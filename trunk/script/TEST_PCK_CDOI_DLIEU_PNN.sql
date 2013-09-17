-- Start of DDL Script for Package TEST.PCK_CDOI_DLIEU_PNN
-- Generated 16/09/2013 11:30:14 AM from TEST@DCNC

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

    --Get ma loai dat TMS, ma loai duong TMS tu danh muc dung chung
    FUNCTION fnc_pnn_get_data_tms (p_ma varchar2, p_tbl_map varchar2, p_ma_tinh varchar2)
    RETURN VARCHAR2;

    --dong bo ma loai dat, loai duong tu danh muc dung chung tren he thong TMS
    PROCEDURE prc_pnn_sync_dmuc_tms (p_ma_tinh VARCHAR2, p_taxo VARCHAR2);

END; -- Package spec



-- End of DDL Script for Package TEST.PCK_CDOI_DLIEU_PNN

