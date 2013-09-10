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
using System.Web;
using WebCamService;
using System.Net;


namespace DC.Vatwin
{
    class CLS_TRANSPORT
    {
        public CLS_TRANSPORT()
        { }
        ~CLS_TRANSPORT()
        { }
        public static ArrayList Fnc_seacrh_copy_file_dtnt_ftp(string p_forder,
                                             DirectoryInfo p_dir_destination,                                             
                                             string p_short_name,
                                             Forms.Frm_QLCD p_frm_qlcd,
                                             string p_server,
                                             string p_username,
                                             string p_password,
                                             string p_prefix)
        {
            int _so_file = 0;
            ArrayList myfilesnames = new ArrayList();
            List<string> files = new List<string>();
            try
            {

                //Create FTP request
                FtpWebRequest request = (FtpWebRequest)FtpWebRequest.Create(p_server + p_forder);

                request.Method = WebRequestMethods.Ftp.ListDirectory;
                request.Credentials = new NetworkCredential(p_username,p_password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false;
                

                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                Stream responseStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(responseStream);

                while (!reader.EndOfStream)
                {
                    Application.DoEvents();
                    //                    files.Add(reader.ReadLine());
                    files.Add(reader.ReadLine());
                }

                //Clean-up
                reader.Close();
                responseStream.Close(); //redundant
                response.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("There was an error connecting to the FTP Server");
            }

            //If the list was successfully received, display it to the user
            //through a dialog
            if (files.Count != 0)
            {                
                foreach (string _file in files)
                {
                    string filesname;
                    // listboxFiles.Items.Add(file);
                    if (_file.ToUpper().Contains(p_prefix) == true && _file.ToUpper().Contains("DBF") == true)
                    {
//                        MessageBox.Show(file);
                        filesname = _file.Trim().Substring(_file.ToUpper().IndexOf(p_prefix), _file.ToUpper().IndexOf("DBF") - _file.ToUpper().IndexOf(p_prefix) + 3);
                        myfilesnames.Add(filesname);
                        /*_so_file = _so_file + Fnc_copy_file_dtnt_ftp(p_forder, p_dir_destination, p_short_name, p_frm_qlcd, p_server,
                                               p_username, p_password, filesname);*/
/*                        FtpWebRequest _request = (FtpWebRequest)WebRequest.Create(p_server + p_forder + "/" + filesname);
                        _request.Method = WebRequestMethods.Ftp.DownloadFile;
                        _request.Credentials = new NetworkCredential(p_username, p_password);
                        FtpWebResponse _response = (FtpWebResponse)_request.GetResponse();
                        Stream _responseStream = _response.GetResponseStream();
                        StreamReader _reader = new StreamReader(_responseStream);

                        StreamWriter writer = new StreamWriter(p_dir_destination + "/bk/" + filesname);
                        writer.Write(_reader.ReadToEnd());

                        writer.Close();
                        _reader.Close();
                        _response.Close();*/
                    }
                }
            }            
            return myfilesnames;            
        }
        public static int Fnc_copy_file_dtnt_ftp(string p_forder,
                                            DirectoryInfo p_dir_destination,
                                            string p_short_name,
                                            Forms.Frm_QLCD p_frm_qlcd,
                                            string p_server,
                                            string p_username,
                                            string p_password,
                                            string p_filename)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                // Biến lưu trữ trên hàm hoặc thủ tục
                string v_pck = "FNC_COPY_FILE_DTNT";
                // Biến xác định ghi logs khi thực hiện thành công
                string logs = "";
                // Biến lưu câu lệnh sql 
                string _query = "";
                // Biến lưu trữ số file đã copy về máy
                int _so_file = 1;

                _ora.TransStart();
                try
                {
                #region Copy files
                //Create a WebClient.            
                WebClient request = new WebClient();
                //Declare Ftp parameters
                /*            string FtpServer = "ftp://10.15.117.98/aiun/BPH_DBVAT_707/DTNT/";
                            string FtpUserName = "administrator";
                            string FtpPassword = "123456a@";*/
                //Setup our credentials
                request.Credentials = new NetworkCredential(p_username, p_password);
                try
                {
                    //Download the data into a Byte array
                    byte[] fileData =
                        request.DownloadData(p_server + p_forder + "/" + p_filename);
                    //Create a FileStream that we'll write the
                    // byte array to.
                    FileStream file =
                        File.Create(p_dir_destination + "\\" +
                        p_filename);

                    //Write the full byte array to the file.
                    file.Write(fileData, 0, fileData.Length);
                    file.Close();
//                    _so_file++;
                    /*     }
                          catch (FormatException e)
                          {
                             MessageBox.Show(e.Message);
                          }
                      }*/
                }
                catch (FormatException e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);
                    logs = "E";
                    return -1;
                }
                //                        MessageBox.Show("Download complete");
                #endregion
                }
                catch (Exception e)
                {
                    p_frm_qlcd.AddToListView(0, "   + " + p_short_name + ": " + e.Message);

                    // Ghi log
                    _query = null;
                    _query +=
                        "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                            + v_pck + "', 'N', '";
                    _query += e.Message.ToString().Replace("'", "\"") + "')";
                    _ora.TransExecute(_query);
                    _ora.TransRollBack();

                    return -1;
                }
                if (logs != "E")
                {
                    // Ghi log
                    _query = null;
                    _query = "call PCK_TRACE_LOG.prc_ins_log_vs('" + p_short_name + "', '"
                                                                + v_pck + "', 'Y', null)";
                    _ora.TransExecute(_query);
                    _ora.TransCommit();
                }
                return _so_file;
            }
        }
    }
}

