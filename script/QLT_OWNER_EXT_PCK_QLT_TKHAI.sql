-- Start of DDL Script for Package QLT_OWNER.EXT_PCK_QLT_TKHAI
-- Generated 04/10/2013 2:33:56 PM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE ext_pck_qlt_tkhai
              IS

                PROCEDURE Prc_Finnal( p_fnc_name VARCHAR2);
                PROCEDURE Prc_Update_Pbcb( p_table_name VARCHAR2);

                PROCEDURE Prc_Qlt_Thop_Dkntk( p_chot DATE);
                PROCEDURE Prc_Job_Qlt_Thop_Dkntk( p_chot DATE);

                PROCEDURE Prc_Create_Job( p_name_exe VARCHAR2);
                PROCEDURE Prc_Remove_Job( p_pro_name VARCHAR2);
                PROCEDURE Prc_Ins_Log( p_pck VARCHAR2);

                PROCEDURE Prc_Qlt_Thop_Monbai( p_chot DATE);
                PROCEDURE Prc_Job_Qlt_Thop_Monbai( p_chot DATE);

                PROCEDURE Prc_Del_Log( p_pck VARCHAR2);

                FUNCTION Fnc_GetKyTK ( ma_tk varchar2)
                return varchar2 ;
                FUNCTION fnc_get_tkhai_tms (ma_tk VARCHAR2, loai_kkhai varchar2)
                RETURN VARCHAR2;
                --TAX_MODEL QLT-APP
                c_qlt_tax_model Constant varchar2 (7 ) := 'QLT-APP';
            END;

