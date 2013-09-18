-- Start of DDL Script for View TEST.VW_SL_01_THKH
-- Generated 18/09/2013 1:52:14 PM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_01_thkh (
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
   doanh_thu,
   gtgt_chiu_thue,
   thue_gtgt,
   thue_suat_gtgt )
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
           "DOANH_THU",
           "GTGT_CHIU_THUE",
           "THUE_GTGT",
           "THUE_SUAT_GTGT"
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
                    (decode(b.doanh_thu_ts_5, null, 0, b.doanh_thu_ts_5) + 
                     decode(b.doanh_thu_ts_10, null, 0, b.doanh_thu_ts_10) ) doanh_thu,
                     (decode(b.gtgt_chiu_thue_ts_5, null, 0, b.gtgt_chiu_thue_ts_5) + 
                     decode(b.gtgt_chiu_thue_ts_10, null, 0, b.gtgt_chiu_thue_ts_10) ) gtgt_chiu_thue,
                     (decode(b.thue_gtgt_ts_5, null, 0, b.thue_gtgt_ts_5) + 
                     decode(b.thue_gtgt_ts_10, null, 0, b.thue_gtgt_ts_10) ) thue_gtgt,
                     b.tsgtgt THUE_SUAT_GTGT
              FROM   tb_data_error a, tb_01_thkh_hdr b
             WHERE       a.rid = b.ROWID
                     AND a.table_name = 'TB_01_THKH_HDR'
                     AND a.short_name = b.short_name
                     AND b.short_name = USERENV ('client_info')
                     AND a.update_no = 0)
ORDER BY   tax_model, err_id
/

-- End of DDL Script for View TEST.VW_SL_01_THKH

