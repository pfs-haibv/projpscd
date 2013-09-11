-- Start of DDL Script for View TEST.VW_SL_TK_SDDPNN
-- Generated 11/09/2013 4:58:47 PM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_tk_sddpnn (
   err_id,
   err_name,
   tin,
   kytt_tu_ngay,
   kytt_den_ngay,
   ngay_htoan,
   ma_tkhai,
   ltd,
   ma_loai_tk,
   ngay_nop_tk,
   ma_tmuc )
AS
SELECT     "ERR_ID",
           "ERR_NAME",
           "TIN",
           "KYTT_TU_NGAY",
           "KYTT_DEN_NGAY",
           "NGAY_HTOAN",
           "MA_TKHAI",
           "LTD",
           "MA_LOAI_TK",
           "NGAY_NOP_TK",
           "MA_TMUC"
    FROM   (SELECT    a.err_id err_id,
                     (SELECT   c.err_name
                        FROM   tb_lst_err c
                       WHERE   a.err_id = c.err_id)
                     err_name,                     
                     b.nnt_tin tin,
                     b.kytt_tu_ngay,
                     b.kytt_den_ngay,
                     b.ngay_htoan,
                     b.ma_tkhai,
                     b.ltd,
                     b.ma_loai_tk,
                     b.ngay_nop_tk,
                     b.ma_tmuc
              FROM   tb_data_error a, tb_tk_sddpnn b
             WHERE       a.rid = b.ROWID
                     AND a.table_name in ('TB_TK_SDDPNN','TB_TK_SDDPNN_01_NNT')
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   err_id, ma_tkhai
/

-- End of DDL Script for View TEST.VW_SL_TK_SDDPNN

