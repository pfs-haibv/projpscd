CREATE OR REPLACE 
PACKAGE BODY ext_pck_qlt_control
IS
    /*************************************************************************** EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE) IS
        v_pro_name CONSTANT VARCHAR2(30) := 'PRC_QLT_THOP_NO';
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
        v_tphat_den_ngay DATE;
        
        CURSOR c_GDich_QD(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2)IS
            SELECT *
            FROM  EXT_QLT_DM_GDICH_QDINH DM
            WHERE DM.ma_gdich     =   pc_MA_GDICH
                AND DM.kieu_gdich   =   pc_Kieu_GDich ;

        CURSOR c_TC_NO(pn_PNOP_ID NUMBER)IS
            SELECT TCNO.dtc_ma
            FROM  EXT_QLT_TC_NO TCNO
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
                , NO_NTE                    NO_NTE
                , DON_VI_TIEN               DON_VI_TIEN
                , id                        pnop_id
        FROM ext_qlt_no_thanh_toan PNOP ;

        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qlt_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));
    BEGIN
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        -- Xoa du lieu bang du lieu tren cac bang trung gian
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QLT_NO_THANH_TOAN');
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QLT_NO');
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE EXT_QLT_TC_NO');
        DBMS_UTILITY.exec_ddl_statement ('TRUNCATE TABLE ext_QTN_SO_NO_QLT');

        EXT_PCK_Qlt_XL_NO.prc_qlt_no(p_chot);
        EXT_PCK_Qlt_XL_NO_NTE.prc_qlt_no_nte(p_chot);

        INSERT INTO ext_QTN_SO_NO_QLT (KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                                   dgd_kieu_gdich,TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA)
            select KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich, dgd_kieu_gdich,
                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA
            from QTN_SO_NO@QTN TCNO where TCNO.KYNO_DEN_NGAY = p_chot;

        INSERT INTO EXT_QLT_TC_NO
        SELECT    PNOP.ID       PNOP_ID
                , TCNO.DTC_MA  DTC_MA
        FROM ext_qlt_no_thanh_toan PNOP, ext_QTN_SO_NO_QLT TCNO
        WHERE TCNO.KYNO_DEN_NGAY = p_chot
            AND PNOP.NO_NTE IS NULL
            AND PNOP.hdr_id=TCNO.hdr_id AND PNOP.dtl_id=TCNO.dtl_id
            AND PNOP.ma_gdich = TCNO.dgd_ma_gdich AND PNOP.kieu_gdich = TCNO.dgd_kieu_gdich
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

             --Neu la no ngoai te thi khong lay so quyet dinh
            if vPNOP.NO_NTE IS NULL then
                FOR vc_GDICH_QD IN c_GDICH_QD (vPNOP.ma_gdich
                                               ,vPNOP.kieu_gdich) LOOP
                    v_bang_hdr    := trim(vc_GDICH_QD.BANG_HDR);
                    v_ten_cot_sqd := trim(vc_GDICH_QD.TEN_COT_SQD);
                    v_ten_cot_nqd := trim(vc_GDICH_QD.TEN_COT_NQD);
                END LOOP;
            End if;

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

            v_DTC_MA := null;
            --Neu la no ngoai te thi khong lay tinh chat no
            if vPNOP.NO_NTE IS NULL then
                FOR vc_TC_NO IN c_TC_NO (vPNOP.PNOP_ID) LOOP
                    v_DTC_MA    := trim(vc_TC_NO.DTC_MA);
                END LOOP;
            End if;

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
            v_tphat_den_ngay := null;
            if (vPNOP.PHAI_NOP > 0 and vPNOP.han_nop <= p_chot) then                
                v_tphat_den_ngay := p_chot;                
            end if;
            
            INSERT INTO EXT_QLT_NO (TIN,
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
                        no_nte,
                        don_vi_tien,
                        id,
                        MA_GDICH,
                        KIEU_GDICH,
                        tphat_den_ngay                         
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
                        ,vPNOP.NO_NTE
                        ,vPNOP.DON_VI_TIEN
                        ,ext_seq.NEXTVAL
                        ,vPNOP.MA_GDICH
                        ,vPNOP.KIEU_GDICH
                        ,v_tphat_den_ngay
                        );
        END LOOP;

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qlt_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, 'MONTH'),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, 'MONTH'))
            WHERE id=vUp_Ky.id;
        END LOOP;

        UPDATE ext_qlt_no SET KYKK_TU_NGAY=v_kykk_hluc,
                              KYKK_DEN_NGAY=last_day(v_kykk_hluc)
                        WHERE KYKK_TU_NGAY<v_kykk_hluc;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb('ext_qlt_no');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ps(p_ky_ps_tu date, p_ky_ps_den date) IS

    v_Alert_button NUMBER;
    v_pro_name CONSTANT VARCHAR2(30) := 'PRC_QLT_THOP_PS';

    v_tu_ky date := trunc(p_ky_ps_tu,'month');
    v_den_ky date := last_day(p_ky_ps_den);

    CURSOR cLoop IS
    /* TO KHAI PHAT SINH */
    SELECT tkha.tin tin, tkha.dtk_ma_loai_tkhai dtk_ma, nnt.ma_chuong ma_chuong,
               nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc tmt_ma_tmuc,
               tkha.kykk_tu_ngay kykk_tu_ngay, tkha.kykk_den_ngay kykk_den_ngay,
               psin.thue_psinh so_tien, tkha.han_nop
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >= v_tu_ky)
        AND (tkha.kylb_tu_ngay <= v_den_ky)
        AND (tkha.dtk_ma_loai_tkhai IN  (SELECT a.ma FROM ext_dmuc_tkhai a where a.flg_ps = 'Y') )
        AND (psin.thue_psinh<>0)
        UNION ALL
    /*Chuyen nghia vu thue*/
    SELECT   DTL.TIN           TIN
       , MAP_TMUC.dct_ma       dtk_ma
       , nnt.ma_chuong         ma_chuong
       , nnt.ma_khoan          ma_khoan
       , DTL.TMT_MA_TMUC       tmt_ma_tmuc
       , HDR.KYKK_TU_NGAY      KYKK_TU_NGAY
       , HDR.KYKK_DEN_NGAY     KYKK_DEN_NGAY
       , DTL.SO_TIEN           SO_TIEN
       , DTL.han_nop           han_nop
       /*, HDR.KYLB_TU_NGAY      KYLB_TU_NGAY
       , HDR.KYLB_DEN_NGAY     KYLB_DEN_NGAY*/
        FROM  QLT_QD_CNVT_HDR HDR
             ,QLT_XLTK_GDICH  DTL
             ,qlt_nsd_dtnt nnt
             ,QLT_MAP_TMUC_CNVT MAP_TMUC
        WHERE HDR.ID = DTL.HDR_ID
        AND (nnt.tin=dtl.tin)
        AND (MAP_TMUC.TMUC=DTL.TMT_MA_TMUC)
        AND (HDR.kykk_tu_ngay >= v_tu_ky)
        AND (HDR.kylb_tu_ngay <= v_den_ky)
        AND DTL.DGD_MA_GDICH IN ('94')
        AND DTL.DGD_KIEU_GDICH IN ('25')
        AND DTL.SO_TIEN <> 0    
        UNION ALL
    /* AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
               hdr.kykk_tu_ngay, hdr.kykk_den_ngay, dtl.so_thue so_tien,
               hdr.han_nop
        FROM qlt_ds_an_dinh_hdr hdr,
             qlt_ds_an_dinh_dtl dtl,
             qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.adh_id
        AND (nnt.tin=hdr.tin)
        AND (hdr.ly_do IN ('02','03'))
        AND (hdr.kykk_tu_ngay >= v_tu_ky)
        AND (hdr.kylb_tu_ngay <= v_den_ky)
        AND (hdr.dtk_ma IN  (SELECT a.ma FROM ext_dmuc_tkhai a where a.flg_ps = 'Y') )
        UNION ALL
    /* BAI BO AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
            hdr.kykk_tu_ngay, hdr.kykk_den_ngay, (-1)*dtl.so_thue so_tien,
            hdr.ngay_qd_bbo han_nop
        FROM qlt_qd_bbo_ad_hdr hdr,
            qlt_qd_bbo_ad_dtl dtl,
            qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.qba_id
            AND (nnt.tin=hdr.tin)
            AND (hdr.kykk_tu_ngay >= v_tu_ky)
        AND (hdr.kylb_tu_ngay <= v_den_ky)
        AND (hdr.dtk_ma IN  (SELECT a.ma FROM ext_dmuc_tkhai a where a.flg_ps = 'Y') );

    /* XU LY KHIEU NAI */
        CURSOR cADI IS
        SELECT hdr.id, hdr.so_qd_goc, adi.dtk_ma, adi.kykk_tu_ngay, adi.kykk_den_ngay,
               adi.tin, nnt.ma_chuong, nnt.ma_khoan, 'KHIEU_NAI_AN_DINH' trang_thai, adi.KYLB_TU_NGAY,
               adi.han_nop
        FROM qlt_ds_an_dinh_hdr adi,
               qlt_ds_an_dinh_dtl dtl,
             qlt_qd_xlkn_hdr hdr,
             qlt_nsd_dtnt nnt
        WHERE adi.so_qd=hdr.so_qd_goc
        AND (adi.id=dtl.adh_id)
        AND (adi.tin=nnt.tin)
        AND (adi.ly_do IN ('03'))
        AND (adi.kykk_tu_ngay >= v_tu_ky)
        AND (adi.kylb_tu_ngay <= v_den_ky)
        AND (adi.dtk_ma IN  (SELECT a.ma FROM ext_dmuc_tkhai a where a.flg_ps = 'Y') );

        CURSOR cKHN(p_so_qd_goc VARCHAR2) IS
        SELECT dtl.tmt_ma_tmuc, dtl.stien_clech so_tien
        FROM qlt_qd_xlkn_hdr hdr,
             qlt_qd_xlkn_dtl dtl
        WHERE hdr.id=dtl.qxkh_id
        AND EXISTS (SELECT 1
                    FROM qlt_qd_xlkn_hdr subhdr
                    WHERE subhdr.id=hdr.id
                    START WITH subhdr.so_qd_goc = p_so_qd_goc
                    CONNECT BY PRIOR subhdr.so_qd_xly = subhdr.so_qd_goc);

    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        DBMS_UTILITY.exec_ddl_statement('TRUNCATE TABLE ext_qlt_ps') ;

        /* day du lieu phat sinh to khai, an dinh, bai bo */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                          ma_loai_tkhai, ky_psinh_tu,
                                          ky_psinh_den, han_nop)
                VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ma_chuong, vLoop.ma_khoan,
                       vLoop.tmt_ma_tmuc, vLoop.so_tien,
                       vLoop.dtk_ma, vLoop.kykk_tu_ngay, vLoop.kykk_den_ngay,
                       vLoop.han_nop);
        END LOOP;

        /* day du lieu khieu nai */
        FOR vADI IN cADI LOOP
            FOR vKHN IN cKHN(vADI.so_qd_goc) LOOP
                INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc,
                                              so_tien, ma_loai_tkhai, ky_psinh_tu,
                                              ky_psinh_den, han_nop)
                    VALUES(ext_seq.NEXTVAL, vADI.tin, vADI.ma_chuong, vADI.ma_khoan,
                           vKHN.tmt_ma_tmuc, vKHN.so_tien,
                           vADI.dtk_ma, vADI.kykk_tu_ngay, vADI.kykk_den_ngay, vADI.han_nop);
            END LOOP;
        END LOOP;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb('ext_qlt_ps');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;

         Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ckt
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ckt(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := 'PRC_QLT_THOP_CKT';

    v_ky_tu DATE:= to_date('01/01/2009', 'dd/mm/yyyy');
    v_ky_den DATE:= last_day(p_chot);

    CURSOR cLoop IS
    SELECT tk_hdr.tin tin, nnt.ma_chuong, nnt.ma_khoan,
               tk_hdr.DTK_MA_LOAI_TKHAI dtk_ma,
               tk_hdr.KYKK_TU_NGAY KYKK_TU_NGAY,
               tk_hdr.KYKK_DEN_NGAY KYKK_DEN_NGAY,
               tk_hdr.HAN_NOP HAN_NOP,
               tk_dtl.tmt_ma_tmuc MA_TMUC,
               tk_dtl.thue_ktru_ksau SO_TIEN
        FROM Qlt_tkhai_hdr tk_hdr,
             qlt_htoan_tkhai_gtgt_kt_2004 tk_dtl,
             qlt_nsd_dtnt nnt
        WHERE tk_hdr.id=tk_dtl.tkh_id
        AND tk_dtl.tkh_ltd = 0
        AND nnt.tin=tk_hdr.tin
        AND tk_hdr.TTHAI IN ('1','3','4')
        AND tk_hdr.LTD = 0
        AND tk_hdr.DTK_MA_LOAI_TKHAI = '14'
        AND tk_hdr.KYLB_DEN_NGAY <= v_ky_den
        AND tk_hdr.KYLB_TU_NGAY >= v_ky_tu
        AND tk_hdr.KYKK_TU_NGAY =( SELECT MAX(KYKK_TU_NGAY)
            from qlt_tkhai_hdr a
            where a.tin =tk_hdr.TIN
            AND a.TTHAI IN ('1','3','4')
            AND a.LTD = 0
            AND a.DTK_MA_LOAI_TKHAI = '14'
            AND a.KYLB_DEN_NGAY <= v_ky_den)
    UNION ALL
        SELECT tk_hdr.tin tin, nnt.ma_chuong, nnt.ma_khoan,
               tk_hdr.DTK_MA_LOAI_TKHAI dtk_ma,
               tk_hdr.KYKK_TU_NGAY KYKK_TU_NGAY,
               tk_hdr.KYKK_DEN_NGAY KYKK_DEN_NGAY,
               tk_hdr.HAN_NOP HAN_NOP,
               '1701' MA_TMUC,
               tk_dtl.sothue_dtnt SO_TIEN
        FROM Qlt_tkhai_hdr tk_hdr,
             qlt_tkhai_gtgt_kt tk_dtl,
             qlt_nsd_dtnt nnt
        WHERE tk_hdr.id=tk_dtl.tkh_id
        AND tk_dtl.tkh_ltd = 0
        AND nnt.tin=tk_hdr.tin
        AND tk_hdr.TTHAI IN ('1','3','4')
        AND tk_hdr.LTD = 0
        AND tk_hdr.DTK_MA_LOAI_TKHAI = '68'
        AND tk_hdr.KYLB_DEN_NGAY <= v_ky_den
        AND tk_hdr.KYLB_TU_NGAY >= v_ky_tu
        AND tk_dtl.CTK_ID = '2221'
        AND tk_hdr.KYKK_TU_NGAY =(SELECT MAX(KYKK_TU_NGAY)
            from qlt_tkhai_hdr a
            where a.tin =tk_hdr.TIN
            AND a.TTHAI IN ('1','3','4')
            AND a.LTD = 0
            AND a.DTK_MA_LOAI_TKHAI = '68'
            AND a.KYLB_DEN_NGAY <= v_ky_den) ;
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        DBMS_UTILITY.exec_ddl_statement ('truncate table ext_qlt_con_kt') ;

        /* day du lieu dang ky nop to khai */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_CON_KT(id, tin, ma_chuong, ma_khoan,
                                          ma_loai_tkhai, MA_TMUC,
                                          KYKK_TU_NGAY,
                                          KYKK_DEN_NGAY,
                                          han_nop,
                                          SO_TIEN)
                VALUES(ext_seq.NEXTVAL, vLoop.tin,vLoop.ma_chuong,
                    '000' , vLoop.dtk_ma,
                    vLoop.MA_TMUC, vLoop.KYKK_TU_NGAY,
                    vLoop.KYKK_DEN_NGAY, vLoop.han_nop, vLoop.SO_TIEN);
        END LOOP;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb('ext_qlt_con_kt');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN Prc_Finnal(c_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE) IS
    BEGIN
        Prc_Del_Log('PRC_QLT_THOP_NO');
        COMMIT;
        Prc_Create_Job('BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_No('''||p_chot||''');
                        END;');
    END;

   /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_ky_ps_tu DATE, p_ky_ps_den DATE) IS
    BEGIN
        Prc_Del_Log('PRC_QLT_THOP_PS');
        COMMIT;
        Prc_Create_Job('BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ps('''||p_ky_ps_tu||''', ''' || p_ky_ps_den ||''');
                        END;');
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ckt
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ckt(p_chot DATE) IS
    BEGIN
        Prc_Del_Log('PRC_QLT_THOP_CKT');
        COMMIT;
        Prc_Create_Job('BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_CKT('''||p_chot||''');
                        END;');
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Remove_Job
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
    EXT_PCK_QLT_CONTROL.Prc_Create_Job
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
    EXT_PCK_QLT_CONTROL.Prc_Ins_Log
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
    EXT_PCK_QLT_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Del_Log
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
    EXT_PCK_QLT_CONTROL.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2) IS
    BEGIN
         EXECUTE IMMEDIATE '
        UPDATE '||p_table_name||' a
           SET (ten_nnt, ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT ten_dtnt ten_nnt, b.ma_canbo,
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


-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CONTROL


-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CONTROL


-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CONTROL


-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_CONTROL


-- End of DDL Script for Package QLT_OWNER.EXT_PCK_QLT_CONTROL

