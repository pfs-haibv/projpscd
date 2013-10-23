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
    class CLS_CCTT
    {
        public CLS_CCTT()
        { }

        ~CLS_CCTT()
        { }

        // Hàm xóa dữ liệu tờ khai môn bài cũ trong bảng TB_TKMB
        public static int Fnc_xoa_du_lieu_cctt(string p_short_name,
                                               string p_tax_name,
                                               Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_CCTT";

                // Hàm lưu số bản ghi đã được xóa
                int _rowsnum_dtl = 0;                
                int _rowsnum_hdr = 0;

               
                    _query = @"DELETE FROM tb_cctt
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                    _rowsnum_hdr = _ora.exeUpdate(_query);
                 
               
                return _rowsnum_hdr;
            }
        }

        public static void Fnc_doc_file_cctt(string p_short_name,
                                                 string p_tax_name,
                                                 string p_tax_code,
                                                 string p_path,
                                                 DirectoryInfo p_dir_source,
                                                 DateTime p_ky_chot,
                                                 Forms.Frm_QLCD p_frm_qlcd
                                                 )
        {
            using (CLS_DBASE.ORA _connOra_tkmb = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_CCTT";

                int _rowsnum = 0;
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                string _search_pattern = "TK" + p_ky_chot.ToString("MMyyyy") + ".DBF";
                // Đối tượng lưu trữ danh sách các file dữ liệu tờ khai môn bài
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu tờ khai môn bài
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    if (_file.Name.Length != 12)
                        continue;

                    _query = @"SELECT   a.madtnt as tin,
                                                a.kykkhai,                                                                     
                                                max(a.NgNop) as NgNop,
                                                max(a.HanNop) as HanNop,
                                                a.kylbo, 
                                                a.MaTM as MaTM,
                                                sum(a.thuecl) as so_tien
                                        FROM {0} a                                                                                          
                                             INNER JOIN
                                             DTNT2.DBF as c
                                                ON a.madtnt = c.madtnt                                              
                                       WHERE a.TThTK$'1' AND left(allt(a.MaTKHAI),1) = '4'
                                             and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))
                                       GROUP BY a.madtnt, a.kykkhai, a.kylbo, a.MaTM";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);

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

                        #region Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu                            
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length < 6)
                            _ky_kkhai = p_ky_chot.ToString("MMyyyy");

                        //Nếu kỳ kê khai trước tháng 1/2005 thì chuyển thành 1/2005
                        try
                        {
                            if (Int32.Parse(_ky_kkhai.Substring(2, 4)) < 2005)
                                _ky_kkhai = "012005";
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file.Name + ");";
                            continue;
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file.Name + ");";
                            continue;
                        }

                        // Ngày bắt đầu kỳ phát sinh
                        DateTime _kykk_tu_ngay;
                        // Ngày kết thúc kỳ phát sinh
                        DateTime _kykk_den_ngay;
                        try
                        {
                            _kykk_tu_ngay = new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _kykk_den_ngay =
                                new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _kykk_den_ngay = _kykk_den_ngay.AddMonths(1).AddDays(-1);
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file.Name + ");";
                            continue;
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file.Name + ");";
                            continue;
                        }
                        #endregion

                        #region Lấy số ID tự tăng trong CSDL trung gian
                        _query = @"select seq_id_csv.nextval ID from dual";
                        DataTable _dt_ID = _connOra_tkmb.exeQuery(_query);
                        string _ID = _dt_ID.Rows[0]["ID"].ToString().Trim();
                        #endregion

                        string _NgNop = ((DateTime)_dr["NgNop"]).ToString("dd/MM/yyyy").Trim();
                        string _HanNop = ((DateTime)_dr["HanNop"]).ToString("dd/MM/yyyy").Trim();
                        string _MaTM = _dr["MaTM"].ToString().Trim();

                        _query = @"INSERT INTO tb_cctt
                                               (short_name,
                                                tin, 
                                                KYTT_TU_NGAY,
                                                KYTT_DEN_NGAY,   
                                                NGAY_HTOAN,
                                                NGAY_NOP_TK,                                                                                                                                         
                                                tax_model,
                                                ma_cqt,                                                
                                                id,                                                                                                
                                                Han_Nop                                          
                                                )
                                        VALUES ('{0}', '{1}', '{2}',
                                                '{3}', '{4}', '{5}',
                                                '{6}', '{7}', {8},
                                                '{9}')";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", matin);
                        _query = _query.Replace("{2}", _kykk_tu_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{3}", _kykk_den_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{4}", p_ky_chot.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{5}", _NgNop);
                        _query = _query.Replace("{6}", "VAT-APP");
                        _query = _query.Replace("{7}", p_tax_code);
                        _query = _query.Replace("{8}", _ID);
                        _query = _query.Replace("{9}", _HanNop);

                        if (_connOra_tkmb.exeUpdate(_query) != 0)
                            _rowsnum++;

                        string _File_DTL = "KH" + p_ky_chot.ToString("MMyyyy") + ".DBF";

                        if (p_dir_source.GetFiles(_File_DTL).Count() > 0)
                        {
                            DataTable _dt_details;

                            #region Cập nhật chỉ tiêu tờ khai khoan

                            _query = @"SELECT b.madtnt,
                                                allt(str(sum(b.DSo), 20, 0)) as Doanh_Thu,
                                                allt(str(sum(b.GTTT), 20, 0)) as GTTT,
                                                allt(str(sum(b.ThueSuat), 2, 0)) as ThueSuat,
                                                allt(str(sum(b.Thue), 20, 0)) as Thue_GTGT
                                             FROM {0} b
                                             WHERE b.madtnt = '" + _tin +
                                     "' AND b.MaTM = '" + _MaTM +
                                     "' GROUP BY b.madtnt, b.MaTM";

                            _query = _query.Replace("{0}", _File_DTL);


                            _dt_details = _connFoxPro.exeQuery(_query);

                            foreach (DataRow _dr_details in _dt_details.Rows)
                            {

                                string _thue_suat = _dr_details["ThueSuat"].ToString().Trim();
                                if (_thue_suat == "5")
                                {
                                    _query = @"UPDATE tb_cctt a
                                                        SET a.doanh_thu_ts_5 = {0},
                                                        a.gtgt_chiu_thue_ts_5 = {1},
                                                        a.thue_gtgt_ts_5 = {2}
                                                        WHERE a.ID = {3}"
                                        ;
                                }
                                else
                                {
                                    _query = @"UPDATE tb_cctt a
                                                        SET a.doanh_thu_ts_10 = {0},
                                                        a.gtgt_chiu_thue_ts_10 = {1},
                                                        a.thue_gtgt_ts_10 = {2}
                                                        WHERE a.ID = {3}"
                                        ;
                                }

                                _query = _query.Replace("{0}", _dr_details["doanh_thu"].ToString().Trim());
                                _query = _query.Replace("{1}", _dr_details["GTTT"].ToString().Trim());
                                _query = _query.Replace("{2}", _dr_details["Thue_GTGT"].ToString().Trim());
                                _query = _query.Replace("{3}", _ID);
                                _connOra_tkmb.exeUpdate(_query);
                            }
                            // Xóa nội dung chi tiết tờ khai
                            _dt_details.Clear();

                            #endregion
                        }


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


            }
        }
        public static void Fnc_Cap_nhat_01TKH(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_ULT.Prc_sync_01_thkh('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
    }
}
