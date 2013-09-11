-- Start of DDL Script for View TEST.VW_SL_DKNTK
-- Generated 11/09/2013 8:15:00 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_dkntk (
   tax_model,
   err_id,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ma_tkhai,
   ky_bat_dau,
   ky_ket_thuc )
AS
SELECT     "TAX_MODEL",
           "ERR_ID",
           "ERR_NAME",
           "MA_CBO",
           "TEN_CBO",
           "MA_PBAN",
           "TEN_PBAN",
           "TIN",
           "MA_TKHAI",
           "KY_BAT_DAU",
           "KY_KET_THUC"          
    FROM   (SELECT   b.tax_model,
                     a.err_id err_id,
                     (SELECT   c.err_name
                        FROM   tb_lst_err c
                       WHERE   a.err_id = c.err_id)
                     err_name,
                     b.ma_cbo,
                     b.ten_cbo,
                     b.ma_pban,
                     b.ten_pban,
                     b.tin,
                     b.ma_tkhai,
                     b.ky_bd_hthong_cu as ky_bat_dau,
                     b.ky_kt_hthong_cu as ky_ket_thuc
              FROM   tb_data_error a, tb_dkntk b
             WHERE       a.rid = b.ROWID
                     AND a.table_name = 'TB_DKNTK'
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   tax_model, err_id, ma_tkhai
/

-- End of DDL Script for View TEST.VW_SL_DKNTK

