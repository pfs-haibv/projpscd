-- Start of DDL Script for Package Body TEST.PCK_CHECK_DATA_TMS
-- Generated 03/10/2013 2:27:39 PM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_check_data_tms
/**
 * Thuc hien kiem tra du lieu tren DBTMS
 * <p> Kiem tra cac dau du lieu:
 * <ul>
 *      <li>du lieu NO </li>
 *      <li>du lieu dang ky nop to khai </li>
 *      <li>du lieu to khai thue mon bai </li>
 *      <li>du lieu Phat sinh </li>
 *      <li>du lieu to khai khoan 01-THKH </li>
 *      <li>du lieu con khau tru </li>
 *      <li>du lieu tinh phat  </li>
 *      <li>du lieu 01,02TK-SDDPNN</li>
 * </ul>
 *@author Administrator
 *@date 19/06/2013
 */
IS
    /**
     * Thuc hien insert du lieu vao table loi (tb_data_error)
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_insert_data
     */
    PROCEDURE prc_insert_data (sqltext VARCHAR2)
    IS
    BEGIN
        -- sql insert data error
        EXECUTE IMMEDIATE 'INSERT INTO tb_data_error (short_name,
                                   rid,
                                   table_name,
                                   err_id,
                                   field_name,
                                   update_no,
                                   ma_cqt,
                                   check_app) '
                         || sqltext;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_insert_data');

    END;

    /**
     * Thuc hien kiem tra du lieu table tb_no
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_no
     */
    PROCEDURE prc_check_tb_no (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_NO' AND check_app = 'ORA';

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
        pck_glb_variables.set_short_name (p_short_name);
        pck_glb_variables.set_ky_chot (p_ky_chot);

        sqltext := 'select * from vw_check_tb_no';

        --Thuc hien ghi loi
        prc_insert_data (sqltext);

    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_ult.prc_finnal ('pck_check_data_tms.prc_check_tb_no');

    END;

    /**
     * Thuc hien kiem tra du lieu table tb_dkntk
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_dkntk
     */
    PROCEDURE prc_check_tb_dkntk (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_DKNTK' AND check_app = 'ORA';

       --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table tb_tkmb_hdr, tb_tkmb_dtl
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_tkmb(p_short_name)
     */

    PROCEDURE prc_check_tb_tkmb (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_TKMB_HDR', 'TB_TKMB_DTL') AND check_app = 'ORA';

        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table tb_ps
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_ps(p_short_name)
     */
    PROCEDURE prc_check_tb_ps (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
         p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_PS' AND check_app = 'ORA';

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table tb_con_kt
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_con_kt(p_short_name)
     */
    PROCEDURE prc_check_tb_con_kt (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_CON_KT' AND check_app = 'ORA';

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table tb_01_tkkh_hdr, tb_01_tkkh_dtl
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_01_tb_tkkh(p_short_name)
     */
    PROCEDURE prc_check_01_tb_thkh (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_01_THKH_HDR', 'TB_01_THKH_DTL') AND check_app = 'ORA';

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table TB_TK_SDDPNN, TB_TK_SDDPNN_01_NNT
     *<p> - Doi voi to 01/TK-SDDPNN kiem tra tren 2 table
     *<ul>
     *            <li> TB_TK_SDDPNN (Thong tin xac dinh cua co quan chuc nang), voi ma_loai_tk = 01 </li>
     *            <li> TB_TK_SDDPNN_01_NNT (Thong tin NNT Ke Khai) </li>
     *</ul>
     *<p> - Doi voi to 02/TK-SDDPNN Kiem tra tren 1 table
     *<ul>
     *            <li> TB_TK_SDDPNN voi ma_loai_tk = 02 </li>
     *            <li>o do se kiem tra chung ca 2 to 01/TK-SDDPNN vs 02/TK-SDDPNN </li>
     *</ul>
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tk_sddpnn(p_short_name)
     */
    PROCEDURE prc_check_tk_sddpnn (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name
                 AND table_name IN ('TB_TK_SDDPNN', 'TB_TK_SDDPNN_01_NNT') AND check_app = 'ORA';

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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

    /**
     * Thuc hien kiem tra du lieu table tb_tinh_phat
     *@author Administrator
     *@date 19/06/2013
     *@see pck_check_data_tms.prc_check_tb_tinh_phat(p_short_name)
     */
    PROCEDURE prc_check_tb_tinh_phat (p_short_name VARCHAR2)
    IS
        sqltext     VARCHAR2 (32767);
        p_ky_chot   DATE;
        p_ma_cqt    VARCHAR2(5);
    BEGIN
        --Clear data
        DELETE   tb_data_error
         WHERE   short_name = p_short_name AND table_name = 'TB_TINH_PHAT' AND check_app = 'ORA';

        --get ky_chot
        SELECT   ky_chot, tax_code
          INTO   p_ky_chot, p_ma_cqt
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        --SET MA_CQT, SHORT_NAME, KY_CHOT
        pck_glb_variables.set_ma_cqt (p_ma_cqt);
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


-- End of DDL Script for Package Body TEST.PCK_CHECK_DATA_TMS

