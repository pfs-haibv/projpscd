package com.pit.datatype;

import java.io.Serializable;

/**
 *
 * @author HAIBV
 */
public class DataPSCD{
    
    private String ROW_NUM; //Mã dòng
    private String DOC_TYPE; //Ký hiệu giao dịch
    private String TAX_OFFICE_CODE; //Trường kí tự với độ dài là 5
    private String TIN; //Số giấy tờ
    private String PROFIT_CENTER; //Chương
    private String BUSINESS_AREA; //Khoản
    private String SEGMENT; //Tiểu mục
    private String PAY_GROUP; //Tài khoản Cơ quan thuế
    private String POSTING_DATE; //Posting date
    private String START_PERIOD; //Start date
    private String END_PERIOD; //End date
    private String DUE_DATE; //Due Date
    private String RETURN_CODE; //Return code
    private String AMOUNT; //Amount
    private String ID;
    private String RID; //Row ID

    public DataPSCD() {
    }   
    
    public DataPSCD(String ROW_NUM, String DOC_TYPE){
        this.ROW_NUM = ROW_NUM;
        this.DOC_TYPE = DOC_TYPE;
    }

    public String getAMOUNT() {
        return AMOUNT;
    }

    public void setAMOUNT(String AMOUNT) {
        this.AMOUNT = AMOUNT;
    }

    public String getBUSINESS_AREA() {
        return BUSINESS_AREA;
    }

    public void setBUSINESS_AREA(String BUSINESS_AREA) {
        this.BUSINESS_AREA = BUSINESS_AREA;
    }

    public String getDOC_TYPE() {
        return DOC_TYPE;
    }

    public void setDOC_TYPE(String DOC_TYPE) {
        this.DOC_TYPE = DOC_TYPE;
    }

    public String getDUE_DATE() {
        return DUE_DATE;
    }

    public void setDUE_DATE(String DUE_DATE) {
        this.DUE_DATE = DUE_DATE;
    }

    public String getEND_PERIOD() {
        return END_PERIOD;
    }

    public void setEND_PERIOD(String END_PERIOD) {
        this.END_PERIOD = END_PERIOD;
    }

    public String getPAY_GROUP() {
        return PAY_GROUP;
    }

    public void setPAY_GROUP(String PAY_GROUP) {
        this.PAY_GROUP = PAY_GROUP;
    }

    public String getPOSTING_DATE() {
        return POSTING_DATE;
    }

    public void setPOSTING_DATE(String POSTING_DATE) {
        this.POSTING_DATE = POSTING_DATE;
    }

    public String getPROFIT_CENTER() {
        return PROFIT_CENTER;
    }

    public void setPROFIT_CENTER(String PROFIT_CENTER) {
        this.PROFIT_CENTER = PROFIT_CENTER;
    }

    public String getRETURN_CODE() {
        return RETURN_CODE;
    }

    public void setRETURN_CODE(String RETURN_CODE) {
        this.RETURN_CODE = RETURN_CODE;
    }

    public String getROW_NUM() {
        return ROW_NUM;
    }

    public void setROW_NUM(String ROW_NUM) {
        this.ROW_NUM = ROW_NUM;
    }

    public String getSEGMENT() {
        return SEGMENT;
    }

    public void setSEGMENT(String SEGMENT) {
        this.SEGMENT = SEGMENT;
    }

    public String getSTART_PERIOD() {
        return START_PERIOD;
    }

    public void setSTART_PERIOD(String START_PERIOD) {
        this.START_PERIOD = START_PERIOD;
    }

    public String getTAX_OFFICE_CODE() {
        return TAX_OFFICE_CODE;
    }

    public void setTAX_OFFICE_CODE(String TAX_OFFICE_CODE) {
        this.TAX_OFFICE_CODE = TAX_OFFICE_CODE;
    }

    public String getTIN() {
        return TIN;
    }

    public void setTIN(String TIN) {
        this.TIN = TIN;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getRID() {
        return RID;
    }

    public void setRID(String RID) {
        this.RID = RID;
    }
    
    
}
