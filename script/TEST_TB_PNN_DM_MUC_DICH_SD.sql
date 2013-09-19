-- Start of DDL Script for Table TEST.TB_PNN_DM_MUC_DICH_SD
-- Generated 19/09/2013 1:23:55 PM from TEST@DCNC

CREATE TABLE tb_pnn_dm_muc_dich_sd
    (ma_muc_dich                    VARCHAR2(3 CHAR) NOT NULL,
    ten                            VARCHAR2(150 CHAR),
    heso                           NUMBER(16,7))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_MUC_DICH_SD

