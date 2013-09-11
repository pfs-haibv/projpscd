CREATE OR REPLACE 
PACKAGE BODY pck_check_data_tms
IS
    /***************************************************************************
     pck_check_data_tms.prc_insert_data(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_no
     ***************************************************************************/
    PROCEDURE prc_insert_data (sqltext VARCHAR2)
    IS
    BEGIN
        -- sql insert
        EXECUTE IMMEDIATE 'INSERT INTO tb_data_error (short_name,
                                   rid,
                                   table_name,
                                   err_id,
                                   field_name,
                                   update_no) '
                         || sqltext;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_insert_data');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_no(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_no
     ***************************************************************************/
    PROCEDURE prc_check_tb_no (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_NO';

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_chect_tb_no';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_no');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_dkntk(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_dkntk
     ***************************************************************************/
    PROCEDURE prc_check_tb_dkntk (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_DKNTK';

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from VW_CHECK_TB_DKNTK';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_dkntk');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_tkmb(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_tkmb_hdr, tb_tkmb_dtl
     ***************************************************************************/
    PROCEDURE prc_check_tb_tkmb (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_TKMB_HDR', 'TB_TKMB_DTL');

        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_check_tb_tkmb';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_tkmb');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_ps(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_ps
     ***************************************************************************/
    PROCEDURE prc_check_tb_ps (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_PS';

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_check_tb_ps';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_ps');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_con_kt(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_ps
     ***************************************************************************/
    PROCEDURE prc_check_tb_con_kt (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_CON_KT';

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_chect_tb_con_kt';
        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_con_kt');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_01_tb_tkkh(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_01_tkkh_hdr, tb_01_tkkh_dtl
     ***************************************************************************/
    PROCEDURE prc_check_01_tb_thkh (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_01_THKH_HDR', 'TB_01_THKH_DTL');

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_check_tb_01_thkh';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_01_tb_thkh');
    END;
    /***************************************************************************
     pck_check_data_tms.prc_check_tk_sddpnn(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table TB_TK_SDDPNN, TB_TK_SDDPNN_01_NNT
               - Doi voi to 01/TK-SDDPNN kiem tra tren 2 table
                 TB_TK_SDDPNN (Thong tin xac dinh cua co quan chuc nang), voi ma_loai_tk = 01
                 TB_TK_SDDPNN_01_NNT (Thong tin NNT Ke Khai)
               - Doi voi to 02/TK-SDDPNN Kiem tra tren 1 table
                 TB_TK_SDDPNN voi ma_loai_tk = 02
               Do do se kiem tra chung ca 2 to 01/TK-SDDPNN vs 02/TK-SDDPNN
     ***************************************************************************/
    PROCEDURE prc_check_tk_sddpnn (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_TK_SDDPNN', 'TB_TK_SDDPNN_01_NNT');

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        --01. Kiem tra thong tin xac dinh cua co quan chuc nang
        sqltext := 'select * from vw_check_tb_sddpnn';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);


        --02. Kiem tra thong tin NNT tu ke khai
        sqltext := 'select * from vw_check_tb_sddpnn_01_nnt';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tk_sddpnn');
    END;

    /***************************************************************************
     pck_check_data_tms.prc_check_tb_tinh_phat(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 19/06/2013
     Noi dung: kiem tra du lieu table tb_tinh_phat
     ***************************************************************************/
    PROCEDURE prc_check_tb_tinh_phat (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
    BEGIN
        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_TINH_PHAT';

        --Get ky_chot
        SELECT   ky_chot
          INTO   p_ky_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --SET CQT, KY_CHOT
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_check_tb_tinh_phat';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_tinh_phat');
    END;
END;
/


