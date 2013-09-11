CREATE OR REPLACE VIEW vw_check_tb_sddpnn_01_nnt (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'nnt_ten_nnt' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ten_nnt IS NULL
UNION
--Check Ngay thang nam sinh: Ngay ngay; bat buoc
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_NGAY_SINH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (nnt_ngay_sinh, 'DD/MM/YYYY') IS NULL
UNION
--Check so CMTND
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_CMND' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name AND nnt_cmnd IS NULL
UNION
--Check Ngay cap
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_CMND_NGAY_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (nnt_cmnd_ngay_cap, 'DD/MM/YYYY') IS NULL
UNION
--Check Noi cap
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_CMND_NOI_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_cmnd_noi_cap IS NULL
UNION
--Check dia chi nhan thong bao
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_DIA_CHI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_dia_chi IS NULL
UNION
--Check to thon
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_MA_THON' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ma_thon IS NULL
UNION
--Check phuong xa
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_MA_XA' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name AND nnt_ma_xa IS NULL
UNION
--Check ma huyen
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_MA_HUYEN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ma_huyen IS NULL
UNION
--Check ma tinh
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'NNT_MA_TINH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ma_tinh IS NULL
UNION
--(*)Thong tin thua dat chiu thue
--Check dia chi thua dat
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_DIA_CHI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_dia_chi IS NULL
UNION
--Check ma tinh
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_MA_TINH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_tinh IS NULL
UNION
--Check ma huyen
SELECT   short_name,
/*ADVICE(148): Use of ROWID or UROWID [113] */
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_MA_HUYEN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_huyen IS NULL
UNION
--Check ma xa
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_MA_XA' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name AND thd_ma_xa IS NULL
UNION
--Check ma thon
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_MA_THON' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_thon IS NULL
UNION
--Check so giay chung nhan
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_GCN_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_so IS NULL
         AND thd_gcn = 1
UNION
--Check ngay cap gcn
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_GCN_NGAY_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_ngay_cap IS NULL
         AND thd_gcn = 1
UNION
--Check thua dat so
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_THUA_DAT_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_thua_dat_so IS NULL
         AND thd_gcn = 1
UNION
--Check ban do so
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_BAN_DO_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_ban_do_so IS NULL
         AND thd_gcn = 1
UNION
--Check dien tich tren gcn
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_GCN_DIEN_TICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_dien_tich IS NULL
         AND thd_gcn = 1
UNION
--Check muc dich
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_DTICH_DUNG_MD' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND (thd_dtich_dung_md IS NULL AND thd_gcn = 1)
         OR (thd_dtich_dung_md NOT IN
                     (SELECT   ma_muc_dich FROM tb_pnn_dm_muc_dich_sd)
             AND thd_gcn = 1)
UNION
--Check dien tich dat su dung dung muc dich
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'thd_dtich_dung_md' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_dtich_dung_md < 0
UNION
--Check tong dien tich thuc te
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_TONG_DTICH_TTE' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_tong_dtich_tte < 0
UNION
--Check dien tich (chua co gcn)
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '013' err_id,
         'THD_CHUA_GCN_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_chua_gcn_dtich IS NULL
         AND thd_chua_gcn = 1
--(*)Doi voi nha chung cu
--Check Dien tich: so khong am, bat buoc neu co gia tri loai nha
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '014' err_id,
         'CCU_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name AND ccu_dtich < 0
         OR (ccu_dtich IS NULL AND ccu_loai_nha IS NOT NULL)
--Check he so phan bo: so khong am, bat buoc neu co gia tri loai nha
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN_01_NNT' table_name,
         '014' err_id,
         'CCU_HESO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn_01_nnt
 WHERE   short_name = pck_glb_variables.get_short_name AND ccu_heso < 0
         OR (ccu_heso IS NULL AND ccu_loai_nha IS NOT NULL)
;

