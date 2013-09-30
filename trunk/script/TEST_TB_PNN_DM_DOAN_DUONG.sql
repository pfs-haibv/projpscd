-- Start of DDL Script for Table TEST.TB_PNN_DM_DOAN_DUONG
-- Generated 27/09/2013 10:46:08 AM from TEST@DCNC

CREATE TABLE tb_pnn_dm_doan_duong
    (ma_doan_duong                  VARCHAR2(11 CHAR) NOT NULL,
    ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ten_doan_duong                 VARCHAR2(300 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ma_doan_duong_off              VARCHAR2(7 CHAR),
    ngay_hl_tu                     VARCHAR2(15 BYTE),
    ngay_hl_den                    VARCHAR2(15 BYTE),
    ghi_chu                        VARCHAR2(200 CHAR))
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


-- Constraints for TB_PNN_DM_DOAN_DUONG

ALTER TABLE tb_pnn_dm_doan_duong
ADD CONSTRAINT xpktb_pnn_dm_doan_duong PRIMARY KEY (ma_doan_duong, ma_duong, 
  ma_huyen)
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


-- End of DDL Script for Table TEST.TB_PNN_DM_DOAN_DUONG

