using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Reflection;
using DataGridViewAutoFilter;
using DC.Utl;
using DC.Lib;
using DC.Lib.Objects;
using SAP.Middleware.Connector;
using System.Threading;
using System.Data.OleDb;
using System.Collections;
using System.IO;
using System.DirectoryServices;
using System.Net;
using System.Diagnostics;

namespace DC.Forms
{
    public partial class Frm_QLCD : Form
    {        
    #region KHỞI TẠO
        private static bool[] v_rowIndex;
        private static int newRowIndex;
        private static int oldRowIndex;
        private static int newIndexOfComboBox;
        private static int oldIndexOfComboBox;
        private static int _countdgr = 0;

        // Tạo kết nối tới cơ sở dữ liệu trung gian
        private static CLS_DBASE.ORA _ora;
        
        public Frm_QLCD()
        {
            _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            InitializeComponent();            
            
            // Khởi tạo giá trị cho các biến thành viên            
            Prc_InitializeMember();            

            // Background Worker            
            Prc_InitializeBackGroundWorker();            
        }
        ~Frm_QLCD()
        {
            _ora.close();
        }       
        private void Prc_InitializeMember()
        {
            this.tabPage3_listView2.SmallImageList = iconImageList;
            newRowIndex = oldRowIndex = -1;
            newIndexOfComboBox = oldIndexOfComboBox = 0;            
        }
        // BackGround Worker
        private void Prc_InitializeBackGroundWorker()
        {
            qlcd_backgroundWorker = new BackgroundWorker();
            qlcd_backgroundWorker.WorkerReportsProgress = true;
            qlcd_backgroundWorker.WorkerSupportsCancellation = true;

            qlcd_backgroundWorker.DoWork += qlcd_backgroundWorker_DoWork;
            qlcd_backgroundWorker.ProgressChanged += qlcd_backgroundWorker_ProgressChanged;
            qlcd_backgroundWorker.RunWorkerCompleted += qlcd_backgroundWorker_RunWorkerCompleted;
        }
        // Khởi tạo giá trị cho Combobox
        public GlobalVar.Struc_Combo[] Data_Combo = new GlobalVar.Struc_Combo[] 
        {
            new GlobalVar.Struc_Combo("TH", "01. Đặt Job tổng hợp dữ liệu cho CQT"), 
            new GlobalVar.Struc_Combo("CV", "02. Chuyển dữ liệu tổng hợp về DPPIT"),
            new GlobalVar.Struc_Combo("KT", "03. Kiểm tra dữ liệu")
        };        
        #endregion

    #region FORM CONTROL                
        // Event load form
        private void Frm_QLCD_Load(object sender, EventArgs e)
        {
            Prc_Fill_Dgr();            
            v_rowIndex = new bool[this.dgrTaxOffice.Rows.Count];
            Prc_ComboBoxBinding();            
            loadStatus(0);
            loadLog(0);
            Prc_ktra_trang_thai(0);            
            this.dgrTaxOffice.CurrentCellChanged += new EventHandler(dgrTaxOffice_CurrentCellChanged);
        }
        // Fill dữ liệu vào Datagrid dgrTaxOffice
        private void Prc_Fill_Dgr()
        {
            string _query = "SELECT a.tax_name, a.short_name, a.province, b.prov_name, a.tax_code, c.ma_cqt," +
                                  "       a.tax_model, a.status, a.qlt_host, a.qlt_user, a.qlt_pass, a.tinc_host," +
                                  "       a.tinc_user, a.tinc_pass, a.bmt_host, a.bmt_user, a.bmt_pass," +
                                  "       a.vat_host, a.vat_user, a.vat_pass, a.vat_ddan_tu," +
                                  "       a.vat_ddan_den, a.ky_ps_tu, a.ky_ps_den, a.ky_no_tu, a.ky_no_den," +
                                  "       a.ky_ps10_tu, a.ky_ps10_den, a.ky_tk10_tu, a.ky_tk10_den, a.dblink" +
                                  "  FROM tb_lst_taxo a, tb_lst_province b, tb_lst_map_cqt c" +
                                  " WHERE a.province=b.province" +
                                  "   AND a.tax_code=c.ma_qlt" +
                                  " ORDER BY a.province, a.tax_code";
            DataTable _dt = _ora.exeQuery(_query);            

            this.bndSource.DataSource = _dt;
            _countdgr = _dt.Rows.Count;
            _dt = null;
        }
        // Fill dữ liệu vào CommboBox
        private void Prc_ComboBoxBinding()
        {
            // Populate the list
            this.tabPage1_comboBox1.DataSource = Data_Combo;

            // Define the field to be displayed
            this.tabPage1_comboBox1.DisplayMember = "Display";

            // Define the field to be used as the value
            this.tabPage1_comboBox1.ValueMember = "Value";
        }
        

        // Load chi tiết trạng thái của CQT
        private void loadStatus(int p_index)
        {
            // Xóa các item trước đó của danh sách
            this.status_listView.Items.Clear();

            // Xác định cơ quan thuế hiện tại
            string _short_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_short_name"].Value.ToString();

            string _query = @"SELECT decode(a.id_name, 'Null', 'Y', b.status) status,
                                                     a.id_name status_name
                                                FROM tb_lst_stacqt a, ( SELECT c.pck, c.status, d.tax_model
                                                                          FROM tb_log_pck c, tb_lst_taxo d
                                                                         WHERE c.short_name = d.short_name 
                                                                           AND c.ltd = 0 
                                                                           AND c.short_name = '" + _short_name + @"') b
                                               WHERE a.func_name = b.pck(+) 
                                                 AND EXISTS ( SELECT 1 
                                                                FROM tb_lst_taxo c 
                                                               WHERE c.short_name = '" + _short_name + @"' 
                                                                 AND c.tax_model = a.tax_model)
                                            ORDER BY a.stt";

            DataTable _dt = _ora.exeQuery(_query);
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                DataRow _dr = _dt.Rows[i];

                ListViewItem lvi = new ListViewItem(_dr["status_name"].ToString());
                lvi.SubItems.Add(_dr["status"].ToString());

                this.status_listView.Items.Add(lvi);
            }            
        }

        // Load Log
        delegate void loadLogDelegate(int p_index);
        private void loadLog(int p_index)
        {
            if (this.tabPage3_listView1.InvokeRequired == true)
            {
                loadLogDelegate del = new loadLogDelegate(loadLog);
                this.tabPage3_listView1.Invoke(del, p_index);
            }
            else
            {
                // Xóa các item trước đó của danh sách
                this.tabPage3_listView1.Items.Clear();

                // Xác định cơ quan thuế hiện tại
                string _short_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_short_name"].Value.ToString();
                string _query = @"SELECT a.short_name, a.pck, a.status, a.timestamp
                                                FROM tb_errors a
                                               WHERE a.short_name = '" + _short_name + "'";
                DataTable _dt = _ora.exeQuery(_query);
                for (int i = 0; i < _dt.Rows.Count; i++)
                {
                    DataRow _dr = _dt.Rows[i];
                    ListViewItem lvi = new ListViewItem(_dr["short_name"].ToString());
                    lvi.SubItems.Add(_dr["pck"].ToString());
                    lvi.SubItems.Add(_dr["status"].ToString());
                    lvi.SubItems.Add(_dr["timestamp"].ToString());

                    this.tabPage3_listView1.Items.Add(lvi);
                }
            }
        }

        #endregion

    #region EVENT HANDLE
        private void dgrTaxOffice_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Alt && (e.KeyCode == Keys.Down || e.KeyCode == Keys.Up))
            {
                DataGridViewAutoFilterColumnHeaderCell filterCell =
                    dgrTaxOffice.CurrentCell.OwningColumn.HeaderCell as
                    DataGridViewAutoFilterColumnHeaderCell;
                if (filterCell != null)
                {
                    filterCell.ShowDropDownList();
                    e.Handled = true;
                }
            }
        }
        private void dgrTaxOffice_BindingContextChanged(object sender, EventArgs e)
        {
            if (dgrTaxOffice.DataSource == null) return;

            foreach (DataGridViewColumn col in dgrTaxOffice.Columns)
            {
                col.HeaderCell = new DataGridViewAutoFilterColumnHeaderCell(col.HeaderCell);
            }
            //dgrTaxOffice.AutoResizeColumns();
        }
        private void dgrTaxOffice_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            String filterStatus = DataGridViewAutoFilterColumnHeaderCell.GetFilterStatus(this.dgrTaxOffice);
            this.lb_dgr_status.Text = "Tổng số bản ghi: " + this.dgrTaxOffice.RowCount + "/" + _countdgr;

        }
        private void dgrTaxOffice_CurrentCellChanged(object sender, EventArgs e)
        {
            try
            {
                if (this.dgrTaxOffice.SelectedCells.Count > 0)
                {
                    newRowIndex = this.dgrTaxOffice.SelectedCells[0].RowIndex;
                    if (newRowIndex != oldRowIndex)
                    {
                        loadStatus(newRowIndex);
                        loadLog(newRowIndex);
                        Prc_ktra_trang_thai(newRowIndex);
                    }
                    oldRowIndex = newRowIndex;
                }
            }
            catch (Exception ex)
            {
                AddToListView(0, ex.Message.ToString());

            }
        }
        private void dgrTaxOffice_CurrentCellChanged_VATWIN(object sender, EventArgs e)
        {
            int _index;
            string _path_source, _user_source, _password_source;
            string _path_destination, _user_destination, _password_destination;

            // xác định CQT
            _index = this.dgrTaxOffice.SelectedCells[0].RowIndex;

            // Xác định cấu hình máy nguồn chứa file dữ liệu cần sao chép
            _path_source = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_ddan_tu"].Value.ToString();
            _user_source = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_user"].Value.ToString();
            _password_source = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_pass"].Value.ToString();

            // Xác định cấu hình máy đích chứa file dữ liệu sao chép
            _path_destination = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_ddan_den"].Value.ToString();
            _user_destination = "dci";
            _password_destination = "1209";

            // Khởi tạo giá trị VATWIN trên form
            this.tb_path_source.Text = _path_source;
            this.tb_user_source.Text = _user_source;
            this.tb_password_source.Text = _password_source;

            this.tb_path_destination.Text = _path_destination;
            this.tb_user_destination.Text = _user_destination;
            this.tb_password_destination.Text = _password_destination;

            this.tb_folder.Text = _path_destination;
            this.tb_user.Text = _user_destination;
            this.tb_password.Text = _password_destination;
        }
        
        private void lb_Drg_Loc_Click(object sender, EventArgs e)
        {
            DataGridViewAutoFilterColumnHeaderCell.RemoveFilter(this.dgrTaxOffice);
        }

        // Combo Box
        private void tabPage1_comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index;
            newIndexOfComboBox = this.tabPage1_comboBox1.SelectedIndex;
            index = newIndexOfComboBox;

            if (newIndexOfComboBox != oldIndexOfComboBox)
            {
                // reset value
                this.ckb_error.Checked = false;
                this.ckb_no.Checked = false;
                this.ckb_ps.Checked = false;
                this.ckb_tk.Checked = false;
                this.ckb_qct_no.Checked = false;
                this.ckb_qct_ps.Checked = false;
                this.ckb_qct_tk.Checked = false;
                this.ckb_qlt_no.Checked = false;
                this.ckb_qlt_ps.Checked = false;

                if (index == 0)
                {
                    this.ckb_error.Visible = false;
                    this.ckb_no.Visible = false;
                    this.ckb_ps.Visible = false;
                    this.ckb_tk.Visible = false;
                    this.ckb_qct_no.Visible = true;
                    this.ckb_qct_ps.Visible = true;
                    this.ckb_qct_tk.Visible = true;
                    this.ckb_qlt_no.Visible = true;
                    this.ckb_qlt_ps.Visible = true;
                }
                else if (index == 1)
                {
                    this.ckb_error.Visible = true;
                    this.ckb_no.Visible = false;
                    this.ckb_ps.Visible = false;
                    this.ckb_tk.Visible = false;
                    this.ckb_qct_no.Visible = true;
                    this.ckb_qct_ps.Visible = true;
                    this.ckb_qct_tk.Visible = true;
                    this.ckb_qlt_no.Visible = true;
                    this.ckb_qlt_ps.Visible = true;
                }
                else
                {
                    this.ckb_error.Visible = false;
                    this.ckb_no.Visible = true;
                    this.ckb_ps.Visible = true;
                    this.ckb_tk.Visible = true;
                    this.ckb_qct_no.Visible = false;
                    this.ckb_qct_ps.Visible = false;
                    this.ckb_qct_tk.Visible = false;
                    this.ckb_qlt_no.Visible = false;
                    this.ckb_qlt_ps.Visible = false;
                }
            }
            oldIndexOfComboBox = newIndexOfComboBox;
        }

        // Event Handle
        private void tabPage1_btu_th_Click(object sender, EventArgs e)
        {
            if (qlcd_backgroundWorker.IsBusy)
            {
                qlcd_backgroundWorker.CancelAsync();
            }
            else
            {
                // Hiển thị quy trình thực hiện
                this.tab_action.SelectedIndex = 2;
                qlcd_backgroundWorker.RunWorkerAsync();
            }
        }
        private void tab_action_TabIndexChanged(object sender, EventArgs e)
        {
            MessageBox.Show("Tab index changed");
        }       

        private void tab_action_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.tab_action.SelectedIndex == 1)
            {
                this.dgrTaxOffice.CurrentCellChanged -= new EventHandler(dgrTaxOffice_CurrentCellChanged);
                this.dgrTaxOffice.CurrentCellChanged += new EventHandler(dgrTaxOffice_CurrentCellChanged_VATWIN);
            }
            else
            {
                this.dgrTaxOffice.CurrentCellChanged -= new EventHandler(dgrTaxOffice_CurrentCellChanged_VATWIN);
                this.dgrTaxOffice.CurrentCellChanged += new EventHandler(dgrTaxOffice_CurrentCellChanged);
            }
        }

        #region [VATWIN]
        // Thực hiện copy file dữ liệu VATWIN về máy trạm
        private void btn_vatwin_thuc_hien_Click(object sender, EventArgs e)
        {   
            // Lấy thông tin của các cơ quan thuế đã chọn trên bảng thông tin
            ArrayList _rowIndex = new ArrayList();
            for (int i = 0; i < this.dgrTaxOffice.SelectedCells.Count; i++)
            {
                if (_rowIndex.Contains(this.dgrTaxOffice.SelectedCells[i].RowIndex) == false)
                    _rowIndex.Add(this.dgrTaxOffice.SelectedCells[i].RowIndex);
            }            
            
            this.tab_action.SelectedIndex = 2;

            //Thread[] threads = new Thread[_rowIndex.Count];
            foreach (object _obj in _rowIndex)
            {
                try
                {
                    int _index = (int)_obj;
                    Thread _copy_file_thread = new Thread(() =>
                    {

                        AddToListView(2, "Tiến hành việc copy file VATWIN của " + this.dgrTaxOffice.Rows[_index].Cells["cl_tax_name"].Value.ToString().Trim());
                        // Đăng nhập vào các máy trạm
                        Prc_Logon_Computer(_index);

                        // Chuyển các file trong thư mục cũ sang thư mục BK tương ứng.
                        Prc_Remove_Existed_File(_index);

                        // Chuyển các file từ máy của các cơ quan thuế về máy trạm
                        Prc_Copy_To_Destination_Machine(_index);

                        // Hoàn thành
                        AddToListView(2, "Hoàn thành việc copy file VATWIN của " + this.dgrTaxOffice.Rows[_index].Cells["cl_tax_name"].Value.ToString().Trim());
                    });
                    _copy_file_thread.Start();
                }                
                catch (Exception ex)
                {
                    AddToListView(0, ex.Message);
                }
            }
            _rowIndex.Clear();
            _rowIndex = null;
        }

        // Thực hiện đọc file dữ liệu VATWIN vào cơ sở dữ liệu
        private void btn_doc_file_Click(object sender, EventArgs e)
        {
            // Lấy thông tin của các cơ quan thuế đã chọn trên bảng thông tin
            ArrayList _rowIndex = new ArrayList();
            for (int i = 0; i < this.dgrTaxOffice.SelectedCells.Count; i++)
            {
                if (_rowIndex.Contains(this.dgrTaxOffice.SelectedCells[i].RowIndex) == false)
                    _rowIndex.Add(this.dgrTaxOffice.SelectedCells[i].RowIndex);
            }

            tab_action.SelectedIndex = 2;

            foreach (object _obj in _rowIndex)
            {
                try
                {
                    // Biến lưu chỉ số dòng của cơ quan thuế
                    int _index = (int)_obj;
                    Thread _read_vatwin_thread = new Thread(() =>
                    {
                        // Xác định thông tin của cơ quan thuế
                        // Tên viết tắt của cơ quan thuế
                        string _short_name = this.dgrTaxOffice.Rows[_index].Cells["cl_short_name"].Value.ToString().Trim();
                        string _tax_name = this.dgrTaxOffice.Rows[_index].Cells["cl_tax_name"].Value.ToString().Trim();
                        string _tax_code = this.dgrTaxOffice.Rows[_index].Cells["cl_tax_code"].Value.ToString().Trim();

                        DateTime _ky_ps_tu, _ky_ps_den; // Biến lưu trữ kỳ chốt dữ liệu phát sinh
                        DateTime _ky_no_tu, _ky_no_den; // Biến lưu trữ kỳ chốt dữ liệu nợ
                        DateTime _ky_ps10_tu, _ky_ps10_den; // Biến lưu trữ kỳ chốt dữ liệu phát sinh tờ khai 10
                        DateTime _ky_tk10_tu, _ky_tk10_den; // Biến lưu trữ kỳ chốt dữ liệu tờ khai 10

                        // Xác định thời điểm lấy dữ liệu phát sinh
                        _ky_ps_tu = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_ps_tu"].Value;
                        _ky_ps_den = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_ps_den"].Value;

                        // Xác định thời điểm lấy dữ liệu nợ
                        _ky_no_tu = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_no_tu"].Value;
                        _ky_no_den = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_no_den"].Value;

                        // Xác định thời điểm lấy dữ liệu phát sinh tờ khai 10
                        _ky_ps10_tu = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_ps10_tu"].Value;
                        _ky_ps10_den = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_ps10_den"].Value;

                        // Xác định thời điểm lấy dữ liệu tờ khai 10
                        _ky_tk10_tu = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_tk10_tu"].Value;
                        _ky_tk10_den = (DateTime)this.dgrTaxOffice.Rows[_index].Cells["cl_ky_tk10_den"].Value;

                        // Xác định cấu hình máy nguồn
                        string _path = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim().Replace("\\", "\\\\");
                        string _user = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_user"].Value.ToString().Trim();
                        string _password = this.dgrTaxOffice.Rows[_index].Cells["cl_vat_pass"].Value.ToString().Trim();

                        // Đăng nhập vào máy chứa file dữ liệu
                        Prc_Logon_Computer(_index);

                        DirectoryInfo _dir_source = new DirectoryInfo(_path);
                        if (this.ckb_doc_file_ps.Checked)
                        {
                            #region Phát sinh
                            Thread _read_ps_thread = new Thread(() =>
                            {
                                #region Xóa dữ liệu cũ trên bảng TB_PS
                                Prc_xoa_du_lieu_ps_cu(_short_name, _tax_name);
                                #endregion

                                #region Phát sinh tháng
                                Thread _read_tz_thread = new Thread(() =>
                                {
                                    Prc_doc_file_ps_thang(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_tz_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Phát sinh tháng: " + ex.Message);
                                }
                                #endregion

                                #region Phát sinh quý
                                // Xoá danh sách các file cũ
                                //_listFile.Clear();
                                // Đọc file CNTKYYYY.DBF
                                Thread _read_cntk_thread = new Thread(() =>
                                {
                                    Prc_doc_file_ps_quy(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_cntk_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Phát sinh quý: " + ex.Message);
                                }
                                #endregion

                                #region Tờ khai 10/KK-TNCN
                                Thread _read_p10_thread = new Thread(() =>
                                {
                                    Prc_doc_file_p10(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_p10_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Dữ liệu tờ khai 10/KK-TNCN: " + ex.Message);
                                }
                                #endregion

                                #region Tờ khai 10A/KK-TNCN
                                Thread _read_p10a_thread = new Thread(() =>
                                {
                                    // Đọc file P10AYYYY.DBF
                                    Prc_doc_file_p10a(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_p10a_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: " + ex.Message);
                                }
                                #endregion

                                #region Số dư phát sinh đầu kỳ
                                Thread _read_sdps_thread = new Thread(() =>
                                {
                                    // Xóa danh sách file cũ
                                    //_listFile.Clear();
                                    // Đọc file SDPSYYYY.DBF
                                    Prc_doc_file_sdps(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_sdps_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: " + ex.Message);
                                }
                                #endregion

                                #region Quyết định ấn định, bãi bỏ ấn định

                                Thread _read_qdad_thread = new Thread(() =>
                                {
                                    // Đọc file QDADYYYY.DBF
                                    Prc_doc_file_qdad(_short_name, _tax_name, _tax_code, ref _ky_ps_tu, ref _ky_ps_den, _path, _dir_source);
                                });
                                try
                                {
                                    _read_qdad_thread.Start();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, _tax_name + "\\Dữ liệu quyết định ấn định: " + ex.Message);
                                }
                                #endregion
                            });
                            try
                            {
                                _read_ps_thread.Start();
                            }
                            catch (Exception ex)
                            {
                                AddToListView(0, _tax_name + "\\Phát sinh: " + ex.Message);
                            }
                            #endregion
                        }

                        if (this.ckb_doc_file_no.Checked)
                        {
                            #region Nợ
                            Thread _read_no_thread = new Thread(() =>
                            {
                                // Xóa dữ liệu nợ cũ
                                Prc_xoa_du_lieu_no_cu(_short_name, _tax_name);
                                // Đọc file NOYYYY.DBF
                                Prc_doc_file_no(_short_name, _tax_name, _tax_code, ref _ky_no_den, _path, _dir_source);
                            });
                            try
                            {
                                _read_no_thread.Start();
                            }
                            catch (Exception ex)
                            {
                                AddToListView(0, _tax_name + "\\Nợ: " + ex.Message);
                            }
                            #endregion
                        }

                        if (this.ckb_doc_file_tk.Checked)
                        {
                            #region Tờ khai 10/KK-TNCN
                            Thread _read_tk10_thread = new Thread(() =>
                            {
                                // Xóa dữ liệu tờ khai 10/KK-TNCN cũ
                                Prc_xoa_du_lieu_tk_cu(_short_name, _tax_name);
                                // Đọc dữ liệu tờ khai 10/KK-TNCN
                                Prc_doc_file_tk10(_short_name, _tax_name, _tax_code, _path, _dir_source, _ky_tk10_tu, _ky_tk10_den);
                            });
                            try
                            {
                                _read_tk10_thread.Start();
                            }
                            catch (Exception ex)
                            {
                                AddToListView(0, _tax_name + "\\Tờ khai 10/KK-TNCN: " + ex.Message);
                            }
                            #endregion
                        }                            
                    });
                    try
                    {
                        _read_vatwin_thread.Start();
                    }
                    catch (Exception ex)
                    {
                        AddToListView(0, ex.Message);
                    }
                }
                catch (FormatException ex)
                {
                    AddToListView(0, ex.Message);
                }
                catch (Exception ex)
                {
                    AddToListView(0, ex.Message);
                }
            }        
        }

        // Thực hiện thay đổi cấu hình máy trạm, máy nguồn (domain, user, password)
        private void btn_vatwin_sua_Click(object sender, EventArgs e)
        {
            if (this.btn_vatwin_sua.Text.Equals("Sửa"))
            {
                this.btn_vatwin_sua.Text = "Lưu";
                // Máy nguồn
                this.tb_path_source.ReadOnly = false;
                this.tb_user_source.ReadOnly = false;
                this.tb_password_source.ReadOnly = false;

                // Máy đích
                this.tb_path_destination.ReadOnly = false;
                this.tb_user_destination.ReadOnly = false;
                this.tb_password_destination.ReadOnly = false;
            }
            else
            {
                this.btn_vatwin_sua.Text = "Sửa";
                // Máy nguồn
                this.tb_path_source.ReadOnly = true;
                this.tb_user_source.ReadOnly = true;
                this.tb_password_source.ReadOnly = true;

                // Máy đích
                this.tb_path_destination.ReadOnly = true;
                this.tb_user_destination.ReadOnly = true;
                this.tb_password_destination.ReadOnly = true;                
            }
        }

        private void btn_vatwin_sua_2_Click(object sender, EventArgs e)
        {
            if (this.btn_vatwin_sua_2.Text.Equals("Sửa"))
            {
                this.btn_vatwin_sua_2.Text = "Lưu";
                this.tb_folder.ReadOnly = false;
                this.tb_user.ReadOnly = false;
                this.tb_password.ReadOnly = false;
            }
            else
            {
                this.btn_vatwin_sua_2.Text = "Sửa";
                this.tb_folder.ReadOnly = true;
                this.tb_user.ReadOnly = true;
                this.tb_password.ReadOnly = true;
            }
        }

        #endregion

    #endregion

        delegate void prc_thuc_hien_delegate();
        private void Prc_thuc_hien()
        {
            if (this.tabPage1_comboBox1.InvokeRequired)
            {
                // Khai báo delegate
                prc_thuc_hien_delegate del = new prc_thuc_hien_delegate(Prc_thuc_hien);
                this.tabPage1_comboBox1.Invoke(del);
            }
            else
            {
                ArrayList _rowIndex = new ArrayList();
                for (int i = 0; i < this.dgrTaxOffice.SelectedCells.Count; i++)
                {
                    if (_rowIndex.Contains(this.dgrTaxOffice.SelectedCells[i].RowIndex) == false)
                        _rowIndex.Add(this.dgrTaxOffice.SelectedCells[i].RowIndex);
                }
  
                foreach(object _obj in _rowIndex)
                {
                    try
                    {
                        // Biến lưu trữ row index của CQT
                        int _index = (int)_obj;                        
                        // Biến lưu tên viết tắt của CQT
                        string _short_name 
                            = this.dgrTaxOffice.Rows[_index].Cells["cl_short_name"].Value.ToString().Trim();
                        // Biến lưu trữ tên của CQT
                        string _tax_name 
                            = this.dgrTaxOffice.Rows[_index].Cells["cl_tax_name"].Value.ToString().Trim();
                        // Biến lưu loại hình của CQT
                        string _tax_model 
                            = this.dgrTaxOffice.Rows[_index].Cells["cl_tax_model"].Value.ToString().Trim();
                        
                        AddToListView(2, _tax_name);
                        try
                        {
                            #region Môi trường
                            if (this.ckb_ktao.Checked)
                            {
                                // Khởi tạo môi trường
                                khoiTaoMoiTruong(_index, _short_name);
                            }
                            else if (this.ckb_ddep.Checked)
                            {
                                // Dọn dẹp môi trường
                                donDepMoiTruong(_index, _short_name);
                            }
                            #endregion

                            #region Tổng hợp dữ liệu nợ, phát sinh, tờ khai 10
                            if (this.tabPage1_comboBox1.SelectedValue.ToString() == "TH")
                            {
                                // Cục thuế
                                if (_tax_model == "QLT")
                                {
                                    // Tổng hợp dữ liệu phát sinh
                                    if (this.ckb_qlt_ps.Checked)
                                        TKTQ_PCK_ORA.Prc_QLT_QltPs(_short_name);
                                    // Tổng hợp dữ liệu nợ
                                    if (this.ckb_qlt_no.Checked)
                                        TKTQ_PCK_ORA.Prc_QLT_QltNo(_short_name);
                                }
                                // Chi cục thuế
                                else if (_tax_model == "QCT")
                                {                        // 
                                    if (this.ckb_qlt_ps.Checked)
                                        TKTQ_PCK_ORA.Prc_QCT_QltPs(_short_name);

                                    if (this.ckb_qlt_no.Checked)
                                        TKTQ_PCK_ORA.Prc_QCT_QltNo(_short_name);

                                    if (this.ckb_qct_ps.Checked)
                                        TKTQ_PCK_ORA.Prc_QCT_QctPs(_short_name);

                                    if (this.ckb_qct_no.Checked)
                                        TKTQ_PCK_ORA.Prc_QCT_QctNo(_short_name);

                                    if (this.ckb_qct_tk.Checked)
                                        TKTQ_PCK_ORA.Prc_QCT_QctTk(_short_name);
                                }
                            }
                            #endregion

                            #region Chuyển dữ liệu tổng hợp về database DPPIT
                            else if (this.tabPage1_comboBox1.SelectedValue.ToString() == "CV")
                            {
                                if (this.ckb_qlt_ps.Checked)
                                    TKTQ_PCK_ORA.Prc_QCT_GetQltPs(_short_name);

                                if (this.ckb_qlt_no.Checked)
                                    TKTQ_PCK_ORA.Prc_QCT_GetQltNo(_short_name);

                                if (this.ckb_qct_ps.Checked)
                                    TKTQ_PCK_ORA.Prc_QCT_GetQctPs(_short_name);

                                if (this.ckb_qct_no.Checked)
                                    TKTQ_PCK_ORA.Prc_QCT_GetQctNo(_short_name);

                                if (this.ckb_qct_tk.Checked)                                
                                    TKTQ_PCK_ORA.Prc_QCT_GetQctTk(_short_name);

                                if (this.ckb_error.Checked)
                                    TKTQ_PCK_ORA.Prc_QLTQCT_GetLog(_short_name);
                            }
                            #endregion

                            #region Kiểm tra dữ liệu nợ, phát sinh, tờ khai khoán 10
                            else
                            {
                                // SAP Connection
                                InMemoryDestinationConfiguration v_DestConfig = new InMemoryDestinationConfiguration();
                                try
                                {                                    
                                    RfcDestinationManager.RegisterDestinationConfiguration(v_DestConfig);
                                    v_DestConfig.AddOrEditDestination("DE1", 1, "thanhnh5", "12345a@", "EN", "280", "10.15.119.18", "23");
                                    RfcDestination v_sap = RfcDestinationManager.GetDestination("DE1");

                                    // Kiểm tra dữ liệu nợ
                                    if (this.ckb_no.Checked)
                                    {
                                        AddToListView(2, "   + Kiểm tra dữ liệu nợ");
                                        this.Prc_ktra_du_lieu(_short_name, v_sap, "TB_NO");
                                    }

                                    // Kiểm tra dữ liệu phát sinh
                                    if (this.ckb_ps.Checked)
                                    {
                                        AddToListView(2, "   + Kiểm tra dữ liệu phát sinh");
                                        this.Prc_ktra_du_lieu(_short_name, v_sap, "TB_PS");
                                    }

                                    // Kiểm tra dữ liệu tờ khai 10
                                    if (this.ckb_tk.Checked)
                                    {
                                        AddToListView(2, "   + Kiểm tra dữ liệu phát sinh");
                                        this.Prc_ktra_du_lieu(_short_name, v_sap, "TB_TK");
                                    }
                                }
                                catch (Exception e)
                                {
                                    AddToListView(0, "   + " + e.Message);
                                }
                                finally
                                {
                                    // Ngắt kết nối tới hệ thống SAP
                                    RfcDestinationManager.UnregisterDestinationConfiguration(v_DestConfig);
                                    v_DestConfig.RemoveDestination("DE1");
                                }
                            }
                            #endregion
                        }

                        catch (InvalidOperationException e)
                        {
                            AddToListView(0, "   + " + e.Message.ToString());
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, "   + " + e.Message.ToString());
                        }
                    }
                    catch (FormatException e)
                    {
                        AddToListView(0, e.Message);
                    }
                    catch (Exception e)
                    {
                        AddToListView(0, e.Message);
                    }

                }
            }

        }

        private void Prc_ktra_du_lieu(string p_short_name,  RfcDestination p_sap, string p_table_name)
        {
            string _query = @"SELECT rowid, a.* 
                                            FROM " + p_table_name + @" a 
                                           WHERE short_name = '" + p_short_name + "'";
            DataTable _dt = _ora.exeQuery(_query);
            int _so_ban_ghi_loi = 0;
            string v_error_code = ""; // Biến lưu chuỗi mã lỗi
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                DataRow _dr = _dt.Rows[i];
                if (p_table_name.Equals("TB_NO"))
                {
                    //TKTQ_PCK_ORA.prc_ktra_du_lieu_no(p_short_name);
                    v_error_code = TKTQ_CHECK_DATA.Prc_check_data_no(p_short_name, _dr, p_sap);
                }
                else if (p_table_name.Equals("TB_PS"))
                {
                    //TKTQ_PCK_ORA.prc_ktra_du_lieu_ps(p_short_name);
                    v_error_code = TKTQ_CHECK_DATA.Prc_check_data_ps(p_short_name, _dr, p_sap);
                }
                else
                {
                    v_error_code = TKTQ_CHECK_DATA.Prc_check_data_tk10(p_short_name, _dr, p_sap);
                }

                string[] v_err_id = v_error_code.Split('-');
                if (v_err_id.Length > 0)
                {
                    _so_ban_ghi_loi++;

                    foreach (string err_id in v_err_id)
                    {
                        if (err_id.Equals("") == false)
                        {
                            CLS_DATA_ERROR _error = new CLS_DATA_ERROR(p_short_name, _dr["ROWID"].ToString(), p_table_name, err_id, "");

                            _query = @"INSERT INTO tb_data_error(short_name, rid, table_name, err_id, field_name)
                                                    VALUES ('" + _error.short_name + "', '"
                                                       + _error.rid + "', '"
                                                       + _error.table_name + "', '"
                                                       + _error.err_id + "', null)";
                            _ora.exeUpdate(_query);
                        }
                    }
                }
            }
            AddToListView(2, "   + Hoàn thành việc kiểm tra dữ liệu");
        }

        //private delegate void addToListViewDelegate(int iconIndex, string message);
        public void AddToListView(int iconIndex, string message)
        {            
            Monitor.Enter(this);
            try
            {
                ListViewItem item = new ListViewItem();
                item.SubItems.Add((tabPage3_listView2.Items.Count + 1).ToString());
                item.ImageIndex = iconIndex;
                item.SubItems.Add(message);
                item.SubItems.Add(DateTime.Now.ToString());
                tabPage3_listView2.Invoke((Action)(() =>
                {
                    tabPage3_listView2.BeginUpdate();
                    tabPage3_listView2.Items.Add(item);
                    tabPage3_listView2.EndUpdate();
                }));
                var items = this.tabPage3_listView2.Items;
                var last = items[items.Count - 1];
                last.EnsureVisible();
            }
            catch
            {

            }
            finally
            {
                Monitor.Exit(this);
            }
        }



        #region Background Worker        

        private void qlcd_backgroundWorker_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            Prc_thuc_hien();

        }

        private void qlcd_backgroundWorker_ProgressChanged(object sender, System.ComponentModel.ProgressChangedEventArgs e)
        {
            MessageBox.Show("Progress Changed");
        }

        private void qlcd_backgroundWorker_RunWorkerCompleted(object sender, System.ComponentModel.RunWorkerCompletedEventArgs e)
        {
            this.dgrTaxOffice.DataSource = null;
            Prc_Fill_Dgr();
            this.dgrTaxOffice.DataSource = this.bndSource;
            this.dgrTaxOffice.Refresh();
            Prc_ktra_trang_thai(this.dgrTaxOffice.CurrentRow.Index);
            AddToListView(2, "Completed");
        }
        #endregion

        // Khởi tạo môi trường        
        private void khoiTaoMoiTruong(int p_index, string p_short_name)
        {            
            try
            {
                // Biến lưu trữ trạng thái môi trường của CQT
                int _status 
                    = Int32.Parse(this.dgrTaxOffice.Rows[p_index].Cells["cl_status"].Value.ToString().Trim());
                if (_status == 0 || _status == 99)
                {
                    try
                    {
                        AddToListView(2, "   + Đang khởi tạo môi trường!");
                        TKTQ_PCK_ORA.Prc_QLTQCT_KhoiTao_MoiTruong(p_short_name, this);
                        AddToListView(2, "   + Khởi tạo môi trường thành công.");
                    }
                    catch (Exception e)
                    {
                        AddToListView(0, "   + " + e.Message);
                    }
                }
                else
                {
                    AddToListView(0, "   + Không thể thực hiện được khởi tạo");
                }
            }
            catch (FormatException e)
            {
                AddToListView(0, e.Message);
            }
            catch (Exception e)
            {
                AddToListView(0, e.Message);
            }              
        }
        

        // Dọn dẹp môi trường        
        private void donDepMoiTruong(int p_index, string p_short_name)
        {
            try
            {
                // Biến lưu trữ trạng thái môi trường của CQT
                int _status
                    = Int32.Parse(this.dgrTaxOffice.Rows[p_index].Cells["cl_status"].Value.ToString().Trim());
                if (_status == 0 || _status == 99)
                {
                    AddToListView(0, "   + Môi trường chưa được khởi tạo hoặc đã được dọn dẹp trước đó.");
                }
                else
                {
                    try
                    {
                        AddToListView(2, "   + Đang dọn dẹp môi trường...");
                        TKTQ_PCK_ORA.Prc_QLTQCT_DonDep_MoiTruong(p_short_name, this);
                        AddToListView(2, "   + Dọn dẹp môi trường thành công.");
                    }
                    catch (Exception e)
                    {
                        AddToListView(0, "   + " + e.Message);
                    }
                }
            }
            catch (FormatException e)
            {
                AddToListView(0, e.Message);
            }
            catch (Exception e)
            {
                AddToListView(0, e.Message);
            }
        }       

        // Kết xuất
        private void ketXuat(string v_short_name)
        {
            string v_path_open = CLS_FILE.Fnc_Get_Current_Folder() + @"\_LIB\TEMPLATE\TEMP_QLT_BienBanDoiChieu_v2.0.doc";
            if (this.ckb_kxu_bban.Checked)
                TKTQ_EXTRACT.Prc_BienBan(v_path_open,
                                         @"E:\PIT_DIR\PHY\PHY\PHY_BienBanLan01_111021.doc",
                                         v_short_name,
                                         "SELECT ten_tkhai, sotien FROM vw_qlt_ps_bc ORDER BY ten_tkhai",
                                         "SELECT tmt_ma_tmuc, sotien FROM vw_qlt_no_bc WHERE loai='CD' ORDER BY tmt_ma_tmuc",
                                         "SELECT tmt_ma_tmuc, sotien FROM vw_qlt_no_bc WHERE loai='NT' ORDER BY tmt_ma_tmuc",
                                         "SELCET 1 FROM dual WHERE 1=2",
                                         "SELCET 1 FROM dual WHERE 1=2",
                                         "SELCET 1 FROM dual WHERE 1=2",
                                         "SELECT so_luong, doanh_thu, pbq1, pbq2, pbq3, pbq4 FROM vw_qct_tk_bc");
        }

        // Kiểm tra trạng thái của mỗi cơ quan thuế
        public void Prc_ktra_trang_thai(int p_index)
        {            
            this.ckb_ktao.Checked = false;
            this.ckb_ddep.Checked = false;
            int _status = Int32.Parse(this.dgrTaxOffice.Rows[p_index].Cells["cl_status"].Value.ToString());
            if (_status == 1)
            {
                this.ckb_ktao.Enabled = false;
                this.ckb_ddep.Enabled = true;
            }
            else
            {
                this.ckb_ktao.Enabled = true;
                this.ckb_ddep.Enabled = false;
            }
        }

        #region [VATWIN]

        #region [VATWIN]Đăng nhập vào các máy trạm
        private void Prc_Logon_Computer(int p_index)
        {
            // Biến lưu thông tin cấu hình máy nguồn
            string _path_source, _user_source, _password_source;
            // Biến lưu thông tin cấu hình máy đích
            string _path_destination, _user_destination, _password_destination;

            // Xác định cấu hình máy nguồn
            _path_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_tu"].Value.ToString().Trim();
            _user_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_user"].Value.ToString().Trim();
            _password_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_pass"].Value.ToString().Trim();

            // Đăng nhập vào máy nguồn
            Impersonation _imp_source = new Impersonation(_user_source, _path_source, _password_source);
            //NetworkCredential _source_cred = new NetworkCredential(_user_source, _path_source, _password_source);            

            // Xác định cấu hình máy đích
            _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString();            
            _user_destination = "dci";
            _password_destination = "1209";

            // Đăng nhập vào máy đích
            Impersonation _imp_destination = new Impersonation(_user_destination, _path_destination, _password_destination);
            //NetworkCredential _destination_cred = new NetworkCredential(_user_destination, _path_destination, _password_destination);
        }
        #endregion

        #region [VATWIN] Copy file VATWIN

        #region Chuyển các file trong thư mục cũ sang thư mục BK tương ứng.
        private void Prc_Remove_Existed_File(int p_index)
        {
            try
            {
                string _path_destination;

                // Xác định cấu hình máy đích
                _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim();

                //_imp.Revert();
                // Xác định thư mục chưa dữ liệu
                DirectoryInfo _dir_source = new DirectoryInfo(_path_destination);
                DirectoryInfo _dir_target = new DirectoryInfo(_path_destination + "\\BK");
                CLS_FILE.Prc_Move_Bk(_dir_source, _dir_target);
            }
            catch (Exception e)
            {
                AddToListView(0, e.Message);
            }
        }
        #endregion

        #region Copy file về máy đích

        private void Prc_Copy_To_Destination_Machine(int p_index)
        {
            string _path_source;
            string _path_destination;
            
            DateTime _ky_psinh_tu, _ky_psinh_den; // Biến lưu trữ kỳ chốt dữ liệu phát sinh
            DateTime _ky_no_tu, _ky_no_den; // Biến lưu trữ kỳ chốt dữ liệu nợ
            DateTime _ky_ps10_tu, _ky_ps10_den; // Biến lưu trữ kỳ chốt dữ liệu phát sinh tờ khai 10
            DateTime _ky_tk10_tu, _ky_tk10_den; // Biến lưu trữ kỳ chốt dữ liệu tờ khai 10
            
            // Xác định thời điểm lấy dữ liệu phát sinh
            _ky_psinh_tu = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_ps_tu"].Value;
            _ky_psinh_den = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_ps_den"].Value;            

            // Xác định thời điểm lấy dữ liệu nợ
            _ky_no_tu = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_no_tu"].Value;
            _ky_no_den = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_no_den"].Value;

            // Xác định thời điểm lấy dữ liệu phát sinh tờ khai 10
            _ky_ps10_tu = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_ps10_tu"].Value;
            _ky_ps10_den = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_ps10_den"].Value;

            // Xác định thời điểm lấy dữ liệu tờ khai 10
            _ky_tk10_tu = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_tk10_tu"].Value;
            _ky_tk10_den = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_tk10_den"].Value;

            // Xác định cấu hình máy nguồn
            _path_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_tu"].Value.ToString().Trim();

            // Xác định cấu hình máy đích
            _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim();

            // Xác định thư mục chứa dữ liệu
            DirectoryInfo _dir_destination = new DirectoryInfo(_path_destination);

            // Xác định tên của cơ quan thuế
            string _tax_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_tax_name"].Value.ToString().Trim();           
            

            // Sao chép file dữ liệu phát sinh về máy trạm
            if (this.ckb_file_ps_vatwin.Checked)
            {
                #region Phát sinh
                // Dữ liệu phát sinh
                
                #region Phát sinh quý
                Thread _copy_cntk_thread = new Thread(() =>
                {
                    Prc_copy_file_cntk(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);
                });
                try
                {
                    _copy_cntk_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #region Phát sinh tháng
                Thread _copy_tz_thread = new Thread(() =>
                {
                    Prc_copy_file_tz(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);
                });
                try
                {
                    _copy_tz_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #region Quyết định ấn định, bãi bỏ ấn định
                Thread _copy_qdad_thread = new Thread(() =>
                {
                    Prc_copy_file_qdad(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);                    
                });
                try
                {
                    _copy_qdad_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #region Số dư phát sinh đầu kỳ
                Thread _copy_sdps_thread = new Thread(() =>
                {
                    Prc_copy_file_sdps(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);                    
                });
                try
                {
                    _copy_sdps_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #region Tờ khai 10/KK-TNCN
                Thread _copy_p10_thread = new Thread(() =>
                {
                    Prc_copy_file_p10(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);
                });
                try
                {
                    _copy_p10_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #region Tờ khai 10A/KK-TNCN
                Thread _copy_p10a_thread = new Thread(() =>
                {
                    Prc_copy_file_p10a(_path_source, _ky_psinh_tu, _ky_psinh_den, _dir_destination, _tax_name);
                });
                try
                {
                    _copy_p10a_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion

                #endregion
            }
            if (ckb_file_no_vatwin.Checked)
            {
                #region Điều chỉnh nợ                
                // Dữ liệu nợ               
                Thread _copy_no_thread = new Thread(() =>
                {
                    Prc_copy_file_no(_path_source, _dir_destination, _ky_no_tu, _ky_no_den, _tax_name);
                });
                try
                {
                    _copy_no_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion
            }
            if (ckb_file_tk_vatwin.Checked)
            {
                #region Tờ khai 10/KK-TNCN                
                // Dữ liệu tờ khai 10/KK-TNCN                
                Thread _copy_tk10_thread = new Thread(() =>
                {
                    Prc_copy_file_c10(_path_source, _dir_destination, _ky_tk10_tu, _ky_tk10_den, _tax_name);
                });
                try
                {
                    _copy_tk10_thread.Start();
                }
                catch (Exception e)
                {
                    AddToListView(0, e.Message);
                }
                #endregion
            }

            #region Danh bạ các đối tượng nộp thuế
            // Danh bạ các đối tượng nộp thuế
            Thread _copy_dtnt_thread = new Thread(() =>
            {
                Prc_copy_file_dtnt(_path_source, _dir_destination, _tax_name);
            });
            try
            {
                _copy_dtnt_thread.Start();
            }
            catch (Exception e)
            {
                AddToListView(0, e.Message);
            }
            #endregion

            #region Đại lý thuế
            // Danh bạ các đối tượng nộp thuế
            Thread _copy_dtnt_dlt_thread = new Thread(() =>
            {
                Prc_copy_file_dlt(_path_source, _dir_destination, _tax_name);                
            });
            try
            {
                _copy_dtnt_dlt_thread.Start();
            }
            catch (Exception e)
            {
                AddToListView(0, e.Message);
            }
            #endregion
        }

        // Copy file dữ liệu phát sinh quý CNTKYYYY.DBF
        private int Prc_copy_file_cntk(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file CNTK
            string _search_pattern = "CNTK*.DBF";

            // Danh sách các file
            ArrayList _listFile_cntk = new ArrayList();
            _listFile_cntk.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_cntk)
            {
                try
                {
                    if (Int32.Parse(p_ky_psinh_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(4, 4))
                        && Int32.Parse(p_ky_psinh_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(4, 4)))
                    {
                        _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                        _so_file++;
                    }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh quý: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh quý: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh quý: " + e.Message);
                }
            }
            _listFile_cntk.Clear();
            _listFile_cntk = null;
            return _so_file;
        }

        // Copy file dữ liệu phát sinh tháng TZMMYYYY.DBF
        private int Prc_copy_file_tz(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file TZMMYYYY.DBF
            string _search_pattern = "TZ*.DBF";
            ArrayList _listFile_tz = new ArrayList();
            _listFile_tz.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_tz)
            {
                try
                {
                    
                    int _temp_month = Int32.Parse(_file.Name.Substring(2, 2));
                    int _temp_year = Int32.Parse(_file.Name.Substring(4, 4));
                    DateTime _temp_date = new DateTime(_temp_year, _temp_month, 1);

                    if (_temp_date <= p_ky_psinh_den && _temp_date >= p_ky_psinh_tu)
                    {
                        _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                        _so_file++;
                    }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh tháng: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh tháng: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu phát sinh tháng: " + e.Message);
                }
            }
            _listFile_tz.Clear();
            _listFile_tz = null;
            return _so_file;
        }

        // Copy file dữ liệu quyết định ấn định, bãi bỏ ấn định
        private int Prc_copy_file_qdad(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file QDADYYYY.DBF
            string _search_pattern = "QDAD*.DBF";

            ArrayList _listFile_qdad = new ArrayList();
            _listFile_qdad.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_qdad)
            {
                try
                {
                    if (Int32.Parse(p_ky_psinh_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(4, 4))
                        && Int32.Parse(p_ky_psinh_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(4, 4)))
                    {
                        _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                        _so_file++;
                    }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu quyết định ấn định: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu quyết định ấn định: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu quyết định ấn định: " + e.Message);
                }
            }
            _listFile_qdad.Clear();
            _listFile_qdad = null;
            return _so_file;
        }

        // Copy file dữ liệu số dư phát sinh đầu kỳ
        private int Prc_copy_file_sdps(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file SDPSYYYY.DBF
            string _search_pattern = "SDPS*.DBF";
            ArrayList _listFile_sdps = new ArrayList();
            _listFile_sdps.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_sdps)
            {
                try
                {
                    if (Int32.Parse(p_ky_psinh_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(4, 4))
                        && Int32.Parse(p_ky_psinh_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(4, 4)))
                    {
                        _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                        _so_file++;
                    }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                }
            }
            _listFile_sdps.Clear();
            _listFile_sdps = null;

            return _so_file;
        }

        // Copy file dữ liệu tờ khai 10/KK-TNCN (phát sinh)
        private int Prc_copy_file_p10(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file P10YYYY.DBF
            string _search_pattern = "P10*.DBF";
            ArrayList _listFile_p10 = new ArrayList();
            _listFile_p10.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_p10)
            {
                try
                {
                    if (_file.Name.Length == 11)
                        if (Int32.Parse(p_ky_psinh_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(3, 4))
                        && Int32.Parse(p_ky_psinh_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(3, 4)))
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN (phát sinh): " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN (phát sinh): " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN (phát sinh): " + e.Message);
                }
            }
            _listFile_p10.Clear();
            _listFile_p10 = null;
            return _so_file;
        }

        // Copy file dữ liệu tờ khai 10A/KK-TNCN (phát sinh)
        private int Prc_copy_file_p10a(string p_path_source,
                                       DateTime p_ky_psinh_tu,
                                       DateTime p_ky_psinh_den,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file P10AYYYY.DBF
            string _search_pattern = "P10A*.DBF";
            ArrayList _listFile_p10a = new ArrayList();
            _listFile_p10a.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_p10a)
            {
                try
                {
                    if (Int32.Parse(p_ky_psinh_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(4, 4))
                        && Int32.Parse(p_ky_psinh_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(4, 4)))
                    {
                        _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                        _so_file++;
                    }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10A/KK-TNCN (phát sinh): " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10A/KK-TNCN (phát sinh): " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10A/KK-TNCN (phát sinh): " + e.Message);
                }
            }
            _listFile_p10a.Clear();
            _listFile_p10a = null;
            return _so_file;
        }


        // Copy file dữ liệu nợ NOYYYY.DBF
        private int Prc_copy_file_no(string p_path_source,
                                     DirectoryInfo p_dir_destination,
                                     DateTime p_ky_no_tu,
                                     DateTime p_ky_no_den,
                                     string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\SOTHUE";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file NOYYYY.DBF
            string _search_pattern = "NO*.DBF";
            ArrayList _listFile = new ArrayList();
            _listFile.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile)
            {
                try
                {
                    if (_file.Name.Length == 10)
/*                        if (Int32.Parse(p_ky_no_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(2, 4))
                            && Int32.Parse(p_ky_no_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(2, 4)))*/
                          if (Int32.Parse(p_ky_no_den.Year.ToString()) == Int32.Parse(_file.Name.Substring(2, 4)))
                    {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu nợ: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu nợ: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu nợ: " + e.Message);
                }
            }
            _listFile.Clear();
            _listFile = null;
            return _so_file;
        }

        // Copy file dữ liệu tờ khai 10/KK-TNCN C10YYYY.DBF
        private int Prc_copy_file_c10(string p_path_source,
                                      DirectoryInfo p_dir_destination,
                                      DateTime p_ky_tk10_tu,
                                      DateTime p_ky_tk10_den,
                                      string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;

            string _path_file = "\\TK_CT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);
            // Lấy file C10YYYY.DBF
            string _search_pattern = "C10*.DBF";
            ArrayList _listFile_tk10 = new ArrayList();
            _listFile_tk10.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_tk10)
            {
                try
                {
                    if (_file.Name.Length == 11)
                        if (Int32.Parse(p_ky_tk10_tu.Year.ToString()) <= Int32.Parse(_file.Name.Substring(3, 4))
                            && Int32.Parse(p_ky_tk10_den.Year.ToString()) >= Int32.Parse(_file.Name.Substring(3, 4)))
                        {
                            _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                            _so_file++;
                        }
                }
                catch (FormatException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN: " + e.Message);
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy file dữ liệu tờ khai 10/KK-TNCN: " + e.Message);
                }
            }
            _listFile_tk10.Clear();
            _listFile_tk10 = null;
            return _so_file;
        }

        // Copy file danh bạ người nộp thuế
        private int Prc_copy_file_dtnt(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;
            string _path_file = "\\DTNT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

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
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy danh bạ người nộp thuế: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy danh bạ người nộp thuế: " + e.Message);
                }
            }
            _listFile_dtnt.Clear();
            _listFile_dtnt = null;
            return _so_file;
        }
        
        // Copy file danh bạ đại lý thuế
        private int Prc_copy_file_dlt(string p_path_source,
                                       DirectoryInfo p_dir_destination,
                                       string p_tax_name)
        {
            // Biến lưu trữ số file đã copy về máy
            int _so_file = 0;
            string _path_file = "\\DTNT";
            DirectoryInfo _dir_source = new DirectoryInfo(p_path_source + _path_file);

            ArrayList _listFile_dlt = new ArrayList();
            // Lấy file DTNT_DLT.DBF
            string _search_pattern = "DTNT_DLT.DBF";
            _listFile_dlt.AddRange(_dir_source.GetFiles(_search_pattern));
            foreach (FileInfo _file in _listFile_dlt)
            {
                try
                {
                    _file.CopyTo(Path.Combine(p_dir_destination.FullName, _file.Name));
                    _so_file++;
                }
                catch (FileNotFoundException e)
                {
                    AddToListView(0, p_tax_name + "\\Copy danh bạ đại lý thuế: " + e.Message);
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Copy danh bạ đại lý thuế: " + e.Message);
                }
            }
            _listFile_dlt.Clear();
            _listFile_dlt = null;
            return _so_file;
        }
        #endregion       

        #endregion

        #region [VATWIN] Đọc file dữ liệu        

        #region Xóa dữ liệu cũ trên cơ sở dữ liệu Oracle

        #region TB_PS
        private void Prc_xoa_du_lieu_ps_cu(string p_short_name, string p_tax_name)
        {
            try
            {
                using (CLS_DBASE.ORA _ora_ps = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
                {
                    string _query = @"DELETE FROM tb_ps
                                            WHERE short_name = '" + p_short_name + @"'
                                              AND tax_model = 'VAT_APP'";
                    int _rowsnum = _ora_ps.exeUpdate(_query);
                    AddToListView(2, "Đã xóa " + _rowsnum + " bản ghi trong bảng TB_PS của " + p_tax_name);
                }
            }
            catch (Exception e)
            {
                AddToListView(0, p_tax_name + "\\Xóa dữ liệu cũ: " + e.Message);
            }
        }
        #endregion

        #region TB_NO
        private void Prc_xoa_du_lieu_no_cu(string p_short_name, string p_tax_name)
        {
            try
            {
                using (CLS_DBASE.ORA _ora_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
                {
                    string _query = @"DELETE FROM tb_no
                                               WHERE short_name = '" + p_short_name + @"'
                                                 AND tax_model = 'VAT_APP'";
                    int _rowsnum = _ora_no.exeUpdate(_query);
                    AddToListView(2, "Đã xóa " + _rowsnum + " bản ghi trong bảng TB_NO của " + p_tax_name);
                }
            }
            catch (Exception e)
            {
                AddToListView(0, p_tax_name + "\\Xóa dữ liệu cũ: " + e.Message);
            }
        }
        #endregion

        #region TB_TK
        private void Prc_xoa_du_lieu_tk_cu(string p_short_name, string p_tax_name)
        {
            try
            {
                using (CLS_DBASE.ORA _ora_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
                {
                    string _query = @"DELETE FROM tb_tk
                                               WHERE short_name = '" + p_short_name + @"'
                                                 AND tax_model = 'VAT_APP'";
                    int _rowsnum = _ora_no.exeUpdate(_query);
                    AddToListView(2, "Đã xóa " + _rowsnum + " bản ghi trong bảng TB_TK của " + p_tax_name);
                }
            }
            catch (Exception e)
            {
                AddToListView(0, p_tax_name + "\\Xóa dữ liệu cũ: " + e.Message);
            }            
        }
        #endregion 

        #endregion

        #region Đọc dữ liệu
        // Dữ liệu phát sinh tháng
        private void Prc_doc_file_ps_thang(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string _path, DirectoryInfo p_dir_source)
        {
            // Đọc file TZMMYYYY.DBF
            string _search_pattern = "TZ*.DBF";
            // Đối tượng lưu trữ danh sách các file dữ liệu phát sinh tháng
            ArrayList _listFile_tz = new ArrayList();
            // Lấy danh sách các file dữ liệu phát sinh tháng
            _listFile_tz.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_tz = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành tải dữ liệu phát sinh tháng của " + p_tax_name);
            // Biến lưu số bản ghi dữ liệu phát sinh tháng
            // đã đọc vào bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_tz)
            {
                try
                {
                    string _query = @"SELECT a.madtnt as tin, a.matkhai as ma_tkhai,                                         
                                             a.ngnop as ngay_nop, a.matm as ma_tmuc, 
                                             a.hannop2 as han_nop, a.thuetky as so_tien, 
                                             ('01/'+a.KyKKhai) as ky_psinh_tu, 
                                             a.KyKKhai
                                        FROM {0} a,DTNT2.DBF b 
                                       WHERE a.madtnt = b.madtnt 
                                         AND a.MaMuc = '1000' 
                                         AND a.MaTKhai IN ('02T/KK-TNCN',
                                                           '03T/KK-TNCN',
                                                           '07/KK-TNCN') 
                                         AND a.ThueTKy2 <> 1 
                                         AND a.ThueTKy > 0";

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi                                                
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "");
                        // Xác định kỳ phát sinh của đối tượng nộp thuế
                        DateTime _ky_psinh_tu;
                        DateTime _ky_psinh_den;

                        try
                        {
                            _ky_psinh_tu =
                                new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den =
                                new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = _ky_psinh_den.AddMonths(1).AddDays(-1);
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh tháng: Kỳ kê khai sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh tháng: " + e.Message);
                            continue;
                        }

                        // Kiểm tra kỳ phát sinh nằm trong kỳ chốt dữ liệu
                        if (_ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0 || _ky_psinh_tu.CompareTo(p_ky_ps_den) > 0
                          || _ky_psinh_den.CompareTo(p_ky_ps_tu) < 0 || _ky_psinh_den.CompareTo(p_ky_ps_den) > 0)
                            continue;

                        _query = @"INSERT INTO tb_ps
                                               (short_name, stt, loai, ma_cqt, tin,
                                                ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                                tkhoan, ky_psinh_tu, ky_psinh_den,
                                                so_tien, han_nop, ngay_htoan, ngay_nop,
                                                tax_model, status, id)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', '{12}', '{13}', '{14}', 
                                                '{15}', '{16}', '{17}', {18})";

                        _stt++; // Bản ghi số mấy

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", _dr["ma_tkhai"].ToString().Trim());
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _dr["ky_psinh_tu"].ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", "");
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_tz.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Phát sinh tháng: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi dữ liệu phát sinh tháng vào bảng TB_PS của " + p_tax_name);
            _connOra_tz.close();
            _listFile_tz.Clear();
            _listFile_tz = null;
            AddToListView(2, "Hoàn thành tải dữ liệu phát sinh tháng cho " + p_tax_name);
        }

        //Dữ liệu phát sinh quý
        private void Prc_doc_file_ps_quy(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string p_path, DirectoryInfo p_dir_source)
        {
            // Đọc file CNTKYYYY.DBF
            string _search_pattern = "CNTK*.DBF";
            // Đối tượng lưu danh sách các file dữ liệu phát sinh quý
            ArrayList _listFile_cntk = new ArrayList();
            // Lấy danh sách các file dữ liệu phát sinh quý
            _listFile_cntk.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_cntk = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành tải dữ liệu phát sinh quý của " + p_tax_name);
            // Biến lưu số bản ghi dữ liệu phát sinh tháng
            // đã đọc vào bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_cntk)
            {
                try
                {
                    string _query = @"SELECT a.madtnt as tin,
                                             a.matkhai as ma_tkhai,
                                             a.matm as ma_tmuc,
                                             a.ngnop as ngay_nop,
                                             a.hannop2 as han_nop,
                                             a.thuetky as so_tien,
                                             a.KyKkhai, a.KyLbo
                                        FROM {0} a
                                       WHERE a.matkhai IN ('02Q/KK-TNCN',
                                                           '03Q/KK-TNCN',
                                                           '08/KK-TNCN',
                                                           '08A/KK-TNCN') 
                                         AND a.thuetky2 <> 1 
                                         AND a.thuetky > 0";

                    _query = _query.Replace("{0}", _file.Name.ToString());

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ lập bộ
                        string _temp = "";
                        _temp = _dr["kylbo"].ToString().Trim();
                        _temp = _temp.Replace("/", "");
                        try
                        {
                            // Kỳ lập bộ
                            DateTime _kylbo =
                                new DateTime(Int32.Parse(_temp.Substring(2, 4)), // Năm
                                             Int32.Parse(_temp.Substring(0, 2)), // Tháng
                                             1);                                 // Ngày

                            if (_kylbo.CompareTo(p_ky_ps_den) > 0
                                || _kylbo.CompareTo(p_ky_ps_tu) < 0)
                                continue;
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh quý: Kỳ lập bộ sai định dạng ngày tháng");
                        }
                        catch (Exception ex)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh quý: " + ex.Message);
                        }
                        #endregion

                        string _ky_kkhai = _dr["KyKKhai"].ToString().Trim().Replace("/", "");
                        string _ma_tkhai = _dr["ma_tkhai"].ToString().Trim();
                        string _ma_tmuc = _dr["ma_tmuc"].ToString().Trim();

                        #region Xác định mã tờ khai
                        // Xác định mã tờ khai
                        //if (_ma_tkhai.Equals("08/KK-TNCN") && _ma_tmuc.Equals("1014"))
                        //    _ma_tkhai = "08TN/KK-TNCN";
                        //else if (_ma_tkhai.Equals("08A/KK-TNCN") && _ma_tmuc.Equals("1014"))
                        //    _ma_tkhai = "08ATN/KK-TNCN";
                        #endregion

                        #region Xác định kỳ phát sinh
                        int _quy_ky_kkhai = 1; // Biến lưu trữ quý của kỳ kê khai
                        int _nam_ky_kkhai = 2010; // Biến lưu trữ năm của kỳ kê khai
                        try
                        {
                            _quy_ky_kkhai = Int32.Parse(_ky_kkhai.Trim().Substring(0, 1));
                            _nam_ky_kkhai = Int32.Parse(_ky_kkhai.Trim().Substring(1, 4));
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh quý: Kỳ kê khai sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Phát sinh quý: " + e.Message);
                            continue;
                        }

                        #region Xác định kỳ phát sinh dựa vào quý của kỳ kê khai
                        DateTime _ky_psinh_tu; // Ngày bắt đầu kỳ phát sinh
                        DateTime _ky_psinh_den; // Ngày kết thúc kỳ phát sinh

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
                            throw new InvalidDataException("Tháng của kỳ phát sinh không hợp lệ");
                        }

                        if (_ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_den) > 0)
                            continue;
                        #endregion
                        #endregion

                        _query = @"INSERT INTO tb_ps
                                               (short_name, stt, loai, ma_cqt, tin,
                                                ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                                tkhoan, ky_psinh_tu, ky_psinh_den,
                                                so_tien, han_nop, ngay_htoan, ngay_nop,
                                                tax_model, status, id)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', '{12}', '{13}', '{14}', 
                                                '{15}', '{16}', '{17}', {18})";

                        _stt++; // Bản ghi số mấy

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", _ma_tkhai);
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _ma_tmuc);
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_psinh_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_cntk.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Phát sinh quý: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi dữ liệu phát sinh quý vào bảng TB_PS của " + p_tax_name);
            _listFile_cntk.Clear();
            _listFile_cntk = null;
            _connOra_cntk.close();
            AddToListView(2, "Hoàn thành tải dữ liệu phát sinh quý của " + p_tax_name);
        }

        // Dữ liệu tờ khai 10/KK-TNCN
        private void Prc_doc_file_p10(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string p_path, DirectoryInfo p_dir_source)
        {
            // Đọc file P10YYYY.DBF
            string _search_pattern = "P10*.DBF";
            // Đối tượng lưu trữ danh sách file dữ liệu tờ khai 10/KK-TNCN
            ArrayList _listFile_p10 = new ArrayList();
            // Lấy danh sách các file dữ liệu tờ khai 10/KK-TNCN
            _listFile_p10.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_p10 = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành việc tải dữ liệu tờ khai 10/KK-TNCN của " + p_tax_name);
            // Biến lưu trữ số bản ghi đã được đọc vào
            // bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_p10)
            {
                try
                {
                    // Kiểm tra tên file
                    if (_file.Name.Length != 11)
                        continue;

                    string _query = @"SELECT a.kykkhai2,
                                             a.kylbo,
                                             a.madtnt as tin,
                                             a.matkhai as ma_tkhai,
                                             a.matm as ma_tmuc,
                                             a.ngnop as ngay_nop,
                                             a.hannop2 as han_nop,
                                             a.thuepn as so_tien
                                        FROM {0} a 
                                       WHERE a.matkhai = '10/KK-TNCN' 
                                         AND a.thuetky2 <> 1 and a.ThuePN > 0";

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Đối tượng lưu trữ các bản ghi
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ phát sinh và kỳ lập bộ nằm trong kỳ chốt dữ liệu

                        // Biến lưu trữ kỳ lập bộ lấy từ file dữ liệu
                        string _temp = _dr["kylbo"].ToString().Replace("/", "").Trim();
                        // Kỳ lập bộ
                        DateTime _kylbo;
                        try
                        {
                            _kylbo =
                               new DateTime(Int32.Parse(_temp.Substring(2, 4)), // Năm
                                            Int32.Parse(_temp.Substring(0, 2)), // Tháng
                                            1);                                 // Ngày
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10/KK-TNCN: Kỳ lập bộ không đúng định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10/KK-TNCN: " + e.Message);
                            continue;
                        }

                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu
                        string _ky_kkhai = _dr["KyKKhai2"].ToString().Replace("/", "").Trim();
                        // Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Ngày bắt đầu kỳ phát sinh
                        DateTime _ky_psinh_tu;
                        // Ngày kết thúc kỳ phát sinh
                        DateTime _ky_psinh_den;

                        try
                        { 
                            _ky_psinh_tu = new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = _ky_psinh_den.AddMonths(1).AddDays(-1);
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\ Dữ liệu tờ khai 10/KK-TNCN: Kỳ kê khai không đúng định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10/KK-TNCN: " + e.Message);
                            continue;
                        }


                        if ((_ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0) || (_ky_psinh_tu.CompareTo(p_ky_ps_den)) > 0
                            || (_kylbo.CompareTo(p_ky_ps_tu)) < 0 || (_kylbo.CompareTo(p_ky_ps_den) > 0))
                        {
                            continue;
                        }
                        #endregion

                        _stt++; // Bản ghi số mấy
                        _query = @"INSERT INTO tb_ps
                                           (short_name, stt, loai, ma_cqt, tin,
                                            ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                            tkhoan, ky_psinh_tu, ky_psinh_den,
                                            so_tien, han_nop, ngay_htoan, ngay_nop,
                                            tax_model, status, id)
                                    VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                            '{5}', '{6}', '{7}', '{8}', '{9}',
                                            '{10}', '{11}', '{12}', '{13}', '{14}', 
                                            '{15}', '{16}', '{17}', {18})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", _dr["ma_tkhai"].ToString().Trim());
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_psinh_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_p10.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi dữ liệu tờ khai 10/KK-TNCN của " + p_tax_name);
            _listFile_p10.Clear();
            _listFile_p10 = null;
            _connOra_p10.close();
            AddToListView(2, "Hoàn thành việc tải dữ liệu tờ khai 10/KK-TNCN của " + p_tax_name);
        }

        // Dữ liệu tờ khai 10A/KK-TNCN
        private void Prc_doc_file_p10a(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string p_path, DirectoryInfo p_dir_source)
        {
            // Đọc file P10AYYYY.DBF
            string _search_pattern = "P10A*.DBF";
            // Đối tượng lưu trữ danh sách file dữ liệu tờ khai 10A/KK-TNCN
            ArrayList _listFile_p10a = new ArrayList();
            // Lấy danh sách các file dữ liệu tờ khai 10A/KK-TNCN
            _listFile_p10a.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_p10a = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành việc tải dữ liệu tờ khai 10A/KK-TNCN của " + p_tax_name);
            // Biến lưu trữ số bản ghi đã được thêm vào bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_p10a)
            {
                try
                {
                    string _query = @"SELECT a.kykkhai2,
                                         a.kylbo,
                                         a.madtnt as tin,
                                         a.matkhai as ma_tkhai,
                                         a.matm as ma_tmuc,
                                         a.ngnop as ngay_nop,
                                         a.hannop2 as han_nop,
                                         a.thuepn as so_tien
                                    FROM {0} a 
                                   WHERE a.matkhai = '10/KK-TNCN' 
                                     AND a.thuetky2 <> 1
                                     AND a.ThuePN > 0 
                                     AND a.mamuc = '1000'";

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Đối tượng lưu trữ các bản ghi
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ phát sinh và kỳ lập bộ nằm trong kỳ chốt dữ liệu

                        // Biến lưu trữ kỳ lập bộ lấy từ file dữ liệu
                        string _temp = _dr["kylbo"].ToString().Replace("/", "").Trim();
                        // Kỳ lập bộ
                        DateTime _kylbo;
                        try
                        {
                            _kylbo =
                               new DateTime(Int32.Parse(_temp.Substring(2, 4)), // Năm
                                            Int32.Parse(_temp.Substring(0, 2)), // Tháng
                                            1);                                 // Ngày
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: Kỳ lập bộ sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: " + e.Message);
                            continue;
                        }

                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu
                        string _ky_kkhai = _dr["KyKKhai2"].ToString().Replace("/", "").Trim();
                        // Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Ngày bắt đầu kỳ phát sinh
                        DateTime _ky_psinh_tu;
                        // Ngày kết thúc kỳ phát sinh
                        DateTime _ky_psinh_den;

                        try
                        {
                            _ky_psinh_tu = new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = new DateTime(Int32.Parse(_ky_kkhai.Substring(2, 4)), Int32.Parse(_ky_kkhai.Substring(0, 2)), 1);
                            _ky_psinh_den = _ky_psinh_den.AddMonths(1).AddDays(-1);
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: Kỳ kê khai sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: " + e.Message);
                            continue;
                        }

                        if (_kylbo.CompareTo(p_ky_ps_den) > 0
                            || _kylbo.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_den) > 0)
                            continue;
                        #endregion

                        _stt++; // Bản ghi số mấy
                        _query = @"INSERT INTO tb_ps
                                           (short_name, stt, loai, ma_cqt, tin,
                                            ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                            tkhoan, ky_psinh_tu, ky_psinh_den,
                                            so_tien, han_nop, ngay_htoan, ngay_nop,
                                            tax_model, status, id)
                                    VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                            '{5}', '{6}', '{7}', '{8}', '{9}',
                                            '{10}', '{11}', '{12}', '{13}', '{14}', 
                                            '{15}', '{16}', '{17}', {18})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", "10A/KK-TNCN");
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", _ky_psinh_tu.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{11}", _ky_psinh_den.ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_p10a.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }                    
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Dữ liệu tờ khai 10A/KK-TNCN: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi dữ liệu tờ khai 10A/KK-TNCN của " + p_tax_name + " vào bảng TB_PS");
            _listFile_p10a.Clear();
            _listFile_p10a = null;
            _connOra_p10a.close();
            AddToListView(2, "Hoàn thành việc tải dữ liệu tờ khai 10A/KK-TNCN của " + p_tax_name);            
        }

        // Dữ liệu số dư phát sinh đầu kỳ
        private void Prc_doc_file_sdps(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string p_path, DirectoryInfo p_dir_source)
        {
            // Đọc file SDPSYYYY.DBF
            string _search_pattern = "SDPS*.DBF";
            // Đối tượng lưu trữ danh sách file dữ liệu số dư phát sinh đầu kỳ
            ArrayList _listFile_sdps = new ArrayList();
            // Lấy danh sách các file dữ liệu số dư phát sinh đầu kỳ
            _listFile_sdps.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_sdps = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành việc tải dữ liệu số dư phát sinh đầu kỳ của " + p_tax_name);
            // Biến lưu số bản ghi đã được thêm vào bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_sdps)
            {
                try
                {
                    string _query = @"SELECT a.madtnt as tin,
                                         a.matkhai as ma_tkhai,
                                         a.matm as ma_tmuc,
                                         a.ngnop as ngay_nop,
                                         a.hannop as han_nop,
                                         a.thuetky as so_tien,
                                         a.kylbo, a.kykkhai 
                                    FROM {0} a 
                                   WHERE a.matkhai IN ('02T/KK-TNCN', 
                                                       '02Q/KK-TNCN',
                                                       '03T/KK-TNCN',
                                                       '03Q/KK-TNCN',
                                                       '07/KK-TNCN',
                                                       '08/KK-TNCN',
                                                       '08A/KK-TNCN',
                                                       '10/KK-TNCN',
                                                       '10A/KK-TNCN')
                                     AND a.mamuc = '1000' 
                                     AND a.thuetky > 0";
                    /*
                     02T/KK-TNCN Tháng
                     02Q/KK-TNCN Quý
                     03T/KK-TNCN Tháng
                     03Q/KK-TNCN Quý
                     07/KK-TNCN  Tháng
                     08/KK-TNCN  Quý
                     08A/KK-TNCN Quý
                     10/KK-TNCN  Tháng
                     10A/KK-TNCN Tháng
                     */

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Đối tượng lưu trữ các bản ghi
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
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
                        try
                        {
                            _ky_lbo = new DateTime(Int32.Parse(_kylbo.Substring(2, 4)), // Năm
                                                   Int32.Parse(_kylbo.Substring(0, 2)), // Tháng
                                                   1);                                  // Ngày
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: Kỳ lập bộ sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                            continue;
                        }

                        // Tờ khai tháng
                        if (_ma_tkhai.Equals("02T/KK-TNCN")
                            || _ma_tkhai.Equals("03T/KK-TNCN")
                            || _ma_tkhai.Equals("07/KK-TNCN")
                            || _ma_tkhai.Equals("10/KK-TNCN")
                            || _ma_tkhai.Equals("10A/KK-TNCN"))
                        {
                            try
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
                            catch (FormatException)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: Kỳ kê khai sai định dạng");
                                continue;
                            }
                            catch (Exception e)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                                continue;
                            }
                        }

                        // Tờ khai quý
                        else
                        {
                            int _quy_ky_kkhai = 1; // Biến lưu trữ quý của kỳ kê khai
                            int _nam_ky_kkhai = 2010; // Biến lưu trữ năm của kỳ kê khai
                            try
                            {
                                _quy_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(0, 1));
                                _nam_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(1, 4));
                            }
                            catch (FormatException)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: Kỳ kê khai sai định dạng");
                                continue;
                            }
                            catch (Exception e)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh đầu kỳ: " + e.Message);
                                continue;
                            }

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
                                throw new InvalidDataException("Tháng của kỳ phát sinh không hợp lệ");
                            }
                        }

                        if (_kylbo.CompareTo(p_ky_ps_den) > 0
                            || _kylbo.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_den) > 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0)
                            continue;

                        #endregion

                        _stt++; // Bản ghi số mấy

                        _query = @"INSERT INTO tb_ps
                                           (short_name, stt, loai, ma_cqt, tin,
                                            ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                            tkhoan, ky_psinh_tu, ky_psinh_den,
                                            so_tien, han_nop, ngay_htoan, ngay_nop,
                                            tax_model, status, id)
                                    VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                            '{5}', '{6}', '{7}', '{8}', '{9}',
                                            '{10}', '{11}', '{12}', '{13}', '{14}', 
                                            '{15}', '{16}', '{17}', {18})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", _ma_tkhai);
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", "");
                        _query = _query.Replace("{11}", "");
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_sdps.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }                    
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Dữ liệu số dư phát sinh: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + "bản ghi dữ liệu số dư phát sinh đầu kỳ vào bảng TB_PS của " + p_tax_name);
            _listFile_sdps.Clear();
            _listFile_sdps = null;
            _connOra_sdps.close();
            AddToListView(2, "Hoàn thành việc tải dữ liệu số dư phát sinh đầu kỳ của " + p_tax_name);
        }

        // Dữ liệu quyết định ấn định, bãi bỏ quyết định
        private void Prc_doc_file_qdad(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_ps_tu, ref DateTime p_ky_ps_den, string p_path, DirectoryInfo p_dir_source)
        {
            // Đọc file QDADYYYY.DBF
            string _search_pattern = "QDAD*.DBF";
            // Đối tượng lưu trữ danh sách file dữ liệu quyết định ấn định, bãi bỏ quyết định
            ArrayList _listFile_qdad = new ArrayList();
            // Lấy danh sách các file dữ liệu quyết định ấn định, bãi bỏ quyết định
            _listFile_qdad.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_qdad = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành việc tải dữ liệu quyết định ấn định, bãi bỏ ấn định của " + p_tax_name);
            // Biến lưu trữ số bản ghi đã thêm vào bảng TB_PS
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_qdad)
            {
                try
                {
                    string _query = @"SELECT a.madtnt as tin,
                                         a.matkhai as ma_tkhai,
                                         a.matm as ma_tmuc,
                                         iif(Subs(DToC(a.NgayQD), 4, 7) == a.KyLBo, 
                                         a.NgayQD, 
                                         ('01/'+a.KyLBo)) as ngay_nop,
                                         a.hannop as han_nop,
                                         a.thuecl as so_tien 
                                    FROM {0} a 
                                   WHERE a.loai = 0
                                     AND a.maad IN ('02','03') 
                                     AND a.thuecl > 0 
                                     AND a.matkhai IN ('02T/KK-TNCN',
                                                       '02Q/KK-TNCN',
                                                       '03T/KK-TNCN',
                                                       '03Q/KK-TNCN',
                                                       '07/KK-TNCN',
                                                       '08/KK-TNCN',
                                                       '08A/KK-TNCN') 
                                     AND a.mamuc = '1000' ";                    

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Đối tượng lưu trữ các bản ghi
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
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
                        try
                        {
                            _ky_lbo = new DateTime(Int32.Parse(_kylbo.Substring(2, 4)), // Năm
                                                   Int32.Parse(_kylbo.Substring(0, 2)), // Tháng
                                                   1);                                  // Ngày
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: Kỳ lập bộ sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: " + e.Message);
                            continue;                            
                        }

                        // Tờ khai tháng
                        if (_ma_tkhai.Equals("02T/KK-TNCN")
                            || _ma_tkhai.Equals("03T/KK-TNCN")
                            || _ma_tkhai.Equals("07/KK-TNCN"))
                        {
                            try
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
                            catch (FormatException)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: Kỳ kê khai sai định dạng");
                                continue;
                            }
                            catch (Exception e)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: " + e.Message);
                                continue;
                            }
                        }

                        // Tờ khai quý
                        else
                        {
                            int _quy_ky_kkhai = 1; // Biến lưu trữ quý của kỳ kê khai
                            int _nam_ky_kkhai = 2010; // Biến lưu trữ năm của kỳ kê khai
                            try
                            {
                                _quy_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(0, 1));
                                _nam_ky_kkhai = Int32.Parse(_kykkhai.Trim().Substring(1, 4));
                            }
                            catch (FormatException)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: Kỳ kê khai sai định dạng");
                                continue;
                            }
                            catch (Exception e)
                            {
                                AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: " + e.Message);
                                continue;
                            }

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
                                throw new InvalidDataException(p_tax_name + "\\Dữ liệu quyết định, ấn định: Tháng của kỳ phát sinh không hợp lệ");
                            }
                        }

                        if (_kylbo.CompareTo(p_ky_ps_den) > 0
                            || _kylbo.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_tu) < 0
                            || _ky_psinh_tu.CompareTo(p_ky_ps_den) > 0)
                            continue;

                        #endregion
                        
                        _stt++; // Bản ghi số mấy

                        _query = @"INSERT INTO tb_ps
                                           (short_name, stt, loai, ma_cqt, tin,
                                            ma_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                                            tkhoan, ky_psinh_tu, ky_psinh_den,
                                            so_tien, han_nop, ngay_htoan, ngay_nop,
                                            tax_model, status, id)
                                    VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                            '{5}', '{6}', '{7}', '{8}', '{9}',
                                            '{10}', '{11}', '{12}', '{13}', '{14}', 
                                            '{15}', '{16}', '{17}', {18})";

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "TK");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", _ma_tkhai);
                        _query = _query.Replace("{6}", "757");
                        _query = _query.Replace("{7}", "000");
                        _query = _query.Replace("{8}", _dr["ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{9}", "TKNS");
                        _query = _query.Replace("{10}", "");
                        _query = _query.Replace("{11}", "");
                        _query = _query.Replace("{12}", _dr["so_tien"].ToString().Trim());
                        _query = _query.Replace("{13}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{14}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{15}", ((DateTime)_dr["ngay_nop"]).ToString("dd/MM/yyyy").ToString().Trim());
                        _query = _query.Replace("{16}", "VAT_APP");
                        _query = _query.Replace("{17}", "");
                        _query = _query.Replace("{18}", "seq_id_csv.nextval");

                        if (_connOra_qdad.exeUpdate(_query) != 0)
                            _rowsnum++;
                    }                    
                    _dt.Clear();
                    _dt = null;
                    _connFoxPro.close();
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Dữ liệu quyết định, ấn định: " + e.Message);
                    continue;
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi dữ liệu quyết định ấn định vào bảng TB_PS của " + p_tax_name);
            _listFile_qdad.Clear();
            _listFile_qdad = null;
            _connOra_qdad.close();
            AddToListView(2, "Hoàn thành việc tải dữ liệu quyết định ấn định, bãi bỏ ấn định của " + p_tax_name);
        }

        // Dữ liệu nợ
        private void Prc_doc_file_no(string p_short_name, string p_tax_name, string p_tax_code, ref DateTime p_ky_no_den, string p_path, DirectoryInfo p_dir_source)
        {
            // File NOYYYY.DBF
            string _search_pattern = "NO*.DBF";
            // Đối tượng lưu trữ các file dữ liệu
            ArrayList _listFile_no = new ArrayList();
            // Lấy danh sách các file dữ liệu
            _listFile_no.AddRange(p_dir_source.GetFiles(_search_pattern));
            CLS_DBASE.ORA _connOra_no = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            AddToListView(2, "Tiến hành thực hiện tải dữ liệu nợ của " + p_tax_name);
            // Biến lưu số bản ghi đã được thêm vào bảng TB_NO
            int _rowsnum = 0;
            foreach (FileInfo _file in _listFile_no)
            {
                try
                {
                    string _query = @"SELECT a.madtnt as tin,
                                             a.matm as tmt_ma_tmuc,
                                             a.matk as ma_tkhoan,
                                             a.KyKKhai,
                                             a.hannop as han_nop,
                                             sum(iif(a.LoaiDC = '1',a.NoDKy + a.ThueDC,a.ThueDC)) as no_cuoi_ky,
                                             a.KyLBo
                                        FROM {0} a 
                                       WHERE (a.MaMuc = '1000' 
                                              OR 
                                             (a.mamuc <> '1000' 
                                              AND 
                                              a.matm = '4268'))
                                         AND (a.LoaiQD = '0')
                                         AND iif(a.LoaiDC = '1', a.NoDKy + a.ThueDC, a.ThueDC) <> 0
                                    GROUP BY tin, tmt_ma_tmuc, ma_tkhoan, KyKKhai, han_nop, KyLbo";

                    _query = _query.Replace("{0}", _file.Name);

                    CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);

                    // Chứa dữ liệu
                    DataTable _dt = _connFoxPro.exeQuery(_query);
                    int _stt = 0; // Biến đếm số bản ghi
                    MessageBox.Show(_dt.Rows.Count.ToString());
                    foreach (DataRow _dr in _dt.Rows)
                    {
                        #region Kiểm tra kỳ kê khai và kỳ lập bộ
                        try
                        {
                            // Biến lưu trữ kỳ lập bộ lấy từ file dữ liệu
                            string _ky_lbo = _dr["KyLBo"].ToString().Replace("/", "").Trim();
                            // Kỳ lập bộ
                            DateTime _kylbo =
                                new DateTime(Int32.Parse(_ky_lbo.Substring(2, 4)), // Năm
                                             Int32.Parse(_ky_lbo.Substring(0, 2)), // Tháng
                                             1);                                   // Ngày

                            if ((_kylbo.AddMonths(1).AddDays(-1)).CompareTo(p_ky_no_den.AddMonths(1)) != 0)
                                continue;
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: Kỳ lập bộ sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: " + e.Message);
                            continue;
                        }

                        #region Xác định kỳ phát sinh của đối tượng nộp thuế
                        // Biến lưu trữ kỳ kê khai lấy từ file dữ liệu                            
                        string _ky_kkhai = _dr["KyKKhai"].ToString().Replace("/", "").Trim();
                        if (_ky_kkhai.Length < 6)
                            _ky_kkhai = "0" + _ky_kkhai;

                        // Nếu kỳ kê khai trước tháng 1/2005 thì chuyển thành 1/2005
                        try
                        {
                            if (Int32.Parse(_ky_kkhai.Substring(2, 4)) < 2005)
                                _ky_kkhai = "012005";
                        }
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: Kỳ kê khai sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: " + e.Message);
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
                        catch (FormatException)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: Kỳ kê khai sai định dạng");
                            continue;
                        }
                        catch (Exception e)
                        {
                            AddToListView(0, p_tax_name + "\\Dữ liệu nợ: " + e.Message);
                            continue;
                        }
                        #endregion

                        #endregion

                        _query = @"INSERT INTO tb_no
                                               (short_name, stt, loai, ma_cqt,
                                                tin, ma_chuong, ma_khoan, tmt_ma_tmuc,
                                                tkhoan, ngay_hach_toan, kykk_tu_ngay,
                                                kykk_den_ngay, han_nop, dkt_ma,
                                                no_cuoi_ky, tax_model, status, id)
                                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}',
                                                '{5}', '{6}', '{7}', '{8}', '{9}',
                                                '{10}', '{11}', '{12}', '{13}', '{14}',
                                                '{15}', '{16}', {17})";

                        _stt++; // Bản ghi số mấy

                        _query = _query.Replace("{0}", p_short_name);
                        _query = _query.Replace("{1}", _stt.ToString());
                        _query = _query.Replace("{2}", "CD");
                        _query = _query.Replace("{3}", p_tax_code);
                        _query = _query.Replace("{4}", _dr["tin"].ToString().Trim());
                        _query = _query.Replace("{5}", "757");
                        _query = _query.Replace("{6}", "000");
                        _query = _query.Replace("{7}", _dr["tmt_ma_tmuc"].ToString().Trim());
                        _query = _query.Replace("{8}", _dr["ma_tkhoan"].ToString().Trim());
                        _query = _query.Replace("{9}", p_ky_no_den.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{10}", _kykk_tu_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{11}", _kykk_den_ngay.ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{12}", ((DateTime)_dr["han_nop"]).ToString("dd/MM/yyyy"));
                        _query = _query.Replace("{13}", "");
                        _query = _query.Replace("{14}", _dr["no_cuoi_ky"].ToString().Trim());
                        _query = _query.Replace("{15}", "VAT_APP");
                        _query = _query.Replace("{16}", "");
                        _query = _query.Replace("{17}", "seq_id_csv.nextval");

                        if (_connOra_no.exeUpdate(_query) != 0)
                            _rowsnum++;

                    }                    
                    _connFoxPro.close();
                    _dt.Clear();
                    _dt = null;
                }
                catch (Exception e)
                {
                    AddToListView(0, p_tax_name + "\\Dữ liệu nợ: " + e.Message);
                }
            }
            AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi vào bảng TB_NO của " + p_tax_name);
            _connOra_no.close();
            _listFile_no.Clear();
            _listFile_no = null;
            AddToListView(2, "Hoàn thành việc tải dữ liệu nợ của " + p_tax_name);
        }
                
        // Dữ liệu chi tiết tờ khai 10/KK-TNCN
        private void Prc_doc_file_tk10(string p_short_name, string p_tax_name, string p_tax_code, string p_path, DirectoryInfo p_dir_source, DateTime p_ky_tk10_tu, DateTime p_ky_tk10_den)
        {
            try
            {
                // Đọc file CNTKYYYY.DBF
                string _search_pattern = "CNTK2012.DBF";
                // Đối tượng lưu trữ danh sách các file dữ liệu chi tiết tờ khai 10/KK-TNCN
                ArrayList _listFile = new ArrayList();
                // Lấy danh sách các file dữ liệu chi tiết tờ khai 10/KK-TNCN
                _listFile.AddRange(p_dir_source.GetFiles(_search_pattern));

                CLS_DBASE.ORA _connOra_tk10 = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
                // Biến lưu trữ số bản ghi đã thêm vào bảng TB_TK

                AddToListView(2, "Tiến hành thực hiện đọc dữ liệu chi tiết tờ khai 10/KK-TNCN của " + p_tax_name);

                int _rowsnum = 0;
                foreach (FileInfo _file in _listFile)
                {
                    try
                    {
                        string _query = @"SELECT a.madtnt as tin,
                                             a.kykkhai,                                                                     
                                             a.NgNop as kylb_tu_ngay,
                                             b.madlt as mst_dtk,
                                             b.sohd as hd_dlt_so,
                                             dtoc(b.ngayhd) as hd_dlt_ngay 
                                        FROM {0} a 
                                                LEFT JOIN 
                                             DTNT_DLT.DBF as b 
                                                ON a.madtnt = b.madtnt
                                       WHERE a.matkhai = '10/KK-TNCN'
                                         AND (a.Thuetky2 = 0 
                                                OR 
                                              ISNULL(a.Thuetky2))";

                        _query = _query.Replace("{0}", _file.Name);

                        CLS_DBASE.FOX _connFoxPro = new CLS_DBASE.FOX(p_path);
                        // Chứa dữ liệu
                        DataTable _dt = _connFoxPro.exeQuery(_query);
                        int _stt = 0; // Biến đếm số bản ghi
                        foreach (DataRow _dr in _dt.Rows)
                        {
                            #region Xác định mã đối tượng người nộp thuế
                            string _tin = _dr["tin"].ToString().Trim();
                            #endregion

                            #region Xác định kỳ kê khai
                            string _kykk_tu_ngay = "01/01/" + _dr["kykkhai"].ToString().Trim();
                            string _kykk_den_ngay = "31/12/" + _dr["kykkhai"].ToString().Trim();
                            #endregion

                            #region Xác định kỳ lập bộ
                            string _kylb_tu_ngay = ((DateTime)_dr["kylb_tu_ngay"]).ToString("dd/MM/yyyy").Trim();
                            #endregion

                            _stt++;

                            _query = @"INSERT INTO tb_tk
                                               (short_name,
                                                tin, 
                                                kykk_tu_ngay,
                                                kykk_den_ngay, 
                                                kylb_tu_ngay, 
                                                mst_dtk,
                                                hd_dlt_so,
                                                hd_dlt_ngay,
                                                tax_model,
                                                ma_cqt,
                                                stt,
                                                id)
                                        VALUES ('{0}', '{1}', '{2}',
                                                '{3}', '{4}', '{5}',
                                                '{6}', '{7}', '{8}',
                                                '{9}', {10}, {11})";

                            _query = _query.Replace("{0}", p_short_name);
                            _query = _query.Replace("{1}", _tin);
                            _query = _query.Replace("{2}", _kykk_tu_ngay);
                            _query = _query.Replace("{3}", _kykk_den_ngay);
                            _query = _query.Replace("{4}", _kylb_tu_ngay);
                            _query = _query.Replace("{5}", _dr["mst_dtk"].ToString().Trim());
                            _query = _query.Replace("{6}", _dr["hd_dlt_so"].ToString().Trim());
                            _query = _query.Replace("{7}", _dr["hd_dlt_ngay"].ToString().Trim());
                            _query = _query.Replace("{8}", "VAT_APP");
                            _query = _query.Replace("{9}", p_tax_code);
                            _query = _query.Replace("{10}", _stt.ToString());
                            _query = _query.Replace("{11}", "seq_id_csv.nextval");

                            try
                            {
                                if (_connOra_tk10.exeUpdate(_query) != 0)
                                    _rowsnum++;

                                // Đối tượng lưu trữ thông tin chi tiết tờ khai 10/KK-TNCN
                                DataTable _dt_details;

                                #region Cập nhật chỉ tiêu tờ khai 10/KK-TNCN

                                _query = @"SELECT b.madtnt, allt(str(b.thuetky, 20, 0)) as thuetky, b.cttn
                                         FROM c102012 b
                                        WHERE b.madtnt = '" + _tin + "'";

                                try
                                {
                                    _dt_details = _connFoxPro.exeQuery(_query);
                                    foreach (DataRow _dr_details in _dt_details.Rows)
                                    {
                                        // Xác định mã cttn
                                        string _cttn = _dr_details["cttn"].ToString().Trim();
                                        // Biến lưu trữ tên loại chỉ tiêu
                                        string _chi_tieu;

                                        switch (_cttn)
                                        {
                                            case "021":
                                                _chi_tieu = "DTHU_DKIEN";
                                                break;
                                            case "022":
                                                _chi_tieu = "TL_THNHAP_DKIEN";
                                                break;
                                            case "023":
                                                _chi_tieu = "THNHAP_CTHUE_DKIEN";
                                                break;
                                            case "024":
                                                _chi_tieu = "GTRU_GCANH";
                                                break;
                                            case "025":
                                                _chi_tieu = "BAN_THAN";
                                                break;
                                            case "026":
                                                _chi_tieu = "PHU_THUOC ";
                                                break;
                                            case "027":
                                                _chi_tieu = "THNHAP_TTHUE_DKIEN";
                                                break;
                                            case "028":
                                                _chi_tieu = "TNCN";
                                                break;
                                            default: continue;
                                        }
                                        _query = @"UPDATE tb_tk
                                                  SET " + _chi_tieu + @" = " + _dr_details["thuetky"].ToString().Trim() + @" 
                                                WHERE tin = '" + _tin + "'";
                                        _connOra_tk10.exeUpdate(_query);
                                    }
                                    // Xóa nội dung chi tiết tờ khai 10/KK-TNCN
                                    _dt_details.Clear();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN\\Cập nhật chỉ tiêu: " + ex.Message);
                                }
                                #endregion

                                #region Cập nhật phân bổ tờ khai 10/KK-TNCN
                                try
                                {
                                    // Phân bổ quý 1
                                    _query = @"SELECT a.madtnt, allt(str(sum(a.thuepn), 20, 0)) as PB,
                                                  '12Q1' as KYTT,
                                                  CToD('01/01/2012') as HT,
                                                  a.HanNop2 as HN
                                             FROM p102012 a
                                            WHERE a.kylbo2 in('01/2012',
                                                              '02/2012',
                                                              '03/2012')
                                              AND a.madtnt = '" + _tin + @"' 
                                         GROUP BY a.madtnt, HN";
                                    _dt_details = _connFoxPro.exeQuery(_query);

                                    // Phân bổ quý 2
                                    _query = @"SELECT a.madtnt, allt(str(sum(a.thuepn), 20, 0)) as PB,
                                                  '12Q2' as KYTT,
                                                  CToD('01/01/2012') as HT,
                                                  a.HanNop2 as HN
                                             FROM p102012 a
                                            WHERE a.kylbo2 in('04/2012',
                                                              '05/2012',
                                                              '06/2012')
                                              AND a.madtnt = '" + _tin + @"' 
                                         GROUP BY a.madtnt, HN";
                                    _dt_details.Merge(_connFoxPro.exeQuery(_query));


                                    // Phân bổ quý 3
                                    _query = @"SELECT a.madtnt, allt(str(sum(a.thuepn), 20, 0)) as PB,
                                                  '12Q3' as KYTT,
                                                  CToD('01/01/2012') as HT,
                                                  a.HanNop2 as HN
                                             FROM p102012 a
                                            WHERE a.kylbo2 in('07/2012',
                                                              '08/2012',
                                                              '09/2012')
                                              AND a.madtnt = '" + _tin + @"' 
                                         GROUP BY a.madtnt, HN";
                                    _dt_details.Merge(_connFoxPro.exeQuery(_query));

                                    // Phân bổ quý 4
                                    _query = @"SELECT a.madtnt, allt(str(sum(a.thuepn), 20, 0)) as PB,
                                                  '12Q4' as KYTT,
                                                  CToD('01/01/2012') as HT,
                                                  a.HanNop2 as HN
                                             FROM p102012 a
                                            WHERE a.kylbo2 in('10/2012',
                                                              '11/2012',
                                                              '12/2012')
                                              AND a.madtnt = '" + _tin + @"' 
                                         GROUP BY a.madtnt, HN";
                                    _dt_details.Merge(_connFoxPro.exeQuery(_query));
                                    foreach (DataRow _dr_details in _dt_details.Rows)
                                    {
                                        // Xác định kỳ phân bổ
                                        string _kytt = _dr_details["KYTT"].ToString().Trim();
                                        switch (_kytt)
                                        {
                                            case "12Q1":
                                                _query = @"UPDATE tb_tk a
                                                          SET a.PB01 = " + _dr_details["PB"].ToString().Trim() + @",
                                                              a.KYTT01 = '" + _dr_details["KYTT"].ToString().Trim() + @"',
                                                              a.HT01 = '" + ((DateTime)_dr_details["HT"]).ToString("dd/MM/yyyy").Trim() + @"',
                                                              a.HN01 = '" + ((DateTime)_dr_details["HN"]).ToString("dd/MM/yyyy").Trim() + @"'
                                                        WHERE a.tin = '" + _tin + "'";
                                                _connOra_tk10.exeUpdate(_query);
                                                break;
                                            case "12Q2":
                                                _query = @"UPDATE tb_tk a
                                                          SET a.PB02 = " + _dr_details["PB"].ToString().Trim() + @",
                                                              a.KYTT02 = '" + _dr_details["KYTT"].ToString().Trim() + @"',
                                                              a.HT02 = '" + ((DateTime)_dr_details["HT"]).ToString("dd/MM/yyyy").Trim() + @"',
                                                              a.HN02 = '" + ((DateTime)_dr_details["HN"]).ToString("dd/MM/yyyy").Trim() + @"'
                                                        WHERE a.tin = '" + _tin + "'";
                                                _connOra_tk10.exeUpdate(_query);
                                                break;
                                            case "12Q3":
                                                _query = @"UPDATE tb_tk a
                                                          SET a.PB03 = " + _dr_details["PB"].ToString().Trim() + @",
                                                              a.KYTT03 = '" + _dr_details["KYTT"].ToString().Trim() + @"',
                                                              a.HT03 = '" + ((DateTime)_dr_details["HT"]).ToString("dd/MM/yyyy").Trim() + @"',
                                                              a.HN03 = '" + ((DateTime)_dr_details["HN"]).ToString("dd/MM/yyyy").Trim() + @"'
                                                        WHERE a.tin = '" + _tin + "'";
                                                _connOra_tk10.exeUpdate(_query);
                                                break;
                                            case "12Q4":
                                                _query = @"UPDATE tb_tk a
                                                          SET a.PB04 = " + _dr_details["PB"].ToString().Trim() + @",
                                                              a.KYTT04 = '" + _dr_details["KYTT"].ToString().Trim() + @"',
                                                              a.HT04 = '" + ((DateTime)_dr_details["HT"]).ToString("dd/MM/yyyy").Trim() + @"',
                                                              a.HN04 = '" + ((DateTime)_dr_details["HN"]).ToString("dd/MM/yyyy").Trim() + @"'
                                                        WHERE a.tin = '" + _tin + "'";
                                                _connOra_tk10.exeUpdate(_query);
                                                break;
                                            default: continue;
                                        }
                                    }
                                    _dt_details.Clear();
                                }
                                catch (Exception ex)
                                {
                                    AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN\\Cập nhật phân bổ: " + ex.Message);
                                }
                                #endregion

                                #region Cập nhật trường rv_so_tien
                                try
                                {
                                    // Biến lưu trữ kỳ chốt dữ liệu
                                    string _ky_tk10_den = p_ky_tk10_den.Month.ToString().PadLeft(2, '0')
                                        + "/" + p_ky_tk10_den.Year.ToString();
                                    _query = @"SELECT allt(str(sum(a.thuepn), 20, 0)) as rv_so_tien
                                             FROM p102012 a
                                            WHERE a.kylbo2 <= '" + _ky_tk10_den + "'";
                                    _dt_details = _connFoxPro.exeQuery(_query);
                                    foreach (DataRow _dr_details in _dt_details.Rows)
                                    {
                                        _query = @"UPDATE tb_tk a
                                                  SET a.rv_so_tien = " + _dr_details["rv_so_tien"].ToString() + @"
                                                WHERE a.tin = '" + _tin + "'";
                                        _connOra_tk10.exeUpdate(_query);
                                    }
                                }
                                catch (Exception e)
                                {
                                    AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN\\Cập nhật trường reverse: " + e.Message);
                                }
                                #endregion
                            }
                            catch (Exception ex)
                            {
                                AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN: " + ex.Message);
                                continue;
                            }
                        }
                        _dt.Clear();
                        _dt = null;
                        _connFoxPro.close();
                    }
                    catch (Exception ex)
                    {
                        AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN\\Thông tin chính: " + ex.Message);
                        continue;
                    }
                }
                AddToListView(2, "Đã thêm " + _rowsnum + " bản ghi vào bảng TB_TK của " + p_tax_name);
                _connOra_tk10.close();
                _listFile.Clear();
                _listFile = null;
                AddToListView(2, "Hoàn thành việc tải dữ liệu chi tiết tờ khai 10/KK-TNCN của " + p_tax_name);
            }
            catch (IOException e)
            {
                AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN\\Lỗi đăng nhập: " + e.Message);
            }
            catch (Exception e)
            {
                AddToListView(0, p_tax_name + "\\Tờ khai 10/KK-TNCN: " + e.Message);
            }

        }        
        #endregion

        private void grb_drg_Enter(object sender, EventArgs e)
        {

        }
        #endregion

        private void dgrTaxOffice_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        #endregion
    }
}
