-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CHK_STN
-- Generated 04/10/2013 2:29:00 PM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE BODY ext_pck_qlt_chk_stn
IS
    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Finnal
    ***************************************************************************/
    PROCEDURE prc_finnal (p_fnc_name VARCHAR2)
    IS
    BEGIN
        prc_remove_job (p_fnc_name);
        prc_ins_log (p_fnc_name);
    END;

    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE prc_create_job (p_name_exe VARCHAR2)
    IS
        jobno   user_jobs.job%TYPE;
    BEGIN
        DBMS_JOB.submit (jobno,
                         p_name_exe,
                         SYSDATE + 10 / 86400,
                         'SYSDATE + 365');
        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            prc_ins_log ('Create_Job_' || p_name_exe);
    END;

    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE prc_del_log (p_pck VARCHAR2)
    IS
        v_status   VARCHAR2 (1);
        v_ltd      NUMBER (4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT   NVL (MAX (ltd), 0) + 1
          INTO   v_ltd
          FROM   ext_errors
         WHERE   pck = p_pck;

        UPDATE   ext_errors
           SET   ltd = v_ltd
         WHERE   ltd = 0 AND pck = p_pck;
    END;

    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE prc_remove_job (p_pro_name VARCHAR2)
    IS
        CURSOR c
        IS
            SELECT   job
              FROM   user_jobs
             WHERE   INSTR (UPPER (what), UPPER (p_pro_name)) > 0;
    BEGIN
        FOR v IN c
        LOOP
            IF (v.job IS NOT NULL)
            THEN
                DBMS_JOB.remove (v.job);
            END IF;
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            prc_ins_log ('Remove_Job_' || p_pro_name);
    END;

    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE prc_ins_log (p_pck VARCHAR2)
    IS
        v_status   VARCHAR2 (1);
        v_ltd      NUMBER (4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT   NVL (MAX (ltd), 0) + 1
          INTO   v_ltd
          FROM   ext_errors
         WHERE   pck = p_pck;

        UPDATE   ext_errors
           SET   ltd = v_ltd
         WHERE   ltd = 0 AND pck = p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.format_error_stack IS NULL
        THEN
            v_status := 'Y';
        ELSE
            v_status := 'N';
        END IF;

        -- Insert log
        INSERT INTO ext_errors (seq_number,
                                error_stack,
                                call_stack,
                                timestamp,
                                pck,
                                status)
          VALUES   (ext_seq.NEXTVAL,
                    DBMS_UTILITY.format_error_stack,
                    DBMS_UTILITY.format_call_stack,
                    SYSDATE,
                    p_pck,
                    v_status);

        COMMIT;
    END;

    /***************************************************************************
    ext_pck_qlt_chk_stn.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE prc_update_pbcb (p_table_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE '
        UPDATE '
                 || p_table_name || ' a
           SET (ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT b.ma_canbo,
                       (SELECT d.ten FROM qlt_canbo d
                            WHERE d.ngay_hl_den IS NULL
                              AND b.ma_canbo=d.ma_canbo AND rownum=1) ten_canbo,
                       b.ma_phong,
                       (SELECT c.ten FROM qlt_phongban c
                            WHERE c.hluc_den_ngay IS NULL
                              AND b.ma_phong=c.ma_phong AND rownum=1) ten_phong
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin and rownum=1)'
;
    END;

    /**
     * Job kiem tra sai lech so no, so thu nop
     *@author Administrator
     *@date   22/04/2013
     *@see ext_pck_qlt_chk_stn.Prc_Job_Qlt_Slech_No
     */
    PROCEDURE Prc_Job_Qlt_Slech_No IS
    BEGIN
        Prc_Del_Log('PRC_QLT_SLECH_NO');
        COMMIT;
        Prc_Create_Job('BEGIN ext_pck_qlt_chk_stn.Prc_Qlt_Slech_No; END;');
    END;

    /**
     * Kiem tra sai lech so no, so thu nop
     *@author Administrator
     *@date   22/04/2013
     *@see ext_pck_qlt_chk_stn.Prc_Job_Qlt_Slech_No
     */
    PROCEDURE Prc_Qlt_Slech_No IS
        c_pro_name CONSTANT VARCHAR2(30) := 'PRC_QLT_SLECH_NO';
        v_max_upd NUMBER(3);
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        SELECT NVL(max(update_no),0) INTO v_max_upd FROM ext_slech_no;
        SELECT gia_tri INTO v_gl_cqt FROM qlt_tham_so WHERE ten='MA_CQT';
        UPDATE ext_slech_no SET update_no = v_max_upd+1
         WHERE loai='QLT' AND update_no=0;

        INSERT INTO ext_slech_no (loai, ky_thue, tin,
                                  ten_dtnt, tai_khoan, muc, tieumuc, mathue,
                                  sothue_no_cky, sono_no_cky, clech_no_cky,
                                  update_no, ma_slech, ma_gdich, ten_gdich, ma_cqt)
        SELECT 'QLT' loai,
               par.kylb_tu_ngay ky_thue,
               par.tin,
               nnt.TEN_DTNT,
               'TK_TAM_GIU' tai_khoan,
               par.tmt_ma_muc,
               par.tmt_ma_tmuc,
               par.tmt_ma_thue,
               par.no_cky SOTHUE_NO_CKY,
               to_number(NULL) SONO_NO_CKY,
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 5 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt
          FROM qlt_so_tdtn_tkhoan_tgiu par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin(+)
           AND par.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc <> '1000' or par.tmt_ma_tmuc <> '4268')
           AND par.no_cky<>0
        UNION ALL
        SELECT 'QLT' loai,
               par.kylb_tu_ngay ky_thue,
               par.tin,
               nnt.TEN_DTNT,
               par.tkhoan tai_khoan,
               par.tmt_ma_muc,
               par.tmt_ma_tmuc,
               par.tmt_ma_thue,
               to_number(NULL) SOTHUE_NO_CKY,
               par.no_cuoi_ky SONO_NO_CKY,
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 2 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)
           AND par.tkhoan='TK_TAM_GIU'
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc <> '1000' or par.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT 'QLT' loai,
               par.kylb_tu_ngay ky_thue,
               par.tin,
               nnt.TEN_DTNT,
               par.tkhoan tai_khoan,
               par.tmt_ma_muc,
               par.tmt_ma_tmuc,
               par.tmt_ma_thue,
               to_number(NULL) SOTHUE_NO_CKY,
               par.no_cuoi_ky SONO_NO_CKY,
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 3 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)
           AND par.han_nop IS NULL
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc <> '1000' or par.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT 'QLT' loai,
               par.ky_thue,
               par.tin,
               max(nnt.TEN_DTNT) TEN_DTNT,
               par.tai_khoan,
               par.tmt_ma_muc,
               par.tmt_ma_tmuc,
               par.tmt_ma_thue MATHUE,
               ROUND(sum(par.ST_NO_CKY),0) SOTHUE_NO_CKY,
               sum(par.SN_NO_CKY) SONO_NO_CKY,
               (ROUND(sum (par.ST_NO_CKY),0)-sum(par.SN_NO_CKY)) CLECH_NO_CKY,
               0 update_no, 1 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt
        FROM
        (
        SELECT 'TK_NGAN_SACH' AS tai_khoan,
               t.tin,
               t.tmt_ma_muc,
               t.tmt_ma_tmuc,
               t.tmt_ma_thue,
               t.kylb_tu_ngay AS ky_thue,
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_thue t
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc <> '1000' or t.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT 'TK_TAM_GIU' AS tai_khoan,
               t.tin,
               t.tmt_ma_muc,
               t.tmt_ma_tmuc,
               t.tmt_ma_thue,
               t.kylb_tu_ngay AS ky_thue,
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tgiu t
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc <> '1000' or t.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT 'TK_TH_HOAN' AS tai_khoan,
               t.tin,
               t.tmt_ma_muc,
               t.tmt_ma_tmuc,
               t.tmt_ma_thue,
               t.kylb_tu_ngay AS ky_thue,
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_thhoan t
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc <> '1000' or t.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT 'TK_TAM_THU' AS tai_khoan,
               t.tin,
               t.tmt_ma_muc,
               t.tmt_ma_tmuc,
               t.tmt_ma_thue,
               t.kylb_tu_ngay AS ky_thue,
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tthu t
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc <> '1000' or t.tmt_ma_tmuc <> '4268')
        UNION ALL
        SELECT tkhoan,
               tin,
               tmt_ma_muc,
               tmt_ma_tmuc,
               tmt_ma_thue,
               kyno_tu_ngay AS kythue,
               0 AS ST_no_cky,
               no_cky AS SN_no_cky
          FROM (SELECT a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc,
                       a.tmt_ma_thue, kyno_tu_ngay, SUM (no_cuoi_ky) AS no_cky
                  FROM qlt_so_no a
                 WHERE kyno_tu_ngay =(SELECT max(kyno_tu_ngay) FROM  qlt_so_no)
                   AND (a.tmt_ma_muc <> '1000' or a.tmt_ma_tmuc <> '4268')
                 GROUP BY a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc,
                          a.tmt_ma_thue, a.kyno_tu_ngay)
        ) par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin
         GROUP BY par.tai_khoan, par.tin, par.tmt_ma_muc, par.tmt_ma_tmuc,
                  par.tmt_ma_thue, par.ky_thue
        HAVING ROUND(sum(par.ST_NO_CKY),0) <> sum(par.SN_NO_CKY);

        Prc_Update_Pbcb('ext_slech_no');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        Prc_Finnal(c_pro_name);
        EXCEPTION
            WHEN others
                THEN Prc_Finnal(c_pro_name);
    END;

END;