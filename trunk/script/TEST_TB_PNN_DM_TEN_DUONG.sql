-- Start of DDL Script for Table TEST.TB_PNN_DM_TEN_DUONG
-- Generated 12/09/2013 11:00:31 AM from TEST@DCNC

CREATE TABLE tb_pnn_dm_ten_duong
    (ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ten                            VARCHAR2(300 CHAR) ,
    ma_tinh                        VARCHAR2(3 CHAR) NOT NULL,
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_duong_off                   VARCHAR2(3 CHAR),
    ngay_hl_tu                     DATE NOT NULL,
    ngay_hl_den                    DATE)
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


-- Constraints for TB_PNN_DM_TEN_DUONG

ALTER TABLE tb_pnn_dm_ten_duong
ADD CONSTRAINT xpkpnn_dm_ten_duong PRIMARY KEY (ma_duong, ma_huyen)
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

ALTER TABLE tb_pnn_dm_ten_duong
ADD CHECK ("TEN" IS NOT NULL)
/


-- End of DDL Script for Table TEST.TB_PNN_DM_TEN_DUONG

