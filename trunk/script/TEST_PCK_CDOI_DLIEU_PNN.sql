CREATE OR REPLACE 
PACKAGE pck_cdoi_dlieu_pnn
  IS
    --Tong hop no
    PROCEDURE prc_job_pnn_thop_no (p_short_name VARCHAR2);

    --Lay du lieu no ve trung gian
    PROCEDURE prc_pnn_get_no (p_short_name VARCHAR2);

    --Lay du lieu 01/TK-SDDPNN
    PROCEDURE prc_pnn_get_01tk_sddpnn (p_short_name VARCHAR2);

    --Lay du lieu 02/TK-SDDPNN
    PROCEDURE prc_pnn_get_02tk_sddpnn (p_short_name VARCHAR2);

    --Lay du lieu cac loai danh muc
    PROCEDURE prc_pnn_get_dmuc_pnn (p_short_name VARCHAR2);

END; -- Package spec



