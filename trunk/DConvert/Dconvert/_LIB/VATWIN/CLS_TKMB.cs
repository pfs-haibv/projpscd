using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DC.Utl;
using DC.Lib;
using System.Collections;
using System.IO;
using System.Data;
using System.Windows.Forms;

namespace DC.Vatwin
{
    class CLS_TKMB
    {
        public CLS_TKMB()
        { }

        ~CLS_TKMB()
        { }
                
        // Hàm xóa dữ liệu tờ khai môn bài cũ trong bảng TB_TKMB
        public static int Fnc_xoa_du_lieu_tkmb(string p_short_name,
                                               string p_tax_name,
                                               Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_TKMB";

                // Hàm lưu số bản ghi đã được xóa
                int _rowsnum_dtl = 0;
                int _rowsnum_nvt = 0;
                int _rowsnum_hdr = 0;

                _query = @"DELETE FROM tb_tkmb_dtl WHERE hdr_id in ( select id from tb_tkmb_hdr
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP')";
                _rowsnum_dtl = _ora.exeUpdate(_query);

                _query = @"DELETE FROM TB_TKMB_HDR
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                _rowsnum_hdr = _ora.exeUpdate(_query);


                return _rowsnum_hdr;
            }
        }
               
        // Đọc dữ liệu TKMB
        public static void Fnc_doc_file_tkmb(string p_short_name,
                                                 string p_tax_name,
                                                 string p_tax_code,
                                                 string p_path,
                                                 DirectoryInfo p_dir_source,
                                                 DateTime p_ky_chot,
                                                 Forms.Frm_QLCD p_frm_qlcd,
                                                 ref int p_rownum,
                                                 ref int p_rownumn)
        {
            using (CLS_DBASE.ORA _connOra_tkmb = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_TKMB";
                string _Nam_TrK = p_ky_chot.Year.ToString().Trim();

                string _TM_1801, _TM_1802, _TM_1803, _TM_1804, _TM_1805, _TM_1806;
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu trữ số bản ghi đã thêm vào bảng TB_TK
                int _rowsnum = 0;
                int _rowsnumn = 0;

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                // Đọc file TKMBYYYY.DBF
                string _search_pattern = "TKMB" + _Nam_TrK + ".DBF";
                // Đối tượng lưu trữ danh sách các file dữ liệu tờ khai môn bài
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu tờ khai môn bài
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    if (_file.Name.Length != 12)
                        continue;

                    _query = @"SELECT a.madtnt as tin,
                                             a.kykkhai,              
                                             a.NgNop as NgNop,                                                       
                                             DToC(a.NgNop) as cNgNop,
                                             dtoc(a.HanNop) as HanNop,
                                             a.kylbo,
                                             sum(a.ThueTKy) as TongThue
                                        FROM {0} a
                                                INNER JOIN
                                             DTNT2.DBF as c
                                                ON a.madtnt = c.madtnt                                                 
                                       WHERE (a.TThTK$'1,3,4' AND 
                                              a.KyLBo <= '{4}' AND
                                              a.ngnop = (sele max(ngnop) from {0} d 
                                                         where a.MaDTNT = d.MaDTNT and a.KyKKhai = d.KyKKhai 
                                                         AND d.TThTK$'1,3,4' and !delete()
                                                         AND d.KyLBo <= '{4}'
                                                         )
                                              and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))	
                                              )
                                       GROUP BY a.madtnt, a.kykkhai, a.NgNop, a.HanNop, a.kylbo";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);
                    _query = _query.Replace("{4}", p_ky_chot.ToString("MM/yyyy"));

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);
                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);

                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Xác định mã đối tượng người nộp thuế
                        string _tin = _dr["tin"].ToString().Trim();
                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        { matin = matin.Insert(10, "-"); }
                        _query = _query.Replace("{4}", matin);
                        #endregion

                        #region Xác định kỳ kê khai
                        string _kykk_tu_ngay = "01/01/" + _dr["kykkhai"].ToString().Trim();
                        string _kykk_den_ngay = "31/12/" + _dr["kykkhai"].ToString().Trim();
                        #endregion

                        #region Xác định kỳ lập bộ
                        string _kylb_tu_ngay = ("01/" + _dr["kylbo"].ToString().Trim());
                        string kylbo = _dr["kylbo"].ToString().Trim();
                        #endregion

                        #region Không lấy dữ liệu có kỳ lập bộ lớn hơn kỳ chốt
                        if (Int32.Parse(kylbo.Substring(0, 2)) > Int32.Parse(p_ky_chot.ToString().Trim().Substring(3, 2)))
                        {
                            continue;
                        }
                        #endregion

                        #region Lấy số ID tự tăng trong CSDL trung gian
                        _query = @"select seq_id_csv.nextval ID from dual";
                        DataTable _dt_ID = _connOra_tkmb.exeQuery(_query);
                        string _ID = _dt_ID.Rows[0]["ID"].ToString().Trim();
                        string _NgNop = ((DateTime)_dr["NgNop"]).ToString("dd/MM/yyyy").Trim();

                        if (Int32.Parse(kylbo.Substring(0, 2)) > Int32.Parse(p_ky_chot.ToString().Trim().Substring(3, 2)))
                        {
                            continue;
                        }
                        #endregion

                        #region Xác định thuế hạch toán vào các TM
                        _TM_1801 = "0";
                        _TM_1802 = "0";
                        _TM_1803 = "0";
                        _TM_1804 = "0";
                        _TM_1805 = "0";
                        _TM_1806 = "0";

                        _query = @"SELECT a.MaTM as MaTM,
                                                a.ThueTKy as SoTien                                              
                                                FROM {0} a                                                                                             
                                                WHERE a.madtnt = '{1}' 
                                                AND a.kykkhai = '{2}'
                                                AND a.NgNop = CToD('{3}') ";

                        _query = _query.Replace("{0}", _file.Name);
                        _query = _query.Replace("{1}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{2}", _dr["kykkhai"].ToString().Trim());
                        _query = _query.Replace("{3}", _dr["cNgNop"].ToString().Trim());

                        DataTable _dt_hachtoan;

                        _dt_hachtoan = _connFoxPro.exeQuery(_query);
                        foreach (DataRow _dr_hachtoan in _dt_hachtoan.Rows)
                        {
                            switch (_dr_hachtoan["MaTM"].ToString().Trim())
                            {
                                case "1801":
                                    _TM_1801 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                                case "1802":
                                    _TM_1802 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                                case "1803":
                                    _TM_1803 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                                case "1804":
                                    _TM_1804 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                                case "1805":
                                    _TM_1805 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                                case "1806":
                                    _TM_1806 = _dr_hachtoan["SoTien"].ToString().Trim();
                                    break;
                            }
                        }

                        #endregion

                        int flag = 0;

                        _query = @"INSERT INTO TB_TKMB_HDR
                                               (short_name,
                                                tin, 
                                                KYTT_TU_NGAY,
                                                KYTT_DEN_NGAY,   
                                                NGAY_HTOAN,
                                                NGAY_NOP_TK,                                                                                                                                         
                                                tax_model,
                                                ma_cqt,                                                
                                                id,                                                                                                
                                                Han_Nop,
                                                TONG_THUE_PN_NNT,
                                                TONG_THUE_PN_CQT,
                                                TM_1801,
                                                TM_1802,
                                                TM_1803,
                                                TM_1804,
                                                TM_1805,
                                                TM_1806
                                                )
                                        VALUES ('{0}', '{1}', '{2}',
                                                '{3}', '{4}', '{5}',
                                                '{6}', '{7}', {8},
                                                '{9}',{10},{11},{12},
                                                {13},{14},{15},{16},{17})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", matin);
                        _query = _query.Replace("{2}", _kykk_tu_ngay);
                        _query = _query.Replace("{3}", _kykk_den_ngay);
                        _query = _query.Replace("{4}", p_ky_chot.ToString("dd/MM/yyyy").Trim());
                        _query = _query.Replace("{5}", _NgNop);
                        _query = _query.Replace("{6}", "VAT-APP");
                        _query = _query.Replace("{7}", p_tax_code);
                        _query = _query.Replace("{8}", _ID);
                        _query = _query.Replace("{9}", _dr["HanNop"].ToString().Trim());
                        _query = _query.Replace("{10}", _dr["TongThue"].ToString().Trim());
                        _query = _query.Replace("{11}", _dr["TongThue"].ToString().Trim());
                        _query = _query.Replace("{12}", _TM_1801);
                        _query = _query.Replace("{13}", _TM_1802);
                        _query = _query.Replace("{14}", _TM_1803);
                        _query = _query.Replace("{15}", _TM_1804);
                        _query = _query.Replace("{16}", _TM_1805);
                        _query = _query.Replace("{17}", _TM_1806);


                        if (_connOra_tkmb.exeUpdate(_query) != 0)
                            _rowsnum++;

                        string _File_DTL = "MBCT" + _Nam_TrK + ".DBF";

                        // Đối tượng lưu trữ thông tin chi tiết tờ khai 10/KK-TNCN
                        DataTable _dt_details;

                        #region Cập nhật chỉ tiêu tờ khai môn bài

                        _query = @"SELECT b.madtnt, b.STT as STT, b.BacMB as BacMB_NNT, b.BacMB2 as BacMB_CQT, 
                                             allt(str(b.VonDK, 20, 0)) as VonDK_NNT, allt(str(b.VonDK2, 20, 0)) as VonDK_CQT,
                                             allt(str(b.ThuePN, 20, 0)) as ThuePN_NNT, allt(str(b.ThuePN2, 20, 0)) as ThuePN_CQT
                                             FROM {0} b
                                             WHERE b.madtnt = '{1}' And b.ngnop = ctod('{2}') AND !Empty(b.MaTM) ";

                        _query = _query.Replace("{0}", _File_DTL);
                        _query = _query.Replace("{1}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{2}", _dr["cNgNop"].ToString().Trim());


                        _dt_details = _connFoxPro.exeQuery(_query);
                        foreach (DataRow _dr_details in _dt_details.Rows)
                        {
                            string _Chi_Tieu = "";
                            if (_dr_details["STT"].ToString().Trim() == "2")
                                _Chi_Tieu = "2";
                            if (_dr_details["STT"].ToString().Trim() == "3")
                                _Chi_Tieu = "3";

                            // Bac mon bai NNT
                            string _BacMB_NNT = _dr_details["BacMB_NNT"].ToString().Trim();
                            // Bac mon bai CQT
                            string _BacMB_CQT = _dr_details["BacMB_CQT"].ToString().Trim();
                            //VonDK NNT
                            string _VonDK_NNT = _dr_details["VonDK_NNT"].ToString().Trim();
                            //VonDK CQT
                            string _VonDK_CQT = _dr_details["VonDK_CQT"].ToString().Trim();
                            //ThuePN NNT
                            string _ThuePN_NNT = _dr_details["ThuePN_NNT"].ToString().Trim();
                            //ThuePN NNT
                            string _ThuePN_CQT = _dr_details["ThuePN_CQT"].ToString().Trim();

                            if (_Chi_Tieu == "2")
                            {
                                _query = @"UPDATE TB_TKMB_HDR 
                                                           SET BMB_NNT = '{0}',
                                                               Von_DKy_NNT = {1},
                                                               Thue_PN_NNT = {2},
                                                               BMB_CQT = '{3}',
                                                               Von_DKy_CQT = {4},
                                                               Thue_PN_CQT = {5}
                                                           Where ID = {6} ";
                                _query = _query.Replace("{0}", _BacMB_NNT);
                                _query = _query.Replace("{1}", _VonDK_NNT);
                                _query = _query.Replace("{2}", _ThuePN_NNT);
                                _query = _query.Replace("{3}", _BacMB_CQT);
                                _query = _query.Replace("{4}", _VonDK_CQT);
                                _query = _query.Replace("{5}", _ThuePN_CQT);
                                _query = _query.Replace("{6}", _ID.ToString());

                                _connOra_tkmb.exeUpdate(_query);
                            }

                            if (_Chi_Tieu == "3")
                            {
                                _query = @"INSERT INTO TB_TKMB_DTL
                                                               (id,                                                                                                
                                                                HDR_ID,                                                
                                                                BMB_NNT,
                                                                Von_DKy_NNT,
                                                                Thue_PN_NNT,
                                                                BMB_CQT,
                                                                Von_DKy_CQT,
                                                                Thue_PN_CQT
                                                                )
                                                            VALUES ({0}, {1}, '{2}',
                                                                {3}, {4}, '{5}',
                                                                {6}, {7})";

                                _query = _query.Replace("{0}", "seq_id_csv.nextval");
                                _query = _query.Replace("{1}", _ID.ToString());
                                _query = _query.Replace("{2}", _BacMB_NNT);
                                _query = _query.Replace("{3}", _VonDK_NNT);
                                _query = _query.Replace("{4}", _ThuePN_NNT);
                                _query = _query.Replace("{5}", _BacMB_CQT);
                                _query = _query.Replace("{6}", _VonDK_CQT);
                                _query = _query.Replace("{7}", _ThuePN_CQT);

                                _connOra_tkmb.exeUpdate(_query);
                            }
                        }
                        // Xóa nội dung chi tiết tờ khai
                        _dt_details.Clear();

                        #endregion

                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();

                }
                _listFile.Clear();
                _listFile = null;

                //Ghi log
                _connOra_tkmb.TransStart();
                _query = null;


                //   return _rowsnum;
                p_rownum = _rowsnum;
                p_rownumn = _rowsnumn;
            }
        }
        public static void Fnc_cap_nhat_bmb()
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MAP_TMS.Prc_Update_bac_mbai()";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
      

    }
}
