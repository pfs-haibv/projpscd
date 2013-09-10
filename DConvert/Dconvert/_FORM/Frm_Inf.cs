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
            Prc_Fill_DgrBC();
            Prc_Fill_DgrStatus();
            Prc_Fill_DgrLog();
        }

        private void Prc_Fill_DgrBC()
        {
            string _query =
            @"    SELECT loai, tax_model, ma_tkhai, tmt_ma_tmuc, 
                         trim(to_char(sotien_duong,'999,999,999,999,999')) sotien_duong, 
                         trim(to_char(sotien_am,'999,999,999,999,999')) sotien_am, 
                         trim(to_char(sotien,'999,999,999,999,999')) sotien, 
                         trim(to_char(sl,'999,999,999,999,999')) sl    
                    FROM (
                  SELECT 'PS' loai, a.tax_model tax_model, MAX(a.ma_tkhai) ma_tkhai, 
                         NULL tmt_ma_tmuc, 
                         SUM(a.sotien_duong) sotien_duong,
                         SUM(a.sotien_am) sotien_am, 
                         SUM(a.so_tien) sotien, COUNT(1) sl
                    FROM (
                           select tax_model,
                                  ma_tkhai,
                                  decode(so_tien-abs(so_tien), 0,so_tien,0) sotien_duong,
                                  decode(so_tien-abs(so_tien), 0,0,so_tien) sotien_am,
                                  so_tien                  
                             from tb_ps where short_name = '&1'
                         ) a, tb_lst_tkhai b
                   WHERE a.ma_tkhai = b.ma_tkhai
                GROUP BY a.tax_model, a.ma_tkhai
                UNION ALL
                  SELECT 'NO' loai, a.tax_model tax_model, NULL ma_tkhai,
                         a.tmt_ma_tmuc tmt_ma_tmuc, 
                         SUM(a.sotien_duong) sotien_duong, 
                         SUM(a.sotien_am) sotien_am,
                         SUM(a.sotien) sotien,
                         COUNT (1) sl
                    FROM (
                           select tax_model,
                                  tmt_ma_tmuc,
                                  decode(no_cuoi_ky-abs(no_cuoi_ky), 0,no_cuoi_ky,0) sotien_duong,
                                  decode(no_cuoi_ky-abs(no_cuoi_ky), 0,0,no_cuoi_ky) sotien_am,
                                  no_cuoi_ky sotien
                             from tb_no where short_name = '&1'
                         ) a
                GROUP BY a.tax_model, a.tmt_ma_tmuc
                UNION ALL
                  SELECT   'TK' loai, tax_model, NULL ma_tkhai, NULL tmt_ma_tmuc,
                           SUM(decode(dthu_dkien-abs(dthu_dkien), 0, dthu_dkien,0)) sotien_duong,
                           SUM(decode(dthu_dkien-abs(dthu_dkien), 0, 0,dthu_dkien)) sotien_am,
                           SUM(dthu_dkien) sotien, COUNT (1) sl
                      FROM tb_tk
                     WHERE short_name = '&1'
                  GROUP BY tax_model
                HAVING COUNT (tin) > 0
                         )
                ORDER BY loai, 
                         SUBSTR(tax_model, 1, 3) DESC,
                         SUBSTR(tax_model, -3),
                         ma_tkhai, tmt_ma_tmuc";
           
            _query = _query.Replace("&1", v_short_name);
 
            //DataTable _dt = _ora.exeQuery(_query);

            //for (int i = 0; i < _dt.Rows.Count; i++)
            //{
            //    DataRow _dr = _dt.Rows[i];

            //    ListViewItem lvi = new ListViewItem(_dr["loai"].ToString());
            //    lvi.SubItems.Add(_dr["tax_model"].ToString());
            //    lvi.SubItems.Add(_dr["ma_tkhai"].ToString());
            //    lvi.SubItems.Add(_dr["tmt_ma_tmuc"].ToString());
            //    lvi.SubItems.Add(_dr["sotien_duong"].ToString());
            //    lvi.SubItems.Add(_dr["sotien_am"].ToString());
            //    lvi.SubItems.Add(_dr["sotien"].ToString());
            //    lvi.SubItems.Add(_dr["sl"].ToString());
            //    //lvi.SubItems.Add((Double.Parse(_dr["sotien_duong"].ToString())).ToString("0,0", CultureInfo.InvariantCulture));
            //    //lvi.SubItems.Add(String.Format("{0,0}", _dr["sotien_duong"].ToString()));
            //    //lvi.SubItems.Add((Double.Parse(_dr["sotien_am"].ToString())).ToString("0,0", CultureInfo.InvariantCulture));
            //    //lvi.SubItems.Add((Double.Parse(_dr["sotien"].ToString())).ToString("0,0", CultureInfo.InvariantCulture));
            //    //lvi.SubItems.Add((Double.Parse(_dr["sl"].ToString())).ToString("0,0", CultureInfo.InvariantCulture));

            //    this.lvwBC.Items.Add(lvi);
            //}
            
            //_dt = null;
        }

        private void Prc_Fill_DgrStatus()
        {            
            string _query = @"SELECT decode(a.id_name, 'Null', 'Y', b.status) status,
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
                                AND c.tax_model = a.tax_model)
                           ORDER BY a.stt";

            DataTable _dt = _ora.exeQuery(_query);            

            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                DataRow _dr = _dt.Rows[i];

                ListViewItem lvi = new ListViewItem(_dr["status_name"].ToString());
                lvi.SubItems.Add(_dr["status"].ToString());
                lvi.SubItems.Add(_dr["where_log"].ToString());
                lvi.SubItems.Add(_dr["err_code"].ToString());

                this.lvwStatus.Items.Add(lvi);
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

        
    }
}
