CREATE TABLE tb_pnn_dm_vi_tri
    (ma_vi_tri                      VARCHAR2(8 BYTE) NOT NULL,
    ten                            VARCHAR2(150 BYTE) NOT NULL,
    ma_tinh                        VARCHAR2(3 BYTE) NOT NULL,
    heso                           NUMBER(16,7),
    ngay_hl_tu                     DATE NOT NULL,
    ngay_hl_den                    DATE,
    ghi_chu                        VARCHAR2(200 BYTE),
    ma_vi_tri_off                  VARCHAR2(5 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL)
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




ALTER TABLE tb_pnn_dm_vi_tri
ADD CONSTRAINT xpkptb_pnn_dm_vi_tri PRIMARY KEY (ma_vi_tri, ma_tinh, ma_huyen)
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

