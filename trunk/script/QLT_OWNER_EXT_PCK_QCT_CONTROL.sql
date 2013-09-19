-- Start of DDL Script for Package QLT_OWNER.EXT_PCK_QCT_CONTROL
-- Generated 19/09/2013 10:05:20 AM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE ext_pck_qct_control IS

                            PROCEDURE Prc_Qct_Thop_No(p_chot DATE);

                            PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE);

                            PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                            PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);

                            PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                            PROCEDURE Prc_Del_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
                        END;



-- End of DDL Script for Package QLT_OWNER.EXT_PCK_QCT_CONTROL

