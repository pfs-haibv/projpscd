-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QCT_CONTROL
-- Generated 19/09/2013 10:00:06 AM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE BODY ext_pck_qct_control
IS
    /*************************************************************************** EXT_PCK_QCT_CONTROL.Prc_Qct_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE) IS
        v_pro_name CONSTANT VARCHAR2(30) := 'PRC_QCT_THOP_NO';
        v_kykk_hluc CONSTANT DATE := to_date('1-jan-2005','DD/MM/RRRR');

        v_bang_hdr          VARCHAR2(50);
        v_ten_cot_sqd       VARCHAR2(20);
        v_ten_cot_nqd       VARCHAR2(20);

        TYPE cv_typ IS REF CURSOR;
        c_SO_QD cv_typ;
        v_so_qd VARCHAR2(20);
        v_ngay_qd DATE;

        SQL_Text  VARCHAR2(200);

        v_DTC_MA VARCHAR2(2);

        v_kykk_tu_ngay  DATE ;
        v_kykk_den_ngay  DATE ;
        v_ngay_hach_toan DATE ;

        CURSOR c_GDich_QD(pc_MA_GDICH VARCHAR2)IS
            SELECT *
            FROM  EXT_QCT_DM_GDICH_QDINH DM
            WHERE DM.ma_gdich     =   pc_MA_GDICH   ;

        CURSOR c_TC_NO(pn_PNOP_ID NUMBER)IS
            SELECT TCNO.dtc_ma
            FROM  EXT_QCT_TC_NO TCNO
            WHERE TCNO.pnop_id = pn_PNOP_ID;

        CURSOR cPNOP (p_chot DATE) IS
        SELECT    PNOP.TIN
                , HDR_ID                    HDR_ID
                , DTL_ID                    DTL_ID
                , PNOP.TKHOAN               TKHOAN
                , MA_CHUONG            MA_CHUONG
                , MA_KHOAN             MA_KHOAN
                , MA_MUC                    MA_MUC
                , MA_TMUC                   MA_TMUC
                , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                , KYLB_TU_NGAY              KYLB_TU_NGAY
                , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                , KYKK_TU_NGAY              KYKK_TU_NGAY
                , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                , MA_THUE                   MA_THUE
                , NO_DAU_KY                 NO_DAU_KY
                , PHAI_NOP                  PHAI_NOP
                , HAN_NOP                   HAN_NOP
                , KYTP_TU_NGAY              KYTP_TU_NGAY
                , MA_GDICH                  MA_GDICH
                , KIEU_GDICH                KIEU_GDICH
                , TEN_GDICH                 TEN_GDICH
                , CHK_KNO                   CHK_KNO
                , QDINH_ID                  QDINH_ID
                , Loai_Qdinh                Loai_Qdinh
                , Nguon_Goc                 Nguon_Goc
                , id                        pnop_id
        FROM ext_qct_no_thanh_toan PNOP ;

        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qct_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));
    BEGIN
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        -- Xoa du lieu bang du lieu tren cac bang trung gian
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QCT_NO_THANH_TOAN') ;
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QCT_NO') ;
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QCT_TC_NO');
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE ext_QTN_SO_NO_QCT');

        EXT_PCK_Qct_XL_NO.prc_qct_no(p_chot);

        INSERT INTO ext_QTN_SO_NO_QCT (KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA)
            select KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA
            from QTN_SO_NO_CTH@QTN TCNO where TCNO.KYNO_DEN_NGAY = p_chot;

        INSERT INTO EXT_QCT_TC_NO
        SELECT    PNOP.ID       PNOP_ID
                , TCNO.DTC_MA  DTC_MA
        FROM ext_qct_no_thanh_toan PNOP, ext_QTN_SO_NO_QCT TCNO
        WHERE TCNO.KYNO_DEN_NGAY = p_chot
            AND PNOP.hdr_id=TCNO.hdr_id AND PNOP.dtl_id=TCNO.dtl_id
            AND PNOP.ma_gdich = TCNO.dgd_ma_gdich
            AND PNOP.tin = TCNO.TIN AND PNOP.ma_tmuc = TCNO.tmt_ma_tmuc
            AND PNOP.han_nop = TCNO.han_nop AND PNOP.ma_thue = TCNO.tmt_ma_thue
            AND decode(PNOP.tkhoan,'TK_TAM_GIU','1',
                              'TK_NGAN_SACH','2',
                              'TK_TAM_THU','3',
                              'TK_TH_HOAN','4') = TCNO.tkn_ma
            AND PNOP.PHAI_NOP>0 ;

        FOR vPNOP IN cPNOP(p_chot) LOOP
            v_bang_hdr    := null;
            v_ten_cot_sqd := null;
            v_ten_cot_nqd := null;

            FOR vc_GDICH_QD IN c_GDICH_QD (vPNOP.ma_gdich) LOOP
                v_bang_hdr    := trim(vc_GDICH_QD.BANG_HDR);
                v_ten_cot_sqd := trim(vc_GDICH_QD.TEN_COT_SQD);
                v_ten_cot_nqd := trim(vc_GDICH_QD.TEN_COT_NQD);
            END LOOP;

            v_so_qd := null;
            v_ngay_qd := null;

            if v_bang_hdr is not null then
                SQL_Text := 'SELECT ' || v_ten_cot_sqd || ' SO_QD, '
                                  || v_ten_cot_nqd || ' NGAY_QD FROM '
                                  || v_bang_hdr || ' HDR WHERE HDR.ID = '
                                  || Nvl(vPNOP.HDR_ID,0) ;

                OPEN c_SO_QD for SQL_Text;
                LOOP
                    FETCH c_SO_QD into v_so_qd, v_ngay_qd;
                    EXIT WHEN c_SO_QD%notfound;
                END LOOP;
                --Close cursor
                CLOSE c_SO_QD;
             END IF;

            IF v_ngay_qd is null THEN
                 v_ngay_qd := Trunc(vPNOP.kylb_tu_ngay,'Month') ;
            END IF;

            v_DTC_MA := null;
            FOR vc_TC_NO IN c_TC_NO (vPNOP.PNOP_ID) LOOP
                v_DTC_MA    := trim(vc_TC_NO.DTC_MA);
            END LOOP;

            v_kykk_tu_ngay := vPNOP.kykk_tu_ngay ;
            v_kykk_den_ngay := vPNOP.kykk_den_ngay ;
            if vPNOP.kykk_tu_ngay is null then
                v_kykk_tu_ngay := vPNOP.kylb_tu_ngay ;
            end if;

            if vPNOP.kykk_den_ngay is null then
                v_kykk_den_ngay := vPNOP.kylb_den_ngay ;
            end if;

            if vPNOP.KYLB_DEN_NGAY < Trunc(p_chot,'Year') then
                v_ngay_hach_toan := Trunc(p_chot,'Year') - 1 ;
            else
                v_ngay_hach_toan := last_day(p_chot);
            end if;

            INSERT INTO EXT_QCT_NO (TIN,
                        tkhoan,
                        ma_chuong,
                        ma_khoan,
                        tmt_ma_tmuc,
                        kykk_tu_ngay,
                        kykk_den_ngay,
                        ngay_hach_toan,
                        han_nop,
                        nguon_goc,
                        tinh_chat,
                        so_qd,
                        ngay_qd,
                        so_tien,
                        id,
                        MA_GDICH,
                        KIEU_GDICH  
                        )
            VALUES      (
                        vPNOP.TIN
                        ,vPNOP.tkhoan
                        ,vPNOP.ma_chuong
                        ,vPNOP.ma_khoan
                        ,vPNOP.ma_tmuc
                        ,v_kykk_tu_ngay
                        ,v_kykk_den_ngay
                        ,v_ngay_hach_toan
                        ,vPNOP.han_nop
                        ,vPNOP.nguon_goc
                        ,v_DTC_MA
                        ,v_so_qd
                        ,v_ngay_qd
                        ,vPNOP.PHAI_NOP
                        ,ext_seq.NEXTVAL
                        ,vPNOP.MA_GDICH
                        ,vPNOP.KIEU_GDICH
                        );
        END LOOP;

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qct_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, 'MONTH'),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, 'MONTH'))
            WHERE id=vUp_Ky.id;
        END LOOP;

        UPDATE ext_qct_no SET KYKK_TU_NGAY=v_kykk_hluc,
                              KYKK_DEN_NGAY=last_day(v_kykk_hluc)
                        WHERE KYKK_TU_NGAY<v_kykk_hluc;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb('ext_qct_no');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Job_Qct_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE) IS
    BEGIN
        Prc_Del_Log('PRC_QCT_THOP_NO');
        COMMIT;
        Prc_Create_Job('BEGIN
                            EXT_PCK_QCT_CONTROL.Prc_Qct_Thop_No('''||p_chot||''');
                        END;');
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2)
    IS
        CURSOR c IS
        SELECT JOB FROM user_jobs
            WHERE instr(upper(what), upper(p_pro_name))>0;
    BEGIN
        FOR v IN c LOOP
            IF (v.job IS NOT NULL) THEN
                dbms_job.remove(v.job);
            END IF;
        END LOOP;
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log('Remove_Job_'||p_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2)
    IS
        JobNo user_jobs.job%TYPE;
    BEGIN
        dbms_job.submit(JobNo,
                        p_name_exe,
                        SYSDATE + 10/86400,
                        'SYSDATE + 365');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log('Create_Job_'||p_name_exe);
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.FORMAT_ERROR_STACK IS NULL THEN
            v_status:='Y';
        ELSE
            v_status:='N';
        END IF;

        -- Insert log
        INSERT INTO ext_errors(seq_number, error_stack, call_stack, timestamp,
                               pck, status)
                      VALUES(ext_seq.NEXTVAL,
                             DBMS_UTILITY.FORMAT_ERROR_STACK,
                             DBMS_UTILITY.FORMAT_CALL_STACK,
                             SYSDATE, p_pck, v_status);
        COMMIT;
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE '
        UPDATE '||p_table_name||' a
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
END;

-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QCT_CONTROL

