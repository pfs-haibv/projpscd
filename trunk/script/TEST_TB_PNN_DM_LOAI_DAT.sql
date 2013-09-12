-- Start of DDL Script for Table TEST.TB_PNN_DM_LOAI_DAT
-- Generated 12/09/2013 4:32:00 PM from TEST@DCNC

CREATE TABLE tb_pnn_dm_loai_dat
    (ma_loai_dat                    VARCHAR2(6 CHAR) NOT NULL,
    ten_tms                        VARCHAR2(70 CHAR) NOT NULL,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_loai_dat_tms                VARCHAR2(6 BYTE),
    ma_tinh                        VARCHAR2(3 BYTE),
    ten                            VARCHAR2(70 BYTE),
    ma_tmuc                        VARCHAR2(4 BYTE))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_LOAI_DAT

