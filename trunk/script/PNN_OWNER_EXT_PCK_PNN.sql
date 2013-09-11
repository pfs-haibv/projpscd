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

        --Chuyen doi chi tiet to khai 01/TK-SDDPNN
        PROCEDURE prc_job_pnn_thop_01_tk_sddpnn (p_chot DATE);
        PROCEDURE prc_pnn_thop_01_tk_sddpnn (p_chot DATE);

        --Chuyen doi chi tiet to khai 02/TK-SDDPNN
        PROCEDURE prc_job_pnn_thop_02_tk_sddpnn (p_chot DATE);
        PROCEDURE prc_pnn_thop_02_tk_sddpnn (p_chot DATE);

END; -- Package spec
/


