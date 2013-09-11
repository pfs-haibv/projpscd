-- Start of DDL Script for Table TEST.TB_TK_SDDPNN_01_NNT
-- Generated 11/09/2013 4:01:50 PM from TEST@DCNC

CREATE TABLE tb_tk_sddpnn_01_nnt
    (ma_cqt_par                     VARCHAR2(5 CHAR) ,
    ma_cqt                         VARCHAR2(5 CHAR) ,
    ky_tthue                       VARCHAR2(15 BYTE),
    ma_tkhai                       VARCHAR2(22 CHAR) ,
    ltd                            NUMBER(*,0) ,
    trang_thai_cm                  VARCHAR2(2 CHAR),
    ma_mo_rong                     VARCHAR2(3 CHAR),
    so_hieu_tep                    VARCHAR2(200 CHAR),
    loai_dky                       NUMBER(*,0),
    ngay_nop                       VARCHAR2(15 BYTE),
    nnt_tin                        VARCHAR2(14 CHAR),
    nnt_ten_nnt                    VARCHAR2(300 CHAR),
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
    nnt_quoc_tich                  VARCHAR2(2 CHAR),
    nnt_so_dt                      VARCHAR2(20 CHAR),
    nnt_so_tk                      VARCHAR2(30 CHAR),
    nnt_ngan_hang                  VARCHAR2(100 CHAR),
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
    thd_dia_chi                    VARCHAR2(300 CHAR),
    thd_ma_tinh                    VARCHAR2(3 CHAR),
    thd_ma_huyen                   VARCHAR2(5 CHAR),
    thd_ma_xa                      VARCHAR2(7 CHAR),
    thd_ma_thon                    VARCHAR2(9 CHAR),
    thd_duy_nhat                   NUMBER(*,0),
    thd_ma_huyen_kkth              VARCHAR2(5 CHAR),
    thd_gcn                        NUMBER(*,0),
    thd_gcn_so                     VARCHAR2(20 CHAR),
    thd_gcn_ngay_cap               VARCHAR2(15 BYTE),
    thd_thua_dat_so                VARCHAR2(20 CHAR),
    thd_ban_do_so                  VARCHAR2(50 CHAR),
    thd_gcn_dien_tich              NUMBER(16,2),
    thd_gcn_ma_md                  VARCHAR2(3 BYTE),
    thd_tong_dtich_tte             NUMBER(19,5),
    thd_dtich_dung_md              NUMBER(19,5),
    thd_dtich_sai_md               NUMBER(19,5),
    thd_han_muc                    NUMBER(16,2),
    thd_dtich_lan_chiem            NUMBER(19,5),
    thd_chua_gcn                   NUMBER(*,0),
    thd_chua_gcn_dtich             NUMBER(19,5),
    thd_chua_gcn_ma_md             VARCHAR2(3 CHAR),
    ccu_loai_nha                   VARCHAR2(100 CHAR),
    ccu_dtich                      NUMBER(19,5),
    ccu_heso                       NUMBER(16,7),
    mgi_ma_ly_do                   VARCHAR2(5 CHAR),
    mgi_ghi_chu                    VARCHAR2(100 CHAR),
    dkn_dknt                       NUMBER(*,0),
    dkn_sonam                      NUMBER(4,0),
    thd_gcn_ten_md                 VARCHAR2(200 BYTE),
    thd_chua_gcn_ten_md            VARCHAR2(200 BYTE),
    mgi_ten_ly_do                  VARCHAR2(200 BYTE),
    short_name                     VARCHAR2(7 BYTE))
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


-- Indexes for TB_TK_SDDPNN_01_NNT

CREATE INDEX tb_tkhai_sddpnn_ma_thon_idx ON tb_tk_sddpnn_01_nnt
  (
    nnt_ma_thon                     ASC
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

CREATE INDEX tb_tkhai_sddpnn_ma_tinh_td_idx ON tb_tk_sddpnn_01_nnt
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

CREATE INDEX tb_tkhai_ma_huyen_td_idx ON tb_tk_sddpnn_01_nnt
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

CREATE INDEX tb_tkhai_sddpnn_ma_xa_td_idx ON tb_tk_sddpnn_01_nnt
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

CREATE INDEX tb_tkhai_huyen_dkkk_th_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_ma_huyen_kkth               ASC
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

CREATE INDEX tb_tkhai_sddpnn_ma_md_idx ON tb_tk_sddpnn_01_nnt
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



-- Constraints for TB_TK_SDDPNN_01_NNT

ALTER TABLE tb_tk_sddpnn_01_nnt
ADD CONSTRAINT tb_tkhai_sddpnn$pk PRIMARY KEY (ma_tkhai, ma_cqt, ltd, ma_cqt_par)
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



-- End of DDL Script for Table TEST.TB_TK_SDDPNN_01_NNT

-- Foreign Key
ALTER TABLE tb_tk_sddpnn_01_nnt
ADD CONSTRAINT ttb_tkhai_sddpnn$cctt_fk FOREIGN KEY (ma_tkhai, ma_cqt, ltd, 
  ma_cqt_par)
REFERENCES tb_tk_sddpnn (ma_tkhai,ma_cqt,ltd,ma_cqt_par) ON DELETE CASCADE
/
-- End of DDL script for Foreign Key(s)
