using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using DC.Utl;
using DC.Lib;
using System.Collections;
using System.Globalization;

namespace DC.Forms
{
    public partial class Frm_HTDC : Form
    {
        public Frm_HTDC()
        {
            InitializeComponent();
        }

        private void btn_browse_Click(object sender, EventArgs e)
        {
            fbd.ShowDialog();
            tb_path.Text = fbd.SelectedPath.ToString();
        }

        private void btn_cancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_import_Click(object sender, EventArgs e)
        {
            // Xác định thư mục chứa file dbf
            string _path = System.IO.Path.GetFullPath(tb_path.Text.ToString());            
            DirectoryInfo _dir_source = new DirectoryInfo(_path);

            try
            {                
                // Xóa dữ liệu cũ trên DPPIT
                Prc_delete();
                // Import file psqt.dbf
                Prc_import_psqt(_dir_source, _path);
                // Import file sono.dbf
                Prc_import_sono(_dir_source, _path);
                // Import file tokhai10.dbf
                Prc_import_tokhai10(_dir_source, _path);
                MessageBox.Show("Finished");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public static void Prc_delete() 
        {
            CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            string _query = @"DELETE FROM tb_temp_dchieu
                                    WHERE mau = 'VAT-APP'";
            _ora.TransStart();
            try
            {
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e) {
                throw new Exception("Có lỗi khi xóa dữ liệu: " + e.Message.ToString());
                _ora.TransRollBack();
            }
            finally {
                _ora.close();
            }            
        }

        public static void Prc_import_psqt(DirectoryInfo p_dir_source, string p_path)
        {
            
            CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            string _query = "";
            string _search_pattern = "PSQT.DBF";
            _ora.TransStart();
            try
            {
                ArrayList _listFile = new ArrayList();
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    try
                    {
                        _query = @"SELECT short_name, matkhai, tien from {0}";

                        _query = _query.Replace("{0}", _file.Name.ToString());

                        CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                        DataTable _dt = _connFoxPro.exeQuery(_query);

                        foreach (DataRow _dr in _dt.Rows)
                        {
                            _query = @"INSERT INTO tb_temp_dchieu ( short_name, 
                                                                    mau, 
                                                                    v_char1, 
                                                                    v_char2, 
                                                                    v_char3, 
                                                                    loai)
                                            VALUES ('{1}', '{2}', '{3}', '{4}', '{5}', '{6}')";

                            _query = _query.Replace("{1}", _dr["short_name"].ToString());
                            _query = _query.Replace("{2}", "VAT-APP");
                            _query = _query.Replace("{3}", _dr["matkhai"].ToString());
                            _query = _query.Replace("{4}", String.Format("{0:#,0}", Double.Parse(_dr["tien"].ToString())));
                            _query = _query.Replace("{5}", "");
                            _query = _query.Replace("{6}", "PS");

                            _ora.TransExecute(_query);                            
                        }
                        _dt.Clear();
                        _dt = null;
                        _connFoxPro.close();
                    }
                    catch (FormatException e)
                    {
                        _ora.TransRollBack();
                        throw new FormatException("Có lỗi khi import file psqt.dbf: " + e.Message.ToString());                        
                    }
                    catch (Exception e)
                    {
                        _ora.TransRollBack();
                        throw new Exception("Có lỗi khi import file psqt.dbf: " + e.Message.ToString());                        
                    }
                }
                _ora.TransCommit();
                _listFile.Clear();
                _listFile = null;

            }
            catch (Exception e)
            {
                _ora.TransRollBack();
                throw new Exception("Có lỗi khi import file psqt.dbf: " + e.Message.ToString());                
            }
            finally 
            {
                _ora.close();
            }
        }

        public static void Prc_import_sono(DirectoryInfo p_dir_source, string p_path)
        {

            CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            string _query = "";
            string _search_pattern = "SONO.DBF";
            _ora.TransStart();
            try
            {
                ArrayList _listFile = new ArrayList();
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    try
                    {
                        _query = @"SELECT short_name, matm, phainop, nopthua from {0}";

                        _query = _query.Replace("{0}", _file.Name.ToString());

                        CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                        DataTable _dt = _connFoxPro.exeQuery(_query);

                        foreach (DataRow _dr in _dt.Rows)
                        {
                            _query = @"INSERT INTO tb_temp_dchieu ( short_name, 
                                                                    mau, 
                                                                    v_char1, 
                                                                    v_char2, 
                                                                    v_char3, 
                                                                    loai)
                                            VALUES ('{1}', '{2}', '{3}', '{4}', '{5}', '{6}')";

                            _query = _query.Replace("{1}", _dr["short_name"].ToString());
                            _query = _query.Replace("{2}", "VAT-APP");
                            _query = _query.Replace("{3}", _dr["matm"].ToString());
                            _query = _query.Replace("{4}", String.Format("{0:#,0}", Double.Parse(_dr["phainop"].ToString())));
                            _query = _query.Replace("{5}", String.Format("{0:#,0}", Double.Parse(_dr["nopthua"].ToString())));
                            _query = _query.Replace("{6}", "NO");

                            _ora.TransExecute(_query);                            
                        }
                        _dt.Clear();
                        _dt = null;
                        _connFoxPro.close();
                    }
                    catch (FormatException e)
                    {
                        _ora.TransRollBack();
                        throw new FormatException("Có lỗi khi import file sono.dbf: " + e.Message.ToString());                        
                    }
                    catch (Exception e)
                    {
                        _ora.TransRollBack();
                        throw new Exception("Có lỗi khi import file sono.dbf: " + e.Message.ToString());                        
                    }
                }
                _listFile.Clear();
                _listFile = null;
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                _ora.TransRollBack();
                throw new Exception("Có lỗi khi import file sono.dbf: " + e.Message.ToString());                
            }
            finally
            {
                _ora.close();
            }
        }

        public static void Prc_import_tokhai10(DirectoryInfo p_dir_source, string p_path)
        {

            CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            string _query = "";
            string _search_pattern = "TOKHAI10.DBF";
            _ora.TransStart();
            try
            {
                ArrayList _listFile = new ArrayList();
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile)
                {
                    try
                    {
                        _query = @"SELECT short_name, tien from {0}";

                        _query = _query.Replace("{0}", _file.Name.ToString());

                        CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                        DataTable _dt = _connFoxPro.exeQuery(_query);

                        foreach (DataRow _dr in _dt.Rows)
                        {
                            _query = @"INSERT INTO tb_temp_dchieu ( short_name, 
                                                                    mau, 
                                                                    v_char1, 
                                                                    v_char2, 
                                                                    v_char3, 
                                                                    loai)
                                            VALUES ('{1}', '{2}', '{3}', '{4}', '{5}', '{6}')";

                            _query = _query.Replace("{1}", _dr["short_name"].ToString());
                            _query = _query.Replace("{2}", "VAT-APP");
                            _query = _query.Replace("{3}", "10/KK-TNCN");
                            _query = _query.Replace("{4}", String.Format("{0:#,0}", Double.Parse(_dr["tien"].ToString())));
                            _query = _query.Replace("{5}", "");
                            _query = _query.Replace("{6}", "TK");

                            _ora.TransExecute(_query);                            
                        }
                        _dt.Clear();
                        _dt = null;
                        _connFoxPro.close();
                    }
                    catch (FormatException e)
                    {
                        _ora.TransRollBack();
                        throw new FormatException("Có lỗi khi import file psqt.dbf: " + e.Message.ToString());                        
                    }
                    catch (Exception e)
                    {
                        _ora.TransRollBack();
                        throw new Exception("Có lỗi khi import file tokhai10.dbf: " + e.Message.ToString());                        
                    }
                }
                _listFile.Clear();
                _listFile = null;
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                _ora.TransRollBack();
                throw new Exception("Có lỗi khi import file tokhai10.dbf: " + e.Message.ToString());                
            }
            finally
            {
                _ora.close();
            }
        }
    }
}