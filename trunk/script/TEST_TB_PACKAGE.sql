CREATE TABLE tb_package
    (id                             NUMBER(20,0) ,
    pck_name                       VARCHAR2(100 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    tbl_user_objects               VARCHAR2(30 BYTE),
    directory                      VARCHAR2(100 BYTE))
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




CREATE INDEX ind_tb_package_id ON tb_package
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


ALTER TABLE tb_package
ADD CONSTRAINT pk_tb_package_id PRIMARY KEY (id)
;

CREATE OR REPLACE TRIGGER trg_tb_package_id
 BEFORE
  INSERT
 ON tb_package
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables.NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
;

