CREATE TABLE tb_dkntk
    (id                             NUMBER(20,0) ,
    tkh_id                         NUMBER(20,0),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE),
    ky_bat_dau                     VARCHAR2(15 BYTE),
    ky_ket_thuc                    VARCHAR2(15 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    ky_bd_hthong_cu                VARCHAR2(15 BYTE),
    ky_kt_hthong_cu                VARCHAR2(15 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    status                         CHAR(1 CHAR),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    ma_tkhai_tms                   VARCHAR2(4 BYTE))
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




CREATE INDEX idx_tms_dkntk_qt_id ON tb_dkntk
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


ALTER TABLE tb_dkntk
ADD CONSTRAINT pk_tms_dkntk_qt_id PRIMARY KEY (id)
;

