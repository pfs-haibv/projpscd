-- Start of DDL Script for View TEST.VW_CHECT_TB_CON_KT
-- Generated 03/10/2013 2:30:01 PM from TEST@DCNC

CREATE OR REPLACE VIEW vw_chect_tb_con_kt (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no,
   ma_cqt,
   check_app )
AS
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '010' err_id,
         'so_tien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
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
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_chuong NOT IN (SELECT ma_chuong FROM tb_dmuc_capchuong)
--Check ma khoan
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '005' err_id,
         'ma_khoan' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name AND ma_khoan <> '000'
--Check Ma tieu muc: 1701; 1704; 1705
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '006' err_id,
         'ma_tmuc' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_tmuc NOT IN ('1701', '1704', '1705')
--Check so thue khau tru chuyen ky sau: so, khong duoc am
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name AND so_tien < 0
--Check Ngay hach toan: ngay cuoi cung cua ky chot du lieu chuyen doi
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
             LAST_DAY (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--Check Ky ke khai tu ngay: ngay dau thang
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '012' err_id,
         'kykk_tu_ngay' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY') <>
             TRUNC (TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY'))
--Check Ky ke khai den ngay: ngay cuoi thang
UNION
SELECT   short_name,
         ROWID rid,
         'TB_CON_KT' table_name,
         '012' err_id,
         'kykk_den_ngay' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_con_kt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (kykk_den_ngay, 'DD/MM/YYYY') <>
             LAST_DAY (TO_DATE (kykk_den_ngay, 'DD/MM/YYYY'))
/

-- End of DDL Script for View TEST.VW_CHECT_TB_CON_KT

