-- Start of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_QCT
-- Generated 27/08/2013 2:39:48 PM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_cdoi_dlieu_qct
IS
    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_No(p_short_name)
    Noi dung:
    ***************************************************************************/
    PROCEDURE prc_job_qct_thop_no (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   tax_model = 'QCT' AND short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                                EXT_PCK_QCT_CONTROL.Prc_Job_Qct_Thop_No@QLT_'|| p_short_name|| '('''|| p_chot|| ''');
                           END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_QCT_GET_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_Dkntk(p_short_name)
    Noi dung:
    ***************************************************************************/
    PROCEDURE prc_job_qct_thop_dkntk (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                                ext_pck_qct_tkhai.Prc_Job_Qct_Thop_Dkntk@QLT_'|| p_short_name|| '('''|| p_chot || ''');
                           END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_qct_get_dkntk');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_TK');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /*************************************************************************** PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_DKNTK(p_short_name)
     Nguoi thuc hien: Administrator
     Ngay thuc hien: 15/04/2013
     Noi dung: lay thong tin dang ky nop to khai, quyet toan tu CQT
     ***************************************************************************/
    PROCEDURE prc_qct_get_dkntk (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data
        DELETE FROM   tb_dkntk
              WHERE   short_name = p_short_name AND tax_model = 'QCT-APP';

        --Insert tms_dkntk_qt
        EXECUTE IMMEDIATE '
            INSERT INTO tb_dkntk (
                                    id,
                                    tkh_id,
                                    ma_cqt,
                                    tin,
                                    ten_nnt,
                                    ma_cbo,
                                    ten_cbo,
                                    ma_pban,
                                    ten_pban,
                                    ky_bat_dau,
                                    ky_ket_thuc,
                                    ma_tkhai,
                                    short_name,
                                    tax_model,
                                    ky_bd_hthong_cu,
                                    ky_kt_hthong_cu,
                                    mau_tkhai_tms
                                    )
            SELECT   seq_data_cdoi.NEXTVAL id,
                     id tkh_id,
                    (SELECT   tax_code FROM tb_lst_taxo WHERE short_name = ''' || p_short_name || ''')
                     ma_cqt,
                     tin,
                     ten_nnt,
                     ma_cbo,
                     ten_cbo,
                     ma_pban,
                     ten_pban,
                     ky_bd,
                     ky_kt,
                     mau_tk,
                     ''' || p_short_name || ''' short_name,
                     ''QCT-APP'' tax_model,
                     ky_bd_qlt,
                     ky_kt_qlt,
                     mau_tk_tms
            FROM   ext_dkntk_qt@qlt_' || p_short_name || '
            where tax_model = ''QCT-APP'' '
                           ;
        COMMIT;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'Prc_Qlt_Get_DKNTK_QT');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Thop(p_short_name)
    Noi dung: Tong hop du lieu
    ***************************************************************************/
    PROCEDURE prc_thop (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set REMOTE_DEPENDENCIES_MODE=SIGNATURE';
    END;
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin no tu CQT
    ***************************************************************************/
    PROCEDURE prc_qlt_get_no (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_no
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        EXECUTE IMMEDIATE '
                            INSERT INTO tb_no(stt,
                            loai,
                            ma_cqt,
                            tin,
                            ma_chuong,
                            ma_khoan,
                            tmt_ma_tmuc,
                            tkhoan,
                            ngay_hach_toan,
                            kykk_tu_ngay,
                            kykk_den_ngay,
                            han_nop,
                            so_tien,
                            nguon_goc,
                            tinh_chat_no,
                            so_qd,
                            ngay_qd,
                            no_nte,
                            don_vi_tien,
                            short_name,
                            tax_model,
                            ma_cbo,
                            ten_cbo,
                            ma_pban,
                            ten_pban)
        SELECT ROWNUM STT,
               ''CD'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''|| p_short_name|| ''') MA_CQT,
               tin,
               ma_chuong,
               ma_khoan,
               tmt_ma_tmuc,
               tkhoan tkhoan,
               to_char(ngay_hach_toan,''dd/mm/rrrr'') ngay_hach_toan,
               to_char(kykk_tu_ngay,''dd/mm/rrrr'') kykk_tu_ngay,
               to_char(kykk_den_ngay,''dd/mm/rrrr'') kykk_den_ngay,
               to_char(han_nop,''dd/mm/rrrr'') han_nop,
               so_tien,
               nguon_goc,
               tinh_chat,
               so_qd,
               to_char(ngay_qd,''dd/mm/rrrr'') ngay_qd,
               no_nte,
               don_vi_tien,
               '''|| p_short_name || ''' short_name,
               ''QLT-APP'' tax_model,
               ma_cbo,
               ten_cbo,
               ma_pban,
               ten_pban
        FROM ext_qlt_no@qlt_'|| p_short_name|| ' a
        WHERE so_tien<>0 '
                          ;

        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Qct_Get_No(p_short_name)
    Nguoi thuc hien: DuBV
    Ngay thuc hien: 06/05/2013
    Noi dung: lay thong tin no tu CQT
    ***************************************************************************/
    PROCEDURE prc_qct_get_no (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QCT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_no
              WHERE   short_name = p_short_name AND tax_model = 'QCT-APP';

        EXECUTE IMMEDIATE '
        INSERT INTO tb_no(
                            stt,
                            loai,
                            ma_cqt,
                            tin,
                            ma_chuong,
                            ma_khoan,
                            tmt_ma_tmuc,
                            tkhoan,
                            NGAY_HTOAN,
                            kykk_tu_ngay,
                            kykk_den_ngay,
                            han_nop,
                            so_tien,
                            nguon_goc,
                            tinh_chat,
                            so_qd,
                            ngay_qd,
                            no_nte,
                            don_vi_tien,
                            short_name,
                            tax_model,
                            ma_cbo,
                            ten_cbo,
                            ma_pban,
                            ten_pban)
        SELECT ROWNUM STT,
               ''CD'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''|| p_short_name|| ''') MA_CQT,
               tin,
               ma_chuong,
               ma_khoan,
               tmt_ma_tmuc,
               tkhoan tkhoan,
               to_char(ngay_hach_toan,''dd/mm/rrrr'') ngay_hach_toan,
               to_char(kykk_tu_ngay,''dd/mm/rrrr'') kykk_tu_ngay,
               to_char(kykk_den_ngay,''dd/mm/rrrr'') kykk_den_ngay,
               to_char(han_nop,''dd/mm/rrrr'') han_nop,
               so_tien,
               nguon_goc,
               tinh_chat,
               so_qd,
               to_char(ngay_qd,''dd/mm/rrrr'') ngay_qd,
               null no_nte, null don_vi_tien,
               '''|| p_short_name|| ''' short_name,
               ''QCT-APP'' tax_model,
               ma_cbo,
               ten_cbo,
               ma_pban,
               ten_pban
        FROM ext_qct_no@qlt_'|| p_short_name|| ' a
        WHERE so_tien<>0 '
                          ;

        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            ROLLBACK;
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_job_slech_no (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        EXECUTE IMMEDIATE 'BEGIN
                                EXT_PCK_CONTROL.Prc_Job_Qlt_Slech_No@QLT_'|| p_short_name|| ';
                           END;';

        EXECUTE IMMEDIATE 'BEGIN
                                EXT_PCK_CONTROL.Prc_Job_Qct_Slech_No@QLT_'|| p_short_name|| ';
                            END;';

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_GET_SLECH_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_get_slech_no (p_short_name VARCHAR2)
    IS
    BEGIN
        pck_cdoi_dlieu_qlt.prc_get_slech_no (p_short_name);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Dchinh_No_Qct(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_dchinh_no_qct (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        EXECUTE IMMEDIATE 'BEGIN
                                EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qlt@QLT_'||p_short_name|| ';
                           END;';

        EXECUTE IMMEDIATE 'BEGIN
                                EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qct@QLT_'|| p_short_name|| ';
                           END;';

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_TKTMB(p_short_name)
    Noi dung: Tong hop du lieu to khai thue mon bai
    ***************************************************************************/
    PROCEDURE prc_job_qct_thop_tktmb (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   tax_model = 'QCT' AND short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                                ext_pck_qct_tkhai.Prc_Job_Qct_Thop_Monbai@QLT_'|| p_short_name|| '('''|| p_chot|| ''');
                           END;'

                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'Prc_Job_Qct_Thop_Monbai');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Qct_Get_TKTMB(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 07/05/2013
    Noi dung: lay thong tin tai khai thue mon bai
    ***************************************************************************/
    PROCEDURE prc_qct_get_tktmb (p_short_name VARCHAR2)
    IS
        CURSOR c_update_hdr_id
        IS
            SELECT   id, tkh_id
              FROM   tb_tkmb_hdr b
             WHERE   b.short_name = '' || p_short_name || ''
                     AND b.tax_model = 'QCT-APP';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data

        DELETE FROM   tb_tkmb_dtl
              WHERE   hdr_id IN
                              (SELECT   id
                                 FROM   tb_tkmb_hdr
                                WHERE   short_name = p_short_name
                                        AND tax_model = 'QCT-APP');

        DELETE FROM   tb_tkmb_hdr
              WHERE   short_name = p_short_name AND tax_model = 'QCT-APP';

        --Insert tms_tktmb_hdr
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_tkmb_hdr(
                                                id,
                                                tkh_id,
                                                ma_cqt,
                                                tin,
                                                ten_nnt,
                                                kytt_tu_ngay,
                                                kytt_den_ngay,
                                                ngay_htoan,
                                                ngay_nop_tk,
                                                han_nop,
                                                ma_cbo,
                                                ten_cbo,
                                                ma_pban,
                                                ten_pban,
                                                short_name,
                                                tax_model,
                                                THUE_PN_NNT,
                                                THUE_PN_CQT,
                                                VON_DKY_NNT,
                                                VON_DKY_CQT,
                                                BMB_NNT,
                                                BMB_CQT,
                                                TONG_THUE_PN_NNT,
                                                TONG_THUE_PN_CQT,
                                                TM_1801,
                                                TM_1802,
                                                TM_1803,
                                                TM_1804,
                                                TM_1805,
                                                TM_1806

                                                )
                    SELECT seq_data_cdoi.NEXTVAL id,
                            tkh_id,
                            (SELECT   tax_code FROM tb_lst_taxo WHERE short_name = ''' || p_short_name || ''')ma_cqt,
                            tin,
                            ten_nnt,
                            kytt_tu_ngay,
                            kytt_den_ngay,
                            ngay_htoan,
                            ngay_nop_tk,
                            han_nop,
                            ma_cbo,
                            ten_cbo,
                            ma_pban,
                            ten_pban,
                            ''' || p_short_name || ''' short_name,
                            ''QCT-APP'' tax_model,
                            THUE_PN_NNT,
                            THUE_PN_CQT,
                            VON_DKY_NNT,
                            VON_DKY_CQT,
                            BMB_NNT,
                            BMB_CQT,
                            TONG_THUE_PN_NNT,
                            TONG_THUE_PN_CQT,
                            TM_1801,
                            TM_1802,
                            TM_1803,
                            TM_1804,
                            TM_1805,
                            TM_1806
                    FROM   ext_tktmb_hdr@qlt_' || p_short_name || '
                    where tax_model = ''QCT-APP'''
                            ;

        --Insert tms_tktmb_dtl
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_tkmb_dtl(id,
                                            tkh_id,
                                            chi_tieu,
                                            bmb_nnt,
                                            bmb_cqt,
                                            THUE_PN_NNT,
                                            THUE_PN_CQT,
                                            von_dky_nnt,
                                            von_dky_cqt)
                                            SELECT seq_data_cdoi.NEXTVAL id,
                                            tkh_id,
                                            chi_tieu,
                                            bmb_nnt,
                                            bmb_cqt,
                                            so_nnt,
                                            so_cqt,
                                            von_dky_nnt,
                                            von_dky_cqt
                    FROM ext_tktmb_dtl@qlt_'|| p_short_name || '
                    where tax_model = ''QCT-APP'''
                         ;

        --Update hdr_id cho detail(tb_tkmb_dtl)
        FOR v IN c_update_hdr_id
        LOOP
            UPDATE   tb_tkmb_dtl a
               SET   a.hdr_id = (v.id)
             WHERE   a.tkh_id = v.tkh_id AND a.hdr_id IS NULL;
        END LOOP;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'Prc_Qct_Get_TKTMB');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_CCTT_GTGT(p_short_name)
    Noi dung: Tong hop du lieu can cu tinh thue GTGT
    ***************************************************************************/
    PROCEDURE prc_job_qct_thop_cctt_gtgt (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   tax_model = 'QCT' AND short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                                ext_pck_qct_tkhai.prc_job_qct_thop_cctt_gtgt@QLT_'|| p_short_name|| '('''|| p_chot|| ''');
                           END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_job_qct_thop_cctt_gtgt');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Qct_Get_CCTT_GTGT(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 07/05/2013
    Noi dung: lay thong tin can cu tinh thue GTGT
    ***************************************************************************/
    PROCEDURE prc_qct_get_cctt_gtgt (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data
        DELETE FROM   tb_cctt
              WHERE   short_name = p_short_name AND tax_model = 'QCT-APP';

        --Insert tb_cctt
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_01_thkh_hdr(id,
                                            tkh_id,
                                            ma_cqt,
                                            tin,
                                            ten_nnt,
                                            kytt_tu_ngay,
                                            kytt_den_ngay,
                                            ngay_htoan,
                                            ngay_nop_tk,
                                            han_nop,
                                            ma_cbo,
                                            ten_cbo,
                                            ma_pban,
                                            ten_pban,
                                            short_name,
                                            tax_model,
                                            tm_1701,
                                            doanh_thu_ts_5,
                                            gtgt_chiu_thue_ts_5,
                                            thue_gtgt_ts_5,
                                            doanh_thu_ts_10,
                                            gtgt_chiu_thue_ts_10,
                                            thue_gtgt_ts_10
                                            )
                    SELECT seq_data_cdoi.NEXTVAL id,
                                                id tkh_id,
                                                (SELECT   tax_code FROM tb_lst_taxo WHERE short_name = '''|| p_short_name || ''')ma_cqt,
                                                tin,
                                                ten_nnt,
                                                kytt_tu_ngay,
                                                kytt_den_ngay,
                                                ngay_htoan,
                                                ngay_nop_tk,
                                                han_nop,
                                                ma_cbo,
                                                ten_cbo,
                                                ma_pban,
                                                ten_pban,
                                                ''' || p_short_name || ''' short_name,
                                                ''QCT-APP'' tax_model,
                                                tm_1701,
                                                doanh_thu_ts_5,
                                                gtgt_chiu_thue_ts_5,
                                                thue_gtgt_ts_5,
                                                doanh_thu_ts_10,
                                                gtgt_chiu_thue_ts_10,
                                                thue_gtgt_ts_10
                    FROM   ext_cctt_hdr@qlt_' || p_short_name || ''
                            ;
        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_qct_get_cctt_gtgt');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
        --Sync 01/THKH
        pck_ult.Prc_sync_01_thkh(p_short_name);
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

    END;

END;
/


-- End of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_QCT

