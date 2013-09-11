CREATE OR REPLACE 
PACKAGE pck_moi_truong
IS
    PROCEDURE Prc_Cre_DBlink(p_short_name VARCHAR2);
    PROCEDURE prc_cre_dblink_pnn (p_short_name VARCHAR2);
    PROCEDURE Prc_Close_DBlink(p_link VARCHAR2);
    PROCEDURE Prc_Drop_DBlink(p_link VARCHAR2);
    PROCEDURE Prc_Remote_Sql(p_sql IN VARCHAR2);

    PROCEDURE Prc_Ktao_Seq;
    PROCEDURE Prc_DDep_Seq;

    --remote sql, create, drop sequence PNN-APP
    PROCEDURE prc_remote_sql_pnn (p_sql IN VARCHAR2);
    PROCEDURE prc_ktao_seq_pnn;
    PROCEDURE prc_ddep_seq_pnn;
    PROCEDURE prc_ktao_table_pnn (tax_model VARCHAR2);

    PROCEDURE prc_ktao_pnn (p_short_name VARCHAR2);
    PROCEDURE prc_ddep_pnn (p_short_name VARCHAR2);

    PROCEDURE Prc_Ktao_tb_ext_qlt_ps;
    PROCEDURE Prc_Ddep_tb_ext_qlt_ps;

    --Khoi tao table tren qlt-app
    PROCEDURE Prc_Ktao_Table(tax_model varchar2);

    PROCEDURE prc_ktao_tb_ext_dm_gdich_qlt;
    PROCEDURE Prc_Ddep_tb_ext_dm_gdich_qlt;

    PROCEDURE prc_ktao_tb_ext_dm_gdich_qct;
    PROCEDURE Prc_Ddep_tb_ext_dm_gdich_qct;

    PROCEDURE Prc_Ktao_tb_ext_qlt_no;
    PROCEDURE Prc_Ddep_tb_ext_qlt_no;

    PROCEDURE Prc_Ktao_tb_ext_qlt_dmtk_ps;
    PROCEDURE Prc_Ddep_tb_ext_qlt_dmtk_ps;

    PROCEDURE Prc_Ktao_tb_ext_qlt_con_kt;
    PROCEDURE Prc_Ddep_tb_ext_qlt_con_kt;

    PROCEDURE prc_ktao_tb_ext_qct_no;
    PROCEDURE prc_ddep_tb_ext_qct_no;

    PROCEDURE Prc_Ktao_pck_qlt;
    PROCEDURE Prc_Ktao_Pck_Qlt_Du;
    PROCEDURE Prc_Ktao_Pck_Qlt_XL_NO;
    PROCEDURE Prc_Ktao_Pck_Qct_XL_NO;
    PROCEDURE prc_ktao_pck_qct_du;

    PROCEDURE Prc_Ktao_tb_ext_errors;
    PROCEDURE Prc_Ddep_tb_ext_errors;

    PROCEDURE Prc_Ktao_Qlt(p_short_name varchar2);
    PROCEDURE Prc_Ddep_Qlt(p_short_name varchar2);

    PROCEDURE Prc_Ktao(p_short_name VARCHAR2);
    PROCEDURE Prc_Ddep(p_short_name VARCHAR2);

    PROCEDURE Prc_Set_glView(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Errors(p_short_name VARCHAR2);
    PROCEDURE Prc_Chot_Dlieu(p_short_name varchar2);

    --Khoi tao va Don dep QCT-APP
    PROCEDURE Prc_Ktao_Qct(p_short_name VARCHAR2);
    PROCEDURE Prc_Ddep_Qct(p_short_name VARCHAR2);

    PROCEDURE Prc_GetData_DMuc_TKhai(v_tax_model varchar2);
    --TAX_MODEL
    c_qlt_tax_model Constant varchar2(7) := 'QLT-APP';
    c_qct_tax_model Constant varchar2(7) := 'QCT-APP';
    c_pnn_tax_model Constant varchar2(7) := 'PNN-APP';
    c_vat_tax_model Constant varchar2(7) := 'VAT-APP';



END;
/


