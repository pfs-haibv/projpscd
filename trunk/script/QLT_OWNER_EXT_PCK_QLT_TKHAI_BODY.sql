-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_TKHAI
-- Generated 27/08/2013 9:25:08 AM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE BODY ext_pck_qlt_tkhai
IS
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Finnal
    ***************************************************************************/
    PROCEDURE prc_finnal (p_fnc_name VARCHAR2)
    IS
    BEGIN
        prc_remove_job (p_fnc_name);
        prc_ins_log (p_fnc_name);
    END;

    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Create_Job
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
    TMS_QLT_CDOI_TK.Prc_Del_Log
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
    TMS_QLT_CDOI_TK.Prc_Remove_Job
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
    TMS_QLT_CDOI_TK.Prc_Ins_Log
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
    TMS_QLT_CDOI_TK.Prc_Update_Pbcb
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

    /***************************************************************************
      TMS_QLT_CDOI_TK.Prc_Job_Qlt_Thop_Dkntk(p_chot)
      ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_dkntk (p_chot DATE)
    IS
    BEGIN
        prc_del_log ('Prc_Qlt_Thop_Dkntk');
        COMMIT;
        prc_create_job('BEGIN EXT_PCK_QLT_TKHAI.Prc_Qlt_Thop_Dkntk('''|| p_chot|| ''');
                        END;');
    END;

    /**
     * @package: TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Dkntk
     * @desc:    Lay danh sach
     * @author:  Administrator
     * @date:    11/04/2013
     * @param:   p_chot
     */
    PROCEDURE prc_qlt_thop_dkntk (p_chot DATE)
    IS
        c_pro_name            CONSTANT VARCHAR2 (30) := 'PRC_QLT_THOP_DKNTK';
        v_last_ky_dkntk DATE
                := LAST_DAY (ADD_MONTHS (TRUNC (p_chot, 'YEAR'), 11));
        v_firt_ky_dkntk       DATE := LAST_DAY (SYSDATE) + 1;
        v_ky_bat_dau          VARCHAR2 (15);
        v_ky_ket_thuc         VARCHAR2 (15);
        v_ma_tk               VARCHAR2 (1);
        v_last_current_year   DATE;
        v_ma_loai_tms         VARCHAR2(20);
        v_quarter             NUMBER (1);
        v_year                VARCHAR2 (2);

        CURSOR cloop
        IS
            SELECT   dk_hdr.tin tin,
                     dk_hdr.ten_dtnt,
                     dk_dtl.ma_loai ma_loai,
                     dk_dtl.loai_kkhai,
                     dk_dtl.ngay_bat_dau ky_bat_dau,
                     dk_dtl.ngay_ket_thuc ky_ket_thuc
              FROM   qlt_dknop_tkhai_hdr dk_hdr,
                     qlt_dknop_tkhai_dtl dk_dtl,
                     qlt_nsd_dtnt nnt
             WHERE   dk_hdr.id = dk_dtl.dknh_id
                     AND nnt.tin = dk_hdr.tin
                     AND nnt.trang_thai NOT IN ('01', '02', '03')
                     AND dk_dtl.ma_loai IN
                                (SELECT   ma
                                   FROM   ext_dmuc_tkhai
                                  WHERE   tax_model = c_qlt_tax_model  and flg_dkntk is not null)
                     AND dk_dtl.dky_nop = 'Y'
                     AND (dk_dtl.ngay_ket_thuc > LAST_DAY (p_chot)
                          OR dk_dtl.ngay_ket_thuc IS NULL);
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        --Clear data ext_dkntk_qt
        DBMS_UTILITY.exec_ddl_statement ('truncate table ext_dkntk_qt');

        -- Lay ngay cuoi cung cua thang chua ky chot du lieu
        SELECT   LAST_DAY(ADD_MONTHS (
                              TRUNC (TO_DATE (p_chot, 'DD/MM/RRRR'), 'Year'),
                              11))
          INTO   v_last_current_year
          FROM   DUAL;

        --Lay 2 so cua nam
        v_year := TO_CHAR (TRUNC (p_chot), 'YY');

        /* day du lieu dang ky nop to khai */
        FOR vloop IN cloop
        LOOP
            --loai tk
            v_ma_tk := fnc_getkytk (vloop.ma_loai);

            -- Xac dinh ky bat dau voi tung loai to khai
            IF v_ma_tk = 'M'
            THEN -- ky thang ky bat dau = ky dau tien cua nam chua ky chot du lieu
                v_ky_bat_dau := v_year || '01';
            ELSIF v_ma_tk = 'Q'
            THEN -- ky quy ky bat dau = quy dau tien cua nam chua ky chot du lieu
                v_ky_bat_dau := v_year || 'Q1';
            ELSIF v_ma_tk = 'Y'
            THEN    -- ky nam ky bat dau = nam chua ky chot du lieu chuyen doi
                v_ky_bat_dau := v_year || 'CN';
            END IF;

            -- Xac dinh ky ket thuc tuong ung voi tung mau to khai
            -- Neu ngay ket thuc trong hoac > ngay cuoi cung cua nam chua ky chot du lieu chuyen doi
            IF vloop.ky_ket_thuc IS NULL
               OR vloop.ky_ket_thuc > v_last_current_year
            THEN
                IF v_ma_tk = 'M'
                THEN
                    v_ky_ket_thuc := v_year || '12';
                ELSIF v_ma_tk = 'Q'
                THEN
                    v_ky_ket_thuc := v_year || 'Q4';
                ELSIF v_ma_tk = 'Y'
                THEN
                    v_ky_ket_thuc := v_year || 'CN';
                END IF;
            ELSE
                -- lay quarter theo ky_ket_thuc
                SELECT   TO_NUMBER(TO_CHAR (
                                       TO_DATE (vloop.ky_ket_thuc,
                                                'dd.mm.yyyy'),
                                       'Q'))
                             quarter
                  INTO   v_quarter
                  FROM   DUAL;

                IF v_ma_tk = 'M'
                THEN
                    v_ky_ket_thuc :=
                        v_year || TO_CHAR (TRUNC (vloop.ky_ket_thuc), 'MM');
                ELSIF v_ma_tk = 'Q'
                THEN
                    v_ky_ket_thuc := v_year || 'Q' || v_quarter;
                ELSIF v_ma_tk = 'Y'
                THEN
                    v_ky_ket_thuc := v_year || 'CN';
                END IF;
            END IF;
            -- Lay ma to khai TMS
            v_ma_loai_tms := fnc_get_tkhai_tms(vloop.ma_loai, vloop.loai_kkhai);

            INSERT INTO ext_dkntk_qt (id,
                                      tin,
                                      ten_nnt,
                                      mau_tk,
                                      ky_bd,
                                      ky_kt,
                                      ky_bd_qlt,
                                      ky_kt_qlt,
                                      tax_model,
                                      MAU_TK_TMS
                                      )
              VALUES   (ext_seq.NEXTVAL,
                        vloop.tin,
                        vloop.ten_dtnt,
                        vloop.ma_loai,
                        v_ky_bat_dau,
                        v_ky_ket_thuc,
                        to_char(vloop.ky_bat_dau,'DD/MM/YYYY'),
                        to_char(vloop.ky_ket_thuc,'DD/MM/YYYY'),
                        c_qlt_tax_model,
                        v_ma_loai_tms);

            --clear ma_tk
            v_ma_tk := NULL;
        END LOOP;

        /* cap nhat phong ban can bo */
        prc_update_pbcb ('ext_dkntk_qt');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        prc_finnal (c_pro_name);
    EXCEPTION
        WHEN OTHERS

        THEN
            prc_finnal (c_pro_name);
    END;

    /***************************************************************************
     TMS_QLT_CDOI_TK.Prc_Job_Qlt_Thop_Monbai(p_chot)
     ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_monbai (p_chot DATE)
    IS
    BEGIN
        prc_del_log ('Prc_Qlt_Thop_Monbai');
        COMMIT;
        prc_create_job('BEGIN
                            TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Monbai('''

                       || p_chot
                       || ''');
                        END;'

                             );
    END;

    /**
     * @package: TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Monbai
     * @desc:    Lay danh sach
     * @author:  Administrator
     * @date:    16/04/2013
     * @param:   p_chot
     */
    PROCEDURE prc_qlt_thop_monbai (p_chot DATE)
    IS
        c_pro_name   CONSTANT VARCHAR2 (30) := 'PRC_QLT_THOP_MONBAI';
        v_ky_den     DATE := LAST_DAY (p_chot);
        v_chi_tieu   NUMBER (1);

        -- List Hdr
        CURSOR cloop
        IS
            SELECT   tk_hdr.tin tin,
                     tk_hdr.ten_dtnt ten_nnt,
                     tk_hdr.id tkh_id,
                     tk_hdr.kykk_tu_ngay kykk_tu_ngay,
                     tk_hdr.kykk_den_ngay kykk_den_ngay,
                     tk_hdr.han_nop han_nop,
                     tk_hdr.ngay_nop ngay_nop
              FROM   qlt_tkhai_hdr tk_hdr, qlt_nsd_dtnt nnt
             WHERE   nnt.tin = tk_hdr.tin AND tk_hdr.tthai IN ('1', '3', '4')
                     AND TO_CHAR (TRUNC (tk_hdr.kykk_tu_ngay), 'YYYY') =
                            TO_CHAR (TRUNC (p_chot), 'YYYY')
                     AND tk_hdr.ltd = 0
                     AND tk_hdr.dtk_ma_loai_tkhai = '53'
                     AND tk_hdr.kylb_den_ngay <= v_ky_den
                     ;

        -- List Dtl
        CURSOR cdtl (v_tkh_id VARCHAR2)
        IS
              SELECT   *
                FROM   qlt_tkhai_mbai
               WHERE   tkh_id = v_tkh_id AND tkh_ltd = 0
            ORDER BY   id;
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        --Clear Data
        DBMS_UTILITY.exec_ddl_statement ('truncate table ext_tktmb_hdr');
        DBMS_UTILITY.exec_ddl_statement ('truncate table ext_tktmb_dtl');

        /* day du lieu bang master to khai mon bai */
        FOR vloop IN cloop
        LOOP
            --Insert table ext_tktmb_hdr
            INSERT INTO ext_tktmb_hdr (id,
                                       tkh_id,
                                       tin,
                                       ten_nnt,
                                       kytt_tu_ngay,
                                       kytt_den_ngay,
                                       ngay_htoan,
                                       ngay_nop_tk,
                                       han_nop)
              VALUES   (ext_seq.NEXTVAL,
                        vloop.tkh_id,
                        vloop.tin,
                        vloop.ten_nnt,
                        to_char(vloop.kykk_tu_ngay, 'DD/MM/YYYY'),
                        to_char(vloop.kykk_den_ngay,'DD/MM/YYYY'),
                        to_char(v_ky_den,'DD/MM/YYYY'),
                        to_char(vloop.ngay_nop,'DD/MM/YYYY'),
                        to_char(vloop.han_nop,'DD/MM/YYYY'));

            --default chi_tieu
            FOR v_dtl IN cdtl (vloop.tkh_id)
            LOOP
                IF v_dtl.ky_hieu = '[10]'
                THEN
                    v_chi_tieu := 1;                       --Nguoi nop thue
                ELSIF v_dtl.ky_hieu = '[11]'
                THEN
                    v_chi_tieu := 2;                       --Don vi truc thuoc
                ELSIF v_dtl.ky_hieu = '[12]'
                THEN
                    v_chi_tieu := 3;                       --Tong so
                END IF;

                IF v_dtl.ky_hieu IS NULL OR v_dtl.ky_hieu = '[12]'
                THEN
                    --Update tong so len header
                    if v_chi_tieu = 3 then
                        UPDATE ext_tktmb_hdr a set a.TONG_THUE_PN_NNT = v_dtl.so_nnt,
                                                   a.TONG_THUE_PN_CQT = v_dtl.so_cqt
                               where a.tkh_id = v_dtl.tkh_id;
                    elsif  v_chi_tieu = 1 then
                         UPDATE ext_tktmb_hdr a set
                                                    a.bmb_nnt = v_dtl.bmb_id_nnt,
                                                    a.bmb_cqt = v_dtl.bmb_id_cqt,
                                                    a.THUE_PN_NNT = v_dtl.so_nnt,
                                                    a.THUE_PN_CQT = v_dtl.so_cqt,
                                                    a.von_dky_nnt = v_dtl.von_dky_nnt,
                                                    a.von_dky_cqt = v_dtl.von_dky_cqt
                               where a.tkh_id = v_dtl.tkh_id;
                    else
                        --Insert table ext_tktmb_dtl
                        INSERT INTO ext_tktmb_dtl (id,
                                                   tkh_id,
                                                   chi_tieu,
                                                   bmb_id_nnt,
                                                   bmb_id_cqt,
                                                   so_nnt,
                                                   so_cqt,
                                                   von_dky_nnt,
                                                   von_dky_cqt,
                                                   mst_dvtt)
                          VALUES   (ext_seq.NEXTVAL,
                                    v_dtl.tkh_id,
                                    v_chi_tieu,
                                    v_dtl.bmb_id_nnt,
                                    v_dtl.bmb_id_cqt,
                                    v_dtl.so_nnt,
                                    v_dtl.so_cqt,
                                    v_dtl.von_dky_nnt,
                                    v_dtl.von_dky_cqt,
                                    v_dtl.chi_tieu);
                      end if;
                END IF;
            END LOOP;

             --update thue phat sinh theo tieu muc

                        update ext_tktmb_hdr a set TM_1801 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

                        update ext_tktmb_hdr a set TM_1802 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

                        update ext_tktmb_hdr a set TM_1803 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

                        update ext_tktmb_hdr a set TM_1804 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

                        update ext_tktmb_hdr a set TM_1805 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

                        update ext_tktmb_hdr a set TM_1806 = ( select sum(thue_psinh)
                                                                       FROM   qlt_psinh_tkhai
                                                               WHERE   tkh_id = vloop.tkh_id
                                                                       and tmt_ma_tmuc = '1802' group by tmt_ma_tmuc)
                               where a.tkh_id = vloop.tkh_id;

        END LOOP;

        /* cap nhat phong ban can bo */
        prc_update_pbcb ('ext_tktmb_hdr');

        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        prc_finnal (c_pro_name);
    EXCEPTION
        WHEN OTHERS
        THEN
            prc_finnal (c_pro_name);
    END;

    /**
     * @package: TMS_QLT_CDOI_TK.Fnc_GetKyTK
     * @desc:    lay loai tk (thang, quy, nam)
     * @author:  Administrator
     * @date:    22/04/2013
     * @param:   ma_tk
     */
    FUNCTION fnc_getkytk (ma_tk VARCHAR2)
        RETURN VARCHAR2
    IS
        rt_loaitk   VARCHAR2 (1);
    BEGIN
        SELECT   kieu_ky into  rt_loaitk
          FROM   (SELECT   a.kieu_ky
                    FROM   qlt_dm_tkhai_hluc a
                   WHERE   a.hluc_den_ngay IS NULL AND dtk_ma = ma_tk
                  UNION
                  SELECT   'Y' kieu_ky
                    FROM   qlt_dm_qtoan_hluc a
                   WHERE   a.hluc_den_ngay IS NULL AND dqt_ma = ma_tk)
         WHERE   ROWNUM = 1;

        RETURN rt_loaitk;

    END;

    /**
     * @package: TMS_QLT_CDOI_TK.fnc_get_tkhai_tms
     * @desc:    Lay ma to khai TMS
     * @author:  Administrator
     * @date:    22/04/2013
     * @param:   ma_tms
     */
    FUNCTION fnc_get_tkhai_tms (ma_tk VARCHAR2, loai_kkhai varchar2)
        RETURN VARCHAR2
    IS
        tk_tms   VARCHAR2 (20);
    BEGIN
        SELECT   a.ma_tms
          INTO   tk_tms
          FROM   ext_dmuc_tkhai a
         WHERE   a.ma =  ma_tk
            and a.loai_kkhai = loai_kkhai and rownum = 1;

        RETURN tk_tms;

    END;


END;


