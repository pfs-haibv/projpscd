/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.datatype;

/**
 *
 * @author Administrator
 */
public class DataList {    
    
    private String id;//mã district or province
    private String values;//values new
    private String mode;//mode = U|I (U = Update, I = Insert)
    private int table;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public int getTable() {
        return table;
    }

    public void setTable(int table) {
        this.table = table;
    }

    public String getValues() {
        return values;
    }

    public void setValues(String values) {
        this.values = values;
    }

    public DataList() {
    }

    public DataList(String id, String values, String mode, int table) {
        this.id = id;
        this.values = values;
        this.mode = mode;
        this.table = table;
    }   
            
}
