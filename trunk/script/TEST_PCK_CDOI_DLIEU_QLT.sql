CREATE OR REPLACE 
PACKAGE pck_cdoi_dlieu_qlt
IS
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_short_name varchar2);
    PROCEDURE Prc_Job_Qlt_Thop_No(p_short_name varchar2);
    PROCEDURE Prc_Job_Qlt_Thop_Ckt(p_short_name varchar2);
    PROCEDURE Prc_Qlt_Get_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Qlt_Get_Ckt(p_short_name VARCHAR2);

    PROCEDURE Prc_Thop(p_short_name varchar2);

    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Dchinh_No_Qlt(p_short_name VARCHAR2);
    PROCEDURE Prc_Dchinh_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_MST(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Qlt_Thop_DKNTK_QT(p_short_name varchar2);
    PROCEDURE Prc_Qlt_Get_DKNTK_QT(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Qlt_Thop_TKTMB(p_short_name VARCHAR2);
    PROCEDURE Prc_Qlt_Get_TKTMB(p_short_name VARCHAR2);


END;
/


