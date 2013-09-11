CREATE OR REPLACE VIEW vw_check_tb_tinh_phat (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '007' err_id,
         'tkhoan' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name AND tkhoan <> '741'
UNION
--Ma chuong: ton tai trong danh muc ma chuong con hieu luc
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '005' err_id,
         'ma_chuong' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_chuong NOT IN (SELECT   ma_chuong FROM tb_dmuc_capchuong)
--M? kho?n: 000
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '005' err_id,
         'ma_khoan' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name AND ma_khoan <> '000'
--M? ti?u m?c: 4254
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '006' err_id,
         'tmt_ma_tmuc' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name
         AND tmt_ma_tmuc <> '4254'
--   Ngay hach toan: la ngay cuoi cung cua ky chot du lieu chuyen doi
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '012' err_id,
         'ngay_htoan' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
                LAST_DAY (
                    TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--   Han nop: la ngay cuoi cung cua ky chot du lieu chuyen doi
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '012' err_id,
         'han_nop' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (han_nop, 'DD/MM/YYYY') <>
                LAST_DAY (
                    TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--   S? ti?n: s?, khong du?c am
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TINH_PHAT' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no
  FROM   tb_tinh_phat
 WHERE   short_name = pck_glb_variables.get_short_name AND so_tien < 0
;

