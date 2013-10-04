-- Start of DDL Script for Package QLT_OWNER.EXT_PCK_QCT_CHK_STN
-- Generated 04/10/2013 2:29:18 PM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE ext_pck_qct_chk_stn
    /**
     * Thuc hien kiem tra sai lech tren so thu nop
     *@author Administrator
     */
              IS

                PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);

                PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);
                PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
                PROCEDURE Prc_Del_Log(p_pck VARCHAR2);

                PROCEDURE Prc_Job_Qct_Slech_No;
                PROCEDURE Prc_Qct_Slech_No;
                v_gl_cqt VARCHAR2(5);

END;