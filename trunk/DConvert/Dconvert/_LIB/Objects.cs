using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DC.Lib.Objects
{
    // Modify by ManhTV3 on 6/12/2011
    // Đối tượng dữ liệu nợ
    class CLS_NO
    {        
        private string _stt;
        private string _loai;
        private string _ma_cqt;
        private string _tin;
        private string _ma_chuong;
        private string _ma_khoan;
        private string _tmt_ma_tmuc;
        private string _tkhoan;
        private string _ngay_hach_toan;
        private string _kykk_tu_ngay;
        private string _kykk_den_ngay;
        private string _han_nop;
        private string _dkt_ma;
        private string _no_cuoi_ky;

        // Hàm khởi tạo không tham số
        public CLS_NO()
        {
            this._stt = "";
            this._loai = "";
            this._ma_cqt = "";
            this._tin = "";
            this._ma_chuong = "";
            this._ma_khoan = "";
            this._tmt_ma_tmuc = "";
            this._tkhoan = "";
            this._ngay_hach_toan = "";
            this._kykk_tu_ngay = "";
            this._kykk_den_ngay = "";
            this._han_nop = "";
            this._dkt_ma = "";
            this._no_cuoi_ky = "";
        }

        // Hàm khởi tạo có tham số
        public CLS_NO(string p_stt, string p_loai, string p_ma_cqt, 
            string p_tin, string p_ma_chuong, string p_ma_khoan, 
            string p_tmt_ma_tmuc, string p_tkhoan, string p_ngay_hach_toan,
            string p_kykk_tu_ngay, string p_kykk_den_ngay, string p_han_nop, 
            string p_dkt_ma, string p_no_cuoi_ky)
        {
            this._stt = p_stt;
            this._loai = p_loai;
            this._ma_cqt = p_ma_cqt;
            this._tin = p_tin;
            this._ma_chuong = p_ma_chuong;
            this._ma_khoan = p_ma_khoan;
            this._tmt_ma_tmuc = p_tmt_ma_tmuc;
            this._tkhoan = p_tkhoan;
            this._ngay_hach_toan = p_ngay_hach_toan;
            this._kykk_tu_ngay = p_kykk_tu_ngay;
            this._kykk_den_ngay = p_kykk_den_ngay;
            this._han_nop = p_han_nop;
            this._dkt_ma = p_dkt_ma;         
            this._no_cuoi_ky = p_no_cuoi_ky;
        }

        // Hàm set và get
        public String stt
        {
            set { this._stt = value; }
            get { return this._stt; }
        }

        public String loai
        {
            set { this._loai = value; }
            get { return this._loai; }
        }

        public String ma_cqt
        {
            set { this._ma_cqt = value; }
            get { return this._ma_cqt; }
        }

        public String tin
        {
            set { this._tin = value; }
            get { return this._tin; }
        }

        public String ma_chuong
        {
            set { this._ma_chuong = value; }
            get { return this._ma_chuong; }
        }

        public String ma_khoan
        {
            set { this._ma_khoan = value; }
            get { return this._ma_khoan; }
        }

        public String tmt_ma_tmuc
        {
            set { this._tmt_ma_tmuc = value; }
            get { return this._tmt_ma_tmuc; }
        }

        public String tkhoan
        {
            set { this._tkhoan = value; }
            get { return this._tkhoan; }
        }

        public String ngay_hach_toan
        {
            set { this._ngay_hach_toan = value; }
            get { return this._ngay_hach_toan; }
        }

        public String kykk_tu_ngay
        {
            set { this._kykk_tu_ngay = value; }
            get { return this._kykk_tu_ngay; }
        }

        public String kykk_den_ngay
        {
            set { this._kykk_den_ngay = value; }
            get { return this._kykk_den_ngay; }
        }


        public String han_nop
        {
            set { this._han_nop = value; }
            get { return this._han_nop; }
        }

        public String dkt_ma
        {
            set { this._dkt_ma = value; }
            get { return this._dkt_ma; }
        }

        public String no_cuoi_ky
        {
            set { this._no_cuoi_ky = value; }
            get { return this._no_cuoi_ky; }
        }
    }
    
    // Đối tượng dữ liệu phát sinh
    class CLS_PS
    {        
        private string _stt;
        private string _loai;
        private string _ma_cqt;
        private string _tin;
        private string _ma_chuong;
        private string _ma_khoan;
        private string _ma_tmuc;
        private string _tkhoan;
        private string _ngay_htoan;
        private string _ky_psinh_tu;
        private string _ky_psinh_den;
        private string _han_nop;
        private string _ma_tkhai;
        private string _so_tien;

        public CLS_PS()
        {
            this._stt = "";     
            this._loai = "";
            this._ma_cqt = "";
            this._tin = "";
            this._ma_chuong = "";
            this._ma_khoan = "";
            this._ma_tmuc = "";
            this._tkhoan = "";
            this._ngay_htoan = "";
            this._ky_psinh_tu = "";
            this._ky_psinh_den = "";
            this._han_nop = "";
            this._ma_tkhai = "";
            this._so_tien = "";
        }

        public CLS_PS(string p_stt, string p_loai, string p_ma_cqt, string p_tin,
            string p_ma_chuong, string p_ma_khoan, string p_ma_tmuc, string p_tkhoan,
            string p_ngay_htoan, string p_ky_psinh_tu, string p_ky_psinh_den,
            string p_han_nop, string p_ma_tkhai, string p_so_tien)
        {
            this._stt = p_stt;
            this._loai = p_loai;
            this._ma_cqt = p_ma_cqt;
            this._tin = p_tin;
            this._ma_chuong = p_ma_chuong;
            this._ma_khoan = p_ma_khoan;
            this._ma_tmuc = p_ma_tmuc;
            this._tkhoan = p_tkhoan;
            this._ngay_htoan = p_ngay_htoan;
            this._ky_psinh_tu = p_ky_psinh_tu;
            this._ky_psinh_den = p_ky_psinh_den;
            this._han_nop = p_han_nop;
            this._ma_tkhai = p_ma_tkhai;
            this._so_tien = p_so_tien;
        }

        // Hàm set và get
        public String stt
        {
            set { this._stt = value; }
            get { return this._stt; }
        }

        public String loai
        {
            set { this._loai = value; }
            get { return this._loai; }
        }

        public String ma_cqt
        {
            set { this._ma_cqt = value; }
            get { return this._ma_cqt; }
        }

        public String tin
        {
            set { this._tin = value; }
            get { return this._tin; }
        }

        public String ma_chuong
        {
            set { this._ma_chuong = value; }
            get { return this._ma_chuong; }
        }

        public String ma_khoan
        {
            set { this._ma_khoan = value; }
            get { return this._ma_khoan; }
        }

        public String ma_tmuc
        {
            set { this._ma_tmuc = value; }
            get { return this._ma_tmuc; }
        }

        public String tkhoan
        {
            set { this._tkhoan = value; }
            get { return this._tkhoan; }
        }

        public String ngay_htoan
        {
            set { this._ngay_htoan = value; }
            get { return this._ngay_htoan; }
        }

        public String ky_psinh_tu
        {
            set { this._ky_psinh_tu = value; }
            get { return this._ky_psinh_tu; }
        }

        public String ky_psinh_den
        {
            set { this._ky_psinh_den = value; }
            get { return this._ky_psinh_den; }
        }


        public String han_nop
        {
            set { this._han_nop = value; }
            get { return this._han_nop; }
        }

        public String ma_tkhai
        {
            set { this._ma_tkhai = value; }
            get { return this._ma_tkhai; }
        }

        public String so_tien
        {
            set { this._so_tien = value; }
            get { return this._so_tien; }
        }       

    }

    // Đối tượng lỗi phát sinh khi kiểm tra dữ liệu dành cho nợ và phát sinh
    class CLS_DATA_ERROR
    {
        private string _short_name;
        private string _rid;
        private string _table_name;
        private string _err_id;
        private string _field_name;

        public CLS_DATA_ERROR()
        {
            this._short_name = "";
            this._rid = "";
            this._table_name = "";
            this._err_id = "";
            this._field_name = "";
        }

        public CLS_DATA_ERROR(string p_short_name, string p_rid, string p_table_name, string p_err_id, string p_field_name)
        {
            this._short_name = p_short_name;
            this._rid = p_rid;
            this._table_name = p_table_name;
            this._err_id = p_err_id;
            this._field_name = p_field_name;
        }

        public String short_name
        {
            set { _short_name = value; }
            get { return _short_name; }
        }

        public String rid
        {
            set { _rid = value; }
            get { return _rid; }
        }

        public String table_name
        {
            set { _table_name = value; }
            get { return _table_name; }
        }

        public String err_id
        {
            set { _err_id = value; }
            get { return _err_id; }
        }

        public String field_name
        {
            set { _field_name = value; }
            get { return _field_name; }
        }            
    }

    // Modify by ManhTV3 on 6/12/2011
    class CLS_STATUS
    {
        private string _status_name;
        private string _status;

        public CLS_STATUS()
        {
            this._status_name = "";
            this._status = "";
        }
        public CLS_STATUS(string p_status_name, string p_status)
        {
            this._status_name = p_status_name;

            if (p_status.Equals("Y") == false || p_status.Equals("N") == false || p_status.Equals("") == false)
            {
                p_status = "";
            }
            else 
            {
                this._status = p_status;
            }
        }

        public String status_name
        {
            set { this._status_name = value; }
            get { return this._status_name; }
        }

        public String status
        {
            set
            {
                if (value.ToString().Equals("Y") == false || value.ToString().Equals("N") == false || value.ToString().Equals("") == false)
                {
                    this._status = "";
                }
                else
                {
                    this._status = value;
                }
            }
            get
            {
                return this._status;
            }
        }
    }
    
    // Modify by ManhTV3 on 6/12/2011
    class CLS_ERROR
    {        
        private string _short_name;
        private string _pck;
        private string _status;
        private string _timestamp;

        public CLS_ERROR()
        {
            this._short_name = "";
            this._pck = "";
            this._status = "";
            this._timestamp = "";
        }

        public CLS_ERROR(string p_short_name, string p_pck, string p_status, string p_timestamp)
        {
            this._short_name = p_short_name;
            this._pck = p_pck;
            this._status = p_status;
            this._timestamp = p_timestamp;
        }

        public String short_name
        {
            set { this._short_name = value; }
            get { return this._short_name; }
        }

        public String pck
        {
            set { this._pck = value; }
            get { return this._pck; }
        }

        public String status
        {
            set { this._status = value; }
            get { return this._status; }
        }

        public String timestamp
        {
            set { this._timestamp = value; }
            get { return this._timestamp; }
        }
    }

    // Modify by ManhTV3 on 6/12/2011
    class CLS_LOG
    {
        private int _icon;
        private string _stt;
        private string _mo_ta;
        private string _thoi_gian;

        public CLS_LOG()
        {
            this._icon = 0;
            this._stt = "";
            this._mo_ta = "";
            this._thoi_gian = "";
        }

        public CLS_LOG(int p_icon, string p_stt, string p_mo_ta, string p_thoi_gian)
        {
            if (p_icon < 0 || p_icon > 2)
            {
                this._icon = 0;
            }
            else
            {
                this._icon = p_icon;
            }
            this._stt = p_stt;
            this._mo_ta = p_mo_ta;
            this._thoi_gian = p_thoi_gian;
        }

        public Int32 icon
        {
            set { _icon = value; }
            get { return _icon; }
        }

        public String stt
        {
            set { _stt = value; }
            get { return _stt; }
        }

        public String mo_ta
        {
            set { _mo_ta = value;}
            get { return _mo_ta; }
        }

        public String thoi_gian
        {
            set { _thoi_gian = value; }
            get { return _thoi_gian; }
        }        
    }

    // modify by ManhTV3 on 8/12/2011
    class CLS_SAP_ITEM
    {         
        private string _appServerHost;
        private string _systemNumber;
        private string _systemID;
        private string _user;
        private string _password;
        private string _client;
        private string _language;
        private string _poolSize;
        private string _maxPoolSize;
        private string _idleTimeout;

        public CLS_SAP_ITEM()
        {
            this._appServerHost = "";
            this._systemNumber = "";
            this._systemID = "";
            this._user = "";
            this._password = "";
            this._client = "";
            this._language = "";
            this._poolSize = "";
            this._maxPoolSize = "";
            this._idleTimeout = "";
        }

        public CLS_SAP_ITEM(string p_appServerHost, string p_systemNumber, string p_systemID,
            string p_user, string p_password, string p_client, string p_language,
            string p_poolSize, string p_maxPoolSize, string p_idleTimeout)
        {
            this._appServerHost = p_appServerHost;
            this._systemNumber = p_systemNumber;
            this._systemID = p_systemID;
            this._user = p_user;
            this._password = p_password;
            this._client = p_client;
            this._language = p_language;
            this._poolSize = p_poolSize;
            this._maxPoolSize = p_maxPoolSize;
            this._idleTimeout = p_idleTimeout;
        }

        public String AppServerHost
        {
            set { this._appServerHost = value; }
            get { return this._appServerHost; }
        }

        public String SystemNumber
        {
            set { this._systemNumber = value; }
            get { return this._systemNumber; }
        }

        public String SystemID
        {
            set { this._systemID = value; }
            get { return this._systemID; }
        }

        public String User
        {
            set { this._user = value; }
            get { return this._user; }
        }

        public String Password
        {
            set { this._password = value; }
            get { return this._password; }
        }

        public String Client
        {
            set { this._client = value; }
            get { return this._client; }
        }

        public String Language
        {
            set { this._language = value; }
            get { return this._language; }
        }

        public String PoolSize
        {
            set { this._poolSize = value; }
            get { return this._poolSize; }
        }

        public String MaxPoolSize
        {
            set { this._maxPoolSize = value; }
            get { return this._maxPoolSize; }
        }

        public String IdleTimeout
        {
            set { this._idleTimeout = value; }
            get { return this._idleTimeout; }
        }
    }

}
