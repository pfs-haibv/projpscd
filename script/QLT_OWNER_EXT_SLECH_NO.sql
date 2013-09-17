-- Start of DDL Script for Table QLT_OWNER.EXT_SLECH_NO
-- Generated 16/09/2013 3:31:58 PM from QLT_OWNER@QLT_BRV_VTA

CREATE TABLE ext_slech_no
    (loai                          CHAR(3),
    ky_thue                        DATE,
    tin                            VARCHAR2(14),
    ten_dtnt                       VARCHAR2(250),
    tai_khoan                      VARCHAR2(50),
    muc                            VARCHAR2(4),
    tieumuc                        VARCHAR2(4),
    mathue                         VARCHAR2(2),
    sothue_no_cky                  NUMBER(15,0),
    sono_no_cky                    NUMBER(15,0),
    clech_no_cky                   NUMBER(15,0),
    update_no                      NUMBER(3,0),
    ma_cbo                         VARCHAR2(15),
    ten_cbo                        VARCHAR2(150),
    ma_pban                        VARCHAR2(15),
    ten_pban                       VARCHAR2(250),
    ma_slech                       NUMBER(2,0),
    ma_gdich                       VARCHAR2(3),
    ten_gdich                      VARCHAR2(100),
    da_dchinh                      VARCHAR2(1),
    ma_cqt                         VARCHAR2(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  qlt_dmuc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  NOMONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for EXT_SLECH_NO

CREATE INDEX ext_slno_udn ON ext_slech_no
  (
    update_no                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  qlt_dmuc
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- End of DDL Script for Table QLT_OWNER.EXT_SLECH_NO

