CREATE OR REPLACE 
PACKAGE pck_ult
  IS
    PROCEDURE prc_cre_dblink (p_short_name VARCHAR2, p_name VARCHAR2,p_user VARCHAR2
                              ,p_pass VARCHAR2,p_connect VARCHAR2);
    PROCEDURE Prc_Close_DBlink(p_short_name VARCHAR2, p_link VARCHAR2);
    PROCEDURE Prc_Drop_DBlink(p_short_name VARCHAR2, p_link VARCHAR2);

    FUNCTION Fnc_Check_Digit(v_tin IN VARCHAR2) RETURN VARCHAR2;

    FUNCTION Fnc_Check_Tin(P_TIN Varchar2) RETURN NUMBER;

    PROCEDURE Prc_Read_File(p_fname Varchar2, p_id_hdr number);

    FUNCTION Fnc_Excel_Tag_Cell(p_style VARCHAR2,
                               p_type VARCHAR2,
                               p_data VARCHAR2) RETURN VARCHAR2;

    PROCEDURE Prc_Write_File(p_sql varchar2,
                             p_dir varchar2,
                             p_fname varchar2,
                             p_separator varchar2 DEFAULT ',');

    FUNCTION Fnc_Find_strInFile(p_dir Varchar2, p_fname Varchar2, p_str Varchar2) RETURN boolean;

    FUNCTION Fnc_Split_strFile(p_str Varchar2) RETURN varchar2;

    FUNCTION Fnc_Split_strFolder(p_str Varchar2) RETURN varchar2;

    /* Create Drop table QLT-APP */
    procedure Prc_Drop_Tbl_Qlt(tbl_user_objects varchar2, v_tax_model varchar2);
    PROCEDURE Prc_Create_Tbl_Qlt (v_tax_model varchar2);
    PROCEDURE Prc_Ddep_Pck_Qlt (tbl_user_objects varchar2, v_tax_model varchar2);

    /* Create Drop table, package PNN-APP */
    PROCEDURE Prc_Drop_Tbl_pnn (tbl_user_objects varchar2, v_tax_model varchar2);
    PROCEDURE Prc_Create_Tbl_Pnn(v_tax_model varchar2);


    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
    PROCEDURE Prc_Remove_Job (p_pro_name VARCHAR2 );
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);

    PROCEDURE Prc_Crt_Pck_File (v_tax_model varchar2 );

    PROCEDURE Prc_Update_bac_mbai;

    --CONSTANT
    c_object_type_table Constant varchar2(5) := 'TABLE';
    c_object_type_package Constant varchar2(7) := 'PACKAGE';

END;
/


