-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QCT_TKHAI
-- Generated 06/11/2013 3:32:07 PM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE BODY ext_pck_qct_tkhai
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
ext_pck_qct_tkhai.Prc_Create_Job
***************************************************************************/
   PROCEDURE prc_create_job (p_name_exe VARCHAR2)
   IS
      jobno   user_jobs.job%TYPE;
   BEGIN
      DBMS_JOB.submit (jobno,
                       p_name_exe,
                       SYSDATE + 10 / 86400,
                       'SYSDATE + 365'
                      );
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         prc_ins_log ('Create_Job_' || p_name_exe);
   END;

/***************************************************************************
ext_pck_qct_tkhai.Prc_Del_Log
***************************************************************************/
   PROCEDURE prc_del_log (p_pck VARCHAR2)
   IS
      v_status   VARCHAR2 (1);
      v_ltd      NUMBER (4);
   BEGIN
      -- Cap nhat lan thay doi LTD
      SELECT NVL (MAX (ltd), 0) + 1
        INTO v_ltd
        FROM ext_errors
       WHERE pck = p_pck;

      UPDATE ext_errors
         SET ltd = v_ltd
       WHERE ltd = 0 AND pck = p_pck;
   END;

/***************************************************************************
ext_pck_qct_tkhai.Prc_Remove_Job
***************************************************************************/
   PROCEDURE prc_remove_job (p_pro_name VARCHAR2)
   IS
      CURSOR c
      IS
         SELECT job
           FROM user_jobs
          WHERE INSTR (UPPER (what), UPPER (p_pro_name)) > 0;
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
ext_pck_qct_tkhai.Prc_Ins_Log
***************************************************************************/
   PROCEDURE prc_ins_log (p_pck VARCHAR2)
   IS
      v_status   VARCHAR2 (1);
      v_ltd      NUMBER (4);
   BEGIN
      -- Cap nhat lan thay doi LTD
      SELECT NVL (MAX (ltd), 0) + 1
        INTO v_ltd
        FROM ext_errors
       WHERE pck = p_pck;

      UPDATE ext_errors
         SET ltd = v_ltd
       WHERE ltd = 0 AND pck = p_pck;

      -- Cap nhat trang thai cua thu tuc
      IF DBMS_UTILITY.format_error_stack IS NULL
      THEN
         v_status := 'Y';
      ELSE
         v_status := 'N';
      END IF;

      -- Insert log
      INSERT INTO ext_errors
                  (seq_number, error_stack,
                   call_stack, TIMESTAMP, pck, status
                  )
           VALUES (ext_seq.NEXTVAL, DBMS_UTILITY.format_error_stack,
                   DBMS_UTILITY.format_call_stack, SYSDATE, p_pck, v_status
                  );

      COMMIT;
   END;

/***************************************************************************
ext_pck_qct_tkhai.Prc_Update_Pbcb
***************************************************************************/
   PROCEDURE prc_update_pbcb (p_table_name VARCHAR2)
   IS
   BEGIN
      EXECUTE IMMEDIATE    '
        UPDATE '
                        || p_table_name
                        || ' a
           SET (ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT b.ma_canbo,
                       (SELECT d.ten FROM qlt_canbo d
                            WHERE d.ngay_hl_den IS NULL
                              AND b.ma_canbo=d.ma_canbo AND rownum=1) ten_canbo,
                       b.ma_phong,
                       (SELECT c.ten FROM qlt_phongban c
                            WHERE c.hluc_den_ngay IS NULL
                              AND b.ma_phong=c.ma_phong AND rownum=1) ten_phong
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin and rownum=1)';
   END;

   /***************************************************************************
     ext_pck_qct_tkhai.Prc_Job_Qct_Thop_Dkntk(p_chot)
     ***************************************************************************/
   PROCEDURE prc_job_qct_thop_dkntk (p_chot DATE)
   IS
   BEGIN
      prc_del_log ('Prc_Qct_Thop_Dkntk');
      COMMIT;
      prc_create_job
         (   'BEGIN
                           ext_pck_qct_tkhai.Prc_Qct_Thop_Dkntk('''
          || p_chot
          || ''');
                        END;'
         );
   END;

   /**
    * Thuc hien lay du lieu dang ky nop to khai tren QCT
    *@author Administrator
    *@date   02/05/2013
    *@param  p_chot
    *@see ext_pck_qct_tkhai.Prc_Qlt_Thop_Dkntk
    *
    *@Modified by  Administator
    *@Modified Date 23/09/2013
    * Thuc hien bo cac trang thai cua ma TIN
    */
   PROCEDURE prc_qct_thop_dkntk (p_chot DATE)
   IS
      c_pro_name   CONSTANT VARCHAR2 (30) := 'PRC_QCT_THOP_DKNTK';
      v_last_ky_dkntk       DATE
                        := LAST_DAY (ADD_MONTHS (TRUNC (p_chot, 'YEAR'), 11));
      v_firt_ky_dkntk       DATE          := LAST_DAY (SYSDATE) + 1;
      v_ky_bat_dau          VARCHAR2 (15);
      v_ky_ket_thuc         VARCHAR2 (15);
      v_ma_tk               VARCHAR2 (1);           --to khai thang, quy, nam
      v_ma_loai             VARCHAR2 (20);                  --ma loai to khai
      v_ma_loai_tms         VARCHAR2 (20);         --ma loai to khai tren tms
      v_last_current_year   DATE;
      v_quarter             NUMBER (1);
      v_year                VARCHAR2 (2);

      CURSOR cloop
      IS
         SELECT dk_hdr.tin tin, 
                dk_hdr.ten_dtnt, 
                dk_dtl.dcc_ma ma_loai,
                dk_dtl.ky_bdau ky_bat_dau, 
                dk_dtl.ky_kthuc ky_ket_thuc,
                dk_hdr.dpp_ma dpp_ma                  --phuong phap tinh thue
           FROM qct_dtnt dk_hdr, qct_dtnt_tkhai_pnop dk_dtl,
                qlt_nsd_dtnt nnt
          WHERE dk_hdr.ID = dk_dtl.hdr_id
            AND nnt.tin = dk_hdr.tin
            -- AND nnt.trang_thai NOT IN ('01', '02', '03')
            AND dk_dtl.dcc_ma IN (
                   SELECT ma
                     FROM ext_dmuc_tkhai
                    WHERE tax_model = c_qct_tax_model
                          AND flg_dkntk IS NOT NULL)
            AND (dk_dtl.ky_kthuc > LAST_DAY (p_chot)
                 OR dk_dtl.ky_kthuc IS NULL
                );
   BEGIN
      qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
      DBMS_UTILITY.exec_ddl_statement ('truncate table ext_qct_dkntk');

      -- Lay ngay cuoi cung cua thang chua ky chot du lieu
      SELECT LAST_DAY (ADD_MONTHS (TRUNC (p_chot, 'Year'), 11))
        INTO v_last_current_year
        FROM DUAL;

      --Lay 2 so cua nam
      v_year := TO_CHAR (p_chot, 'YY');

      /* day du lieu dang ky nop to khai */
      FOR vloop IN cloop
      LOOP
         --Lay loai to khai thang, quy, nam
         v_ma_tk := fnc_getkytk (vloop.ma_loai);

         -- Xac dinh ky bat dau voi tung loai to khai
         IF v_ma_tk = 'M'
         THEN
            -- ky thang ky bat dau = ky dau tien caa nam chua ky chot du lieu
            v_ky_bat_dau := v_year || '01';
         ELSIF v_ma_tk = 'Q'
         THEN -- ky quy ky bat dau = quy dau tien cua nam chua ky chot du lieu
            v_ky_bat_dau := v_year || 'Q1';
         ELSIF v_ma_tk = 'Y'
         THEN       -- ky nam ky bat dau = nam chua ky chot du lieu chuyen doi
            v_ky_bat_dau := v_year || 'CN';
         END IF;

         -- Xac dinh ky ket thuc tuong ung voi tung mau to khai
         -- Neu ngay ket thuc trong hoac > ngay cuoi cung cua nam chua ky chot du lieu chuyen doi
         IF    vloop.ky_ket_thuc IS NULL
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
            SELECT TO_NUMBER (TO_CHAR (vloop.ky_ket_thuc, 'Q')) quarter
              INTO v_quarter
              FROM DUAL;

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

         /**
          *  01/TT?B:
          *          01/TT?B n?u NNT l? h? k? khai
          *          01/THKH n?u NNT l? h? kho?n
          *  01/TAIN:
          *          01/TAIN n?u NNT l? h? k? khai
          *          01/THKH n?u NNT l? h? kho?n
          **/
         IF (vloop.ma_loai IN ('05', '06') AND vloop.dpp_ma LIKE '4%')
         THEN
            v_ma_loai := '01/THKH';
         ELSE
            v_ma_loai := vloop.ma_loai;
         END IF;

         --Lay ma to khai TMS
         v_ma_loai_tms := fnc_get_tkhai_tms (v_ma_loai);

         --Loai cac truong hop la to khai ho khoan (01/THKH)
         --Vi khong dang ky nop to khai
         IF v_ma_loai <> '01/THKH'
         THEN
            INSERT INTO ext_qct_dkntk
                        (ID, tin, ten_nnt,
                         mau_tk, ky_bd, ky_kt,
                         ky_bd_qlt,
                         ky_kt_qlt,
                         tax_model, mau_tk_tms
                        )
                 VALUES (ext_seq.NEXTVAL, vloop.tin, vloop.ten_dtnt,
                         v_ma_loai, v_ky_bat_dau, v_ky_ket_thuc,
                         TO_CHAR (vloop.ky_bat_dau, 'DD/MM/YYYY'),
                         TO_CHAR (vloop.ky_ket_thuc, 'DD/MM/YYYY'),
                         c_qct_tax_model, v_ma_loai_tms
                        );
         END IF;

         --clear ma_tk
         v_ma_tk := NULL;
      END LOOP;

      /* cap nhat phong ban can bo */
      prc_update_pbcb ('ext_qct_dkntk');
      COMMIT;
      qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
      prc_finnal (c_pro_name);
   EXCEPTION
      WHEN OTHERS
      THEN
         prc_finnal (c_pro_name);
   END;

   /***************************************************************************
   TMS_QCT_CDOI_TK.Prc_Job_Qct_Thop_Monbai(p_chot)
    ***************************************************************************/
   PROCEDURE prc_job_qct_thop_monbai (p_chot DATE)
   IS
   BEGIN
      prc_del_log ('Prc_Qct_Thop_Monbai');
      COMMIT;
      prc_create_job
         (   'BEGIN
                            ext_pck_qct_tkhai.Prc_Qct_Thop_Monbai('''
          || p_chot
          || ''');
                        END;'
         );
   END;

   /**
    * Thuc hien lay du lien to khai thue mon bai tren he thong QCT
    *@author Administrator
    *@date   16/04/2013
    *@param  p_chot
    *@see TMS_QCT_CDOI_TK.Prc_Qct_Thop_Monbai
    */
   PROCEDURE prc_qct_thop_monbai (p_chot DATE)
   IS
      c_pro_name        CONSTANT VARCHAR2 (30)  := 'PRC_QCT_THOP_MONBAI';
      v_ky_den                   DATE           := LAST_DAY (p_chot);
      v_chi_tieu                 NUMBER (1);
      v_so_thue_phai_nop         NUMBER (22, 0);
      v_total_so_thue_phai_nop   NUMBER (22, 0) := 0;
      v_fyear_ky_chot            DATE           := TRUNC (p_chot, 'year');

      -- List Hdr
      CURSOR cloop
      IS
         SELECT tk_hdr.tin tin, 
                tk_hdr.ten_dtnt ten_nnt, 
                tk_hdr.ID tkh_id,
                tk_hdr.kykk_tu_ngay kykk_tu_ngay,
                tk_hdr.kykk_den_ngay kykk_den_ngay, 
                tk_hdr.han_nop han_nop,
                tk_hdr.ngay_nhap ngay_nop
           FROM qct_mon_bai_hdr tk_hdr, qlt_nsd_dtnt nnt
          WHERE nnt.tin = tk_hdr.tin
            AND TRUNC (tk_hdr.kykk_tu_ngay, 'year') = v_fyear_ky_chot
            AND tk_hdr.kylb_den_ngay <= v_ky_den;

      -- List Dtl
      CURSOR cdtl (v_tkh_id NUMBER)
      IS
         SELECT   *
             FROM qct_mon_bai_dtl
            WHERE hdr_id = v_tkh_id
         ORDER BY btm_id;
   BEGIN
      qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
      --Clear data
      DBMS_UTILITY.exec_ddl_statement ('truncate table ext_qct_tktmb_hdr');
      DBMS_UTILITY.exec_ddl_statement ('truncate table ext_qct_tktmb_dtl');

      /* day du lieu bang master to khai mon bai */
      FOR vloop IN cloop
      LOOP
         --Insert table ext_qct_tktmb_hdr
         INSERT INTO ext_qct_tktmb_hdr
                     (ID, tkh_id, tin,
                      ten_nnt,
                      kytt_tu_ngay,
                      kytt_den_ngay,
                      ngay_htoan,
                      ngay_nop_tk,
                      han_nop, tax_model
                     )
              VALUES (ext_seq.NEXTVAL, vloop.tkh_id, vloop.tin,
                      vloop.ten_nnt,
                      TO_CHAR (vloop.kykk_tu_ngay, 'DD/MM/YYYY'),
                      TO_CHAR (vloop.kykk_den_ngay, 'DD/MM/YYYY'),
                      TO_CHAR (v_ky_den, 'DD/MM/YYYY'),
                      TO_CHAR (vloop.ngay_nop, 'DD/MM/YYYY'),
                      TO_CHAR (vloop.han_nop, 'DD/MM/YYYY'), c_qct_tax_model
                     );

         v_chi_tieu := 1;

         FOR v_dtl IN cdtl (vloop.tkh_id)
         LOOP
            v_total_so_thue_phai_nop :=
                               v_total_so_thue_phai_nop + v_dtl.thue_phai_nop;
            --Tach thanh cac dong chi tiet
            v_so_thue_phai_nop := v_dtl.thue_phai_nop / v_dtl.so_the;

            --Check so the #0 ...
            FOR i IN 1 .. v_dtl.so_the
            LOOP
               --Lay 1 dong du lieu nguoi nop thue dua len header
               --va chuyen chi tieu = 2
               IF v_chi_tieu = 1
               THEN
                  UPDATE ext_qct_tktmb_hdr a
                     SET a.bmb_nnt = v_dtl.btm_id,
                         a.bmb_cqt = v_dtl.btm_id,
                         a.thue_pn_nnt = v_so_thue_phai_nop,
                         a.thue_pn_cqt = v_so_thue_phai_nop,
                         a.von_dky_nnt = 0,
                         a.von_dky_cqt = 0
                   WHERE a.tkh_id = v_dtl.hdr_id;

                  v_chi_tieu := 2;
               ELSE
                  --Chi tiet co quan thue
                  INSERT INTO ext_qct_tktmb_dtl
                              (ID, tkh_id, bmb_id_cqt,
                               so_cqt, bmb_id_nnt,
                               so_nnt, von_dky_nnt, von_dky_cqt, tax_model
                              )
                       VALUES (ext_seq.NEXTVAL, v_dtl.hdr_id, v_dtl.btm_id,
                               v_so_thue_phai_nop, v_dtl.btm_id,
                               v_so_thue_phai_nop, 0, 0, c_qct_tax_model
                              );
               END IF;
            END LOOP;
         --set default chi_tieu = 0
         END LOOP;

         v_chi_tieu := 0;

         -- Update Tong so thue phai nop cua nnt vs cqt tu table detail -> table header
         UPDATE ext_qct_tktmb_hdr a
            SET tong_thue_pn_cqt = v_total_so_thue_phai_nop,
                tong_thue_pn_nnt = v_total_so_thue_phai_nop
          WHERE a.tkh_id = vloop.tkh_id;

         --update thue phat sinh theo tieu muc
         UPDATE ext_qct_tktmb_hdr a
            SET tm_1801 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1801'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         UPDATE ext_qct_tktmb_hdr a
            SET tm_1802 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1802'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         UPDATE ext_qct_tktmb_hdr a
            SET tm_1803 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1803'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         UPDATE ext_qct_tktmb_hdr a
            SET tm_1804 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1804'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         UPDATE ext_qct_tktmb_hdr a
            SET tm_1805 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1805'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         UPDATE ext_qct_tktmb_hdr a
            SET tm_1806 =
                       (SELECT   SUM (thue_phai_nop) thue_phai_nop
                            FROM qct_mon_bai_dtl
                           WHERE hdr_id = vloop.tkh_id
                                 AND tmt_ma_tmuc = '1806'
                        GROUP BY tmt_ma_tmuc)
          WHERE a.tkh_id = vloop.tkh_id;

         -- Clear tong so thue phai nop trong 1 ban ke
         v_total_so_thue_phai_nop := 0;
      END LOOP;

      /* cap nhat phong ban can bo */
      prc_update_pbcb ('ext_qct_tktmb_hdr');
      COMMIT;
      qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
      prc_finnal (c_pro_name);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         prc_finnal (c_pro_name);
   END;

   /*************************************************************************** EXT_PCK_QCT_TKHAI.prc_job_qct_thop_cctt_gtgt(p_chot)
    ***************************************************************************/
   PROCEDURE prc_job_qct_thop_cctt_gtgt (p_chot DATE)
   IS
   BEGIN
      prc_del_log ('prc_qct_thop_cctt_gtgt');
      COMMIT;
      prc_create_job
         (   'BEGIN
                            EXT_PCK_QCT_TKHAI.prc_qct_thop_cctt_gtgt('''
          || p_chot
          || ''');
                        END;'
         );
   END;

   /**
    * Thuc hien lay danh sach can cu tinh thue gia tri gia tang tren QCT
    *@author  Administrator
    *@date    06/05/2013
    *@param   p_chot
    *@see EXT_PCK_QCT_TKHAI.prc_qct_thop_cctt_gtgt
    *
    *@Modified by  Administator
    *@Modified Date 23/09/2013
    * Thuc hien bo cac trang thai cua ma TIN
    */
   PROCEDURE prc_qct_thop_cctt_gtgt (p_chot DATE)
   IS
      --ma loai CCTT GTGT
      c_dcc_ma     CONSTANT VARCHAR2 (2)  := '01';
      c_pro_name   CONSTANT VARCHAR2 (30) := 'prc_qct_thop_cctt_gtgt';
      v_ky_den              VARCHAR2 (10)
                                 := TO_CHAR (LAST_DAY (p_chot), 'DD/MM/YYYY');
      v_ky_tu               DATE          := TRUNC (p_chot, 'month');
   BEGIN
      qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
      --Clear data
      DBMS_UTILITY.exec_ddl_statement ('truncate table EXT_CCTT_HDR');

      --Cap nhat EXT_CCTT_HDR
      INSERT INTO ext_cctt_hdr
                  (tin, 
                   ten_nnt, 
                   ID, 
                   kytt_tu_ngay, 
                   kytt_den_ngay, 
                   han_nop,
                   ngay_nop_tk, 
                   ngay_htoan, 
                   doanh_thu_ts_5,
                   gtgt_chiu_thue_ts_5, 
                   thue_gtgt_ts_5, 
                   tm_1701, 
                   tsgtgt,
                   tlgtgt, 
                   ma, 
                   doanh_thu_quy_ts_5, 
                   gtgt_chiu_thue_quy_ts_5,
                   thue_gtgt_quy_ts_5)
         SELECT thop.tin, 
                thop.ten_nnt, 
                thop.ID, 
                thop.kytt_tu_ngay,
                thop.kytt_den_ngay, 
                thop.han_nop, 
                thop.ngay_nop_tk,
                thop.ngay_htoan, 
                thop.doanh_thu_ts_5,
                thop.gtgt_chiu_thue_ts_5, 
                thop.thue_gtgt_ts_5, 
                thop.tm_1701,
                thop.tsgtgt, 
                thop.tlgtgt, 
                thop.ma, 
                thop.doanh_thu_quy_ts_5,
                thop.gtgt_chiu_thue_quy_ts_5, 
                thop.thue_gtgt_quy_ts_5
           FROM (SELECT tk_hdr.tin tin, 
                        tk_hdr.ten_dtnt ten_nnt, 
                        tk_hdr.ID ID,
                        TO_CHAR (tk_hdr.kykk_tu_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_tu_ngay,
                        TO_CHAR (tk_hdr.kykk_den_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_den_ngay,
                        TO_CHAR (tk_hdr.han_nop, 'DD/MM/YYYY') han_nop,
                        TO_CHAR (tk_hdr.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                        v_ky_den ngay_htoan, 
                        tk_dtl.doanh_thu doanh_thu_ts_5,
                        tk_dtl.gtgt_chiu_thue gtgt_chiu_thue_ts_5,
                        tk_dtl.thue_gtgt thue_gtgt_ts_5,
                        psinh.thue_psinh tm_1701, 
                        5 tsgtgt, 
                        tk_dtl.tlgtgt,
                        tk_hdr.dcc_ma ma, 
                        0 doanh_thu_quy_ts_5,
                        0 gtgt_chiu_thue_quy_ts_5, 
                        0 thue_gtgt_quy_ts_5
                   FROM qct_cctt_hdr tk_hdr,
                        qct_cctt_dtl tk_dtl,
                        qct_cctt_psinh psinh
                  WHERE tk_hdr.ID = tk_dtl.hdr_id
                    AND tk_hdr.ID = psinh.hdr_id
                    AND tk_hdr.dcc_ma = c_dcc_ma
                    AND tk_dtl.tsgtgt = 5                      -- thue suat 5%
                    --AND nnt.trang_thai NOT IN ('01', '03')
                    AND tk_hdr.kykk_tu_ngay = tk_hdr.kylb_tu_ngay
                    AND tk_hdr.kylb_tu_ngay = v_ky_tu
                    AND psinh.tmt_ma_tmuc = '1701'
                 UNION ALL
                 SELECT tk_hdr.tin tin, 
                        tk_hdr.ten_dtnt ten_nnt, 
                        tk_hdr.ID ID,
                        TO_CHAR (tk_hdr.kykk_tu_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_tu_ngay,
                        TO_CHAR (tk_hdr.kykk_den_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_den_ngay,
                        TO_CHAR (tk_hdr.han_nop, 'DD/MM/YYYY') han_nop,
                        TO_CHAR (tk_hdr.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                        v_ky_den ngay_htoan,
                        tk_dtl.doanh_thu / 3 doanh_thu_ts_5,
                        tk_dtl.gtgt_chiu_thue / 3 gtgt_chiu_thue_ts_5,
                        tk_dtl.thue_gtgt / 3 thue_gtgt_ts_5,
                        psinh.thue_psinh tm_1701, 
                        5 tsgtgt, 
                        tk_dtl.tlgtgt,
                        tk_hdr.dcc_ma ma, 
                        tk_dtl.doanh_thu doanh_thu_quy_ts_5,
                        tk_dtl.gtgt_chiu_thue gtgt_chiu_thue_quy_ts_5,
                        tk_dtl.thue_gtgt thue_gtgt_quy_ts_5
                   FROM qct_cctt_hdr tk_hdr,
                        qct_cctt_dtl tk_dtl,
                        qct_cctt_psinh psinh
                  WHERE tk_hdr.ID = tk_dtl.hdr_id
                    AND tk_hdr.ID = psinh.hdr_id
                    AND tk_hdr.dcc_ma = '51'
                    AND tk_dtl.tsgtgt = 5                      -- thue suat 5%
                    --AND nnt.trang_thai NOT IN ('01', '03')
                    AND tk_hdr.kykk_tu_ngay = tk_hdr.kylb_tu_ngay
                    AND tk_hdr.kylb_tu_ngay = v_ky_tu
                    AND psinh.tmt_ma_tmuc = '1701') thop,
                qlt_nsd_dtnt dtnt
          WHERE thop.tin = dtnt.tin;

      --Cap nhat EXT_CCTT_HDR
      INSERT INTO ext_cctt_hdr
                  (tin, 
                   ten_nnt, 
                   ID, 
                   kytt_tu_ngay, 
                   kytt_den_ngay, 
                   han_nop,
                   ngay_nop_tk, 
                   ngay_htoan, 
                   doanh_thu_ts_10,
                   gtgt_chiu_thue_ts_10, 
                   thue_gtgt_ts_10, 
                   tm_1701, 
                   tsgtgt,
                   tlgtgt, 
                   ma, 
                   doanh_thu_quy_ts_10, 
                   gtgt_chiu_thue_quy_ts_10,
                   thue_gtgt_quy_ts_10)
         SELECT thop.tin, 
                thop.ten_nnt, 
                thop.ID, 
                thop.kytt_tu_ngay,
                thop.kytt_den_ngay, 
                thop.han_nop, 
                thop.ngay_nop_tk,
                thop.ngay_htoan, 
                thop.doanh_thu_ts_10,
                thop.gtgt_chiu_thue_ts_10, 
                thop.thue_gtgt_ts_10, 
                thop.tm_1701,
                thop.tsgtgt, 
                thop.tlgtgt, 
                thop.ma, 
                thop.doanh_thu_quy_ts_10,
                thop.gtgt_chiu_thue_quy_ts_10, 
                thop.thue_gtgt_quy_ts_10
           FROM (SELECT tk_hdr.tin tin, 
                        tk_hdr.ten_dtnt ten_nnt, 
                        tk_hdr.ID ID,
                        TO_CHAR (tk_hdr.kykk_tu_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_tu_ngay,
                        TO_CHAR (tk_hdr.kykk_den_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_den_ngay,
                        TO_CHAR (tk_hdr.han_nop, 'DD/MM/YYYY') han_nop,
                        TO_CHAR (tk_hdr.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                        v_ky_den ngay_htoan, tk_dtl.doanh_thu doanh_thu_ts_10,
                        tk_dtl.gtgt_chiu_thue gtgt_chiu_thue_ts_10,
                        tk_dtl.thue_gtgt thue_gtgt_ts_10,
                        psinh.thue_psinh tm_1701, 
                        10 tsgtgt, 
                        tk_dtl.tlgtgt,
                        tk_hdr.dcc_ma ma, 
                        0 doanh_thu_quy_ts_10,
                        0 gtgt_chiu_thue_quy_ts_10, 
                        0 thue_gtgt_quy_ts_10
                   FROM qct_cctt_hdr tk_hdr,
                        qct_cctt_dtl tk_dtl,
                        qct_cctt_psinh psinh
                  WHERE tk_hdr.ID = tk_dtl.hdr_id
                    AND tk_hdr.ID = psinh.hdr_id
                    AND tk_hdr.dcc_ma = c_dcc_ma
                    AND tk_dtl.tsgtgt = 10                    -- thue suat 10%
                    --AND nnt.trang_thai NOT IN ('01', '03')
                    AND tk_hdr.kykk_tu_ngay = tk_hdr.kylb_tu_ngay
                    AND tk_hdr.kykk_tu_ngay = v_ky_tu
                    AND psinh.tmt_ma_tmuc = '1701'
                 UNION ALL
                 SELECT tk_hdr.tin tin, 
                        tk_hdr.ten_dtnt ten_nnt, 
                        tk_hdr.ID ID,
                        TO_CHAR (tk_hdr.kykk_tu_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_tu_ngay,
                        TO_CHAR (tk_hdr.kykk_den_ngay,
                                 'DD/MM/YYYY'
                                ) kytt_den_ngay,
                        TO_CHAR (tk_hdr.han_nop, 'DD/MM/YYYY') han_nop,
                        TO_CHAR (tk_hdr.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                        v_ky_den ngay_htoan,
                        tk_dtl.doanh_thu / 3 doanh_thu_ts_10,
                        tk_dtl.gtgt_chiu_thue / 3 gtgt_chiu_thue_ts_10,
                        tk_dtl.thue_gtgt / 3 thue_gtgt_ts_10,
                        psinh.thue_psinh tm_1701, 
                        10 tsgtgt, 
                        tk_dtl.tlgtgt,
                        tk_hdr.dcc_ma ma,
                        tk_dtl.doanh_thu doanh_thu_quy_ts_10,
                        tk_dtl.gtgt_chiu_thue gtgt_chiu_thue_quy_ts_10,
                        tk_dtl.thue_gtgt thue_gtgt_quy_ts_10
                   FROM qct_cctt_hdr tk_hdr,
                        qct_cctt_dtl tk_dtl,
                        qct_cctt_psinh psinh
                  WHERE tk_hdr.ID = tk_dtl.hdr_id
                    AND tk_hdr.ID = psinh.hdr_id
                    AND tk_hdr.dcc_ma = '51'
                    AND tk_dtl.tsgtgt = 10                    -- thue suat 10%
                    --AND nnt.trang_thai NOT IN ('01', '03')
                    AND tk_hdr.kykk_tu_ngay = tk_hdr.kylb_tu_ngay
                    AND tk_hdr.kykk_tu_ngay = v_ky_tu
                    AND psinh.tmt_ma_tmuc = '1701') thop,
                qlt_nsd_dtnt dtnt
          WHERE thop.tin = dtnt.tin;

      /* cap nhat phong ban can bo */
      prc_update_pbcb ('EXT_CCTT_HDR');
      COMMIT;
      qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
      prc_finnal (c_pro_name);
   EXCEPTION
      WHEN OTHERS
      THEN
         prc_finnal (c_pro_name);
   END;

   /**
    * Thuc hien lay loai to khai (thang, quy, nam)
    *@author  Administrator
    *@date    22/04/2013
    *@param   ma_tk
    *@see ext_pck_qct_tkhai.Fnc_GetKyTK
    */
   FUNCTION fnc_getkytk (ma_tk VARCHAR2)
      RETURN VARCHAR2
   IS
      rt_loaitk   VARCHAR2 (1);
   BEGIN
      SELECT a.kieu_ky
        INTO rt_loaitk
        FROM qct_dm_cctt a
       WHERE a.ma = ma_tk;

      RETURN rt_loaitk;
   END;

   /**
    * Thuc hien lay ma to khai da map tren he thong TMS
    *@author  Administrator
    *@date    22/04/2013
    *@param   ma_tk
    *@see ext_pck_qct_tkhai.fnc_get_tkhai_tms
    */
   FUNCTION fnc_get_tkhai_tms (ma_tk VARCHAR2)
      RETURN VARCHAR2
   IS
      tk_tms   VARCHAR2 (20);
   BEGIN
      SELECT a.ma_tms
        INTO tk_tms
        FROM ext_dmuc_tkhai a
       WHERE a.ma = ma_tk AND a.tax_model = 'QCT-APP' AND ROWNUM = 1;

      RETURN tk_tms;
   END;
END;