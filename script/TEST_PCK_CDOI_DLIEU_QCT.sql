CREATE OR REPLACE 
PACKAGE pck_cdoi_dlieu_qct
IS
    PROCEDURE Prc_Thop(p_short_name varchar2);
    PROCEDURE Prc_Job_Qct_Thop_No(p_short_name VARCHAR2);

    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2);

    PROCEDURE Prc_Qct_Get_No(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Dchinh_No_Qct(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Qct_Thop_Dkntk(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_DKNTK(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Qct_Thop_TKTMB(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_TKTMB(p_short_name VARCHAR2);

    PROCEDURE Prc_Job_Qct_Thop_CCTT_GTGT(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_CCTT_GTGT(p_short_name VARCHAR2);

END;
/


