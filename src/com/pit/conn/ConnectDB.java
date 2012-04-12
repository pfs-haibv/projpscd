/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.conn;

import com.pit.convert.ConvertPSCDVATApp;
import java.io.IOException;
import java.sql.*;
import com.pit.utility.Utility;

/**
 *
 * @author Administrator
 */
public class ConnectDB {

    /**
     * @des get connection oracle database
     * @param sql
     * @return
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
     * @desc thực hiện các câu lệnh sql database
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
     * @desc insert cqt convert to database
     * @param sql
     * @throws SQLException 
     */
    public static void insCQTConvert(String short_name, String type_date, String imp_time) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "insert into tb_cqt_convert (short_name, type_data, imp_date) values ('"+short_name+"','"+type_date+"','"+imp_time+"')";
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
     * @desc delete data of file excel
     * @param sql
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
        String sql_no = "delete from tb_no a where short_name = '"+try_cqt+"' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_ps = "delete from tb_ps a where short_name = '"+try_cqt+"' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";
        String sql_tk = "delete from tb_tk a where short_name = '"+try_cqt+"' and a.imp_file in (" + del_file.substring(0, del_file.length() - 1) + ")";

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
     * 
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
     * 
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
                info = rset.getString("tax_code") + "," + rset.getString("short_name") +","+rset.getString("tax_model");
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
     * 
     * @param sql
     * @throws SQLException 
     * @return number convert
     */
    public static int[] getNumCV(String short_name) throws SQLException {
        int cqt_cv [] = new int[3];              
        Connection conn = null;
        Statement stmt  = null;
        ResultSet rset  = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            String sql = "SELECT count(type_data) num_convert FROM tb_cqt_convert a where a.short_name = '" + short_name
                       + "' and  a.type_data in ('NO','PS','TK') group by type_data order by a.type_data";
            rset = stmt.executeQuery(sql);
            int i = 0;
            while (rset.next()) {
                cqt_cv[i] = rset.getInt("num_convert");
                i ++;
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
    
    
    /*
     * @desc insert error code into database
     * @param sql
     * @throws SQLException
     */
    public static void insErrCode(String short_name, String rid, String err_string) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "insert into tb_unsplit_data_error (short_name, rid, table_name, err_string) values ("
                + short_name + ", '" + rid + "', 'TB_TK', '" + err_string + "')";
        try {
            System.out.println(sql);
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
        }
    }

}
