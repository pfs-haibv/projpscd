using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using DC.Utl;
using System.Diagnostics;
using DC.Lib;
using System.Data;

namespace DC.Forms
{
    public partial class Main : System.Windows.Forms.Form
    {

        public Main() {
            this.InitializeComponent();
        }

        private void ExitToolsStripMenuItem_Click(object sender, EventArgs e) {
            Application.Exit();
        }

        // Mẫu gọi Form trong menu
        //private void báoCáoToolStripMenuItem_Click(object sender, EventArgs e)
        //{
        //    if (CLS_FORM.Func_check_form_exists("Frm_Report") != null)
        //    {
        //        CLS_FORM.LoadFormChild(CLS_FORM.Func_check_form_exists("Frm_Report"), this);
        //    }
        //    else
        //    {
        //        Frm_Report _Frm_Report = new Frm_Report();
        //        CLS_FORM.LoadFormChild(_Frm_Report, this);
        //    }
        //}

        private void QLTCD_ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            const string _c_frm_name = "Frm_QLCD";

            if (CLS_FORM.Func_check_form_exists(_c_frm_name) != null)
            {
                CLS_FORM.LoadFormChild(CLS_FORM.Func_check_form_exists(_c_frm_name), this);
            }
            else
            {                
                try
                {                    
                    Frm_QLCD _Frm_QLCD = new Frm_QLCD();                    
                    CLS_FORM.LoadFormChild(_Frm_QLCD, this);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        private void importFileExcelToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                string _query = @"SELECT *
                                    FROM tb_01_para a
                                   WHERE a.rv_group = 'JAVA'
                                ORDER BY a.id";
                DataTable _dt = _ora.exeQuery(_query);

                string cmd = _dt.Rows[0]["rv_chr"].ToString();
                string cmdParams = _dt.Rows[1]["rv_chr"].ToString();
                string workingDirectory = _dt.Rows[2]["rv_chr"].ToString();
                int timeout = Int32.Parse(_dt.Rows[3]["rv_chr"].ToString());

                using (Process process = Process.Start(new ProcessStartInfo(cmd, cmdParams)))
                {
                    process.StartInfo.WorkingDirectory = workingDirectory;
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    process.Start();
                    process.StandardOutput.ReadToEnd();
                    process.WaitForExit(timeout);
                }
            }
        }        

        private void HTDC_ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            const string _c_frm_name = "Frm_HTDC";

            if (CLS_FORM.Func_check_form_exists(_c_frm_name) != null)
            {
                CLS_FORM.LoadFormChild(CLS_FORM.Func_check_form_exists(_c_frm_name), this);
            }
            else
            {
                try
                {
                    Frm_HTDC _Frm_HTDC = new Frm_HTDC();
                    CLS_FORM.LoadFormChild(_Frm_HTDC, this);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }  
    }
}
