using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Windows.Forms;
using System.IO;
using System.Security.Principal;
using System.Runtime.InteropServices;
using SAP.Middleware.Connector;
using System.ComponentModel;
using System.Reflection;
// Modify by ManhTV3 on 5/12/2011
using DC.Lib;
using DC.Lib.Objects;
using Oracle.DataAccess.Client;

namespace DC.Utl
{
    // Các công cụ thao tác với Number
    class CLS_NUM
    {
        // Kiểm tra Number
        public static bool IsNumeric(string NumericText)
        {
            bool isnumber = true;
            foreach (char c in NumericText.Replace("-",""))
            {
                isnumber = char.IsNumber(c);
                if (!isnumber)
                {
                    return isnumber;
                }
            }
            return isnumber;
        }

        // Kiểm tra Number, coi 0 ko phải number
        public static bool IsNumeric_notZero(string NumericText)
        {
            bool isnumber = true;
            foreach (char c in NumericText.Replace("-", ""))
            {
                isnumber = char.IsNumber(c);
                if ((!isnumber))
                {
                    return isnumber;
                }
            }
            isnumber = NumericText == "0" ? false : true;
            return isnumber;
        }
    }

    // Các công cụ phục vụ cho Font
    class CLS_FONT
    {
        private static char[] tcvnchars = {
            'µ', '¸', '¶', '·', '¹', 
            '¨', '»', '¾', '¼', '½', 'Æ', 
            '©', 'Ç', 'Ê', 'È', 'É', 'Ë', 
            '®', 'Ì', 'Ð', 'Î', 'Ï', 'Ñ', 
            'ª', 'Ò', 'Õ', 'Ó', 'Ô', 'Ö', 
            '×', 'Ý', 'Ø', 'Ü', 'Þ', 
            'ß', 'ã', 'á', 'â', 'ä', 
            '«', 'å', 'è', 'æ', 'ç', 'é', 
            '¬', 'ê', 'í', 'ë', 'ì', 'î', 
            'ï', 'ó', 'ñ', 'ò', 'ô', 
            '­', 'õ', 'ø', 'ö', '÷', 'ù', 
            'ú', 'ý', 'û', 'ü', 'þ', 
            '¡', '¢', '§', '£', '¤', '¥', '¦'
        };

        private static char[] unichars = {
            'à', 'á', 'ả', 'ã', 'ạ', 
            'ă', 'ằ', 'ắ', 'ẳ', 'ẵ', 'ặ', 
            'â', 'ầ', 'ấ', 'ẩ', 'ẫ', 'ậ', 
            'đ', 'è', 'é', 'ẻ', 'ẽ', 'ẹ', 
            'ê', 'ề', 'ế', 'ể', 'ễ', 'ệ', 
            'ì', 'í', 'ỉ', 'ĩ', 'ị', 
            'ò', 'ó', 'ỏ', 'õ', 'ọ', 
            'ô', 'ồ', 'ố', 'ổ', 'ỗ', 'ộ', 
            'ơ', 'ờ', 'ớ', 'ở', 'ỡ', 'ợ', 
            'ù', 'ú', 'ủ', 'ũ', 'ụ', 
            'ư', 'ừ', 'ứ', 'ử', 'ữ', 'ự', 
            'ỳ', 'ý', 'ỷ', 'ỹ', 'ỵ', 
            'Ă', 'Â', 'Đ', 'Ê', 'Ô', 'Ơ', 'Ư'
        };

        private static char[] convertTable;

        public static string Fnc_TCVN3ToUNICODE(string value)
        {
            convertTable = new char[256];
            for (int i = 0; i < 256; i++)
                convertTable[i] = (char)i;
            for (int i = 0; i < tcvnchars.Length; i++)
                convertTable[tcvnchars[i]] = unichars[i];

            char[] chars = value.ToCharArray();
            for (int i = 0; i < chars.Length; i++)
                if (chars[i] < (char)256)
                {
                    chars[i] = convertTable[chars[i]];
                }
            return new string(chars);
        }
    }

    // Thiết lập kết nối với các Database
    class CLS_DBASE
    {
        public class ORA : IDisposable
        {
            private string _connstring;

            private OleDbConnection _connection = null;
            private OleDbDataAdapter _adapter = null;
            private OleDbCommand _command = null;
            private OleDbTransaction _trans;

            // Khởi tạo cho class

            public OleDbConnection Connection
            {
                set { this._connection = value; }
                get { return this._connection; }
            }
                
            public ORA(string p_connString)
            {               
                this._connstring = p_connString;
                this._connection = new OleDbConnection(this._connstring);
                this._connection.Open();
                this._command = this._connection.CreateCommand();
                this._adapter = new OleDbDataAdapter(_command);
            }
            
            // Thực hiện truy vấn dữ liệu, giá trị trả về là DataTable
            public DataTable exeQuery(string p_query)
            {
                return exeQuery(p_query, 0,10000);
            }            
            public DataTable exeQuery(string p_query, int _startRecord, int _maxRecords)
            {
                this._command.CommandText = p_query;
                this._command.CommandType = CommandType.Text;
                DataTable _table = new DataTable();
                this._adapter.Fill(_startRecord, _maxRecords, _table);
                return _table;
            }

            // Thực hiện cho update,insert and delete
            public int exeUpdate(string p_query)
            {
                this._command.CommandText = p_query;
                this._command.CommandType = CommandType.Text;
                return this._command.ExecuteNonQuery();              
            }

            public void TransStart()
            {
                this._trans = this._connection.BeginTransaction(IsolationLevel.ReadCommitted);
            }

            public void TransExecute(String strSQL)
            {
                this._command.Transaction = this._trans;
                _command.CommandType = CommandType.Text;
                _command.CommandText = strSQL;
                _command.ExecuteNonQuery();
            }

            // Return DataTable -------------------------------------------- 
            public DataTable TransExecute_DataTable(String p_query)
            {
                this._command.Transaction = this._trans;
                this._command.CommandText = p_query;
                this._command.CommandType = CommandType.Text;                
                DataTable _dt = new DataTable();
                this._adapter.Fill(_dt);
                return _dt;
            }
            public void TransRollBack()
            {
                this._trans.Rollback();
            }
            public void TransCommit()
            {
                this._trans.Commit();
            }
            public void close()
            {
                if (this._connection.State == ConnectionState.Open)
                {
                    this._connection.Close();
                }
            }
            private bool IsDisposed = false;

            public void Free()
            {
                if (IsDisposed) throw new System.ObjectDisposedException("Object Name");
            }
            public void Dispose()
            {
                Dispose(true);
                //If dispose is called already then say GC to skip finalize on this instance.
                GC.SuppressFinalize(this);
                close();
            }
            ~ORA()
            {
                Dispose(false);
            }

            protected virtual void Dispose(bool disposedStatus)
            {
                if (!IsDisposed)
                {
                    IsDisposed = true;
                    // Released unmanaged Resources
                    if (disposedStatus){}
                }
            }
        }

        public class FOX : IDisposable
        {
            string _connstring;

            private OleDbConnection _connection = null;
            private OleDbDataAdapter _adapter = null;
            private OleDbCommand _command = null;

            // Khởi tạo cho class
            public FOX(string p_pathDB)
            {
                this._connstring = @"PROVIDER=VFPOLEDB.1;Data Source=" + p_pathDB; ;
                this._connection = new OleDbConnection(this._connstring);
                this._connection.Open();
                this._command = this._connection.CreateCommand();
                this._adapter = new OleDbDataAdapter(_command);
            }

            // Thực hiện truy vấn dữ liệu, giá trị trả về là DataTable
            public DataTable exeQuery(string p_query)
            {
                this._command.CommandText = p_query;
                this._command.CommandType = CommandType.Text;
                DataTable _table = new DataTable();
                this._adapter.Fill(_table);
                return _table;
            }

            // Thực hiện cho update,insert and delete
            public int exeUpdate(string p_query)
            {
                this._command.CommandText = p_query;
                this._command.CommandType = CommandType.Text;
                return this._command.ExecuteNonQuery();
            }

            public void close()
            {
                if (this._connection.State == ConnectionState.Open)
                {
                    this._connection.Close();
                }
            }

            private bool IsDisposed = false;

            public void Free()
            {
                if (IsDisposed) throw new System.ObjectDisposedException("Object Name");
            }
            public void Dispose()
            {
                Dispose(true);
                //If dispose is called already then say GC to skip finalize on this instance.
                GC.SuppressFinalize(this);
                close();
            }
            ~FOX()
            {
                Dispose(false);
            }

            protected virtual void Dispose(bool disposedStatus)
            {
                if (!IsDisposed)
                {
                    IsDisposed = true;
                    // Released unmanaged Resources
                    if (disposedStatus){}
                }
            }
        }

        public static void WriteToServer(string connstring, string qualifiedDBName, DataTable dataTable)
        {                
                /*using (OracleBulkCopy bulkCopy = new OracleBulkCopy(connstring))
                {
                    bulkCopy.DestinationTableName = qualifiedDBName;
                    bulkCopy.WriteToServer(dataTable);
                }*/
        }
     }

    // Thiết lập các thuộc tính cho Form
    class CLS_FORM
    {
        public static void setFormParrent(System.Windows.Forms.Form pForm)
        {
            pForm.MaximizeBox = true;
        }

        public static void setFormChild(System.Windows.Forms.Form pForm)
        {           
            pForm.WindowState = FormWindowState.Maximized;
            pForm.ControlBox = false;
        }

        public static void LoadFormChild(System.Windows.Forms.Form pForm, System.Windows.Forms.Form pMasterForm)
        {         
            pForm.MdiParent = pMasterForm;         
            setFormChild(pForm);            
            pForm.Show();
        }

        public static System.Windows.Forms.Form Func_check_form_exists(String pForm_Name)
        {
            System.Windows.Forms.Form v_check = null;

            foreach (System.Windows.Forms.Form ctrl in Application.OpenForms)
            {
                if (ctrl.Name == pForm_Name)
                {
                    v_check = ctrl;
                }
            }
            return v_check;
        }

        public class User_ProgressBar
        {
            internal System.Windows.Forms.ProgressBar myProgressBar = null;
            internal Timer myTimer;
            private int percentPerSecond = 5;

            public User_ProgressBar(ProgressBar myProgressBar)
            {                                
                myTimer = new System.Windows.Forms.Timer(new System.ComponentModel.Container());

                myProgressBar.Dock = System.Windows.Forms.DockStyle.Fill;
                myProgressBar.Name = "myProgressBar";

                myTimer.Tick += new System.EventHandler(this.myTimer_Tick);
            }

            public int PercentPerSecond
            {
                get
                {
                    return percentPerSecond;
                }
                set
                {
                    if (value < 0)
                    {
                        throw new ArgumentException("Progress cannot go backward.");
                    }
                    else if (value == 0)
                    {
                        throw new ArgumentException("Progress must go on.");
                    }
                    percentPerSecond = value;
                }
            }

            public void Start(ProgressBar myProgressBar)
            {
                if (Application.RenderWithVisualStyles)
                {
                    myProgressBar.Style = ProgressBarStyle.Marquee;
                    myProgressBar.MarqueeAnimationSpeed = 50;
                    myTimer.Start();
                }
                else
                {
                    myProgressBar.Style = ProgressBarStyle.Continuous;
                    myProgressBar.Maximum = 100;
                    myProgressBar.Value = 0;
                    myTimer.Enabled = true;
                }
            }

            public void Stop(ProgressBar myProgressBar)
            {
                myTimer.Stop();
                myProgressBar.Style = ProgressBarStyle.Continuous;
                myProgressBar.Maximum = 100;
                myProgressBar.Value = 0;
                myTimer.Enabled = true;
            }

            public void Finish(ProgressBar myProgressBar)
            {
                myTimer.Stop();
                myProgressBar.Value = myProgressBar.Maximum;
            }

            private void myTimer_Tick(object sender, EventArgs e)
            {
                this.myProgressBar.Value += 5;
                if (myProgressBar.Value > 120)
                {
                    myProgressBar.Value = 0;
                }
            }

        }

        public static object getProperty(object containingObject, string propertyName)
        {
            return containingObject.GetType().InvokeMember(propertyName,
                                                           BindingFlags.GetProperty,
                                                           null,
                                                           containingObject,
                                                           null);
        }

        public static void setProperty(object containingObject, string propertyName, object newValue)
        {
            containingObject.GetType().InvokeMember(propertyName, 
                                                    BindingFlags.SetProperty, 
                                                    null, 
                                                    containingObject, 
                                                    new object[] { newValue });
        }
        // Thiết lập thuộc tinh cho p_ctr
        public static void Prc_setPropertyControl(Control p_ctr, string p_ppt, string p_value)
        {
            PropertyInfo _propertyInfo = p_ctr.GetType().GetProperty(p_ppt);
            TypeCode _typeCode = Type.GetTypeCode(_propertyInfo.PropertyType);
            switch (_typeCode)
            {
                case TypeCode.Boolean:
                    _propertyInfo.SetValue(p_ctr, Convert.ToBoolean(p_value), null);
                    break;
                case TypeCode.String:
                    _propertyInfo.SetValue(p_ctr, p_value, null);
                    break;
                case TypeCode.Int16:
                    _propertyInfo.SetValue(p_ctr, Convert.ToInt16(p_value), null);
                    break;
                case TypeCode.DateTime:
                    _propertyInfo.SetValue(p_ctr, Convert.ToDateTime(p_value), null);
                    break;
                default: break;
            }
        }
        // Thiết lập thuộc tính cho hàng loạt _ctrl nằm trong p_control
        public static void Prc_Set_Control(Control p_control, string p_typeControl, string p_ppt, string p_value)
        {
            foreach (Control _ctrl in p_control.Controls)
            {
                if (_ctrl.GetType().Name.ToString() == p_typeControl)
                {
                    Prc_setPropertyControl(_ctrl, p_ppt, p_value);
                }
                Prc_Set_Control(_ctrl, p_typeControl, p_ppt, p_value);
            }
        }
    }

    // Các công cụ thao tác với File
    class CLS_FILE
    {
        // Lấy danh sách các file trong một thư mục
        // Example: 
        // DANS.File v_GetFile = DANS.File.GetFiles("J:\\Projects", "*.sql");
        public static string[] Fnc_GetFiles(string _path, string _ext)
        {
            string[] _files = null;
            try
            {
                _files = Directory.GetFiles(_path, _ext);
            }
            catch (Exception exp)
            {
                System.Windows.Forms.MessageBox.Show("Could not open directory '"
                                                        + _path
                                                        + "'. Error: "
                                                        + exp.Message);
            }
            return _files;
        }

        // Copy tất cả các file từ thư mục "source" sang thư mục "target"
        // mỗi file khi được move xong sẽ rename có gán thêm năm.tháng.ngày.giờ.phút.giây
        // Example:
        // DirectoryInfo v_Source = new DirectoryInfo(this.dgrTaxOffice.CurrentRow.Cells["VAT_PATH_FROM"].Value.ToString().Trim());
        // DirectoryInfo v_Target = new DirectoryInfo(this.dgrTaxOffice.CurrentRow.Cells["VAT_PATH_FROM"].Value.ToString().Trim() + "\\BK");
        // DANS.File.Prc_Move_Bk(v_Source, v_Target);         
        public static void Prc_Move_Bk(DirectoryInfo source, DirectoryInfo target)
        {
            if (source.FullName.ToLower() == target.FullName.ToLower())
            {
                return;
            }

            // Check if the target directory exists, if not, create it.
            if (Directory.Exists(target.FullName) == false)
            {
                Directory.CreateDirectory(target.FullName);
            }
            DirectoryInfo _dir = Directory.CreateDirectory(target.FullName + "\\" + DateTime.Now.ToString("yyMMddHHmmss"));
            
            //else
            //{
            //    Directory.CreateDirectory(target.FullName + "\\" + DateTime.Now.ToString("yyMMddHHmmss"));
            //}

            // Copy each file into it's new directory.
            foreach (FileInfo fi in source.GetFiles())
            {                                
                fi.MoveTo(Path.Combine(_dir.FullName.ToString(), fi.Name));
                
            }
            /*
            // Copy each subdirectory using recursion.
            foreach (DirectoryInfo diSourceSubDir in source.GetDirectories())
            {
                DirectoryInfo nextTargetSubDir =
                    target.CreateSubdirectory(diSourceSubDir.Name);
                Prc_CopyAll(diSourceSubDir, nextTargetSubDir);
            }*/
        }

        public static string Fnc_Get_Current_Folder()
        {
            FileInfo v_folder = new FileInfo(Application.StartupPath);
            return v_folder.Directory.Parent.FullName;
        }

        public static void Prc_Create_Folder(string pPath)
        {
            if (!Directory.Exists(pPath))
            {
                Directory.CreateDirectory(pPath);
            }
        }
    }

    // CLASS: truy cập hệ thống SAP    
    #region CONNECT SAP

    #region EXAMPLE CONNECT SAP
    /*
            Ult.InMemoryDestinationConfiguration v_DestConfig = new Ult.InMemoryDestinationConfiguration();
            // Đăng ký cấu hình hệ thống SAP
            
            RfcDestinationManager.RegisterDestinationConfiguration(v_DestConfig);
            // Cấu hình hệ thống với các tham số             
            // AddOrEditDestination(SYSTEMID, MAXPOOLSIZE = 1, USER, PASS, LANGUAGE, CLIENT, HOST, INSTANTCE_NUMBER)
            v_DestConfig.AddOrEditDestination("DE1", 1, "thanhnh5", "12345a@", "EN", "280", "10.15.119.18", "23");
            
            // Đăng nhập hệ thống
            RfcDestination v_sap = RfcDestinationManager.GetDestination("DE1");
            
            // Need a repository for the metadata from the ABAP Dictionary of the corresponding destination system. 
            RfcRepository v_repo = v_sap.Repository;

            IRfcFunction v_babi = v_repo.CreateFunction("BAPI_COMPANY_GETDETAIL");
            v_babi.SetValue("COMPANYID", "000001");
            v_babi.Invoke(v_sap);
            IRfcStructure v_struc = v_babi.GetStructure("COMPANY_DETAIL");
            
            String companyName = v_struc.GetString("NAME1");
            
            MessageBox.Show(companyName);

            IRfcFunction v_babi = v_repo.CreateFunction("ZBAPI_PSCD_CD_DC");
            
            IRfcStructure v_struc = v_babi.GetStructure("I_DATA");
            v_struc.SetValue("ROW_NUM", 1);
            v_struc.SetValue("DOC_TYPE", "1");
            v_struc.SetValue("TAX_OFFICE_CODE", "1");
            v_struc.SetValue("TIN", "1");
            v_struc.SetValue("PROFIT_CENTER", "1");
            v_struc.SetValue("BUSINESS_AREA", "1");
            v_struc.SetValue("PAY_GROUP", "1");
            v_struc.SetValue("POSTING_DATE", "1");
            v_struc.SetValue("START_PERIOD", "1");
            v_struc.SetValue("END_PERIOD", "1");
            v_struc.SetValue("DUE_DATE", "1");
            v_struc.SetValue("RETURN_CODE", "1");
            v_struc.SetValue("AMOUNT", "1");

            IRfcStructure v_struc_return = v_babi.GetStructure("RETURN");
            MessageBox.Show("TYPE: " + v_struc_return.GetString("TYPE"));
            MessageBox.Show("ID: " + v_struc_return.GetString("ID"));
            MessageBox.Show("NUMBER: " + v_struc_return.GetString("NUMBER"));
            MessageBox.Show("MESSAGE: " + v_struc_return.GetString("MESSAGE"));
            MessageBox.Show("LOG_NO: " + v_struc_return.GetString("LOG_NO"));
            MessageBox.Show("LOG_MSG_NO: " + v_struc_return.GetString("LOG_MSG_NO"));
            MessageBox.Show("MESSAGE_V1: " + v_struc_return.GetString("MESSAGE_V1"));
            MessageBox.Show("MESSAGE_V2: " + v_struc_return.GetString("MESSAGE_V2"));
            MessageBox.Show("MESSAGE_V3: " + v_struc_return.GetString("MESSAGE_V3"));
            MessageBox.Show("MESSAGE_V4: " + v_struc_return.GetString("MESSAGE_V4"));
            MessageBox.Show("PARAMETER: " + v_struc_return.GetString("PARAMETER"));
            MessageBox.Show("ROW: " + v_struc_return.GetString("ROW"));
            MessageBox.Show("FIELD: " + v_struc_return.GetString("FIELD"));
            MessageBox.Show("SYSTEM: " + v_struc_return.GetString("SYSTEM"));           

            v_babi.SetValue("I_DATA", v_struc);            
            v_babi.Invoke(v_sap);

            MessageBox.Show("xong");

            v_DestConfig.RemoveDestination("DE1");
        
        */
    #endregion

    public class InMemoryDestinationConfiguration : IDestinationConfiguration
    {
        Dictionary<string, RfcConfigParameters> availableDestinations;
        RfcDestinationManager.ConfigurationChangeHandler changeHandler;

        public InMemoryDestinationConfiguration()
        {
            availableDestinations = new Dictionary<string, RfcConfigParameters>();
        }

        public RfcConfigParameters GetParameters(string destinationName)
        {
            RfcConfigParameters foundDestination;
            availableDestinations.TryGetValue(destinationName, out foundDestination);
            return foundDestination;
        }

        //our configuration supports events
        public bool ChangeEventsSupported()
        {
            return true;
        }

        public event RfcDestinationManager.ConfigurationChangeHandler ConfigurationChanged
        {
            add
            {
                changeHandler = value;
            }
            remove
            {
                //do nothing
            }
        }

        //removes the destination that is known under the given name
        public void RemoveDestination(string name)
        {
            if (name != null && availableDestinations.Remove(name))
            {
                Console.WriteLine("Successfully removed destination " + name);
                Console.WriteLine("Fire deletion event for destination " + name);
                changeHandler(name, new RfcConfigurationEventArgs(RfcConfigParameters.EventType.DELETED));
            }
        }

        //allows adding or modifying a destination for a specific application server
        public void AddOrEditDestination(string name, int poolSize, string user, string password, string language, string client, string applicationServer, string systemNumber)
        {
            //in productive code the given parameters should be checked for validity, e.g. that name is not null
            //as this is not relevant for the example, we omit it here
            RfcConfigParameters parameters = new RfcConfigParameters();            
            parameters[RfcConfigParameters.Name] = name;
            parameters[RfcConfigParameters.MaxPoolSize] = Convert.ToString(poolSize);
            parameters[RfcConfigParameters.IdleTimeout] = Convert.ToString(6); // we keep connections for 10 minutes
            parameters[RfcConfigParameters.User] = user;
            parameters[RfcConfigParameters.Password] = password;
            parameters[RfcConfigParameters.Client] = client;
            parameters[RfcConfigParameters.Language] = language;
            parameters[RfcConfigParameters.AppServerHost] = applicationServer;
            parameters[RfcConfigParameters.SystemNumber] = systemNumber;            
            RfcConfigParameters existingConfiguration;

            //if a destination of that name existed before, we need to fire a change event
            if (availableDestinations.TryGetValue(name, out existingConfiguration))
            {
                availableDestinations[name] = parameters;
                RfcConfigurationEventArgs eventArgs = new RfcConfigurationEventArgs(RfcConfigParameters.EventType.CHANGED, parameters);
                MessageBox.Show("Fire change event " + eventArgs.ToString() + " for destination " + name);
                changeHandler(name, eventArgs);
            }
            else
            {
                availableDestinations[name] = parameters;
            }

            //MessageBox.Show("Added application server destination " + name);
        }

        //allows adding or modifying a destination for a group/server selection
        public void AddOrEditDestination(string name,
                                         int poolSize,
                                         string user,
                                         string password,
                                         string language,
                                         string client,                                         
                                         string messageServerService,                                         
                                         string messageServerHost,
                                         string logonGroup)
        {
            //in productive code the given parameters should be checked for validity, e.g. that name is not null
            //as this is not relevant for the example, we omit it here            
            RfcConfigParameters parameters = new RfcConfigParameters();
            parameters[RfcConfigParameters.Name] = name;
            parameters[RfcConfigParameters.MaxPoolSize] = Convert.ToString(poolSize);
            parameters[RfcConfigParameters.IdleTimeout] = Convert.ToString(6); // we keep connections for 10 minutes            
            parameters[RfcConfigParameters.User] = user;
            parameters[RfcConfigParameters.Password] = password;
            parameters[RfcConfigParameters.Client] = client;
            parameters[RfcConfigParameters.Language] = language;            
            parameters[RfcConfigParameters.MessageServerService] = messageServerService;
            parameters[RfcConfigParameters.MessageServerHost] = messageServerHost;
            parameters[RfcConfigParameters.LogonGroup] = logonGroup;
            RfcConfigParameters existingConfiguration;

            //if a destination of that name existed before, we need to fire a change event
            if (availableDestinations.TryGetValue(name, out existingConfiguration))
            {
                availableDestinations[name] = parameters;
                RfcConfigurationEventArgs eventArgs = new RfcConfigurationEventArgs(RfcConfigParameters.EventType.CHANGED, parameters);
                MessageBox.Show("Fire change event " + eventArgs.ToString() + " for destination " + name);
                changeHandler(name, eventArgs);
            }
            else
            {
                availableDestinations[name] = parameters;
            }

            //MessageBox.Show("Added application server destination " + name);
        }

        
    }
    #endregion

    // CLASS: cấp quyền cho user đăng nhập local machine
    // DANS.Ult.Impersonation imp = new DANS.Ult.Impersonation("administrator", "10.15.68.42", "dell118");
    #region Impersonation
    public enum LogonType : int
    {
        Interactive = 2,
        Network = 3,
        Batch = 4,
        Service = 5,
        Unlock = 7,
        NetworkClearText = 8,
        NewCredentials = 9,
    }
    public enum LogonProvider : int
    {
        Default = 0,
    }
    public sealed class Impersonation : IDisposable
    {
        private bool disposed = false;
        private WindowsImpersonationContext context;

        public void Revert()
        {
            if (context != null)
            {
                context.Undo();
                context.Dispose();
            }
        }

        public Impersonation(string userName, string domain, string password)
        {
            IntPtr userToken = IntPtr.Zero;
            IntPtr userDuplicate = IntPtr.Zero;

            bool isLoggedOn = LogonUser(userName, domain, password, LogonType.NewCredentials, LogonProvider.Default, out userToken);

            if (isLoggedOn)
            {
                try
                {
                    if (DuplicateToken(userToken, 2, ref userDuplicate))
                    {
                        WindowsIdentity identity = new WindowsIdentity(userDuplicate);

                        context = identity.Impersonate();
                    }
                    else
                    {
                        throw new Win32Exception("Could not duplicate user token.");
                    }
                }
                finally
                {
                    if (!userDuplicate.Equals(IntPtr.Zero))
                    {
                        CloseHandle(userDuplicate);
                        userDuplicate = IntPtr.Zero;
                    }

                    if (!userToken.Equals(IntPtr.Zero))
                    {
                        CloseHandle(userToken);
                        userToken = IntPtr.Zero;
                    }
                }
            }
            else
            {
                throw new Win32Exception("Could not verify credentials for suggested user.");
            }
        }

        ~Impersonation()
        {
            Dispose();
        }
        public void Dispose()
        {
            if (!disposed)
            {
                Revert();

                disposed = true;

                GC.SuppressFinalize(this);
            }
        }

        [DllImport("kernel32.dll")]
        private static extern bool CloseHandle(IntPtr hObject);

        [DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern bool LogonUser(string userName, string domain, string password, LogonType logonType, LogonProvider logonProvider, out IntPtr userToken);

        [DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern bool DuplicateToken(IntPtr hToken, int impersonationLevel, ref IntPtr duplication);

        [DllImport("advapi32.dll", SetLastError = true)]
        private static extern bool ImpersonateLoggedOnUser(IntPtr userToken);
    }
    #endregion

    // Kiểm tra dữ liệu
    class TKTQ_CHECK_DATA
    {
        // Modify by ManhTV3 on 5/12/2011 - START
        // Kiểm tra dữ liệu nợ
        public static string Prc_check_data_no(string p_short_name, DataRow p_dr, RfcDestination p_sap)
        {            
            RfcRepository v_repo = p_sap.Repository;

            IRfcFunction v_babi = v_repo.CreateFunction("ZFM_PSCD_MAPPING_DC");

            IRfcStructure v_struc = v_babi.GetStructure("I_SOURCE");            
            
            v_struc.SetValue("ROW_NUM", p_dr["STT"].ToString());
            v_struc.SetValue("DOC_TYPE", p_dr["LOAI"].ToString());
            v_struc.SetValue("TAX_OFFICE_CODE", p_dr["MA_CQT"]);
            v_struc.SetValue("TIN", p_dr["TIN"].ToString());
            v_struc.SetValue("PROFIT_CENTER", p_dr["MA_CHUONG"].ToString());
            v_struc.SetValue("BUSINESS_AREA", p_dr["MA_KHOAN"].ToString());
            v_struc.SetValue("SEGMENT", p_dr["TMT_MA_TMUC"].ToString());
            v_struc.SetValue("PAY_GROUP", p_dr["TKHOAN"].ToString());
            v_struc.SetValue("POSTING_DATE", p_dr["NGAY_HACH_TOAN"].ToString());
            v_struc.SetValue("START_PERIOD", p_dr["KYKK_TU_NGAY"].ToString());
            v_struc.SetValue("END_PERIOD", p_dr["KYKK_DEN_NGAY"].ToString());
            v_struc.SetValue("DUE_DATE", p_dr["HAN_NOP"].ToString());
            v_struc.SetValue("RETURN_CODE", p_dr["DKT_MA"].ToString());
            v_struc.SetValue("AMOUNT", p_dr["NO_CUOI_KY"].ToString());

            v_babi.Invoke(p_sap);

            return v_babi.GetString("E_ERROR_CODE");
            
        }

        // Kiểm tra dữ liệu phát sinh
        public static string Prc_check_data_ps(string p_short_name, DataRow p_dr, RfcDestination p_sap)
        {
            string v_error_code = "";            
            // Need a repository for the metadata from the ABAP Dictionary 
            // of the corresponding destination system.
            RfcRepository v_repo = p_sap.Repository;
            IRfcFunction v_babi = v_repo.CreateFunction("ZFM_PSCD_MAPPING_TK_DC");
            IRfcStructure v_struc = v_babi.GetStructure("I_SOURCE");
            
            v_struc.SetValue("ROW_NUM", p_dr["STT"].ToString());
            v_struc.SetValue("DOC_TYPE", p_dr["LOAI"].ToString());
            v_struc.SetValue("TAX_OFFICE_CODE", p_dr["MA_CQT"].ToString());
            v_struc.SetValue("TIN", p_dr["TIN"].ToString());
            v_struc.SetValue("PROFIT_CENTER", p_dr["MA_CHUONG"].ToString());
            v_struc.SetValue("BUSINESS_AREA", p_dr["MA_KHOAN"].ToString());
            v_struc.SetValue("SEGMENT", p_dr["MA_TMUC"].ToString());
            v_struc.SetValue("PAY_GROUP", p_dr["TKHOAN"].ToString());
            v_struc.SetValue("POSTING_DATE", p_dr["NGAY_HTOAN"].ToString());
            v_struc.SetValue("START_PERIOD", p_dr["KY_PSINH_TU"].ToString());
            v_struc.SetValue("END_PERIOD", p_dr["KY_PSINH_DEN"].ToString());
            v_struc.SetValue("DUE_DATE", p_dr["HAN_NOP"].ToString());
            v_struc.SetValue("RETURN_CODE", p_dr["MA_TKHAI"].ToString());
            v_struc.SetValue("AMOUNT", p_dr["SO_TIEN"].ToString());

            v_babi.Invoke(p_sap);

            v_error_code = v_babi.GetString("E_ERROR_CODE");
            
            return v_error_code;
        }

        // Kiểm tra dữ liệu tờ khai 10/KK-TNCN
        public static string Prc_check_data_tk10(string p_short_name, string p_tax_code, DataRow p_dr, RfcDestination p_sap, string p_ky_chot_dl)
        {
            // Bắt đầu một session
            RfcSessionManager.BeginContext(p_sap);
            RfcRepository v_repo = p_sap.Repository;
            IRfcFunction v_babi = v_repo.CreateFunction("ZBAPI_DETAIL_10_CHECK");
            IRfcStructure v_struc = v_babi.GetStructure("I_DATA");

            v_struc.SetValue("TAXPAYER_ID", p_dr["TIN"].ToString());
            v_struc.SetValue("START_PERIOD", p_dr["KYKK_TU_NGAY"].ToString());
            v_struc.SetValue("END_PERIOD", p_dr["KYKK_DEN_NGAY"].ToString());
            v_struc.SetValue("DUE_DATE", p_dr["KYLB_TU_NGAY"].ToString());
            v_struc.SetValue("A_F08_DOANH_THU_DU_KIEN", p_dr["DTHU_DKIEN"].ToString());
            v_struc.SetValue("A_F09_TY_LE_TNCT_DU_KIEN", p_dr["TL_THNHAP_DKIEN"].ToString());
            v_struc.SetValue("C_F10_TNCT_DU_KIEN", p_dr["THNHAP_CTHUE_DKIEN"].ToString());
            v_struc.SetValue("C_F11_GIAM_TRU_GC", p_dr["GTRU_GCANH"].ToString());
            v_struc.SetValue("A_F12_GIAM_TRU_BAN_THAN", p_dr["BAN_THAN"].ToString());
            v_struc.SetValue("A_F13_GIAM_TRU_NPT", p_dr["PHU_THUOC"].ToString());
            v_struc.SetValue("C_F14_THU_NHAP_TINH_THUE", p_dr["THNHAP_TTHUE_DKIEN"].ToString());
            v_struc.SetValue("C_F15_THUE_TNCN_DU_KIEN", p_dr["TNCN"].ToString());
            v_struc.SetValue("C_F16_THUE_PN_Q1", p_dr["PB01"].ToString());
            v_struc.SetValue("C_F16_KY_TINH_THUE_Q1", p_dr["KYTT01"].ToString());
            v_struc.SetValue("C_F16_KY_HACH_TOAN_Q1", p_dr["HT01"].ToString());
            v_struc.SetValue("C_F16_HAN_NOP_Q1", p_dr["HN01"].ToString());
            v_struc.SetValue("C_F17_THUE_PN_Q2", p_dr["PB02"].ToString());
            v_struc.SetValue("C_F17_KY_TINH_THUE_Q2", p_dr["KYTT02"].ToString());
            v_struc.SetValue("C_F17_KY_HACH_TOAN_Q2", p_dr["HT02"].ToString());
            v_struc.SetValue("C_F17_HAN_NOP_Q2", p_dr["HN02"].ToString());
            v_struc.SetValue("C_F18_THUE_PN_Q3", p_dr["PB03"].ToString());
            v_struc.SetValue("C_F18_KY_TINH_THUE_Q3", p_dr["KYTT03"].ToString());
            v_struc.SetValue("C_F18_KY_HACH_TOAN_Q3", p_dr["HT03"].ToString());
            v_struc.SetValue("C_F18_HAN_NOP_Q3", p_dr["HN03"].ToString());
            v_struc.SetValue("C_F19_THUE_PN_Q4", p_dr["PB04"].ToString());
            v_struc.SetValue("C_F19_KY_TINH_THUE_Q4", p_dr["KYTT04"].ToString());
            v_struc.SetValue("C_F19_KY_HACH_TOAN_Q4", p_dr["HT04"].ToString());
            v_struc.SetValue("C_F19_HAN_NOP_Q4", p_dr["HN04"].ToString());
            v_struc.SetValue("TAX_OFFICE_CODE", p_dr["MA_CQT"].ToString());
            v_struc.SetValue("ROW_NUM", p_dr["STT"].ToString());
            v_struc.SetValue("F13_MST_DLT", p_dr["MST_DTK"].ToString());
            v_struc.SetValue("F20_HOP_DONG_DLT_SO", p_dr["HD_DLT_SO"].ToString());
            v_struc.SetValue("F_HOP_DONG_DLT_NGAY", p_dr["HD_DLT_NGAY"].ToString());
            v_struc.SetValue("REVERSE_AMOUNT", p_dr["RV_SO_TIEN"].ToString());

            v_babi.SetValue("I_FILE", randomFileName(p_tax_code, p_ky_chot_dl));

            v_babi.Invoke(p_sap);
            // Kết thúc một session
            RfcSessionManager.EndContext(p_sap);
            return v_babi.GetString("E_ERROR_CODE");
        }

        public static string randomFileName(string p_tax_code, string p_ky_chot_dl)
        {
            return "TKQCT" + p_ky_chot_dl + "_" + p_tax_code + "_" + (new Random()).Next(0123).ToString() + ".CSV";
        }
    }

    class CLS_EXCEL
    {
        public static void Prc_Add_Sheets(Microsoft.Office.Interop.Excel.Workbook p_workBook, string p_sheetname,
                                          System.Data.DataTable p_dt)
        {
            //Sheets _sheets = null;
            Microsoft.Office.Interop.Excel.Worksheet xlWorksheet = 
                (Microsoft.Office.Interop.Excel.Worksheet)p_workBook.Worksheets.get_Item(p_sheetname);
            //_sheets = p_workBook.Sheets as Sheets;

            // The first argument below inserts the new worksheet as the first one
            //xlWorksheet = 
            //    (Worksheet)_sheets.Add(//Optional Object. An object that specifies the sheet before which the new sheet is added.
            //                            _sheets[1],
            //                            //specifies the sheet after which the new sheet is added.
            //                            Type.Missing, 
            //                            //Optional Object. The number of sheets to be added. The default value is one
            //                            Type.Missing,
            //                            //Optional Object. Specifies the sheet type
            //                            Type.Missing);              

            // Chuyển sheet tới cuối
            //xlWorksheet.Move(Type.Missing, p_workBook.Worksheets[p_workBook.Worksheets.Count]);
            // Format sheet
            Prc_Format_Col(xlWorksheet, p_dt.Rows.Count, p_dt.Columns.Count);
            // điền thông tin header cho sheet
            //Prc_Add_Header(xlWorksheet, p_dt);
            // điền thông tin body cho sheet
            Prc_Add_Body(xlWorksheet, p_dt);
            // Autofit cho Column
            Prc_Resize_Col(xlWorksheet, p_dt.Rows.Count, p_dt.Columns.Count);
        }

        public static void Prc_Add_Header(Microsoft.Office.Interop.Excel.Worksheet p_sheet, 
                                          System.Data.DataTable p_dt)
        {
            Microsoft.Office.Interop.Excel.Range _range;
            int iCol = 0;
            foreach (DataColumn c in p_dt.Columns)
            {
                iCol++;
                p_sheet.Cells[1, iCol] = c.ColumnName;
            }

            _range = p_sheet.get_Range(p_sheet.Cells[1, 1], p_sheet.Cells[1, p_dt.Columns.Count]);
            _range.Font.Bold = true;
        }

        public static void Prc_Add_Body(Microsoft.Office.Interop.Excel.Worksheet p_sheet, 
                                        System.Data.DataTable p_dt)
        {
            Microsoft.Office.Interop.Excel.Range _range;
            /*
             * Modify by ManhTV3 on 18/04/2012
             * Content: Điều kiện kết xuất phụ lục
             * */
            int iRow = 0;
            if (p_sheet.Name.Substring(0,6).Equals("Phuluc"))                
                iRow = 3;
            /*
             * Modify by ManhTV3 on 1/5/2012
             * Content: Điều kiện kết xuất báo cáo chuẩn hóa
             * */
            else if (p_sheet.Name.Equals("BaoCaoChuanHoa"))
                iRow = 1;

            int iCol = 0;
            foreach (DataRow r in p_dt.Rows)
            {
                iRow++;
                // add row
                iCol = 0;
                foreach (DataColumn c in p_dt.Columns)
                {
                    iCol++;
                    p_sheet.Cells[iRow + 1, iCol] = r[c.ColumnName];
                }
            }

            _range = p_sheet.get_Range(p_sheet.Cells[2, 1], p_sheet.Cells[iRow + 1, p_dt.Columns.Count]);
            _range.Font.Name = ".VnArial";
        }

        public static void Prc_Resize_Col(Microsoft.Office.Interop.Excel.Worksheet p_sheet, 
                                          int p_row_count, 
                                          int p_col_count)
        {
            Microsoft.Office.Interop.Excel.Range _range;
            // Resize the columns 
            _range = p_sheet.get_Range(p_sheet.Cells[1, 1],
                                       p_sheet.Cells[p_row_count, p_col_count]);
            _range.EntireColumn.AutoFit();
        }

        public static void Prc_Format_Col(Microsoft.Office.Interop.Excel.Worksheet p_sheet, 
                                          int p_row_count, 
                                          int p_col_count)
        {
            Microsoft.Office.Interop.Excel.Range _range;
            // Format Column
            _range = p_sheet.get_Range(p_sheet.Cells[1, 1],
                                       p_sheet.Cells[p_row_count, p_col_count]);
            _range.EntireColumn.NumberFormat = "@";
        }

        public static void Prc_releaseObject(object obj)
        {
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
            obj = null;
        }
    }
}
