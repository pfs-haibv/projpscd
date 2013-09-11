CREATE TABLE tb_01_thkh_npt
    (short_name                     VARCHAR2(7 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ky_tthue                       VARCHAR2(4 BYTE),
    loai_tk                        VARCHAR2(4 BYTE),
    loai_bk                        VARCHAR2(4 BYTE),
    mst_npt                        VARCHAR2(14 BYTE),
    ten_npt                        VARCHAR2(150 BYTE),
    ngay_sinh                      VARCHAR2(10 BYTE),
    so_cmt                         VARCHAR2(30 BYTE),
    qhe_nnt                        VARCHAR2(50 BYTE),
    sothang_gtru                   NUMBER(2,0),
    sotien_gtru                    NUMBER(15,0),
    qhe_vchong                     VARCHAR2(1 BYTE),
    ngaynop                        VARCHAR2(10 BYTE),
    tax_code                       VARCHAR2(7 BYTE),
    bukrs                          VARCHAR2(4 BYTE),
    id                             NUMBER(15,0))
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




CREATE INDEX ind_01_thkh_pt_sname ON tb_01_thkh_npt
  (
    short_name                      ASC
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


CREATE OR REPLACE TRIGGER trg_01_thkh
 BEFORE
  INSERT
 ON tb_01_thkh_npt
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_PT.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
;

