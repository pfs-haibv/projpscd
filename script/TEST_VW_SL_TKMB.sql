-- Start of DDL Script for View TEST.VW_SL_TKMB
-- Generated 18/09/2013 11:12:10 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_tkmb (
   tax_model,
   err_id,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ten_nnt,
   kytt_tu_ngay,
   kytt_den_ngay,
   ngay_htoan,
   ngay_nop_tk,
   han_nop,
   thue_pn_nnt,
   thue_pn_cqt,
   von_dky_nnt,
   von_dky_cqt,
   bmb_nnt,
   bmb_cqt,
   tong_thue_pn_nnt,
   tong_thue_pn_cqt )
AS
SELECT   "TAX_MODEL",
           "ERR_ID",
           "ERR_NAME",
           "MA_CBO",
           "TEN_CBO",
           "MA_PBAN",
           "TEN_PBAN",
           "TIN",
           "TEN_NNT",
           "KYTT_TU_NGAY",
           "KYTT_DEN_NGAY",
           "NGAY_HTOAN",
           "NGAY_NOP_TK",
           "HAN_NOP",
           "THUE_PN_NNT",
           "THUE_PN_CQT",
           "VON_DKY_NNT",
           "VON_DKY_CQT",
           "BMB_NNT",
           "BMB_CQT",
           "TONG_THUE_PN_NNT",
           "TONG_THUE_PN_CQT"
           
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
                     b.ten_nnt,
                     b.kytt_tu_ngay,
                     b.kytt_den_ngay,
                     b.ngay_htoan,
                     b.ngay_nop_tk,
                     b.han_nop,
                     b.thue_pn_nnt,
                     b.thue_pn_cqt,
                     b.von_dky_nnt,
                     b.von_dky_cqt,
                     b.bmb_nnt,
                     b.bmb_cqt,
                     b.tong_thue_pn_nnt,
                     b.tong_thue_pn_cqt
              FROM   tb_data_error a, tb_tkmb_hdr b
             WHERE       a.rid = b.ROWID
                     AND a.table_name = 'TB_TKMB_HDR'
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   tax_model, err_id


