/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.convert;

import com.pit.datatype.DataList;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 *
 * @author Administrator
 * 
 */
public class UpdateList {

    //mảng danh mục thay đổi
    public static ArrayList<DataList> arr_list = new ArrayList<>();

    /**
     * Lấy thông tin danh mục District and Province thay đổi
     * @param file
     * @return arr_list
     * @throws FileNotFoundException 
     */
    public static ArrayList<DataList> getList(File file) throws FileNotFoundException {

        //Scand folder list
        for (File l : file.listFiles()) {

            HSSFRow row = null;//Row   
            HSSFSheet sheet_name = null;//sheet_name

            try {
                FileInputStream fileInputStream = new FileInputStream(l.getAbsoluteFile());
                HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
                /**-----------------------------------------------------------------*
                 *                      SHEET LIST                                  *
                 **-----------------------------------------------------------------*/
                sheet_name = workbook.getSheet("Sheet1");
                int t_rows = sheet_name.getLastRowNum();
                for (int i = 1; i <= t_rows; i++) {

                    row = sheet_name.getRow(i);

                    DataList list = new DataList();

                    list.setId(row.getCell(0).toString());
                    list.setMode(row.getCell(3).toString());
                    list.setValues(row.getCell(1).toString());

                    //Set update cho table 
                    if (list.getId().length() == 8) {
                        list.setTable(2);//Phường xã ADRCITYPRT
                    } else {
                        list.setTable(1);//Thành phố ADRCITYT
                    }
                    //add to array list
                    arr_list.add(list);
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return arr_list;
    }
}
