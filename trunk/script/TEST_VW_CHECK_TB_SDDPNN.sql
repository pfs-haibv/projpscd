CREATE OR REPLACE VIEW vw_check_tb_sddpnn (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
(--Check ky ke khai thuoc nam chuyen doi du lieu
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '011' err_id,
         'KYTT_TU_NGAY' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (kytt_tu_ngay, 'DD/MM/YYYY'), 'YEAR') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'),
                       'YEAR')
UNION
--Ngay hach toan: ngay cuoi cung cua ky chot du lieu
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '011' err_id,
         'NGAY_HTOAN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
                LAST_DAY (
                    TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
UNION
--Ngay nop to khai: thuoc nam chuyen doi du lieu
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '011' err_id,
         'NGAY_NOP_TK' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (ngay_nop_tk, 'DD/MM/YYYY'), 'YEAR') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'),
                       'YEAR')
--Han nop: thuoc nam chuyen doi du lieu
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '011' err_id,
         'HAN_NOP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TRUNC (TO_DATE (han_nop, 'DD/MM/YYYY'), 'YEAR') <>
                TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/RRRR'),
                       'YEAR')
--Check ma to khai
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'MA_TKHAI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND ma_tkhai IS NULL
--Check NNT Ten
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'NNT_TEN_NNT' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ten_nnt IS NULL
--Check NNT Ngay sinh
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'NNT_NGAY_SINH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_ngay_sinh IS NULL
--Check NNT NNT_CMND_NOI_CAP


UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'NNT_CMND_NOI_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_cmnd_noi_cap IS NULL
--Check NNT_CMND_NGAY_CAP
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'NNT_CMND_NGAY_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND nnt_cmnd_ngay_cap IS NULL
--Check NNT NNT_CMND
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'NNT_CMND' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND nnt_cmnd IS NULL
--(*) Thua dat chiu thue:
-- Check THD_DIA_CHI
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_DIA_CHI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_dia_chi IS NULL
-- Check THD_MA_THON
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_MA_THON' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_thon IS NULL
-- Check THD_MA_TINH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_DIA_CHI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_tinh IS NULL
-- Check THD_MA_HUYEN
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_DIA_CHI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND thd_ma_huyen IS NULL
-- Check THD_MA_XA
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_MA_XA' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND thd_ma_xa IS NULL
-- Check THD_GCN_SO

UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_GCN_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_so IS NULL
         AND thd_gcn = 1
-- Check THD_GCN_NGAY_CAP
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_GCN_NGAY_CAP' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_ngay_cap IS NULL
         AND thd_gcn = 1
-- Check THD_BAN_DO_SO
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_BAN_DO_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_ban_do_so IS NULL
         AND thd_gcn = 1
-- Check THD_GCN_DIEN_TICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_BAN_DO_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_gcn_dien_tich IS NULL
         AND thd_gcn = 1
-- Check THD_DTICH_SD_TTE
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_DTICH_SD_TTE' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_dtich_sd_tte IS NULL
         AND thd_gcn = 1
--Check muc dich
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_GCN_MA_MD' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND (thd_gcn_ma_md IS NULL AND thd_gcn = 1)
         OR (thd_gcn_ma_md NOT IN
                     (SELECT   ma_muc_dich FROM tb_pnn_dm_muc_dich_sd)
             AND thd_gcn = 1)
--Check muc dich
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_CHUA_GCN_MA_MD' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND (thd_chua_gcn_ma_md IS NULL AND thd_gcn = 1)
         OR (thd_chua_gcn_ma_md NOT IN
                     (SELECT   ma_muc_dich FROM tb_pnn_dm_muc_dich_sd)
             AND thd_chua_gcn = 1)
-- Check THD_CHUA_GCN_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_CHUA_GCN_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_chua_gcn_dtich IS NULL
         AND thd_chua_gcn = 1
-- Check THD_CHUA_GCN_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'THD_CHUA_GCN_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND thd_chua_gcn_dtich IS NULL
         AND thd_chua_gcn = 1
-- Check MGI_MA_LY_DO
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'MGI_MA_LY_DO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE       short_name = pck_glb_variables.get_short_name
         AND mgi_ma_ly_do IS NOT NULL
         AND mgi_ma_ly_do NOT IN (SELECT   ma_lydo FROM tb_pnn_dm_mien_giam)
--Check Can cu tinh thue
-- Check CCT_DTICH_SD_TTE
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'CCT_DTICH_SD_TTE' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_dtich_sd_tte < 0
-- Check CCT_HAN_MUC
UNION
SELECT   short_name,
/*ADVICE(352): Use of ROWID or UROWID [113] */
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '013' err_id,
         'CCT_HAN_MUC' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND cct_han_muc < 0
-- Check CCT_MA_LOAI_DAT
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_MA_LOAI_DAT' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_ma_loai_dat NOT IN
                    (SELECT   ma_loai_dat FROM tb_pnn_dm_loai_dat)
-- Check CCT_MA_LOAI_DAT
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_MA_DUONG' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_ma_duong NOT IN (SELECT   ma_duong FROM tb_pnn_dm_ten_duong)
-- Check CCT_MA_DOAN_DUONG
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_MA_DOAN_DUONG' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_ma_doan_duong NOT IN
                    (SELECT   ma_doan_duong FROM tb_pnn_dm_doan_duong)
-- Check CCT_MA_LOAI_DUONG
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_MA_LOAI_DUONG' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_ma_loai_duong NOT IN
                    (SELECT   ma_loai_duong FROM tb_pnn_dm_loai_duong)
-- Check CCT_MA_VI_TRI
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_MA_VI_TRI' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_ma_vi_tri NOT IN (SELECT   ma_vi_tri FROM tb_pnn_dm_vi_tri)
-- Check CCT_GIA_DAT
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '016' err_id,
         'CCT_GIA_DAT' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_gia_dat NOT IN
                    (SELECT   DISTINCT gia FROM tb_pnn_dm_gia_dat)
-- Check CCT_HE_SO
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'CCT_HE_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND cct_he_so < 0
-- Check CCT_GIA_1M2_DAT
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'CCT_GIA_1M2_DAT' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND cct_gia_1m2_dat < 0
--(*) Kiem tra Dien tich data tinh thue
-- Check Dat o
-- Check DATO_DTICH_TRONG_HM
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'DATO_DTICH_TRONG_HM' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND dato_dtich_trong_hm < 0
-- Check DATO_DTICH_DUOI3
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'DATO_DTICH_DUOI3' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND dato_dtich_duoi3 < 0
-- Check DATO_DTICH_VUOT3
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'DATO_DTICH_VUOT3' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND dato_dtich_vuot3 < 0
-- Check DATO_STPN
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'DATO_STPN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND dato_stpn < 0
--Dat o nha Chung cu
--Check CCU_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'CCU_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND ccu_dtich < 0
--Check CCU_STPN
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'CCU_STPN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND ccu_stpn < 0
--Check CCU_HE_SO
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'CCU_HE_SO' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND ccu_he_so < 0
--Dat o san xuat kinh doanh
--Check SKD_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'SKD_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND skd_dtich < 0
--Check SKD_STPN
UNION
SELECT   short_name,
         ROWID rid,
         'SKD_STPN' table_name,
         '014' err_id,
         'SKD_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND skd_stpn < 0
--Dat o su dung khong dung muc dich
--Check SMD_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'SMD_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND smd_dtich < 0
--Check SMD_MA_MD
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'SMD_MA_MD' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND smd_ma_md < 0
--Check SMD_GIA_1M2_DAT
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'SKD_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND smd_gia_1m2_dat < 0
--Check SMD_STPN
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'SMD_STPN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND smd_stpn < 0
--Dat lan chiem
--Check LCH_DTICH
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'LCH_DTICH' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND lch_dtich < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'LCH_GIA_1M2_DAT' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name
         AND lch_gia_1m2_dat < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'LCH_STPN' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND lch_stpn < 0
UNION
SELECT   short_name,
         ROWID rid,
         'TB_TK_SDDPNN' table_name,
         '014' err_id,
         'STPN_TONG' field_name,
         0 update_no
  FROM   tb_tk_sddpnn
 WHERE   short_name = pck_glb_variables.get_short_name AND stpn_tong < 0
)
;

