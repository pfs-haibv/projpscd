using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;

namespace DC.Lib
{
    public static class GlobalVar
    {
        // Khai báo tham số cho truy cập database DPPIT
        
        public const string gl_connTKTQ = "provider=OraOLEDB.Oracle;data source=DCNC;user id=TEST;password=TEST;";
        public const string gl_connTKTQ1 = "data source=DCNC;user id=TEST;password=TEST;";

        public const string gl_connTKTQVATW = "Provider=msdaora;Data Source=DCNC;User Id=TEST;Password=TEST;";
        public const string gl_connStringDPPIT = "provider=OraOLEDB.Oracle;data source=DCNC;OLE DB Services=-16;user id=QLT_OWNER;password=QLT_OWNER";

        public const string gl_dirDANHMUCVATW = @"\\10.15.119.215\tmpvat\DM_CHUNG";

        public const string gl_dirNhap_Ngoai = @"\\10.15.119.215\NHAP_NGOAI";

        public const string gl_tempBienBan = "TEMP_BienBanDoiChieu_v1.0.doc";

        //Tạo chuỗi kết nối đọc file excel
        public static string get_connExcel(string _file_source)
        {
            string strConn = String.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=""Excel 8.0;HDR=YES;IMEX=1;""", _file_source);
            return strConn;
        }

        // Khai báo ví dụ
        public static int gl_test
        {
            get
            {
                return gl_test;
            }
            set
            {
                gl_test = value;
            }
        }

        public struct Struc_Combo
        {
            private string _value, _display;

            public Struc_Combo(string value, string display)
            {
                this._value = value;
                this._display = display;
            }

            public string Value { get { return _value; } }
            public string Display { get { return _display; } }
        }
    }
}
