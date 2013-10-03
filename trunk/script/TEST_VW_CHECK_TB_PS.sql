-- Start of DDL Script for View TEST.VW_CHECK_TB_PS
-- Generated 03/10/2013 2:29:07 PM from TEST@DCNC

CREATE OR REPLACE VIEW vw_check_tb_ps (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no,
   ma_cqt,
   check_app )
AS
(--Check ma_tk ton tai trong danh muc
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '010' err_id,
         'ma_tkhai' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_tkhai NOT IN (SELECT   ma
                                FROM   tb_dmuc_tkhai
                               WHERE   flg_ps IS NOT NULL)
--Check kykk_tu_ngay kykk_den_ngay
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '012' err_id,
         'kykk_tu_ngay kykk_den_ngay' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ( TRUNC (TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY'), 'YYYY') <>
               TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'), 'YYYY')
         OR TRUNC (TO_DATE (kykk_den_ngay, 'DD/MM/YYYY'), 'YYYY') <>
            TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'), 'YYYY')
         OR TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY') <>
            TRUNC (TO_DATE (kykk_tu_ngay, 'DD/MM/YYYY'))
         OR TO_DATE (kykk_den_ngay, 'DD/MM/YYYY') <>
            TRUNC (TO_DATE (kykk_den_ngay, 'DD/MM/YYYY'))
         )
--Check tkhoan
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '007' err_id,
         'tkhoan' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name AND tkhoan <> '741'
--Check ngay_htoan
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '012' err_id,
         'tkhoan' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name
         AND TO_DATE (ngay_htoan, 'DD/MM/YYYY') <>
             LAST_DAY (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'))
--Check ma_chuong ton tai trong danh muc
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '005' err_id,
         'ma_chuong' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name
         AND ma_chuong NOT IN (SELECT ma_chuong FROM tb_dmuc_capchuong)
--Check ma_khoan 000
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '005' err_id,
         'ma_khoan' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name AND ma_khoan <> '000'
--Check so_tien khong am
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '014' err_id,
         'so_tien' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name AND so_tien < 0
--Check tieu muc hoach toan phai dung voi loai to khai
UNION
SELECT   short_name,
         ROWID rid,
         'TB_PS' table_name,
         '007' err_id,
         'ma_tmuc, ma_tkhai' field_name,
         0 update_no,
          ma_cqt,
          'ORA' check_app
  FROM   tb_ps
 WHERE   short_name = pck_glb_variables.get_short_name
    OR ( ma_tkhai = '11' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '11' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '12' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '12' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '24' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '24' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '26' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '26' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '37' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '37' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '47' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '47' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '72' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '72' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '74' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '74' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '75' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '75' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '76' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '76' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '77' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '77' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '78' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '78' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '80' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '80' AND tmuc_ps IS NOT NULL))
    OR ( ma_tkhai = '82' and ma_tmuc not in ( SELECT   tmuc_ps  FROM   tb_dmuc_tkhai a WHERE   ma = '82' AND tmuc_ps IS NOT NULL))
)
/

-- End of DDL Script for View TEST.VW_CHECK_TB_PS

