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
    class CLS_NO
    {
        public CLS_NO()
        { }
        ~CLS_NO()
        { }
        
        // Hàm xóa dữ liệu nợ cũ trong bảng TB_NO
        public static int Fnc_xoa_du_lieu_no_cu(string p_short_name,
                                                string p_tax_name,
                                                Forms.Frm_QLCD p_frm_qlcd)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_XOA_DU_LIEU_NO_CU";

                // Hàm lưu số bản ghi đã được xóa
                int _rowsnum = 0;


                _query = @"DELETE FROM tb_no
                                WHERE short_name = '" + p_short_name + @"'
                                  AND tax_model = 'VAT-APP'";
                _rowsnum = _ora.exeUpdate(_query);
              

                return _rowsnum;
            }
        }

        // Hàm đọc dữ liệu nợ
        public static int Fnc_doc_file_no(string p_short_name,
                                          string p_tax_name,
                                          string p_tax_code,
                                          ref DateTime p_ky_chot,
                                          string p_path,
                                          DirectoryInfo p_dir_source,
                                          Forms.Frm_QLCD p_frm_qlcd,
                                          ref string flages)
        {
            //using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            using (CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQVATW))
            {
                string _query = "";

                // Biến lưu trữ tên của hàm hoặc thủ tục
                string v_pck = "FNC_DOC_FILE_NO";
                string _ky_chot_1 = p_ky_chot.AddMonths(1).ToString().Trim().Substring(3, 7);
                string _File_Nghi = "Nghi" + p_ky_chot.ToString("yyyy") + ".DBF";

                // Biến lưu số bản ghi đã được bổ sung vào bảng TB_NO
                int _rowsnum = 0;

                // Biến lưu mô tả lỗi, ngoại lệ trong quá trình đọc file dữ liệu
                string _error_message = "";

                #region Docfileno

                // File NOYYYY.DBF
                string _search_pattern = "NOC" + p_ky_chot.AddMonths(1).ToString("yyyy") + ".DBF";
                // Đối tượng lưu trữ các file dữ liệu
                ArrayList _listFile_no = new ArrayList();
                // Lấy danh sách các file dữ liệu
                _listFile_no.AddRange(p_dir_source.GetFiles(_search_pattern));

                foreach (FileInfo _file in _listFile_no)
                {
                    if (_file.Name.Length != 11)
                        continue;

                    _query = @"SELECT a.madtnt as tin,
                                             a.matm as tmt_ma_tmuc,
                                             a.matk as ma_tkhoan,
                                             a.KyKKhai,
                                             a.hannop as han_nop,
                                             a.SoQD as SoQD,
                                             a.NgayQD as NgayQD,
                                             a.KyLBo,
                                             MAX(a.KyLSo) as KyLSo,
                                             MAX(c.MaChuong) as machuong,
                                             sum(iif(a.lqddc = '0',a.NoDKy,0)) as no_cuoi_ky
                                             FROM {0} a 
                                                        INNER JOIN
                                                        DTNT2.DBF as c
                                                        ON a.madtnt = c.madtnt
                                             WHERE a.MaMuc <> '1000' 
                                             AND a.matm <> '4268'
                                             AND a.MaTK <> 'TKTG'
                                             AND iif(a.lqddc = '0',a.NoDKy,0) <> 0                                             
                                             AND a.KyLBo = '{1}'                                             
                                             GROUP BY tin, tmt_ma_tmuc, ma_tkhoan, KyKKhai, han_nop, KyLbo, SoQD, NgayQD";

                    _query = _query.Replace("{0}", _file.Name);
                    _query = _query.Replace("{3}", _File_Nghi);

                    string ThangTrKhai = p_ky_chot.AddMonths(1).ToString().Trim().Substring(3, 2);
                    string NamTrKhai = p_ky_chot.AddMonths(1).ToString().Trim().Substring(6, 4);
                    _query = _query.Replace("{1}", _ky_chot_1);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    //                            int countf = 0;
                    int chot;
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu                            
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length < 4)
                            _ky_kkhai = _dr["KyLSo"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length < 4)
                            _ky_kkhai = _dr["KyLBo"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length == 4)
                            _ky_kkhai = "01" + _ky_kkhai;
                        if (_ky_kkhai.Length < 6)
                            _ky_kkhai = "0" + _ky_kkhai;


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

                        string _KyLSo = _dr["KyLSo"].ToString().Trim();
                        if (_KyLSo.Length != 7)
                            _KyLSo = p_ky_chot.ToString("MM/yyyy");

                        int _nam_LSo = Int32.Parse(_KyLSo.Substring(3, 4));

                        DateTime _ngay_htoan;
                        DateTime _ngay_dau_nam = new DateTime(p_ky_chot.Year, 1, 1);
                        if (_nam_LSo < p_ky_chot.Year)
                            _ngay_htoan = _ngay_dau_nam.AddDays(-1);
                        else
                            _ngay_htoan = p_ky_chot;

                        _query = @"INSERT INTO tb_no
                                               (short_name, stt, loai, ma_cqt,
                                                tin, ma_chuong, ma_khoan, tmt_ma_tmuc,
                                                tkhoan, ngay_htoan, kykk_tu_ngay,
                                                kykk_den_ngay, han_nop,
                                                so_tien, tax_model, status, id, So_QD, Ngay_QD)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', '{12}', '{14}',
                                                '{15}', '{16}', {17}, '{18}', '{19}')";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", (_rowsnum + 1).ToString());
                        _query = _query.Replace("{2}", "CD");
                        _query = _query.Replace("{3}", p_tax_code);

                        string matin = _dr["tin"].ToString().Trim();
                        if (matin.Length > 10)
                        {
                            matin = matin.Insert(10, "-");
                        }

                        _query = _query.Replace("{4}", matin);
                        _query = _query.Replace("{5}", _dr["machuong"].ToString().Trim());
                        _query = _query.Replace("{6}", "000");
                        _query = _query.Replace("{7}", _dr["tmt_ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{8}", _dr["ma_tkhoan"].ToString().Trim());
                        _query = _query.Replace("{9}", _ngay_htoan.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{10}", _kykk_tu_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{11}", _kykk_den_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{12}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{14}", _dr["no_cuoi_ky"].ToString().Trim());
                        _query = _query.Replace("{15}", "VAT-APP");
                        _query = _query.Replace("{16}", "");
                        _query = _query.Replace("{17}", "seq_id_csv.nextval");
                        _query = _query.Replace("{18}", _dr["SoQD"].ToString().Trim());
                        _query = _query.Replace("{19}", ((DateTime)_dr["NgayQD"]).ToString("dd/MM/yyyy"));

                        if (_connOra_no.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }

                    _connFoxPro.close();
                    _dt.Clear();
                    _dt = null;

                    if (_rowsnum == 0)
                    {
                        string e = "Chưa có nợ của kỳ lập bộ tháng chốt dữ liệu";
                        //MessageBox.Show("Chưa có nợ của kỳ lập bộ tháng chốt dữ liệu");
                        flages = "No";
                        p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e);                      
                                             
                        break;
                    }
                }
                _listFile_no.Clear();
                _listFile_no = null;


                #endregion
                return _rowsnum;
            }
        }        
    }
}

