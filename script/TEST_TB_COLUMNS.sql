CREATE TABLE tb_columns
    (id                             NUMBER(10,0) ,
    tbl_id                         NUMBER(10,0),
    col_name                       VARCHAR2(100 BYTE),
    type                           VARCHAR2(100 BYTE))
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




CREATE INDEX ind_ztb_columns_id ON tb_columns
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


ALTER TABLE tb_columns
ADD CONSTRAINT pk_ztb_columns_id PRIMARY KEY (id)
;


CREATE OR REPLACE TRIGGER trg_ztb_columns_id
 BEFORE
  INSERT
 ON tb_columns
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables.NEXTVAL INTO :new.id FROM DUAL;
    END IF;
END;
;

ALTER TABLE tb_columns
ADD CONSTRAINT fk_ztb_columns_id FOREIGN KEY (tbl_id)
REFERENCES tb_tables (id)
;
-- End of DDL script for Foreign Key(s)
