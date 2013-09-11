CREATE TABLE tb_dmuc_tkhai
    (id                             NUMBER(20,0) ,
    ma                             VARCHAR2(20 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    ten                            VARCHAR2(200 BYTE),
    ma_tms                         VARCHAR2(7 BYTE),
    loai_kkhai                     VARCHAR2(2 BYTE),
    flg_dkntk                      VARCHAR2(1 BYTE),
    flg_ps                         VARCHAR2(1 BYTE),
    tmuc_ps                        VARCHAR2(4000 BYTE))
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
;




CREATE INDEX idx_tb_dmuc_tkhai_id ON tb_dmuc_tkhai
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
;


ALTER TABLE tb_dmuc_tkhai
ADD CONSTRAINT pk_tb_dmuc_tkhai_id PRIMARY KEY (id)
;

CREATE OR REPLACE TRIGGER trg_tb_dmuc_tkhai_id
 BEFORE
  INSERT
 ON tb_dmuc_tkhai
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables. NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
;

