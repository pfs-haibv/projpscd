-- Start of DDL Script for View TEST.VW_SL_TINH_PHAT
-- Generated 20/09/2013 11:35:12 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_tinh_phat (
   tax_model,
   err_id,
   err_name,
   field_name,
   tin,
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
           "FIELD_NAME",
           "TIN",
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
                     a.field_name,
                     b.tin,
                     b.ma_chuong,
                     b.ma_khoan,
                     b.tmt_ma_tmuc ma_tmuc,
                     b.tkhoan,
                     b.so_tien,
                     b.han_nop,
                     b.ngay_htoan
              FROM   tb_data_error a, tb_tinh_phat b
             WHERE       a.rid = b.ROWID
                     AND a.table_name = 'TB_TINH_PHAT'
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   tax_model, err_id
/

-- End of DDL Script for View TEST.VW_SL_TINH_PHAT

