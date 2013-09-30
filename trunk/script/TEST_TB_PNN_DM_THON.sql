-- Start of DDL Script for Table TEST.TB_PNN_DM_THON
-- Generated 27/09/2013 10:45:20 AM from TEST@DCNC

CREATE TABLE tb_pnn_dm_thon
    (ma_thon                        VARCHAR2(9 CHAR) NOT NULL,
    ma_xa                          VARCHAR2(7 CHAR),
    ten                            VARCHAR2(100 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR),
    ma_tinh                        VARCHAR2(3 BYTE),
    ngay_hl_tu                     VARCHAR2(15 BYTE),
    ngay_hl_den                    VARCHAR2(15 BYTE))
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


-- Constraints for TB_PNN_DM_THON

ALTER TABLE tb_pnn_dm_thon
ADD CONSTRAINT xpktb_pnn_dm_thon PRIMARY KEY (ma_thon)
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


-- End of DDL Script for Table TEST.TB_PNN_DM_THON

