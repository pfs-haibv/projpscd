/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.utility;

import com.pit.system.Constants;
import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Calendar;


/**
 * Methods utility
 * @author HAIBV
 */
public class Utility {
   
    /**
     * Directory file on folder
     * @param name
     * @param files 
     */
    public static void dirFiles(String name, String files) {
        try {
            File actual = new File(files);
            for (File f : actual.listFiles()) {
                //System.out.println(name+f.getName());
            }
        } catch (Exception ex) {
        }
    }

    /**
     * Move file from folder to folder
     * @param source
     * @param targer 
     */
    
    public static void moveFiles(String source, String targer) {
        // File (or directory) to be moved
        File file = new File(source);
        // Destination directory
        File dir = new File(targer);
        //Delete file nếu đã tồn tại file đó
        //File f_del = new File(targer+"\\"+file.getName());
        //f_del.delete();              
        //Move file to new directory
        boolean success = file.renameTo(new File(dir, file.getName()));

        if (!success) {
            // File was not successfully moved                
        }
    }

    /**
     * Delete file on folder
     * @param file 
     */
    public static void delFiles(File file) {

        boolean success = file.delete();
        if (!success) {
            System.out.println("Deletion file " + file + " failed.");
        } else {
            System.out.println("File deleted.");
        }

    }
    /**
     * Copy files from folder to folder
     * @param srcPath
     * @param dstPath
     * @throws IOException 
     */

    public static void copyDirectory(File srcPath, File dstPath) throws IOException {
        // bỏ trường hợp srcPath = dstPath
        if (!srcPath.equals(dstPath)) {
            if (srcPath.isDirectory()) {
                if (!dstPath.exists()) {
                    dstPath.mkdir();
                }

                String files[] = srcPath.list();
                for (int i = 0; i < files.length; i++) {
                    copyDirectory(new File(srcPath, files[i]), new File(dstPath, files[i]));
                }
            } else {
                if (!srcPath.exists()) {
                    System.out.println("File or directory does not exist.");
                    System.exit(0);
                } else {
                    InputStream in = new FileInputStream(srcPath);
                    OutputStream out = new FileOutputStream(dstPath);

                    // Transfer bytes from in to out
                    byte[] buf = new byte[1024];
                    int len;
                    while ((len = in.read(buf)) > 0) {
                        out.write(buf, 0, len);
                    }
                    in.close();
                    out.close();
                }
            }
        }

    }

    /**
     * Tạo thư mục chứa các file excel      
     * @param short_name_ 
     */
    public static void getConfig(String[] short_name_) {
        File crtForder = null;
        //Khởi tạo thư mục chính
        crtForder = new File(Constants.CONFIG_DEFAULT);
        crtForder.mkdir();
        //Khởi tạo thư mục Data
        crtForder = new File(Constants.CONFIG_EXCELDATA);
        crtForder.mkdir();
        for (int i = 0; i < short_name_.length; i++) {
            crtForder = new File(Constants.CONFIG_EXCELDATA + short_name_[i]);
            crtForder.mkdir();
        }
        //Khởi tạo thư mục Backup
        crtForder = new File(Constants.CONFIG_BACKUP);
        crtForder.mkdir();
        //Khởi tạo thư mục Errors
        crtForder = new File(Constants.CONFIG_ERRORS);
        crtForder.mkdir();
    }

    /**
     * Kiểm tra gía trị là number
     * @param i
     * @return boolean
     */
    public static boolean isNumber(String i) {
        try {
            Integer.parseInt(i);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }

    /**
     * Kiểm tra giá trị date
     * @param dateFormat
     * @return date_format
     */
    public static String nowDate(String dateFormat) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        return sdf.format(cal.getTime());
    }

    /**
     * Tạo file lấy thông số connect database oracle
     * write thông tin config       
     * @param file_ora
     * @return getConnORA
     */
    public static String getConfigORA(String file_ora) throws IOException {

        String getConnORA = "";
        File file = new File(file_ora);
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        DataInputStream dis = null;
        String line = null;
        try {

            //Create file 
            if (!file.exists()) {
                file.createNewFile();
                //write use buffering
                Writer output = new BufferedWriter(new FileWriter(file));
                output.write("jdbc:oracle:thin:@10.64.9.199:1522/DPPIT,TKTQ,TKTQ");
                output.close();
            }

            fis = new FileInputStream(file);

            // Here BufferedInputStream is added for fast reading.
            bis = new BufferedInputStream(fis);
            dis = new DataInputStream(bis);

            // dis.available() returns 0 if the file does not have more lines.
            while ((line = dis.readLine()) != null) {
                getConnORA = line;
            }

            // dispose all the resources after using them.
            fis.close();
            bis.close();
            dis.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return getConnORA;
    }

    /**
     * Lấy ngày cuối cùng của tháng
     * @param datetime
     * @return max_date
     */
    public static String getMaxDate(String datetime) {

        String max_date = "";

        String month_year[] = datetime.split("/");
        //Year
        int year = Integer.parseInt(month_year[1]);
        //Month (January = 0 ... )
        int month = Integer.parseInt(month_year[0]) - 1;
        //date        
        int date = 01;

        Calendar calendar = Calendar.getInstance();

        calendar.set(year, month, date);

        int maxDay = calendar.getActualMaximum(calendar.DATE);

        max_date = maxDay + "/" + datetime;

        return max_date;

    }

    /**
     * Lây thông tin năm và quý VD: 2012QI
     * @param datetime
     * @return year_quy
     */
    public static String getQuy(String datetime) {

        String quy = "";

        String month_year[] = datetime.split("/");

        String year = month_year[2].substring(2);

        int month = Integer.parseInt(month_year[1]);

        //Quý 1
        if (month < 4) {
            quy = Constants.QUY[0];
        } //Quý 2
        else if (4 <= month && month < 7) {
            quy = Constants.QUY[1];
        } //Quý 3
        else if (7 <= month && month < 10) {
            quy = Constants.QUY[2];
        } //Quý 4
        else {
            quy = Constants.QUY[3];
        }
        return year + quy;

    }

    /**
     * Check tin: length, and format
     * @param tin
     * @return mess_err
     * @throws Exception 
     */
    public static String checkTIN(String tin) throws Exception {
        String dess = "";
        //Check length
        int num = tin.length();
        if (!(num == 10 || num == 14)) {
            dess = "KiÓm tra l¹i ®Þnh d¹ng vµ ®é dµi cña m· TIN";
        }
        //Check format
        if (tin.indexOf("E") >= 0) {
            dess = "TIN kh«ng ®óng ®Þnh d¹ng";
        }

        return dess;
    }

    /**
     * 
     *          Mẫu tờ khai theo tiểu mục: 
     * <p>
     *               1001: 02T/KK-TNCN, 02Q/KK-TNCN, 07/KK-TNCN 
     * <p>
     *               1003: 03T/KK-TNCN, 03Q/KK-TNCN, 07/KK-TNCN, 01/KK-BH, 01/KK-XS, 08/KK-TNCN, 08A/KK-TNCN, 10/KK-TNCN, 10A/KK-TNCN 
     * <p>
     *               1004: 03T/KK-TNCN, 03Q/KK-TNCN 
     * <p>   
     *               1007: 03T/KK-TNCN, 03Q/KK-TNCN 
     * <p>               
     *               1008: 03T/KK-TNCN, 03Q/KK-TNCN 
     * <p>
     *               1014: 08TN/KK-TNCN, 08ATN/KK-TNCN 
     * <p>
     *           Mã tờ khai theo kỳ kê khai: 
     * <p>
     *               02T/KK-TNCN: kỳ kê khai định dạng tháng 
     * <p>
     *               02Q/KK-TNCN: kỳ kê khai định dáng quý 
     * <p>
     *               03T/KK-TNCN: kỳ kê khai định dạng tháng 
     * <p>
     *               03Q/KK-TNCN: kỳ kê khai định dạng quý 
     * <p>
     *               07/KK-TNCN: kỳ kê khai định dạng tháng 
     * <p>
     *               01/KK-BH: kỳ kê khai định dạng tháng 
     * <p>
     *               01/KK-XS: Kỳ kê khai định dạng tháng 
     * <p>
     *               08/KK-TNCN: định dạng cả tháng, quý, năm 
     * <p>
     *               08A/KK-TNCN: định dạng cả tháng, quý, năm 
     * <p>
     *               10/KK-TNCN: định dạng năm 
     * <p>
     *               10A/KK-TNCN: định dạng năm
     * @param tmuc
     * @param mau_tk
     * @param ky_kk_tu
     * @param ky_kk_den 
     */
    public static String checkDataPS(String tmuc, String mau_tk, String ky_kk_tu, String ky_kk_den) {

        String desc = "";
        /* Check Mã TK theo tiểu mục 1001 */
        if (tmuc.equals("1001") && Constants.MAUTK_1001.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1001";
        }
        //Mã TK theo tiểu mục 1003
        if (tmuc.equals("1003") && Constants.MAUTK_1003.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1003";
        }
        //Mã TK theo tiểu mục 1004
        if (tmuc.equals("1004") && Constants.MAUTK_1004.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1004";
        }
        //Mã TK theo tiểu mục 1007
        if (tmuc.equals("1007") && Constants.MAUTK_1007.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1007";
        }
        //Mã TK theo tiểu mục 1008
        if (tmuc.equals("1008") && Constants.MAUTK_1008.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1008";
        }
        //Mã TK theo tiểu mục 1014
        if (tmuc.equals("1014") && Constants.MAUTK_1014.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng ®óng theo tiÓu môc 1014";
        }

        /* Check Mã TK theo kỳ kê khai */

        String ky_kk = "";//Kỳ kê khai tháng, quy, năm
        //Ky KK thuộc tháng
        if (ky_kk_tu.equals(ky_kk_den)) {
            ky_kk = "T";
        }

        //Kỳ KK thuộc quý
        String ky = ky_kk_tu.substring(0, 2) + ky_kk_den.substring(0, 2);
        if (Constants.KYKK_THUOC_QUY.indexOf(ky) >= 0) {
            ky_kk = "Q";
        }
        //Kỳ KK thuộc năm
        if (ky.equals("0112")) {
            ky_kk = "N";
        }

        //Mẫu TK thuộc kỳ tháng
        if (ky_kk.equalsIgnoreCase("T") && Constants.MAUTK_THANG.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng thuéc kú th¸ng";
        }

        //Mẫu TK thuộc kỳ quý
        if (ky_kk.equalsIgnoreCase("Q") && Constants.MAUTK_QUY.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng thuéc kú quý";
        }

        //Mẫu TK thuộc kỳ năm
        if (ky_kk.equalsIgnoreCase("N") && Constants.MAUTK_NAM.indexOf(mau_tk) < 0) {
            desc = "MÉu TK " + mau_tk + " kh«ng thuéc kú n¨m";
        }

        return desc;
    }

    /**
     * Kiểm tra tiểu mục CDNT có thuộc tiểu mục TNCN hay không
     * @param tmuc
     * @return mess_err
     */
    public static String checkDataCDNT(String tmuc) {

        String desc = "";

        if (Constants.MTMUC_CDNT.indexOf(tmuc) < 0) {
            desc = "TiÓu môc " + tmuc + " kh«ng thuéc tiÓu môc TNCN";
        }

        return desc;
    }

    /**
     * Kiểm tra theo định dạng DD/MM/YYYY
     * @param date
     * @return mess_err
     * @throws Exception 
     */
    public static String checkDateDDMMYYYY(String date) throws Exception {
        //Date temp_d;
        String desc = "";
        try {
            if (date.length() < 10) {
                desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (DD/MM/YYYY)";
            } else {
                //temp_d = Constants.DATE_DDMMYYY.parse(date);
                String day[] = date.toString().split("/");

                int m = Integer.parseInt(day[1]) - 1,
                        d = Integer.parseInt(day[0]),
                        y = Integer.parseInt(day[2]);
                Calendar c = Calendar.getInstance();
                c.set(y, m, d);
                if (m != c.get(Calendar.MONTH) || d != c.get(Calendar.DATE) || y != c.get(Calendar.YEAR)) {
                    desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (DD/MM/YYYY)";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return desc;
    }

    /**
     * Kiểm tra theo định dạng DD/MM/YYYY
     * @param date
     * @return mess_err
     * @throws Exception 
     */
    public static String checkDateMMYYYY(String date) throws Exception {
        //Date temp_d;
        String desc = "";
        try {
            if (date.length() < 7) {
                desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (MM/YYYY)";
            } else {
                //temp_d = Constants.DATE_DDMMYYY.parse(date);
                String day[] = date.toString().split("/");

                    int m = Integer.parseInt(day[0]) - 1,
                        d = 01,
                        y = Integer.parseInt(day[1]);
                Calendar c = Calendar.getInstance();
                c.set(y, m, d);
                if (m != c.get(Calendar.MONTH) || d != c.get(Calendar.DATE) || y != c.get(Calendar.YEAR)) {
                    desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (MM/YYYY)";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return desc;
    }

    /**
     * Kiểm tra theo định dạng DD/MM/YYYY
     * @param date
     * @return mess_err
     * @throws Exception 
     */
    public static String checkKyLBMMYYYY(String date) throws Exception {
        //Date temp_d;
        String desc = "";
        try {
            if (date.length() < 7) {
                desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (MM/YYYY)";
            } else {
                //temp_d = Constants.DATE_DDMMYYY.parse(date);
                String day[] = date.toString().split("/");

                    int m = Integer.parseInt(day[0]) - 1,
                        d = 01,
                        y = Integer.parseInt(day[1]);
                //kỳ LB theo năm 2012
                if (y != 2012) {
                    desc = "Kú lËp bé "+date+" cã n¨m lÊy theo n¨m 2012";
                } else {
                    Calendar c = Calendar.getInstance();
                    c.set(y, m, d);

                    if (m != c.get(Calendar.MONTH) || d != c.get(Calendar.DATE) || y != c.get(Calendar.YEAR)) {
                        desc = "§Þnh d¹ng " + date + " kh«ng hîp lÖ, chuyÓn theo ®Þnh d¹ng (MM/YYYY)";
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return desc;
    }   

    /**
     * Kiểm tra tỷ lệ thu nhập chịu thuế
     * @param tltnct
     * @return mess_err
     * @throws Exception 
     */
    public static String checkTLTNCT(int tltnct) throws Exception {
        String desc = "";
        if( !(tltnct >= 0 && tltnct <= 100) )           
        desc = "tû lÖ thu nhËp chÞu thuÕ trong kho¶ng (0, 100)";       

        return desc;
    }
    
    /**
     * kiểm tra trường số tiền có âm không
     * @param field
     * @param money
     * @return mô tả số tiền
     */
    public static String checkAm(String field,String money){
        
        String desc = "";
        
        double d = Double.parseDouble(money);
        
        if(d < 0){
           desc = field+ " , ";

        }
        
        return desc;
        
    }
    
    
    public static void main(String[] args) {
        
    }
}
