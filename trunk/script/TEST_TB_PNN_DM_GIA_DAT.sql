-- Start of DDL Script for Table TEST.TB_PNN_DM_GIA_DAT
-- Generated 28/09/2013 9:08:29 AM from TEST@DCNC

CREATE TABLE tb_pnn_dm_gia_dat
    (ma_gia_dat                     VARCHAR2(5 CHAR),
    ma_tinh                        VARCHAR2(3 CHAR) NOT NULL,
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ma_loai_dat                    VARCHAR2(6 CHAR) NOT NULL,
    ma_muc_dich                    VARCHAR2(3 CHAR) NOT NULL,
    ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ma_doan_duong                  VARCHAR2(11 CHAR) NOT NULL,
    ma_vi_tri                      VARCHAR2(8 CHAR) NOT NULL,
    gia                            NUMBER(16,2),
    ngay_hl_tu                     VARCHAR2(15 BYTE) NOT NULL,
    ngay_hl_den                    VARCHAR2(15 BYTE),
    ma_loai_duong                  VARCHAR2(6 CHAR),
    ghi_chu                        VARCHAR2(200 BYTE),
    nam                            VARCHAR2(15 BYTE) NOT NULL)
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


-- Constraints for TB_PNN_DM_GIA_DAT

ALTER TABLE tb_pnn_dm_gia_dat
ADD CHECK ("GIA" IS NOT NULL)
/

ALTER TABLE tb_pnn_dm_gia_dat
ADD CONSTRAINT tb_pnn_dm_gia_dat$uk1 UNIQUE (ma_gia_dat)
DISABLE NOVALIDATE
/


-- End of DDL Script for Table TEST.TB_PNN_DM_GIA_DAT

