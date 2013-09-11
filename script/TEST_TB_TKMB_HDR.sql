CREATE TABLE tb_tkmb_hdr
    (id                             NUMBER(20,0) ,
    tkh_id                         NUMBER(20,0),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE),
    kytt_tu_ngay                   VARCHAR2(15 BYTE),
    kytt_den_ngay                  VARCHAR2(15 BYTE),
    ngay_htoan                     VARCHAR2(15 BYTE),
    ngay_nop_tk                    VARCHAR2(15 BYTE),
    han_nop                        VARCHAR2(15 BYTE),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(150 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    status                         CHAR(1 CHAR),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    thue_pn_nnt                    NUMBER(20,0),
    von_dky_nnt                    NUMBER(20,0),
    von_dky_cqt                    NUMBER(20,0),
    thue_pn_cqt                    NUMBER(20,0),
    bmb_nnt                        VARCHAR2(10 BYTE),
    bmb_cqt                        VARCHAR2(10 BYTE),
    tong_thue_pn_nnt               NUMBER(20,0),
    tong_thue_pn_cqt               NUMBER(20,0),
    tm_1801                        NUMBER(20,0),
    tm_1802                        NUMBER(20,0),
    tm_1803                        NUMBER(20,0),
    tm_1804                        NUMBER(20,0),
    tm_1805                        NUMBER(20,0),
    tm_1806                        NUMBER(20,0))
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




CREATE INDEX idx_tb_tkmb_hdr_id ON tb_tkmb_hdr
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


ALTER TABLE tb_tkmb_hdr
ADD CONSTRAINT pk_tb_tkmb_hdr_id PRIMARY KEY (id)
;

