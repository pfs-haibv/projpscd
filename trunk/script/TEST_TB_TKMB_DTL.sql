CREATE TABLE tb_tkmb_dtl
    (id                             NUMBER(20,0) NOT NULL,
    hdr_id                         NUMBER(20,0),
    tkh_id                         NUMBER(20,0),
    thue_pn_nnt                    NUMBER(20,2),
    von_dky_nnt                    NUMBER(20,0),
    von_dky_cqt                    NUMBER(20,0),
    thue_pn_cqt                    NUMBER(20,2),
    bmb_nnt                        VARCHAR2(10 BYTE),
    bmb_cqt                        VARCHAR2(10 BYTE),
    mst_dvtt                       VARCHAR2(100 BYTE))
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




CREATE INDEX idx_tb_tkmb_dtl_id ON tb_tkmb_dtl
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


ALTER TABLE tb_tkmb_dtl
ADD CONSTRAINT pk_tb_tkmb_dtl_id PRIMARY KEY (id)
;


ALTER TABLE tb_tkmb_dtl
ADD CONSTRAINT fk_tb_tkmb_dtl_hdr_id FOREIGN KEY (hdr_id)
REFERENCES tb_tkmb_hdr (id)
;
-- End of DDL script for Foreign Key(s)
