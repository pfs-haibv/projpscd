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
    class CLS_DTNT
    {
        public CLS_DTNT()
        { }
        ~CLS_DTNT()
        { }

        public static void Prc_doc_danh_muc(string p_short_name,
                                        string p_tax_name,
                                        string p_tax_code,
                                        string p_path,
                                        DirectoryInfo p_dir_source,
                                        Forms.Frm_QLCD p_frm_qlcd)
        {
            string _query = "";
            //Biến lưu trữ tên của hàm hoặc thủ tục
            
            CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

            

            // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
            
            using (CLS_DBASE.ORA _connOra_cndm = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {

                #region Xoá dữ liệu danh mục cũ
                _query = @"Delete tb_vat_dtnt Where short_name= '" + p_short_name + "'";
                _connOra_cndm.exeUpdate(_query);
                #endregion

                #region Đọc dữ liệu mã danh mục

                _query = @"SELECT madtnt as madtnt, mabpql as mabpql, macaptren as macaptren,'"
                         + p_short_name + "' as short_name,left(allt(tengoi),75) as tendtnt from Dtnt2";

                DataTable _dt = _connFoxPro.exeQuery(_query);
                foreach (DataRow _dr in _dt.Rows)
                {
                    _query = @"INSERT INTO tb_vat_dtnt (madtnt, mabpql, macaptren, short_name, tendtnt)
                                          VALUES ('" + _dr["madtnt"].ToString().Trim() +
                                  @"', '" + _dr["mabpql"].ToString().Trim() +
                                  @"', '" + _dr["macaptren"].ToString().Trim() +
                                  @"', '" + p_short_name +
                                  @"', '" + _dr["tendtnt"].ToString().Trim() + @"')";
                    _connOra_cndm.exeUpdate(_query);
                }
                //CLS_DBASE.WriteToServer(GlobalVar.gl_connTKTQ1, "tb_vat_dtnt", _dt);

                _dt.Clear();
                _dt = null;
                _connFoxPro.close();

                #endregion

                #region Cập nhật MaDTNT 13 số

                _query = @"UPDATE tb_vat_dtnt
                                    SET madtnt = SUBSTR(trim(madtnt),1,10) || '-' || SUBSTR(trim(madtnt),11,3)
                                    WHERE length(trim(madtnt))>10
                                    AND short_name= '" + p_short_name + "'";
                _connOra_cndm.exeUpdate(_query);

                #endregion

                #region Đọc dữ liệu tên phòng ban, cán bộ

                _query = @"SELECT mabpql, tengoi, macaptren from dmbpql";

                _dt = _connFoxPro.exeQuery(_query);
                string name;
                string code;
                string macaptren;

                foreach (DataRow _dr in _dt.Rows)
                {
                    macaptren = _dr["macaptren"].ToString().Trim();
                    if (macaptren == "")
                    {
                        name = "TENCAPTRENQUANLY";
                        code = "MACAPTREN";
                    }
                    else
                    {
                        name = "TENBOPHANQUANLY";
                        code = "MABPQL";
                    }
                    _query = @"UPDATE tb_vat_dtnt
                                          SET " + name + @" = '" + _dr["tengoi"].ToString().Trim() + @"'
                                        WHERE trim(" + code + ") = '" + _dr["mabpql"].ToString().Trim() + @"'
                                          AND short_name= '" + p_short_name + "'";
                    _connOra_cndm.exeUpdate(_query);
                }
                _dt.Clear();
                _dt = null;
                _connFoxPro.close();

                #endregion

            }
        }


        //TienTM2 : Kiem tra dieu kien khoa so
        public static string Prc_kiem_tra_dieu_kien_khoa_so(string p_short_name,
                                           string p_tax_name,
                                           string p_tax_code,
                                           string p_path,
                                           DirectoryInfo p_dir_source,
                                           Forms.Frm_QLCD p_frm_qlcd,
                                           ref DateTime p_ky_chot
                                           )
        {
            using (CLS_DBASE.ORA _connOra_cndm = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                //Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "Prc_kiem_tra_dieu_kien_khoa_so";
                string lcKy_Chot;
              
                string _search_pattern = "KHOASO.DBF";
                // Đối tượng lưu trữ các file dữ liệu
                ArrayList _listFile_no = new ArrayList();
                // Lấy danh sách các file dữ liệu
                _listFile_no.AddRange(p_dir_source.GetFiles(_search_pattern));
                string khoaso = "N";
                foreach (FileInfo _file in _listFile_no)
                {
                    lcKy_Chot = p_ky_chot.ToString("MM/yyyy");
                    try
                    {
                        _query = @"Select kylbo from khoaso where not delete() and kylbo = '" + lcKy_Chot + "'";

                        CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                        // Chứa dữ liệu
                        DataTable _dt = _connFoxPro.exeQuery(_query);
                        if (_dt.Rows.Count > 0)
                        {
                            khoaso = "Y";
                            break;
                        }
                    }
                    catch (Exception e)
                    {
                        p_frm_qlcd.AddToListView(0, "   + " + p_short_name + "/ " + v_pck + ": " + e.Message);
                    }
                }
                return khoaso;
            }
        }

        //test check out
        //TienTM2 : Get parameter of Target Server
        public static void Prc_Targetes_Server_Parameter(ref string target_username, ref string target_password)
        {
            //            using (CLS_DBASE.ORA _connOra_cndm = new CLS_DBASE.ORA("Provider=msdaora;Data Source=DPPIT;User Id=TKTQ;Password=TKTQ;"))
            using (CLS_DBASE.ORA _connOra_ptsp = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                //Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "Prc_Targetes_Server_Parameter";

                // Biến lưu số bản ghi dữ liệu phát sinh tháng                    
                //int _rowsnum = 0;

                ArrayList parameter = new ArrayList();

                #region Server Parameter
                try
                {
                    _query = @"SELECT rv_key, rv_chr FROM tb_01_para where rv_group ='TARGETES'";
                    DataTable _dt = _connOra_ptsp.exeQuery(_query);
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        target_username = _dr["rv_key"].ToString().Trim();
                        target_password = _dr["rv_chr"].ToString().Trim();
                    }
                }
                catch (Exception e)
                {
                    //return -1;
                    MessageBox.Show(e.Message);
                }
                #endregion
            }
        }

        public static string Fnc_Capnhatdanhmuc(string p_short_name)
        {
            // Biến lưu trữ tên của hàm hoặc thủ tục
            //string v_pck = "FNC_GHI_DU_LIEU_DKNTK";

            // Hàm lưu số bản ghi đã được xóa
            
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHUYENDOI_VAT.Prc_Capnhatdanhmuc('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }

            return "Y";

        }
    }
}
