-- Start of DDL Script for View TEST.VW_SL_PS
-- Generated 11/09/2013 8:14:43 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_ps (
   tax_model,
   err_id,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ma_tkhai,
   ma_chuong,
   ma_khoan,
   ma_tmuc,
   tkhoan,
   so_tien,
   han_nop,
   ngay_htoan )
AS
SELECT   "TAX_MODEL",
           "ERR_ID",
           "ERR_NAME",
           "MA_CBO",
           "TEN_CBO",
           "MA_PBAN",
           "TEN_PBAN",
           "TIN",
           "MA_TKHAI",
           "MA_CHUONG",
           "MA_KHOAN",
           "MA_TMUC",
           "TKHOAN",
           "SO_TIEN",
           "HAN_NOP",
           "NGAY_HTOAN"
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
                     b.ma_chuong,
                     b.ma_khoan,
                     b.ma_tmuc,
                     b.tkhoan,
                     b.so_tien,
                     b.han_nop,
                     b.ngay_htoan
              FROM   tb_data_error a, tb_ps b
             WHERE       a.rid = b.ROWID
                     AND a.table_name = 'TB_PS'
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   tax_model, err_id, ma_tkhai
/

-- End of DDL Script for View TEST.VW_SL_PS

