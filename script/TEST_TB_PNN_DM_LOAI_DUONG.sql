CREATE TABLE tb_pnn_dm_loai_duong
    (ma_loai_duong                  VARCHAR2(6 CHAR) NOT NULL,
    ten                            VARCHAR2(70 CHAR) NOT NULL,
    ma_tinh                        VARCHAR2(3 CHAR) NOT NULL,
    ngay_hl_tu                     DATE NOT NULL,
    ngay_hl_den                    DATE,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_loai_duong_off              VARCHAR2(3 CHAR))
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




ALTER TABLE tb_pnn_dm_loai_duong
ADD CONSTRAINT xpktb_pnn_dm_loai_duong PRIMARY KEY (ma_loai_duong, ma_tinh)
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

