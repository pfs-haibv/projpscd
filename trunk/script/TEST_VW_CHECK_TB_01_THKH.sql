-- Start of DDL Script for View TEST.VW_CHECK_TB_01_THKH
-- Generated 03/10/2013 2:28:29 PM from TEST@DCNC

CREATE OR REPLACE VIEW vw_check_tb_01_thkh (
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
         'TB_01_THKH_HDR' table_name,
         '012' err_id,
         'ngay_htoan' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
                LAST_DAY (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--Check Ngay nop to khai: thuoc nam chuyen doi du lieu
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '012' err_id,
         'ngay_nop_tk' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ngay_nop_tk, 'DD/MM/YYYY'), 'YEAR') <>
             TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'),'YEAR')
--Check cac truong kieu so, khong duoc < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'dthu_dkien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND dthu_dkien < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'tl_thnhap_dkien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND tl_thnhap_dkien < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'thnhap_cthue_dkien' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thnhap_cthue_dkien < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'gtru_ban_than' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND gtru_ban_than < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'gtru_phu_thuoc' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND gtru_phu_thuoc < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'gtru_tong' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND gtru_tong < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'thue_pnop' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND thue_pnop < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'thnhap_tinhthue' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thnhap_tinhthue < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'doanh_thu_ts_5, gtgt_chiu_thue_ts_5, thue_gtgt_ts_5' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name AND doanh_thu_ts_5 < 0
         OR gtgt_chiu_thue_ts_5 < 0
         OR thue_gtgt_ts_5 < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'doanh_thu_ts_10, gtgt_chiu_thue_ts_10, thue_gtgt_ts_10' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND doanh_thu_ts_10 < 0
         OR gtgt_chiu_thue_ts_10 < 0
         OR thue_gtgt_ts_10 < 0
--Check T? l? phan chia thu nh?p: 100
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_HDR' table_name,
         '014' err_id,
         'tl_phanchia_tn' field_name,
         0 update_no,
         ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_hdr
 WHERE   short_name = pck_glb_variables.get_short_name
         AND tl_phanchia_tn <> 100
--Xem lai phan check tieu muc, vi hien tai chi lay tieu muc 1701
-- lay tmuc 1701 doi voi du lieu o QCT, tieu muc 1003 du lieu ben tk tncn
-- do dieu kien lay = 1701 do do ko check truong hop nay
--Check Ky tinh thue: ky tinh thue thuoc nam chuyen doi du lieu
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '011' err_id,
         'ky_tthue' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ky_tthue, 'DD/MM/YYYY'), 'YEAR') <>
             TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'),'YEAR')
--Check ten npt bat buoc
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '014' err_id,
         'ten_npt' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt as ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name AND ten_npt IS NULL
--Check Nam sinh: bat buoc, khong lon hon nam chuyen doi
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '012' err_id,
         'ten_npt' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt as ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ngay_sinh, 'DD/MM/YYYY'), 'YEAR') >
             TRUNC (SYSDATE, 'YEAR')
--Check Quan he voi NNT: bat buoc, quan he voi chu ho
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '013' err_id,
         'qhe_nnt' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt as ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name AND qhe_nnt IS NULL
--Check So thang duoc tinh giam tru: 0 < so <= 12
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '014' err_id,
         'sothang_gtru' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt as ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name
    AND  ( sothang_gtru < 0
         OR sothang_gtru > 12 )
--Check Thu nhap duoc giam tru: so, khong duoc am
UNION
SELECT   short_name,
         ROWID rid,
         'TB_01_THKH_NPT' table_name,
         '014' err_id,
         'sotien_gtru' field_name,
         0 update_no,
         pck_glb_variables.get_ma_cqt as ma_cqt,
         'ORA' check_app
  FROM   tb_01_thkh_npt
 WHERE   short_name = pck_glb_variables.get_short_name AND sotien_gtru < 0
/

-- End of DDL Script for View TEST.VW_CHECK_TB_01_THKH

