-- Start of DDL Script for Package PNN_OWNER.EXT_PCK_PNN
-- Generated 30-Oct-2013 15:08:16 from PNN_OWNER@PNN_BRV_VTA

CREATE OR REPLACE 
PACKAGE ext_pck_pnn
  IS
        PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);

        PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);
        PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);

        PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
        PROCEDURE Prc_Del_Log(p_pck VARCHAR2);

        --Chuyen doi so con phai nop, nop thua
        PROCEDURE prc_job_pnn_thop_no (p_chot DATE, tax_code varchar2);
        PROCEDURE prc_pnn_thop_no (p_chot DATE, tax_code varchar2);
       
        FUNCTION Fnc_encode_unicode(P_instring VARCHAR2)
            RETURN VARCHAR2;

END; -- Package spec



-- End of DDL Script for Package PNN_OWNER.EXT_PCK_PNN

