-- Start of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_XL_NO
-- Generated 19/09/2013 10:04:25 AM from QLT_OWNER@QLT_BRV_VTA

CREATE OR REPLACE 
PACKAGE BODY ext_pck_qlt_xl_no
IS
    PROCEDURE Prc_Qlt_No(p_ky_no DATE) IS

        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;

        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma, hoac lay het (NULL)

        PROCEDURE Prc_THop_No_Thue(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , PNOP.TKHOAN               TKHOAN
                        , DTNT.MA_CHUONG            MA_CHUONG
                        , DTNT.MA_KHOAN             MA_KHOAN
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
                FROM(
                        SELECT  ST.TIN                  TIN
                                , ST.HDR_ID             HDR_ID
                                , ST.DTL_ID             DTL_ID
                                , Max(ST.KYTT_TU_NGAY)       KY_TTOAN_TU_NGAY
                                , Max(ST.KYTT_DEN_NGAY)      KY_TTOAN_DEN_NGAY
                                , Max(ST.KYLB_TU_NGAY)       KYLB_TU_NGAY
                                , Max(ST.KYLB_DEN_NGAY)      KYLB_DEN_NGAY
                                , ST.KYKK_TU_NGAY       KYKK_TU_NGAY
                                , ST.KYKK_DEN_NGAY      KYKK_DEN_NGAY
                                , ST.TMT_MA_MUC         MA_MUC
                                , ST.TMT_MA_TMUC        MA_TMUC
                                , ST.TMT_MA_THUE        MA_THUE
                                , ST.TKHOAN             TKHOAN
                                , Sum(Decode(CHECK_KNO,'1',NO_CUOI_KY,0))    NO_DAU_KY
                                , Sum(ST.NO_CUOI_KY)         PHAI_NOP
                                , St.han_nop            HAN_NOP
                                , Max(Decode(CHECK_KNO,'1', Trunc(p_den_ky,'Month')-1,ST.HAN_NOP))    KYTP_TU_NGAY
                                , ST.DGD_MA_GDICH       MA_GDICH
                                , ST.DGD_KIEU_GDICH     KIEU_GDICH
                                , ('XLTK_GDICH')        TEN_GDICH
                                , Max(Nvl(ST.CHECK_KNO,'0')) CHK_KNO
                                , Max(QDINH_ID)         QDINH_ID
                                , Max(Loai_Qdinh)       Loai_Qdinh
                        FROM    QLT_SO_NO  ST
                        WHERE   ST.KYNO_TU_NGAY = Trunc(p_den_ky,'Month')
                                AND (Tmt_Ma_Muc <> '1000' AND Tmt_Ma_Tmuc <> '4268')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.kykk_tu_ngay,st.kykk_den_ngay,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.dgd_ma_gdich,st.dgd_kieu_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, PNOP.TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;

            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT Ten
                FROM  QLT_DM_GDICH DM
                WHERE DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),'NULL')    =   'XLTK_GDICH'
                UNION ALL
                SELECT trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM Dual
                WHERE NVL(trim(pc_Ten_GDich),'NULL')    <>  'XLTK_GDICH';

            TYPE tab_phai_nop IS TABLE OF c_phai_nop%ROWTYPE INDEX BY BINARY_INTEGER;
            vt_PN tab_PHAI_NOP;
            i NUMBER;
            j NUMBER;
            k NUMBER;
            l NUMBER;
            v_kno_num           NUMBER;
            v_kno_first_index   NUMBER;
            v_kno_index         NUMBER;
            v_last_tin VARCHAR2(14):='HHHHHHHHHHHHHH';
            v_last_tkhoan   VARCHAR2(20):='HHHHHHHHHHHHHHHHHHHH';
            v_last_muc      VARCHAR2(4):='HHH';
            v_last_tmuc     VARCHAR2(4):='HH';
            v_ten_gdich     VARCHAR2(100);
            v_Temp  VARCHAR2(10);

            /*Thu tuc thuc hien qua trinh thanh toan doi voi 1 tap du lieu TIN-TKHOAN-MUC-TMUC
            Nguoi tao:  HoangNL
            Ngay tao:   02/11/2006
            Muc dich:   + Thuc hien thanh toan tren mang du lieu vt_PN(i) (i=1..k):
            */
            PROCEDURE PRC_THANH_TOAN IS
                v_No_Dky NUMBER;
            BEGIN
                -- So luong phan tu mang vt_PN, lay chi so khoan no dau tien
                v_kno_num:=k;
                v_kno_first_index:=v_kno_num+1;
                i:=1;
                WHILE (i<=v_kno_num) LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN
                        v_kno_first_index:=i;
                        EXIT;
                    END IF;
                    i:=i+1;
                END LOOP;

                -- Duyet cac khoan dieu chinh de tim giao dich dac biet
                FOR i IN 1..v_kno_first_index-1 LOOP
                    --  Tim thay giao dich dac biet
                    IF (vt_PN(i).ma_gdich IN ('H7','H5','78','B4')) THEN
                        -- Duyet cac khoan phai nop de tim giao dich can dieu chinh tuong ung
                        j :=v_kno_first_index;
                        WHILE (j<=v_kno_num) AND (vt_PN(i).phai_nop <0)LOOP
                            IF  (   vt_PN(j).phai_nop>0
                                AND (((  (vt_PN(i).ma_gdich='H7' AND vt_PN(j).ma_gdich='24')
                                    OR  (vt_PN(i).ma_gdich='H5' AND vt_PN(j).ma_gdich='H1')
                                    OR  (vt_PN(i).ma_gdich='78' AND vt_PN(j).ma_gdich IN('04','16')))
                                AND vt_PN(i).ky_ttoan_tu_ngay    =   vt_PN(j).ky_ttoan_tu_ngay
                                AND vt_PN(i).ky_ttoan_den_ngay   =   vt_PN(j).ky_ttoan_den_ngay)
                                OR  (vt_PN(i).ma_gdich='B4' AND vt_PN(j).ma_gdich='I3'))) THEN

                                IF  vt_PN(i).Han_Nop>vt_PN(j).kytp_tu_ngay  THEN
                                    vt_PN(j).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(j).CHK_KNO:='1';
                                END IF;

                                IF abs(vt_PN(i).phai_nop)>vt_pn(j).phai_nop THEN
                                    vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(j).phai_nop;
                                    vt_PN(j).phai_nop:=0;
                                ELSE
                                    vt_PN(j).phai_nop:=vt_PN(j).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop:=0;
                                END IF;
                            END IF;
                            j:=j+1;
                        END LOOP;
                    END IF;
                END LOOP;
                --Thanh toan theo ky va theo han nop xa nhat
                IF(v_kno_first_index<=v_kno_num)THEN
                    i:=1;
                    v_kno_index := v_kno_first_index;
                    WHILE (i<v_kno_first_index) LOOP
                        -- Thanh toan cac khoan co cung nguon goc hoac chung tu co chi ro quyet dinh
                        l := v_kno_index;
                        WHILE l <= v_kno_num LOOP
                            IF vt_PN(l).Phai_Nop > 0
                                AND ((vt_PN(l).Hdr_Id = vt_PN(i).Hdr_Id AND vt_PN(l).Dtl_Id = vt_PN(i).Dtl_Id)
                                OR (vt_PN(i).Qdinh_Id = vt_PN(l).Hdr_Id AND Qlt_Pck_Thop_No_Thue.Fnc_Ttoan(vt_PN(i).Ma_Gdich,vt_Pn(l).Ma_Gdich,vt_Pn(i).Loai_Qdinh))
                                OR (vt_PN(i).Loai_Qdinh = vt_PN(l).Loai_Qdinh AND vt_PN(i).Qdinh_Id = vt_PN(l).Qdinh_Id)
                                ) THEN
                                        IF vt_PN(i).Han_Nop > vt_PN(l).KyTp_Tu_Ngay THEN
                                            vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                            vt_PN(l).CHK_KNO:='1';
                                        END IF;

                                IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                   vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                   vt_PN(i).phai_nop:=0;
                                   EXIT;
                                ELSE
                                   vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                   vt_PN(l).phai_nop:=0;
                                   l:=l+1;
                                END IF;
                            ELSE
                                l:=l+1;
                            END IF;
                        END LOOP;
                        --Thanh toan theo ky
                        IF(vt_PN(i).Ky_ttoan_tu_ngay IS NOT NULL) THEN
                            l:=v_kno_index;
                            WHILE (l<=v_kno_num) LOOP
                                IF (vt_PN(l).phai_nop>0 AND vt_PN(i).Ma_Gdich <> 'B4' AND vt_PN(l).Ma_Gdich <> 'I3')
                                    AND vt_PN(i).ky_ttoan_tu_ngay<=vt_PN(l).ky_ttoan_tu_ngay
                                    AND vt_PN(i).ky_ttoan_den_ngay>=vt_PN(l).ky_ttoan_den_ngay
                                THEN
                                    --Neu khoan phai nop duoc thanh toan qua han==>tinh phat ncham
                                    IF vt_PN(i).Han_Nop>vt_PN(l).kytp_tu_ngay THEN
                                        vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                        vt_PN(l).CHK_KNO:='1';
                                    END IF;

                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
                                       EXIT;
                                    ELSE
                                       vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                       vt_PN(l).phai_nop:=0;
                                       l:=l+1;
                                    END IF;
                                ELSE
                                    l:=l+1;
                                END IF;
                            END LOOP;
                        END IF;

                        --Thuc hien ttoan doi voi khoan da nop vt_PN(i)
                        WHILE (vt_PN(i).Phai_nop<0 AND vt_Pn(i).Ma_Gdich NOT IN('B4')) LOOP
                            --Duyet cac khoan phai nop: (Bat dau tu khoan con phai nop dau tien)
                            --Neu khoan phai nop van chua ttoan het
                            IF  (vt_PN(v_kno_index).Phai_nop>0 AND vt_Pn(v_kno_index).Ma_Gdich NOT IN('I3'))THEN
                                --So sanh han nop, tinh phat ncham
                                IF vt_PN(i).Han_Nop>vt_PN(v_kno_index).kytp_tu_ngay THEN
                                    vt_PN(v_kno_index).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(v_kno_index).CHK_KNO:='1';
                                END IF;
                                --Thanh toan
                                IF abs(vt_PN(i).phai_nop) >= vt_pn(v_kno_index).phai_nop THEN
                                    vt_PN(i).phai_nop :=vt_PN(i).phai_nop+vt_PN(v_kno_index).phai_nop;
                                    vt_PN(v_kno_index).phai_nop   :=0;
                                    --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                    v_kno_index := v_kno_index+1;
                                ELSE
                                    vt_PN(v_kno_index).phai_nop :=vt_PN(v_kno_index).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop := 0;
                                END IF;
                            ELSE
                                --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                v_kno_index := v_kno_index+1;
                            END IF;
                            EXIT WHEN (v_kno_index>v_kno_num);
                        END LOOP;
                        EXIT WHEN (v_kno_index > v_kno_num);
                        i:=i+1;
                    END LOOP;
                END IF;

                -- Thanh toan xong dua du lieu vao bang so no
                FOR i IN 1 .. v_kno_num LOOP
                    v_ten_gdich:=NULL;
                    IF vt_Pn(i).Phai_Nop >= 0 AND vt_Pn(i).Han_Nop <= Last_Day(p_den_ky) THEN
                        v_No_Dky := vt_Pn(i).No_Dau_Ky;
                    END IF;
                    FOR vc_DM_GDich IN c_DM_GDich(  vt_PN(i).ma_gdich
                                                    ,vt_PN(i).kieu_gdich
                                                    ,vt_PN(i).Ten_GDich)LOOP
                        v_ten_gdich :=  vc_DM_GDich.TEN;
                    END LOOP;
                    v_Nguon_Goc := QLT_PCK_GDICH.Fnc_Lay_Nguon_Goc_So_Lieu(
                                                    vt_pn(i).MA_GDICH
                                                    , v_Ten_GDich
                                                    , Nvl(vt_pn(i).KYKK_TU_NGAY, vt_pn(i).KYLB_TU_NGAY)
                                                    , Nvl(vt_pn(i).KYKK_DEN_NGAY, vt_pn(i).KYLB_DEN_NGAY)
                                                    , vt_pn(i).KYLB_DEN_NGAY
                                                    , 'QLT_XLTK_GDICH'
                                                    , vt_pn(i).HAN_NOP);

                    INSERT INTO EXT_QLT_NO_THANH_TOAN (
                                              TIN
                                            , HDR_ID
                                            , DTL_ID
                                            , TKHOAN
                                            , MA_CHUONG
                                            , MA_KHOAN
                                            , MA_MUC
                                            , MA_TMUC
                                            , KY_TTOAN_TU_NGAY
                                            , KY_TTOAN_DEN_NGAY
                                            , KYLB_TU_NGAY
                                            , KYLB_DEN_NGAY
                                            , KYKK_TU_NGAY
                                            , KYKK_DEN_NGAY
                                            , MA_THUE
                                            , NO_DAU_KY
                                            , PHAI_NOP
                                            , HAN_NOP
                                            , KYTP_TU_NGAY
                                            , MA_GDICH
                                            , KIEU_GDICH
                                            , TEN_GDICH
                                            , CHK_KNO
                                            , QDINH_ID
                                            , Loai_Qdinh
                                            , Nguon_Goc
                                            , id
                                            )
                                    VALUES  (
                                              vt_PN(i).TIN
                                            , vt_PN(i).HDR_ID
                                            , vt_PN(i).DTL_ID
                                            , vt_PN(i).TKHOAN
                                            , vt_PN(i).MA_CHUONG
                                            , vt_PN(i).MA_KHOAN
                                            , vt_PN(i).MA_MUC
                                            , vt_PN(i).MA_TMUC
                                            , vt_PN(i).KY_TTOAN_TU_NGAY
                                            , vt_PN(i).KY_TTOAN_DEN_NGAY
                                            , vt_PN(i).KYLB_TU_NGAY
                                            , vt_PN(i).KYLB_DEN_NGAY
                                            , vt_PN(i).KYKK_TU_NGAY
                                            , vt_PN(i).KYKK_DEN_NGAY
                                            , vt_PN(i).MA_THUE
                                            , vt_PN(i).NO_DAU_KY
                                            , vt_PN(i).PHAI_NOP
                                            , vt_PN(i).HAN_NOP
                                            , vt_PN(i).KYTP_TU_NGAY
                                            , vt_PN(i).MA_GDICH
                                            , vt_PN(i).KIEU_GDICH
                                            , vt_PN(i).TEN_GDICH
                                            , vt_PN(i).CHK_KNO
                                            , vt_PN(i).QDINH_ID
                                            , vt_PN(i).Loai_Qdinh
                                            , v_Nguon_Goc
                                            , ext_seq.NEXTVAL
                                            );
                END LOOP;
            END;--End Prc_Thanh_Toan
        BEGIN
            --Khoi tao gia tri bien dem so luong phan tu mang vt_PN(i)
            k:=0;
            FOR v_dtnt IN c_PHAI_NOP LOOP
                --Neu gap tap du lieu moi, thuc hien thanh toan tren tap du lieu da cap nhat vao mang
                IF    (v_last_tin<>'HHHHHHHHHHHHHH')
                    AND (k > 0)
                    AND (   (v_dtnt.tin     <>  v_last_tin)
                                                    OR  (v_dtnt.tkhoan  <>  v_last_tkhoan)
                                                    OR  (v_dtnt.ma_muc  <>  v_last_muc)
                                                    OR  (v_dtnt.ma_tmuc <>  v_last_tmuc)
                                                    )THEN
                    --Thuc hien ttoan,tinh phat ncham, cap nhat du lieu so no
                    PRC_THANH_TOAN;
                    k:=0;
                END IF;
                -- Gan vao mang
                k := k+1;
                vt_PN(k) := v_dtnt;
                -- Cap nhat cac gia tri kiem tra v_last_TIN, v_Last_Ma_Muc,...
                v_last_tin := v_dtnt.tin;
                v_last_tkhoan := v_dtnt.tkhoan;
                v_last_muc := v_dtnt.ma_muc;
                v_last_tmuc := v_dtnt.ma_tmuc;
            END LOOP; -- danop

            --Thuc hien thanh toan tren tap du lieu cuoi cung trong con tro c_Phai_Nop
            IF(k>0)THEN
                PRC_THANH_TOAN;
            END IF;
        END;
    BEGIN
        Prc_THop_No_Thue(p_ky_no);
    END;
END;


-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_XL_NO



-- End of DDL Script for Package Body QLT_OWNER.EXT_PCK_QLT_XL_NO

