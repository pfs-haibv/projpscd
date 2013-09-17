-- Start of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_PNN
-- Generated 16/09/2013 11:29:59 AM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_cdoi_dlieu_pnn
IS
    /***************************************************************************
    pck_cdoi_dlieu_pnn.prc_job_pnn_thop_no(p_short_name)
    Noi dung: Tong hop du lieu no
    ***************************************************************************/
    PROCEDURE prc_job_pnn_thop_no (p_short_name VARCHAR2)
    IS
        p_tu         DATE;
        p_tax_code   VARCHAR2 (5);
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot, tax_code
          INTO   p_tu, p_tax_code
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                               ext_pck_pnn.prc_job_pnn_thop_no@PNN'
                         || '('''
                         || p_tu
                         || ''','''
                         || p_tax_code
                         || ''');
                           END;'
                                ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_job_pnn_thop_no');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_pnn.prc_pnn_get_no(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 16/04/2013
    Noi dung: lay thong tin du lieu nop thua
    ***************************************************************************/
    PROCEDURE prc_pnn_get_no (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data
        DELETE FROM   tb_no
              WHERE   short_name = p_short_name AND tax_model = 'PNN-APP';

        --Insert tb_no
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_no a(
                                         a.so_tien,
                                         a.so_qd,
                                         a.ngay_qd,
                                         a.tinh_chat,
                                         a.nguon_goc,
                                         a.han_nop,
                                         a.ngay_htoan,
                                         a.kykk_tu_ngay,
                                         a.kykk_den_ngay,
                                         a.tmt_ma_tmuc,
                                         a.ma_khoan,
                                         a.ma_chuong,
                                         a.tkhoan,
                                         a.tin,
                                         a.ma_tkhai,
                                         a.ma_cqt,
                                         a.short_name,
                                         a.tax_model
                                            )
                    SELECT   b.so_tien,
                             b.so_qd,
                             b.ngay_qd,
                             b.tinh_chat,
                             b.nguon_goc,
                             b.han_nop,
                             b.ngay_hach_toan,
                             b.kykk_tu_ngay,
                             b.kykk_den_ngay,
                             b.tmt_ma_tmuc,
                             b.ma_khoan,
                             b.ma_chuong,
                             b.tkhoan,
                             b.tin,
                             b.ma_tkhai,
                             b.ma_cqt,
                             '''

                         || p_short_name
                         || ''' short_name,
                             ''PNN-APP'' tax_model
                      FROM   ext_pnn_no@pnn b
                      where b.ma_cqt in (SELECT   tax_code
                                              FROM tb_lst_taxo
                                         WHERE short_name = '''

                         || p_short_name
                         || ''')
                      '

                       ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_pnn_get_no');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_pnn.prc_pnn_get_no(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 16/04/2013
    Noi dung: lay thong tin du lieu nop thua
    ***************************************************************************/
    PROCEDURE prc_pnn_get_02tk_sddpnn (p_short_name VARCHAR2)
    IS
        v_ma_cqt varchar2(5);
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   tax_code into v_ma_cqt
                                    FROM   tb_lst_taxo
                                   WHERE   short_name = p_short_name;

        --Clear data
        DELETE FROM   tb_tk_sddpnn a
              WHERE   a.ma_cqt = v_ma_cqt
                      AND a.ma_loai_tk = '02';

        --Insert
        INSERT INTO tb_tk_sddpnn (ma_cqt_par,
                                  ma_cqt,
                                  ma_tkhai,
                                  ltd,
                                  ma_loai_tk,
                                  landau,
                                  bs_lan_thu,
                                  vang_chu,
                                  chuyen_nhuong,
                                  ngay_nop_tk,
                                  trang_thai_tk,
                                  trang_thai_cm,
                                  ma_tkhai_off,
                                  ma_tmuc,
                                  nnt_tin,
                                  nnt_ten_nnt,
                                  nnt_ngcap_mst,
                                  nnt_cap,
                                  nnt_chuong,
                                  nnt_loai,
                                  nnt_khoan,
                                  nnt_ngay_sinh,
                                  nnt_dia_chi,
                                  nnt_ma_tinh,
                                  nnt_ma_huyen,
                                  nnt_ma_xa,
                                  nnt_ma_thon,
                                  nnt_ten_thon,
                                  nnt_cmnd,
                                  nnt_cmnd_ngay_cap,
                                  nnt_cmnd_noi_cap,
                                  nnt_so_dt,
                                  nnt_so_tk,
                                  nnt_ngan_hang,
                                  nnt_nnkt_ctiet,
                                  thd_dia_chi,
                                  thd_ma_tinh,
                                  thd_ma_huyen,
                                  thd_ma_xa,
                                  thd_ma_thon,
                                  thd_gcn,
                                  thd_gcn_so,
                                  thd_gcn_ngay_cap,
                                  thd_thua_dat_so,
                                  thd_ban_do_so,
                                  thd_gcn_dien_tich,
                                  thd_dtich_sd_tte,
                                  thd_gcn_ma_md,
                                  thd_han_muc,
                                  thd_chua_gcn,
                                  thd_chua_gcn_dtich,
                                  thd_chua_gcn_ma_md,
                                  mgi_ma_ly_do,
                                  mgi_ghi_chu,
                                  mgi_so_tien,
                                  cct_dtich_sd_tte,
                                  cct_han_muc,
                                  cct_ma_loai_dat,
                                  cct_ma_duong,
                                  cct_ma_doan_duong,
                                  cct_ma_loai_duong,
                                  cct_ma_vi_tri,
                                  cct_he_so,
                                  cct_ma_gia_dat,
                                  cct_gia_dat,
                                  cct_gia_1m2_dat,
                                  cct_co_bke,
                                  dato_dtich_trong_hm,
                                  dato_dtich_duoi3,
                                  dato_dtich_vuot3,
                                  dato_stpn,
                                  ccu_dtich,
                                  ccu_stpn,
                                  skd_dtich,
                                  skd_stpn,
                                  smd_dtich,
                                  smd_ma_md,
                                  smd_gia_1m2_dat,
                                  smd_stpn,
                                  lch_dtich,
                                  lch_ma_md,
                                  lch_gia_1m2_dat,
                                  lch_stpn,
                                  stpn_truoc_mgi,
                                  stpn_tong,
                                  stpn_clech_bsung,
                                  dkn_nop_5nam,
                                  dkn_so_tien,
                                  ttk_dato_stpn,
                                  ttk_ccu_stpn,
                                  ttk_skd_stpn,
                                  ttk_smd_stpn,
                                  ttk_lch_stpn,
                                  dlt_tin,
                                  dlt_ten_dlt,
                                  dlt_dia_chi,
                                  dlt_ma_tinh,
                                  dlt_ma_huyen,
                                  dlt_ma_xa,
                                  dlt_ma_thon,
                                  dlt_so_dt,
                                  dlt_fax,
                                  dlt_email,
                                  dlt_so_hdong,
                                  dlt_ngay_hdong,
                                  mgi_ty_le,
                                  ccu_he_so,
                                  sthue_pnop,
                                  kytt_tu_ngay,
                                  ngay_htoan,
                                  --thd_gcn_ten_md,
                                  --mgi_ten_ly_do,
                                  short_name)
            SELECT   a.ma_cqt_par,
                     a.ma_cqt,
                     a.ma_tkhai,
                     a.ltd,
                     a.ma_loai_tk,
                     a.landau,
                     a.bs_lan_thu,
                     a.vang_chu,
                     a.chuyen_nhuong,
                     TO_CHAR (a.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                     a.trang_thai_tk,
                     a.trang_thai_cm,
                     a.ma_tkhai_off,
                     a.ma_tmuc,
                     a.nnt_tin,
                     a.nnt_ten_nnt,
                     TO_CHAR (a.nnt_ngcap_mst, 'DD/MM/YYYY') nnt_ngcap_mst,
                     a.nnt_cap,
                     a.nnt_chuong,
                     a.nnt_loai,
                     a.nnt_khoan,
                     TO_CHAR (a.nnt_ngay_sinh, 'DD/MM/YYYY') nnt_ngay_sinh,
                     a.nnt_dia_chi,
                     a.nnt_ma_tinh,
                     a.nnt_ma_huyen,
                     a.nnt_ma_xa,
                     a.nnt_ma_thon,
                     a.nnt_ten_thon,
                     a.nnt_cmnd,
                     TO_CHAR (a.nnt_cmnd_ngay_cap, 'DD/MM/YYYY') nnt_cmnd_ngay_cap,


                     a.nnt_cmnd_noi_cap,
                     a.nnt_so_dt,
                     a.nnt_so_tk,
                     a.nnt_ngan_hang,
                     a.nnt_nnkt_ctiet,
                     a.thd_dia_chi,
                     a.thd_ma_tinh,
                     a.thd_ma_huyen,
                     a.thd_ma_xa,
                     a.thd_ma_thon,
                     a.thd_gcn,
                     a.thd_gcn_so,
                     TO_CHAR (a.thd_gcn_ngay_cap, 'DD/MM/YYYY') thd_gcn_ngay_cap,

                     a.thd_thua_dat_so,
                     a.thd_ban_do_so,
                     a.thd_gcn_dien_tich,
                     a.thd_dtich_sd_tte,
                     a.thd_gcn_ma_md,
                     a.thd_han_muc,
                     a.thd_chua_gcn,
                     a.thd_chua_gcn_dtich,
                     a.thd_chua_gcn_ma_md,
                     a.mgi_ma_ly_do,
                     a.mgi_ghi_chu,
                     a.mgi_so_tien,
                     a.cct_dtich_sd_tte,
                     a.cct_han_muc,
                     a.cct_ma_loai_dat,
                     a.cct_ma_duong,
                     a.cct_ma_doan_duong,
                     a.cct_ma_loai_duong,
                     a.cct_ma_vi_tri,
                     a.cct_he_so,
                     a.cct_ma_gia_dat,
                     a.cct_gia_dat,
                     a.cct_gia_1m2_dat,
                     a.cct_co_bke,
                     a.dato_dtich_trong_hm,
                     a.dato_dtich_duoi3,
                     a.dato_dtich_vuot3,
                     a.dato_stpn,
                     a.ccu_dtich,
                     a.ccu_stpn,
                     a.skd_dtich,
                     a.skd_stpn,
                     a.smd_dtich,
                     a.smd_ma_md,
                     a.smd_gia_1m2_dat,
                     a.smd_stpn,
                     a.lch_dtich,
                     a.lch_ma_md,
                     a.lch_gia_1m2_dat,
                     a.lch_stpn,
                     a.stpn_truoc_mgi,
                     a.stpn_tong,
                     a.stpn_clech_bsung,
                     a.dkn_nop_5nam,
                     a.dkn_so_tien,
                     a.ttk_dato_stpn,
                     a.ttk_ccu_stpn,
                     a.ttk_skd_stpn,
                     a.ttk_smd_stpn,
                     a.ttk_lch_stpn,
                     a.dlt_tin,
                     a.dlt_ten_dlt,
                     a.dlt_dia_chi,
                     a.dlt_ma_tinh,
                     a.dlt_ma_huyen,
                     a.dlt_ma_xa,
                     a.dlt_ma_thon,
                     a.dlt_so_dt,
                     a.dlt_fax,
                     a.dlt_email,
                     a.dlt_so_hdong,
                     TO_CHAR (a.dlt_ngay_hdong, 'DD/MM/YYYY') dlt_ngay_hdong,
                     a.mgi_ty_le,
                     a.ccu_he_so,
                     a.nothue_nhadat sthue_pnop,
                     TO_CHAR (a.ky_tthue, 'DD/MM/YYYY') kytt_tu_ngay,
                     (SELECT   TO_CHAR (LAST_DAY (ky_chot), 'DD/MM/YYYY')
                        FROM   tb_lst_taxo
                       WHERE   short_name = p_short_name)
                         ngay_htoan,
                     --b.ten mgi_ten_ly_do,
                     --c.ten thd_gcn_ten_md,
                     p_short_name short_name
              FROM   pnn_can_cu_tt@pnn a                                   --,
             --pnn_dm_mien_giam@pnn b,
             --pnn_dm_muc_dich_sd@pnn c
             WHERE                                --a.mgi_ma_ly_do = b.ma_lydo
                         --AND a.thd_gcn_ma_md = c.ma_muc_dich
                         a.ma_cqt = v_ma_cqt
                     AND a.ma_loai_tk = '02'
                     AND a.ltd = 0;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name,
                                       'prc_pnn_get_02tk_sddpnn');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_pnn.prc_pnn_get_no(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 16/04/2013
    Noi dung: lay thong tin du lieu nop thua
    ***************************************************************************/
    PROCEDURE prc_pnn_get_01tk_sddpnn (p_short_name VARCHAR2)
    IS
    v_ma_cqt varchar2(5);
    v_province varchar2(3);
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --get tax_code
        SELECT   tax_code, province into v_ma_cqt, v_province
                                       FROM   tb_lst_taxo
                                      WHERE   short_name = p_short_name;

        --Clear data
        DELETE FROM   tb_tk_sddpnn a
              WHERE   a.ma_cqt = v_ma_cqt
                      AND a.ma_loai_tk = '01';


        --Insert thong tin cqt
        INSERT INTO tb_tk_sddpnn (ma_cqt_par,
                                  ma_cqt,
                                  ma_tkhai,
                                  ltd,
                                  ma_loai_tk,
                                  landau,
                                  bs_lan_thu,
                                  vang_chu,
                                  chuyen_nhuong,
                                  ngay_nop_tk,
                                  trang_thai_tk,
                                  trang_thai_cm,
                                  ma_tkhai_off,
                                  ma_tmuc,
                                  nnt_tin,
                                  nnt_ten_nnt,
                                  nnt_ngcap_mst,
                                  nnt_cap,
                                  nnt_chuong,
                                  nnt_loai,
                                  nnt_khoan,
                                  nnt_ngay_sinh,
                                  nnt_dia_chi,
                                  nnt_ma_tinh,
                                  nnt_ma_huyen,
                                  nnt_ma_xa,
                                  nnt_ma_thon,
                                  nnt_ten_thon,
                                  nnt_cmnd,
                                  nnt_cmnd_ngay_cap,
                                  nnt_cmnd_noi_cap,
                                  nnt_so_dt,
                                  nnt_so_tk,
                                  nnt_ngan_hang,
                                  nnt_nnkt_ctiet,
                                  thd_dia_chi,
                                  thd_ma_tinh,
                                  thd_ma_huyen,
                                  thd_ma_xa,
                                  thd_ma_thon,
                                  thd_gcn,
                                  thd_gcn_so,
                                  thd_gcn_ngay_cap,
                                  thd_thua_dat_so,
                                  thd_ban_do_so,
                                  thd_gcn_dien_tich,
                                  thd_dtich_sd_tte,
                                  thd_gcn_ma_md,
                                  thd_han_muc,
                                  thd_chua_gcn,
                                  thd_chua_gcn_dtich,
                                  thd_chua_gcn_ma_md,
                                  mgi_ma_ly_do,
                                  mgi_ghi_chu,
                                  mgi_so_tien,
                                  cct_dtich_sd_tte,
                                  cct_han_muc,
                                  cct_ma_loai_dat,
                                  cct_ma_duong,
                                  cct_ma_doan_duong,
                                  cct_ma_loai_duong,
                                  cct_ma_vi_tri,
                                  cct_he_so,
                                  cct_ma_gia_dat,
                                  cct_gia_dat,
                                  cct_gia_1m2_dat,
                                  cct_co_bke,
                                  dato_dtich_trong_hm,
                                  dato_dtich_duoi3,
                                  dato_dtich_vuot3,
                                  dato_stpn,
                                  ccu_dtich,
                                  ccu_stpn,
                                  skd_dtich,
                                  skd_stpn,
                                  smd_dtich,
                                  smd_ma_md,
                                  smd_gia_1m2_dat,
                                  smd_stpn,
                                  lch_dtich,
                                  lch_ma_md,
                                  lch_gia_1m2_dat,
                                  lch_stpn,
                                  stpn_truoc_mgi,
                                  stpn_tong,
                                  stpn_clech_bsung,
                                  dkn_nop_5nam,
                                  dkn_so_tien,
                                  ttk_dato_stpn,
                                  ttk_ccu_stpn,
                                  ttk_skd_stpn,
                                  ttk_smd_stpn,
                                  ttk_lch_stpn,
                                  dlt_tin,
                                  dlt_ten_dlt,
                                  dlt_dia_chi,
                                  dlt_ma_tinh,
                                  dlt_ma_huyen,
                                  dlt_ma_xa,
                                  dlt_ma_thon,
                                  dlt_so_dt,
                                  dlt_fax,
                                  dlt_email,
                                  dlt_so_hdong,
                                  dlt_ngay_hdong,
                                  mgi_ty_le,
                                  ccu_he_so,
                                  sthue_pnop,
                                  kytt_tu_ngay,
                                  ngay_htoan,
                                  --thd_gcn_ten_md,
                                  --mgi_ten_ly_do,
                                  short_name)
            SELECT   a.ma_cqt_par,
                     a.ma_cqt,
                     a.ma_tkhai,
                     a.ltd,
                     a.ma_loai_tk,
                     a.landau,
                     a.bs_lan_thu,
                     a.vang_chu,
                     a.chuyen_nhuong,
                     TO_CHAR (a.ngay_nop, 'DD/MM/YYYY') ngay_nop_tk,
                     a.trang_thai_tk,
                     a.trang_thai_cm,
                     a.ma_tkhai_off,
                     a.ma_tmuc,
                     a.nnt_tin,
                     a.nnt_ten_nnt,
                     TO_CHAR (a.nnt_ngcap_mst, 'DD/MM/YYYY') nnt_ngcap_mst,
                     a.nnt_cap,
                     a.nnt_chuong,
                     a.nnt_loai,
                     a.nnt_khoan,
                     TO_CHAR (a.nnt_ngay_sinh, 'DD/MM/YYYY') nnt_ngay_sinh,
                     a.nnt_dia_chi,
                     a.nnt_ma_tinh,
                     a.nnt_ma_huyen,
                     a.nnt_ma_xa,
                     a.nnt_ma_thon,
                     a.nnt_ten_thon,
                     a.nnt_cmnd,
                     TO_CHAR (a.nnt_cmnd_ngay_cap, 'DD/MM/YYYY') nnt_cmnd_ngay_cap,
                     a.nnt_cmnd_noi_cap,
                     a.nnt_so_dt,
                     a.nnt_so_tk,
                     a.nnt_ngan_hang,
                     a.nnt_nnkt_ctiet,
                     a.thd_dia_chi,
                     a.thd_ma_tinh,
                     a.thd_ma_huyen,
                     a.thd_ma_xa,
                     a.thd_ma_thon,
                     a.thd_gcn,
                     a.thd_gcn_so,
                     TO_CHAR (a.thd_gcn_ngay_cap, 'DD/MM/YYYY') thd_gcn_ngay_cap,
                     a.thd_thua_dat_so,
                     a.thd_ban_do_so,
                     a.thd_gcn_dien_tich,
                     a.thd_dtich_sd_tte,
                     a.thd_gcn_ma_md,
                     a.thd_han_muc,
                     a.thd_chua_gcn,
                     a.thd_chua_gcn_dtich,
                     a.thd_chua_gcn_ma_md,
                     a.mgi_ma_ly_do,
                     a.mgi_ghi_chu,
                     a.mgi_so_tien,
                     a.cct_dtich_sd_tte,
                     a.cct_han_muc,
                     a.cct_ma_loai_dat,
                     a.cct_ma_duong,
                     a.cct_ma_doan_duong,
                     a.cct_ma_loai_duong,
                     a.cct_ma_vi_tri,
                     a.cct_he_so,
                     a.cct_ma_gia_dat,
                     a.cct_gia_dat,
                     a.cct_gia_1m2_dat,
                     a.cct_co_bke,
                     a.dato_dtich_trong_hm,
                     a.dato_dtich_duoi3,
                     a.dato_dtich_vuot3,
                     a.dato_stpn,
                     a.ccu_dtich,
                     a.ccu_stpn,
                     a.skd_dtich,
                     a.skd_stpn,
                     a.smd_dtich,
                     a.smd_ma_md,
                     a.smd_gia_1m2_dat,
                     a.smd_stpn,
                     a.lch_dtich,
                     a.lch_ma_md,
                     a.lch_gia_1m2_dat,
                     a.lch_stpn,
                     a.stpn_truoc_mgi,
                     a.stpn_tong,
                     a.stpn_clech_bsung,
                     a.dkn_nop_5nam,
                     a.dkn_so_tien,
                     a.ttk_dato_stpn,
                     a.ttk_ccu_stpn,
                     a.ttk_skd_stpn,
                     a.ttk_smd_stpn,
                     a.ttk_lch_stpn,
                     a.dlt_tin,
                     a.dlt_ten_dlt,
                     a.dlt_dia_chi,
                     a.dlt_ma_tinh,
                     a.dlt_ma_huyen,
                     a.dlt_ma_xa,
                     a.dlt_ma_thon,
                     a.dlt_so_dt,
                     a.dlt_fax,
                     a.dlt_email,
                     a.dlt_so_hdong,
                     TO_CHAR (a.dlt_ngay_hdong, 'DD/MM/YYYY') dlt_ngay_hdong,
                     a.mgi_ty_le,
                     a.ccu_he_so,
                     a.nothue_nhadat sthue_pnop,
                     TO_CHAR (a.ky_kkhai, 'DD/MM/YYYY') ky_kkhai_tu_ngay,
                     (SELECT   TO_CHAR (LAST_DAY (ky_chot), 'DD/MM/YYYY')
                        FROM   tb_lst_taxo
                       WHERE   short_name = p_short_name)
                         ngay_htoan,
                     --b.ten mgi_ten_ly_do,
                     --c.ten thd_gcn_ten_md,
                     p_short_name short_name
              FROM   pnn_can_cu_tt@pnn a                                   --,
             --pnn_dm_mien_giam@pnn b,
             --pnn_dm_muc_dich_sd@pnn c
             WHERE                                --a.mgi_ma_ly_do = b.ma_lydo
                         --AND a.thd_gcn_ma_md = c.ma_muc_dich
                         -- AND
                         a.ma_cqt = v_ma_cqt
                     AND a.ma_loai_tk = '01'
                     AND a.ltd = 0;

        --Insert thong tin nnt
        INSERT INTO tb_tk_sddpnn_01_nnt (ma_cqt_par,
                                         ma_cqt,
                                         ky_tthue,
                                         ma_tkhai,
                                         ltd,
                                         trang_thai_cm,
                                         ma_mo_rong,
                                         so_hieu_tep,
                                         loai_dky,
                                         ngay_nop,
                                         nnt_tin,
                                         nnt_ten_nnt,
                                         nnt_ngay_sinh,
                                         nnt_dia_chi,
                                         nnt_ma_tinh,
                                         nnt_ma_huyen,
                                         nnt_ma_xa,
                                         nnt_ma_thon,
                                         nnt_ten_thon,
                                         nnt_cmnd,
                                         nnt_cmnd_ngay_cap,
                                         nnt_cmnd_noi_cap,
                                         nnt_quoc_tich,
                                         nnt_so_dt,
                                         nnt_so_tk,
                                         nnt_ngan_hang,
                                         dlt_tin,
                                         dlt_ten_dlt,
                                         dlt_dia_chi,
                                         dlt_ma_tinh,
                                         dlt_ma_huyen,
                                         dlt_ma_xa,
                                         dlt_ma_thon,
                                         dlt_so_dt,
                                         dlt_fax,
                                         dlt_email,
                                         dlt_so_hdong,
                                         dlt_ngay_hdong,
                                         thd_dia_chi,
                                         thd_ma_tinh,
                                         thd_ma_huyen,
                                         thd_ma_xa,
                                         thd_ma_thon,
                                         thd_duy_nhat,
                                         thd_ma_huyen_kkth,
                                         thd_gcn,
                                         thd_gcn_so,
                                         thd_gcn_ngay_cap,
                                         thd_thua_dat_so,
                                         thd_ban_do_so,
                                         thd_gcn_dien_tich,
                                         thd_gcn_ma_md,
                                         thd_tong_dtich_tte,
                                         thd_dtich_dung_md,
                                         thd_dtich_sai_md,
                                         thd_han_muc,
                                         thd_dtich_lan_chiem,
                                         thd_chua_gcn,
                                         thd_chua_gcn_dtich,
                                         thd_chua_gcn_ma_md,
                                         ccu_loai_nha,
                                         ccu_dtich,
                                         ccu_heso,
                                         mgi_ma_ly_do,
                                         mgi_ghi_chu,
                                         dkn_dknt,
                                         dkn_sonam,
                                         --thd_gcn_ten_md,
                                         --thd_chua_gcn_ten_md,
                                         --mgi_ten_ly_do
                                         short_name)
            SELECT   a.ma_cqt_par,
                     a.ma_cqt,
                     to_char(a.ky_tthue, 'DD/MM/YYYY') ky_tthue,
                     a.ma_tkhai,
                     a.ltd,
                     a.trang_thai_cm,
                     a.ma_mo_rong,
                     a.so_hieu_tep,
                     a.loai_dky,
                     TO_CHAR (a.ngay_nop, 'DD/MM/YYYY') ngay_nop,
                     a.nnt_tin,
                     a.nnt_ten_nnt,
                     TO_CHAR (a.nnt_ngay_sinh, 'DD/MM/YYYY') nnt_ngay_sinh,
                     a.nnt_dia_chi,
                     a.nnt_ma_tinh,
                     a.nnt_ma_huyen,
                     a.nnt_ma_xa,
                     a.nnt_ma_thon,
                     a.nnt_ten_thon,
                     a.nnt_cmnd,
                     TO_CHAR (a.nnt_cmnd_ngay_cap, 'DD/MM/YYYY') nnt_cmnd_ngay_cap,
                     a.nnt_cmnd_noi_cap,
                     a.nnt_quoc_tich,
                     a.nnt_so_dt,
                     a.nnt_so_tk,
                     a.nnt_ngan_hang,
                     a.dlt_tin,
                     a.dlt_ten_dlt,
                     a.dlt_dia_chi,
                     a.dlt_ma_tinh,
                     a.dlt_ma_huyen,
                     a.dlt_ma_xa,
                     a.dlt_ma_thon,
                     a.dlt_so_dt,
                     a.dlt_fax,
                     a.dlt_email,
                     a.dlt_so_hdong,
                     TO_CHAR (a.dlt_ngay_hdong, 'DD/MM/YYYY') dlt_ngay_hdong,
                     a.thd_dia_chi,
                     a.thd_ma_tinh,
                     a.thd_ma_huyen,
                     a.thd_ma_xa,
                     a.thd_ma_thon,
                     a.thd_duy_nhat,
                     a.thd_ma_huyen_kkth,
                     a.thd_gcn,
                     a.thd_gcn_so,
                     TO_CHAR (a.thd_gcn_ngay_cap, 'DD/MM/YYYY') thd_gcn_ngay_cap,
                     a.thd_thua_dat_so,
                     a.thd_ban_do_so,
                     a.thd_gcn_dien_tich,
                     a.thd_gcn_ma_md,
                     a.thd_tong_dtich_tte,
                     a.thd_dtich_dung_md,
                     a.thd_dtich_sai_md,
                     a.thd_han_muc,
                     a.thd_dtich_lan_chiem,
                     a.thd_chua_gcn,
                     a.thd_chua_gcn_dtich,
                     a.thd_chua_gcn_ma_md,
                     a.ccu_loai_nha,
                     a.ccu_dtich,
                     a.ccu_heso,
                     a.mgi_ma_ly_do,
                     a.mgi_ghi_chu,
                     a.dkn_dknt,
                     a.dkn_sonam,
                     p_short_name
              FROM   pnn_tkhai@pnn a, pnn_can_cu_tt@pnn b
             WHERE       a.ma_cqt_par = b.ma_cqt_par
                     AND a.ma_cqt = b.ma_cqt
                     AND a.ma_tkhai = b.ma_tkhai
                     AND a.ltd = b.ltd
                     AND b.ma_cqt = v_ma_cqt
                     AND b.ma_loai_tk = '01'
                     AND b.ltd = 0;
                     --bo sung dieu kien lay to khai da hach toan

        --Dong bo danh muc dung
        pck_cdoi_dlieu_pnn.prc_pnn_sync_dmuc_tms(v_province, v_ma_cqt);

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_pnn_get_01tk_sddpnn');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;

    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_pnn.prc_pnn_get_dmuc_pnn(p_short_name)
    Nguoi thuc hien: Administrator
    Ngay thuc hien: 28/08/2013
    Noi dung: lay thong tin du lieu danh muc
                >   Danh muc to thon
                >   Danh muc gia dat
                >   Danh muc duong/vung
                >   Danh muc doan duong/ khu vuc
                >   Danh muc vi tri/ hang muc

    ***************************************************************************/
    PROCEDURE prc_pnn_get_dmuc_pnn (p_short_name VARCHAR2)
    IS
    v_province varchar2(3);
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Get tax code
        SELECT   province into v_province
                                       FROM   tb_lst_taxo
                                      WHERE   short_name = p_short_name;
        /* Step 1: Clear data */
        --01. Danh muc thon
        DELETE from tb_pnn_dm_thon a where a.ma_tinh = v_province;
        --02. Danh muc gia dat
        DELETE from tb_pnn_dm_gia_dat a where a.ma_tinh = v_province;
        --03. Danh muc duong/vung
        DELETE from tb_pnn_dm_ten_duong a where a.ma_tinh = v_province;
        --04. Danh muc doan duong
        DELETE from TB_PNN_DM_DOAN_DUONG a where substr(a.ma_huyen,1,3) = v_province;
        --05. Danh muc vi tri
        DELETE from tb_pnn_dm_vi_tri a where a.ma_tinh = v_province;


        /* Step 2: Insert danh muc */
        --01. Danh muc thon
        INSERT INTO tb_pnn_dm_thon select * from  pnn_dm_thon@pnn;
        --02. Danh muc gia dat
        INSERT INTO tb_pnn_dm_gia_dat select * from pnn_dm_gia_dat@pnn;
        --03. Danh muc duong/vung
        INSERT INTO tb_pnn_dm_ten_duong select * from pnn_dm_ten_duong@pnn;
        --04. Danh muc doan duong
        INSERT INTO TB_PNN_DM_DOAN_DUONG select * from PNN_DM_DOAN_DUONG@pnn;
        --05. Danh muc vi tri
        INSERT INTO tb_pnn_dm_vi_tri select * from pnn_dm_vi_tri@pnn;

        --commit
        COMMIT;

    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);

    END;
    /**
     *Thuc hien lay ma map nhu ma loai dat, ma loai duong cua TMS
     *<p> tu bang map danh muc
     *@author Administrator
     *@date 16/09/2013
     *@param v_ma
     *@param v_tbl_map
     *@param v_ma_tinh
     *@see pck_cdoi_dlieu_pnn.prc_pnn_get_data_tms
     *@return v_get_key_tms
     */

    FUNCTION fnc_pnn_get_data_tms (p_ma varchar2, p_tbl_map varchar2, p_ma_tinh varchar2)

    RETURN VARCHAR2
    IS
        v_get_key_tms varchar2(3);
    BEGIN
        --Kiem tra null
        if(p_ma is null or p_tbl_map is null or p_ma_tinh is null) then
            v_get_key_tms := null;
        else
            if (upper(p_tbl_map) = upper('tb_pnn_dm_loai_dat')) then
                --Lay ma_loai_dat_tms trong danh muc tb_pnn_dm_loai_dat
                EXECUTE IMMEDIATE 'SELECT   a.ma_loai_dat_tms
                                   FROM   '||p_tbl_map||' a
                                   WHERE   a.ma_loai_dat = '''||p_ma||'''
                                   AND a.ma_tinh = '''||p_ma_tinh||''' and rownum = 1' into v_get_key_tms;
            else
                --Lay ma_loai_duong_tms trong danh muc tb_pnn_dm_loai_duong
                EXECUTE IMMEDIATE 'SELECT   a.ma_loai_duong_tms
                                   FROM   tb_pnn_dm_loai_duong a
                                   WHERE   a.ma_loai_duong = '''||p_ma||'''
                                   AND a.ma_tinh = '''||p_ma_tinh||''' and rownum = 1' into v_get_key_tms;
            end if;

        end if;

        return v_get_key_tms;

        EXCEPTION
            WHEN OTHERS

            THEN
                pck_trace_log.prc_ins_log (p_tbl_map, pck_trace_log.fnc_whocalledme);
     END;

     /**
      *Thuc hien dong bo ma loai dat, ma loai duong tu ma he thong cu
      *<p> len su dung ma loai dat, ma loai duong chung tren he thong tms
      *@author Adminstrator
      *@date 16/09/2013
      *@param p_short_name
      *@see pck_cdoi_dlieu_pnn.prc_pnn_sync_dmuc_tms
      */

     PROCEDURE prc_pnn_sync_dmuc_tms (p_ma_tinh VARCHAR2, p_taxo VARCHAR2)
     IS
        --data pnn danh muc loai dat
        cursor c_pnn_dm_loai_dat
        is
            select * from tb_pnn_dm_loai_dat a where a.ma_tinh = p_ma_tinh;

        --data pnn danh muc loai duong
        cursor c_pnn_dm_loai_duong
        is
            select * from tb_pnn_dm_loai_duong a where a.ma_tinh = p_ma_tinh;

     BEGIN

         --Update danh muc loai dat
         FOR vc_pnn_dm_loai_dat IN c_pnn_dm_loai_dat
            LOOP
                update tb_tk_sddpnn set cct_ma_loai_dat_tms = vc_pnn_dm_loai_dat.ma_loai_dat_tms
                where ma_cqt = p_taxo
                  and cct_ma_loai_dat = vc_pnn_dm_loai_dat.ma_loai_dat;
         END LOOP;

         --Update danh muc loai duong
         FOR vc_pnn_dm_loai_duong IN c_pnn_dm_loai_duong
            LOOP
                update tb_tk_sddpnn set cct_ma_loai_duong_tms = vc_pnn_dm_loai_duong.ma_loai_duong_tms
                where ma_cqt = p_taxo
                  and cct_ma_loai_duong = vc_pnn_dm_loai_duong.ma_loai_duong;
         END LOOP;

     END;


END;
/


-- End of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_PNN

