CREATE TABLE tb_pnn_dm_thon
    (ma_thon                        VARCHAR2(9 CHAR) NOT NULL,
    ma_xa                          VARCHAR2(7 CHAR),
    ten                            VARCHAR2(100 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR),
    ma_tinh                        VARCHAR2(3 CHAR),
    ngay_hl_tu                     DATE,
    ngay_hl_den                    DATE)
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




ALTER TABLE tb_pnn_dm_thon
ADD CONSTRAINT xpktb_pnn_dm_thon PRIMARY KEY (ma_thon)
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
;

