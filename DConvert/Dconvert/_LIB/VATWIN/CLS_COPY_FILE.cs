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
using System.Data.OracleClient;

namespace DC.Vatwin
{
    class CLS_COPY_FILE
    {
        public CLS_COPY_FILE()
        { }
        ~CLS_COPY_FILE()
        { }

        // Hàm copy file danh bạ người nộp thuế
        public static int Fnc_copy_file_dtnt(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name,
                                       string p_short_name,
                                       Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DTNT";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;
                string _path_file = "\\DTNT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    ArrayList _listFile_dtnt = new ArrayList();
                    // Lấy file DTNT2.DBF
                    string _search_pattern = "DTNT2.DBF";
                    _listFile_dtnt.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_dtnt)
                    {
                        try
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_dtnt.Clear();
                    _listFile_dtnt = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }
                return _so_file;
            }
        }

        // Hàm copy file ĐTNT nghỉ
        public static int Fnc_copy_file_nghi(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       DateTime p_ky_chot,
                                       string p_tax_name,
                                       string p_short_name,
                                       Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_NGHI";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;
                string _path_file = "\\SOTHUE";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    ArrayList _listFile_dtnt = new ArrayList();
                    // Lấy file DTNT2.DBF
                    string _search_pattern = "NGHI" + p_ky_chot.AddMonths(1).ToString("yyyy") + ".DBF";
                    _listFile_dtnt.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_dtnt)
                    {
                        try
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_dtnt.Clear();
                    _listFile_dtnt = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }
                return _so_file;
            }
        }

        // Hàm copy file danh mục bộ phận quản lý
        public static int Fnc_copy_file_dmbpql(string p_path_source,
                                               DirectoryInfo p_dir_destination,
                                               string p_tax_name,
                                               string p_short_name,
                                               Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DMBPQL";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\DTNT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                ArrayList _listFile_dlt = new ArrayList();

                _ora.TransStart();

                try
                {
                    // Lấy file DMBPQL.DBF
                    string _search_pattern = "DMBPQL.DBF";
                    _listFile_dlt.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_dlt)
                    {
                        try
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_dlt.Clear();
                    _listFile_dlt = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // File sổ thuế hàng tháng chứa số khấu trừ chuyển kỳ sau 01 GTGT
        public static int Fnc_copy_file_st(string p_path_source,
                                    DirectoryInfo p_dir_destination,
                                    DateTime p_ky_chot,
                                    string p_tax_name,
                                    string p_short_name,
                                    Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_ST";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\SOTHUE";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    string _search_pattern = "ST" + p_ky_chot.ToString("MMyyyy") + ".DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        try
                        {
                            //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
                            /*                            if (_file.Name.Length == 10)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
                            if (_file.Name.Length == 12)
                            {
                                _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                _so_file++;
                            }

                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // File dữ liệu master của các tờ khai tháng
        public static int Fnc_copy_file_tk(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_chot,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_TK";

                int _nam = 2; //lay du lieu cho nam chuyen doi va nam truoc

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    for (int i = 0; i < _nam; i++)
                    {
                        string _search_pattern = "TK*" + p_ky_chot.AddYears(i * -1).ToString("yyyy") + ".DBF";
                        ArrayList _listFile = new ArrayList();
                        _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                        foreach (FileInfo _file in _listFile)
                        {
                            try
                            {
                                if (_file.Name.Length == 12)
                                {
                                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                    _so_file++;
                                }

                            }
                            catch (FormatException e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                            catch (IOException e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                            catch (Exception e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                        }
                        _listFile.Clear();
                        _listFile = null;
                    }

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Hàm copy file detail CCTT hộ khoán
        public static int Fnc_copy_file_kh(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       DateTime p_ky_chot,
                                       string p_tax_name,
                                       string p_short_name,
                                       Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_KH";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file CNTK
                    string _search_pattern = "KH" + p_ky_chot.ToString("MMyyyy") + ".DBF";

                    // Danh sách các file
                    ArrayList _listFile_tkmb = new ArrayList();
                    _listFile_tkmb.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_tkmb)
                    {
                        try
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name), true);
                            _so_file++;
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_tkmb.Clear();
                    _listFile_tkmb = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }

        }

        // Hàm copy file detail tờ khai 02/GTGT (GTGT dự án đầu tư
        public static int Fnc_copy_file_DA(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_chot,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DA";

                int _thang = 6; //Số tháng tính từ kỳ chốt ngược về trước để copy file TK theo từng tháng

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    for (int i = 0; i <= _thang; i++)
                    {
                        string _search_pattern = "DA" + p_ky_chot.AddYears(i * -1).ToString("MMyyyy") + ".DBF";
                        ArrayList _listFile = new ArrayList();
                        _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                        foreach (FileInfo _file in _listFile)
                        {
                            try
                            {
                                if (_file.Name.Length == 12)
                                {
                                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                    _so_file++;
                                }

                            }
                            catch (FormatException e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                            catch (IOException e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                            catch (Exception e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                            }
                        }
                        _listFile.Clear();
                        _listFile = null;
                    }

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Copy file dữ liệu đăng ký nộp tờ khai
        public static int Fnc_copy_file_dkntk(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_chot,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DKNTK";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\DTNT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file NOYYYY.DBF 
                    //Doi lay file NOCYYYY.DBF
                    //                    string _search_pattern = "NO*.DBF";
                    string _search_pattern = "DTNT_LT2.DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        try
                        {
                            //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
                            /*                            if (_file.Name.Length == 10)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
                            if (_file.Name.Length == 12)
                            {
                                _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                _so_file++;
                            }

                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Copy file danh mục các tờ khai con hiệu lực 
        public static int Fnc_copy_file_dmtokhai(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DMTOKHAI";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file NOYYYY.DBF 
                    //Doi lay file NOCYYYY.DBF
                    //                    string _search_pattern = "NO*.DBF";
                    string _search_pattern = "DMTOKHAI.DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        try
                        {
                            //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
                            /*                            if (_file.Name.Length == 10)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
                            if (_file.Name.Length == 12)
                            {
                                _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                _so_file++;
                            }

                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Copy file dữ liệu nợ NOYYYY.DBF
        public static int Fnc_copy_file_no(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_chot,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_NO";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\SOTHUE";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file NOYYYY.DBF 
                    //Doi lay file NOCYYYY.DBF
                    //                    string _search_pattern = "NO*.DBF";
                    string _search_pattern = "NOC" + p_ky_chot.AddMonths(1).ToString("yyyy") + ".DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        try
                        {
                            //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
                            /*                            if (_file.Name.Length == 10)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
                            if (_file.Name.Length == 11)
                                if (Int32.Parse(p_ky_chot.Year.ToString()) == Int32.Parse(_file.Name.Substring(3, 4)))
                                {
                                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                    _so_file++;
                                }
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Copy file dữ liệu nợ KHOASO.DBF
        public static int Fnc_copy_file_khoaso(string p_path_source,
                                     DirectoryInfo p_dir_destination,                                     
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_KHOASO";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\DB_HT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file NOYYYY.DBF 
                    //Doi lay file NOCYYYY.DBF
                    //                    string _search_pattern = "NO*.DBF";
                    string _search_pattern = "KHOASO.DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        try
                        {
                            //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
                            /*                            if (_file.Name.Length == 10)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
                            /*                            if (_file.Name.Length == 11)
                                                            if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(3, 4)))
                                                            {*/
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                            //                                }
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Copy file danh mục nghành nghề
        //public static int Fnc_copy_file_DMNN(string p_path_source,
        //                             DirectoryInfo p_dir_destination,                                     
        //                             string p_tax_name,
        //                             string p_short_name,
        //                             Forms.Frm_QLCD p_frm_qlcd)
        //{
        //    using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
        //    {
        //        string _query = "";

        //        // Biến lưu trữ trên hàm hoặc thủ tục
        //        string v_pck = "FNC_COPY_FILE_DMNN";

        //        // Biến lưu trữ số file đã copy về máy
        //        int _so_file = 0;

        //        string _path_file = "\\DB_HT";
        //        DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

        //        _ora.TransStart();

        //        try
        //        {
        //            // Lấy file NOYYYY.DBF 
        //            //Doi lay file NOCYYYY.DBF
        //            //                    string _search_pattern = "NO*.DBF";
        //            string _search_pattern = "DMTS.DBF";
        //            ArrayList _listFile = new ArrayList();
        //            _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
        //            foreach (FileInfo _file in _listFile)
        //            {
        //                try
        //                {
        //                    //  Thay doi dieu kien lay nam theo ten file ( Lay o file ten NOCYYYY thay cho NOYYYY )
        //                    /*                            if (_file.Name.Length == 10)
        //                                                    if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))*/
        //                    /*                            if (_file.Name.Length == 11)
        //                                                    if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(3, 4)))
        //                                                    {*/
        //                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
        //                    _so_file++;
        //                    //                                }
        //                }
        //                catch (FormatException e)
        //                {
        //                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
        //                }
        //                catch (IOException e)
        //                {
        //                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
        //                }
        //                catch (Exception e)
        //                {
        //                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
        //                }
        //            }
        //            _listFile.Clear();
        //            _listFile = null;

        //            // Ghi log
        //            _query = null;
        //            _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
        //                                                        + v_pck + "', 'Y', null)";
        //            _ora.TransExecute(_query);
        //            _ora.TransCommit();
        //        }
        //        catch (Exception e)
        //        {
        //            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

        //            // Ghi log
        //            _query = null;
        //            _query +=
        //                "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
        //                                                    + v_pck + "', 'N', '";
        //            _query += e.Message.ToString().Replace("'", "\"") + "')";
        //            _ora.TransExecute(_query);
        //            _ora.TransRollBack();

        //            return -1;
        //        }

        //        return _so_file;
        //    }
        //}

        // Hàm copy file dữ liệu quyết định ấn định, bãi bỏ ấn định
        public static int Fnc_copy_file_qdad(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       DateTime p_ky_chot,
                                       string p_tax_name,
                                       string p_short_name,
                                       Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_QDAD";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file QDADYYYY.DBF
                    string _search_pattern = "QDAD*.DBF";
                    ArrayList _listFile_qdad = new ArrayList();
                    _listFile_qdad.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_qdad)
                    {
                        try
                        {
                            if (Int32.Parse((p_ky_chot.Year-1).ToString()) <= Int32.Parse(_file.Name.Substring(4, 4))
                                && Int32.Parse(p_ky_chot.Year.ToString()) >= Int32.Parse(_file.Name.Substring(4, 4)))
                            {
                                _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                _so_file++;
                            }
                        }
                        catch (FormatException)
                        {
                            //p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                        }
                    }
                    _listFile_qdad.Clear();
                    _listFile_qdad = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Hàm copy file dữ liệu master tờ khai TNDN quý TKDNYYYY.DBF
        public static int Fnc_copy_file_tkdnyyyy(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_chot,
                                     string p_tax_name,
                                     string p_short_name,
                                     Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_TKDNYYYY";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file TKMMYYYY.DBF
                    string _search_pattern = "TKDN*.DBF";
                    ArrayList _listFile = new ArrayList();
                    _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile)
                    {
                        if (_file.Name.Length == 12)
                        {
                            try
                            {
                                int _temp_year = Int32.Parse(_file.Name.Substring(4, 4));
                                DateTime _temp_date = new DateTime(_temp_year, 1, 1);

                                if ((_temp_date.Year == p_ky_chot.Year) || (_temp_date.Year == p_ky_chot.Year-1))
                                {
                                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                    _so_file++;
                                }
                            }
                            catch (FormatException)
                            {
                                // Trường hợp này không in lỗi ra
                                //p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            }
                            catch (IOException e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            }
                            catch (Exception e)
                            {
                                p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            }
                        }
                    }
                    _listFile.Clear();
                    _listFile = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Hàm copy file detail tờ khai môn bài
        public static int Fnc_copy_file_MBCT(string p_path_source,
                                      DirectoryInfo p_dir_destination,
                                      DateTime p_ky_chot,
                                      string p_tax_name,
                                      string p_short_name,
                                      Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_TKMB";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    // Lấy file MBCTYYYY.DBF
                    string _search_pattern = "MBCT" + p_ky_chot.ToString("yyyy") + ".DBF";
                    ArrayList _listFile_tkmb = new ArrayList();
                    _listFile_tkmb.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_tkmb)
                    {
                        try
                        {
                            if (_file.Name.Length == 12)
                            {
                                _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                                _so_file++;
                            }
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_tkmb.Clear();
                    _listFile_tkmb = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }
        }

        // Hàm copy file master dữ liệu tờ khai môn bài
        public static int Fnc_copy_file_TKMB(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       DateTime p_ky_chot,                                       
                                       string p_tax_name,
                                       string p_short_name,
                                       Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_TKMB";

                // Biến lưu trữ số file đã copy về máy
                int _so_file = 0;

                string _path_file = "\\TK_CT";
                DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

                _ora.TransStart();

                try
                {
                    string _search_pattern = "TKMB" + p_ky_chot.ToString("yyyy") + ".DBF";

                    // Danh sách các file
                    ArrayList _listFile_tkmb = new ArrayList();
                    _listFile_tkmb.AddRange(_dir_source.GetFiles(_search_pattern));
                    foreach (FileInfo _file in _listFile_tkmb)
                    {
                        try
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name), true);
                            _so_file++;
                        }
                        catch (FormatException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (IOException e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                        }
                    }
                    _listFile_tkmb.Clear();
                    _listFile_tkmb = null;

                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }

                return _so_file;
            }

        }

    }
}
