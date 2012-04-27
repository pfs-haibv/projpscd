package com.pit.conn;

import com.pit.convert.ConvertPSCDVATApp;
import java.io.IOException;
import java.sql.*;
import com.pit.utility.Utility;

/**
 * Thực hiện các truy vấn đến CSDL Oracle
 * @author Administrator
 */
public class ConnectDB {

    /**
     * Get connection oracle database
     * @return connection to database
     * @throws SQLException 
     */
    public static Connection getConnORA() throws SQLException, IOException {

        //Load info database oracle         
        String config_ora[] = Utility.getConfigORA("configORA.ora").split(",");
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = config_ora[0];
            String username = config_ora[1];
            String password = config_ora[2];
            conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException ex) {
            throw new SQLException(ex.getMessage());
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Driver not found.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * Thực hiện các câu lệnh sql database
     * @param sql
     * @throws SQLException 
     */
    public static void sqlDatabase(String sql) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Insert cqt convert to database
     * @param short_name
     * @param type_date
     * @param imp_time
     * @throws SQLException 
     */
    public static void insCQTConvert(String short_name, String type_date, String imp_time) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "insert into tb_cqt_convert (short_name, type_data, imp_date) values ('" + short_name + "','" + type_date + "','" + imp_time + "')";
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Delete data of file excel
     * @param try_cqt
     * @param file_imp
     * @throws SQLException 
     */
    public static void delExlData(String try_cqt, String file_imp) throws SQLException {

        String[] arr_file = file_imp.split(",");
        // số file dữ liệu cần xóa
        int num_file = arr_file.length;
        // delete file
        String del_file = "";
        for (int i = 0; i < num_file; i++) {
            del_file = del_file + "'" + arr_file[i].trim() + "',";

        }
        //Query delete table TB_NO, TB_PS, TB_TK
        String sql_no = "delete from tb_no a where short_name = '" + try_cqt + "' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_ps = "delete from tb_ps a where short_name = '" + try_cqt + "' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_tk = "delete from tb_tk a where short_name = '" + try_cqt + "' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql_no);
            rset = stmt.executeQuery(sql_ps);
            rset = stmt.executeQuery(sql_tk);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Delete data file excel 
     * @param file_imp
     * @throws SQLException 
     */
    public static void delExlData(String file_imp) throws SQLException {

        String[] arr_file = file_imp.split(",");
        // số file dữ liệu cần xóa
        int num_file = arr_file.length;
        // delete file
        String del_file = "";
        for (int i = 0; i < num_file; i++) {
            del_file = del_file + "'" + arr_file[i].trim() + "',";
        }
        //Query delete table TB_NO, TB_PS, TB_TK
        String sql_no = "delete from tb_no a where a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_ps = "delete from tb_ps a where a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_tk = "delete from tb_tk a where a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql_no);
            rset = stmt.executeQuery(sql_ps);
            rset = stmt.executeQuery(sql_tk);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Thực hiện lấy thông tin để ghi log sau khi convert
     * @param sql
     * @throws SQLException 
     * @return short_name, id, tin
     */
    public static String getInfoLog(String sql) throws SQLException {
        String info = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            while (rset.next()) {
                info = rset.getString("short_name") + "," + rset.getString("id") + "," + rset.getString("tin");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
        return info;
    }

    /**
     * Thực hiện lấy thông tin CQT
     * @param sql
     * @throws SQLException 
     * @return short_name, ma_cqt
     */
    public static String getInfoCQT(String sql) throws SQLException {
        String info = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            while (rset.next()) {
                info = rset.getString("tax_code") + "," + rset.getString("short_name") + "," + rset.getString("tax_model");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
        return info;
    }

    /**
     * Lấy thông tin số lượng dữ liệu đã chuyển đổi
     * @param short_name
     * @throws SQLException 
     * @return number convert
     */
    public static int[] getNumCV(String short_name) throws SQLException {
        int cqt_cv[] = new int[3];
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            String sql = "SELECT count(type_data) num_convert FROM tb_cqt_convert a where a.short_name = '" + short_name
                    + "' and  a.type_data in ('NO','PS','TK') group by type_data order by a.type_data";
            rset = stmt.executeQuery(sql);
            int i = 0;
            while (rset.next()) {
                cqt_cv[i] = rset.getInt("num_convert");
                i++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
        return cqt_cv;
    }

    /**
     * Insert error code into database
     * @param short_name
     * @param rid
     * @param table_name
     * @param err_string
     * @throws SQLException 
     */
    public static void insUnSplitErrCode(String short_name, String rid, String table_name, String err_string) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql = "insert into tb_unsplit_data_error (short_name, rid, table_name, err_string)"
                + " values ( '" + short_name + "',"
                + " '" + rid + "',"
                + " '" + table_name + "',"
                + " '" + err_string + "')";
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Xóa dữ liệu trong bảng tb_unsplit_data_error khi thực hiện kiểm tra lại
     * @param short_name
     * @param table_name
     * @throws SQLException 
     */
    public static void delUnSplitErrCode(String short_name, String table_name) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql = "delete from tb_unsplit_data_error"
                + " where short_name = '" + short_name + "'"
                + " and table_name = '" + table_name + "'";

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Xóa dữ liệu cũ trong bảng tb_data_error khi thực hiện kiểm tra lại
     * @param short_name
     * @param table_name
     * @throws SQLException 
     */
    public static void delDataErrCode(String short_name, String table_name) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql = "delete from tb_data_error"
                + " where short_name = '" + short_name + "'"
                + " and table_name = '" + table_name + "'";

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Cập nhật trường update_no của dữ liệu cũ (cùng cơ quan thuế)
     * @param short_name
     * @param table_name
     * @throws SQLException 
     */
    public static void updateDataErrCode(String short_name, String table_name) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql = "UPDATE tb_data_error a "
                + "SET a.update_no = (SELECT MAX (b.update_no) + 1 "
                + "                     FROM tb_data_error b "
                + "                    WHERE b.short_name = '" + short_name + "' "
                + "                      AND b.table_name = '" + table_name + "') "
                + "WHERE a.short_name = '" + short_name +"' "
                + "AND a.table_name = '" + table_name + "' "
                + "AND a.update_no = 0";

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Gọi tới thủ tục kiểm tra dữ liệu Oracle
     * @param prcName
     * @param short_name
     * @throws SQLException 
     */
    public static void callOraclePrcChk(String prcName, String short_name) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql;

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();

            sql = "begin pck_check_data." + prcName + "('" + short_name + "', '" + loadNgayChotDL(short_name) + "'); end;";
//                System.out.println(sql);s
            stmt.execute(sql);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Insert log when check data PSCD
     * @param short_name
     * @param pck
     * @throws SQLException 
     */
    public static void callOraclePrc_Ins_Log_Vs(String short_name, String pck, String status, String mesg) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql;

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();

            sql = "begin pck_trace_log.Prc_Ins_Log_Vs('" + short_name + "', '" + pck + "', '" + status + "', '" + mesg + "'); end;";
//                System.out.println(sql);
            stmt.execute(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Gọi thủ tục kiểm tra dữ liệu
     * @param prcName
     * @param short_name
     * @param table_name
     * @throws SQLException 
     */
    public static void callOraclePrcInsSplitErr(String prcName, String short_name, String table_name) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        String sql;

        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();

            sql = "begin pck_check_data." + prcName + "('" + short_name + "', '" + table_name + "'); end;";
//                System.out.println(sql);
            stmt.execute(sql);

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            stmt.close();
        }
    }

    /**
     * Lấy thông tin kỳ chốt (ky_no_den)
     * @param short_name
     * @return ngay_chot
     * @throws SQLException 
     */
    public static String loadNgayChotDL(String short_name) throws SQLException {
        //Ngày chốt
        String ngay_chot = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery("SELECT a.short_name, to_char(a.ky_no_den, 'DD-MON-YYYY') as ky_no_den FROM tb_lst_taxo a where a.short_name = '" + short_name + "'");
            while (rset.next()) {
                ngay_chot = rset.getString("ky_no_den");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
        return ngay_chot;
    }
}
