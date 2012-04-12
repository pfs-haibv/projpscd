package com.pit.system;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Constants {

    //PROCESS
    public static final int    NUMBER_OF_PROCESS_PSCD   = 1;  
    //Log name class
    public static final String LOGGER_NAME              = "ConvertPSCD";    
    //Thông tin Nợ
    public static final String NO  = "NO";
    //Thông tin về Phát sinh
    public static final String PS  = "PS";
    //Thông tin về Tờ khai
    public static final String TK  = "TK";
    //Thông tin về người phụ thuộc
    public static final String PT  = "PT";
    //Loại khác
    public static final String LK  = "LK";
    
    //PROJECT, SUBJECT, OBJECT, FILE_NAME    
    public static final String LOG_PROJECT     = "PRO_PSCD";    // Project Nợ, Nộp thừa, Phát sinh
    public static final String LOG_SUB_PSCD_TK = "SUB_PSCD_TK"; // Subject Phát sinh
    public static final String LOG_SUB_PSCD_CD = "SUB_PSCD_CD"; // Subject Nợ, Nộp thừa
    public static final String LOG_PRO_FORM_10 = "PRO_FORM_10"; // Project Form 10
    public static final String LOG_SUB_FORM_10 = "SUB_FORM_10"; // Subject Form 10    
    
    //IMPORT EXCEL TO DATA    
    public static final String TAX_MODEL       = "-EXT";        // TAX_MODEL
    public static final String MA_CHUONG_557   = "557";         // MA_CHUONG
    public static final String MA_CHUONG_757   = "757";         // MA_CHUONG
    public static final String MA_KHOAN_000    = "000";         // MA_KHOAN
    
    public static final String KYKK_TU_NGAY    = "01/01/2012";  // KYKK_TU_NGAY
    public static final String KYKK_DEN_NGAY   = "31/12/2012";  // KYKK_DEN_NGAY
    
    public static final String CHUONG_MTMUC    = "1001, 1003, 1004, 1005"; //Chương theo Mục - tiểu mục
    
    public static final String MTMUC_CDNT      = "1001, 1003, 1004, 1005, 1006, 1007, 1008, 1012, 1049, 1014, 4268"; //Mục - tiểu mục CDNT 
    
    // Các quý trong năm    
    public static final String QUY[]           = {"Q1","Q2","Q3","Q4"};
    // Mẫu TK theo tiểu mục
    public static final String MAUTK_1001      = "02T/KK-TNCN, 02Q/KK-TNCN, 07/KK-TNCN"; // Mẫu theo tiểu mục 1001
    public static final String MAUTK_1003      = "03T/KK-TNCN, 03Q/KK-TNCN, 07/KK-TNCN, 01/KK-BH, 01/KK-XS, 08/KK-TNCN, 08A/KK-TNCN, 10/KK-TNCN, 10A/KK-TNCN "; // Mẫu theo tiểu mục 1003
    public static final String MAUTK_1004      = "03T/KK-TNCN, 03Q/KK-TNCN  "; // Mẫu theo tiểu mục 1004
    public static final String MAUTK_1007      = "03T/KK-TNCN, 03Q/KK-TNCN"; // Mẫu theo tiểu mục 1007
    public static final String MAUTK_1008      = "03T/KK-TNCN, 03Q/KK-TNCN"; // Mẫu theo tiểu mục 1008
    public static final String MAUTK_1014      = "08/KK-TNCN, 08A/KK-TNCN"; // Mẫu theo tiểu mục 1014
    
    public static final String MAUTK_THANG     = "02T/KK-TNCN, 03T/KK-TNCN, 07/KK-TNCN, 01/KK-BH, 01/KK-XS, 08/KK-TNCN, 08A/KK-TNCN"; // Mẫu theo kỳ kê khai định dạng tháng
    public static final String MAUTK_QUY       = "02Q/KK-TNCN, 03Q/KK-TNCN, 08/KK-TNCN, 08A/KK-TNCN"; // Mẫu theo kỳ kê khai định dạng quý
    public static final String MAUTK_NAM       = "10/KK-TNCN, 10A/KK-TNCN, 08/KK-TNCN, 08A/KK-TNCN"; // Mẫu theo kỳ kê khai định dạng năm
    
    public static final String KYKK_THUOC_QUY = "0103, 0406, 0709, 1012"; //Kỳ kê khai thuộc kỳ quý
    
    // Format Date/Time
    public static final DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    public static final DateFormat DATE_DDMMYYY = new SimpleDateFormat("dd/MM/yyyy");
    // Chuyển đổi toàn bộ dữ liệu ngoài cho tất cả các CQT
    public static final String ALL_CQT = "Tất cả";
    // Flad value = X
    public static final String FLAG_VALUES_X = "X";
    
    
    // Khởi tạo tham số mặc đinh
    public static final String CONFIG_DEFAULT = "D:/PSCD";
    public static final String CONFIG_EXCELDATA = "D:/PSCD/ExcelData/";
    public static final String CONFIG_BACKUP = "D:/PSCD/Backup";
    public static final String CONFIG_ERRORS = "D:/PSCD/Errors";
}
