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
    class CLS_DKNTK
    {
        public CLS_DKNTK()
        { }
        ~CLS_DKNTK()
        { }

        // Hàm xóa dữ liệu cũ trong bảng TB_DKNTK
        public static int Fnc_xoa_du_lieu_dkntk(string p_short_name,
                                                string p_tax_name,
                                                Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_DKNTK";

                // Hàm lưu số bản ghi đã được xóa
                int _rowsnum = 0;

                try
                {
                    _query = @"DELETE FROM tb_vat_dkntk
                                WHERE short_name = '" + p_short_name + @"'
                               ";
                    _rowsnum = _ora.exeUpdate(_query);

                    _query = @"DELETE FROM tb_dkntk
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                    _rowsnum = _ora.exeUpdate(_query);

                    // Ghi log
                    _ora.TransStart();
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);

                    // Ghi log
                    _ora.TransStart();
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();
                    
                    return -1;
                }
                return _rowsnum;
            }
        }

        // Hàm đọc dữ liệu nợ
        public static int Fnc_doc_file_dkntk(string p_short_name,
                                          string p_tax_name,
                                          string p_tax_code,
                                          ref DateTime p_ky_chot,
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
                string v_pck = "FNC_DOC_FILE_DKNTK";
                string _ky_chot = p_ky_chot.ToString("MM/yyyy");
                DateTime _ngay_dau_nam = new DateTime(p_ky_chot.Year,1,1);

                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";
                // Biến lưu số bản ghi đã được bổ sung vào bảng TB_NO
                int _rowsnum = 0;

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                #region Docfile dkntk
                try
                {
                    // File 
                    string _search_pattern = "DTNT_LT2.DBF";
                    // Đối tượng lưu trữ các file dữ liệu
                    ArrayList _listFile = new ArrayList();
                    // Lấy danh sách các file dữ liệu
                    _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                    foreach (FileInfo _file in _listFile)
                    {
                        if (_file.Name.Length != 12)
                            continue;
                        try
                        {
                            _query = @"SELECT a.madtnt as tin,
                                              a.tuky as ky_bat_dau,
                                              a.denky as ky_ket_thuc,
                                              a.matkhai as ma_tkhai,
                                              '{2}' AS short_name                                          
                                       FROM {0} a 
                                       INNER JOIN
                                            DTNT2.DBF as c
                                            ON a.madtnt = c.madtnt
                                       WHERE  CTOD('01/' + '{1}') >= CTOD('01/' + a.TuKy)
                                              and (CTOD('01/' + '{1}') <= CTOD('01/' + a.DenKy)
                                                    or empty(a.DenKy) or trim(a.DenKy)='/') 
                                              and Allt(matkhai) in (select Allt(matkhai) from dmtokhai.dbf)
                                              and Allt(a.madtnt) not in (select Allt(MaDTNT) from {3} where empty(denngay))
                                             ";
                            
                            _query = _query.Replace("{0}", _file.Name);
                            _query = _query.Replace("{1}", _ky_chot);
                            _query = _query.Replace("{2}", p_short_name);
                            _query = _query.Replace("{3}", _File_Nghi);
                                                                                    
                            CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);
                            
                            // Chứa dữ liệu
                            DataTable _dt = _connFoxPro.exeQuery(_query);                            
                            CLS_DBASE.WriteToServer(GlobalVar.gl_connTKTQ1, "TB_VAT_DKNTK", _dt);                            
                            
                            _connFoxPro.close();
                            _dt.Clear();
                            _dt = null;
                        }
                        catch (Exception e)
                        {
                            p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                            _error_message += e.Message + "(" + _file.Name + ");";
                        }
                        
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
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);

                    // Ghi log
                    _connOra_no.TransStart();
                    _query = null;
                    _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                    + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _connOra_no.TransExecute(_query);
                    _connOra_no.TransRollBack();

                    return -1;
                }
                #endregion
                return _rowsnum;                
            }
        }

        public static int Fnc_ghi_du_lieu_dkntk(string p_short_name)
        {
            // Biến lưu trữ tên của hàm hoặc thủ tục
           //string v_pck = "FNC_GHI_DU_LIEU_DKNTK";

            // Hàm lưu số bản ghi đã được xóa
            int _rowsnum = 0;

            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHUYENDOI_VAT.prc_capnhat_dkntk('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();  

                _ora.TransStart();
                _query = "call PCK_CHUYENDOI_VAT.prc_ghi_dkntk('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();              
            }

            return _rowsnum;

        }

    }
}

