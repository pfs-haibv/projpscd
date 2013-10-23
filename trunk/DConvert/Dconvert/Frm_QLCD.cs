using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OracleClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Reflection;
using DataGridViewAutoFilter;
using DC.Utl;
using DC.Lib;
using DC.Lib.Objects;
using DC.Vatwin;
using DC.ExtremeMirror;
using SAP.Middleware.Connector;
using System.Threading;
using System.Data.OleDb;
using System.Collections;
using System.IO;
using System.DirectoryServices;
using System.Net;

namespace DC.Forms
{
    public partial class Frm_QLCD : Form
    {

        #region KHỞI TẠO
        private static bool[] v_rowIndex;
        private static int newRowIndex;
        private static int oldRowIndex;
        private static int _countdgr = 0;
        private static string v_combo_value;
        private static string v_combo_value_pnn;
        private static int v_vatwin_selected_tab;        
        private static DataRow v_dr;
        private static int v_index;
        private static ArrayList arr_dr;
        private static ArrayList arr_index;

        // Tạo kết nối tới cơ sở dữ liệu trung gian
        private static CLS_DBASE.ORA _ora;

        // Tạo kết nối tới SAP
        // SAP Connection
        private static InMemoryDestinationConfiguration v_DestConfig;
        private static RfcDestination v_sap;


        public Frm_QLCD()
        {
            // Oracle database
            _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);

            // SAP
            v_DestConfig = new InMemoryDestinationConfiguration();
            RfcDestinationManager.RegisterDestinationConfiguration(v_DestConfig);

            // Modify by ManhTV3 on 3/5/2012
            arr_dr = new ArrayList();
            // Modify by ManhTV3 on 17/5/2012
            arr_index = new ArrayList();

            string _query = null;
            _query += "select max(Decode(rv_key,'SID', rv_chr)) SID,";
            _query += "max(Decode(rv_key,'USER', rv_chr)) USR,";
            _query += "max(Decode(rv_key,'PASS', rv_chr)) PASS,";
            _query += "max(Decode(rv_key,'LANG', rv_chr)) LANG,";
            _query += "max(Decode(rv_key,'CLIENT', rv_chr)) CLIENT,";
            _query += "max(Decode(rv_key,'IP', rv_chr)) IP,";
            _query += "max(Decode(rv_key,'INUM', rv_chr)) INUM ";
            _query += "from tb_01_para where rv_group='SER_SAP_APP'";

            DataTable _dt = _ora.exeQuery(_query);
            v_DestConfig.AddOrEditDestination(_dt.Rows[0]["SID"].ToString(),
                                                      100,
                                                      _dt.Rows[0]["USR"].ToString(),
                                                      _dt.Rows[0]["PASS"].ToString(),
                                                      _dt.Rows[0]["LANG"].ToString(),
                                                      _dt.Rows[0]["CLIENT"].ToString(),
                                                      _dt.Rows[0]["IP"].ToString(),
                                                      _dt.Rows[0]["INUM"].ToString());

            v_sap = RfcDestinationManager.GetDestination(_dt.Rows[0]["SID"].ToString());

            InitializeComponent();

            // Khởi tạo giá trị cho các biến thành viên            
            Prc_InitializeMember();
        }
        ~Frm_QLCD()
        {
            // Ngắt kết nối tới DPPIT database
            _ora.close();
            // Ngắt kết nối tới hệ thống SAP
            v_DestConfig.RemoveDestination(v_sap.Name.ToString());
            RfcDestinationManager.UnregisterDestinationConfiguration(v_DestConfig);
        }
        private void Prc_InitializeMember()
        {
            this.tabPage3_listView2.SmallImageList = iconImageList;
            newRowIndex = oldRowIndex = -1;
            this.progressBar1.Visible = false;
        }
        // Khởi tạo giá trị cho Combobox
        public GlobalVar.Struc_Combo[] Data_Combo = new GlobalVar.Struc_Combo[] 
        {
            new GlobalVar.Struc_Combo("TH", "01. Tổng hợp dữ liệu cho CQT"), 
            new GlobalVar.Struc_Combo("CV", "02. Chuyển dữ liệu tổng hợp về DPPIT")
        };
        #endregion

        #region FORM CONTROL
        // Event load form
        private void Frm_QLCD_Load(object sender, EventArgs e)
        {
            v_rowIndex = new bool[this.dgrTaxOffice.Rows.Count];

            //Dành cho DataGridView 
            Prc_Fill_Dgr();
            this.dgrTaxOffice.CurrentCell = this.dgrTaxOffice.CurrentRow.Cells[1];
            this.dgrTaxOffice.CurrentCellChanged += new EventHandler(dgrTaxOffice_CurrentCellChanged);

            //Dành cho ComboBox
            Prc_ComboBoxBinding();
        }
        // Fill dữ liệu vào Datagrid dgrTaxOffice
        private void Prc_Fill_Dgr()
        {
            string _query = @"SELECT a.tax_name, a.short_name, a.province, b.prov_name, a.tax_code, c.ma_cqt, 
                                     a.tax_model, a.qlt_user, a.qlt_pass,
                                     a.vat_user, a.vat_pass, a.vat_ddan_tu, 
                                     a.vat_ddan_den, a.ky_chot, a.ky_ps_tu, a.ky_ps_den,
                                     a.dblink, a.giai_doan
                                FROM tb_lst_taxo a, tb_lst_province b, tb_lst_map_cqt c 
                               WHERE a.province=b.province 
                                 AND a.tax_code=c.ma_qlt AND c.ma_cqt not like 'Z%'
                               ORDER BY a.province, a.tax_code";
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

            // Populate the list
            this.pnn_comboBox1.DataSource = Data_Combo;

            // Define the field to be displayed
            this.pnn_comboBox1.DisplayMember = "Display";

            // Define the field to be used as the value
            this.pnn_comboBox1.ValueMember = "Value";
        }
        // Hiển thị log running
        private delegate void addToListViewDelegate(int iconIndex, string message);        
        public void AddToListView(int iconIndex, string message)
        {
            if (this.tabPage3_listView2.InvokeRequired == true)
            {
                addToListViewDelegate del = new addToListViewDelegate(AddToListView);
                this.tabPage3_listView2.Invoke(del, iconIndex, message);
            }
            else
            {
                try
                {
                    ListViewItem item = new ListViewItem();
                    item.SubItems.Add((tabPage3_listView2.Items.Count + 1).ToString());
                    item.ImageIndex = iconIndex;
                    if (v_dr == null)
                        item.SubItems.Add("");
                    else
                        item.SubItems.Add(v_dr[1].ToString());
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
                    MessageBox.Show("Có lỗi trong thủ tục AddToListView()",
                                    "System Error",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Exclamation);
                }
            }

        }        
        // Thiết lập trạng thái cho các control
        private void Prc_Load_Status(int p_index)
        {
            loadStatus(p_index);
            //loadLog(p_index);
        }
        private void loadStatus(int p_index)
        {
            // Xóa các item trước đó của danh sách
            this.status_listView.Items.Clear();
            // Xác định cơ quan thuế hiện tại
            string _short_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_short_name"].Value.ToString();
            string _query = @"SELECT decode(a.id_name, 'Null', 'Y', b.status) status,
                                                     a.id_name status_name, b.where_log, b.err_code
                                                FROM tb_lst_stacqt a, ( SELECT c.pck, c.status, d.tax_model,
                                                                               c.where_log, c.err_code 
                                                                          FROM tb_log_pck c, tb_lst_taxo d
                                                                         WHERE c.short_name = d.short_name 
                                                                           AND c.ltd = 0 
                                                                           AND c.short_name = '" + _short_name + @"') b
                                               WHERE a.func_name = b.pck(+) 
                                                 AND EXISTS ( SELECT 1 
                                                                FROM tb_lst_taxo c 
                                                               WHERE c.short_name = '" + _short_name + @"' 
                                                                 AND (c.tax_model = a.tax_model or a.tax_model = '*'))
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
                string _query = @"SELECT a.short_name, a.pck, a.status, a.timestamp, a.error_stack
                                    FROM tb_errors a
                                   WHERE a.short_name = '" + _short_name + "'";
                DataTable _dt = _ora.exeQuery(_query);
                for (int i = 0; i < _dt.Rows.Count; i++)
                {
                    DataRow _dr = _dt.Rows[i];
                    ListViewItem lvi = new ListViewItem(_dr["pck"].ToString());
                    lvi.SubItems.Add(_dr["status"].ToString());
                    lvi.SubItems.Add(_dr["timestamp"].ToString());                    

                    this.tabPage3_listView1.Items.Add(lvi);
                }
            }
        }
        private void Prc_Set_Property_Control(int p_index)
        {
            // Các biến lưu tham số của CQT được chọn 
            bool _combo_status = true;
            //string _cl_status = this.dgrTaxOffice.Rows[p_index].Cells["cl_status"].Value.ToString();
            string _cl_tax_model = this.dgrTaxOffice.Rows[p_index].Cells["cl_tax_model"].Value.ToString();
            string _combo_value = null;
            if (this.tabPage1_comboBox1.SelectedValue != null)
                _combo_value = this.tabPage1_comboBox1.SelectedValue.ToString();

            // Thiết lập thuộc tính Enabled của các control trong Tab tab_action
            this.tab_action.Enabled = true;
            this.tabPage1_grb_th.Enabled = true;
            this.tabPage1_grb_cdl.Enabled = true;
            this.ckb_error.Enabled = true;
            this.ckb_ktao.Enabled = true;
            this.ckb_ddep.Enabled = true;
            this.ckb_reset_log.Checked = false;

            CLS_FORM.Prc_Set_Control(this.tab_action, "CheckBox", "Checked", "false");

            // Thiết lập thuộc tính ẩn khi cho ckb_error
            string _pnn_combo_value = "";
            this.ckb_error.Enabled = true;
            this.ckb_pnn_tk01.Enabled = true;
            this.ckb_pnn_tk02.Enabled = true;
            if (this.pnn_comboBox1.SelectedValue != null)
                _pnn_combo_value = this.pnn_comboBox1.SelectedValue.ToString();
            if (_pnn_combo_value != "CV")
            {
                this.ckb_get_log_pnn.Enabled = false;
                this.ckb_pnn_tk01.Enabled = false;
                this.ckb_pnn_tk02.Enabled = false;
            }

            // Thiết lập thuộc tính ẩn cho CheckBox đối với trạng thái
            // Trạng thái khởi tạo và dọn dẹp
            //if (((_cl_status == "0") || (_cl_status == "99")) & _cl_tax_model != "VAT")
            //{
            //    _combo_status = false;
            //    this.tabPage1_grb_th.Enabled = _combo_status;                
            //    //this.cbk_ktra_kychot.Enabled = _combo_status;                
            //}
            // Trạng thái chốt dữ liệu
            //else if (_cl_status == "98")
            //{
            //    this.tab_qltqct.Enabled = false;
            //    this.tab_vatwin.Enabled = false;
            //    //this.tabPage1_grb_co.Enabled = false;
            //    //this.groupBox4.Enabled = false;
            //}
            // Trạng thái được quyền thao tác với dữ liệu
            //else
            //{
            // Mô hình Cục
            if ((_cl_tax_model == "QLT") || (_cl_tax_model == "QCT"))
            {
                this.tab_qltqct.Enabled = true;
                // Thiết lập thuộc tính ẩn khi đối với tax_model
                if (_cl_tax_model == "QLT")
                {
                    this.ckb_qct_no.Enabled = false;
                    this.ckb_qct_tkmb.Enabled = false;
                    this.ckb_qct_cctt.Enabled = false;
                    this.ckb_qct_slech_no.Enabled = false;
                    this.ckb_qct_dkntk.Enabled = false;
                }
                else if (_cl_tax_model == "QCT")
                {
                    this.ckb_qct_no.Enabled = true;
                    this.ckb_qct_tkmb.Enabled = true;
                    this.ckb_qct_cctt.Enabled = true;
                    this.ckb_qct_slech_no.Enabled = true;
                    this.ckb_qct_dkntk.Enabled = true;
                }
                // Thiết lập thuộc tính ẩn khi cho ckb_error
                if (_combo_value != "CV")
                {
                    this.ckb_error.Enabled = false;
                }
            }
            else
            {
                this.tab_qltqct.Enabled = false;
            }

            // Mô hình VATWIN
            if (_cl_tax_model == "VAT")
            {
                this.tab_vatwin.Enabled = true;
                this.ckb_capnhat_tinhchat.Enabled = true;
            }
            else
            {
                this.tab_vatwin.Enabled = false;
                this.ckb_capnhat_tinhchat.Enabled = false;
            }
            //}                          
            
            this.dgrTaxOffice.Focus();
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
                    newRowIndex = this.dgrTaxOffice.CurrentRow.Index;
                    Prc_Load_Status(newRowIndex);
                    Prc_Set_Property_Control(newRowIndex);
                    oldRowIndex = newRowIndex;
                    v_dr = Prc_GetCurrentRow(this.dgrTaxOffice);
                    Prc_hthi_tt_may_tram(newRowIndex);                    
                }
                else
                {
                    this.dgrTaxOffice.Rows[0].Selected = true;
                }
            }
            catch
            {
                //AddToListView(0, ex.Message.ToString());
                return;
            }
        }
       
        private void lb_Drg_Loc_Click(object sender, EventArgs e)
        {
            DataGridViewAutoFilterColumnHeaderCell.RemoveFilter(this.dgrTaxOffice);
        }

        // Combo Box
        private void tabPage1_comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Prc_Set_Property_Control(newRowIndex);
        }

        // Event Handle
        private void tab_action_TabIndexChanged(object sender, EventArgs e)
        {
            MessageBox.Show("Tab index changed");
        }    

        #endregion

        #region PRC_FNC      

        private DataRow Prc_GetCurrentRow(DataGridView dgv)
        {
            DataRowView drv = null;
            try
            {
                if (dgv.CurrentRow == null) { return null; }
                if (dgv.CurrentRow.DataBoundItem == null) { return null; }
                drv = (DataRowView)dgv.CurrentRow.DataBoundItem;
            }
            catch
            {
                return null;
            }
            return drv.Row;
        }

        private void Prc_ktra_du_lieu(string p_short_name, RfcDestination p_sap, string p_table_name)
        {
            string _query = @"SELECT rowid, a.* FROM " + p_table_name + @" a WHERE short_name = '" + p_short_name + "'";
            DataTable _dt = _ora.exeQuery(_query);
            int _so_ban_ghi_loi = 0;
            //string v_error_code = ""; // Biến lưu chuỗi mã lỗi
            string v_pck = null;

            // Modify
            DateTime v_ngay_chot = (DateTime)this.dgrTaxOffice.CurrentRow.Cells["cl_ky_no_den"].Value;
            //MessageBox.Show(v_ngay_chot.ToString("dd-MMM-yyyy"));
            //string v_ky_chot_dl = v_ngay_chot.Year.ToString() + v_ngay_chot.Month + v_ngay_chot.Day;
            string v_ky_chot_dl = v_ngay_chot.ToString("yyyy/MM/dd");
            v_ky_chot_dl = v_ky_chot_dl.Replace("/", "");
            string v_tax_code = this.dgrTaxOffice.CurrentRow.Cells["cl_tax_code"].Value.ToString();

            _ora.TransStart();

            int count = 0;

            try
            {
                // Xóa dữ liệu cũ
                _query = null;
                _query += "DELETE FROM tb_data_error WHERE short_name='";
                _query += p_short_name;
                _query += "' AND table_name='";
                _query += p_table_name + "'";
                _ora.TransExecute(_query);

                _query = "DELETE FROM tb_unsplit_data_error WHERE short_name = '" + p_short_name + "' AND table_name = '" + p_table_name + "'";
                _ora.TransExecute(_query);

                if (p_table_name.Equals("TB_NO"))
                {
                    count = 0;

                    v_pck = "PRC_KTRA_NO";

                    // Content: kiểm tra dữ liệu theo yêu cầu bổ sung
                    // Sử dụng các thủ tục trong Oracle để kiểm tra dữ liệu
                    _query = "call PCK_CHECK_DATA.prc_ktra_du_lieu_no('" + p_short_name + "', '" + v_ngay_chot.ToString("dd-MMM-yyyy") + "')";
                    _ora.exeQuery(_query);

                    // Modify by ManhTV3 on 14/03/2012
                    // Content: Sử dụng hàm check dữ liệu trong SAP để kiểm tra dữ liệu
                    StringBuilder _ins_query = new StringBuilder();
                    _ins_query.Append("BEGIN ");
                    for (int i = 0; i < _dt.Rows.Count; i++)
                    {

                        string v_error_code = ""; // Errors code

                        DataRow _dr = _dt.Rows[i];

                        v_error_code = TKTQ_CHECK_DATA.Prc_check_data_no(p_short_name, _dr, p_sap);

                        if (!v_error_code.Equals(""))
                        {
                            _ins_query.Append(@"INSERT INTO tb_unsplit_data_error(short_name, rid, table_name, err_string)
                                                    VALUES ('" + p_short_name + "', '"
                                                                   + _dr["ROWID"].ToString() + "', '"
                                                                   + p_table_name + "', '"
                                                                   + v_error_code + "');");
                        }
                        count++;
                    }
                    _ins_query.Append(" dbms_output.put_line('Successful'); END;");
                    _ora.TransExecute(_ins_query.ToString());
                }
                else if (p_table_name.Equals("TB_PS"))
                {
                    count = 0;
                    
                    v_pck = "PRC_KTRA_PS";

                    // Content: kiểm tra dữ liệu theo yêu cầu bổ sung
                    _query = "call PCK_CHECK_DATA.prc_ktra_du_lieu_ps('" + p_short_name + "', '" + v_ngay_chot.ToString("dd-MMM-yyyy") + "')";
                    _ora.exeQuery(_query);

                    // Modify by ManhTV3 on 14/03/2012
                    // Content: Sử dụng hàm check dữ liệu trong SAP để kiểm tra dữ liệu
                    StringBuilder _ins_query = new StringBuilder();
                    _ins_query.Append("BEGIN ");
                    for (int i = 0; i < _dt.Rows.Count; i++)
                    {
                        string v_error_code = ""; // Errors code

                        DataRow _dr = _dt.Rows[i];

                        v_error_code = TKTQ_CHECK_DATA.Prc_check_data_ps(p_short_name, _dr, p_sap);

                        if (!v_error_code.Equals(""))
                        {
                            _ins_query.Append(@"INSERT INTO tb_unsplit_data_error(short_name, rid, table_name, err_string)
                                                    VALUES ('" + p_short_name + "', '"
                                                                   + _dr["ROWID"].ToString() + "', '"
                                                                   + p_table_name + "', '"
                                                                   + v_error_code + "');");
                        }
                        count++;
                    }
                    _ins_query.Append(" dbms_output.put_line('Successful'); END;");
                    _ora.TransExecute(_ins_query.ToString());
                }
                else
                {
                    count = 0;
                    v_pck = "PRC_KTRA_TK";

                    // Content: kiểm tra dữ liệu theo yêu cầu bổ sung
                    _query =
                        "call PCK_CHECK_DATA.prc_ktra_du_lieu_tk('" + p_short_name + "', '"
                                                                    + v_ngay_chot.ToString("dd-MMM-yyyy") + "')";
                    _ora.exeQuery(_query);

                    // Modify by ManhTV3 on 14/03/2012
                    // Content: Sử dụng hàm check dữ liệu trong SAP để kiểm tra dữ liệu
                    StringBuilder _ins_query = new StringBuilder();
                    _ins_query.Append("BEGIN ");
                    for (int i = 0; i < _dt.Rows.Count; i++)
                    {
                        string v_error_code = ""; // Errors code

                        DataRow _dr = _dt.Rows[i];

                        v_error_code =
                            TKTQ_CHECK_DATA.Prc_check_data_tk10(p_short_name, v_tax_code, _dr, p_sap, v_ky_chot_dl);

                        if (!v_error_code.Equals(""))
                        {
                            _ins_query.Append(@"INSERT INTO tb_unsplit_data_error(short_name, rid, table_name, err_string)
                                                    VALUES ('" + p_short_name + "', '"
                                                                   + _dr["ROWID"].ToString() + "', '"
                                                                   + p_table_name + "', '"
                                                                   + v_error_code + "');");
                        }
                        count++;
                    }
                    _ins_query.Append(" dbms_output.put_line('Successful'); END;");
                    _ora.TransExecute(_ins_query.ToString());
                }

                _query = "call PCK_CHECK_DATA.prc_insert_splitted_err('" + p_short_name + "', '" + p_table_name + "')";
                _ora.TransExecute(_query);

                // Ghi log
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                // Ghi log
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                _ora.TransRollBack();
                AddToListView(2, "    + Rows: " + count + "/" + _dt.Rows.Count);
                AddToListView(0, "    + Error: " + e.Message.ToString());
            }
        }
        
        // Khởi tạo môi trường        
        private void Prc_khoiTaoMoiTruong(string v_short_name)
        {
            TKTQ_PCK_ORA_QLT.Prc_QLTQCT_DonDep_MoiTruong(v_short_name, this);
            TKTQ_PCK_ORA_QLT.Prc_QLTQCT_KhoiTao_MoiTruong(v_short_name, this);
        }

        // Dọn dẹp môi trường        
        private void Prc_donDepMoiTruong(string v_short_name)
        {
            TKTQ_PCK_ORA_QLT.Prc_QLTQCT_DonDep_MoiTruong(v_short_name, this);
        }

        // Kết xuất
        private void Prc_Ketxuat_Bienban(string p_short_name)
        {
            // KHỞI TẠO
            _ora.TransStart();
            string v_path_open = null;
            string v_path_save = null;
            string _query = null;
            string v_pck = "PRC_KXUAT_BBAN1";
            try
            {
                v_path_open += CLS_FILE.Fnc_Get_Current_Folder();
                v_path_open += @"\_LIB\TEMPLATE\TEMP_BienBanDoiChieu_Lan1.doc";

                v_path_save += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT\" + p_short_name.Substring(0, 3) + @"\02_ChuyenDoiDuLieu\01_BienBanDoiChieuLan1\" + p_short_name;
                CLS_FILE.Prc_Create_Folder(v_path_save);

                // THỰC HIỆN THỦ TỤC KẾT XUẤT
                TKTQ_EXTRACT.Prc_BienBan(v_path_open,
                                         v_path_save,
                                         p_short_name
                                         );
                // Ghi log                
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                
                // Ghi log
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                AddToListView(0, "    + Error: " + e.Message.ToString());
                _ora.TransCommit();
            }          
        }

        // Kết xuất biên bản lần 2
        private void Prc_Ketxuat_Bienban2(string p_short_name)
        {            
            // KHỞI TẠO
            _ora.TransStart();
            string v_path_open = null;
            string v_path_save = null;
            string _query = null;
            string v_pck = "PRC_KXUAT_BBAN2";
            try
            {
                v_path_open += CLS_FILE.Fnc_Get_Current_Folder();
                v_path_open += @"\_LIB\TEMPLATE\TEMP_BienBanDoiChieu_Lan2.doc";

                v_path_save += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT\" + p_short_name.Substring(0, 3) + @"\02_ChuyenDoiDuLieu\02_BienBanDoiChieuLan2\" + p_short_name;
                CLS_FILE.Prc_Create_Folder(v_path_save);

                // THỰC HIỆN THỦ TỤC KẾT XUẤT
                TKTQ_EXTRACT.Prc_BienBan2(v_path_open,
                                         v_path_save,
                                         p_short_name
                                         );
                // Ghi log
                
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                // Ghi log                
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '" + v_pck + "', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                AddToListView(0, "    + Error: " + e.Message.ToString());
                _ora.TransCommit();
            }           
        }

        private void Prc_KetXuat_Slech(string p_short_name)
        {
            string _query = null;
            _ora.TransStart();
            try
            {
                string _sourcePath = null;
                string _destinPath = null;
                string _filename = "TEMP_DuLieuSaiLech";
                string _extenfile = ".xls";

                _sourcePath += CLS_FILE.Fnc_Get_Current_Folder();
                _sourcePath += @"\_LIB\TEMPLATE\" + _filename + _extenfile;

                _destinPath += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT\" + p_short_name.Substring(0, 3) + @"\" + p_short_name + @"\NHAN";
                CLS_FILE.Prc_Create_Folder(_destinPath);
                _destinPath += @"\" + _filename.Replace("TEMP", p_short_name) + "_";
                _destinPath += String.Format("{0:yyMMdd}", DateTime.Now) + _extenfile;

                //Ket xuat du lieu sai lech
                TKTQ_EXTRACT.Prc_SaiLech(_sourcePath, _destinPath, p_short_name);

                // Ghi Log                                
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_SLECH', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {                
                // Ghi log
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_SLECH', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                AddToListView(0, "   + " + e.Message.ToString());
                _ora.TransCommit();
            }           
        }

        private void Prc_KetXuat_BCao_CHoa()
        {            
            try
            {
                string _sourcePath = null;
                string _destinPath = null;
                string _filename = "TEMP_BC_ChuanHoa";
                string _extenfile = ".xls";

                _sourcePath += CLS_FILE.Fnc_Get_Current_Folder();
                _sourcePath += @"\_LIB\TEMPLATE\" + _filename + _extenfile;

                _destinPath += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT";
                CLS_FILE.Prc_Create_Folder(_destinPath);
                _destinPath += @"\" + _filename.Replace("TEMP_", "");
                _destinPath += String.Format("{0:yyMMdd}", DateTime.Now) + _extenfile;

                TKTQ_EXTRACT.Prc_Bcao_Chuan_Hoa(_sourcePath, _destinPath);
            }
            catch (Exception e)
            {                
                AddToListView(0, "   + " + e.Message.ToString());
            }            
        }

        private void Prc_KetXuat_CTiet(string p_short_name)
        {
            string _query = null;
            _ora.TransStart();
            try
            {
                string _sourcePath = null;
                string _destinPath = null;
                string _filename = "TEMP_DuLieuChiTiet";
                string _extenfile = ".xls";

                _sourcePath += CLS_FILE.Fnc_Get_Current_Folder();
                _sourcePath += @"\_LIB\TEMPLATE\" + _filename + _extenfile;

                _destinPath += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT\" + p_short_name.Substring(0, 3) + @"\02_ChuyenDoiDuLieu\01_BienBanDoiChieuLan1\" + p_short_name;
                CLS_FILE.Prc_Create_Folder(_destinPath);
                _destinPath += @"\" + _filename.Replace("TEMP", p_short_name) + "_";
                _destinPath += String.Format("{0:yyMMdd}", DateTime.Now) + _extenfile;

                TKTQ_EXTRACT.Prc_ChiTiet(_sourcePath, _destinPath, p_short_name);

                // Ghi Log                                
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_CTIET', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {                
                // Ghi log
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_CTIET', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                AddToListView(0, "    + Error: " + e.Message.ToString());
                _ora.TransCommit();
            }           
        }

        // #KEYWORD: PHỤ LỤC
        private void Prc_KetXuat_ChuyenDoiLoi(string p_short_name)
        {
            string _query = null;
            _ora.TransStart();
            try
            {
                string _sourcePath = null;
                string _destinPath = null;

                _sourcePath += CLS_FILE.Fnc_Get_Current_Folder() + @"\_LIB\TEMPLATE\";
                _destinPath += CLS_FILE.Fnc_Get_Current_Folder() + @"\_EXPORT\" + p_short_name;
                CLS_FILE.Prc_Create_Folder(_destinPath);

                string _filename = "TEMP_Phuluc";
                string _extenfile = ".xls";
                
                _sourcePath += _filename + _extenfile;
                _destinPath += @"\" + _filename.Replace("TEMP", p_short_name) + "_";
                _destinPath += String.Format("{0:yyMMdd}", DateTime.Now) + _extenfile;

                TKTQ_EXTRACT.Prc_ChuyenDoiLoi(_sourcePath, _destinPath, p_short_name);

                // Ghi Log                                
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_PLUC', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {                
                // Ghi log
                _query = null;
                _query += "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', 'PRC_KXUAT_PLUC', 'N', '";
                _query += e.Message.ToString().Replace("'", "\"") + "')";
                _ora.TransExecute(_query);
                AddToListView(0, "    + Error: " + e.Message.ToString());
                _ora.TransCommit();
            }            
        }

        private void Prc_Remove_Existed_File(int p_index)
        {
            try
            {
                string _path_destination, _user_destination, _password_destination;

                // Xác định cấu hình máy đích
                _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim();
                _user_destination = "administrator";
                _password_destination = "12345a@";

                PinvokeWindowsNetworking.connectToRemote(_path_destination, _user_destination, _password_destination);

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

        private void Prc_Copy_To_Destination_Machine(int p_index)
        {

            #region Xác định các tham số copy file
            // Biến lưu thông tin cấu hình máy nguồn
            string _path_source, _user_source, _password_source;
            // Biến lưu thông tin cấu hình máy đích
            string _path_destination, _user_destination = "", _password_destination = "";
            DateTime _ky_chot; // Biến lưu trữ kỳ chốt dữ liệu phát sinh
            // Xác định thời điểm lấy dữ liệu phát sinh
            _ky_chot = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_chot"].Value;
            // Xác định cấu hình máy nguồn
            _path_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_tu"].Value.ToString().Trim();
            _user_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_user"].Value.ToString().Trim();
            _password_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_pass"].Value.ToString().Trim();
            // Xác định cấu hình máy đích            
            _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim();
            //CLS_DTNT.Prc_Targetes_Server_Parameter(ref _user_destination, ref _password_destination);
            _user_destination = "administrator";
            _password_destination = "12345a@";
            PinvokeWindowsNetworking.connectToRemote(_path_source, _user_source, _password_source);
            PinvokeWindowsNetworking.connectToRemote(_path_destination, _user_destination, _password_destination);
            // Xác định thư mục chứa dữ liệu
            DirectoryInfo _dir_destination = new DirectoryInfo(_path_destination);
            // Xác định tên của cơ quan thuế
            string _tax_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_tax_name"].Value.ToString().Trim();
            string _short_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_short_name"].Value.ToString().Trim();
            int _so_file = 0;
            string _query;
            #endregion
            string v_pck = "FNC_COPY_FILE";

            _ora.TransStart();
            try
            {
                #region File DTNT
                _so_file = CLS_COPY_FILE.Fnc_copy_file_dtnt(_path_source,
                                                        _dir_destination,
                                                        _tax_name,
                                                        _short_name,
                                                        this);                
                #endregion
                #region ĐTNT nghỉ
                // Dữ liệu ĐTNT nghỉ 
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_nghi(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);                
                #endregion
                #region File DMBPQL
                // Danh mục bộ phận quản lý
                _so_file = CLS_COPY_FILE.Fnc_copy_file_dmbpql(_path_source,
                                                         _dir_destination,
                                                         _tax_name,
                                                         _short_name,
                                                         this);                
                #endregion
                #region File Khóa sổ
                // Khóa sổ
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_khoaso(_path_source,
                                                    _dir_destination,
                                                    _tax_name,
                                                    _short_name,
                                                    this);                
                #endregion
                #region File DM nghành nghề
                //// Danh muc nghanh nghe

                //    _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_DMNN(_path_source,
                //                                        _dir_destination,
                //                                        _tax_name,
                //                                        _short_name,
                //                                        this);
                //    if (_so_file != -1)
                //        AddToListView(2, "  + Số file danh mục nghành nghề đã copy: " + _so_file + " files");

                #endregion
                #region file TKDN
                // Phát sinh quý
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_tkdnyyyy(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);                
                #endregion
                #region file QDAD
                // Quyết định ấn định, bãi bỏ ấn định
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_qdad(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);                
                #endregion
                #region Nợ
                // Dữ liệu nợ     
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_no(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);                
                #endregion
                #region DKNTK
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_dkntk(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);
                #endregion
                #region DM tờ khai
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_dmtokhai(GlobalVar.gl_dirDANHMUCVATW,
                                                    _dir_destination,
                                                    _tax_name,
                                                    _short_name,
                                                    this);
                #endregion
                #region Tờ khai môn bài
                // Chi tiết tờ khai môn bài
                _so_file = CLS_COPY_FILE.Fnc_copy_file_MBCT(_path_source,
                                                      _dir_destination,
                                                      _ky_chot,
                                                      _tax_name,
                                                      _short_name,
                                                      this);
                // File dữ liệu master tờ khai môn bài 
                _so_file = CLS_COPY_FILE.Fnc_copy_file_TKMB(_path_source,
                                                         _dir_destination,
                                                         _ky_chot,
                                                         _tax_name,
                                                         _short_name,
                                                         this);
                #endregion
                #region File TK
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_tk(_path_source,
                                                      _dir_destination,
                                                      _ky_chot,
                                                      _tax_name,
                                                      _short_name,
                                                      this);
                #endregion
                #region File sổ thuế
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_st(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);
                #endregion
                #region File DA
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_DA(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);
                #endregion
                #region File KH
                _so_file = DC.Vatwin.CLS_COPY_FILE.Fnc_copy_file_kh(_path_source,
                                                    _dir_destination,
                                                    _ky_chot,
                                                    _tax_name,
                                                    _short_name,
                                                    this);
                #endregion
                //Ghi log
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                            + v_pck + "', 'Y', null)";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
            catch (Exception e)
            {
                //Ghi log
                _query = null;
                _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                            + v_pck + "', 'N', '" + e.Message + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }

        }

        private void Prc_Read_Data_VATW(int p_index)
        {
            // Xác định thông tin của cơ quan thuế
            // Tên viết tắt của cơ quan thuế
            string _short_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_short_name"].Value.ToString().Trim();
            string _tax_name = this.dgrTaxOffice.Rows[p_index].Cells["cl_tax_name"].Value.ToString().Trim();
            string _tax_code = this.dgrTaxOffice.Rows[p_index].Cells["cl_tax_code"].Value.ToString().Trim();

            DateTime _ky_chot; // Biến lưu trữ kỳ chốt
            DateTime _ky_ps_tu;
            DateTime _ky_ps_den;
            // Xác định thời điểm lấy dữ liệu phát sinh
            _ky_chot= (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["cl_ky_chot"].Value;
            _ky_ps_tu = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["ky_ps_tu"].Value;
            _ky_ps_den = (DateTime)this.dgrTaxOffice.Rows[p_index].Cells["ky_ps_den"].Value;            
            // Xác định cấu hình máy nguồn
            string _path = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString().Trim().Replace("\\", "\\\\");
            string _user = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_user"].Value.ToString().Trim();
            string _password = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_pass"].Value.ToString().Trim();

            // Đăng nhập vào máy chứa file dữ liệu
            PinvokeWindowsNetworking.connectToRemote(_path, _user, _password);

            // Biến lưu số bản ghi
            int _rowsnum = 0;

            // Biến lưu số bản ghi người phụ thuộc chi tiết của tờ khai 10
            int rowsnum = 0;

            string _query;

            //Tientm: Bo sung kiem tra khoa so

            string flages = "Y";

            DirectoryInfo _dir_source = new DirectoryInfo(_path);

            if ((this.ckb_kt_khoa_so.Checked)
                || (this.ckb_doc_file_danh_muc.Checked)
                || (this.ckb_doc_file_ps.Checked)
                || (this.ckb_doc_file_no.Checked)
                || (this.ckb_doc_file_tkmb.Checked)
                || (this.ckb_doc_file_dkntk.Checked)
                || (this.ckb_doc_file_ckt.Checked)
                || (this.ckb_doc_file_cctt.Checked)
                )
            {                
                #region Kiểm tra điều kiện khóa sổ
                _ora.TransStart();

                string v_pck = "FNC_CHECK_KS";
                try
                {
                    flages = CLS_DTNT.Prc_kiem_tra_dieu_kien_khoa_so(_short_name,
                                                   _tax_name,
                                                   _tax_code,
                                                   _path,
                                                   _dir_source,
                                                   this,
                                                   ref _ky_chot);
                    if (flages == "N")
                    {                        
                        string _message = "Ứng dụng VAT chưa khóa sổ kỳ " + _ky_chot.ToString().Trim().Substring(3, 7);
                        this.AddToListView(0, "   + " + _short_name + ": " + _message);

                        _message = "øng dông VAT ch­a kho¸ sæ kú " + _ky_chot.ToString().Trim().Substring(3, 7);
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                    + v_pck + "', 'N', '" + _message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                        return;
                    }
                    else
                    {                        
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }
                catch (Exception e)
                {   
                    AddToListView(0, "  + Lỗi: " + e.Message);
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                    return;
                }
                #endregion
            }

            if (this.ckb_doc_file_danh_muc.Checked)
            {
                #region Đọc dữ liệu danh mục
                _ora.TransStart();
                string v_pck = "FNC_READ_DM";
                try
                {
                    CLS_DTNT.Prc_doc_danh_muc(_short_name,
                                                   _tax_name,
                                                   _tax_code,
                                                   _path,
                                                   _dir_source,
                                                   this
                                                   );
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                #endregion
            }

            if (this.ckb_doc_file_ps.Checked)
            {
                #region Phát sinh
                _ora.TransStart();
                string v_pck = "FNC_READ_PS";
                // Xóa dữ liệu cũ trong bảng TB_PS
                try
                {
                    _rowsnum = DC.Vatwin.CLS_PS.Fnc_xoa_du_lieu_ps_cu(_short_name, _tax_name, this);
                    
                    _rowsnum = DC.Vatwin.CLS_PS.Fnc_doc_file_ps_thang(_short_name,
                                                                      _tax_name,
                                                                      _tax_code,
                                                                      _ky_chot,
                                                                      _ky_ps_tu,
                                                                      _ky_ps_den,
                                                                      _path,
                                                                      _dir_source,
                                                                      this);

                    _rowsnum = DC.Vatwin.CLS_PS.Fnc_doc_file_ps_quy(_short_name,
                                                                    _tax_name,
                                                                    _tax_code,
                                                                    _ky_chot,
                                                                    _ky_ps_tu,
                                                                    _ky_ps_den,
                                                                    _path,
                                                                    _dir_source,
                                                                    this);

                    _rowsnum = DC.Vatwin.CLS_PS.Fnc_doc_file_qdad(_short_name,
                                                                  _tax_name,
                                                                  _tax_code,
                                                                  _ky_chot,
                                                                  _ky_ps_tu,
                                                                  _ky_ps_den,
                                                                  _path,
                                                                  _dir_source,
                                                                  this);
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }

                #endregion
            }

            if (this.ckb_doc_file_no.Checked)
            {
                #region Nợ
                _ora.TransStart();
                string v_pck = "FNC_READ_NO";

                // Xóa dữ liệu nợ cũ
                try
                {
                    _rowsnum = DC.Vatwin.CLS_NO.Fnc_xoa_du_lieu_no_cu(_short_name, _tax_name, this);
                    if (_rowsnum != -1)
                        AddToListView(2, "  + Dữ liệu nợ cũ đã xóa: " + _rowsnum + " bản ghi");

                    _rowsnum = DC.Vatwin.CLS_NO.Fnc_doc_file_no(_short_name,
                                                                    _tax_name,
                                                                    _tax_code,
                                                                    ref _ky_chot,
                                                                    _path,
                                                                    _dir_source,
                                                                    this,
                                                                    ref flages);

                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                #endregion
            }

            if (this.ckb_doc_file_tkmb.Checked)
            {
                #region Tờ khai môn bài
                _ora.TransStart();
                string v_pck = "FNC_READ_TKMB";
                // Xóa dữ liệu tờ khai môn bài
                //try
                //{
                    _rowsnum = CLS_TKMB.Fnc_xoa_du_lieu_tkmb(_short_name, _tax_name, this);
                 
                    CLS_TKMB.Fnc_doc_file_tkmb(_short_name,
                                             _tax_name,
                                             _tax_code,
                                             _path,
                                             _dir_source,
                                             _ky_chot,                                                                                       
                                             this,
                                             ref _rowsnum,
                                             ref rowsnum);
                    // Cập nhật mã bậc môn bài theo TMS
                    CLS_TKMB.Fnc_cap_nhat_bmb();

                   //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                //}
                //catch (Exception e)
                //{
                //    //Ghi log
                //    _query = null;
                //    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                //                                                + v_pck + "', 'N', '" + e.Message + "')";
                //    _ora.TransExecute(_query);
                //    _ora.TransCommit();
                //}
                #endregion
            }
             
            if (this.ckb_doc_file_dkntk.Checked)
            {
                #region ĐKNTK
                _ora.TransStart();
                string v_pck = "FNC_READ_DKNTK";
                // Xóa dữ liệu cũ
                try
                {
                    _rowsnum = DC.Vatwin.CLS_DKNTK.Fnc_xoa_du_lieu_dkntk(_short_name, _tax_name, this);
                                   
                    _rowsnum = 0;
                    DC.Vatwin.CLS_DKNTK.Fnc_doc_file_dkntk(_short_name,
                                                                    _tax_name,
                                                                    _tax_code,
                                                                    ref _ky_chot,
                                                                    _path,
                                                                    _dir_source,
                                                                    this);                  
                
                    _rowsnum = DC.Vatwin.CLS_DKNTK.Fnc_ghi_du_lieu_dkntk(_short_name);
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                #endregion
            }

            if (this.ckb_doc_file_ckt.Checked)
            {
                #region CKT
                _ora.TransStart();
                string v_pck = "FNC_READ_CKT";
                // Xóa dữ liệu cũ
                try
                {
                    _rowsnum = DC.Vatwin.CLS_CKT.Fnc_xoa_du_lieu_ckt(_short_name, _tax_name, this);
                    if (_rowsnum != -1)
                        AddToListView(2, "  + Dữ liệu CKT đã xóa: " + _rowsnum + " bản ghi");

                    _rowsnum = 0;
                    DC.Vatwin.CLS_CKT.Fnc_doc_file_ckt_01(_short_name,
                                                                    _tax_name,
                                                                    _tax_code,
                                                                    _ky_chot,
                                                                    _path,
                                                                    _dir_source,
                                                                    this);

                    _rowsnum = 0;
                    DC.Vatwin.CLS_CKT.Fnc_doc_file_ckt_02(_short_name,
                                                                    _tax_name,
                                                                    _tax_code,
                                                                    _ky_chot,
                                                                    _path,
                                                                    _dir_source,
                                                                    this);

                    _rowsnum = DC.Vatwin.CLS_CKT.Fnc_ghi_du_lieu_ckt_02(_short_name);

                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                #endregion
            }

            if (this.ckb_doc_file_cctt.Checked)
            {
                #region CKT
                _ora.TransStart();
                string v_pck = "FNC_READ_CCTT";
                // Xóa dữ liệu cũ
                try
                {
                    _rowsnum = DC.Vatwin.CLS_CCTT.Fnc_xoa_du_lieu_cctt(_short_name, _tax_name, this);
                   

              
                    _rowsnum = 0;
                    DC.Vatwin.CLS_CCTT.Fnc_doc_file_cctt(_short_name,
                                                         _tax_name,
                                                         _tax_code,
                                                         _path,
                                                         _dir_source,
                                                         _ky_chot,
                                                         this
                                                         );
                    DC.Vatwin.CLS_CCTT.Fnc_Cap_nhat_01TKH(_short_name);

                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                #endregion
            }

            if (this.ckb_capnhat_tinhchat.Checked)
            {
                // Đọc dữ liệu 
                string v_pck = "FNC_READ_TCNO";
                _ora.TransStart();
                try
                {
                    #region chuyen QTN
                    TKTQ_PCK_ORA_QTN.Fnc_get_qtn_so_no(_short_name);

                    #endregion

                    #region Cap nhat tinh c hat no

                    TKTQ_PCK_ORA_QTN.Fnc_update_tc_no(_short_name);
                    #endregion

                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                catch (Exception e)
                {
                    //Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + _short_name + "', '"
                                                                + v_pck + "', 'N', '" + e.Message + "')";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
            }
               

            if ((this.ckb_doc_file_danh_muc.Checked)
                 || (this.ckb_doc_file_ps.Checked)
                 || (this.ckb_doc_file_no.Checked)
                 || (this.ckb_doc_file_tkmb.Checked)
                 || (this.ckb_doc_file_dkntk.Checked)
                 || (this.ckb_doc_file_ckt.Checked)
                 || (this.ckb_doc_file_cctt.Checked)
                 )
            {
                #region Cập nhật danh mục
                try
                {
                    flages = CLS_DTNT.Fnc_Capnhatdanhmuc(_short_name);
                    if (flages == "N")
                        return;
                }
                catch (Exception e)
                {
                    AddToListView(0, "  + Thủ tục Prc_Capnhatdanhmuc có lỗi: " + e.Message);
                    return;
                }
                #endregion
            }
        }

        private void Prc_hthi_tt_may_tram(int p_index)
        {
            {
                string _path_source, _user_source, _password_source;
                string _path_destination, _user_destination = "" , _password_destination = "";

                // Xác định cấu hình máy nguồn chứa file dữ liệu cần sao chép
                _path_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_tu"].Value.ToString();
                _user_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_user"].Value.ToString();
                _password_source = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_pass"].Value.ToString();

                // Xác định cấu hình máy đích chứa file dữ liệu sao chép
                _path_destination = this.dgrTaxOffice.Rows[p_index].Cells["cl_vat_ddan_den"].Value.ToString();
                /*_user_destination = "dci";
                _password_destination = "1209";*/
                CLS_DTNT.Prc_Targetes_Server_Parameter(ref _user_destination, ref _password_destination);

                // Khởi tạo giá trị VATWIN trên form
                this.tb_path_source.Text = _path_source;
                this.tb_user_source.Text = _user_source;
                this.tb_pass_source.Text = _password_source;

                this.tb_path_destination.Text = _path_destination;
                //this.tb_user_destination.Text = _user_destination;
                //this.tb_password_destination.Text = _password_destination;

                this.tb_folder.Text = _path_destination;
                //this.tb_user.Text = _user_destination;
                //this.tb_password.Text = _password_destination;
            }
        }
        #endregion

        // Thực hiện
        private void Thuc_hien_Click(object sender, EventArgs e)
        {
            // Modify by ManhTV3 on 3/5/2012
            // Content: Xác định danh sách cơ quan thuế được chọn trên dgrTaxOffice
            string _tax_model = "";            
            arr_dr.Clear();
            arr_index.Clear();
            for (int i = 0; i < this.dgrTaxOffice.SelectedCells.Count; i++)
            {
                int _index = this.dgrTaxOffice.SelectedCells[i].RowIndex;
                if(arr_index.Contains(_index) == false)
                {
                    arr_index.Add(_index);
                    DataRowView drv = (DataRowView)this.dgrTaxOffice.Rows[_index].DataBoundItem;                    
                    
                    arr_dr.Add(drv.Row);
                    _tax_model += this.dgrTaxOffice.Rows[_index].Cells["CL_TAX_MODEL"].Value.ToString();
                }
            }            
            if ((_tax_model.Contains("VAT") && _tax_model.Contains("QCT"))
                || (_tax_model.Contains("VAT") && _tax_model.Contains("QLT")))
            {
                AddToListView(0, "Không thể thực hiện công việc cho các cơ quan thuế có cả loại hình QLT/QCT và VAT");
                return;
            }

            BackgroundWorker bw = new BackgroundWorker();
            bw.WorkerSupportsCancellation = true;
            bw.WorkerReportsProgress = true;
            bw.DoWork += new DoWorkEventHandler(bw_DoWork);
            bw.ProgressChanged += new ProgressChangedEventHandler(bw_ProgressChanged);
            bw.RunWorkerCompleted += new RunWorkerCompletedEventHandler(bw_RunWorkerCompleted);

            this.Enabled = false;
            //v_dr = Prc_GetCurrentRow(this.dgrTaxOffice);
                                    
            //if (v_dr[6].ToString().Equals("VAT") && this.tab_action.SelectedIndex == 1)
            //    v_vatwin_selected_tab = this.tab_vatwin.SelectedIndex;
            //else
            //    v_vatwin_selected_tab = -1;

            this.tab_action.SelectedIndex = 7;
            this.progressBar1.Visible = true;
            v_combo_value = this.tabPage1_comboBox1.SelectedValue.ToString();
            v_combo_value_pnn = this.pnn_comboBox1.SelectedValue.ToString();

            if (bw.IsBusy != true)
            {
                bw.RunWorkerAsync();
            }
        }
        private void bw_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {            
            //AddToListView(2,(e.ProgressPercentage.ToString() + "%" + "  dang thuc hien" + e.UserState));            
        }
        private void bw_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if ((e.Cancelled == true))
            {
                //MessageBox.Show("Canceled");
            }
            else if (!(e.Error == null))
            {
                AddToListView(0, "    + Error: " + e.Error.Message);
            }
            else
            {
                AddToListView(2, "    + Hoàn thành việc xử lý");
                this.dgrTaxOffice.DataSource = null;
                Prc_Fill_Dgr();
                this.dgrTaxOffice.DataSource = this.bndSource;
                this.dgrTaxOffice.Refresh();
                this.Enabled = true;
                this.progressBar1.Visible = false;
                this.tab_action.SelectedTab = this.tab_log;
            }
        }
        private void bw_DoWork(object sender, DoWorkEventArgs e)
        {
            // Modify by ManhTV3 on 3/5/2012
            BackgroundWorker worker = sender as BackgroundWorker;
            for (int i = 0; i < arr_dr.Count; i++)
            {                
                v_dr = (DataRow)arr_dr[i];
                v_index = (int)arr_index[i];

                AddToListView(2, "Bắt đầu việc xử lý của " + v_dr[1].ToString());

                this.Enabled = false;
                BackgroundWorker _worker = sender as BackgroundWorker;
                
                // Reset log
                if (this.ckb_reset_log.Checked)
                {
                    using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
                    {
                        string _tax_model = v_dr[6].ToString().Trim();
                        string _short_name = v_dr[1].ToString();
                        _ora.TransStart();
                        string _query = "call pck_trace_log.Prc_reset_log('" + _short_name + "','" + _tax_model + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }
        
                #region Cơ quan thuế QLT, QCT
                if (v_dr[6].ToString().Equals("QLT") || v_dr[6].ToString().Equals("QCT"))
                {
                    // Kiểm tra môi trường
                    if (this.ckb_ktao.Checked)
                    {
                        // Khởi tạo môi trường
                        AddToListView(2, "Khởi tạo môi trường");
                        Prc_khoiTaoMoiTruong(v_dr[1].ToString());
                    }
                    else if ((this.ckb_ddep.Checked)) //|| (this.ckb_mt_vatwin.Checked))
                    {
                        // Dọn dẹp môi trường
                        AddToListView(2, "Dọn dẹp môi trường");
                        Prc_donDepMoiTruong(v_dr[1].ToString());
                    }
                    else 
                    {
                        if ((this.ckb_check_kychot.Checked)
                            || (this.ckb_qlt_ps.Checked)
                            || (this.ckb_qlt_no.Checked)
                            || (this.ckb_qlt_ckt.Checked)
                            || (this.ckb_qlt_tkmb.Checked)
                            || (this.ckb_qlt_dkntk.Checked)
                            || (this.ckb_qlt_slech_no.Checked)
                            || (this.ckb_qct_no.Checked)
                            ||(this.ckb_qct_tkmb.Checked)
                            ||(this.ckb_qct_dkntk.Checked)
                            ||(this.ckb_qct_cctt.Checked)
                            ||(this.ckb_qct_slech_no.Checked))
                        {
                            // Kiểm tra kỳ chốt
                            AddToListView(2, "Kiểm tra kỳ chốt");
                            TKTQ_PCK_ORA_QLT.Prc_Ktra_Kchot(v_dr[1].ToString());
                        }
                        // Tổng hợp dữ liệu nợ, phát sinh, tờ khai 10
                        #region TH dữ liệu
                        if (v_combo_value == "TH")
                        {
                            // Tổng hợp dữ liệu phát sinh
                            if (this.ckb_qlt_ps.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp dữ liệu phát sinh");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QltPs(v_dr[1].ToString());
                            }
                            // Tổng hợp dữ liệu nợ
                            if (this.ckb_qlt_no.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp dữ liệu nợ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QltNo(v_dr[1].ToString());
                            }
                            // Tổng hợp dữ liệu ckt
                            if (this.ckb_qlt_ckt.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp dữ liệu còn khấu trừ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QltCkt(v_dr[1].ToString());
                            }
                            // Tổng hợp dữ liệu TKMB
                            if (this.ckb_qlt_tkmb.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp dữ liệu tờ khai môn bài");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QltTKMB(v_dr[1].ToString());
                            }
                            // Tổng hợp dữ liệu DKNTK
                            if (this.ckb_qlt_dkntk.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp dữ liệu đăng ký nộp tờ khai");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QltDKNTK(v_dr[1].ToString());
                            }
                            if (this.ckb_qlt_slech_no.Checked)
                            {
                                AddToListView(2, "QLT - Tổng hợp sai lệch sổ nợ với sổ thu nộp");
                                TKTQ_PCK_ORA_QLT.Prc_Qlt_Slech_No(v_dr[1].ToString());
                            }

                            if (this.ckb_qct_no.Checked)
                            {
                                AddToListView(2, "QCT - Tổng hợp dữ liệu nợ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QctNo(v_dr[1].ToString());
                            }
                            if (this.ckb_qct_tkmb.Checked)
                            {
                                AddToListView(2, "QCT - Tổng hợp dữ liệu TKMB");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QctTKMB(v_dr[1].ToString());
                            }
                            if (this.ckb_qct_dkntk.Checked)
                            {
                                AddToListView(2, "QCT - Tổng hợp dữ liệu ĐKNTK");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QctDKNTK(v_dr[1].ToString());
                            }
                            if (this.ckb_qct_cctt.Checked)
                            {
                                AddToListView(2, "QCT - Tổng hợp dữ liệu CCTT");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_QctCCTT(v_dr[1].ToString());
                            }

                            if (this.ckb_qct_slech_no.Checked)
                            {
                                AddToListView(2, "QCT - Tổng hợp sai lệch sổ nợ với sổ thu nộp");
                                TKTQ_PCK_ORA_QLT.Prc_Qct_Slech_No(v_dr[1].ToString());
                            }

                        }
                        #endregion

                        #region Kết chuyển dữ liệu
                        else if (v_combo_value == "CV")
                        {
                            // Lấy dữ liệu phát sinh đã tổng hợp
                            if (this.ckb_qlt_ps.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển dữ liệu phát sinh");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQltPs(v_dr[1].ToString());
                            }
                            // Lấy dữ liệu nợ đã tổng hợp
                            if (this.ckb_qlt_no.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển dữ liệu nợ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQltNo(v_dr[1].ToString());
                            }

                            if (this.ckb_qlt_ckt.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển dữ liệu còn khấu trừ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQltCkt(v_dr[1].ToString());
                            }
                            if (this.ckb_qlt_tkmb.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển dữ liệu TKMB");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQltTKMB(v_dr[1].ToString());
                            }
                            if (this.ckb_qlt_dkntk.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển dữ liệu ĐKNTK");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQltDKNTK(v_dr[1].ToString());
                            }
                            if (this.ckb_qlt_slech_no.Checked)
                            {
                                AddToListView(2, "QLT - Chuyển sai lệch sổ nợ với sổ thu nộp");
                                TKTQ_PCK_ORA_QLT.Prc_Qlt_Get_Slech_No(v_dr[1].ToString());
                            }

                            if (this.ckb_qct_no.Checked)
                            {
                                AddToListView(2, "QCT - Chuyển dữ liệu nợ");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQctNo(v_dr[1].ToString());
                            }

                            if (this.ckb_qct_tkmb.Checked)
                            {
                                AddToListView(2, "QCT - Chuyển dữ liệu TKMB");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQctTKMB(v_dr[1].ToString());
                            }

                            if (this.ckb_qct_dkntk.Checked)
                            {
                                AddToListView(2, "QCT - Chuyển dữ liệu ĐKNTK");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQctDKNTK(v_dr[1].ToString());
                            }
                            if (this.ckb_qct_cctt.Checked)
                            {
                                AddToListView(2, "QCT - Chuyển dữ liệu CCTT");
                                TKTQ_PCK_ORA_QLT.Prc_QLT_GetQctCCTT(v_dr[1].ToString());
                            }
                            if (this.ckb_qct_slech_no.Checked)
                            {
                                AddToListView(2, "QCT - Chuyển sai lệch sổ nợ với sổ thu nộp");
                                TKTQ_PCK_ORA_QLT.Prc_Qct_Get_Slech_No(v_dr[1].ToString());
                            }
                            if (this.ckb_error.Checked)
                            {
                                AddToListView(2, "Chuyển log");
                                TKTQ_PCK_ORA_QLT.Prc_QLTQCT_GetLog(v_dr[1].ToString());
                            }
                        }
                        #endregion                       
                    }
                }
                #endregion

                #region Cơ quan thuế VAT
                if (v_dr[6].ToString().Equals("VAT"))
                {
                    if (this.ckb_copy_file.Checked)
                    {   // Chuyển các file trong thư mục cũ sang thư mục BK tương ứng.
                        Prc_Remove_Existed_File(v_index);
                        // Chuyển các file từ máy của các cơ quan thuế về máy trạm
                        Prc_Copy_To_Destination_Machine(v_index);
                    }
                    
                    // Chuyển dữ liệu vào hệ thống
                    Prc_Read_Data_VATW(v_index);
                }        
                #endregion

                #region Ứng dụng QTN
                //Tạo DB link kết nối đến QTN cho tất cả các loại CQT
                if (this.ckb_tao_DB_link.Checked)
                {
                    string v_pck = "PRC_KTAO_QTN";
                    string _query;
                    _ora.TransStart();
                    try
                    {
                        AddToListView(2, "QTN - Tạo DB link QTN");
                        TKTQ_PCK_ORA_QTN.Prc_Create_DB_Link(v_dr[1].ToString());

                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                    catch (Exception e1)
                    {
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'N', '" + e1.Message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }                

                //Số tính phạt trên QTN cho tất cả các loại CQT
                if (this.ckb_chuyen_tinh_phat.Checked)
                {
                    string v_pck = "PRC_QTN_GET_TPHAT";
                    string _query;
                    _ora.TransStart();
                    try
                    {
                        AddToListView(2, "QTN - Tổng hợp số tính phạt");
                        TKTQ_PCK_ORA_QTN.Fnc_get_tinh_phat(v_dr[1].ToString());
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                    catch (Exception e1)
                    {
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'N', '" + e1.Message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }
                #endregion

                #region Ứng dụng PNN
                if (this.ckb_ktao_pnn.Checked)
                {
                    AddToListView(2, "PNN - Khởi tạo môi trường");
                    TKTQ_PCK_ORA_PNN.Prc_KhoiTao_MoiTruong(v_dr[1].ToString());
                }

                if (this.ckb_ddep_pnn.Checked)
                {
                    AddToListView(2, "PNN - Dọn dẹp môi trường");
                    TKTQ_PCK_ORA_PNN.Prc_DonDep_MoiTruong(v_dr[1].ToString());
                }

                if (v_combo_value_pnn == "TH")
                {

                    if (this.ckb_pnn_no.Checked)
                    {
                        AddToListView(2, "PNN - Tổng hợp nợ");
                        TKTQ_PCK_ORA_PNN.Prc_TH_No(v_dr[1].ToString());
                    }
                }

                if (v_combo_value_pnn == "CV")
                {

                    if (this.ckb_pnn_no.Checked)
                    {
                        AddToListView(2, "PNN - Chuyển dữ liệu nợ");
                        TKTQ_PCK_ORA_PNN.Prc_Get_No(v_dr[1].ToString());
                    }
                    if (this.ckb_pnn_tk01.Checked)
                    {
                        AddToListView(2, "PNN - Chuyển dữ liệu tờ khai 01/TK-SDDPNN");
                        TKTQ_PCK_ORA_PNN.Prc_Get_tk01(v_dr[1].ToString());
                    }
                    if (this.ckb_pnn_tk02.Checked)
                    {
                        AddToListView(2, "PNN - Chuyển dữ liệu tờ khai 02/TK-SDDPNN");
                        TKTQ_PCK_ORA_PNN.Prc_Get_tk02(v_dr[1].ToString());
                    }
                }

                #endregion

                #region Đọc dữ liệu nhập ngoài
                if (this.ckb_nhap_ngoai_no.Checked)
                {
                    string v_pck = "PRC_NN_GET_NO";
                    string _query;
                    _ora.TransStart();
                    try
                    {
                        AddToListView(2, "Đọc dữ liệu nợ nhập ngoài");
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_read_no(v_dr[1].ToString());
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_tong_hop_no(v_dr[1].ToString());
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                    catch (Exception e1)
                    {
                        //Ghi log 
                        string _message = e1.Message.Replace("'", "''");
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'N', '" + _message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }

                if (this.ckb_nhap_ngoai_ps.Checked)
                {
                    string v_pck = "PRC_NN_GET_PS";
                    string _query;
                    _ora.TransStart();
                    try
                    {
                        AddToListView(2, "Đọc dữ liệu phát sinh nhập ngoài");
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_read_ps(v_dr[1].ToString());
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_tong_hop_ps(v_dr[1].ToString());
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                    catch (Exception e1)
                    {                        
                        //Ghi log 
                        string _message = e1.Message.Replace("'", "''");
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'N', '" + _message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }

                if (this.ckb_nhap_ngoai_ckt.Checked)
                {
                    string v_pck = "PRC_NN_GET_CKT";
                    string _query;
                    _ora.TransStart();
                    try
                    {
                        AddToListView(2, "Đọc dữ liệu còn khấu trừ nhập ngoài");
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_read_ckt(v_dr[1].ToString());
                        TKTQ_PCK_ORA_NHAP_NGOAI.Fnc_tong_hop_ckt(v_dr[1].ToString());
                        //Ghi log
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'Y', null)";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                    catch (Exception e1)
                    {
                        //Ghi log 
                        string _message = e1.Message.Replace("'", "''");
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + v_dr[1].ToString() + "', '"
                                                                    + v_pck + "', 'N', '" + _message + "')";
                        _ora.TransExecute(_query);
                        _ora.TransCommit();
                    }
                }
                #endregion

                #region Check Data                
                if (this.ckb_check_no.Checked)
                {
                    AddToListView(2, "  - Kiểm tra dữ liệu nợ");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_NO(v_dr[1].ToString());
                }

                if (this.ckb_check_ps.Checked)
                {
                    AddToListView(2, "  - Kiểm tra dữ liệu phát sinh");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_PS(v_dr[1].ToString());
                }
                if (this.ckb_check_tkmb.Checked)
                {
                    AddToListView(2, "  - Kiểm tra dữ liệu tờ khai môn bài");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_TKMB(v_dr[1].ToString());
                }

                if (this.ckb_check_ckt.Checked)
                {
                    AddToListView(2, "Check - Kiểm tra dữ liệu nợ");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_CKT(v_dr[1].ToString());
                }

                if (this.ckb_check_dkntk.Checked)
                {
                    AddToListView(2, "  - Kiểm tra dữ liệu đăng ký nộp tờ khai");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_DKNTK(v_dr[1].ToString());
                }
                if (this.ckb_check_tkkh.Checked)
                {
                    AddToListView(2, "  - Kiểm tra dữ liệu tờ khai khoán");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_TKKH(v_dr[1].ToString());
                }
                if (this.ckb_check_TK_PNN.Checked)
                {
                    AddToListView(2, "Check - Kiểm tra dữ liệu tờ khai phi nông nghiệp");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_TK_PNN(v_dr[1].ToString());
                }
                if (this.ckb_check_tphat.Checked)
                {
                    AddToListView(2, "Check - Kiểm tra dữ liệu tính phạt");
                    TKTQ_PCK_ORA_CHECKDATA.Prc_CHECK_TPH(v_dr[1].ToString());
                }

                #endregion
                
                #region Kết xuất
                if (this.ckb_kxu_loi.Checked)
                {
                    AddToListView(2, "Kết xuất sai lệch");
                    Prc_KetXuat_Slech(v_dr[1].ToString());
                }
                            

                if (this.ckb_kxu_ctiet.Checked)
                {
                    AddToListView(2, "Kết xuất chi tiết");
                    Prc_KetXuat_CTiet(v_dr[1].ToString());
                }
                if (this.ckb_kxu_cdloi.Checked)
                {
                    AddToListView(2, "Kết xuất chi tiết dữ liệu chuyển đổi lỗi");
                    Prc_KetXuat_ChuyenDoiLoi(v_dr[1].ToString());
                }
                if (this.ckb_kxu_bban.Checked)
                {
                    AddToListView(2, "Kết xuất biên bản lần 1");
                    Prc_Ketxuat_Bienban(v_dr[1].ToString());
                }
                if (this.ckb_kxu_bban2.Checked)
                {
                    AddToListView(2, "Kết xuất biên bản lần 2");
                    Prc_Ketxuat_Bienban2(v_dr[1].ToString());
                }
                #endregion
                          
                AddToListView(2, "    + Kết thúc việc xử lý của " + v_dr[1].ToString());
                v_dr = null;
            }
        }

        private void dgrTaxOffice_DoubleClick(object sender, EventArgs e)
        {
            return;
            //Frm_Inf _frm_Inf = new Frm_Inf(v_dr[1].ToString().Trim());
            //_frm_Inf.Text = "   [" + v_dr[1].ToString() + "] Thống Kê Chi Tiết";
            //_frm_Inf.Show();
        }

        private void dgrTaxOffice_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void tab_action_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }    
}
