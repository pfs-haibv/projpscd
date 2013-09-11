-- Start of DDL Script for View TEST.VW_CHECK_TB_DKNTK
-- Generated 11/09/2013 8:16:48 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_check_tb_dkntk (
   short_name,
   rid,
   table_name,
   err_id,
   field_name,
   update_no )
AS
(--Check loai tk ton tai
 SELECT   short_name,
          ROWID rid,
          'TB_DKNTK' table_name,
          '010' err_id,
          'MA_TKHAI' field_name,
          0 update_no
   FROM   tb_dkntk
  WHERE   short_name = pck_glb_variables.get_short_name
          AND ma_tkhai NOT IN
                     (SELECT   ma
                        FROM   tb_dmuc_tkhai
                       WHERE   tax_model = 'QLT-APP'
                               AND flg_dkntk IS NOT NULL)
 --Chech ky_bat_dau thuoc nam chuyen doi du lieu
 UNION all
 SELECT   short_name,
          ROWID rid,
          'TB_DKNTK' table_name,
          '011' err_id,
          'ky_bd_hthong_cu' field_name,
          0 update_no
   FROM   tb_dkntk
  WHERE   short_name = pck_glb_variables.get_short_name
          AND substr(ky_bd_hthong_cu, -4)  <>
              substr(pck_glb_variables.get_ky_chot, -4)
 /*
 UNION
 --ky ket thuc thuoc nam chuyen doi du lieu; ky ket thuc > ky bat dau
 SELECT   short_name,
          ROWID rid,
          'TB_DKNTK' table_name,
          '011' err_id,
          'ky_kt_hthong_cu' field_name,
          '0' update_no
   FROM   tb_dkntk
  WHERE   short_name = pck_glb_variables.get_short_name
          AND TRUNC (TO_DATE (ky_kt_hthong_cu, 'DD/MM/YYYY'), 'YYYY') <>
              TRUNC (TO_DATE (pck_glb_variables.get_ky_chot, 'DD/MM/YYYY'),'YYYY')
  */
)
/

-- End of DDL Script for View TEST.VW_CHECK_TB_DKNTK

