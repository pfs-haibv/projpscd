-- Start of DDL Script for Table TEST.TB_01_THKH_HDR
-- Generated 18/09/2013 1:50:02 PM from TEST@DCNC

CREATE TABLE tb_01_thkh_hdr
    (id                             NUMBER(20,0) ,
    tkh_id                         NUMBER(20,0),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE),
    kytt_tu_ngay                   VARCHAR2(15 BYTE),
    kytt_den_ngay                  VARCHAR2(15 BYTE),
    ngay_htoan                     VARCHAR2(15 BYTE),
    ngay_nop_tk                    VARCHAR2(15 BYTE),
    han_nop                        VARCHAR2(15 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    status                         CHAR(1 CHAR),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(150 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    tm_1701                        NUMBER(22,0),
    dthu_dkien                     NUMBER(15,0),
    tl_thnhap_dkien                NUMBER(20,0),
    tl_phanchia_tn                 NUMBER(20,0),
    thnhap_cthue_dkien             NUMBER(20,0),
    gtru_ban_than                  NUMBER(20,0),
    gtru_phu_thuoc                 NUMBER(20,0),
    gtru_tong                      NUMBER(20,0),
    thue_pnop                      NUMBER(20,0),
    thnhap_tinhthue                NUMBER(20,0),
    doanh_thu_ts_5                 NUMBER(20,0),
    gtgt_chiu_thue_ts_5            NUMBER(20,0),
    thue_gtgt_ts_5                 NUMBER(20,0),
    doanh_thu_ts_10                NUMBER(20,0),
    gtgt_chiu_thue_ts_10           NUMBER(20,0),
    thue_gtgt_ts_10                NUMBER(20,0),
    tsgtgt                         NUMBER(5,0))
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


-- Indexes for TB_01_THKH_HDR

CREATE INDEX idx_tb_cctt_hdr_id ON tb_01_thkh_hdr
  (
    id                              ASC
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



-- Constraints for TB_01_THKH_HDR

ALTER TABLE tb_01_thkh_hdr
ADD CONSTRAINT pk_tb_cctt_hdr_id PRIMARY KEY (id)
/


-- End of DDL Script for Table TEST.TB_01_THKH_HDR

