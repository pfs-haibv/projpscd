-- Start of DDL Script for Table TEST.TB_PNN_DM_LOAI_DUONG
-- Generated 12/09/2013 4:31:46 PM from TEST@DCNC

CREATE TABLE tb_pnn_dm_loai_duong
    (ma_loai_duong                  VARCHAR2(6 CHAR) NOT NULL,
    ten                            VARCHAR2(70 CHAR) NOT NULL,
    ngay_hl_tu                     DATE NOT NULL,
    ngay_hl_den                    DATE,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_loai_duong_tms              VARCHAR2(6 BYTE),
    ten_tms                        VARCHAR2(70 BYTE),
    ma_tinh                        VARCHAR2(3 BYTE))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_LOAI_DUONG

