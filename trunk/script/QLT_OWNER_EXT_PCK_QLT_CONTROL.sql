-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CONTROL
-- Generated 01/11/2013 7:24:56 AM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE ext_pck_qlt_control IS

                            PROCEDURE Prc_Qlt_Thop_No(p_chot DATE);
                            PROCEDURE Prc_Qlt_Thop_PS(p_ky_ps_tu DATE, p_ky_ps_den DATE);
                            PROCEDURE Prc_Qlt_Thop_Ckt(p_chot DATE);

                            PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE);
                            PROCEDURE Prc_Job_Qlt_Thop_PS(p_ky_ps_tu DATE, p_ky_ps_den DATE);
                            PROCEDURE Prc_Job_Qlt_Thop_Ckt(p_chot DATE);

                            PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                            PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);

                            PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                            PROCEDURE Prc_Del_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
                        END;


-- End of DDL Script for Package QLT_OWNER.EXT_PCK_QLT_CONTROL


