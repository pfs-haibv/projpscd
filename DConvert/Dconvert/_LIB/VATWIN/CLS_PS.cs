using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DC.Utl;
using DC.Lib;
using System.IO;
using System.Collections;
using System.Data;
using System.Windows.Forms;

namespace DC.Vatwin
{
    class CLS_PS
    {
        public CLS_PS()
        { }
        ~CLS_PS()
        { }

        // Hàm xóa dữ liệu phát sinh cũ trong bảng TB_PS
        public static int Fnc_xoa_du_lieu_ps_cu(string p_short_name, string p_tax_name, Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_PS";

                // Biến lưu số bản ghi đã được xóa
                int _rowsnum = 0;


                _query = @"DELETE FROM tb_ps
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                _rowsnum = _ora.exeUpdate(_query);

                // Ghi log
                _ora.TransStart();
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
                return _rowsnum;
            }
        }

        #region Đọc dữ liệu

        // Hàm đọc dữ liệu phát sinh tháng
        public static int Fnc_doc_file_ps_thang(string p_short_name,
                                                string p_tax_name,
                                                string p_tax_code,
                                                DateTime p_ky_chot,
                                                DateTime p_ky_ps_tu,
                                                DateTime p_ky_ps_den,
                                                string _path,
                                                DirectoryInfo p_dir_source,
                                                Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _connOra = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                DateTime _ky_ps_tu = p_ky_ps_tu;
                DateTime _ky_ps_den = p_ky_ps_den;

                string _query = "";

                // Biến lưu trữ tên hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_PS_THANG";
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu số bản ghi dữ liệu đã đọc
                int _rowsnum = 0;

                // Đọc file TZMMYYYY.DBF
                string _search_pattern = "TK*.DBF";
                                                
                // Đối tượng lưu trữ danh sách các file dữ liệu phát sinh tháng
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu phát sinh tháng
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));
                #region Doc file
                foreach (FileInfo _file in _listFile)
                {
                    if (_file.Name.Length != 12)
                        continue;
                    int ky;
                    int nam;
                    try
                    {
                        ky = int.Parse(_file.Name.ToString().Trim().Substring(2, 2));
                        nam = int.Parse(_file.Name.ToString().Trim().Substring(4, 4));
                    }
                    catch (FormatException e)
                    {
                        ky = 1;
                        nam = 1;
                    }

                    DateTime _d_file = new DateTime(nam, ky, 1);
                    if ((_d_file < _ky_ps_tu) || (_d_file < new DateTime(2011, 08, 01)))
                        continue;

                    _query = @"SELECT a.madtnt as tin, a.matkhai as ma_tkhai,                                         
                                         a.ngnop as ngay_nop, a.matm as ma_tmuc, 
                                         a.hannop as han_nop, thuecl as so_tien,                                          
                                         a.KyKKhai, 
                                         b.mabpql, b.macaptren, b.MaChuong
                                    FROM {0} a,DTNT2.DBF b 
                                   WHERE a.madtnt = b.madtnt                                      
                                         AND a.MaTKhai IN ('01/TAIN',
                                                       '01/BVMT',
                                                       '01/PHLP',
                                                       '01/KHAC')                                      
                                         AND thuecl <> 0
                                         and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);

                    foreach (DataRow _dr in _dt.Rows)
                    {
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "");
                        #region Xác định kỳ phát sinh của đối tượng nộp thuế
                        DateTime _ky_psinh_tu;
                        DateTime _ky_psinh_den;

                        
                            _ky_psinh_tu =
                                new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den =
                                new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = _ky_psinh_den.AddMonths(1).AddDays(-1);
                    

                        // Kiểm tra kỳ phát sinh nằm trong kỳ chốt dữ liệu
                        if (_ky_psinh_tu.CompareTo(_ky_psinh_tu) < 0 || _ky_psinh_tu.CompareTo(_ky_psinh_den) > 0
                          || _ky_psinh_den.CompareTo(_ky_psinh_tu) < 0 || _ky_psinh_den.CompareTo(_ky_psinh_den) > 0)
                            continue;
                        #endregion

                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = @"INSERT INTO tb_ps
                                               (short_name, stt, loai, ma_cqt, tin,
                                                ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                                tkhoan, kykk_tu_ngay, kykk_den_ngay,
                                                so_tien, han_nop, ngay_htoan, 
                                                tax_model, status, id, ma_cbo, ma_pban)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', {12}, '{13}', '{14}', 
                                                '{15}', '{16}', {17}, '{18}' , '{19}')";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", (_rowsnum + 1).ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", matin);
                        _query = _query.Replace("{5}", _dr["ma_tkhai"].ToString().Trim());
                        _query = _query.Replace("{6}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_psinh_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", p_ky_chot.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", "VAT-APP");
                        _query = _query.Replace("{16}", "");
                        _query = _query.Replace("{17}", "seq_id_csv.nextval");
                        _query = _query.Replace("{18}", _dr["mabpql"].ToString().Trim());
                        _query = _query.Replace("{19}", _dr["macaptren"].ToString().Trim());
                        if (_connOra.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();                   
                }
                _listFile.Clear();
                _listFile = null;
                #endregion
                return _rowsnum;
            }
        }

        // Hàm đọc dữ liệu phát sinh quý
        public static int Fnc_doc_file_ps_quy(string p_short_name,
                                            string p_tax_name,
                                            string p_tax_code,
                                            DateTime p_ky_chot,
                                            DateTime p_ky_ps_tu,
                                            DateTime p_ky_ps_den,
                                            string p_path,
                                            DirectoryInfo p_dir_source,
                                            Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _connOra_cntk = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                DateTime _ky_ps_tu = p_ky_ps_tu;
                DateTime _ky_ps_den = p_ky_ps_den;

                string _query = "";

                //Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_PS_QUY";

                // Biến lưu số bản ghi dữ liệu phát sinh tháng                    
                int _rowsnum = 0;
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Đọc file TKDNYYYY.DBF
                string _search_pattern = "TKDN*.DBF";

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                // Đối tượng lưu danh sách các file dữ liệu phát sinh quý
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu phát sinh quý
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    if (_file.Name.Length != 12)
                        continue;

                    _query = @"SELECT a.madtnt as tin,
                                          a.matkhai as ma_tkhai,
                                          a.matm as ma_tmuc,
                                          a.ngnop as ngay_nop,
                                          a.hannop as han_nop,
                                          a.thuecl as so_tien,
                                          a.qui as KyKkhai,
                                          a.KyLbo,
                                          b.mabpql, b.macaptren, b.machuong
                                       FROM {0} a, DTNT2.DBF b
                                       WHERE a.matkhai IN ('01A/TNDN', '01B/TNDN')                                        
                                       AND a.thuecl <> 0		                                       
                                       AND a.madtnt = b.madtnt
                                       and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))";

                    _query = _query.Replace("{0}", _file.Name.ToString());
                    _query = _query.Replace("{3}", _File_Nghi);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    DataTable _dt = _connFoxPro.exeQuery(_query);

                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ lập bộ
                        string _temp = "";
                        _temp = _dr["kylbo"].ToString().Trim();
                        _temp = _temp.Replace("/", "");
                    
                            // Kỳ lập bộ
                            DateTime _kylbo =
                                new DateTime(Int32.Parse(_temp.Substring(2, 4)), // Năm
                                             Int32.Parse(_temp.Substring(0, 2)), // Tháng
                                             1);                                 // Ngày

                            if (_kylbo.CompareTo(_ky_ps_den) > 0
                                || _kylbo.CompareTo(_ky_ps_tu) < 0)
                                continue;
                       
                        #endregion

                        string _ky_kkhai = _dr["KyKKhai"].ToString().Trim().Replace("/", "");
                        string _ma_tkhai = _dr["ma_tkhai"].ToString().Trim();
                        string _ma_tmuc = _dr["ma_tmuc"].ToString().Trim();

                        #region Xác định kỳ phát sinh
                        int _quy_ky_kkhai = 1; // Biến lưu trữ quý của kỳ kê khai
                        int _nam_ky_kkhai = 2010; // Biến lưu trữ năm của kỳ kê khai
                       
                            _quy_ky_kkhai = Int32.Parse(_ky_kkhai.Trim().Substring(0, 1));
                            _nam_ky_kkhai = Int32.Parse(_ky_kkhai.Trim().Substring(1, 4));
                        

                        DateTime _ky_kk_tu; // Ngày bắt đầu kỳ kk
                        DateTime _ky_kk_den; // Ngày kết thúc kỳ kk

                        if (_quy_ky_kkhai == 1)
                        {
                            _ky_kk_tu = new DateTime(_nam_ky_kkhai, 1, 1);
                            _ky_kk_den = new DateTime(_nam_ky_kkhai, 3, 31);
                        }
                        else if (_quy_ky_kkhai == 2)
                        {
                            _ky_kk_tu = new DateTime(_nam_ky_kkhai, 4, 1);
                            _ky_kk_den = new DateTime(_nam_ky_kkhai, 6, 30);
                        }
                        else if (_quy_ky_kkhai == 3)
                        {
                            _ky_kk_tu = new DateTime(_nam_ky_kkhai, 7, 1);
                            _ky_kk_den = new DateTime(_nam_ky_kkhai, 9, 30);
                        }
                        else if (_quy_ky_kkhai == 4)
                        {
                            _ky_kk_tu = new DateTime(_nam_ky_kkhai, 10, 1);
                            _ky_kk_den = new DateTime(_nam_ky_kkhai, 12, 31);
                        }
                        else
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name
                                    + "/ " + v_pck + ": "
                                    + new InvalidDataException("Tháng của kỳ phát sinh không hợp lệ").Message);
                            continue;
                        }

                        if (_ky_kk_tu.CompareTo(_ky_ps_tu) < 0
                            || _ky_kk_den.CompareTo(_ky_ps_den) > 0)
                            continue;
                        #endregion

                        _query = @"INSERT INTO tb_ps
                                               (short_name, stt, loai, ma_cqt, tin,
                                                ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                                tkhoan, kykk_tu_ngay, kykk_den_ngay,
                                                so_tien, han_nop, ngay_htoan, 
                                                tax_model, status, id, ma_cbo, ma_pban)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', {12}, '{13}', '{14}', 
                                                '{15}', '{16}', {17}, '{18}', '{19}')";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", (_rowsnum + 1).ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);

                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = _query.Replace("{4}", matin);
                        _query = _query.Replace("{5}", _ma_tkhai);
                        _query = _query.Replace("{6}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _ma_tmuc);
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_kk_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_kk_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").Trim());
                        _query = _query.Replace("{14}", p_ky_chot.ToString("dd/MM/yyyy").Trim());
                        _query = _query.Replace("{15}", "VAT-APP");
                        _query = _query.Replace("{16}", "");
                        _query = _query.Replace("{17}", "seq_id_csv.nextval");
                        _query = _query.Replace("{18}", _dr["mabpql"].ToString().Trim());
                        _query = _query.Replace("{19}", _dr["macaptren"].ToString().Trim());

                        if (_connOra_cntk.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();

                }
                _listFile.Clear();
                _listFile = null;

                // Ghi log
                _connOra_cntk.TransStart();
                _query = null;

                return _rowsnum;
            }
        }

        // Dữ liệu quyết định ấn định, bãi bỏ quyết định
        public static int Fnc_doc_file_qdad(string p_short_name,
                                            string p_tax_name,
                                            string p_tax_code,
                                            DateTime p_ky_chot,
                                            DateTime p_ky_ps_tu,
                                            DateTime p_ky_ps_den,
                                            string p_path,
                                            DirectoryInfo p_dir_source,
                                            Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _connOra_qdad = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                DateTime _ky_ps_tu = p_ky_ps_tu;
                DateTime _ky_ps_den = p_ky_ps_den;

                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_QDAD";
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu trữ số bản ghi
                int _rowsnum = 0;

                // Đọc file QDADYYYY.DBF
                string _search_pattern = "QDAD*.DBF";

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";


                // Đối tượng lưu trữ danh sách file dữ liệu quyết định ấn định, bãi bỏ quyết định
                ArrayList _listFile_qdad = new ArrayList();
                // Lấy danh sách các file dữ liệu quyết định ấn định, bãi bỏ quyết định
                _listFile_qdad.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile_qdad)
                {

                    _query = @"SELECT a.madtnt,
                                         a.matkhai as ma_tkhai,
                                         a.matm as ma_tmuc,
                                         a.kylbo,a.kykkhai,
                                         iif(Subs(DToC(a.NgayQD), 4, 7) == a.KyLBo, 
                                         a.NgayQD, 
                                         ('01/'+a.KyLBo)) as ngay_nop,
                                         a.hannop as han_nop,
                                         iif(a.Loai=1,a.thuecl,-1*a.thuecl) as so_tien ,
                                         b.mabpql, b.macaptren, b.machuong   
                                    FROM {0} a ,dtnt2 b
                                   WHERE a.maad IN ('02','03') 
                                     AND a.thuecl > 0 
                                     AND a.matkhai IN ('01/TAIN',
                                                       '01/BVMT',
                                                       '01/PHLP',
                                                       '01/KHAC',
                                                       '01A/TNDN',
                                                       '01B/TNDN')
                                     AND a.madtnt = b.madtnt
                                     and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))
                                  ";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Đối tượng lưu trữ các bản ghi
                    DataTable _dt = _connFoxPro.exeQuery(_query);

                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ phát sinh và kỳ lập bộ nằm trong kỳ chốt dữ liệu

                        // Biến lưu trữ mã tờ khai
                        string _ma_tkhai = _dr["ma_tkhai"].ToString().Trim();
                        // Biến lưu trữ kỳ lập bộ
                        string _kylbo = _dr["kylbo"].ToString().Replace("/", "").Trim();
                        // Biến lưu trữ kỳ kê khai
                        string _kykkhai = _dr["kykkhai"].ToString().Replace("/", "").Trim();

                        // Kỳ lập bộ
                        DateTime _ky_lbo;
                        DateTime _ky_psinh_tu; // Ngày bắt đầu kỳ phát sinh
                        DateTime _ky_psinh_den; // Ngày kết thúc kỳ phát sinh

                        // Xác định kỳ lập bộ
                      
                            _ky_lbo = new DateTime(Int32.Parse(_kylbo.Substring(2, 4)), // Năm
                                                   Int32.Parse(_kylbo.Substring(0, 2)), // Tháng
                                                   1);                                  // Ngày
                       

                        // Tờ khai tháng
                        if (_ma_tkhai.Equals("01/TAIN")
                            || _ma_tkhai.Equals("01/BVMT")
                            || _ma_tkhai.Equals("01/KHAC"))
                        {
                            
                                _ky_psinh_tu =
                                    new DateTime(Int32.Parse(_kykkhai.Substring(2, 4)), // Năm
                                                 Int32.Parse(_kykkhai.Substring(0, 2)), // Tháng
                                                 1);                                    // Ngày
                                // Ngày kết thúc kỳ phát sinh
                                _ky_psinh_den =
                                    new DateTime(Int32.Parse(_kykkhai.Substring(2, 4)), // Năm
                                                 Int32.Parse(_kykkhai.Substring(0, 2)), // Tháng
                                                 1);                                    // Ngày
                                _ky_psinh_den = _ky_psinh_den.AddMonths(1).AddDays(-1);
                          
                        }

                        // Tờ khai quý
                        else
                        {
                            int _quy_ky_kkhai = 1; // Biến lưu trữ quý của kỳ kê khai
                            int _nam_ky_kkhai = 2010; // Biến lưu trữ năm của kỳ kê khai
                           
                                _quy_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(0, 1));
                                _nam_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(1, 4));
                          
                            if (_quy_ky_kkhai == 1)
                            {
                                _ky_psinh_tu = new DateTime(_nam_ky_kkhai, 1, 1);
                                _ky_psinh_den = new DateTime(_nam_ky_kkhai, 3, 31);

                            }
                            else if (_quy_ky_kkhai == 2)
                            {
                                _ky_psinh_tu = new DateTime(_nam_ky_kkhai, 4, 1);
                                _ky_psinh_den = new DateTime(_nam_ky_kkhai, 6, 30);
                            }
                            else if (_quy_ky_kkhai == 3)
                            {
                                _ky_psinh_tu = new DateTime(_nam_ky_kkhai, 7, 1);
                                _ky_psinh_den = new DateTime(_nam_ky_kkhai, 9, 30);
                            }
                            else if (_quy_ky_kkhai == 4)
                            {
                                _ky_psinh_tu = new DateTime(_nam_ky_kkhai, 10, 1);
                                _ky_psinh_den = new DateTime(_nam_ky_kkhai, 12, 31);
                            }
                            else
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name
                                    + "/ " + v_pck + ": "
                                    + new InvalidDataException("Tháng của kỳ phát sinh không hợp lệ").Message);
                                _error_message += "Tháng của kỳ phát sinh không hợp lệ(" + _file.Name + ");";
                                continue;
                            }
                        }

                        if (_ky_lbo.CompareTo(_ky_ps_den) > 0
                            || _ky_lbo.CompareTo(_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(_ky_ps_den) > 0)

                            continue;

                        #endregion

                        _query = @"INSERT INTO tb_ps
                                           (short_name, stt, loai, ma_cqt, tin,
                                            ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                            tkhoan, kykk_tu_ngay, kykk_den_ngay,
                                            so_tien, han_nop, ngay_htoan,
                                            tax_model, status, id)
                                    VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                            '{5}', '{6}', '{7}', '{8}', '{9}',
                                            '{10}', '{11}', '{12}', '{13}', '{14}', 
                                            '{15}', '{16}', {17})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", (_rowsnum + 1).ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);

                        string matin = _dr["madtnt"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = _query.Replace("{4}", matin);
                        _query = _query.Replace("{5}", _ma_tkhai);
                        _query = _query.Replace("{6}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_psinh_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", "VAT-APP");
                        _query = _query.Replace("{16}", "");
                        _query = _query.Replace("{17}", "seq_id_csv.nextval");

                        if (_connOra_qdad.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                _listFile_qdad.Clear();
                _listFile_qdad = null;

                // Ghi log
                _connOra_qdad.TransStart();
                _query = null;
                
                return _rowsnum;
            }
        }
        #endregion
    }
}
