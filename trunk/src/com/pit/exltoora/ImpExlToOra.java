package com.pit.exltoora;

import UnicodeConverter.Tcvn3Converter;
import com.pit.conn.ConnectDB;
import java.io.FileInputStream;
import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.pit.datatype.*;
import com.pit.system.Constants;
import com.pit.utility.Utility;
import java.io.File;
import java.util.Date;

/**
 *
 * @author Administrator
 * 
 * @param   -> Scand folders
 *              1)Scand folders
 *              2)Read a file excel
 * 
 *                          NO, PS, TK (khởi tạo giá trị)
 * 
 *                          //Sheet NO
 *                          Read sheet NO
 *                          Setter values NO, and add to ArrayList NO
 * 
 *                          //Sheet PS
 *                          Read sheet PS
 *                          Setter values PS, and add to ArrayList PS
 * 
 *                          //Sheet TK
 *                          Read sheet TK
 *                          Setter values TK, and add to ArrayList TK
 * 
 *                          Insert ArrayList NO, PS, TK to database
 * 
 *              3)Backup files
 * 
 *              4)Back to step 2
 * 
 * @version jvm 1.7
 */
public class ImpExlToOra {

    //Mảng chứa từng phần tử Nợ & phát sinh
    private static ArrayList<DataPSCD> arrPSCD = new ArrayList<DataPSCD>();
    //Mảng chứ từng phần tử Tờ khai
    private static ArrayList<DataTK> arrTK = new ArrayList<DataTK>();

    public ImpExlToOra() {
    }

    /**
     * 
     * @param file
     * @param file_name
     * @param try_cv_cqt
     * @param htcd 
     */
    public static void ImpExlToOra(String file, String file_name, String try_cv_cqt, String htcd, String tgrErr) {

        HSSFRow row = null;//Row   
        HSSFSheet sheet_name = null;//sheet_name

        try {

            /**
             * @desc CQT được chọn và hình thức chuyển đôi 
             *       Hình thức chuyển đổi lại -> xóa dữ liệu theo cqt và file truyền vào
             *       Hình thức chuyển đổi bổ sung -> Update thêm dữ liệu
             */
            if (htcd.equals("I")) {
                //Xóa dữ liệu trong database
                ConnectDB.delExlData(file_name);
                //Xóa dữ liệu trong table tb_log_excel khi chuyển lại với file đó
                ConnectDB.sqlDatabase("delete tb_log_excel where file_imp = '" + file_name + "'");
            }

            FileInputStream fileInputStream = new FileInputStream(file);
            HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);

            int t_rows = 0;//Total row on sheet
            String sql = "";//Query 
            String sql_log = "";//sql query log data excel
            String sql_secc = "";//sql query insert excel -> db secc
            String desc_tin = "";
            String desc_ps = "";
            String desc_nt = "";
            String desc_money_tk = "";//kiểm tra số tiền tờ khai không âm
            //check dd/mm/yyyy
            String desc_ngay_ddmmyyyy[] = null;
            //check mm/yyyy
            String desc_ngay_mmyyyy[] = null;
            //check ky_lb
            String desc_kylb = "";
            //check tỷ lệ thu nhập chịu thuế
            String desc_cltnct = "";
            String flag_log = "";

            String imp_date = "";

            int total_no = 0;
            int total_ps = 0;
            int total_tk = 0;
            setFlag("");

            //ma_chuong
            String ma_chuong = "";
            //get short_name theo tên file truyền vào
            String[] arr_short_name = file_name.split("_");
            String short_name = "";
            if (arr_short_name.length > 2) {
                short_name = arr_short_name[1] + "_" + arr_short_name[2].substring(0, arr_short_name[2].length() - 4);
            } else {
                short_name = arr_short_name[1].substring(0, arr_short_name[1].length() - 4);
            }
            String sql_cqt = "SELECT a.tax_code, a.short_name, a.tax_model FROM tb_lst_taxo a where a.short_name = '" + short_name.toUpperCase() + "'";
            // get info cqt
            String InfoCQT[] = ConnectDB.getInfoCQT(sql_cqt).split(",");
            //set short_name
            setShort_name(short_name);
            
            if(InfoCQT[0].isEmpty() || InfoCQT[1].isEmpty() || InfoCQT[2].isEmpty()){
                String log = "Không tồn tại dữ liệu, kiểm tra lại tên CQT hoặc tax_model. \n kiểm tra file :"+file;
                setGetlog(log);
                throw new Exception(log);
            }
            
            /**-----------------------------------------------------------------*
             *                      SHEET PS                                    *
             **-----------------------------------------------------------------*/
            sheet_name = workbook.getSheet("PS");
            t_rows = sheet_name.getLastRowNum();

            /**
             * @param get ma chuong 
             *        không phân biệt tiểu muc
             *        Cuc -> ma_chuong = '557' 
             *        Chi cục = > ma_chuong = '757'
             */
            if (InfoCQT[1].length() > 3) {
                ma_chuong = "757";
            } else {
                ma_chuong = "557";
            }


            //Start from row 6
            for (int i = 6; i <= t_rows; i++) {
                row = sheet_name.getRow(i);

                //clear
                desc_ps = "";
                desc_tin = "";
                desc_ngay_ddmmyyyy = new String[2];
                desc_ngay_mmyyyy = new String[2];

                //check date
                desc_ngay_ddmmyyyy[0] = Utility.checkDateDDMMYYYY(row.getCell(5).toString());
                desc_ngay_ddmmyyyy[1] = Utility.checkDateDDMMYYYY(row.getCell(6).toString());
                desc_ngay_mmyyyy[0]   = Utility.checkDateMMYYYY(row.getCell(3).toString());
                desc_ngay_mmyyyy[1]   = Utility.checkDateMMYYYY(row.getCell(4).toString());

                //Check data PS
                desc_ps = Utility.checkDataPS(row.getCell(1).toString(), row.getCell(2).toString().toUpperCase(), row.getCell(3).toString(), row.getCell(4).toString());
                desc_tin = Utility.checkTIN(row.getCell(0).toString());

                //không lỗi thực hiện insert vào data
                if (desc_ps.isEmpty() && desc_tin.isEmpty() && desc_ngay_ddmmyyyy[0].isEmpty() && desc_ngay_ddmmyyyy[1].isEmpty() && desc_ngay_mmyyyy[0].isEmpty() && desc_ngay_mmyyyy[1].isEmpty()) {
                    sql = "insert into tb_ps (tin, ma_chuong, ma_khoan, "
                            + "ma_tkhai, ky_psinh_tu, ky_psinh_den, ngay_nop, "
                            + "ngay_htoan, han_nop, so_tien, imp_file, "
                            + "tax_model, short_name, ma_cqt, tkhoan, loai, ma_tmuc) values ("
                            + "'" + row.getCell(0).toString() + "','" + ma_chuong + "','" + Constants.MA_KHOAN_000 + "','"
                            + row.getCell(2).toString().toUpperCase() + "','01/" + row.getCell(3) + "','" + Utility.getMaxDate(row.getCell(4).toString()) + "','" + row.getCell(5) + "','"
                            + row.getCell(5) + "','" + row.getCell(6) + "'," + row.getCell(7) + ",'" + file_name + "','"
                            + InfoCQT[2] + Constants.TAX_MODEL + "','" + InfoCQT[1] + "','" + InfoCQT[0] + "','TKNS','TK','" + row.getCell(1) + "')";

                    //Insert to db
                    ConnectDB.sqlDatabase(sql);

                    //total row inserted
                    total_ps++;
                } // Ghi dữ liệu vào log
                else {
                    //Ghi log vơi tờ khai
                    if (!desc_ps.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ps) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    //Ghi log với tin
                    if (!desc_tin.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_tin) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    //Log date
                    if (!desc_ngay_ddmmyyyy[0].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[0]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_ddmmyyyy[1].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[1]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_mmyyyy[0].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_mmyyyy[0]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_mmyyyy[1].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_mmyyyy[1]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    //có lỗi
                    flag_log = Constants.FLAG_VALUES_X;
                }

            }

            /**-----------------------------------------------------------------*
             *                      SHEET CDNT                                  *
             **-----------------------------------------------------------------*/
            sheet_name = workbook.getSheet("CD");
            t_rows = sheet_name.getLastRowNum();

            //Start from row 6
            for (int i = 6; i <= t_rows; i++) {
                row = sheet_name.getRow(i);

                /**
                 * @param get ma chuong 
                 *        tiểu muc 1001, 1003, 1004, 1005
                 *        Cuc -> ma_chuong = '557' 
                 *        Chi cục = > ma_chuong = '757'
                 */
                if (InfoCQT[1].length() == 3) {
                    if (Constants.CHUONG_MTMUC.indexOf(row.getCell(1).toString()) >= 0) {
                        ma_chuong = "557";
                    } else {
                        ma_chuong = "757";
                    }
                } else {
                    ma_chuong = "757";
                }

                //Clear
                desc_tin = "";
                desc_nt = "";

                desc_ngay_ddmmyyyy = new String[1];
                desc_ngay_mmyyyy = new String[3];

                //check date
                desc_ngay_ddmmyyyy[0] = Utility.checkDateDDMMYYYY(row.getCell(5).toString());

                desc_ngay_mmyyyy[0] = Utility.checkDateMMYYYY(row.getCell(2).toString());
                desc_ngay_mmyyyy[1] = Utility.checkDateMMYYYY(row.getCell(3).toString());
                desc_ngay_mmyyyy[2] = Utility.checkDateMMYYYY(row.getCell(4).toString());

                //Check data CDNT
                desc_nt = Utility.checkDataCDNT(row.getCell(1).toString().substring(0, 4));
                desc_tin = Utility.checkTIN(row.getCell(0).toString());



                if (desc_tin.isEmpty() && desc_nt.isEmpty() && desc_ngay_ddmmyyyy[0].isEmpty() && desc_ngay_mmyyyy[0].isEmpty()
                    && desc_ngay_mmyyyy[1].isEmpty() && desc_ngay_mmyyyy[2].isEmpty()  ) {
                    sql = "insert into tb_no (tin, ma_chuong, ma_khoan, "
                            + "TMT_MA_TMUC, tkhoan, KYKK_TU_NGAY, KYKK_DEN_NGAY, "
                            + "ngay_hach_toan, HAN_NOP, NO_CUOI_KY, imp_file, "
                            + "tax_model, short_name, ma_cqt, loai) values ("
                            + "'" + row.getCell(0).toString() + "','" + ma_chuong + "','" + Constants.MA_KHOAN_000 + "','"
                            + row.getCell(1).toString().substring(0, 4) + "','TKNS','01/" + row.getCell(3) + "','" + Utility.getMaxDate(row.getCell(4).toString()) + "','"
                            + Utility.getMaxDate(row.getCell(2).toString()) + "','" + row.getCell(5) + "'," + row.getCell(6) + ",'" + file_name + "','"
                            + InfoCQT[2] + Constants.TAX_MODEL + "','" + InfoCQT[1] + "','" + InfoCQT[0] + "','CD')";

                    //Insert to db
                    ConnectDB.sqlDatabase(sql);

                    //total row inserted
                    total_no++;
                } // Ghi dữ liệu vào log
                else {

                    //Ghi log vơi tờ khai
                    if (!desc_nt.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_nt) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_tin.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_tin) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    //Log date
                    if (!desc_ngay_ddmmyyyy[0].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[0]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_mmyyyy[0].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_mmyyyy[0]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_mmyyyy[1].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_mmyyyy[1]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_mmyyyy[2].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', 'CDNT','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_mmyyyy[2]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    //có lỗi
                    flag_log = Constants.FLAG_VALUES_X;
                }

            }
            /**-----------------------------------------------------------------*
             *                      SHEET 10KK-TNCN                             *
             **-----------------------------------------------------------------*/
            sheet_name = workbook.getSheet("10KK-TNCN");
            t_rows = sheet_name.getLastRowNum();

            String mst_dtk = "", hd_dlt_so = "", hd_dlt_ngay ="";
            
            //Start from row 6
            for (int i = 6; i <= t_rows; i++) {
                row = sheet_name.getRow(i);

                //clear
                desc_tin = "";
                desc_kylb = "";
                desc_cltnct = "";
                desc_money_tk = "";
                desc_ngay_ddmmyyyy = new String[9];
                //kiểm tra định dạng ngày
                desc_ngay_ddmmyyyy[0] = Utility.checkDateDDMMYYYY(row.getCell(11).toString()); 
                desc_ngay_ddmmyyyy[1] = Utility.checkDateDDMMYYYY(row.getCell(12).toString());
                desc_ngay_ddmmyyyy[2] = Utility.checkDateDDMMYYYY(row.getCell(14).toString());
                desc_ngay_ddmmyyyy[3] = Utility.checkDateDDMMYYYY(row.getCell(15).toString());
                desc_ngay_ddmmyyyy[4] = Utility.checkDateDDMMYYYY(row.getCell(17).toString());
                desc_ngay_ddmmyyyy[5] = Utility.checkDateDDMMYYYY(row.getCell(18).toString());
                desc_ngay_ddmmyyyy[6] = Utility.checkDateDDMMYYYY(row.getCell(20).toString());
                desc_ngay_ddmmyyyy[7] = Utility.checkDateDDMMYYYY(row.getCell(21).toString());
                if(!row.getCell(24).toString().isEmpty())
                {
                desc_ngay_ddmmyyyy[8] = Utility.checkDateDDMMYYYY(row.getCell(24).toString());
                } else { desc_ngay_ddmmyyyy[8] = ""; }
                
                //kiểm tra số tiền không âm
                desc_money_tk = Utility.checkAm("Doanh thu ph¸t sinh trong kú", row.getCell(2).toString()); 
                desc_money_tk = desc_money_tk + Utility.checkAm("Thu nhËp chÞu thuÕ", row.getCell(4).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Gi¶m trõ gia c¶nh", row.getCell(5).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Gi¶m trõ b¶n th©n", row.getCell(6).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Gi¶m trõ cho ng­êi phô thuéc", row.getCell(7).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Thu nhËp tÝnh thuÕ", row.getCell(8).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Thu nhËp dù kiÕn ph¶i nép", row.getCell(9).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Quý I ph©n bæ", row.getCell(10).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Quý II ph©n bæ", row.getCell(13).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Quý III ph©n bæ", row.getCell(16).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Quý IV ph©n bæ", row.getCell(19).toString());
                desc_money_tk = desc_money_tk + Utility.checkAm("Sè tiÒn ®· ho¹ch to¸n", row.getCell(25).toString());
                
                //Check tỷ lệ thu nhập chịu thuế
                desc_cltnct = Utility.checkTLTNCT(Integer.parseInt(row.getCell(3).toString()));
                //Check data 10KK-TNCN
                desc_tin  = Utility.checkTIN(row.getCell(0).toString());

                desc_kylb = Utility.checkKyLBMMYYYY(row.getCell(1).toString());
                
                //ghi vào database trung gian
                if (desc_tin.isEmpty() && desc_kylb.isEmpty() && desc_ngay_ddmmyyyy[0].isEmpty() && desc_ngay_ddmmyyyy[1].isEmpty() && desc_ngay_ddmmyyyy[2].isEmpty() && desc_ngay_ddmmyyyy[3].isEmpty() 
                        && desc_ngay_ddmmyyyy[4].isEmpty() && desc_ngay_ddmmyyyy[5].isEmpty() && desc_ngay_ddmmyyyy[6].isEmpty() 
                        && desc_ngay_ddmmyyyy[7].isEmpty() && desc_ngay_ddmmyyyy[8].isEmpty() && desc_cltnct.isEmpty() && desc_money_tk.isEmpty()) {
                    
                    //Kiểm tra mã số thuế đại lý có giá trị hay không
                    if(!row.getCell(22).toString().isEmpty()){
                        mst_dtk = row.getCell(22).toString();
                    }else{ mst_dtk = "";}
                    
                    //Kiểm tra hợp đồng đại lý thuế số
                    if(!row.getCell(23).toString().isEmpty()){
                        hd_dlt_so = row.getCell(23).toString();
                    }else{ hd_dlt_so = "";}
                    
                    //Kiểm tra ngày hợp đồng
                    if(!row.getCell(24).toString().isEmpty()){
                        hd_dlt_ngay = row.getCell(24).toString();
                    }else{ hd_dlt_ngay = "";}
                    
                    sql = "insert into tb_tk (TIN, KYLB_TU_NGAY, KYKK_TU_NGAY, "
                            + "KYKK_DEN_NGAY, DTHU_DKIEN, TL_THNHAP_DKIEN, THNHAP_CTHUE_DKIEN, "
                            + "GTRU_GCANH, BAN_THAN, PHU_THUOC, THNHAP_TTHUE_DKIEN, "
                            + "TNCN, PB01, kytt01, HT01, "
                            + "HN01, PB02, kytt02, HT02, "
                            + "HN02, PB03, kytt03, HT03, "
                            + "HN03, PB04, kytt04, HT04, "
                            + "HN04, imp_file, tax_model, short_name, "
                            + "ma_cqt, mst_dtk, hd_dlt_so, hd_dlt_ngay, rv_so_tien) values ("
                            + "'" + row.getCell(0).toString() + "','01/" + row.getCell(1) + "','" + Constants.KYKK_TU_NGAY + "','"
                            + Constants.KYKK_DEN_NGAY + "'," + row.getCell(2) + ", " + row.getCell(3) + "," + row.getCell(4) + ","
                            + row.getCell(5) + "," + row.getCell(6) + "," + row.getCell(7) + "," + row.getCell(8) + ","
                            + row.getCell(9) + "," + row.getCell(10) + ",'" + Utility.getQuy(row.getCell(11).toString()) + "','" + row.getCell(11) + "','"
                            + row.getCell(12) + "','" + row.getCell(13) + "','" + Utility.getQuy(row.getCell(14).toString()) + "','" + row.getCell(14) + "','"
                            + row.getCell(15) + "','" + row.getCell(16) + "','" + Utility.getQuy(row.getCell(17).toString()) + "','" + row.getCell(17) + "','"
                            + row.getCell(18) + "','" + row.getCell(19) + "','" + Utility.getQuy(row.getCell(20).toString()) + "','" + row.getCell(20) + "','"
                            + row.getCell(21) + "','" + file_name + "','" + InfoCQT[2] + Constants.TAX_MODEL + "','"
                            + InfoCQT[1] + "','" + InfoCQT[0] + "','" + mst_dtk + "','" + hd_dlt_so + "','" + hd_dlt_ngay + "'," + row.getCell(25) + ")";

                    //Insert to db
                    ConnectDB.sqlDatabase(sql);

                    //total row inserted
                    total_tk++;

                } // Ghi dữ liệu vào log
                else {
                    //log tin
                    if (!desc_tin.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_tin) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    //log tỷ lệ thu nhập chịu thuế
                    if (!desc_cltnct.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + desc_cltnct + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    //log kiểm tra số tiền âm
                    if (!desc_money_tk.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + desc_money_tk + " cã sè tiÒn ©m  ','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    
                    //log ky_lb
                    if (!desc_kylb.isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_kylb) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }

                    if (!desc_ngay_ddmmyyyy[0].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[0]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[1].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[1]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[2].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[2]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[3].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[3]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[4].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[4]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[5].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[5]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[6].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[6]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[7].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[7]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    if (!desc_ngay_ddmmyyyy[8].isEmpty()) {
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        sql_log = "INSERT INTO tb_log_excel (short_name, sheet, file_imp, status, imp_date, desc_err, row_err)"
                                + "                VALUES   ('" + InfoCQT[1] + "', '10KK-TNCN','" + file_name + "','E','" + imp_date + "','" + UnicodeConverter.Tcvn3Converter.convertU(desc_ngay_ddmmyyyy[8]) + "','" + (row.getRowNum() + 1) + "')";

                        ConnectDB.sqlDatabase(sql_log);
                    }
                    
                    //có lỗi
                    flag_log = Constants.FLAG_VALUES_X;
                }
                
            }


            //Xóa dữ liệu và chuyển vào thư mục lỗi
            if (flag_log.equals(Constants.FLAG_VALUES_X)) {
                //Chuyển vào thư mục lỗi
                File crtForder = new File(tgrErr);
                if (!crtForder.exists()) {
                    crtForder.mkdir();
                }
                Utility.moveFiles(file, tgrErr);

                //Xóa dữ liệu trường hợp có sheet đã insert vào
                ConnectDB.delExlData(file_name);

                //Hiển thị cảnh báo
                setFlag("X");

            } else {
                //Cập nhật dữ liệu file đã thành công
                //Dữ liệu NO
                if (total_no > 0) {
                    imp_date = Constants.dateFormat.format(new Date());//import date
                    sql_secc = " INSERT INTO tb_log_excel (short_name, sheet, file_imp, total_row_imp, status, imp_date)"
                            + " VALUES   ('" + InfoCQT[1] + "', 'NO','" + file_name + "'," + total_no + ",'S','" + imp_date + "')";
                    ConnectDB.sqlDatabase(sql_secc);
                }

                //Dữ liệu PS
                if (total_ps > 0) {
                    imp_date = Constants.dateFormat.format(new Date());//import date
                    sql_secc = " INSERT INTO tb_log_excel (short_name, sheet, file_imp, total_row_imp, status, imp_date)"
                            + " VALUES   ('" + InfoCQT[1] + "', 'PS','" + file_name + "'," + total_ps + ",'S','" + imp_date + "')";
                    ConnectDB.sqlDatabase(sql_secc);
                }

                //Dữ liệu TK
                if (total_tk > 0) {
                    imp_date = Constants.dateFormat.format(new Date());//import date
                    sql_secc = " INSERT INTO tb_log_excel (short_name, sheet, file_imp, total_row_imp, status, imp_date)"
                            + " VALUES   ('" + InfoCQT[1] + "', 'TK','" + file_name + "'," + total_tk + ",'S','" + imp_date + "')";
                    ConnectDB.sqlDatabase(sql_secc);
                }

            }



        } catch (Exception ex) {
            ex.printStackTrace();
            String getlog = "File: " + file_name + " | Sheet: " + sheet_name.getSheetName() + " | row: " + (row.getRowNum() + 1) + " | Desc: " + ex.getMessage();
            //set log
            setGetlog(getlog);
            throw new RuntimeException(getlog);
        }

    }
    //get log
    private static String getlog;
    //short_name
    private static String short_name;
    //flag đánh dấu có lỗi hay không
    private static String flag;

    public static String getGetlog() {
        return getlog;
    }

    public static void setGetlog(String getlog) {
        ImpExlToOra.getlog = getlog;
    }

    public static String getShort_name() {
        return short_name;
    }

    public static void setShort_name(String short_name) {
        ImpExlToOra.short_name = short_name;
    }

    public static String getFlag() {
        return flag;
    }

    public static void setFlag(String flag) {
        ImpExlToOra.flag = flag;
    }
    
    public static void main(String[] args) {
        
    }
}
