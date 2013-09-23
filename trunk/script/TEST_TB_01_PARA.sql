-- Start of DDL Script for Table TEST.TB_01_PARA
-- Generated 23/09/2013 8:49:00 AM from TEST@DCNC

CREATE TABLE tb_01_para
    (id                             NUMBER(2,0) NOT NULL,
    rv_group                       VARCHAR2(50 BYTE),
    rv_key                         VARCHAR2(50 BYTE),
    rv_chr                         VARCHAR2(100 BYTE),
    rv_num                         NUMBER(10,0),
    rv_dat                         DATE,
    rv_note                        VARCHAR2(200 BYTE))
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


-- Constraints for TB_01_PARA

ALTER TABLE tb_01_para
ADD CONSTRAINT pk_para PRIMARY KEY (id)
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


-- End of DDL Script for Table TEST.TB_01_PARA

