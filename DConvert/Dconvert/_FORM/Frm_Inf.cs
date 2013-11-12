using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DC.Lib;
using DC.Utl;
using System.Globalization;

namespace DC.Forms
{
    public partial class Frm_Inf : Form
    {
        private static string v_short_name;

        // Tạo kết nối tới cơ sở dữ liệu trung gian
        private static CLS_DBASE.ORA _ora;

        public Frm_Inf()
        {
            InitializeComponent();
        }

        public Frm_Inf(string p_short_name)
        {            
            v_short_name = p_short_name;
            _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);

            InitializeComponent();
        }

        #region FORM CONTROL

        private void Frm_Inf_Load(object sender, EventArgs e)
        {
            //Prc_Fill_DgrBC();
            Prc_Fill_DgrStatus();
            //Prc_Fill_DgrLog();
        }

        private void Prc_Fill_DgrStatus()
        {
            string _query;

            _query = @"SELECT decode(a.id_name, 'Null', 'Y', b.status) status,
                                                     a.id_name status_name, b.where_log, b.err_code
                                                FROM tb_lst_stacqt a, ( SELECT c.pck, c.status, d.tax_model,
                                                                               c.where_log, c.err_code 
                                                                          FROM tb_log_pck c, tb_lst_taxo d
                                                                         WHERE c.short_name = d.short_name 
                                                                           AND c.ltd = 0 
                                                                           AND c.short_name = '" + v_short_name + @"') b
                                               WHERE a.func_name = b.pck(+) 
                                                 AND EXISTS ( SELECT 1 
                                                                FROM tb_lst_taxo c 
                                                               WHERE c.short_name = '" + v_short_name + @"' 
                                                                 AND (c.tax_model = a.tax_model or a.tax_model = '*'))
                                            ORDER BY a.stt";

            DataTable _dt = _ora.exeQuery(_query);            

            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                DataRow _dr = _dt.Rows[i];

                ListViewItem lvi = new ListViewItem(_dr["status_name"].ToString());
                lvi.SubItems.Add(_dr["status"].ToString());
                lvi.SubItems.Add(_dr["where_log"].ToString());
                lvi.SubItems.Add(_dr["err_code"].ToString());

                this.lvwLog.Items.Add(lvi);
            }
            _dt = null;
        }

        private void Prc_Fill_DgrLog()
        {
            string _query = @"SELECT a.short_name, a.pck, a.status, a.timestamp, a.error_stack
                                FROM tb_errors a
                               WHERE a.short_name = '" + v_short_name + "'";

            DataTable _dt = _ora.exeQuery(_query);

            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                DataRow _dr = _dt.Rows[i];

                ListViewItem lvi = new ListViewItem(_dr["pck"].ToString());
                lvi.SubItems.Add(_dr["status"].ToString());
                lvi.SubItems.Add(_dr["timestamp"].ToString());
                lvi.SubItems.Add(_dr["error_stack"].ToString());

                this.lvwLog.Items.Add(lvi);
            }

            _dt = null;
        }

        public void setInf(string p_inf)
        {
            this.lb_inf.Text = p_inf;
        }
        #endregion

        private void lvwBC_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
        {

        }

    }
}
