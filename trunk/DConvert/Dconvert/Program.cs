using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using SAP.Middleware.Connector;
using System.Data;
using DC.Utl;
using DC.Lib.Objects;
using DC.Lib;

namespace DC
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new DC.Forms.Main());
            Application.Run(new DC.Forms.Frm_QLCD());
            
            // Test connect to group/server selection
            //using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            //{
            //try
            //{
            //    InMemoryDestinationConfiguration v_DestConfig = new InMemoryDestinationConfiguration();
            //    RfcDestinationManager.RegisterDestinationConfiguration(v_DestConfig);
            //    //v_DestConfig.AddOrEditDestination("DE1", 1, "thanhnh5", "12345a@", "EN", "211", "10.15.119.18", "23");                    
            //    v_DestConfig.AddOrEditDestination("QLT-TNCN",
            //        100,
            //        "DC_DEV01",
            //        "1234567",
            //        "EN",
            //        "500",                    
            //        "guitncn.tct.vn",
            //        "10.64.85.12",
            //        "PE1-GROUP");
            //    RfcDestination v_sap = RfcDestinationManager.GetDestination("QLT-TNCN");

            //    string _query = "SELECT * FROM tb_ps WHERE short_name = 'HCM'";
            //    DataTable _dt = _ora.exeQuery(_query);

            //    for (int i = 0; i < _dt.Rows.Count; i++)
            //    {
            //        string _error_code = Utl.TKTQ_CHECK_DATA.Prc_check_data_ps("HCM", _dt.Rows[i] , v_sap);
            //        //MessageBox.Show(_error_code);
            //        //if (_error_code.Equals("") == false)
            //            //MessageBox.Show(_error_code);
            //    }
            //    MessageBox.Show("done");
            //}
            //catch (Exception e)
            //{
            //    MessageBox.Show(e.Message);
            //}
            //}
        }
    }
}
