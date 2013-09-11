-- Start of DDL Script for View TEST.VW_CHECK_TB_NO
-- Generated 11/09/2013 8:16:37 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_check_tb_no (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
(--Check han_Nop khong null
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '013' err_id,
         'HAN_NOP' field_name,
         0 update_no
  FROM   tb_no
 WHERE  short_name = pck_glb_variables.get_short_name
    and han_nop IS NULL
UNION
--Check nguon_goc khong null
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '013' err_id,
         'NGUON_GOC' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
     and nguon_goc IS NULL
UNION
--CHECK tai khoan
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '008' err_id,
         'TKHOAN' field_name,
         0 update_no
  FROM   tb_no
 WHERE  short_name = pck_glb_variables.get_short_name
    and tkhoan NOT IN ('TK_NGAN_SACH', 'TK_TH_HOAN', 'TK_STC')
--Check chuong
UNION
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '005' err_id,
         'ma_chuong' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and ma_chuong NOT IN (SELECT   ma_chuong FROM tb_dmuc_capchuong)
UNION
--Check khoan
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '008' err_id,
         'MA_KHOAN' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and ma_khoan <> '000'
UNION
--Check tieu muc
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '006' err_id,
         'TMT_MA_TMUC' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and tmt_ma_tmuc NOT IN (SELECT ma_tmuc FROM tb_dmuc_mtmuc)
UNION
--Kykk_tu_ngay
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '011' err_id,
         'KYKK_TU_NGAY' field_name,
         0 update_no
  FROM   tb_no a
 WHERE   short_name = pck_glb_variables.get_short_name
    and TO_DATE (a.kykk_tu_ngay, 'DD/MM/YYYY') <>
        TRUNC (TO_DATE (a.kykk_tu_ngay, 'DD/MM/YYYY'), 'MONTH')
UNION
--Kykk_den_ngay
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '011' err_id,
         'KYKK_DEN_NGAY' field_name,
         0 update_no
  FROM   tb_no a
 WHERE   short_name = pck_glb_variables.get_short_name
    and TO_DATE (a.kykk_den_ngay, 'DD/MM/YYYY') <>
        LAST_DAY (TO_DATE (a.kykk_den_ngay, 'DD/MM/YYYY'))
UNION
/**
 * Ngay hoach toan: ngay cuoi cung cua ky chot du lieu chuyen doi,
 * hoac ngay cuoi cung cua nam truoc nam chuyen doi du lieu
 **/
SELECT   a.short_name,
         ROWID rid,
         'TB_NO' table_name,
         '012' err_id,
         'NGAY_HTOAN' field_name,
         0 update_no
  FROM   tb_no a
 WHERE  a.short_name = pck_glb_variables.get_short_name
    and (TO_DATE (a.ngay_htoan, 'DD/MM/YYYY') <> last_day(to_date(pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
      or TO_DATE (a.ngay_htoan, 'DD/MM/YYYY') <> LAST_DAY(ADD_MONTHS (TRUNC (TRUNC
                                                (to_date(pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'), 'Year') - 1,'Year'),11))
        )
UNION
 --ngay_qd: bat buoc, khong lon hon ngay cuoi cung cua ky chot du lieu chuyen doi
 SELECT    short_name,

         ROWID rid,
         'TB_NO' table_name,
         '012' err_id,
         'NGAY_QD' field_name,
         0 update_no
  FROM   tb_no a
 WHERE  short_name = pck_glb_variables.get_short_name
    and TO_DATE (a.ngay_qd, 'DD/MM/YYYY') > to_date (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY')
    AND a.ngay_qd is null
  UNION
 --ngay_tinh_phat: khong bat buoc, khong lon hon ngay cuoi cung cua ky chot du lieu chuyen doi
 SELECT    short_name,
         ROWID rid,
         'TB_NO' table_name,
         '012' err_id,
         'TPHAT_DEN_NGAY' field_name,
         0 update_no
  FROM   tb_no a
 WHERE  short_name = pck_glb_variables.get_short_name
    and TO_DATE (a.tphat_den_ngay, 'DD/MM/YYYY') > to_date(pck_glb_variables.get_ky_chot, 'DD/MM/YYYY')
UNION
--Check LOAI, TINH_CHAT_NO
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '001' err_id,
         'LOAI' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and loai <> 'CD'
UNION
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '016' err_id,
         'TINH_CHAT' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and tinh_chat IS NOT NULL
    AND tinh_chat NOT IN (SELECT   to_char(ma) FROM tb_dmuc_tchat_no)
UNION
--Check so_tien
SELECT   short_name,
         ROWID rid,
         'TB_NO' table_name,
         '014' err_id,
         'SO_TIEN' field_name,
         0 update_no
  FROM   tb_no
 WHERE   short_name = pck_glb_variables.get_short_name
    and NOT REGEXP_LIKE (so_tien, '^-?[[:digit:],.]*$')
)
/

-- End of DDL Script for View TEST.VW_CHECK_TB_NO

