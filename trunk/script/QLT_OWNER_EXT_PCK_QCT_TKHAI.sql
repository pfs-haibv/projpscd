CREATE OR REPLACE 
PACKAGE ext_pck_qct_tkhai
              IS

                PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);

                PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);
                PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);

                PROCEDURE Prc_Qct_Thop_Dkntk(p_chot DATE);
                PROCEDURE Prc_Job_Qct_Thop_Dkntk(p_chot DATE);

                PROCEDURE Prc_Qct_Thop_Monbai(p_chot DATE);
                PROCEDURE Prc_Job_Qct_Thop_Monbai(p_chot DATE);

                PROCEDURE prc_job_qct_thop_cctt_gtgt (p_chot DATE);
                PROCEDURE prc_qct_thop_cctt_gtgt (p_chot DATE);


                PROCEDURE Prc_Del_Log(p_pck VARCHAR2);

                FUNCTION Fnc_GetKyTK (ma_tk varchar2)
                return varchar2;

                FUNCTION fnc_get_tkhai_tms (ma_tk VARCHAR2)
                RETURN VARCHAR2;
                --TAX_MODEL QCT-APP
                c_qct_tax_model Constant varchar2(7) := 'QCT-APP';

				END;


