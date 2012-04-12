package com.pit.datatype;

/**
 *
 * @author HAIBV
 */
public class DataTK {
    
    private String ROW_NUM; //Mã dòng
    private String TAX_OFFICE_CODE; //Trường kí tự với độ dài là 5
    private String TAXPAYER_ID; //Mã số thuế
    private String START_PERIOD; //Start date
    private String END_PERIOD; //End date
    private String DUE_DATE; //Due Date
    private String A_F08_DOANH_THU_DU_KIEN; //
    private String A_F09_TY_LE_TNCT_DU_KIEN; //
    private String C_F10_TNCT_DU_KIEN; //
    private String C_F11_GIAM_TRU_GC; //
    private String A_F12_GIAM_TRU_BAN_THAN; //
    private String A_F13_GIAM_TRU_NPT; //
    private String C_F14_THU_NHAP_TINH_THUE; //
    private String C_F15_THUE_TNCN_DU_KIEN; //
    private String C_F16_THUE_PN_Q1; //
    private String C_F16_KY_TINH_THUE_Q1; //
    private String C_F16_KY_HACH_TOAN_Q1; //
    private String C_F16_HAN_NOP_Q1; //
    private String C_F17_THUE_PN_Q2; //
    private String C_F17_KY_TINH_THUE_Q2; //
    private String C_F17_KY_HACH_TOAN_Q2; //
    private String C_F17_HAN_NOP_Q2; //
    private String C_F18_THUE_PN_Q3; //
    private String C_F18_KY_TINH_THUE_Q3; //
    private String C_F18_KY_HACH_TOAN_Q3; //
    private String C_F18_HAN_NOP_Q3; //
    private String C_F19_THUE_PN_Q4; //
    private String C_F19_KY_TINH_THUE_Q4; //
    private String C_F19_KY_HACH_TOAN_Q4; //
    private String C_F19_HAN_NOP_Q4; //
    private String F13_MST_DLT;
    private String F20_HOP_DONG_DLT_SO;
    private String F_HOP_DONG_DLT_NGAY;    
    private String ID;
    private String RV_SO_TIEN;
    private String RID; //Row ID

    public DataTK() {
    }

    public String getA_F08_DOANH_THU_DU_KIEN() {
        return A_F08_DOANH_THU_DU_KIEN;
    }

    public void setA_F08_DOANH_THU_DU_KIEN(String A_F08_DOANH_THU_DU_KIEN) {
        this.A_F08_DOANH_THU_DU_KIEN = A_F08_DOANH_THU_DU_KIEN;
    }

    public String getA_F09_TY_LE_TNCT_DU_KIEN() {
        return A_F09_TY_LE_TNCT_DU_KIEN;
    }

    public void setA_F09_TY_LE_TNCT_DU_KIEN(String A_F09_TY_LE_TNCT_DU_KIEN) {
        this.A_F09_TY_LE_TNCT_DU_KIEN = A_F09_TY_LE_TNCT_DU_KIEN;
    }

    public String getA_F12_GIAM_TRU_BAN_THAN() {
        return A_F12_GIAM_TRU_BAN_THAN;
    }

    public void setA_F12_GIAM_TRU_BAN_THAN(String A_F12_GIAM_TRU_BAN_THAN) {
        this.A_F12_GIAM_TRU_BAN_THAN = A_F12_GIAM_TRU_BAN_THAN;
    }

    public String getA_F13_GIAM_TRU_NPT() {
        return A_F13_GIAM_TRU_NPT;
    }

    public void setA_F13_GIAM_TRU_NPT(String A_F13_GIAM_TRU_NPT) {
        this.A_F13_GIAM_TRU_NPT = A_F13_GIAM_TRU_NPT;
    }

    public String getC_F10_TNCT_DU_KIEN() {
        return C_F10_TNCT_DU_KIEN;
    }

    public void setC_F10_TNCT_DU_KIEN(String C_F10_TNCT_DU_KIEN) {
        this.C_F10_TNCT_DU_KIEN = C_F10_TNCT_DU_KIEN;
    }

    public String getC_F11_GIAM_TRU_GC() {
        return C_F11_GIAM_TRU_GC;
    }

    public void setC_F11_GIAM_TRU_GC(String C_F11_GIAM_TRU_GC) {
        this.C_F11_GIAM_TRU_GC = C_F11_GIAM_TRU_GC;
    }

    public String getC_F14_THU_NHAP_TINH_THUE() {
        return C_F14_THU_NHAP_TINH_THUE;
    }

    public void setC_F14_THU_NHAP_TINH_THUE(String C_F14_THU_NHAP_TINH_THUE) {
        this.C_F14_THU_NHAP_TINH_THUE = C_F14_THU_NHAP_TINH_THUE;
    }

    public String getC_F15_THUE_TNCN_DU_KIEN() {
        return C_F15_THUE_TNCN_DU_KIEN;
    }

    public void setC_F15_THUE_TNCN_DU_KIEN(String C_F15_THUE_TNCN_DU_KIEN) {
        this.C_F15_THUE_TNCN_DU_KIEN = C_F15_THUE_TNCN_DU_KIEN;
    }

    public String getC_F16_HAN_NOP_Q1() {
        return C_F16_HAN_NOP_Q1;
    }

    public void setC_F16_HAN_NOP_Q1(String C_F16_HAN_NOP_Q1) {
        this.C_F16_HAN_NOP_Q1 = C_F16_HAN_NOP_Q1;
    }

    public String getC_F16_KY_HACH_TOAN_Q1() {
        return C_F16_KY_HACH_TOAN_Q1;
    }

    public void setC_F16_KY_HACH_TOAN_Q1(String C_F16_KY_HACH_TOAN_Q1) {
        this.C_F16_KY_HACH_TOAN_Q1 = C_F16_KY_HACH_TOAN_Q1;
    }

    public String getC_F16_KY_TINH_THUE_Q1() {
        return C_F16_KY_TINH_THUE_Q1;
    }

    public void setC_F16_KY_TINH_THUE_Q1(String C_F16_KY_TINH_THUE_Q1) {
        this.C_F16_KY_TINH_THUE_Q1 = C_F16_KY_TINH_THUE_Q1;
    }

    public String getC_F16_THUE_PN_Q1() {
        return C_F16_THUE_PN_Q1;
    }

    public void setC_F16_THUE_PN_Q1(String C_F16_THUE_PN_Q1) {
        this.C_F16_THUE_PN_Q1 = C_F16_THUE_PN_Q1;
    }

    public String getC_F17_HAN_NOP_Q2() {
        return C_F17_HAN_NOP_Q2;
    }

    public void setC_F17_HAN_NOP_Q2(String C_F17_HAN_NOP_Q2) {
        this.C_F17_HAN_NOP_Q2 = C_F17_HAN_NOP_Q2;
    }

    public String getC_F17_KY_HACH_TOAN_Q2() {
        return C_F17_KY_HACH_TOAN_Q2;
    }

    public void setC_F17_KY_HACH_TOAN_Q2(String C_F17_KY_HACH_TOAN_Q2) {
        this.C_F17_KY_HACH_TOAN_Q2 = C_F17_KY_HACH_TOAN_Q2;
    }

    public String getC_F17_KY_TINH_THUE_Q2() {
        return C_F17_KY_TINH_THUE_Q2;
    }

    public void setC_F17_KY_TINH_THUE_Q2(String C_F17_KY_TINH_THUE_Q2) {
        this.C_F17_KY_TINH_THUE_Q2 = C_F17_KY_TINH_THUE_Q2;
    }

    public String getC_F17_THUE_PN_Q2() {
        return C_F17_THUE_PN_Q2;
    }

    public void setC_F17_THUE_PN_Q2(String C_F17_THUE_PN_Q2) {
        this.C_F17_THUE_PN_Q2 = C_F17_THUE_PN_Q2;
    }

    public String getC_F18_HAN_NOP_Q3() {
        return C_F18_HAN_NOP_Q3;
    }

    public void setC_F18_HAN_NOP_Q3(String C_F18_HAN_NOP_Q3) {
        this.C_F18_HAN_NOP_Q3 = C_F18_HAN_NOP_Q3;
    }

    public String getC_F18_KY_HACH_TOAN_Q3() {
        return C_F18_KY_HACH_TOAN_Q3;
    }

    public void setC_F18_KY_HACH_TOAN_Q3(String C_F18_KY_HACH_TOAN_Q3) {
        this.C_F18_KY_HACH_TOAN_Q3 = C_F18_KY_HACH_TOAN_Q3;
    }

    public String getC_F18_KY_TINH_THUE_Q3() {
        return C_F18_KY_TINH_THUE_Q3;
    }

    public void setC_F18_KY_TINH_THUE_Q3(String C_F18_KY_TINH_THUE_Q3) {
        this.C_F18_KY_TINH_THUE_Q3 = C_F18_KY_TINH_THUE_Q3;
    }

    public String getC_F18_THUE_PN_Q3() {
        return C_F18_THUE_PN_Q3;
    }

    public void setC_F18_THUE_PN_Q3(String C_F18_THUE_PN_Q3) {
        this.C_F18_THUE_PN_Q3 = C_F18_THUE_PN_Q3;
    }

    public String getC_F19_HAN_NOP_Q4() {
        return C_F19_HAN_NOP_Q4;
    }

    public void setC_F19_HAN_NOP_Q4(String C_F19_HAN_NOP_Q4) {
        this.C_F19_HAN_NOP_Q4 = C_F19_HAN_NOP_Q4;
    }

    public String getC_F19_KY_HACH_TOAN_Q4() {
        return C_F19_KY_HACH_TOAN_Q4;
    }

    public void setC_F19_KY_HACH_TOAN_Q4(String C_F19_KY_HACH_TOAN_Q4) {
        this.C_F19_KY_HACH_TOAN_Q4 = C_F19_KY_HACH_TOAN_Q4;
    }

    public String getC_F19_KY_TINH_THUE_Q4() {
        return C_F19_KY_TINH_THUE_Q4;
    }

    public void setC_F19_KY_TINH_THUE_Q4(String C_F19_KY_TINH_THUE_Q4) {
        this.C_F19_KY_TINH_THUE_Q4 = C_F19_KY_TINH_THUE_Q4;
    }

    public String getC_F19_THUE_PN_Q4() {
        return C_F19_THUE_PN_Q4;
    }

    public void setC_F19_THUE_PN_Q4(String C_F19_THUE_PN_Q4) {
        this.C_F19_THUE_PN_Q4 = C_F19_THUE_PN_Q4;
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

    public String getROW_NUM() {
        return ROW_NUM;
    }

    public void setROW_NUM(String ROW_NUM) {
        this.ROW_NUM = ROW_NUM;
    }

    public String getSTART_PERIOD() {
        return START_PERIOD;
    }

    public void setSTART_PERIOD(String START_PERIOD) {
        this.START_PERIOD = START_PERIOD;
    }

    public String getTAXPAYER_ID() {
        return TAXPAYER_ID;
    }

    public void setTAXPAYER_ID(String TAXPAYER_ID) {
        this.TAXPAYER_ID = TAXPAYER_ID;
    }

    public String getTAX_OFFICE_CODE() {
        return TAX_OFFICE_CODE;
    }

    public void setTAX_OFFICE_CODE(String TAX_OFFICE_CODE) {
        this.TAX_OFFICE_CODE = TAX_OFFICE_CODE;
    }

    public String getF13_MST_DLT() {
        return F13_MST_DLT;
    }

    public void setF13_MST_DLT(String F13_MST_DLT) {
        this.F13_MST_DLT = F13_MST_DLT;
    }

    public String getF20_HOP_DONG_DLT_SO() {
        return F20_HOP_DONG_DLT_SO;
    }

    public void setF20_HOP_DONG_DLT_SO(String F20_HOP_DONG_DLT_SO) {
        this.F20_HOP_DONG_DLT_SO = F20_HOP_DONG_DLT_SO;
    }

    public String getF_HOP_DONG_DLT_NGAY() {
        return F_HOP_DONG_DLT_NGAY;
    }

    public void setF_HOP_DONG_DLT_NGAY(String F_HOP_DONG_DLT_NGAY) {
        this.F_HOP_DONG_DLT_NGAY = F_HOP_DONG_DLT_NGAY;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getRV_SO_TIEN() {
        return RV_SO_TIEN;
    }

    public void setRV_SO_TIEN(String RV_SO_TIEN) {
        this.RV_SO_TIEN = RV_SO_TIEN;
    }

    public String getRID() {
        return RID;
    }

    public void setRID(String RID) {
        this.RID = RID;
    }  
        
}
