package com.pit.convert;

/**
 *
 * @author HAIBV
 */
import com.sap.conn.jco.JCoException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.xml.parsers.ParserConfigurationException;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.pit.system.Constants;
import com.pit.datatype.*;
import com.sap.conn.jco.JCoRuntimeException;

public class LoadData {
    //Mảng chứa toàn bộ dữ liệu PSCD, TK

    private static DataCVPSCD data_cv;
    //Mảng chứa dữ liệu người phụ thuộc
    private static DataCVNPT data_npt;
    //Mảng chứa từng phần tử Nợ & phát sinh
    private static ArrayList<DataPSCD> arrPSCD = new ArrayList<DataPSCD>();
    //Mảng chứa từng phần tử Tờ khai
    private static ArrayList<DataTK> arrTK = new ArrayList<DataTK>();
    //Mảng chứa phần tử người phụ thuộc
    private static ArrayList<DataNPT> arrNPT = new ArrayList<DataNPT>();

    /**
     * @param thực hiện đọc từng loại dữ liệu (NO, PS, TK)
     * @param source_file
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     */
    static void readDataPSCD(String[] type_cv, int thread_vat, String f_name[], String tax, String chk_pscd) throws ParserConfigurationException, IOException, ExceptionInInitializerError, JCoException, SQLException {
        try {
            //Xử lý Nợ
            if (type_cv[0].equals(Constants.NO)) {
                //Load dữ liệu
                getDataORA(type_cv[0], tax, chk_pscd);
                //Convert PSCD
                if (chk_pscd.isEmpty()) {
                    ConvertPSCD.runConvert(type_cv[0], Constants.NUMBER_OF_PROCESS_PSCD, tax, "");
                    //Write log file
                    ConvertPSCD.sqlDatabase(f_name[0], tax);
                } else {
                    //Check PSCD                
                    ConvertPSCD.runConvert(type_cv[0], Constants.NUMBER_OF_PROCESS_PSCD, tax, "X");
                }

            }
            //Xử lý Phát sinh
            if (type_cv[1].equals(Constants.PS)) {
                //Load dữ liệu 
                getDataORA(type_cv[1], tax, chk_pscd);
                //Convert PSCD
                if (chk_pscd.isEmpty()) {
                    ConvertPSCD.runConvert(type_cv[1], Constants.NUMBER_OF_PROCESS_PSCD, tax, "");
                    //Write log file
                    ConvertPSCD.sqlDatabase(f_name[1], tax);
                } else {
                    ConvertPSCD.runConvert(type_cv[1], Constants.NUMBER_OF_PROCESS_PSCD, tax, "X");
                }

            }
            //Xử lý Tờ khai
            if (type_cv[2].equals(Constants.TK)) {
                //Load dữ liệu
                getDataORA(type_cv[2], tax, chk_pscd);
                //Convert PSCD
                if (chk_pscd.isEmpty()) {
                    ConvertPSCD.runConvert(type_cv[2], thread_vat, tax, "");
                    //Write log file
                    ConvertPSCD.sqlDatabase(f_name[2], tax);
                } else {
                    ConvertPSCD.runConvert(type_cv[2], thread_vat, tax, "X");
                }

            }

        } catch (ExceptionInInitializerError ExInt) {
            throw new RuntimeException("Lỗi xẩy ra đối với cơ quan thuế: " + tax + ", trong file : " + f_name[0] + f_name[1] + f_name[2], ExInt);
        } catch (JCoException je) {
            throw new JCoException(thread_vat, tax, je.getMessage());
        } catch (JCoRuntimeException jr) {
            throw new JCoRuntimeException(1, "", jr.getMessage());
        }

    }

    /**
     * @desc lấy dữ liệu người phụ thuộc theo chi cục thuế
     * @param tax
     * @throws ParserConfigurationException
     * @throws IOException
     * @throws ExceptionInInitializerError
     * @throws JCoException
     * @throws SQLException 
     */
    static void readDataNPT(String tax) throws ParserConfigurationException, IOException, ExceptionInInitializerError, JCoException, SQLException {
        try {
            //Load dữ liệu
            getDataORA(tax);
            //Convert 
            ConvertPSCD.convertNPT();

        } catch (ExceptionInInitializerError ExInt) {
            throw new RuntimeException("Lỗi xẩy ra đối với cơ quan thuế: " + tax, ExInt);
        } catch (JCoException je) {
            throw new JCoException(1, tax, je.getMessage());
        } catch (JCoRuntimeException jr) {
            throw new JCoRuntimeException(1, "", jr.getMessage());
        }

    } 

    static void getDataORA(String tax) throws SQLException, UnsupportedEncodingException {
        // Clear 
        arrNPT.clear();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "";
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();

            sql = "select * from tb_pt where short_name in (" + tax + ")";

            rset = stmt.executeQuery(sql);
            while (rset.next()) {
                DataNPT npt = new DataNPT();
                data_npt = null;
                arrNPT.clear();
                //setter DataPSCD             
                npt.setID(rset.getString("id"));
                npt.setTIN(rset.getString("tin"));
                npt.setPERIOD_KEY(rset.getString("KY_TTHUE"));
                npt.setFBTYP(rset.getString("LOAI_TK"));
                npt.setAPPEN_ID(rset.getString("LOAI_BK"));
                npt.setTAXPAYER_ID(rset.getString("MST_NPT"));
                npt.setTAXPAYER_NAME(rset.getString("TEN_NPT"));

                //String a = new String("fsàds","UTF-8");
                npt.setBIRTHDAY(rset.getString("NGAY_SINH"));
                npt.setIDENTIFY_NUM(rset.getString("SO_CMT"));
                npt.setRELATIONSHIP(rset.getString("QHE_NNT"));
                npt.setNUM_OF_RELIEF(rset.getString("SOTHANG_GTRU"));
                npt.setINCOME_RELIEF(rset.getString("SOTIEN_GTRU"));
                npt.setRELATIONSHIP_WH(rset.getString("QHE_VCHONG"));
                arrNPT.add(npt);

                data_npt = new DataCVNPT(arrNPT);
                //Load data lên queue
                ConvertPSCD.loadQueueNPT(data_npt);
            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
        }

    }

    /**
     * @desc đọc và lấy từng loại dữ liệu và gán vào mảng 
     * @param type_cv
     * @param tax
     * @throws SQLException 
     */
    static void getDataORA(String type_cv, String tax, String chk_pscd) throws SQLException {
        // Clear 
        arrTK.clear();
        arrPSCD.clear();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "";
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();

            //Xử lý Nợ
            if (type_cv.equals(Constants.NO)) {
                sql = "select * from tb_no where short_name in (" + tax + ") and status is null";
                rset = stmt.executeQuery(sql);
                while (rset.next()) {
                    DataPSCD pscd = new DataPSCD();
                    data_cv = null;
                    arrPSCD.clear();
                    //setter DataPSCD
                    pscd.setDOC_TYPE(rset.getString("loai")); //Ký hiệu giao dịch
                    pscd.setTAX_OFFICE_CODE(rset.getString("MA_CQT")); //Trường kí tự với độ dài là 5
                    pscd.setTIN(rset.getString("tin")); //Số giấy tờ
                    pscd.setPROFIT_CENTER(rset.getString("ma_chuong")); //Chương
                    pscd.setBUSINESS_AREA(rset.getString("ma_khoan")); //Khoản
                    pscd.setSEGMENT(rset.getString("TMT_MA_TMUC")); //Tiểu mục
                    pscd.setPAY_GROUP(rset.getString("TKHOAN")); //Tài khoản Cơ quan thuế
                    pscd.setPOSTING_DATE(rset.getString("NGAY_HACH_TOAN")); //Posting date
                    pscd.setSTART_PERIOD(rset.getString("KYKK_TU_NGAY")); //Start date
                    pscd.setEND_PERIOD(rset.getString("KYKK_DEN_NGAY")); //End date
                    pscd.setDUE_DATE(rset.getString("HAN_NOP")); //Due Date
                    pscd.setRETURN_CODE(rset.getString("DKT_MA")); //Return code
                    pscd.setAMOUNT(rset.getString("NO_CUOI_KY")); //Amount      
                    pscd.setID(rset.getString("ID")); //ID    
                    arrPSCD.add(pscd);

                    data_cv = new DataCVPSCD(arrPSCD, arrTK);
                    //Load data NO lên queue                    
                    ConvertPSCD.loadQueue(data_cv);
                }
            }
            //Xử lý phát sinh
            if (type_cv.equals(Constants.PS)) {
                sql = "select * from tb_ps where short_name in (" + tax + ") and status is null";
                rset = stmt.executeQuery(sql);
                while (rset.next()) {
                    DataPSCD pscd = new DataPSCD();
                    data_cv = null;
                    arrPSCD.clear();
                    //setter DataPSCD
                    pscd.setDOC_TYPE(rset.getString("loai")); //Ký hiệu giao dịch
                    pscd.setTAX_OFFICE_CODE(rset.getString("MA_CQT")); //Trường kí tự với độ dài là 5
                    pscd.setTIN(rset.getString("tin")); //Số giấy tờ
                    pscd.setPROFIT_CENTER(rset.getString("ma_chuong")); //Chương
                    pscd.setBUSINESS_AREA(rset.getString("ma_khoan")); //Khoản
                    pscd.setSEGMENT(rset.getString("MA_TMUC")); //Tiểu mục
                    pscd.setPAY_GROUP(rset.getString("TKHOAN")); //Tài khoản Cơ quan thuế
                    pscd.setPOSTING_DATE(rset.getString("NGAY_HTOAN")); //Posting date
                    pscd.setSTART_PERIOD(rset.getString("KY_PSINH_TU")); //Start date
                    pscd.setEND_PERIOD(rset.getString("KY_PSINH_DEN")); //End date
                    pscd.setDUE_DATE(rset.getString("HAN_NOP")); //Due Date
                    pscd.setRETURN_CODE(rset.getString("MA_TKHAI")); //Return code
                    pscd.setAMOUNT(rset.getString("SO_TIEN")); //Amount     
                    pscd.setID(rset.getString("ID")); //ID
                    arrPSCD.add(pscd);

                    data_cv = new DataCVPSCD(arrPSCD, arrTK);
                    //Load data PS lên queue                    
                    ConvertPSCD.loadQueue(data_cv);
                }
            }

            //Xử lý Tờ khai
            if (type_cv.equals(Constants.TK)) {
                //Lấy dữ liệu để convert
                if (chk_pscd.isEmpty()) {
                    sql = "select * from tb_tk where short_name in (" + tax + ") and status is null";
                } else {//lấy dữ liệu thực hiện check
                    sql = "select rowid rid, a.* from tb_tk a where short_name in (" + tax + ")";
                }

                rset = stmt.executeQuery(sql);
                while (rset.next()) {
                    DataTK tk = new DataTK();
                    data_cv = null;
                    arrTK.clear();
                    //setter DataTK
                    tk.setTAX_OFFICE_CODE(rset.getString("MA_CQT")); //Trường kí tự với độ dài là 5
                    tk.setTAXPAYER_ID(rset.getString("tin")); //Mã số thuế
                    tk.setSTART_PERIOD(rset.getString("KYKK_TU_NGAY")); //Start date
                    tk.setEND_PERIOD(rset.getString("KYKK_DEN_NGAY")); //End date
                    tk.setDUE_DATE(rset.getString("KYLB_TU_NGAY")); //Due Date
                    tk.setA_F08_DOANH_THU_DU_KIEN(rset.getString("DTHU_DKIEN")); //
                    tk.setA_F09_TY_LE_TNCT_DU_KIEN(rset.getString("TL_THNHAP_DKIEN")); //
                    tk.setC_F10_TNCT_DU_KIEN(rset.getString("THNHAP_CTHUE_DKIEN")); //
                    tk.setC_F11_GIAM_TRU_GC(rset.getString("GTRU_GCANH")); //
                    tk.setA_F12_GIAM_TRU_BAN_THAN(rset.getString("BAN_THAN")); //
                    tk.setA_F13_GIAM_TRU_NPT(rset.getString("PHU_THUOC")); //
                    tk.setC_F14_THU_NHAP_TINH_THUE(rset.getString("THNHAP_TTHUE_DKIEN")); //
                    tk.setC_F15_THUE_TNCN_DU_KIEN(rset.getString("TNCN")); //
                    tk.setC_F16_THUE_PN_Q1(rset.getString("PB01")); //
                    tk.setC_F16_KY_TINH_THUE_Q1(rset.getString("KYTT01")); //
                    tk.setC_F16_KY_HACH_TOAN_Q1(rset.getString("HT01")); //
                    tk.setC_F16_HAN_NOP_Q1(rset.getString("HN01")); //
                    tk.setC_F17_THUE_PN_Q2(rset.getString("PB02")); //
                    tk.setC_F17_KY_TINH_THUE_Q2(rset.getString("KYTT02")); //
                    tk.setC_F17_KY_HACH_TOAN_Q2(rset.getString("HT02")); //
                    tk.setC_F17_HAN_NOP_Q2(rset.getString("HN02")); //
                    tk.setC_F18_THUE_PN_Q3(rset.getString("PB03")); //
                    tk.setC_F18_KY_TINH_THUE_Q3(rset.getString("KYTT03")); //
                    tk.setC_F18_KY_HACH_TOAN_Q3(rset.getString("HT03")); //
                    tk.setC_F18_HAN_NOP_Q3(rset.getString("HN03")); //
                    tk.setC_F19_THUE_PN_Q4(rset.getString("PB04")); //
                    tk.setC_F19_KY_TINH_THUE_Q4(rset.getString("KYTT04")); //
                    tk.setC_F19_KY_HACH_TOAN_Q4(rset.getString("HT04")); //
                    tk.setC_F19_HAN_NOP_Q4(rset.getString("HN04")); //
                    tk.setF13_MST_DLT(rset.getString("MST_DTK"));
                    tk.setF20_HOP_DONG_DLT_SO(rset.getString("HD_DLT_SO"));
                    tk.setF_HOP_DONG_DLT_NGAY(rset.getString("HD_DLT_NGAY"));
                    tk.setID(rset.getString("ID"));
                    tk.setRV_SO_TIEN(rset.getString("RV_SO_TIEN"));
                    tk.setRID(rset.getString("RID"));

                    //Add vào mảng TK
                    arrTK.add(tk);
                    data_cv = new DataCVPSCD(arrPSCD, arrTK);
                    // Load data TK lên queue                    
                    ConvertPSCD.loadQueue(data_cv);
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
        }

    }
}
