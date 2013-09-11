CREATE OR REPLACE 
PACKAGE pck_check_data_tms
  IS
    --Insert data error
    PROCEDURE prc_insert_data (sqltext varchar2);

    --Check table TB_NO
    PROCEDURE prc_check_tb_no ( p_short_name     VARCHAR2);

    --Check table TB_DKNTK
    PROCEDURE prc_check_tb_dkntk ( p_short_name     VARCHAR2);

    --Check table TB_01_TKMB_....
    PROCEDURE prc_check_tb_tkmb ( p_short_name     VARCHAR2);

    --Check table TB_PS phat sinh phuc vu quyet toan
    PROCEDURE prc_check_tb_ps ( p_short_name     VARCHAR2);

    --Check table tb_con_kt so con khau tru
    PROCEDURE prc_check_tb_con_kt ( p_short_name     VARCHAR2);

    --Check table TB_01_THKH_HDR, TB_O1_THKH
    PROCEDURE prc_check_01_tb_thkh ( p_short_name     VARCHAR2);

    --Check table 01/TK-SDDPNN, 02/TK-SDDPNN
    PROCEDURE prc_check_tk_sddpnn ( p_short_name     VARCHAR2);

    --Check table tb_tinh_phat
    PROCEDURE prc_check_tb_tinh_phat ( p_short_name     VARCHAR2);

END;
/


