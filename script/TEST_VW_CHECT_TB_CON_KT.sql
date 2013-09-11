CREATE OR REPLACE VIEW vw_chect_tb_con_kt (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '010' err_id,
         'so_tien' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_tkhai NOT IN ('01/GTGT', '02/GTGT')
--Check ma_chuong ton tai trong danh muc
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '005' err_id,
         'ma_chuong' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_chuong NOT IN (SELECT   ma_chuong FROM tb_dmuc_capchuong)
--Check ma khoan
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '005' err_id,
         'ma_khoan' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name AND ma_khoan <> '000'
--Check M? ti?u m?c: 1701; 1704; 1705
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '006' err_id,
         'ma_tmuc' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_tmuc NOT IN ('1701', '1704', '1705')
--Check s? thu? kh?u tr? chuy?n k? sau: s?, khong du?c am
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name AND so_tien < 0
--Check Ngay h?ch toan: ngay cu?i cung c?a k? ch?t d? li?u chuy?n d?i
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
                LAST_DAY (
                    TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--Check K? ke khai t? ngay: ngay d?u thang
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '012' err_id,
         'kykk_tu_ngay' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY') <>
                TRUNC (TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY'))
--Check K? ke khai d?n ngay: ngay cu?i thang
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '012' err_id,
         'kykk_den_ngay' field_name,
         0 update_no
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kykk_den_ngay, 'DD/MM/YYYY') <>
                LAST_DAY (TO_DATE (kykk_den_ngay, 'DD/MM/YYYY'))
;

