-- Start of DDL Script for View TEST.VW_SL_NO
-- Generated 11/09/2013 8:14:09 AM from TEST@DCNC

CREATE OR REPLACE VIEW vw_sl_no (
   tax_model,
   err_id,
   err_name,
   ma_cbo,
   ten_cbo,
   ma_pban,
   ten_pban,
   tin,
   ma_chuong,
   ma_khoan,
   tmt_ma_tmuc,
   tkhoan,
   ngay_hach_toan,
   kykk_tu_ngay,
   kykk_den_ngay,
   han_nop,
   no_cuoi_ky )
AS
SELECT   tax_model, err_id, err_name, ma_cbo, ten_cbo, ma_pban, ten_pban, tin,
         ma_chuong, ma_khoan, tmt_ma_tmuc, tkhoan, ngay_hach_toan,
         kykk_tu_ngay, kykk_den_ngay, han_nop, no_cuoi_ky
    FROM (SELECT b.tax_model, a.err_id,
                 (SELECT c.err_name
                    FROM tb_lst_err c
                   WHERE a.err_id = c.err_id) err_name,
                 b.ma_cbo, b.ten_cbo, b.ma_pban, b.ten_pban, b.tin,
                 b.ma_chuong, b.ma_khoan, b.tmt_ma_tmuc, b.tkhoan,
                 'bo ngay_hach_toan' ngay_hach_toan, b.kykk_tu_ngay, b.kykk_den_ngay, b.han_nop,
                 null as no_cuoi_ky
            FROM tb_data_error a, tb_no b
           WHERE a.rid = b.ROWID
             AND a.table_name = 'TB_NO'
             AND a.short_name = b.short_name
             AND a.update_no = 0
             AND b.short_name = USERENV ('client_info')
             /*
          UNION
          SELECT a.loai tax_model, NULL err_id, (SELECT b.rv_note
                                                   FROM tb_01_para b
                                                  WHERE b.rv_num = 6)
                                                                     err_name,
                 a.ma_cbo, a.ten_cbo, a.ma_pban, a.ten_pban, a.tin tin,
                 NULL ma_chuong, NULL ma_khoan, a.tieumuc tmt_ma_tmuc,
                 a.tai_khoan tkhoan, NULL ngay_hach_toan, NULL kykk_tu_ngay,
                 NULL kykk_den_ngay, NULL han_nop, a.sono_no_cky no_cuoi_ky
            FROM tb_slech_no a
           WHERE a.short_name = USERENV ('client_info') and a.ma_slech=6
            */
           )
ORDER BY tax_model, err_id
/

-- End of DDL Script for View TEST.VW_SL_NO

