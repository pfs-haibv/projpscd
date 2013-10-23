using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Collections;
using DC.Utl;
using DC.Lib;
using System.Data;
using System.Windows.Forms;

namespace DC.Vatwin
{
    class CLS_CKT
    {
        public CLS_CKT()
        { }
        ~CLS_CKT()
        { }
               
        // Hàm xóa dữ liệu cũ trong bảng TB_CKT
        public static int Fnc_xoa_du_lieu_ckt(string p_short_name,
                                                string p_tax_name,
                                                Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_CKT";

                // Hàm lưu số bản ghi đã được xóa
                int _rowsnum = 0;


                _query = @"DELETE FROM tb_vat_con_kt_02
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                _rowsnum = _ora.exeUpdate(_query);

                _query = @"DELETE FROM tb_con_kt
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                _rowsnum = _ora.exeUpdate(_query);


                return _rowsnum;
            }
        }

        // Hàm đọc dữ liệu con khau tru 01/GTGT
        public static int Fnc_doc_file_ckt_01(string p_short_name,
                                          string p_tax_name,
                                          string p_tax_code,
                                          DateTime p_ky_chot,
                                          string p_path,
                                          DirectoryInfo p_dir_source,
                                          Forms.Frm_QLCD p_frm_qlcd
                                         )
        {
            string flages = "YES";
            //using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_CKT_01";

                // Biến lưu số bản ghi đã được bổ sung vào bảng TB_NO
                int _rowsnum = 0;
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                #region Docfile ckt_01/GTGT

                // File 
                string _search_pattern = "ST" + p_ky_chot.ToString("MMyyyy") + ".DBF";
                // Đối tượng lưu trữ các file dữ liệu
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    if (_file.Name.Length != 12)
                        continue;

                    _query = @"SELECT a.madtnt as tin,
                                              max(c.machuong) as machuong,  
                                              max(c.makhoan) as makhoan,                                     
                                              max(a.KyKKhai) as KyKKhai,
                                              max(a.HanNop) as HanNop,                                              
                                              a.MaTM as MaTMuc,
                                              sum(a.KTTHTRUOC + a.sodcqt)*(-1) as SoTien                                              
                                       FROM {0} a 
                                       INNER JOIN
                                            DTNT2.DBF as c
                                            ON a.madtnt = c.madtnt
                                       WHERE  (KTTHTRUOC + sodcqt) < 0 
                                              and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))
                                       GROUP BY a.madtnt, a.MaTM
                                             ";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    //                            int countf = 0;

                    foreach (DataRow _dr in _dt.Rows)
                    {
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

                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = @"INSERT INTO tb_con_kt
                                               (STT,
                                                TIN,
                                                tax_model,
                                                ma_cqt,
                                                ma_tkhai,
                                                ma_tkhai_tms,
                                                short_name,                                                
                                                ma_chuong,
                                                ma_khoan,
                                                ma_tmuc,
                                                KYKK_TU_NGAY,
                                                KYKK_DEN_NGAY,
                                                han_nop,
                                                ngay_htoan,
                                                so_tien,
                                                tkhoan
                                                )
                                        VALUES ({0}, '{1}', '{2}', '{3}', '{4}','{5}','{6}','{7}',
                                                '{8}','{9}','{10}','{11}','{12}','{13}',{14},'{15}')";

                        _query = _query.Replace("{0}", _rowsnum.ToString());
                        _query = _query.Replace("{1}", matin);
                        _query = _query.Replace("{2}", "VAT-APP");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", "01/GTGT");
                        _query = _query.Replace("{5}", "0026");
                        _query = _query.Replace("{6}", p_short_name);
                        _query = _query.Replace("{7}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{8}", _dr["makhoan"].ToString().Trim());
                        _query = _query.Replace("{9}", _dr["MaTMuc"].ToString().Trim());
                        _query = _query.Replace("{10}", _kykk_tu_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{11}", _kykk_den_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{12}", ((DateTime)_dr["HanNop"]).ToString("dd/MM/yyyy").Trim());
                        _query = _query.Replace("{13}", p_ky_chot.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{14}", _dr["SoTien"].ToString().Trim());
                        _query = _query.Replace("{15}", "TKNS");

                        if (_connOra_no.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }

                    _connFoxPro.close();
                    _dt.Clear();
                    _dt = null;

                }
                _listFile.Clear();
                _listFile = null;
                if (flages != "No")
                {
                    // Ghi log
                    _connOra_no.TransStart();
                    _query = null;

                    // Modify by ManhTV3 on 30.05.2012
                    if (_error_message.Length == 0)
                    {
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _connOra_no.TransExecute(_query);
                        _connOra_no.TransCommit();
                    }
                    else
                    {
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                    + v_pck + "', 'N', '" + _error_message + "')";
                        _connOra_no.TransExecute(_query);
                        _connOra_no.TransRollBack();
                    }
                }
                #endregion
                return _rowsnum;
            }
        }

        // Gọi hàm đọc dữ liệu 02/GTGT theo tháng
        public static int Fnc_doc_file_ckt_02(string p_short_name,
                                          string p_tax_name,
                                          string p_tax_code,
                                          DateTime p_ky_chot,
                                          string p_path,
                                          DirectoryInfo p_dir_source,
                                          Forms.Frm_QLCD p_frm_qlcd)
        {
            int _thang = 12 ; //Số tháng tính từ kỳ chốt ngược về trước để lấy dữ liệu số khấu trừ 02/GTGT
            int _rowsnum = 0;
            DateTime _ky;
            for (int j = 0; j <= _thang; j++)
            {
                _ky = p_ky_chot.AddMonths(j * -1);
                // Xử lý cho trường hợp lấy dữ liệu từ trước tháng 8 năm 2011 thì bỏ qua vì cấu trúc file đã khác
                if (_ky < new DateTime(2011, 08, 01))
                    break;
                //Gọi hàm đọc dữ liệu từng tháng
                Fnc_doc_file_ckt_02_ky(p_short_name,
                                    p_tax_name,
                                    p_tax_code,
                                    _ky,
                                    p_ky_chot,
                                    p_path,
                                    p_dir_source,
                                    p_frm_qlcd
                                    );
            }            
            return _rowsnum;
        }

        // Hàm đọc dữ liệu con khau tru 02/GTGT
        public static int Fnc_doc_file_ckt_02_ky(string p_short_name,
                                          string p_tax_name,
                                          string p_tax_code,
                                          DateTime p_ky,
                                          DateTime p_ky_chot,
                                          string p_path,
                                          DirectoryInfo p_dir_source,
                                          Forms.Frm_QLCD p_frm_qlcd
                                         )
        {
            string flages = "YES";
            //using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_CKT_02";
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu số bản ghi đã được bổ sung vào bảng TB_NO
                int _rowsnum = 0;

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                #region Docfile ckt_02/GTGT

                // File 
                string _file_master = "TK" + p_ky.ToString("MMyyyy") + ".DBF";
                string _file_dtl = "DA" + p_ky.ToString("MMyyyy") + ".DBF";
                if ((p_dir_source.GetFiles(_file_master).Count() > 0) && (p_dir_source.GetFiles(_file_dtl).Count() > 0))
                {

                    _query = @"SELECT a.madtnt as tin,
                                              max(c.machuong) as machuong,                                              
                                              a.KyKKhai as KyKKhai,
                                              max(a.HanNop) as HanNop,                                              
                                              a.MaTM as MaTMuc,
                                              sum(b.thuecl) as SoTien                                              
                                       FROM {0} a                                         
                                       INNER JOIN
                                            {1} as b
                                            ON a.madtnt = b.madtnt 
                                               and a.KyKKhai = b.KyKKhai
                                               and a.NgNop = b.NgNop
                                       INNER JOIN
                                            DTNT2.DBF as c
                                            ON a.madtnt = c.madtnt
                                       WHERE  b.thuecl <> 0 and allt(b.ctieutndn)=='033'
                                              and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))
                                       GROUP BY a.madtnt, a.MaTM, a.KyKKhai
                                             ";

                    _query = _query.Replace("{0}", _file_master);
                    _query = _query.Replace("{1}", _file_dtl);
                    _query = _query.Replace("{3}", _File_Nghi);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    //                            int countf = 0;

                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu                            
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length < 6)
                            _ky_kkhai = p_ky.ToString("MMyyyy");

                        //Nếu kỳ kê khai trước tháng 1/2005 thì chuyển thành 1/2005
                        try
                        {
                            if (Int32.Parse(_ky_kkhai.Substring(2, 4)) < 2005)
                                _ky_kkhai = "012005";
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file_master + ");";
                            continue;
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file_master + ");";
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
                            _error_message += e.Message + "(" + _file_master + ");";
                            continue;
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file_master + ");";
                            continue;
                        }
                        #endregion

                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = @"INSERT INTO tb_vat_con_kt_02
                                               (STT,
                                                TIN,
                                                tax_model,
                                                ma_cqt,
                                                ma_tkhai,
                                                ma_tkhai_tms,
                                                short_name,                                                
                                                ma_chuong,
                                                ma_khoan,
                                                ma_tmuc,
                                                KYKK_TU_NGAY,
                                                KYKK_DEN_NGAY,
                                                han_nop,
                                                ngay_htoan,
                                                so_tien,
                                                tkhoan
                                                )
                                        VALUES ({0}, '{1}', '{2}', '{3}', '{4}','{5}','{6}','{7}',
                                                '{8}','{9}','{10}','{11}','{12}','{13}',{14},'{15}')";

                        _query = _query.Replace("{0}", _rowsnum.ToString());
                        _query = _query.Replace("{1}", matin);
                        _query = _query.Replace("{2}", "VAT-APP");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", "02/GTGT");
                        _query = _query.Replace("{5}", "0027");
                        _query = _query.Replace("{6}", p_short_name);
                        _query = _query.Replace("{7}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{8}", "000");
                        _query = _query.Replace("{9}", _dr["MaTMuc"].ToString().Trim());
                        _query = _query.Replace("{10}", _kykk_tu_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{11}", _kykk_den_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{12}", ((DateTime)_dr["HanNop"]).ToString("dd/MM/yyyy").Trim());
                        _query = _query.Replace("{13}", p_ky.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{14}", _dr["SoTien"].ToString().Trim());
                        _query = _query.Replace("{15}", "TKNS");

                        if (_connOra_no.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }

                    _connFoxPro.close();
                    _dt.Clear();
                    _dt = null;
                }

                #endregion
                return _rowsnum;
            }
        }
        public static int Fnc_ghi_du_lieu_ckt_02(string p_short_name)
        {
            // Biến lưu trữ tên của hàm hoặc thủ tục
            //string v_pck = "FNC_GHI_DU_LIEU_DKNTK";

            // Hàm lưu số bản ghi đã được xóa
            int _rowsnum = 0;

            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHUYENDOI_VAT.prc_ghi_ckt_02('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();                
            }

            return _rowsnum;

        }
    }
}

