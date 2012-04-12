package com.pit.datatype;

/**
 *
 * @author Administrator
 * @desc Class chứa thông tin dữ liệu Người phụ thuộc
 */
public class DataNPT {
    
    private String      ID;
    private String      SHORT_NAME;
    private String 	TIN;            //	Mã số thuế
    private String 	PERIOD_KEY;     //	Kỳ tính thuế
    private String 	FBTYP;          //	Mẫu tờ khai
    private String 	APPEN_ID;       //	Mã bảng kê
    private String 	TAXPAYER_ID;    //	Mã số thuế
    private String 	TAXPAYER_NAME;  //	Họ và tên NNT
    private String 	BIRTHDAY;       //	Ngày sinh
    private String 	IDENTIFY_NUM;   //	Số CMND
    private String 	RELATIONSHIP;   //	Quan hệ với người nộp thuế
    private String 	NUM_OF_RELIEF;  //	Tổng số tháng giảm trừ
    private String 	INCOME_RELIEF;  //	Thu nhập được giảm trừ
    private String 	RELATIONSHIP_WH;//	Quan hệ vợ chồng
    private String 	STATUS;         //	Trạng thái
    private String 	MESSAGE;        //	Mô tả lỗi
    private String 	ICON_STATUS;    //	Trạng thái
    private String 	WAERS;          //	Tiền tệ

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }
    
    public String getSHORT_NAME() {
        return SHORT_NAME;
    }

    public void setSHORT_NAME(String SHORT_NAME) {
        this.SHORT_NAME = SHORT_NAME;
    }    
    
    public String getAPPEN_ID() {
        return APPEN_ID;
    }

    public void setAPPEN_ID(String APPEN_ID) {
        this.APPEN_ID = APPEN_ID;
    }

    public String getBIRTHDAY() {
        return BIRTHDAY;
    }

    public void setBIRTHDAY(String BIRTHDAY) {
        this.BIRTHDAY = BIRTHDAY;
    }

    public String getFBTYP() {
        return FBTYP;
    }

    public void setFBTYP(String FBTYP) {
        this.FBTYP = FBTYP;
    }

    public String getICON_STATUS() {
        return ICON_STATUS;
    }

    public void setICON_STATUS(String ICON_STATUS) {
        this.ICON_STATUS = ICON_STATUS;
    }

    public String getIDENTIFY_NUM() {
        return IDENTIFY_NUM;
    }

    public void setIDENTIFY_NUM(String IDENTIFY_NUM) {
        this.IDENTIFY_NUM = IDENTIFY_NUM;
    }

    public String getINCOME_RELIEF() {
        return INCOME_RELIEF;
    }

    public void setINCOME_RELIEF(String INCOME_RELIEF) {
        this.INCOME_RELIEF = INCOME_RELIEF;
    }

    public String getMESSAGE() {
        return MESSAGE;
    }

    public void setMESSAGE(String MESSAGE) {
        this.MESSAGE = MESSAGE;
    }

    public String getNUM_OF_RELIEF() {
        return NUM_OF_RELIEF;
    }

    public void setNUM_OF_RELIEF(String NUM_OF_RELIEF) {
        this.NUM_OF_RELIEF = NUM_OF_RELIEF;
    }

    public String getPERIOD_KEY() {
        return PERIOD_KEY;
    }

    public void setPERIOD_KEY(String PERIOD_KEY) {
        this.PERIOD_KEY = PERIOD_KEY;
    }

    public String getRELATIONSHIP() {
        return RELATIONSHIP;
    }

    public void setRELATIONSHIP(String RELATIONSHIP) {
        this.RELATIONSHIP = RELATIONSHIP;
    }

    public String getRELATIONSHIP_WH() {
        return RELATIONSHIP_WH;
    }

    public void setRELATIONSHIP_WH(String RELATIONSHIP_WH) {
        this.RELATIONSHIP_WH = RELATIONSHIP_WH;
    }

    public String getSTATUS() {
        return STATUS;
    }

    public void setSTATUS(String STATUS) {
        this.STATUS = STATUS;
    }

    public String getTAXPAYER_ID() {
        return TAXPAYER_ID;
    }

    public void setTAXPAYER_ID(String TAXPAYER_ID) {
        this.TAXPAYER_ID = TAXPAYER_ID;
    }

    public String getTAXPAYER_NAME() {
        return TAXPAYER_NAME;
    }

    public void setTAXPAYER_NAME(String TAXPAYER_NAME) {
        this.TAXPAYER_NAME = TAXPAYER_NAME;
    }

    public String getTIN() {
        return TIN;
    }

    public void setTIN(String TIN) {
        this.TIN = TIN;
    }

    public String getWAERS() {
        return WAERS;
    }

    public void setWAERS(String WAERS) {
        this.WAERS = WAERS;
    }
    
}
