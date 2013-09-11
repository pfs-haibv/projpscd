CREATE OR REPLACE VIEW vw_check_tb_tkmb (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
SELECT   short_name,
         ROWID rid,
         'TB_TKMB_HDR' table_name,
         '011' err_id,
         'kytt_tu_ngay' field_name,
         0 update_no
  FROM   tb_tkmb_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kytt_tu_ngay, 'DD/MM/YYYY') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'),
                       'YEAR')
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TKMB_HDR' table_name,
         '011' err_id,
         'kytt_den_ngay' field_name,
         0 update_no
  FROM   tb_tkmb_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kytt_den_ngay, 'DD/MM/YYYY') <>
                LAST_DAY(ADD_MONTHS (
                             TRUNC (
                                 TO_DATE (pck_glb_variables.get_ky_chot,
                                          'DD/MM/RRRR'),
                                 'Year'),
                             11))
--Ngay hach toan: ngay cuoi cung cua ky chot du lieu chuyen doi
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TKMB_HDR' table_name,
         '012' err_id,
         'ngay_htoan' field_name,
         0 update_no
  FROM   tb_tkmb_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
                LAST_DAY (
                    TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'))
--Ngay nop to khai: bat buoc thuoc nam chuyen doi du lieu
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TKMB_HDR' table_name,
         '012' err_id,
         'ngay_nop_tk' field_name,
         0 update_no
  FROM   tb_tkmb_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ngay_nop_tk, 'DD/MM/YYYY'), 'YEAR') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'),
                       'YEAR')
--Han nop: thuoc nam chuyen doi du lieu
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TKMB_HDR' table_name,
         '012' err_id,
         'han_nop' field_name,
         0 update_no
  FROM   tb_tkmb_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ngay_nop_tk, 'DD/MM/YYYY'), 'YEAR') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'),
                       'YEAR')
--Bac mon bai tu 1 den 6
UNION
SELECT   short_name,
         a.ROWID rid,
         'TB_TKMB_HDR or TB_TKMB_DTL' table_name,
         '012' err_id,
         'BMB_NNT BMB_CQT' field_name,
         0 update_no
  FROM   tb_tkmb_hdr a
 WHERE   a.short_name = pck_glb_variables.get_short_name
         AND (a.bmb_cqt IS NOT NULL
              AND a.bmb_cqt NOT IN (SELECT   DISTINCT a.ma
                                      FROM   tb_dmuc_bac_mbai a
                                     WHERE   a.tax_model <> 'TMS-APP'))
         OR (a.bmb_nnt IS NOT NULL
             AND a.bmb_nnt NOT IN (SELECT   DISTINCT a.ma
                                     FROM   tb_dmuc_bac_mbai a
                                    WHERE   a.tax_model <> 'TMS-APP'))
UNION
SELECT   short_name,
         a.ROWID rid,
         'TB_TKMB_DTL' table_name,
         '012' err_id,
         'BMB_NNT BMB_CQT' field_name,
         0 update_no
  FROM   tb_tkmb_hdr a, tb_tkmb_dtl b
 WHERE       a.id = b.hdr_id
         AND a.short_name = pck_glb_variables.get_short_name
         AND (b.bmb_cqt IS NOT NULL
              AND b.bmb_cqt NOT IN (SELECT   DISTINCT a.ma
                                      FROM   tb_dmuc_bac_mbai a
                                     WHERE   a.tax_model <> 'TMS-APP'))
         OR (b.bmb_nnt IS NOT NULL
             AND b.bmb_nnt NOT IN (SELECT   DISTINCT a.ma
                                     FROM   tb_dmuc_bac_mbai a
                                    WHERE   a.tax_model <> 'TMS-APP'))
UNION
--Check sotien khong duoc am
SELECT   short_name,
         a.ROWID rid,
         'TB_TKMB_HDR' table_name,
         '014' err_id,
         'VON_DK_NNT VON_DK_CQT ...' field_name,
         0 update_no
  FROM   tb_tkmb_hdr a
 WHERE   a.short_name = pck_glb_variables.get_short_name
         AND (   a.thue_pn_nnt < 0
              OR a.von_dky_nnt < 0
              OR a.von_dky_cqt < 0
              OR a.thue_pn_cqt < 0
              --OR a.bmb_nnt < 0
              --OR a.bmb_cqt < 0
              OR a.tong_thue_pn_nnt < 0
              OR a.tong_thue_pn_cqt < 0)
UNION
SELECT   short_name,
         a.ROWID rid,
         'TB_TKMB_DTL' table_name,
         '014' err_id,
         'VON_DK_NNT VON_DK_CQT ...' field_name,
         0 update_no
  FROM   tb_tkmb_hdr a, tb_tkmb_dtl b
 WHERE   a.id = b.hdr_id AND a.short_name = pck_glb_variables.get_short_name
         AND (   b.thue_pn_nnt < 0
              OR b.von_dky_nnt < 0
              OR b.von_dky_cqt < 0
              OR b.thue_pn_cqt < 0)
;

