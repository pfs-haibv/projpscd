-- Start of DDL Script for View TEST.VW_BC_01PNN
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_01pnn (
   stt,
   tax_model,
   ma_tmuc,
   sotien,
   sl )
AS
SELECT Decode(stt_ma_tmuc,1,NULL,rownum) stt, 'PNN-APP' tax_model, ma_tmuc, SOTIEN, SL
FROM (
SELECT GROUPING(a.ma_tmuc) stt_ma_tmuc,
       DECODE(GROUPING(a.ma_tmuc), 0, max(ma_tmuc),1, 'Tæng tiÓu môc') ma_tmuc,
       trim(to_char(sum(sthue_pnop),'999,999,999,999,999')) SOTIEN,
       count(1) SL
  FROM tb_tk_sddpnn a
 WHERE a.short_name=userenv('client_info') and a.ma_loai_tk = '01'
 GROUP BY cube (a.ma_tmuc)
 ORDER BY GROUPING(a.ma_tmuc), a.ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_BC_01PNN

-- Start of DDL Script for View TEST.VW_BC_02PNN
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_02pnn (
   stt,
   tax_model,
   ma_tmuc,
   sotien,
   sl )
AS
SELECT Decode(stt_ma_tmuc,1,NULL,rownum) stt, 'PNN-APP' tax_model, ma_tmuc, SOTIEN, SL
FROM (
SELECT GROUPING(a.ma_tmuc) stt_ma_tmuc,
       DECODE(GROUPING(a.ma_tmuc), 0, max(ma_tmuc),1, 'Tæng tiÓu môc') ma_tmuc,
       trim(to_char(sum(sthue_pnop),'999,999,999,999,999')) SOTIEN,
       count(1) SL
  FROM tb_tk_sddpnn a
 WHERE a.short_name=userenv('client_info') and a.ma_loai_tk = '02'
 GROUP BY cube (a.ma_tmuc)
 ORDER BY GROUPING(a.ma_tmuc), a.ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_BC_02PNN

-- Start of DDL Script for View TEST.VW_BC_CKT
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_ckt (
   stt,
   tax_model,
   ma_tkhai,
   ten_tkhai,
   sotien,
   sl )
AS
SELECT Decode(stt_ma_tkhai,1,NULL,rownum) stt, tax_model, ma_tkhai, ten_tkhai, sotien, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.ma_tkhai) stt_ma_tkhai,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.ma_tkhai), 1, 'Tæng theo tê khai', a.ma_tkhai) ma_tkhai,
       DECODE(GROUPING(a.ma_tkhai)+GROUPING(a.tax_model), 0, max(ten_tkhai),
                                                          1, 'TÊt c¶ tê khai',
                                                          2, ' ') ten_tkhai,
       trim(to_char(sum(a.so_tien),'999,999,999,999,999')) sotien,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_con_kt a, tb_lst_tkhai b
 WHERE a.ma_tkhai_tms=b.ma_tkhai_tms
   AND a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.ma_tkhai)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.ma_tkhai)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.ma_tkhai), substr(a.tax_model,1,3) desc, GROUPING(a.ma_tkhai), substr(a.tax_model,-3), max(b.ten_tkhai)
)
/

-- End of DDL Script for View TEST.VW_BC_CKT

-- Start of DDL Script for View TEST.VW_BC_DKNTK
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_dkntk (
   stt,
   tax_model,
   ma_tkhai,
   ten_tkhai,
   sl )
AS
SELECT Decode(stt_ma_tkhai,1,NULL,rownum) stt, tax_model, ma_tkhai, ten_tkhai, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.ma_tkhai) stt_ma_tkhai,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.ma_tkhai), 1, 'Tæng theo tê khai', a.ma_tkhai) ma_tkhai,
       DECODE(GROUPING(a.ma_tkhai)+GROUPING(a.tax_model), 0, max(ten_tkhai),
                                                          1, 'TÊt c¶ tê khai',
                                                          2, ' ') ten_tkhai,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_dkntk a, tb_lst_tkhai b
 WHERE a.mau_tkhai_tms=b.ma_tkhai_tms
   AND a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.ma_tkhai)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.ma_tkhai)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.ma_tkhai), substr(a.tax_model,1,3) desc, GROUPING(a.ma_tkhai), substr(a.tax_model,-3), max(b.ten_tkhai)
)
/

-- End of DDL Script for View TEST.VW_BC_DKNTK

-- Start of DDL Script for View TEST.VW_BC_NO
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_no (
   stt,
   tax_model,
   tmt_ma_tmuc,
   so_no,
   so_pnop,
   sl )
AS
SELECT Decode(stt_ma_tmuc,1,NULL,rownum) stt, tax_model, tmt_ma_tmuc, so_no, so_pnop, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.tmt_ma_tmuc) stt_ma_tmuc,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.tmt_ma_tmuc)+GROUPING(a.tax_model), 0, max(tmt_ma_tmuc),
                                                          1, 'Tæng tiÓu môc',
                                                          2, ' ') tmt_ma_tmuc,
       trim(to_char(sum(decode(a.so_tien-abs(a.so_tien), 0, a.so_tien, 0)),'999,999,999,999,999')) so_no,
       trim(to_char(sum(decode(a.so_tien-abs(a.so_tien), 0, 0, a.so_tien)),'999,999,999,999,999')) so_pnop,
       count(1) SL
  FROM tb_no a
 WHERE a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.tmt_ma_tmuc)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.tmt_ma_tmuc)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.tmt_ma_tmuc), substr(a.tax_model,1,3) desc, GROUPING(a.tmt_ma_tmuc), substr(a.tax_model,-3), a.tmt_ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_BC_NO

-- Start of DDL Script for View TEST.VW_BC_NO2
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_no2 (
   stt,
   tax_model,
   tmt_ma_tmuc,
   so_no,
   so_pnop,
   sl )
AS
SELECT Decode(stt_ma_tmuc,1,NULL,rownum) stt, tax_model, tmt_ma_tmuc, so_no, so_pnop, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.tmt_ma_tmuc) stt_ma_tmuc,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.tmt_ma_tmuc)+GROUPING(a.tax_model), 0, max(tmt_ma_tmuc),
                                                          1, 'Tæng tiÓu môc',
                                                          2, ' ') tmt_ma_tmuc,
       DECODE(GROUPING(a.tmt_ma_tmuc)+GROUPING(a.tax_model), 0, max(tmt_ma_tmuc),
                                                          1, '9998',
                                                          2, '9999') sort_tmuc,
       trim(to_char(sum(decode(a.so_tien-abs(a.so_tien), 0, a.so_tien, 0)),'999,999,999,999,999')) so_no,
       trim(to_char(sum(decode(a.so_tien-abs(a.so_tien), 0, 0, a.so_tien)),'999,999,999,999,999')) so_pnop,
       count(1) SL
  FROM tb_no a
 WHERE a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.tmt_ma_tmuc)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.tmt_ma_tmuc)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.tmt_ma_tmuc), a.tmt_ma_tmuc, substr(a.tax_model,1,3) desc, substr(a.tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_BC_NO2

-- Start of DDL Script for View TEST.VW_BC_PS
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_ps (
   stt,
   tax_model,
   ma_tkhai,
   ten_tkhai,
   sotien,
   sl )
AS
SELECT Decode(stt_ma_tkhai,1,NULL,rownum) stt, tax_model, ma_tkhai, ten_tkhai, sotien, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.ma_tkhai) stt_ma_tkhai,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.ma_tkhai), 1, 'Tæng theo tê khai', a.ma_tkhai) ma_tkhai,
       DECODE(GROUPING(a.ma_tkhai)+GROUPING(a.tax_model), 0, max(ten),
                                                          1, 'TÊt c¶ tê khai',
                                                          2, ' ') ten_tkhai,
       trim(to_char(sum(a.so_tien),'999,999,999,999,999')) sotien,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_ps a, vw_tkhai_tms b
 WHERE a.ma_tkhai_tms=b.ma_tms
   AND a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.ma_tkhai)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.ma_tkhai)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.ma_tkhai), substr(a.tax_model,1,3) desc, GROUPING(a.ma_tkhai), substr(a.tax_model,-3), max(b.ten)
)
/

-- End of DDL Script for View TEST.VW_BC_PS

-- Start of DDL Script for View TEST.VW_BC_PS2
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_ps2 (
   stt,
   tax_model,
   ma_tkhai,
   ten_tkhai,
   sotien,
   sl )
AS
SELECT DECODE(stt_ma_tkhai,1,NULL,rownum) stt, tax_model, ma_tkhai, ten_tkhai, sotien, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.ma_tkhai) stt_ma_tkhai,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.ma_tkhai), 1, 'Tæng theo tê khai', a.ma_tkhai) ma_tkhai,
       DECODE(GROUPING(a.ma_tkhai)+GROUPING(a.tax_model), 0, max(a.ma_tkhai_tms),
                                                          1, '9998',
                                                          2, '9999') ma_tms,
       DECODE(GROUPING(a.ma_tkhai)+GROUPING(a.tax_model), 0, max(ten_tkhai),
                                                          1, 'TÊt c¶ tê khai',
                                                          2, ' ') ten_tkhai,
       trim(to_char(sum(a.so_tien),'999,999,999,999,999')) sotien,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_ps a, tb_lst_tkhai b
 WHERE a.ma_tkhai_tms=b.ma_tkhai_tms
   AND a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model, a.ma_tkhai)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.ma_tkhai)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.ma_tkhai), max(b.ten_tkhai), substr(a.tax_model,1,3) desc, substr(a.tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_BC_PS2

-- Start of DDL Script for View TEST.VW_BC_TCNO
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_tcno (
   stt,
   tax_model,
   ten_tcno,
   so_no,
   sl )
AS
SELECT Decode(stt_ma_tc,1,NULL,rownum) stt, tax_model, ten_tcno, so_no, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.tinh_chat) stt_ma_tc,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       DECODE(GROUPING(a.tinh_chat)+GROUPING(a.tax_model), 0, max(ten_tchat),
                                                          1, 'TÊt c¶ tÝnh chÊt',
                                                          2, ' ') ten_tcno,
       trim(to_char(sum(a.so_tien),'999,999,999,999,999')) so_no,
       trim(to_char(count(1),'999,999,999,999,999')) SL
 FROM   tb_no a, tb_dmuc_tchat_no b
 WHERE  a.short_name=userenv('client_info') 
        and a.tinh_chat = b.ma
        and a.so_tien > 0 
        and a.tinh_chat is not null
 GROUP BY cube (a.tax_model, a.tinh_chat)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.tinh_chat)=0)
 ORDER BY GROUPING(a.tax_model), 
          GROUPING(a.tinh_chat),
          substr(a.tax_model,1,3) desc,
          GROUPING(a.tinh_chat),
          substr(a.tax_model,-3),
          a.tinh_chat
)
/

-- End of DDL Script for View TEST.VW_BC_TCNO

-- Start of DDL Script for View TEST.VW_BC_TKH
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_tkh (
   stt,
   tax_model,
   doanhthu,
   gttt,
   thuepn,
   sl )
AS
SELECT Null STT, tax_model,DoanhThu,GTTT, ThuePN, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,       
       trim(to_char(sum(NVL(a.doanh_thu_ts_5,0) + NVL(a.doanh_thu_ts_10,0)),'999,999,999,999,999')) DoanhThu,
       trim(to_char(sum(NVL(a.gtgt_chiu_thue_ts_5,0) + NVL(a.gtgt_chiu_thue_ts_10,0)),'999,999,999,999,999')) GTTT,
       trim(to_char(sum(NVL(a.thue_gtgt_ts_5,0) + NVL(a.thue_gtgt_ts_10,0)),'999,999,999,999,999')) ThuePN,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_01_thkh_hdr a
 WHERE a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model)
 having NOT GROUPING(a.tax_model)=1 
 ORDER BY GROUPING(a.tax_model), substr(a.tax_model,1,3) desc, substr(a.tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_BC_TKH

-- Start of DDL Script for View TEST.VW_BC_TKMB
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_tkmb (
   stt,
   tax_model,
   bac_mbai,
   ten_bac,
   sotien,
   sl )
AS
SELECT Decode(stt_bmb,1,NULL,rownum) stt, tax_model, bac_mbai, ten_bac, sotien, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, GROUPING(a.bmb_nnt_tms) stt_bmb,
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,       
       DECODE(GROUPING(a.bmb_nnt_tms), 1, 'Tæng theo bËc m«n bµi', a.bmb_nnt_tms) bac_mbai,
       DECODE(GROUPING(a.bmb_nnt_tms)+GROUPING(a.tax_model), 0, max(b.ten),
                                                          1, 'TÊt c¶ bËc m«n bµi',
                                                          2, ' ') ten_bac,
       trim(to_char(sum(a.tong_thue_pn_nnt),'999,999,999,999,999')) sotien,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_tkmb_hdr a, tb_dmuc_bac_mbai b
 WHERE a.short_name=userenv('client_info')
    and a.bmb_nnt_tms = b.ma and b.tax_model = 'TMS-APP'
 GROUP BY cube (a.tax_model, a.bmb_nnt_tms)
 having NOT (GROUPING(a.tax_model)=1 AND GROUPING(a.bmb_nnt_tms)=0)
 ORDER BY GROUPING(a.tax_model), GROUPING(a.bmb_nnt_tms), substr(a.tax_model,1,3) desc,
  GROUPING(a.bmb_nnt_tms), substr(a.tax_model,-3), max(a.bmb_nnt_tms)
)
/

-- End of DDL Script for View TEST.VW_BC_TKMB

-- Start of DDL Script for View TEST.VW_BC_TPHAT
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_bc_tphat (
   stt,
   tax_model,
   sotien,
   sl )
AS
SELECT null STT, tax_model, sotien, SL
FROM (
SELECT GROUPING(a.tax_model) stt_tax_model, 
       DECODE(GROUPING(a.tax_model), 1, 'Tæng céng', a.tax_model) tax_model,
       trim(to_char(sum(a.so_tien),'999,999,999,999,999')) sotien,
       trim(to_char(count(1),'999,999,999,999,999')) SL
  FROM tb_tinh_phat a
 WHERE a.short_name=userenv('client_info')
 GROUP BY cube (a.tax_model)
 having NOT (GROUPING(a.tax_model)=1)
 ORDER BY GROUPING(a.tax_model), 
          substr(a.tax_model,1,3) desc,
          substr(a.tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_BC_TPHAT

-- Start of DDL Script for View TEST.VW_CD_01PNN
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_01pnn (
   tax_model,
   ma_tmuc,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   ma_tkhai,
   ngay_nop_tk,
   sthue_pnop,
   msg_no,
   err_name )
AS
SELECT tax_model, ma_tmuc, tin, kytt_tu_ngay, kytt_den_ngay, ma_tkhai, ngay_nop_tk,
       trim(to_char(sthue_pnop,'999,999,999,999')) sthue_pnop,       
       msg_no, err_name
  FROM vw_cd_01pnn_tmp
UNION ALL
SELECT tax_model, ma_tmuc, tin, kytt_tu_ngay, kytt_den_ngay, ma_tkhai, ngay_nop_tk,
       sthue_pnop, msg_no, err_name
FROM 
(       
SELECT tax_model, ma_tmuc, to_char(NULL) tin,
       to_char(NULL) kytt_tu_ngay, to_char(NULL) kytt_den_ngay,
       to_char(NULL) ma_tkhai,  to_char(NULL) ngay_nop_tk,
       trim(to_char(sum(sthue_pnop),'999,999,999,999')) sthue_pnop,
       to_char(NULL) msg_no, to_char(NULL) err_name
  FROM vw_cd_01pnn_tmp
 GROUP BY cube(tax_model, ma_tmuc) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(ma_tmuc)=0)
 ORDER BY GROUPING(tax_model), GROUPING(ma_tmuc), substr(tax_model,1,3) DESC, GROUPING(ma_tmuc), substr(tax_model,-3), ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_CD_01PNN

-- Start of DDL Script for View TEST.VW_CD_01PNN_TMP
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_01pnn_tmp (
   tax_model,
   ma_tmuc,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   ma_tkhai,
   ngay_nop_tk,
   sthue_pnop,
   msg_no,
   err_name )
AS
(
SELECT 'PNN-APP' tax_model, a.ma_tmuc, a.nnt_tin tin, a.kytt_tu_ngay,
       a.kytt_den_ngay, a.ma_tkhai, a.ngay_nop_tk,
       a.sthue_pnop,
       NULL msg_no,
       a.err_des err_name
  FROM tb_tk_sddpnn a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
   AND a.ma_loai_tk = '01'
)
/

-- End of DDL Script for View TEST.VW_CD_01PNN_TMP

-- Start of DDL Script for View TEST.VW_CD_02PNN
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_02pnn (
   tax_model,
   ma_tmuc,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   ma_tkhai,
   ngay_nop_tk,
   sthue_pnop,
   msg_no,
   err_name )
AS
SELECT tax_model, ma_tmuc, tin, kytt_tu_ngay, kytt_den_ngay, ma_tkhai, ngay_nop_tk,
       trim(to_char(sthue_pnop,'999,999,999,999')) sthue_pnop,       
       msg_no, err_name
  FROM vw_cd_02pnn_tmp
UNION ALL
SELECT tax_model, ma_tmuc, tin, kytt_tu_ngay, kytt_den_ngay, ma_tkhai, ngay_nop_tk,
       sthue_pnop, msg_no, err_name
FROM 
(       
SELECT tax_model, ma_tmuc, to_char(NULL) tin,
       to_char(NULL) kytt_tu_ngay, to_char(NULL) kytt_den_ngay,
       to_char(NULL) ma_tkhai,  to_char(NULL) ngay_nop_tk,
       trim(to_char(sum(sthue_pnop),'999,999,999,999')) sthue_pnop,
       to_char(NULL) msg_no, to_char(NULL) err_name
  FROM vw_cd_02pnn_tmp
 GROUP BY cube(tax_model, ma_tmuc) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(ma_tmuc)=0)
 ORDER BY GROUPING(tax_model), GROUPING(ma_tmuc), substr(tax_model,1,3) DESC, GROUPING(ma_tmuc), substr(tax_model,-3), ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_CD_02PNN

-- Start of DDL Script for View TEST.VW_CD_02PNN_TMP
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_02pnn_tmp (
   tax_model,
   ma_tmuc,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   ma_tkhai,
   ngay_nop_tk,
   sthue_pnop,
   msg_no,
   err_name )
AS
(
SELECT 'PNN-APP' tax_model, a.ma_tmuc, a.nnt_tin tin, a.kytt_tu_ngay,
       a.kytt_den_ngay, a.ma_tkhai, a.ngay_nop_tk,
       a.sthue_pnop,
       NULL msg_no,
       a.err_des err_name
  FROM tb_tk_sddpnn a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
   AND a.ma_loai_tk = '02'
)
/

-- End of DDL Script for View TEST.VW_CD_02PNN_TMP

-- Start of DDL Script for View TEST.VW_CD_CCTT
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_cctt (
   tax_model,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   doanh_thu,
   gt_tinh_thue,
   thue_pn,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, tin, kytt_tu_ngay, kytt_den_ngay, 
       trim(to_char(doanh_thu,'999,999,999,999')) doanh_thu,
       trim(to_char(gt_tinh_thue,'999,999,999,999')) gt_tinh_thue,
       trim(to_char(Thue_PN,'999,999,999,999')) Thue_PN,
       msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_cctt_tmp
UNION ALL
SELECT tax_model, tin, kytt_tu_ngay, kytt_den_ngay,  doanh_thu,gt_tinh_thue,Thue_PN ,  msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(
SELECT tax_model, to_char(NULL) tin, to_char(NULL) kytt_tu_ngay, to_char(NULL) kytt_den_ngay, 
       trim(to_char(sum(doanh_thu),'999,999,999,999')) doanh_thu, 
       trim(to_char(sum(gt_tinh_thue),'999,999,999,999')) gt_tinh_thue, 
       trim(to_char(sum(Thue_PN),'999,999,999,999')) Thue_PN, 
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_cctt_tmp
 GROUP BY cube(tax_model) HAVING NOT (GROUPING(tax_model)=1 )
 ORDER BY GROUPING(tax_model),  substr(tax_model,1,3) DESC,  substr(tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_CD_CCTT

-- Start of DDL Script for View TEST.VW_CD_CCTT_TMP
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_cctt_tmp (
   short_name,
   tax_model,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   doanh_thu,
   gt_tinh_thue,
   thue_pn,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.short_name, a.tax_model, a.tin, a.kytt_tu_ngay,
       a.kytt_den_ngay,
       (nvl(a.doanh_thu_ts_5,0) + nvl(a.doanh_thu_ts_10,0)) doanh_thu,
       (nvl(a.gtgt_chiu_thue_ts_5,0) + nvl(a.gtgt_chiu_thue_ts_10,0)) gt_tinh_thue,
       (nvl(a.thue_gtgt_ts_5,0) + nvl(a.thue_gtgt_ts_10,0)) Thue_PN,
       NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_01_thkh_hdr a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
)
/

-- End of DDL Script for View TEST.VW_CD_CCTT_TMP

-- Start of DDL Script for View TEST.VW_CD_CKT
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_ckt (
   tax_model,
   mau_tkhai,
   tin,
   kykk_tu_ngay,
   kykk_den_ngay,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, mau_tkhai, tin, kykk_tu_ngay,kykk_den_ngay,
       trim(to_char(so_tien,'999,999,999,999')) so_tien,      
       msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_ckt_tmp
UNION ALL
SELECT tax_model, mau_tkhai, tin, kykk_tu_ngay,kykk_den_ngay, so_tien, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(
SELECT tax_model, to_char(NULL) mau_tkhai, to_char(NULL) tin, to_char(NULL) kykk_tu_ngay, to_char(NULL) kykk_den_ngay,
       trim(to_char(sum(so_tien),'999,999,999,999')) so_tien, 
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_ckt_tmp
 GROUP BY cube(tax_model) HAVING NOT (GROUPING(tax_model)=1 )
 ORDER BY GROUPING(tax_model),  substr(tax_model,1,3) DESC,  substr(tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_CD_CKT

-- Start of DDL Script for View TEST.VW_CD_CKT_TMP
-- Generated 3-Oct-2013 16:30:49 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_ckt_tmp (
   short_name,
   tax_model,
   mau_tkhai,
   tin,
   kykk_tu_ngay,
   kykk_den_ngay,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.short_name, a.tax_model, mau_tkhai, a.tin, a.kykk_tu_ngay,
       a.kykk_den_ngay,
       a.so_tien,
       NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_con_kt a , vw_tkhai_tms b
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
   AND a.ma_tkhai_tms=b.ma_tms
)
/

-- End of DDL Script for View TEST.VW_CD_CKT_TMP

-- Start of DDL Script for View TEST.VW_CD_DKNTK
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_dkntk (
   tax_model,
   ma_tkhai,
   tin,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, ma_tkhai, tin, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_dkntk_tmp
/

-- End of DDL Script for View TEST.VW_CD_DKNTK

-- Start of DDL Script for View TEST.VW_CD_DKNTK_OLD
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_dkntk_old (
   tax_model,
   ma_tkhai,
   tin,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, ma_tkhai, tin, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_dkntk_tmp
UNION ALL
SELECT tax_model, ma_tkhai, tin, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(
SELECT tax_model, ma_tkhai, to_char(NULL) tin, 
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_dkntk_tmp
 GROUP BY cube(tax_model, ma_tkhai) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(ma_tkhai)=0)
 ORDER BY GROUPING(tax_model), GROUPING(ma_tkhai), substr(tax_model,1,3) DESC, GROUPING(ma_tkhai), substr(tax_model,-3), ma_tkhai
)
/

-- End of DDL Script for View TEST.VW_CD_DKNTK_OLD

-- Start of DDL Script for View TEST.VW_CD_DKNTK_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_dkntk_tmp (
   short_name,
   tax_model,
   tin,
   ma_tkhai,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.short_name, a.tax_model, a.tin, ma_tkhai,  NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_dkntk a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )

)
/

-- End of DDL Script for View TEST.VW_CD_DKNTK_TMP

-- Start of DDL Script for View TEST.VW_CD_NO
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_no (
   tax_model,
   tmt_ma_tmuc,
   tin,
   ngay_htoan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   so_duong,
   so_am,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, tmt_ma_tmuc, tin, NGAY_HTOAN, kykk_tu_ngay, kykk_den_ngay, han_nop,
       trim(to_char(so_duong,'999,999,999,999')) so_duong,
       trim(to_char(so_am,'999,999,999,999')) so_am,
       msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_no_tmp
UNION ALL
SELECT tax_model, tmt_ma_tmuc, tin, ngay_hach_toan, kykk_tu_ngay, kykk_den_ngay, han_nop,
       so_duong, so_am, msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(       
SELECT tax_model, tmt_ma_tmuc, to_char(NULL) tin, to_char(NULL) ngay_hach_toan, 
       to_char(NULL) kykk_tu_ngay, to_char(NULL) kykk_den_ngay, to_char(NULL) han_nop,
       trim(to_char(sum(so_duong),'999,999,999,999')) so_duong,
       trim(to_char(sum(so_am),'999,999,999,999')) so_am,
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_no_tmp
 GROUP BY cube(tax_model, tmt_ma_tmuc) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(tmt_ma_tmuc)=0)
 ORDER BY GROUPING(tax_model), GROUPING(tmt_ma_tmuc), substr(tax_model,1,3) DESC, GROUPING(tmt_ma_tmuc), substr(tax_model,-3), tmt_ma_tmuc
)
/

-- End of DDL Script for View TEST.VW_CD_NO

-- Start of DDL Script for View TEST.VW_CD_NO_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_no_tmp (
   tax_model,
   tmt_ma_tmuc,
   tin,
   ngay_htoan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   so_duong,
   so_am,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.tax_model, a.tmt_ma_tmuc, a.tin, a.ngay_htoan, a.kykk_tu_ngay,
       a.kykk_den_ngay, a.han_nop,
       DECODE (a.so_tien - ABS (a.so_tien),
               0, a.so_tien,
               0
              ) so_duong,
       DECODE (a.so_tien - ABS (a.so_tien), 0, 0, a.so_tien) so_am,
       NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_no a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
       )
/

-- End of DDL Script for View TEST.VW_CD_NO_TMP

-- Start of DDL Script for View TEST.VW_CD_PS
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_ps (
   tax_model,
   ma_tkhai,
   tin,
   ky_psinh_tu,
   ky_psinh_den,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, ma_tkhai, tin, ky_psinh_tu, ky_psinh_den, 
       trim(to_char(so_tien,'999,999,999,999')) so_tien, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_ps_tmp
UNION ALL
SELECT tax_model, ma_tkhai, tin, ky_psinh_tu, ky_psinh_den, so_tien, msg_no, err_name,
       ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(
SELECT tax_model, ma_tkhai, to_char(NULL) tin, to_char(NULL) ky_psinh_tu, to_char(NULL) ky_psinh_den, 
       trim(to_char(sum(so_tien),'999,999,999,999')) so_tien, 
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_ps_tmp
 GROUP BY cube(tax_model, ma_tkhai) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(ma_tkhai)=0)
 ORDER BY GROUPING(tax_model), GROUPING(ma_tkhai), substr(tax_model,1,3) DESC, GROUPING(ma_tkhai), substr(tax_model,-3), ma_tkhai
)
/

-- End of DDL Script for View TEST.VW_CD_PS

-- Start of DDL Script for View TEST.VW_CD_PS_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_ps_tmp (
   short_name,
   tax_model,
   tin,
   ma_tkhai,
   ky_psinh_tu,
   ky_psinh_den,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.short_name, a.tax_model, a.tin, b.mau_tkhai MA_TKHAI, a.kykk_tu_ngay,
       a.kykk_den_ngay, a.so_tien, NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_ps a, vw_tkhai_tms b
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
   AND a.ma_tkhai_tms=b.ma_tms

)
/

-- End of DDL Script for View TEST.VW_CD_PS_TMP

-- Start of DDL Script for View TEST.VW_CD_TC_NO
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tc_no (
   tax_model,
   tmt_ma_tmuc,
   tin,
   ngay_htoan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   ten_tc,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, tmt_ma_tmuc, tin, NGAY_HTOAN, kykk_tu_ngay, kykk_den_ngay, han_nop, TEN_TC, 
       trim(to_char(so_tien,'999,999,999,999')) so_tien,
       msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_tc_no_tmp
UNION ALL
SELECT tax_model, tmt_ma_tmuc, tin, ngay_hach_toan, kykk_tu_ngay, kykk_den_ngay, han_nop, TEN_TC, 
       so_tien, msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(       
SELECT tax_model, to_char(NULL) tmt_ma_tmuc, to_char(NULL) tin, to_char(NULL) ngay_hach_toan, 
       to_char(NULL) kykk_tu_ngay, to_char(NULL) kykk_den_ngay, to_char(NULL) han_nop, max(TEN_TC) TEN_TC,
       trim(to_char(sum(so_tien),'999,999,999,999')) so_tien,
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_tc_no_tmp
 GROUP BY cube(tax_model, TINH_CHAT) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(TINH_CHAT)=0)
 ORDER BY GROUPING(tax_model), GROUPING(TINH_CHAT), substr(tax_model,1,3) DESC, GROUPING(TINH_CHAT), substr(tax_model,-3), TINH_CHAT
)
/

-- End of DDL Script for View TEST.VW_CD_TC_NO

-- Start of DDL Script for View TEST.VW_CD_TC_NO_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tc_no_tmp (
   tax_model,
   tmt_ma_tmuc,
   tin,
   ngay_htoan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   tinh_chat,
   ten_tc,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.tax_model, a.tmt_ma_tmuc, a.tin, a.ngay_htoan, a.kykk_tu_ngay,
       a.kykk_den_ngay, a.han_nop, tc_no_tms TINH_CHAT, ten_tchat TEN_TC,
       a.so_tien, 
       NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_no a, tb_dmuc_tchat_no b
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
  AND a.so_tien > 0 
  AND a.tc_no_tms is not null
  and a.tinh_chat = b.ma

)
/

-- End of DDL Script for View TEST.VW_CD_TC_NO_TMP

-- Start of DDL Script for View TEST.VW_CD_TKMB
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tkmb (
   tax_model,
   bmb_nnt_tms,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   han_nop,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
SELECT tax_model, bmb_nnt_tms, tin, kytt_tu_ngay, kytt_den_ngay, han_nop,
       trim(to_char(so_tien,'999,999,999,999')) so_tien,       
       msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
  FROM vw_cd_tkmb_tmp
UNION ALL
SELECT tax_model, bmb_nnt_tms, tin, kytt_tu_ngay, kytt_den_ngay, han_nop,
       so_tien, msg_no, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban
FROM 
(       
SELECT tax_model, bmb_nnt_tms, to_char(NULL) tin, 
       to_char(NULL) kytt_tu_ngay, to_char(NULL) kytt_den_ngay, to_char(NULL) han_nop,
       trim(to_char(sum(so_tien),'999,999,999,999')) so_tien,       
       to_char(NULL) msg_no, to_char(NULL) err_name,
       to_char(NULL) ma_cbo, to_char(NULL) ten_cbo, to_char(NULL) ma_pban, to_char(NULL) ten_pban
  FROM vw_cd_tkmb_tmp
 GROUP BY cube(tax_model, bmb_nnt_tms) HAVING NOT (GROUPING(tax_model)=1 AND GROUPING(bmb_nnt_tms)=0)
 ORDER BY GROUPING(tax_model), GROUPING(bmb_nnt_tms), substr(tax_model,1,3) DESC, GROUPING(bmb_nnt_tms), substr(tax_model,-3), bmb_nnt_tms
)
/

-- End of DDL Script for View TEST.VW_CD_TKMB

-- Start of DDL Script for View TEST.VW_CD_TKMB_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tkmb_tmp (
   tax_model,
   bmb_nnt_tms,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   han_nop,
   so_tien,
   msg_no,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban )
AS
(
SELECT a.tax_model, b.ten bmb_nnt_tms, a.tin, a.kytt_tu_ngay,
       a.kytt_den_ngay, a.han_nop,
       a.tong_thue_pn_nnt so_tien,
       NULL msg_no,
       a.err_des err_name,
       a.ma_cbo,
       a.ten_cbo, a.ma_pban, a.ten_pban
  FROM tb_tkmb_hdr a, tb_dmuc_bac_mbai b
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )
   and a.bmb_nnt_tms = b.ma and b.tax_model = 'TMS-APP'
)
/

-- End of DDL Script for View TEST.VW_CD_TKMB_TMP

-- Start of DDL Script for View TEST.VW_CD_TPHAT
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tphat (
   tax_model,
   tin,
   han_nop,
   so_tien,
   msg_no,
   err_name )
AS
SELECT tax_model, tin, han_nop,
       trim(to_char(so_tien,'999,999,999,999')) so_tien,
       msg_no, err_name
  FROM vw_cd_tphat_tmp
UNION ALL
SELECT tax_model, tin, han_nop,
       so_tien, msg_no, err_name
FROM 
(       
SELECT tax_model, to_char(NULL) tin, to_char(NULL) han_nop,
       trim(to_char(sum(so_tien),'999,999,999,999')) so_tien,
       to_char(NULL) msg_no, to_char(NULL) err_name
  FROM vw_cd_tphat_tmp
 GROUP BY cube(tax_model) HAVING NOT (GROUPING(tax_model)=1)
 ORDER BY GROUPING(tax_model), substr(tax_model,1,3) DESC, substr(tax_model,-3)
)
/

-- End of DDL Script for View TEST.VW_CD_TPHAT

-- Start of DDL Script for View TEST.VW_CD_TPHAT_TMP
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_cd_tphat_tmp (
   tax_model,
   tin,
   han_nop,
   so_tien,
   msg_no,
   err_name )
AS
(
SELECT a.tax_model, a.tin, a.han_nop,
       a.so_tien, 
       NULL msg_no,
       a.err_des err_name
     
  FROM TB_TINH_PHAT a
 WHERE a.status in ('E','C')
   AND (   a.short_name = USERENV ('client_info')
        OR USERENV ('client_info') IS NULL
       )

)
/

-- End of DDL Script for View TEST.VW_CD_TPHAT_TMP

-- Start of DDL Script for View TEST.VW_CT_01PNN
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_01pnn (
   stt,
   kytt_tu_ngay,
   ky_kkhai_tu_ngay,
   ngay_htoan,
   ma_tkhai,
   ltd,
   ngay_nop_tk,
   trang_thai_tk,
   ma_tmuc,
   nnt_tin,
   nnt_ten_nnt,
   nnt_ngcap_mst,
   nnt_cap,
   nnt_chuong,
   nnt_loai,
   nnt_khoan,
   nnt_ngay_sinh,
   nnt_dia_chi,
   nnt_ma_tinh,
   nnt_ten_tinh,
   nnt_ma_huyen,
   nnt_ten_huyen,
   nnt_ma_xa,
   nnt_ten_xa,
   nnt_ma_thon,
   nnt_ten_thon,
   nnt_cmnd,
   nnt_cmnd_ngay_cap,
   nnt_cmnd_noi_cap,
   thd_dia_chi,
   thd_ma_tinh,
   thd_ten_tinh,
   thd_ma_huyen,
   thd_ten_huyen,
   thd_ma_xa,
   thd_ten_xa,
   thd_ma_thon,
   thd_ten_thon,
   thd_gcn,
   thd_gcn_so,
   thd_gcn_ngay_cap,
   thd_thua_dat_so,
   thd_ban_do_so,
   thd_gcn_dien_tich,
   thd_dtich_sd_tte,
   thd_gcn_ma_md,
   thd_gcn_ten_md,
   thd_han_muc,
   thd_chua_gcn,
   thd_chua_gcn_dtich,
   thd_chua_gcn_ma_md,
   thd_chua_gcn_ten_md,
   mgi_ma_ly_do,
   mgi_ten_ly_do,
   mgi_ghi_chu,
   mgi_so_tien,
   mgi_ty_le,
   cct_dtich_sd_tte,
   cct_han_muc,
   cct_ma_loai_dat,
   cct_ten_loai_dat,
   cct_ma_duong,
   cct_ten_duong,
   cct_ma_doan_duong,
   cct_ten_doan_duong,
   cct_ma_loai_duong,
   cct_ten_loai_duong,
   cct_ma_vi_tri,
   cct_ten_vi_tri,
   cct_he_so,
   cct_ma_gia_dat,
   cct_gia_dat,
   cct_gia_1m2_dat,
   cct_co_bke,
   dato_dtich_trong_hm,
   dato_dtich_duoi3,
   dato_dtich_vuot3,
   dato_stpn,
   ccu_dtich,
   ccu_stpn,
   ccu_he_so,
   skd_dtich,
   skd_stpn,
   smd_dtich,
   smd_ma_md,
   smd_ten_md,
   smd_gia_1m2_dat,
   smd_stpn,
   lch_dtich,
   lch_ma_md,
   lch_ten_md,
   lch_gia_1m2_dat,
   lch_stpn,
   stpn_truoc_mgi,
   stpn_tong,
   stpn_clech_bsung,
   dkn_nop_5nam,
   dkn_so_tien,
   ttk_dato_stpn,
   ttk_ccu_stpn,
   ttk_skd_stpn,
   ttk_smd_stpn,
   ttk_lch_stpn,
   dlt_tin,
   dlt_ten_dlt,
   dlt_dia_chi,
   dlt_ma_tinh,
   dlt_ten_tinh,
   dlt_ma_huyen,
   dlt_ten_huyen,
   dlt_ma_xa,
   dlt_ten_xa,
   dlt_ma_thon,
   dlt_ten_thon,
   dlt_so_dt,
   dlt_so_hdong,
   dlt_ngay_hdong,
   sthue_pnop )
AS
SELECT   rownum STT,
         kytt_tu_ngay,
         ky_kkhai_tu_ngay,
         ngay_htoan,
         ma_tkhai,
         ltd,         
         ngay_nop_tk,
         trang_thai_tk,
         ma_tmuc,
         nnt_tin,
         nnt_ten_nnt,
         nnt_ngcap_mst,
         nnt_cap,
         nnt_chuong,
         nnt_loai,
         nnt_khoan,
         nnt_ngay_sinh,
         nnt_dia_chi,
         nnt_ma_tinh,
         nnt_ten_tinh,
         nnt_ma_huyen,
         nnt_ten_huyen,
         nnt_ma_xa,
         nnt_ten_xa,
         nnt_ma_thon,
         nnt_ten_thon,
         nnt_cmnd,
         nnt_cmnd_ngay_cap,
         nnt_cmnd_noi_cap,
         thd_dia_chi,
         thd_ma_tinh,
         thd_ten_tinh,
         thd_ma_huyen,
         thd_ten_huyen,
         thd_ma_xa,
         thd_ten_xa,
         thd_ma_thon,
         thd_ten_thon,
         thd_gcn,
         thd_gcn_so,
         thd_gcn_ngay_cap,
         thd_thua_dat_so,
         thd_ban_do_so,
         thd_gcn_dien_tich,
         thd_dtich_sd_tte,
         thd_gcn_ma_md,
         thd_gcn_ten_md,
         thd_han_muc,
         thd_chua_gcn,
         thd_chua_gcn_dtich,
         thd_chua_gcn_ma_md,
         thd_chua_gcn_ten_md,
         mgi_ma_ly_do,
         mgi_ten_ly_do,
         mgi_ghi_chu,
         mgi_so_tien,
         mgi_ty_le,
         cct_dtich_sd_tte,
         cct_han_muc,
         cct_ma_loai_dat,
         cct_ten_loai_dat,
         cct_ma_duong,
         cct_ten_duong,
         cct_ma_doan_duong,
         cct_ten_doan_duong,
         cct_ma_loai_duong,
         cct_ten_loai_duong,
         cct_ma_vi_tri,
         cct_ten_vi_tri,
         cct_he_so,
         cct_ma_gia_dat,
         cct_gia_dat,
         cct_gia_1m2_dat,
         cct_co_bke,
         dato_dtich_trong_hm,
         dato_dtich_duoi3,
         dato_dtich_vuot3,
         dato_stpn,
         ccu_dtich,
         ccu_stpn,
         ccu_he_so,
         skd_dtich,
         skd_stpn,
         smd_dtich,
         smd_ma_md,
         smd_ten_md,
         smd_gia_1m2_dat,
         smd_stpn,
         lch_dtich,
         lch_ma_md,
         lch_ten_md,
         lch_gia_1m2_dat,
         lch_stpn,
         stpn_truoc_mgi,
         stpn_tong,
         stpn_clech_bsung,
         dkn_nop_5nam,
         dkn_so_tien,
         ttk_dato_stpn,
         ttk_ccu_stpn,
         ttk_skd_stpn,
         ttk_smd_stpn,
         ttk_lch_stpn,
         dlt_tin,
         dlt_ten_dlt,
         dlt_dia_chi,
         dlt_ma_tinh,
         dlt_ten_tinh,
         dlt_ma_huyen,
         dlt_ten_huyen,
         dlt_ma_xa,
         dlt_ten_xa,
         dlt_ma_thon,
         dlt_ten_thon,
         dlt_so_dt,
         dlt_so_hdong,
         dlt_ngay_hdong,
         sthue_pnop
    FROM   (SELECT    
         b.kytt_tu_ngay,
         b.ky_kkhai_tu_ngay,
         b.ngay_htoan,
         b.ma_tkhai,
         b.ltd,
         b.ngay_nop_tk,
         b.trang_thai_tk,
         b.ma_tmuc,
         b.nnt_tin,
         b.nnt_ten_nnt,
         b.nnt_ngcap_mst,
         b.nnt_cap,
         b.nnt_chuong,
         b.nnt_loai,
         b.nnt_khoan,
         b.nnt_ngay_sinh,
         b.nnt_dia_chi,
         b.nnt_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.nnt_ma_tinh)
             nnt_ten_tinh,
         b.nnt_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.nnt_ma_huyen)
             nnt_ten_huyen,
         b.nnt_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.nnt_ma_xa)
             nnt_ten_xa,
         b.nnt_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.nnt_ma_thon)
             nnt_ten_thon,
         b.nnt_cmnd,
         b.nnt_cmnd_ngay_cap,
         b.nnt_cmnd_noi_cap,
         b.nnt_so_dt,
         b.nnt_so_tk,
         b.nnt_ngan_hang,
         b.nnt_nnkt_ctiet,
         b.thd_dia_chi,
         b.thd_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.thd_ma_tinh)
             thd_ten_tinh,
         b.thd_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.thd_ma_huyen)
             thd_ten_huyen,
         b.thd_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.thd_ma_xa)
             thd_ten_xa,
         b.thd_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.thd_ma_thon)
             thd_ten_thon,
         b.thd_gcn,
         b.thd_gcn_so,
         b.thd_gcn_ngay_cap,
         b.thd_thua_dat_so,
         b.thd_ban_do_so,
         b.thd_gcn_dien_tich,
         b.thd_dtich_sd_tte,
         b.thd_gcn_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.thd_gcn_ma_md) thd_gcn_ten_md,
         b.thd_han_muc,
         b.thd_chua_gcn,
         b.thd_chua_gcn_dtich,
         b.thd_chua_gcn_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.thd_chua_gcn_ma_md) thd_chua_gcn_ten_md,
         b.mgi_ma_ly_do,
         (SELECT c.ten FROM tb_pnn_dm_mien_giam c where c.ma_lydo = b.mgi_ma_ly_do
         and c.ma_tinh = substr(b.ma_cqt,1,3)) mgi_ten_ly_do,
         b.mgi_ghi_chu,
         b.mgi_so_tien,
         b.mgi_ty_le,
         b.cct_dtich_sd_tte,
         b.cct_han_muc,
         b.cct_ma_loai_dat,
         (SELECT c.ten FROM tb_pnn_dm_loai_dat c where c.ma_loai_dat = b.cct_ma_loai_dat
         and c.ma_tinh = substr(b.ma_cqt,1,3) ) cct_ten_loai_dat,
         b.cct_ma_duong,
         (SELECT c.ten FROM tb_pnn_dm_ten_duong c where c.ma_duong = b.cct_ma_duong
         and c.ma_tinh = substr(b.ma_cqt,1,3) and rownum = 1) cct_ten_duong,
         b.cct_ma_doan_duong,
         (SELECT c.ten_doan_duong FROM tb_pnn_dm_doan_duong c where c.ma_doan_duong = b.cct_ma_doan_duong
         and c.ma_huyen = b.ma_cqt  and rownum = 1) cct_ten_doan_duong,
         b.cct_ma_loai_duong,
         (SELECT c.ten  FROM tb_pnn_dm_loai_duong c where c.ma_loai_duong = b.cct_ma_loai_duong
         and c.ma_tinh = substr(b.ma_cqt,1,3)  and rownum = 1) cct_ten_loai_duong,
         b.cct_ma_vi_tri,
         (SELECT c.ten FROM tb_pnn_dm_vi_tri c where c.ma_vi_tri = b.cct_ma_vi_tri
         and c.ma_tinh = substr(b.ma_cqt,1,3)  and rownum = 1) cct_ten_vi_tri,
         b.cct_he_so,
         b.cct_ma_gia_dat,
         b.cct_gia_dat,
         b.cct_gia_1m2_dat,
         b.cct_co_bke,
         b.dato_dtich_trong_hm,
         b.dato_dtich_duoi3,
         b.dato_dtich_vuot3,
         b.dato_stpn,
         b.ccu_dtich,
         b.ccu_stpn,
         b.ccu_he_so,
         b.skd_dtich,
         b.skd_stpn,
         b.smd_dtich,
         b.smd_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.smd_ma_md) smd_ten_md,
         b.smd_gia_1m2_dat,
         b.smd_stpn,
         b.lch_dtich,
         b.lch_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.lch_ma_md) lch_ten_md,
         b.lch_gia_1m2_dat,
         b.lch_stpn,
         b.stpn_truoc_mgi,
         b.stpn_tong,
         b.stpn_clech_bsung,
         b.dkn_nop_5nam,
         b.dkn_so_tien,
         b.ttk_dato_stpn,
         b.ttk_ccu_stpn,
         b.ttk_skd_stpn,
         b.ttk_smd_stpn,
         b.ttk_lch_stpn,
         b.dlt_tin,
         b.dlt_ten_dlt,
         b.dlt_dia_chi,
         b.dlt_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.dlt_ma_tinh)
             dlt_ten_tinh,
         b.dlt_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.dlt_ma_huyen)
             dlt_ten_huyen,
         b.dlt_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.dlt_ma_xa)
             dlt_ten_xa,
         b.dlt_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.dlt_ma_thon)
             dlt_ten_thon,
         b.dlt_so_dt,
         b.dlt_so_hdong,
         b.dlt_ngay_hdong,
         b.sthue_pnop
              FROM   tb_tk_sddpnn b
             WHERE   b.short_name = USERENV ('client_info') 
                    and b.ma_loai_tk = '01'
        ORDER BY   ma_tkhai) where sthue_pnop > 0
/

-- End of DDL Script for View TEST.VW_CT_01PNN

-- Start of DDL Script for View TEST.VW_CT_02PNN
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_02pnn (
   stt,
   kytt_tu_ngay,
   ky_kkhai_tu_ngay,
   ngay_htoan,
   ma_tkhai,
   ltd,
   ngay_nop_tk,
   trang_thai_tk,
   ma_tmuc,
   nnt_tin,
   nnt_ten_nnt,
   nnt_ngcap_mst,
   nnt_cap,
   nnt_chuong,
   nnt_loai,
   nnt_khoan,
   nnt_ngay_sinh,
   nnt_dia_chi,
   nnt_ma_tinh,
   nnt_ten_tinh,
   nnt_ma_huyen,
   nnt_ten_huyen,
   nnt_ma_xa,
   nnt_ten_xa,
   nnt_ma_thon,
   nnt_ten_thon,
   nnt_cmnd,
   nnt_cmnd_ngay_cap,
   nnt_cmnd_noi_cap,
   thd_dia_chi,
   thd_ma_tinh,
   thd_ten_tinh,
   thd_ma_huyen,
   thd_ten_huyen,
   thd_ma_xa,
   thd_ten_xa,
   thd_ma_thon,
   thd_ten_thon,
   thd_gcn,
   thd_gcn_so,
   thd_gcn_ngay_cap,
   thd_thua_dat_so,
   thd_ban_do_so,
   thd_gcn_dien_tich,
   thd_dtich_sd_tte,
   thd_gcn_ma_md,
   thd_gcn_ten_md,
   thd_han_muc,
   thd_chua_gcn,
   thd_chua_gcn_dtich,
   thd_chua_gcn_ma_md,
   thd_chua_gcn_ten_md,
   mgi_ma_ly_do,
   mgi_ten_ly_do,
   mgi_ghi_chu,
   mgi_so_tien,
   mgi_ty_le,
   cct_dtich_sd_tte,
   cct_han_muc,
   cct_ma_loai_dat,
   cct_ten_loai_dat,
   cct_ma_duong,
   cct_ten_duong,
   cct_ma_doan_duong,
   cct_ten_doan_duong,
   cct_ma_loai_duong,
   cct_ten_loai_duong,
   cct_ma_vi_tri,
   cct_ten_vi_tri,
   cct_he_so,
   cct_ma_gia_dat,
   cct_gia_dat,
   cct_gia_1m2_dat,
   cct_co_bke,
   dato_dtich_trong_hm,
   dato_dtich_duoi3,
   dato_dtich_vuot3,
   dato_stpn,
   ccu_dtich,
   ccu_stpn,
   ccu_he_so,
   skd_dtich,
   skd_stpn,
   smd_dtich,
   smd_ma_md,
   smd_ten_md,
   smd_gia_1m2_dat,
   smd_stpn,
   lch_dtich,
   lch_ma_md,
   lch_ten_md,
   lch_gia_1m2_dat,
   lch_stpn,
   stpn_truoc_mgi,
   stpn_tong,
   stpn_clech_bsung,
   dkn_nop_5nam,
   dkn_so_tien,
   ttk_dato_stpn,
   ttk_ccu_stpn,
   ttk_skd_stpn,
   ttk_smd_stpn,
   ttk_lch_stpn,
   dlt_tin,
   dlt_ten_dlt,
   dlt_dia_chi,
   dlt_ma_tinh,
   dlt_ten_tinh,
   dlt_ma_huyen,
   dlt_ten_huyen,
   dlt_ma_xa,
   dlt_ten_xa,
   dlt_ma_thon,
   dlt_ten_thon,
   dlt_so_dt,
   dlt_so_hdong,
   dlt_ngay_hdong,
   sthue_pnop )
AS
SELECT   rownum STT,
         kytt_tu_ngay,
         ky_kkhai_tu_ngay,
         ngay_htoan,
         ma_tkhai,
         ltd,         
         ngay_nop_tk,
         trang_thai_tk,
         ma_tmuc,
         nnt_tin,
         nnt_ten_nnt,
         nnt_ngcap_mst,
         nnt_cap,
         nnt_chuong,
         nnt_loai,
         nnt_khoan,
         nnt_ngay_sinh,
         nnt_dia_chi,
         nnt_ma_tinh,
         nnt_ten_tinh,
         nnt_ma_huyen,
         nnt_ten_huyen,
         nnt_ma_xa,
         nnt_ten_xa,
         nnt_ma_thon,
         nnt_ten_thon,
         nnt_cmnd,
         nnt_cmnd_ngay_cap,
         nnt_cmnd_noi_cap,
         thd_dia_chi,
         thd_ma_tinh,
         thd_ten_tinh,
         thd_ma_huyen,
         thd_ten_huyen,
         thd_ma_xa,
         thd_ten_xa,
         thd_ma_thon,
         thd_ten_thon,
         thd_gcn,
         thd_gcn_so,
         thd_gcn_ngay_cap,
         thd_thua_dat_so,
         thd_ban_do_so,
         thd_gcn_dien_tich,
         thd_dtich_sd_tte,
         thd_gcn_ma_md,
         thd_gcn_ten_md,
         thd_han_muc,
         thd_chua_gcn,
         thd_chua_gcn_dtich,
         thd_chua_gcn_ma_md,
         thd_chua_gcn_ten_md,
         mgi_ma_ly_do,
         mgi_ten_ly_do,
         mgi_ghi_chu,
         mgi_so_tien,
         mgi_ty_le,
         cct_dtich_sd_tte,
         cct_han_muc,
         cct_ma_loai_dat,
         cct_ten_loai_dat,
         cct_ma_duong,
         cct_ten_duong,
         cct_ma_doan_duong,
         cct_ten_doan_duong,
         cct_ma_loai_duong,
         cct_ten_loai_duong,
         cct_ma_vi_tri,
         cct_ten_vi_tri,
         cct_he_so,
         cct_ma_gia_dat,
         cct_gia_dat,
         cct_gia_1m2_dat,
         cct_co_bke,
         dato_dtich_trong_hm,
         dato_dtich_duoi3,
         dato_dtich_vuot3,
         dato_stpn,
         ccu_dtich,
         ccu_stpn,
         ccu_he_so,
         skd_dtich,
         skd_stpn,
         smd_dtich,
         smd_ma_md,
         smd_ten_md,
         smd_gia_1m2_dat,
         smd_stpn,
         lch_dtich,
         lch_ma_md,
         lch_ten_md,
         lch_gia_1m2_dat,
         lch_stpn,
         stpn_truoc_mgi,
         stpn_tong,
         stpn_clech_bsung,
         dkn_nop_5nam,
         dkn_so_tien,
         ttk_dato_stpn,
         ttk_ccu_stpn,
         ttk_skd_stpn,
         ttk_smd_stpn,
         ttk_lch_stpn,
         dlt_tin,
         dlt_ten_dlt,
         dlt_dia_chi,
         dlt_ma_tinh,
         dlt_ten_tinh,
         dlt_ma_huyen,
         dlt_ten_huyen,
         dlt_ma_xa,
         dlt_ten_xa,
         dlt_ma_thon,
         dlt_ten_thon,
         dlt_so_dt,
         dlt_so_hdong,
         dlt_ngay_hdong,
         sthue_pnop
    FROM   (SELECT    
         b.kytt_tu_ngay,
         b.ky_kkhai_tu_ngay,
         b.ngay_htoan,
         b.ma_tkhai,
         b.ltd,
         b.ngay_nop_tk,
         b.trang_thai_tk,
         b.ma_tmuc,
         b.nnt_tin,
         b.nnt_ten_nnt,
         b.nnt_ngcap_mst,
         b.nnt_cap,
         b.nnt_chuong,
         b.nnt_loai,
         b.nnt_khoan,
         b.nnt_ngay_sinh,
         b.nnt_dia_chi,
         b.nnt_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.nnt_ma_tinh)
             nnt_ten_tinh,
         b.nnt_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.nnt_ma_huyen)
             nnt_ten_huyen,
         b.nnt_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.nnt_ma_xa)
             nnt_ten_xa,
         b.nnt_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.nnt_ma_thon)
             nnt_ten_thon,
         b.nnt_cmnd,
         b.nnt_cmnd_ngay_cap,
         b.nnt_cmnd_noi_cap,
         b.nnt_so_dt,
         b.nnt_so_tk,
         b.nnt_ngan_hang,
         b.nnt_nnkt_ctiet,
         b.thd_dia_chi,
         b.thd_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.thd_ma_tinh)
             thd_ten_tinh,
         b.thd_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.thd_ma_huyen)
             thd_ten_huyen,
         b.thd_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.thd_ma_xa)
             thd_ten_xa,
         b.thd_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.thd_ma_thon)
             thd_ten_thon,
         b.thd_gcn,
         b.thd_gcn_so,
         b.thd_gcn_ngay_cap,
         b.thd_thua_dat_so,
         b.thd_ban_do_so,
         b.thd_gcn_dien_tich,
         b.thd_dtich_sd_tte,
         b.thd_gcn_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.thd_gcn_ma_md) thd_gcn_ten_md,
         b.thd_han_muc,
         b.thd_chua_gcn,
         b.thd_chua_gcn_dtich,
         b.thd_chua_gcn_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.thd_chua_gcn_ma_md) thd_chua_gcn_ten_md,
         b.mgi_ma_ly_do,
         (SELECT c.ten FROM tb_pnn_dm_mien_giam c where c.ma_lydo = b.mgi_ma_ly_do
         and c.ma_tinh = substr(b.ma_cqt,1,3)) mgi_ten_ly_do,
         b.mgi_ghi_chu,
         b.mgi_so_tien,
         b.mgi_ty_le,
         b.cct_dtich_sd_tte,
         b.cct_han_muc,
         b.cct_ma_loai_dat,
         (SELECT c.ten FROM tb_pnn_dm_loai_dat c where c.ma_loai_dat = b.cct_ma_loai_dat
         and c.ma_tinh = substr(b.ma_cqt,1,3) ) cct_ten_loai_dat,
         b.cct_ma_duong,
         (SELECT c.ten FROM tb_pnn_dm_ten_duong c where c.ma_duong = b.cct_ma_duong
         and c.ma_tinh = substr(b.ma_cqt,1,3) and rownum = 1) cct_ten_duong,
         b.cct_ma_doan_duong,
         (SELECT c.ten_doan_duong FROM tb_pnn_dm_doan_duong c where c.ma_doan_duong = b.cct_ma_doan_duong
         and c.ma_huyen = b.ma_cqt  and rownum = 1) cct_ten_doan_duong,
         b.cct_ma_loai_duong,
         (SELECT c.ten  FROM tb_pnn_dm_loai_duong c where c.ma_loai_duong = b.cct_ma_loai_duong
         and c.ma_tinh = substr(b.ma_cqt,1,3)  and rownum = 1) cct_ten_loai_duong,
         b.cct_ma_vi_tri,
         (SELECT c.ten FROM tb_pnn_dm_vi_tri c where c.ma_vi_tri = b.cct_ma_vi_tri
         and c.ma_tinh = substr(b.ma_cqt,1,3)  and rownum = 1) cct_ten_vi_tri,
         b.cct_he_so,
         b.cct_ma_gia_dat,
         b.cct_gia_dat,
         b.cct_gia_1m2_dat,
         b.cct_co_bke,
         b.dato_dtich_trong_hm,
         b.dato_dtich_duoi3,
         b.dato_dtich_vuot3,
         b.dato_stpn,
         b.ccu_dtich,
         b.ccu_stpn,
         b.ccu_he_so,
         b.skd_dtich,
         b.skd_stpn,
         b.smd_dtich,
         b.smd_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.smd_ma_md) smd_ten_md,
         b.smd_gia_1m2_dat,
         b.smd_stpn,
         b.lch_dtich,
         b.lch_ma_md,
         (select c.ten from tb_pnn_dm_muc_dich_sd c where c.ma_muc_dich = b.lch_ma_md) lch_ten_md,
         b.lch_gia_1m2_dat,
         b.lch_stpn,
         b.stpn_truoc_mgi,
         b.stpn_tong,
         b.stpn_clech_bsung,
         b.dkn_nop_5nam,
         b.dkn_so_tien,
         b.ttk_dato_stpn,
         b.ttk_ccu_stpn,
         b.ttk_skd_stpn,
         b.ttk_smd_stpn,
         b.ttk_lch_stpn,
         b.dlt_tin,
         b.dlt_ten_dlt,
         b.dlt_dia_chi,
         b.dlt_ma_tinh,
         (SELECT   c.prov_name
            FROM   tb_pnn_dm_province c
           WHERE   c.province = b.dlt_ma_tinh)
             dlt_ten_tinh,
         b.dlt_ma_huyen,
         (SELECT   c.dist_name
            FROM   tb_pnn_dm_district c
           WHERE   c.dist_code = b.dlt_ma_huyen)
             dlt_ten_huyen,
         b.dlt_ma_xa,
         (SELECT   c.comm_name
            FROM   tb_pnn_dm_commune c
           WHERE   c.comm_code = b.dlt_ma_xa)
             dlt_ten_xa,
         b.dlt_ma_thon,
         (SELECT   c.ten
            FROM   tb_pnn_dm_thon c
           WHERE   c.ma_thon = b.dlt_ma_thon)
             dlt_ten_thon,
         b.dlt_so_dt,
         b.dlt_so_hdong,
         b.dlt_ngay_hdong,
         b.sthue_pnop
              FROM   tb_tk_sddpnn b
             WHERE   b.short_name = USERENV ('client_info') 
                    and b.ma_loai_tk = '02'
                    ORDER BY   ma_tkhai) where rownum < 100
/

-- End of DDL Script for View TEST.VW_CT_02PNN

-- Start of DDL Script for View TEST.VW_CT_CKT
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_ckt (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   mau_tkhai,
   kykk_tu_ngay,
   kykk_den_ngay,
   so_tien )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, ten_nnt, mau_tkhai,
kykk_tu_ngay, kykk_den_ngay, so_tien
from tb_con_kt a, vw_tkhai_tms b where short_name=userenv('client_info') and rownum<100  AND a.ma_tkhai_tms=b.ma_tms
/

-- End of DDL Script for View TEST.VW_CT_CKT

-- Start of DDL Script for View TEST.VW_CT_DKNTK
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_dkntk (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   ma_tkhai,
   ky_bd_hthong_cu,
   ky_kt_hthong_cu )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, ten_nnt, 
ma_tkhai, ky_bd_hthong_cu, ky_kt_hthong_cu 
from tb_dkntk where short_name=userenv('client_info') and rownum<100
/

-- End of DDL Script for View TEST.VW_CT_DKNTK

-- Start of DDL Script for View TEST.VW_CT_NO
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_no (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   ma_chuong,
   ma_khoan,
   tmt_ma_tmuc,
   tkhoan,
   ngay_htoan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   so_tien,
   nguon_goc,
   tinh_chat,
   so_qd,
   ngay_qd )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, ten_nnt,
ma_chuong, ma_khoan, tmt_ma_tmuc, tkhoan, ngay_htoan, kykk_tu_ngay,
kykk_den_ngay, han_nop, so_tien, nguon_goc, tinh_chat, so_qd, ngay_qd
from tb_no where short_name=userenv('client_info') and rownum<100
/

-- End of DDL Script for View TEST.VW_CT_NO

-- Start of DDL Script for View TEST.VW_CT_PS
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_ps (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   mau_tkhai,
   ma_chuong,
   ma_tmuc,
   kykk_tu_ngay,
   kykk_den_ngay,
   so_tien,
   han_nop,
   ngay_htoan )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, ten_nnt, mau_tkhai,
ma_chuong, ma_tmuc, kykk_tu_ngay, kykk_den_ngay, so_tien,
han_nop, ngay_htoan from tb_ps a, vw_tkhai_tms b where short_name=userenv('client_info') and rownum<100
AND a.ma_tkhai_tms=b.ma_tms
/

-- End of DDL Script for View TEST.VW_CT_PS

-- Start of DDL Script for View TEST.VW_CT_TK
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_tk (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   kykk_tu_ngay,
   kykk_den_ngay,
   kylb_tu_ngay,
   dthu_dkien,
   tl_thnhap_dkien,
   thnhap_cthue_dkien,
   gtru_gcanh,
   ban_than,
   phu_thuoc,
   thnhap_tthue_dkien,
   tncn,
   pb01,
   kytt01,
   ht01,
   hn01,
   pb02,
   kytt02,
   ht02,
   hn02,
   pb03,
   kytt03,
   ht03,
   hn03,
   pb04,
   kytt04,
   ht04,
   hn04,
   mst_dtk,
   hd_dlt_so,
   hd_dlt_ngay )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, kykk_tu_ngay,
kykk_den_ngay, kylb_tu_ngay, dthu_dkien, tl_thnhap_dkien, thnhap_cthue_dkien, 
gtru_gcanh, ban_than, phu_thuoc, thnhap_tthue_dkien, tncn, pb01, kytt01, 
ht01, hn01, pb02, kytt02, ht02, hn02, pb03, kytt03, ht03, hn03, pb04, kytt04, 
ht04, hn04, mst_dtk, hd_dlt_so, hd_dlt_ngay from tb_tk where short_name=userenv('client_info')
/

-- End of DDL Script for View TEST.VW_CT_TK

-- Start of DDL Script for View TEST.VW_CT_TKH
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_tkh (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   kykk_tu_ngay,
   kykk_den_ngay,
   doanh_thu,
   gtgt_chiu_thue,
   thue_gtgt,
   han_nop,
   ngay_htoan )
AS
select rownum stt, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban, tin, ten_nnt, 
 kytt_tu_ngay, kytt_den_ngay, (nvl(doanh_thu_ts_5,0) + nvl(doanh_thu_ts_10,0)) doanh_thu,
(nvl(gtgt_chiu_thue_ts_5,0) + nvl(gtgt_chiu_thue_ts_10,0)) gtgt_chiu_thue,
(nvl(thue_gtgt_ts_5,0) + nvl(thue_gtgt_ts_10,0)) thue_gtgt,
han_nop, ngay_htoan 
from tb_01_thkh_hdr where short_name=userenv('client_info') and rownum<100
/

-- End of DDL Script for View TEST.VW_CT_TKH

-- Start of DDL Script for View TEST.VW_CT_TKMB
-- Generated 3-Oct-2013 16:30:50 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_tkmb (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   kytt_tu_ngay,
   kytt_den_ngay,
   han_nop,
   bmb_nnt,
   tong_thue_pn_nnt )
AS
select rownum stt, a.tax_model, a.ma_cbo, a.ten_cbo, a.ma_pban, a.ten_pban, a.tin, a.ten_nnt,
 a.kytt_tu_ngay, a.kytt_den_ngay, a.han_nop, b.ten bmb_nnt, a.tong_thue_pn_nnt
from tb_tkmb_hdr a, tb_dmuc_bac_mbai b
where a.short_name=userenv('client_info') and rownum<100
and a.bmb_nnt_tms = b.ma and b.tax_model = 'TMS-APP'
/

-- End of DDL Script for View TEST.VW_CT_TKMB

-- Start of DDL Script for View TEST.VW_CT_TPHAT
-- Generated 3-Oct-2013 16:30:51 from TEST@DCNC

CREATE OR REPLACE VIEW vw_ct_tphat (
   stt,
   tax_model,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   ma_chuong,
   ma_khoan,
   tmt_ma_tmuc,
   tkhoan,
   ngay_htoan,
   han_nop,
   so_tien )
AS
select rownum stt, tax_model, '' ma_cbo, '' ten_cbo, '' ma_pban, '' ten_pban, tin, ten_nnt,
ma_chuong, ma_khoan, tmt_ma_tmuc, tkhoan, ngay_htoan, han_nop, so_tien
from tb_tinh_phat where short_name=userenv('client_info') and rownum<100
/

-- End of DDL Script for View TEST.VW_CT_TPHAT

-- Start of DDL Script for View TEST.VW_TKHAI_TMS
-- Generated 3-Oct-2013 16:30:51 from TEST@DCNC

CREATE OR REPLACE VIEW vw_tkhai_tms (
   ma_tms,
   ten,
   mau_tkhai )
AS
Select
    ma_tms,
    max(ten),
    max(MAU_TKHAI)
from tb_dmuc_tkhai 
 GROUP BY (ma_tms)
/

-- End of DDL Script for View TEST.VW_TKHAI_TMS

