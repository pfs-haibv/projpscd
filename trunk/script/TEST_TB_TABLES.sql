-- Start of DDL Script for Table TEST.TB_TABLES
-- Generated 17/09/2013 3:33:07 PM from TEST@DCNC

CREATE TABLE tb_tables
    (id                             NUMBER(10,0) ,
    tbl_name                       VARCHAR2(100 BYTE),
    tablespace                     VARCHAR2(100 BYTE),
    p_name                         VARCHAR2(100 BYTE),
    p_value                        VARCHAR2(100 BYTE),
    index_name                     VARCHAR2(100 BYTE),
    index_value                    VARCHAR2(100 BYTE),
    tax_model                      VARCHAR2(7 BYTE))
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


-- Indexes for TB_TABLES

CREATE INDEX ind_ztb_tables_id ON tb_tables
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
/



-- Constraints for TB_TABLES

ALTER TABLE tb_tables
ADD CONSTRAINT pk_ztb_tables_id PRIMARY KEY (id)
/


-- Triggers for TB_TABLES

CREATE OR REPLACE TRIGGER trg_ztb_tables_id
 BEFORE
  INSERT
 ON tb_tables
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables.NEXTVAL INTO :new.id FROM DUAL;
    END IF;
END;
/


-- Comments for TB_TABLES

COMMENT ON COLUMN tb_tables.index_name IS 'index name'
/
COMMENT ON COLUMN tb_tables.index_value IS 'index value'
/
COMMENT ON COLUMN tb_tables.p_name IS 'primary key name'
/
COMMENT ON COLUMN tb_tables.p_value IS 'primary key value'
/
COMMENT ON COLUMN tb_tables.tablespace IS 'tablespace'
/
COMMENT ON COLUMN tb_tables.tbl_name IS 'table name'
/

-- End of DDL Script for Table TEST.TB_TABLES

