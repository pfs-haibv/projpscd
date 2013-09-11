-- Start of DDL Script for Table TEST.TB_TK_SDDPNN
-- Generated 11/09/2013 4:03:12 PM from TEST@DCNC

CREATE TABLE tb_tk_sddpnn
    (ma_cqt_par                     VARCHAR2(5 CHAR) ,
    ma_cqt                         VARCHAR2(5 CHAR) ,
    kytt_tu_ngay                   VARCHAR2(15 BYTE),
    kytt_den_ngay                  VARCHAR2(15 BYTE),
    ngay_htoan                     VARCHAR2(15 BYTE),
    ma_tkhai                       VARCHAR2(22 CHAR) ,
    ltd                            NUMBER(*,0) ,
    ma_loai_tk                     VARCHAR2(2 CHAR),
    landau                         NUMBER(*,0),
    bs_lan_thu                     NUMBER(4,0),
    vang_chu                       NUMBER(*,0),
    chuyen_nhuong                  NUMBER(*,0),
    ngay_nop_tk                    VARCHAR2(15 BYTE),
    trang_thai_tk                  VARCHAR2(2 CHAR),
    trang_thai_cm                  VARCHAR2(2 CHAR),
    ma_tkhai_off                   VARCHAR2(22 CHAR),
    ma_tmuc                        VARCHAR2(4 CHAR),
    nnt_tin                        VARCHAR2(14 CHAR),
    nnt_ten_nnt                    VARCHAR2(300 CHAR),
    nnt_ngcap_mst                  VARCHAR2(15 BYTE),
    nnt_cap                        VARCHAR2(1 CHAR),
    nnt_chuong                     VARCHAR2(3 CHAR),
    nnt_loai                       VARCHAR2(3 CHAR),
    nnt_khoan                      VARCHAR2(3 CHAR),
    nnt_ngay_sinh                  VARCHAR2(15 BYTE),
    nnt_dia_chi                    VARCHAR2(300 CHAR),
    nnt_ma_tinh                    VARCHAR2(3 CHAR),
    nnt_ma_huyen                   VARCHAR2(5 CHAR),
    nnt_ma_xa                      VARCHAR2(7 CHAR),
    nnt_ma_thon                    VARCHAR2(9 CHAR),
    nnt_ten_thon                   VARCHAR2(100 CHAR),
    nnt_cmnd                       VARCHAR2(300 CHAR),
    nnt_cmnd_ngay_cap              VARCHAR2(15 BYTE),
    nnt_cmnd_noi_cap               VARCHAR2(100 CHAR),
    nnt_so_dt                      VARCHAR2(20 CHAR),
    nnt_so_tk                      VARCHAR2(30 CHAR),
    nnt_ngan_hang                  VARCHAR2(100 CHAR),
    nnt_nnkt_ctiet                 VARCHAR2(5 CHAR),
    thd_dia_chi                    VARCHAR2(300 CHAR),
    thd_ma_tinh                    VARCHAR2(3 CHAR),
    thd_ma_huyen                   VARCHAR2(5 CHAR),
    thd_ma_xa                      VARCHAR2(7 CHAR),
    thd_ma_thon                    VARCHAR2(9 CHAR),
    thd_gcn                        NUMBER(*,0),
    thd_gcn_so                     VARCHAR2(20 CHAR),
    thd_gcn_ngay_cap               VARCHAR2(15 BYTE),
    thd_thua_dat_so                VARCHAR2(20 CHAR),
    thd_ban_do_so                  VARCHAR2(50 CHAR),
    thd_gcn_dien_tich              NUMBER(16,2),
    thd_dtich_sd_tte               NUMBER(19,5),
    thd_gcn_ma_md                  VARCHAR2(3 CHAR),
    thd_han_muc                    NUMBER(16,2),
    thd_chua_gcn                   NUMBER(*,0),
    thd_chua_gcn_dtich             NUMBER(19,5),
    thd_chua_gcn_ma_md             VARCHAR2(3 CHAR),
    mgi_ma_ly_do                   VARCHAR2(5 CHAR),
    mgi_ghi_chu                    VARCHAR2(100 CHAR),
    mgi_so_tien                    NUMBER(16,2),
    cct_dtich_sd_tte               NUMBER(19,5),
    cct_han_muc                    NUMBER(16,2),
    cct_ma_loai_dat                VARCHAR2(6 CHAR),
    cct_ma_duong                   VARCHAR2(8 CHAR),
    cct_ma_doan_duong              VARCHAR2(11 CHAR),
    cct_ma_loai_duong              VARCHAR2(6 CHAR),
    cct_ma_vi_tri                  VARCHAR2(8 CHAR),
    cct_he_so                      NUMBER(16,7),
    cct_ma_gia_dat                 VARCHAR2(10 CHAR),
    cct_gia_dat                    NUMBER(16,2),
    cct_gia_1m2_dat                NUMBER(16,2),
    cct_co_bke                     NUMBER(*,0),
    dato_dtich_trong_hm            NUMBER(19,5),
    dato_dtich_duoi3               NUMBER(19,5),
    dato_dtich_vuot3               NUMBER(19,5),
    dato_stpn                      NUMBER(16,2),
    ccu_dtich                      NUMBER(19,5),
    ccu_stpn                       NUMBER(16,2),
    skd_dtich                      NUMBER(19,5),
    skd_stpn                       NUMBER(16,2),
    smd_dtich                      NUMBER(19,5),
    smd_ma_md                      VARCHAR2(3 CHAR),
    smd_gia_1m2_dat                NUMBER(16,2),
    smd_stpn                       NUMBER(16,2),
    lch_dtich                      NUMBER(19,5),
    lch_ma_md                      VARCHAR2(3 CHAR),
    lch_gia_1m2_dat                NUMBER(16,2),
    lch_stpn                       NUMBER(16,2),
    stpn_truoc_mgi                 NUMBER(16,2),
    stpn_tong                      NUMBER(16,2),
    stpn_clech_bsung               NUMBER(16,2),
    dkn_nop_5nam                   NUMBER(*,0),
    dkn_so_tien                    NUMBER(16,2),
    ttk_dato_stpn                  NUMBER(16,2),
    ttk_ccu_stpn                   NUMBER(16,2),
    ttk_skd_stpn                   NUMBER(16,2),
    ttk_smd_stpn                   NUMBER(16,2),
    ttk_lch_stpn                   NUMBER(16,2),
    dlt_tin                        VARCHAR2(14 CHAR),
    dlt_ten_dlt                    VARCHAR2(300 CHAR),
    dlt_dia_chi                    VARCHAR2(100 CHAR),
    dlt_ma_tinh                    VARCHAR2(3 CHAR),
    dlt_ma_huyen                   VARCHAR2(5 CHAR),
    dlt_ma_xa                      VARCHAR2(7 CHAR),
    dlt_ma_thon                    VARCHAR2(9 CHAR),
    dlt_so_dt                      VARCHAR2(20 CHAR),
    dlt_fax                        VARCHAR2(20 CHAR),
    dlt_email                      VARCHAR2(70 CHAR),
    dlt_so_hdong                   VARCHAR2(20 CHAR),
    dlt_ngay_hdong                 VARCHAR2(15 BYTE),
    mgi_ty_le                      NUMBER(16,7),
    ccu_he_so                      NUMBER(16,7),
    sthue_pnop                     NUMBER(16,2),
    han_nop                        VARCHAR2(18 BYTE),
    thd_gcn_ten_md                 VARCHAR2(100 BYTE),
    mgi_ten_ly_do                  VARCHAR2(200 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    ky_kkhai_tu_ngay               VARCHAR2(15 BYTE),
    ky_kkhai_den_ngay              VARCHAR2(15 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_TK_SDDPNN

CREATE INDEX idx_ma_cqt ON tb_tk_sddpnn
  (
    ma_cqt                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_ma_loai_tk_idx ON tb_tk_sddpnn
  (
    ma_loai_tk                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_join_dd_idx ON tb_tk_sddpnn
  (
    cct_ma_doan_duong               ASC,
    cct_ma_duong                    ASC,
    thd_ma_huyen                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_join_ld_idx ON tb_tk_sddpnn
  (
    cct_ma_loai_duong               ASC,
    thd_ma_tinh                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_md_sai_idx ON tb_tk_sddpnn
  (
    smd_ma_md                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_huyentd_idx ON tb_tk_sddpnn
  (
    thd_ma_huyen                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_tin_idx ON tb_tk_sddpnn
  (
    nnt_tin                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_md_lc_idx ON tb_tk_sddpnn
  (
    lch_ma_md                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_tindlt_idx ON tb_tk_sddpnn
  (
    dlt_tin                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_tinhdlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_tinh                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_ma_duong_idx ON tb_tk_sddpnn
  (
    cct_ma_duong                    ASC,
    thd_ma_huyen                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_ma_vtri_idx ON tb_tk_sddpnn
  (
    cct_ma_vi_tri                   ASC,
    thd_ma_tinh                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_huyendlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_huyen                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_xa_dlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_xa                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_thondlt ON tb_tk_sddpnn
  (
    dlt_ma_thon                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_loaidat_idx ON tb_tk_sddpnn
  (
    cct_ma_loai_dat                 ASC,
    thd_ma_tinh                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_tinhtd_idx ON tb_tk_sddpnn
  (
    thd_ma_tinh                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_ak_idx ON tb_tk_sddpnn
  (
    ma_cqt                          ASC,
    ma_tkhai                        ASC,
    ltd                             ASC,
    ma_cqt_par                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_xa_td_idx ON tb_tk_sddpnn
  (
    thd_ma_xa                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_thon_td_idx ON tb_tk_sddpnn
  (
    thd_ma_thon                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_md_idx ON tb_tk_sddpnn
  (
    thd_gcn_ma_md                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX tb_tk_sddpnn_mg_idx ON tb_tk_sddpnn
  (
    mgi_ma_ly_do                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- Constraints for TB_TK_SDDPNN

ALTER TABLE tb_tk_sddpnn
ADD CONSTRAINT tb_tk_sddpnn_pk PRIMARY KEY (ma_tkhai, ma_cqt, ltd, ma_cqt_par)
/

ALTER TABLE tb_tk_sddpnn
ADD CONSTRAINT tb_tk_sddpnn_uk UNIQUE (ma_tkhai, ma_cqt, ltd, bs_lan_thu, 
  ma_cqt_par)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Table TEST.TB_TK_SDDPNN

