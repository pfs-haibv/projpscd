-- Start of DDL Script for Table TEST.TB_01_PARA
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_01_para
    (id                             NUMBER(2,0) NOT NULL,
    rv_group                       VARCHAR2(50 BYTE),
    rv_key                         VARCHAR2(50 BYTE),
    rv_chr                         VARCHAR2(100 BYTE),
    rv_num                         NUMBER(10,0),
    rv_dat                         DATE,
    rv_note                        VARCHAR2(200 BYTE))
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


-- Constraints for TB_01_PARA

ALTER TABLE tb_01_para
ADD CONSTRAINT pk_para PRIMARY KEY (id)
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
/


-- End of DDL Script for Table TEST.TB_01_PARA

-- Start of DDL Script for Table TEST.TB_01_THKH_HDR
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_01_thkh_hdr
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
    short_name                     VARCHAR2(7 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    status                         CHAR(1 CHAR),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(150 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    tm_1701                        NUMBER(22,0),
    dthu_dkien                     NUMBER(15,0),
    tl_thnhap_dkien                NUMBER(20,0),
    tl_phanchia_tn                 NUMBER(20,0),
    thnhap_cthue_dkien             NUMBER(20,0),
    gtru_ban_than                  NUMBER(20,0),
    gtru_phu_thuoc                 NUMBER(20,0),
    gtru_tong                      NUMBER(20,0),
    thue_pnop                      NUMBER(20,0),
    thnhap_tinhthue                NUMBER(20,0),
    doanh_thu_ts_5                 NUMBER(20,0),
    gtgt_chiu_thue_ts_5            NUMBER(20,0),
    thue_gtgt_ts_5                 NUMBER(20,0),
    doanh_thu_ts_10                NUMBER(20,0),
    gtgt_chiu_thue_ts_10           NUMBER(20,0),
    thue_gtgt_ts_10                NUMBER(20,0),
    tsgtgt                         NUMBER(5,0))
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


-- Indexes for TB_01_THKH_HDR

CREATE INDEX idx_tb_cctt_hdr_id ON tb_01_thkh_hdr
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

CREATE INDEX ind_tkh_tin ON tb_01_thkh_hdr
  (
    tin                             ASC
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

CREATE INDEX ind_tkh_tax_model ON tb_01_thkh_hdr
  (
    tax_model                       ASC
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

CREATE INDEX ind_tkh_short_name ON tb_01_thkh_hdr
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
/



-- Constraints for TB_01_THKH_HDR

ALTER TABLE tb_01_thkh_hdr
ADD CONSTRAINT pk_tb_cctt_hdr_id PRIMARY KEY (id)
/


-- End of DDL Script for Table TEST.TB_01_THKH_HDR

-- Start of DDL Script for Table TEST.TB_01_THKH_NPT
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_01_thkh_npt
    (short_name                     VARCHAR2(7 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ky_tthue                       VARCHAR2(10 BYTE),
    mst_npt                        VARCHAR2(14 BYTE),
    ten_npt                        VARCHAR2(150 BYTE),
    ngay_sinh                      VARCHAR2(10 BYTE),
    so_cmt                         VARCHAR2(30 BYTE),
    qhe_nnt                        VARCHAR2(50 BYTE),
    sothang_gtru                   NUMBER(2,0),
    sotien_gtru                    NUMBER(15,0),
    qhe_vchong                     VARCHAR2(1 BYTE),
    ngaynop                        VARCHAR2(10 BYTE),
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
/


-- Indexes for TB_01_THKH_NPT

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
/



-- Triggers for TB_01_THKH_NPT

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
/


-- End of DDL Script for Table TEST.TB_01_THKH_NPT

-- Start of DDL Script for Table TEST.TB_CCTT
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_cctt
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
    short_name                     VARCHAR2(7 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    status                         CHAR(1 CHAR),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(150 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    thnhap_tinhthue                NUMBER(20,0),
    doanh_thu_ts_5                 NUMBER(20,0),
    gtgt_chiu_thue_ts_5            NUMBER(20,0),
    thue_gtgt_ts_5                 NUMBER(20,0),
    doanh_thu_ts_10                NUMBER(20,0),
    gtgt_chiu_thue_ts_10           NUMBER(20,0),
    thue_gtgt_ts_10                NUMBER(20,0),
    tm_1701                        NUMBER(20,0))
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


-- Constraints for TB_CCTT

ALTER TABLE tb_cctt
ADD CONSTRAINT pk_tb_cctt_id PRIMARY KEY (id)
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
/


-- End of DDL Script for Table TEST.TB_CCTT

-- Start of DDL Script for Table TEST.TB_CHK_LST
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_chk_lst
    (short_name                     VARCHAR2(3 BYTE) NOT NULL,
    step                           VARCHAR2(30 BYTE),
    status                         VARCHAR2(1 BYTE),
    stt                            NUMBER,
    note                           VARCHAR2(50 BYTE))
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


-- End of DDL Script for Table TEST.TB_CHK_LST

-- Start of DDL Script for Table TEST.TB_COLUMNS
-- Generated 3-Oct-2013 16:32:33 from TEST@DCNC

CREATE TABLE tb_columns
    (id                             NUMBER(10,0) ,
    tbl_id                         NUMBER(10,0),
    col_name                       VARCHAR2(100 BYTE),
    type                           VARCHAR2(100 BYTE))
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


-- Indexes for TB_COLUMNS

CREATE INDEX ind_ztb_columns_id ON tb_columns
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



-- Constraints for TB_COLUMNS

ALTER TABLE tb_columns
ADD CONSTRAINT pk_ztb_columns_id PRIMARY KEY (id)
/



-- Triggers for TB_COLUMNS

CREATE OR REPLACE TRIGGER trg_ztb_columns_id
 BEFORE
  INSERT
 ON tb_columns
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables.NEXTVAL INTO :new.id FROM DUAL;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_COLUMNS

-- Start of DDL Script for Table TEST.TB_CON_KT
-- Generated 3-Oct-2013 16:32:34 from TEST@DCNC

CREATE TABLE tb_con_kt
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    ma_tmuc                        VARCHAR2(4 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_tkhai_tms                   VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_CON_KT

CREATE INDEX ind_qlt_con_kt_short_name ON tb_con_kt
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     589824
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_con_kt_model ON tb_con_kt
  (
    tax_model                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     524288
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_con_kt_tin ON tb_con_kt
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     655360
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- Constraints for TB_CON_KT

ALTER TABLE tb_con_kt
ADD CONSTRAINT pk_con_kt_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     458752
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Triggers for TB_CON_KT

CREATE OR REPLACE TRIGGER trg_con_kt_b
 BEFORE
  INSERT
 ON tb_con_kt
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_CON_KT

-- Start of DDL Script for Table TEST.TB_CTU
-- Generated 3-Oct-2013 16:32:34 from TEST@DCNC

CREATE TABLE tb_ctu
    (file_name                      CHAR(100 BYTE),
    tran_no                        VARCHAR2(60 BYTE),
    total                          NUMBER,
    comp_code                      VARCHAR2(12 BYTE))
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


-- End of DDL Script for Table TEST.TB_CTU

-- Start of DDL Script for Table TEST.TB_DATA_ERROR
-- Generated 3-Oct-2013 16:32:34 from TEST@DCNC

CREATE TABLE tb_data_error
    (short_name                     VARCHAR2(10 BYTE) NOT NULL,
    rid                            VARCHAR2(30 BYTE) NOT NULL,
    table_name                     VARCHAR2(200 BYTE) ,
    err_id                         VARCHAR2(5 BYTE) ,
    field_name                     VARCHAR2(200 BYTE),
    update_no                      NUMBER(5,0),
    ma_cqt                         VARCHAR2(5 BYTE) NOT NULL,
    check_app                      VARCHAR2(3 BYTE) NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_DATA_ERROR

CREATE INDEX ind_der_short ON tb_data_error
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_der_rid ON tb_data_error
  (
    rid                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     3145728
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_der_tname ON tb_data_error
  (
    table_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_der_eid ON tb_data_error
  (
    err_id                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- Constraints for TB_DATA_ERROR

ALTER TABLE tb_data_error
ADD CONSTRAINT tb_data_error_pk PRIMARY KEY (err_id, table_name)
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
/


-- Comments for TB_DATA_ERROR

COMMENT ON COLUMN tb_data_error.check_app IS 'checked in the SAP defaults "SAP", checked in the Oracle defaults "ORA"'
/
COMMENT ON COLUMN tb_data_error.err_id IS 'ma loi'
/
COMMENT ON COLUMN tb_data_error.field_name IS 'truong loi'
/
COMMENT ON COLUMN tb_data_error.ma_cqt IS 'Ma co quan thue'
/
COMMENT ON COLUMN tb_data_error.rid IS 'rowid trong bang du lieu check'
/
COMMENT ON COLUMN tb_data_error.short_name IS 'ten ngan co quan the'
/
COMMENT ON COLUMN tb_data_error.table_name IS 'ten bang du lieu check'
/
COMMENT ON COLUMN tb_data_error.update_no IS 'co the null'
/

-- End of DDL Script for Table TEST.TB_DATA_ERROR

-- Start of DDL Script for Table TEST.TB_DCONVERT_OVER
-- Generated 3-Oct-2013 16:32:34 from TEST@DCNC

CREATE TABLE tb_dconvert_over
    (short_name                     VARCHAR2(7 BYTE),
    loai                           VARCHAR2(20 BYTE),
    ma_gdich                       VARCHAR2(10 BYTE),
    ten_gdich                      VARCHAR2(150 BYTE),
    so_luong                       NUMBER(10,0))
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


-- End of DDL Script for Table TEST.TB_DCONVERT_OVER

-- Start of DDL Script for Table TEST.TB_DKNTK
-- Generated 3-Oct-2013 16:32:34 from TEST@DCNC

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
    mau_tkhai_tms                  VARCHAR2(4 BYTE))
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


-- Indexes for TB_DKNTK

CREATE INDEX ind_dkntk_tin ON tb_dkntk
  (
    tin                             ASC
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

CREATE INDEX ind_dkntk_tax_model ON tb_dkntk
  (
    tax_model                       ASC
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

CREATE INDEX ind_dkntk_short_name ON tb_dkntk
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
/

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
/



-- Constraints for TB_DKNTK

ALTER TABLE tb_dkntk
ADD CONSTRAINT pk_tms_dkntk_qt_id PRIMARY KEY (id)
/


-- Triggers for TB_DKNTK

CREATE OR REPLACE TRIGGER trg_dkntk_bi
 BEFORE
  INSERT
 ON tb_dkntk
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    CURSOR c1 (p_ma_tkhai VARCHAR2, p_tax_model VARCHAR2) IS
        SELECT ma_tms FROM tb_dmuc_tkhai
            WHERE trim(ma) = trim(p_ma_tkhai) and tax_model = p_tax_model;
    CURSOR c2 (p_ma_tkhai VARCHAR2) IS
        SELECT ma_tms FROM tb_dmuc_tkhai
            WHERE trim(ma_vatwin) = trim(p_ma_tkhai);
BEGIN

    IF :NEW.tax_model = 'QLT-APP' OR :NEW.tax_model = 'QCT-APP' THEN
        OPEN c1 (:NEW.ma_tkhai, :NEW.tax_model);
        LOOP
            FETCH c1 into :NEW.mau_tkhai_tms;
            EXIT WHEN c1%notfound;
        END LOOP;
        CLOSE c1;                        
    END IF;
    
    IF :NEW.tax_model = 'VAT-APP' THEN
        OPEN c2 (:NEW.ma_tkhai);
        LOOP
            FETCH c2 into :NEW.mau_tkhai_tms;
            EXIT WHEN c2%notfound;
        END LOOP;
        CLOSE c2;                        
    END IF;   
     
END;
/


-- End of DDL Script for Table TEST.TB_DKNTK

-- Start of DDL Script for Table TEST.TB_DLBH
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dlbh
    (cl1                            VARCHAR2(100 BYTE),
    cl2                            VARCHAR2(100 BYTE),
    cl3                            VARCHAR2(100 BYTE),
    cl4                            VARCHAR2(100 BYTE),
    cl5                            VARCHAR2(100 BYTE),
    cl6                            VARCHAR2(101 BYTE),
    cl7                            VARCHAR2(100 BYTE),
    cl8                            VARCHAR2(100 BYTE),
    cl9                            VARCHAR2(100 BYTE),
    cl10                           VARCHAR2(100 BYTE),
    cl11                           VARCHAR2(100 BYTE),
    cl12                           VARCHAR2(100 BYTE),
    cl13                           VARCHAR2(100 BYTE),
    cl14                           VARCHAR2(100 BYTE),
    cl15                           VARCHAR2(100 BYTE),
    cl16                           VARCHAR2(100 BYTE),
    cl17                           VARCHAR2(100 BYTE),
    cl18                           VARCHAR2(100 BYTE),
    cl19                           VARCHAR2(100 BYTE),
    cl20                           VARCHAR2(100 BYTE),
    cl21                           VARCHAR2(100 BYTE),
    cl22                           VARCHAR2(100 BYTE),
    cl23                           VARCHAR2(100 BYTE),
    cl24                           VARCHAR2(100 BYTE),
    cl25                           VARCHAR2(100 BYTE),
    cl26                           VARCHAR2(100 BYTE),
    cl27                           VARCHAR2(100 BYTE),
    cl28                           VARCHAR2(100 BYTE))
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


-- End of DDL Script for Table TEST.TB_DLBH

-- Start of DDL Script for Table TEST.TB_DMUC_BAC_MBAI
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_bac_mbai
    (id                             NUMBER(20,0) ,
    ma                             VARCHAR2(20 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    ten                            VARCHAR2(200 BYTE),
    bmb_tms                        VARCHAR2(2 BYTE))
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


-- Indexes for TB_DMUC_BAC_MBAI

CREATE INDEX idx_tb_dmuc_bac_mbai_id ON tb_dmuc_bac_mbai
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



-- Constraints for TB_DMUC_BAC_MBAI

ALTER TABLE tb_dmuc_bac_mbai
ADD CONSTRAINT pk_tb_dmuc_bac_mbai_id PRIMARY KEY (id)
/


-- Triggers for TB_DMUC_BAC_MBAI

CREATE OR REPLACE TRIGGER trg_tb_dmuc_bac_mbai_id
 BEFORE
  INSERT
 ON tb_dmuc_bac_mbai
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables. NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_DMUC_BAC_MBAI

-- Start of DDL Script for Table TEST.TB_DMUC_CAPCHUONG
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_capchuong
    (ma_cap                         VARCHAR2(1 BYTE) NOT NULL,
    ma_chuong                      VARCHAR2(3 BYTE) NOT NULL,
    ten                            VARCHAR2(100 BYTE) NOT NULL,
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
/


-- End of DDL Script for Table TEST.TB_DMUC_CAPCHUONG

-- Start of DDL Script for Table TEST.TB_DMUC_MTMUC
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_mtmuc
    (id                             NUMBER(20,0) ,
    ma_muc                         VARCHAR2(20 BYTE),
    ma_tmuc                        VARCHAR2(20 BYTE),
    ten_tmuc                       VARCHAR2(200 BYTE))
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


-- Indexes for TB_DMUC_MTMUC

CREATE INDEX idx_tb_dmuc_mtmuc_id ON tb_dmuc_mtmuc
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



-- Constraints for TB_DMUC_MTMUC

ALTER TABLE tb_dmuc_mtmuc
ADD CONSTRAINT pk_tb_dmuc_mtmuc_id PRIMARY KEY (id)
/


-- Triggers for TB_DMUC_MTMUC

CREATE OR REPLACE TRIGGER trg_tb_dmuc_mtmuc_id
 BEFORE
  INSERT
 ON tb_dmuc_mtmuc
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables. NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_DMUC_MTMUC

-- Start of DDL Script for Table TEST.TB_DMUC_TCHAT_NO
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_tchat_no
    (id                             NUMBER(20,0) ,
    ma                             VARCHAR2(2 BYTE),
    ma_nhom                        VARCHAR2(2 BYTE),
    ten_nhom                       VARCHAR2(200 BYTE),
    ten_tchat                      VARCHAR2(200 BYTE),
    ma_tc_cha                      VARCHAR2(2 BYTE),
    ma_tc_tms                      VARCHAR2(1 BYTE))
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


-- Indexes for TB_DMUC_TCHAT_NO

CREATE INDEX idx_tb_dmuc_tchat_no_id ON tb_dmuc_tchat_no
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



-- Constraints for TB_DMUC_TCHAT_NO

ALTER TABLE tb_dmuc_tchat_no
ADD CONSTRAINT pk_tb_dmuc_tchat_no_id PRIMARY KEY (id)
/


-- Triggers for TB_DMUC_TCHAT_NO

CREATE OR REPLACE TRIGGER trg_tb_dmuc_tchat_no_id
 BEFORE
  INSERT
 ON tb_dmuc_tchat_no
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables. NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_DMUC_TCHAT_NO

-- Start of DDL Script for Table TEST.TB_DMUC_TKHAI
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_tkhai
    (id                             NUMBER(20,0) ,
    ma                             VARCHAR2(20 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    ten                            VARCHAR2(200 BYTE),
    ma_tms                         VARCHAR2(7 BYTE),
    loai_kkhai                     VARCHAR2(2 BYTE),
    flg_dkntk                      VARCHAR2(1 BYTE),
    flg_ps                         VARCHAR2(1 BYTE),
    tmuc_ps                        VARCHAR2(4000 BYTE),
    mau_tkhai                      VARCHAR2(20 BYTE),
    ma_vatwin                      VARCHAR2(20 BYTE),
    flg_qt                         VARCHAR2(1 BYTE))
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


-- Indexes for TB_DMUC_TKHAI

CREATE INDEX idx_tb_dmuc_tkhai_id ON tb_dmuc_tkhai
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



-- Constraints for TB_DMUC_TKHAI

ALTER TABLE tb_dmuc_tkhai
ADD CONSTRAINT pk_tb_dmuc_tkhai_id PRIMARY KEY (id)
/


-- Triggers for TB_DMUC_TKHAI

CREATE OR REPLACE TRIGGER trg_tb_dmuc_tkhai_id
 BEFORE
  INSERT
 ON tb_dmuc_tkhai
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables. NEXTVAL INTO :new.id FROM DUAL ;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_DMUC_TKHAI

-- Start of DDL Script for Table TEST.TB_DMUC_TKHOAN
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dmuc_tkhoan
    (tax_model                      VARCHAR2(7 BYTE),
    ma_cu                          VARCHAR2(20 BYTE),
    ma_tms                         VARCHAR2(3 BYTE),
    ten                            VARCHAR2(50 BYTE))
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


-- End of DDL Script for Table TEST.TB_DMUC_TKHOAN

-- Start of DDL Script for Table TEST.TB_DPPIT
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_dppit
    (ma_cqt                         VARCHAR2(12 BYTE) NOT NULL,
    persl                          CHAR(4 BYTE),
    total                          NUMBER,
    he_thong                       CHAR(6 BYTE),
    mst                            VARCHAR2(14 BYTE) NOT NULL)
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


-- End of DDL Script for Table TEST.TB_DPPIT

-- Start of DDL Script for Table TEST.TB_ERRORS
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_errors
    (seq_number                     NUMBER NOT NULL,
    short_name                     VARCHAR2(7 BYTE),
    pck                            VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    timestamp                      DATE,
    error_stack                    VARCHAR2(2000 BYTE),
    call_stack                     VARCHAR2(2000 BYTE))
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


-- Constraints for TB_ERRORS

ALTER TABLE tb_errors
ADD CONSTRAINT tb_qlt_pk_errors PRIMARY KEY (seq_number)
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
/


-- End of DDL Script for Table TEST.TB_ERRORS

-- Start of DDL Script for Table TEST.TB_EXCEL
-- Generated 3-Oct-2013 16:32:35 from TEST@DCNC

CREATE TABLE tb_excel
    (id_hdr                         NUMBER(10,0) NOT NULL,
    id_dtl                         NUMBER(10,0) NOT NULL,
    col_text                       VARCHAR2(1000 BYTE))
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


-- Constraints for TB_EXCEL

ALTER TABLE tb_excel
ADD CONSTRAINT pk_excel PRIMARY KEY (id_dtl)
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
/


-- End of DDL Script for Table TEST.TB_EXCEL

-- Start of DDL Script for Table TEST.TB_HTRO_DCHIEU_HTOAN
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_htro_dchieu_htoan
    (short_name                     VARCHAR2(10 BYTE),
    taxpayer                       VARCHAR2(30 BYTE) NOT NULL,
    mst                            VARCHAR2(60 BYTE),
    company                        VARCHAR2(12 BYTE) NOT NULL,
    return_id                      VARCHAR2(96 BYTE) NOT NULL,
    a_amount_q1                    NUMBER(18,0) NOT NULL,
    b_amount_q1                    NUMBER,
    sl_q1                          NUMBER,
    a_amount_q2                    NUMBER(18,0) NOT NULL,
    b_amount_q2                    NUMBER,
    sl_q2                          NUMBER,
    a_amount_q3                    NUMBER(18,0) NOT NULL,
    b_amount_q3                    NUMBER,
    sl_q3                          NUMBER,
    a_amount_q4                    NUMBER(18,0) NOT NULL,
    b_amount_q4                    NUMBER,
    sl_q4                          NUMBER)
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


-- End of DDL Script for Table TEST.TB_HTRO_DCHIEU_HTOAN

-- Start of DDL Script for Table TEST.TB_HTRO_DCHIEU_NO
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_htro_dchieu_no
    (dtg_short_name                 VARCHAR2(21 BYTE),
    dtg_tmuc                       VARCHAR2(12 BYTE),
    dtg_so_no                      NUMBER,
    dtg_so_nothua                  NUMBER,
    pit_tmuc                       VARCHAR2(12 BYTE),
    pit_so_no                      NUMBER,
    pit_so_nothua                  NUMBER,
    sle_so_no                      NUMBER,
    sle_so_nothua                  NUMBER,
    sai_lech_so_no                 NUMBER,
    sai_lech_so_nothua             NUMBER)
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


-- End of DDL Script for Table TEST.TB_HTRO_DCHIEU_NO

-- Start of DDL Script for Table TEST.TB_HTRO_DCHIEU_PS
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_htro_dchieu_ps
    (ma_cqt                         VARCHAR2(30 BYTE),
    pit_ma                         VARCHAR2(12 BYTE),
    pit_sotien                     NUMBER,
    dtg_ma                         VARCHAR2(12 BYTE),
    dtg_sotien                     NUMBER,
    sle_sotien                     NUMBER,
    sai_lech                       NUMBER)
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


-- End of DDL Script for Table TEST.TB_HTRO_DCHIEU_PS

-- Start of DDL Script for Table TEST.TB_HTRO_DCHIEU_TK
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_htro_dchieu_tk
    (short_name                     VARCHAR2(21 BYTE),
    dtg_sotien                     NUMBER,
    pit_sotien                     NUMBER,
    sle_sotien                     NUMBER,
    sai_lech                       NUMBER)
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


-- End of DDL Script for Table TEST.TB_HTRO_DCHIEU_TK

-- Start of DDL Script for Table TEST.TB_LOG_DATA
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_log_data
    (id_hdr                         NUMBER(15,0),
    id_dtl                         NUMBER(15,0),
    table_name                     VARCHAR2(50 BYTE),
    filed_name                     VARCHAR2(50 BYTE),
    new_value                      VARCHAR2(150 BYTE),
    old_value                      VARCHAR2(150 BYTE))
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


-- Triggers for TB_LOG_DATA

CREATE OR REPLACE TRIGGER trg_ldata_b
 BEFORE
  INSERT
 ON tb_log_data
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID_HDR IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID_HDR FROM dual;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_LOG_DATA

-- Start of DDL Script for Table TEST.TB_LOG_EXCEL
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_log_excel
    (short_name                     VARCHAR2(7 BYTE),
    sheet                          VARCHAR2(10 BYTE),
    desc_err                       VARCHAR2(1000 BYTE),
    file_imp                       VARCHAR2(50 BYTE),
    row_err                        VARCHAR2(10 BYTE),
    total_row_imp                  VARCHAR2(10 BYTE),
    status                         VARCHAR2(1 BYTE),
    imp_date                       VARCHAR2(20 BYTE))
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


-- Comments for TB_LOG_EXCEL

COMMENT ON COLUMN tb_log_excel.desc_err IS 'mo ta loi'
/
COMMENT ON COLUMN tb_log_excel.file_imp IS 'ten file nhap ngoai'
/
COMMENT ON COLUMN tb_log_excel.imp_date IS 'thoi gian nhan vao'
/
COMMENT ON COLUMN tb_log_excel.row_err IS 'dong excel loi'
/
COMMENT ON COLUMN tb_log_excel.sheet IS 'ten sheep trong excel'
/
COMMENT ON COLUMN tb_log_excel.short_name IS 'Ten ngan cqt'
/
COMMENT ON COLUMN tb_log_excel.status IS 'trang thai S: thanh cong, E:loi'
/
COMMENT ON COLUMN tb_log_excel.total_row_imp IS 'tong so dong nhan vao'
/

-- End of DDL Script for Table TEST.TB_LOG_EXCEL

-- Start of DDL Script for Table TEST.TB_LOG_PSCD
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_log_pscd
    (fieldname                      VARCHAR2(50 BYTE),
    msg_no                         VARCHAR2(10 BYTE),
    msg_type                       VARCHAR2(1 BYTE),
    msg_des                        VARCHAR2(200 BYTE),
    file_name                      VARCHAR2(50 BYTE),
    status                         VARCHAR2(10 BYTE),
    process_step                   VARCHAR2(10 BYTE),
    tin                            VARCHAR2(20 BYTE),
    id                             NUMBER(15,0),
    short_name                     VARCHAR2(7 BYTE),
    type_data                      VARCHAR2(2 BYTE),
    imp_date                       VARCHAR2(30 BYTE),
    id_hdr                         NUMBER(15,0))
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


-- End of DDL Script for Table TEST.TB_LOG_PSCD

-- Start of DDL Script for Table TEST.TB_LST_BAC_MBAI
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_lst_bac_mbai
    (bmbai_qlt                      NUMBER(2,0),
    bmbai_vatw                     VARCHAR2(10 BYTE),
    bmbai_pit                      VARCHAR2(10 BYTE),
    id                             NUMBER(10,0))
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


-- End of DDL Script for Table TEST.TB_LST_BAC_MBAI

-- Start of DDL Script for Table TEST.TB_LST_ERR
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_lst_err
    (err_id                         VARCHAR2(3 BYTE),
    err_name                       VARCHAR2(150 BYTE),
    err_type                       NUMBER(2,0))
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


-- Comments for TB_LST_ERR

COMMENT ON COLUMN tb_lst_err.err_id IS 'ma loi'
/
COMMENT ON COLUMN tb_lst_err.err_name IS 'ten loi'
/
COMMENT ON COLUMN tb_lst_err.err_type IS 'kieu loi'
/

-- End of DDL Script for Table TEST.TB_LST_ERR

-- Start of DDL Script for Table TEST.TB_LST_ERR_BK
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_lst_err_bk
    (err_id                         VARCHAR2(3 BYTE),
    err_name                       VARCHAR2(150 BYTE),
    err_type                       NUMBER(2,0))
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


-- End of DDL Script for Table TEST.TB_LST_ERR_BK

-- Start of DDL Script for Table TEST.TB_LST_MAP_CQT
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_lst_map_cqt
    (mandt                          VARCHAR2(9 BYTE) NOT NULL,
    ma_cqt                         VARCHAR2(12 BYTE) NOT NULL,
    ten_cqt_ngan                   VARCHAR2(75 BYTE) NOT NULL,
    ma_cqt_7                       VARCHAR2(21 BYTE) NOT NULL,
    ten_cqt_dai                    VARCHAR2(750 BYTE) NOT NULL,
    ma_cha_4                       VARCHAR2(12 BYTE) NOT NULL,
    ma_cha_7                       VARCHAR2(21 BYTE) NOT NULL,
    ma_qlt                         VARCHAR2(15 BYTE) NOT NULL,
    ma_kho_bac_nc                  VARCHAR2(21 BYTE) NOT NULL,
    ten_kb                         VARCHAR2(750 BYTE) NOT NULL,
    ma_tinh                        VARCHAR2(6 BYTE) NOT NULL,
    hl_tu                          VARCHAR2(24 BYTE) NOT NULL,
    hl_den                         VARCHAR2(24 BYTE) NOT NULL,
    vpflg                          VARCHAR2(3 BYTE) NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     196608
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_LST_MAP_CQT

CREATE INDEX ind_lst_map_cqt ON tb_lst_map_cqt
  (
    ma_cqt                          ASC
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

CREATE INDEX ind_lst_map_cqt7 ON tb_lst_map_cqt
  (
    ma_cqt_7                        ASC
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



-- End of DDL Script for Table TEST.TB_LST_MAP_CQT

-- Start of DDL Script for Table TEST.TB_LST_PROVINCE
-- Generated 3-Oct-2013 16:32:36 from TEST@DCNC

CREATE TABLE tb_lst_province
    (province                       VARCHAR2(3 BYTE) ,
    prov_name                      VARCHAR2(30 BYTE) NOT NULL,
    province_old                   VARCHAR2(2 BYTE))
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


-- Indexes for TB_LST_PROVINCE

CREATE UNIQUE INDEX ind_lst_pro_id ON tb_lst_province
  (
    province                        ASC
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



-- Constraints for TB_LST_PROVINCE

ALTER TABLE tb_lst_province
ADD CHECK ("PROVINCE" IS NOT NULL)
/


-- End of DDL Script for Table TEST.TB_LST_PROVINCE

-- Start of DDL Script for Table TEST.TB_LST_STACQT
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_lst_stacqt
    (id_name                        VARCHAR2(150 BYTE),
    tax_model                      VARCHAR2(6 BYTE),
    stt                            NUMBER(3,0),
    func_name                      VARCHAR2(30 BYTE))
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


-- Indexes for TB_LST_STACQT

CREATE INDEX ind_stacqt_func ON tb_lst_stacqt
  (
    func_name                       ASC
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



-- End of DDL Script for Table TEST.TB_LST_STACQT

-- Start of DDL Script for Table TEST.TB_LST_TAXO
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_lst_taxo
    (province                       VARCHAR2(3 BYTE),
    tax_code                       VARCHAR2(5 BYTE) NOT NULL,
    short_name                     VARCHAR2(10 BYTE),
    tax_name                       VARCHAR2(150 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         NUMBER(2,0) DEFAULT 0 NOT NULL,
    qlt_host                       VARCHAR2(30 BYTE),
    qlt_user                       VARCHAR2(20 BYTE),
    qlt_pass                       VARCHAR2(20 BYTE),
    vat_host                       VARCHAR2(20 BYTE),
    vat_user                       VARCHAR2(20 BYTE),
    vat_pass                       VARCHAR2(20 BYTE),
    vat_ddan_tu                    VARCHAR2(100 BYTE),
    vat_ddan_den                   VARCHAR2(100 BYTE),
    dblink                         VARCHAR2(2 BYTE),
    giai_doan                      VARCHAR2(20 BYTE),
    ky_chot                        DATE,
    pnn_host                       VARCHAR2(30 BYTE),
    pnn_user                       VARCHAR2(20 BYTE),
    pnn_pass                       VARCHAR2(20 BYTE),
    qtn_user                       VARCHAR2(20 BYTE),
    qtn_pass                       VARCHAR2(20 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     262144
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_LST_TAXO

CREATE INDEX ind_lst_taxo_sn ON tb_lst_taxo
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
/



-- Constraints for TB_LST_TAXO

ALTER TABLE tb_lst_taxo
ADD CONSTRAINT pk_lst_taxo PRIMARY KEY (tax_code)
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
/


-- End of DDL Script for Table TEST.TB_LST_TAXO

-- Start of DDL Script for Table TEST.TB_LST_TAXO_BK
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_lst_taxo_bk
    (province                       VARCHAR2(3 BYTE),
    tax_code                       VARCHAR2(5 BYTE) NOT NULL,
    short_name                     VARCHAR2(10 BYTE),
    tax_name                       VARCHAR2(150 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         NUMBER(2,0) NOT NULL,
    qlt_host                       VARCHAR2(30 BYTE),
    qlt_user                       VARCHAR2(20 BYTE),
    qlt_pass                       VARCHAR2(20 BYTE),
    tinc_host                      VARCHAR2(20 BYTE),
    tinc_user                      VARCHAR2(20 BYTE),
    tinc_pass                      VARCHAR2(20 BYTE),
    bmt_host                       VARCHAR2(20 BYTE),
    bmt_user                       VARCHAR2(20 BYTE),
    bmt_pass                       VARCHAR2(20 BYTE),
    vat_host                       VARCHAR2(20 BYTE),
    vat_user                       VARCHAR2(20 BYTE),
    vat_pass                       VARCHAR2(20 BYTE),
    vat_ddan_tu                    VARCHAR2(100 BYTE),
    vat_ddan_den                   VARCHAR2(100 BYTE),
    ky_ps_tu                       DATE,
    ky_ps_den                      DATE,
    ky_no_tu                       DATE,
    ky_no_den                      DATE,
    ky_ps10_tu                     DATE,
    ky_ps10_den                    DATE,
    ky_tk10_tu                     DATE,
    ky_tk10_den                    DATE,
    dblink                         VARCHAR2(2 BYTE),
    giai_doan                      VARCHAR2(20 BYTE),
    ky_chot                        DATE)
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


-- End of DDL Script for Table TEST.TB_LST_TAXO_BK

-- Start of DDL Script for Table TEST.TB_LST_TKHAI
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_lst_tkhai
    (id                             NUMBER(10,0),
    ten_tkhai                      VARCHAR2(100 BYTE),
    ma_tkhai_vatw                  VARCHAR2(20 BYTE),
    ma_tkhai_tms                   VARCHAR2(20 BYTE),
    ma_loai_tkhai_qlt              VARCHAR2(2 BYTE),
    ma_tkhai_qlt                   VARCHAR2(20 BYTE),
    tkhai_qtoan                    VARCHAR2(1 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TB_LST_TKHAI

-- Start of DDL Script for Table TEST.TB_LST_TKHAI_PS
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_lst_tkhai_ps
    (ma_loai_tkhai                  VARCHAR2(2 BYTE),
    ten_tkhai                      VARCHAR2(100 BYTE))
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


-- End of DDL Script for Table TEST.TB_LST_TKHAI_PS

-- Start of DDL Script for Table TEST.TB_MAP_KYTT
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_map_kytt
    (kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    kykk_tms                       VARCHAR2(4 BYTE))
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


-- End of DDL Script for Table TEST.TB_MAP_KYTT

-- Start of DDL Script for Table TEST.TB_MASTER_SL
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_master_sl
    (short_name                     VARCHAR2(7 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    thuetky                        NUMBER(15,0),
    thuepbo                        NUMBER(15,0),
    lydoloi                        VARCHAR2(150 BYTE),
    id                             NUMBER(8,0) NOT NULL,
    update_no                      NUMBER(3,0),
    table_name                     VARCHAR2(5 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    ky_psinh_tu                    VARCHAR2(10 BYTE),
    ky_psinh_den                   VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE))
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


-- End of DDL Script for Table TEST.TB_MASTER_SL

-- Start of DDL Script for Table TEST.TB_MESS_LOG
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_mess_log
    (mes_no                         VARCHAR2(3 BYTE),
    mes_desc                       VARCHAR2(1000 BYTE))
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


-- End of DDL Script for Table TEST.TB_MESS_LOG

-- Start of DDL Script for Table TEST.TB_NO
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_no
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    tmt_ma_tmuc                    VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    so_tien                        NUMBER,
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(*,0) DEFAULT NULL NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    so_qd                          VARCHAR2(20 BYTE),
    ngay_qd                        VARCHAR2(10 BYTE),
    tinh_chat                      VARCHAR2(2 BYTE),
    nguon_goc                      VARCHAR2(100 BYTE),
    no_nte                         VARCHAR2(1 BYTE),
    don_vi_tien                    VARCHAR2(20 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    tphat_den_ngay                 VARCHAR2(10 BYTE),
    ma_tkhai                       VARCHAR2(22 BYTE),
    tc_no_tms                      VARCHAR2(1 BYTE),
    tkhoan_tms                     VARCHAR2(3 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE))
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


-- Indexes for TB_NO

CREATE INDEX ind_qlt_no_short_name ON tb_no
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
/

CREATE INDEX ind_no_model ON tb_no
  (
    tax_model                       ASC
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

CREATE INDEX inx_ky_tu ON tb_no
  (
    kykk_tu_ngay                    ASC,
    kykk_den_ngay                   ASC,
    ngay_htoan                      ASC
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

CREATE INDEX ind_tin ON tb_no
  (
    tin                             ASC
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



-- Constraints for TB_NO

ALTER TABLE tb_no
ADD CONSTRAINT pk_no_id PRIMARY KEY (id)
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
/


-- Triggers for TB_NO

CREATE OR REPLACE TRIGGER trg_no_b
 BEFORE
  INSERT
 ON tb_no
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;

-- End of DDL Script for Table TEST.TB_VAT_DKNTK
/

CREATE OR REPLACE TRIGGER trg_no_bi
 BEFORE
  INSERT
 ON tb_no
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    c_tax_model VARCHAR2(7);
    CURSOR c1 (p_ma_tc VARCHAR2) IS
        SELECT ma_tc_tms FROM tb_dmuc_tchat_no
            WHERE ma = p_ma_tc;
            
    CURSOR c2 (p_tkhoan VARCHAR2, p_tax_model VARCHAR2) IS
        SELECT ma_tms FROM tb_dmuc_tkhoan
            WHERE trim(ma_cu) = trim(p_tkhoan) and tax_model = p_tax_model;
BEGIN
    
        OPEN c1 (:NEW.TINH_CHAT);
        LOOP
            FETCH c1 into :NEW.TC_NO_TMS;
            EXIT WHEN c1%notfound;
        END LOOP;
        CLOSE c1;                        

    c_tax_model := :NEW.tax_model;
    IF :NEW.tax_model = 'QCT-APP' THEN
        c_tax_model := 'QLT-APP';
    END IF;
    
        OPEN c2 (:NEW.TKHOAN, c_tax_model);
        LOOP
            FETCH c2 into :NEW.TKHOAN_TMS;
            EXIT WHEN c2%notfound;
        END LOOP;
        CLOSE c2;                        
  
END;
/


-- End of DDL Script for Table TEST.TB_NO

-- Start of DDL Script for Table TEST.TB_NO_NHAP_NGOAI
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_no_nhap_ngoai
    (short_name                     VARCHAR2(20 BYTE),
    tin                            VARCHAR2(20 BYTE),
    tmt_ma_tmuc                    VARCHAR2(20 BYTE),
    ky_lap_bo                      VARCHAR2(20 BYTE),
    ky_ke_khai                     VARCHAR2(20 BYTE),
    han_nop                        VARCHAR2(20 BYTE),
    so_tien                        NUMBER(20,0),
    tai_khoan                      VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TB_NO_NHAP_NGOAI

-- Start of DDL Script for Table TEST.TB_PACKAGE
-- Generated 3-Oct-2013 16:32:37 from TEST@DCNC

CREATE TABLE tb_package
    (id                             NUMBER(20,0) ,
    pck_name                       VARCHAR2(100 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    tbl_user_objects               VARCHAR2(30 BYTE),
    directory                      VARCHAR2(100 BYTE),
    pck_order                      NUMBER(3,0))
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


-- Indexes for TB_PACKAGE

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
/



-- Constraints for TB_PACKAGE

ALTER TABLE tb_package
ADD CONSTRAINT pk_tb_package_id PRIMARY KEY (id)
/


-- Triggers for TB_PACKAGE

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
/


-- End of DDL Script for Table TEST.TB_PACKAGE

-- Start of DDL Script for Table TEST.TB_PIT
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pit
    (ma_cqt                         VARCHAR2(12 BYTE) NOT NULL,
    persl                          VARCHAR2(12 BYTE) NOT NULL,
    total                          NUMBER,
    he_thong                       CHAR(3 BYTE),
    mst                            VARCHAR2(180 BYTE) NOT NULL)
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


-- End of DDL Script for Table TEST.TB_PIT

-- Start of DDL Script for Table TEST.TB_PITMS_DPPIT_MAPPING
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pitms_dppit_mapping
    (pitms_column                   VARCHAR2(50 BYTE),
    dppit_column                   VARCHAR2(50 BYTE),
    table_name                     VARCHAR2(5 BYTE))
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


-- End of DDL Script for Table TEST.TB_PITMS_DPPIT_MAPPING

-- Start of DDL Script for Table TEST.TB_PNN_DM_COMMUNE
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_commune
    (province                       VARCHAR2(9 BYTE) NOT NULL,
    dist_code                      VARCHAR2(15 BYTE) NOT NULL,
    comm_code                      VARCHAR2(21 BYTE) NOT NULL,
    comm_name                      VARCHAR2(180 BYTE) NOT NULL,
    start_date                     DATE,
    finish_date                    DATE,
    cdc                            NUMBER(1,0),
    last_update_dt                 DATE)
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


-- End of DDL Script for Table TEST.TB_PNN_DM_COMMUNE

-- Start of DDL Script for Table TEST.TB_PNN_DM_DISTRICT
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_district
    (province                       VARCHAR2(9 BYTE) NOT NULL,
    dist_code                      VARCHAR2(15 BYTE) NOT NULL,
    dist_name                      VARCHAR2(90 BYTE) NOT NULL,
    cdc                            NUMBER(1,0),
    last_update_dt                 DATE,
    ten_dia_danh                   VARCHAR2(300 BYTE))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_DISTRICT

-- Start of DDL Script for Table TEST.TB_PNN_DM_DOAN_DUONG
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_doan_duong
    (ma_doan_duong                  VARCHAR2(11 CHAR) NOT NULL,
    ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ten_doan_duong                 VARCHAR2(300 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ma_doan_duong_off              VARCHAR2(7 CHAR),
    ngay_hl_tu                     VARCHAR2(15 BYTE),
    ngay_hl_den                    VARCHAR2(15 BYTE),
    ghi_chu                        VARCHAR2(200 CHAR))
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


-- Constraints for TB_PNN_DM_DOAN_DUONG

ALTER TABLE tb_pnn_dm_doan_duong
ADD CONSTRAINT xpktb_pnn_dm_doan_duong PRIMARY KEY (ma_doan_duong, ma_duong, 
  ma_huyen)
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
/


-- End of DDL Script for Table TEST.TB_PNN_DM_DOAN_DUONG

-- Start of DDL Script for Table TEST.TB_PNN_DM_GIA_DAT
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_gia_dat
    (ma_gia_dat                     VARCHAR2(5 CHAR),
    ma_tinh                        VARCHAR2(3 CHAR) NOT NULL,
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ma_loai_dat                    VARCHAR2(6 CHAR) NOT NULL,
    ma_muc_dich                    VARCHAR2(3 CHAR) NOT NULL,
    ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ma_doan_duong                  VARCHAR2(11 CHAR) NOT NULL,
    ma_vi_tri                      VARCHAR2(8 CHAR) NOT NULL,
    gia                            NUMBER(16,2),
    ngay_hl_tu                     VARCHAR2(15 BYTE) NOT NULL,
    ngay_hl_den                    VARCHAR2(15 BYTE),
    ma_loai_duong                  VARCHAR2(6 CHAR),
    ghi_chu                        VARCHAR2(200 BYTE),
    nam                            VARCHAR2(15 BYTE) NOT NULL)
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


-- Constraints for TB_PNN_DM_GIA_DAT

ALTER TABLE tb_pnn_dm_gia_dat
ADD CHECK ("GIA" IS NOT NULL)
/

ALTER TABLE tb_pnn_dm_gia_dat
ADD CONSTRAINT tb_pnn_dm_gia_dat$uk1 UNIQUE (ma_gia_dat)
DISABLE NOVALIDATE
/


-- End of DDL Script for Table TEST.TB_PNN_DM_GIA_DAT

-- Start of DDL Script for Table TEST.TB_PNN_DM_LOAI_DAT
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_loai_dat
    (ma_loai_dat                    VARCHAR2(6 CHAR) NOT NULL,
    ten_tms                        VARCHAR2(70 CHAR) NOT NULL,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_loai_dat_tms                VARCHAR2(6 BYTE),
    ma_tinh                        VARCHAR2(3 BYTE),
    ten                            VARCHAR2(70 BYTE),
    ma_tmuc                        VARCHAR2(4 BYTE))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_LOAI_DAT

-- Start of DDL Script for Table TEST.TB_PNN_DM_LOAI_DUONG
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_loai_duong
    (ma_loai_duong                  VARCHAR2(6 CHAR) NOT NULL,
    ten                            VARCHAR2(70 CHAR) NOT NULL,
    ngay_hl_tu                     DATE NOT NULL,
    ngay_hl_den                    DATE,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_loai_duong_tms              VARCHAR2(6 BYTE),
    ten_tms                        VARCHAR2(70 BYTE),
    ma_tinh                        VARCHAR2(3 BYTE))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_LOAI_DUONG

-- Start of DDL Script for Table TEST.TB_PNN_DM_MIEN_GIAM
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_mien_giam
    (ma_lydo                        VARCHAR2(5 CHAR) NOT NULL,
    ma_tinh                        VARCHAR2(3 BYTE) NOT NULL,
    ten                            VARCHAR2(100 CHAR) NOT NULL,
    tyle                           NUMBER(4,2) NOT NULL,
    ghi_chu                        VARCHAR2(500 CHAR),
    loai_mgiam                     VARCHAR2(1 CHAR),
    ma_lydo_off                    VARCHAR2(2 CHAR),
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
/


-- End of DDL Script for Table TEST.TB_PNN_DM_MIEN_GIAM

-- Start of DDL Script for Table TEST.TB_PNN_DM_MUC_DICH_SD
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_muc_dich_sd
    (ma_muc_dich                    VARCHAR2(3 CHAR) NOT NULL,
    ten                            VARCHAR2(150 CHAR),
    heso                           NUMBER(16,7))
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


-- End of DDL Script for Table TEST.TB_PNN_DM_MUC_DICH_SD

-- Start of DDL Script for Table TEST.TB_PNN_DM_PROVINCE
-- Generated 3-Oct-2013 16:32:38 from TEST@DCNC

CREATE TABLE tb_pnn_dm_province
    (province                       VARCHAR2(9 BYTE) ,
    prov_name                      VARCHAR2(90 BYTE) NOT NULL,
    province_old                   VARCHAR2(6 BYTE) NOT NULL,
    cdc                            NUMBER(1,0),
    last_update_dt                 DATE)
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


-- Constraints for TB_PNN_DM_PROVINCE

ALTER TABLE tb_pnn_dm_province
ADD CHECK ("PROVINCE" IS NOT NULL)
/


-- End of DDL Script for Table TEST.TB_PNN_DM_PROVINCE

-- Start of DDL Script for Table TEST.TB_PNN_DM_TEN_DUONG
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_pnn_dm_ten_duong
    (ma_duong                       VARCHAR2(8 CHAR) NOT NULL,
    ten                            VARCHAR2(300 CHAR) ,
    ma_tinh                        VARCHAR2(3 CHAR) NOT NULL,
    ma_huyen                       VARCHAR2(5 CHAR) NOT NULL,
    ghi_chu                        VARCHAR2(200 CHAR),
    ma_duong_off                   VARCHAR2(3 CHAR),
    ngay_hl_tu                     VARCHAR2(15 BYTE) NOT NULL,
    ngay_hl_den                    VARCHAR2(15 BYTE))
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


-- Constraints for TB_PNN_DM_TEN_DUONG

ALTER TABLE tb_pnn_dm_ten_duong
ADD CONSTRAINT xpkpnn_dm_ten_duong PRIMARY KEY (ma_duong, ma_huyen)
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
/

ALTER TABLE tb_pnn_dm_ten_duong
ADD CHECK ("TEN" IS NOT NULL)
/


-- End of DDL Script for Table TEST.TB_PNN_DM_TEN_DUONG

-- Start of DDL Script for Table TEST.TB_PNN_DM_THON
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_pnn_dm_thon
    (ma_thon                        VARCHAR2(9 CHAR) NOT NULL,
    ma_xa                          VARCHAR2(7 CHAR),
    ten                            VARCHAR2(100 CHAR),
    ma_huyen                       VARCHAR2(5 CHAR),
    ma_tinh                        VARCHAR2(3 BYTE),
    ngay_hl_tu                     VARCHAR2(15 BYTE),
    ngay_hl_den                    VARCHAR2(15 BYTE))
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


-- Constraints for TB_PNN_DM_THON

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
/


-- End of DDL Script for Table TEST.TB_PNN_DM_THON

-- Start of DDL Script for Table TEST.TB_PNN_DM_VI_TRI
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_pnn_dm_vi_tri
    (ma_vi_tri                      VARCHAR2(8 BYTE) NOT NULL,
    ten                            VARCHAR2(150 BYTE) NOT NULL,
    ma_tinh                        VARCHAR2(3 BYTE) NOT NULL,
    heso                           NUMBER(16,7),
    ngay_hl_tu                     VARCHAR2(15 BYTE) NOT NULL,
    ngay_hl_den                    VARCHAR2(15 BYTE),
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
/


-- Constraints for TB_PNN_DM_VI_TRI

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
/


-- End of DDL Script for Table TEST.TB_PNN_DM_VI_TRI

-- Start of DDL Script for Table TEST.TB_PS
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_ps
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    ma_tmuc                        VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) ,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_tkhai_tms                   VARCHAR2(4 BYTE),
    err_id                         NUMBER(*,0),
    err_des                        VARCHAR2(200 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE),
    tkhoan_tms                     VARCHAR2(3 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_PS

CREATE INDEX ind_qlt_ps_short_name ON tb_ps
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     589824
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_ps_model ON tb_ps
  (
    tax_model                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     524288
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX ind_ps_tin ON tb_ps
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     655360
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/



-- Constraints for TB_PS

ALTER TABLE tb_ps
ADD CONSTRAINT pk_ps_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     458752
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Triggers for TB_PS

CREATE OR REPLACE TRIGGER trg_ps_b
 BEFORE
  INSERT
 ON tb_ps
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ps_bi
 BEFORE
  INSERT
 ON tb_ps
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    CURSOR c1 (p_ma_tkhai VARCHAR2, p_tax_model VARCHAR2) IS
        SELECT ma_tms FROM tb_dmuc_tkhai
            WHERE trim(ma) = trim(p_ma_tkhai) and tax_model = p_tax_model;
    CURSOR c2 (p_ma_tkhai VARCHAR2) IS
        SELECT ma_tms FROM tb_dmuc_tkhai
            WHERE trim(ma_vatwin) = trim(p_ma_tkhai);
BEGIN

    :NEW.TKHOAN_TMS := '741';
    
    IF :NEW.tax_model = 'QLT-APP' OR :NEW.tax_model = 'QCT-APP' THEN
        OPEN c1 (:NEW.ma_tkhai, :NEW.tax_model);
        LOOP
            FETCH c1 into :NEW.ma_tkhai_tms;
            EXIT WHEN c1%notfound;
        END LOOP;
        CLOSE c1;                        
    END IF;
    
    IF :NEW.tax_model = 'VAT-APP' THEN
        OPEN c2 (:NEW.ma_tkhai);
        LOOP
            FETCH c2 into :NEW.ma_tkhai_tms;
            EXIT WHEN c2%notfound;
        END LOOP;
        CLOSE c2;                        
    END IF;   
     
END;
/


-- End of DDL Script for Table TEST.TB_PS

-- Start of DDL Script for Table TEST.TB_PT
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_pt
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
    status                         VARCHAR2(2 BYTE),
    message                        VARCHAR2(200 BYTE),
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
/


-- Indexes for TB_PT

CREATE INDEX ind_pt_sname ON tb_pt
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
/



-- Triggers for TB_PT

CREATE OR REPLACE TRIGGER trg_pt_b
 BEFORE
  INSERT
 ON tb_pt
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_PT.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_PT

-- Start of DDL Script for Table TEST.TB_QCT_DM_GDICH_QDINH
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_qct_dm_gdich_qdinh
    (ten_gdich                      VARCHAR2(100 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    kieu_gdich                     VARCHAR2(2 BYTE),
    bang_hdr                       VARCHAR2(50 BYTE),
    ten_qdinh                      VARCHAR2(100 BYTE),
    ten_cot_sqd                    VARCHAR2(20 BYTE),
    ten_cot_nqd                    VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TB_QCT_DM_GDICH_QDINH

-- Start of DDL Script for Table TEST.TB_QLT_DM_GDICH_QDINH
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_qlt_dm_gdich_qdinh
    (ten_gdich                      VARCHAR2(100 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    kieu_gdich                     VARCHAR2(2 BYTE),
    bang_hdr                       VARCHAR2(50 BYTE),
    ten_qdinh                      VARCHAR2(100 BYTE),
    ten_cot_sqd                    VARCHAR2(20 BYTE),
    ten_cot_nqd                    VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TB_QLT_DM_GDICH_QDINH

-- Start of DDL Script for Table TEST.TB_SLECH_NO
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_slech_no
    (short_name                     VARCHAR2(7 BYTE),
    loai                           CHAR(3 BYTE),
    ky_thue                        DATE,
    tin                            VARCHAR2(14 BYTE),
    ten_dtnt                       VARCHAR2(250 BYTE),
    tai_khoan                      VARCHAR2(30 BYTE),
    muc                            VARCHAR2(4 BYTE),
    tieumuc                        VARCHAR2(4 BYTE),
    mathue                         VARCHAR2(2 BYTE),
    sothue_no_cky                  NUMBER(15,0),
    sono_no_cky                    NUMBER(15,0),
    clech_no_cky                   NUMBER(15,0),
    ma_cbo                         VARCHAR2(15 BYTE),
    ten_cbo                        VARCHAR2(150 BYTE),
    ma_pban                        VARCHAR2(15 BYTE),
    ten_pban                       VARCHAR2(250 BYTE),
    ma_slech                       NUMBER(2,0),
    ma_gdich                       VARCHAR2(3 BYTE),
    ten_gdich                      VARCHAR2(100 BYTE))
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


-- Indexes for TB_SLECH_NO

CREATE INDEX ind_slno_short_name ON tb_slech_no
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
/



-- End of DDL Script for Table TEST.TB_SLECH_NO

-- Start of DDL Script for Table TEST.TB_SLECH_TIN
-- Generated 3-Oct-2013 16:32:39 from TEST@DCNC

CREATE TABLE tb_slech_tin
    (tin                            VARCHAR2(14 BYTE),
    status                         VARCHAR2(2 BYTE),
    regi_date                      DATE,
    payer_type                     VARCHAR2(2 BYTE),
    norm_name                      VARCHAR2(250 BYTE),
    ten_phong                      VARCHAR2(250 BYTE),
    ten_canbo                      VARCHAR2(250 BYTE),
    update_no                      NUMBER(3,0),
    short_name                     VARCHAR2(7 BYTE))
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


-- Indexes for TB_SLECH_TIN

CREATE INDEX ind_sltin_upn ON tb_slech_tin
  (
    update_no                       ASC
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

CREATE INDEX ind_sltin_shn ON tb_slech_tin
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
/



-- End of DDL Script for Table TEST.TB_SLECH_TIN

-- Start of DDL Script for Table TEST.TB_TABLES
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

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

-- Start of DDL Script for Table TEST.TB_TEMP_DCHIEU
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_temp_dchieu
    (short_name                     VARCHAR2(7 BYTE),
    mau                            VARCHAR2(10 BYTE),
    v_char1                        VARCHAR2(20 BYTE),
    v_char2                        VARCHAR2(50 BYTE),
    v_char3                        VARCHAR2(50 BYTE),
    loai                           VARCHAR2(2 BYTE))
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


-- Indexes for TB_TEMP_DCHIEU

CREATE INDEX ind_tmpdchieu_sname ON tb_temp_dchieu
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
/



-- End of DDL Script for Table TEST.TB_TEMP_DCHIEU

-- Start of DDL Script for Table TEST.TB_TEMP_HTDC_NO
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_temp_htdc_no
    (a_tax_model                    VARCHAR2(10 BYTE),
    a_ma_tmuc                      VARCHAR2(20 BYTE),
    b_tax_model                    VARCHAR2(9 BYTE),
    b_ma_tmuc                      VARCHAR2(13 BYTE),
    a_so_no                        VARCHAR2(50 BYTE),
    b_so_no                        VARCHAR2(20 BYTE),
    sl_so_no                       VARCHAR2(1 BYTE),
    a_so_thua                      VARCHAR2(50 BYTE),
    b_so_thua                      VARCHAR2(20 BYTE),
    sl_so_thua                     VARCHAR2(1 BYTE),
    short_name                     VARCHAR2(7 BYTE))
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


-- End of DDL Script for Table TEST.TB_TEMP_HTDC_NO

-- Start of DDL Script for Table TEST.TB_TEMP_HTDC_PS
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_temp_htdc_ps
    (a_tax_model                    VARCHAR2(10 BYTE),
    a_to_khai                      VARCHAR2(20 BYTE),
    b_tax_model                    VARCHAR2(9 BYTE),
    b_to_khai                      VARCHAR2(20 BYTE),
    a_sotien                       VARCHAR2(50 BYTE),
    b_sotien                       VARCHAR2(20 BYTE),
    sl_sotien                      VARCHAR2(1 BYTE),
    short_name                     VARCHAR2(7 BYTE))
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


-- End of DDL Script for Table TEST.TB_TEMP_HTDC_PS

-- Start of DDL Script for Table TEST.TB_TEMP_HTDC_TK
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_temp_htdc_tk
    (a_tax_model                    VARCHAR2(10 BYTE),
    a_to_khai                      VARCHAR2(20 BYTE),
    b_tax_model                    VARCHAR2(9 BYTE),
    b_to_khai                      VARCHAR2(20 BYTE),
    a_sotien                       VARCHAR2(50 BYTE),
    b_sotien                       VARCHAR2(20 BYTE),
    sl_sotien                      VARCHAR2(1 BYTE),
    short_name                     VARCHAR2(7 BYTE))
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


-- End of DDL Script for Table TEST.TB_TEMP_HTDC_TK

-- Start of DDL Script for Table TEST.TB_TINH_PHAT
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_tinh_phat
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    tmt_ma_tmuc                    VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    so_tien                        NUMBER,
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(*,0) DEFAULT NULL NOT NULL,
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    ten_nnt                        VARCHAR2(150 BYTE),
    tkhoan_tms                     VARCHAR2(3 BYTE))
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


-- Indexes for TB_TINH_PHAT

CREATE INDEX ind_tph_tin ON tb_tinh_phat
  (
    tin                             ASC
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

CREATE INDEX ind_tph_tax_model ON tb_tinh_phat
  (
    tax_model                       ASC
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

CREATE INDEX ind_tph_short_name ON tb_tinh_phat
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
/



-- Constraints for TB_TINH_PHAT

ALTER TABLE tb_tinh_phat
ADD CONSTRAINT pk_tinh_phat_id PRIMARY KEY (id)
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
/


-- Triggers for TB_TINH_PHAT

CREATE OR REPLACE TRIGGER trg_tinh_phat_b
 BEFORE
  INSERT
 ON tb_tinh_phat
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;

-- End of DDL Script for Table TEST.TB_VAT_DKNTK
/

CREATE OR REPLACE TRIGGER trg_tphat_bi
 BEFORE
  INSERT
 ON tb_tinh_phat
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN

    :NEW.TKHOAN_TMS := '741';

     
END;
/


-- End of DDL Script for Table TEST.TB_TINH_PHAT

-- Start of DDL Script for Table TEST.TB_TK
-- Generated 3-Oct-2013 16:32:40 from TEST@DCNC

CREATE TABLE tb_tk
    (short_name                     VARCHAR2(7 BYTE),
    tin                            VARCHAR2(14 BYTE) NOT NULL,
    kykk_tu_ngay                   VARCHAR2(10 BYTE) NOT NULL,
    kykk_den_ngay                  VARCHAR2(10 BYTE) NOT NULL,
    kylb_tu_ngay                   VARCHAR2(10 BYTE),
    dthu_dkien                     NUMBER(15,0),
    tl_thnhap_dkien                NUMBER(20,5),
    thnhap_cthue_dkien             NUMBER(15,0),
    gtru_gcanh                     NUMBER(15,0),
    ban_than                       NUMBER(15,0),
    phu_thuoc                      NUMBER(15,0),
    thnhap_tthue_dkien             NUMBER(15,0),
    tncn                           NUMBER(15,0),
    pb01                           NUMBER(15,0),
    kytt01                         VARCHAR2(4 BYTE),
    ht01                           VARCHAR2(10 BYTE),
    hn01                           VARCHAR2(10 BYTE),
    pb02                           NUMBER(15,0),
    kytt02                         VARCHAR2(4 BYTE),
    ht02                           VARCHAR2(10 BYTE),
    hn02                           VARCHAR2(10 BYTE),
    pb03                           NUMBER(15,0),
    kytt03                         VARCHAR2(4 BYTE),
    ht03                           VARCHAR2(10 BYTE),
    hn03                           VARCHAR2(10 BYTE),
    pb04                           NUMBER(15,0),
    kytt04                         VARCHAR2(4 BYTE),
    ht04                           VARCHAR2(10 BYTE),
    hn04                           VARCHAR2(10 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    stt                            NUMBER(10,0),
    status                         CHAR(1 BYTE),
    mst_dtk                        VARCHAR2(14 BYTE),
    hd_dlt_so                      VARCHAR2(30 BYTE),
    hd_dlt_ngay                    VARCHAR2(10 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    rv_so_tien                     NUMBER(15,0),
    tax_model                      VARCHAR2(7 BYTE),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    flag                           NUMBER(4,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     13631488
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Indexes for TB_TK

CREATE INDEX ind_vat_tk_short_name ON tb_tk
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
/

CREATE INDEX ind_tk_tin ON tb_tk
  (
    tin                             ASC
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



-- Constraints for TB_TK

ALTER TABLE tb_tk
ADD CONSTRAINT pk_tk_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     917504
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Triggers for TB_TK

CREATE OR REPLACE TRIGGER trg_tk_b
 BEFORE
  INSERT
 ON tb_tk
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_au_tb_tk
 AFTER
  UPDATE
 ON tb_tk
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
--   IF (:old.FLAG <> 'U' Or :old.FLAG Is Not Null) Then
   IF (:new.FLAG = :old.FLAG AND :new.FLAG IS NOT NULL AND :old.FLAG IS NOT NULL)
   OR (:old.FLAG IS NULL AND :new.FLAG IS NULL) Then
   IF (:new.DTHU_DKIEN <> :old.DTHU_DKIEN  AND :old.DTHU_DKIEN IS NOT NULL AND :new.DTHU_DKIEN IS NOT NULL) OR
                 (:old.DTHU_DKIEN IS NOT NULL AND :new.DTHU_DKIEN IS NULL) OR
                 (:old.DTHU_DKIEN IS NULL AND :new.DTHU_DKIEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','DTHU_DKIEN',:new.DTHU_DKIEN,:old.DTHU_DKIEN);
   END IF;
   IF (:new.TL_THNHAP_DKIEN <> :old.TL_THNHAP_DKIEN  AND :old.TL_THNHAP_DKIEN IS NOT NULL AND :new.TL_THNHAP_DKIEN IS NOT NULL) OR
                 (:old.TL_THNHAP_DKIEN IS NOT NULL AND :new.TL_THNHAP_DKIEN IS NULL) OR
                 (:old.TL_THNHAP_DKIEN IS NULL AND :new.TL_THNHAP_DKIEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','TL_THNHAP_DKIEN',:new.TL_THNHAP_DKIEN,:old.TL_THNHAP_DKIEN);
   END IF;
   IF (:new.THNHAP_CTHUE_DKIEN <> :old.THNHAP_CTHUE_DKIEN  AND :old.THNHAP_CTHUE_DKIEN IS NOT NULL AND :new.THNHAP_CTHUE_DKIEN IS NOT NULL) OR
                 (:old.THNHAP_CTHUE_DKIEN IS NOT NULL AND :new.THNHAP_CTHUE_DKIEN IS NULL) OR
                 (:old.THNHAP_CTHUE_DKIEN IS NULL AND :new.THNHAP_CTHUE_DKIEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','THNHAP_CTHUE_DKIEN',:new.THNHAP_CTHUE_DKIEN,:old.THNHAP_CTHUE_DKIEN);
   END IF;
   IF (:new.GTRU_GCANH <> :old.GTRU_GCANH  AND :old.GTRU_GCANH IS NOT NULL AND :new.GTRU_GCANH IS NOT NULL) OR
                 (:old.GTRU_GCANH IS NOT NULL AND :new.GTRU_GCANH IS NULL) OR
                 (:old.GTRU_GCANH IS NULL AND :new.GTRU_GCANH IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','GTRU_GCANH',:new.GTRU_GCANH,:old.GTRU_GCANH);            
   END IF;
   IF (:new.BAN_THAN <> :old.BAN_THAN  AND :old.BAN_THAN IS NOT NULL AND :new.BAN_THAN IS NOT NULL) OR
                 (:old.BAN_THAN IS NOT NULL AND :new.BAN_THAN IS NULL) OR
                 (:old.BAN_THAN IS NULL AND :new.BAN_THAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','BAN_THAN',:new.BAN_THAN,:old.BAN_THAN);            
   END IF;
   IF (:new.KYKK_TU_NGAY <> :old.KYKK_TU_NGAY  AND :old.KYKK_TU_NGAY IS NOT NULL AND :new.KYKK_TU_NGAY IS NOT NULL) OR
                 (:old.KYKK_TU_NGAY IS NOT NULL AND :new.KYKK_TU_NGAY IS NULL) OR
                 (:old.KYKK_TU_NGAY IS NULL AND :new.KYKK_TU_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYKK_TU_NGAY',:new.KYKK_TU_NGAY,:old.KYKK_TU_NGAY);
   END IF;
   IF (:new.KYKK_DEN_NGAY <> :old.KYKK_DEN_NGAY  AND :old.KYKK_DEN_NGAY IS NOT NULL AND :new.KYKK_DEN_NGAY IS NOT NULL) OR
                 (:old.KYKK_DEN_NGAY IS NOT NULL AND :new.KYKK_DEN_NGAY IS NULL) OR
                 (:old.KYKK_DEN_NGAY IS NULL AND :new.KYKK_DEN_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYKK_DEN_NGAY',:new.KYKK_DEN_NGAY,:old.KYKK_DEN_NGAY);
   END IF;
   IF (:new.KYLB_TU_NGAY <> :old.KYLB_TU_NGAY  AND :old.KYLB_TU_NGAY IS NOT NULL AND :new.KYLB_TU_NGAY IS NOT NULL) OR
                 (:old.KYLB_TU_NGAY IS NOT NULL AND :new.KYLB_TU_NGAY IS NULL) OR
                 (:old.KYLB_TU_NGAY IS NULL AND :new.KYLB_TU_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYLB_TU_NGAY',:new.KYLB_TU_NGAY,:old.KYLB_TU_NGAY);
   END IF;
   IF (:new.PHU_THUOC <> :old.PHU_THUOC  AND :old.PHU_THUOC IS NOT NULL AND :new.PHU_THUOC IS NOT NULL) OR
                 (:old.PHU_THUOC IS NOT NULL AND :new.PHU_THUOC IS NULL) OR
                 (:old.PHU_THUOC IS NULL AND :new.PHU_THUOC IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','PHU_THUOC',:new.PHU_THUOC,:old.PHU_THUOC);
   END IF;
   IF (:new.THNHAP_TTHUE_DKIEN <> :old.THNHAP_TTHUE_DKIEN  AND :old.THNHAP_TTHUE_DKIEN IS NOT NULL AND :new.THNHAP_TTHUE_DKIEN IS NOT NULL) OR
                 (:old.THNHAP_TTHUE_DKIEN IS NOT NULL AND :new.THNHAP_TTHUE_DKIEN IS NULL) OR
                 (:old.THNHAP_TTHUE_DKIEN IS NULL AND :new.THNHAP_TTHUE_DKIEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','THNHAP_TTHUE_DKIEN',:new.THNHAP_TTHUE_DKIEN,:old.THNHAP_TTHUE_DKIEN);
   END IF;
   IF (:new.TNCN <> :old.TNCN  AND :old.TNCN IS NOT NULL AND :new.TNCN IS NOT NULL) OR
                 (:old.TNCN IS NOT NULL AND :new.TNCN IS NULL) OR
                 (:old.TNCN IS NULL AND :new.TNCN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','TNCN',:new.TNCN,:old.TNCN);
   END IF;
   IF (:new.PB01 <> :old.PB01  AND :old.PB01 IS NOT NULL AND :new.PB01 IS NOT NULL) OR
                 (:old.PB01 IS NOT NULL AND :new.PB01 IS NULL) OR
                 (:old.PB01 IS NULL AND :new.PB01 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','PB01',:new.PB01,:old.PB01);
   END IF;
   IF (:new.PB02 <> :old.PB02  AND :old.PB02 IS NOT NULL AND :new.PB02 IS NOT NULL) OR
                 (:old.PB02 IS NOT NULL AND :new.PB02 IS NULL) OR
                 (:old.PB02 IS NULL AND :new.PB02 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','PB02',:new.PB02,:old.PB02);
   END IF;
   IF (:new.PB03 <> :old.PB03  AND :old.PB03 IS NOT NULL AND :new.PB03 IS NOT NULL) OR
                 (:old.PB03 IS NOT NULL AND :new.PB03 IS NULL) OR
                 (:old.PB03 IS NULL AND :new.PB03 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','PB03',:new.PB03,:old.PB03);
   END IF;
   IF (:new.PB04 <> :old.PB04  AND :old.PB04 IS NOT NULL AND :new.PB04 IS NOT NULL) OR
                 (:old.PB04 IS NOT NULL AND :new.PB04 IS NULL) OR
                 (:old.PB04 IS NULL AND :new.PB04 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','PB04',:new.PB04,:old.PB04);
   END IF;
   IF (:new.KYTT01 <> :old.KYTT01  AND :old.KYTT01 IS NOT NULL AND :new.KYTT01 IS NOT NULL) OR
                 (:old.KYTT01 IS NOT NULL AND :new.KYTT01 IS NULL) OR
                 (:old.KYTT01 IS NULL AND :new.KYTT01 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYTT01',:new.KYTT01,:old.KYTT01);
   END IF;
   IF (:new.KYTT02 <> :old.KYTT02  AND :old.KYTT02 IS NOT NULL AND :new.KYTT02 IS NOT NULL) OR
                 (:old.KYTT02 IS NOT NULL AND :new.KYTT02 IS NULL) OR
                 (:old.KYTT02 IS NULL AND :new.KYTT02 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYTT02',:new.KYTT02,:old.KYTT02);
   END IF;
      IF (:new.KYTT03 <> :old.KYTT03  AND :old.KYTT03 IS NOT NULL AND :new.KYTT03 IS NOT NULL) OR
                 (:old.KYTT03 IS NOT NULL AND :new.KYTT03 IS NULL) OR
                 (:old.KYTT03 IS NULL AND :new.KYTT03 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYTT03',:new.KYTT03,:old.KYTT03);
   END IF;
      IF (:new.KYTT04 <> :old.KYTT04  AND :old.KYTT04 IS NOT NULL AND :new.KYTT04 IS NOT NULL) OR
                 (:old.KYTT04 IS NOT NULL AND :new.KYTT04 IS NULL) OR
                 (:old.KYTT04 IS NULL AND :new.KYTT04 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','KYTT04',:new.KYTT04,:old.KYTT04);
   END IF;
      IF (:new.HT01 <> :old.HT01  AND :old.HT01 IS NOT NULL AND :new.HT01 IS NOT NULL) OR
                 (:old.HT01 IS NOT NULL AND :new.HT01 IS NULL) OR
                 (:old.HT01 IS NULL AND :new.HT01 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HT01',:new.HT01,:old.HT01);
   END IF;
      IF (:new.HT02 <> :old.HT02  AND :old.HT02 IS NOT NULL AND :new.HT02 IS NOT NULL) OR
                 (:old.HT02 IS NOT NULL AND :new.HT02 IS NULL) OR
                 (:old.HT02 IS NULL AND :new.HT02 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HT02',:new.HT02,:old.HT02);
   END IF;
      IF (:new.HT03 <> :old.HT03  AND :old.HT03 IS NOT NULL AND :new.HT03 IS NOT NULL) OR
                 (:old.HT03 IS NOT NULL AND :new.HT03 IS NULL) OR
                 (:old.HT03 IS NULL AND :new.HT03 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HT03',:new.HT03,:old.HT03);
   END IF;
      IF (:new.HT04 <> :old.HT04  AND :old.HT04 IS NOT NULL AND :new.HT04 IS NOT NULL) OR
                 (:old.HT04 IS NOT NULL AND :new.HT04 IS NULL) OR
                 (:old.HT04 IS NULL AND :new.HT04 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HT04',:new.HT04,:old.HT04);
   END IF;
      IF (:new.HN01 <> :old.HN01  AND :old.HN01 IS NOT NULL AND :new.HN01 IS NOT NULL) OR
                 (:old.HN01 IS NOT NULL AND :new.HN01 IS NULL) OR
                 (:old.HN01 IS NULL AND :new.HN01 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HN01',:new.HN01,:old.HN01);
   END IF;
      IF (:new.HN02 <> :old.HN02  AND :old.HN02 IS NOT NULL AND :new.HN02 IS NOT NULL) OR
                 (:old.HN02 IS NOT NULL AND :new.HN02 IS NULL) OR
                 (:old.HN02 IS NULL AND :new.HN02 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HN02',:new.HN02,:old.HN02);
   END IF;
      IF (:new.HN03 <> :old.HN03  AND :old.HN03 IS NOT NULL AND :new.HN03 IS NOT NULL) OR
                 (:old.HN03 IS NOT NULL AND :new.HN03 IS NULL) OR
                 (:old.HN03 IS NULL AND :new.HN03 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HN03',:new.HN03,:old.HN03);
   END IF;
      IF (:new.HN04 <> :old.HN04  AND :old.HN04 IS NOT NULL AND :new.HN04 IS NOT NULL) OR
                 (:old.HN04 IS NOT NULL AND :new.HN04 IS NULL) OR
                 (:old.HN04 IS NULL AND :new.HN04 IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HN04',:new.HN04,:old.HN04);
   END IF;
      IF (:new.MST_DTK <> :old.MST_DTK  AND :old.MST_DTK IS NOT NULL AND :new.MST_DTK IS NOT NULL) OR
                 (:old.MST_DTK IS NOT NULL AND :new.MST_DTK IS NULL) OR
                 (:old.MST_DTK IS NULL AND :new.MST_DTK IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','MST_DTK',:new.MST_DTK,:old.MST_DTK);
   END IF;
      IF (:new.HD_DLT_SO <> :old.HD_DLT_SO  AND :old.HD_DLT_SO IS NOT NULL AND :new.HD_DLT_SO IS NOT NULL) OR
                 (:old.HD_DLT_SO IS NOT NULL AND :new.HD_DLT_SO IS NULL) OR
                 (:old.HD_DLT_SO IS NULL AND :new.HD_DLT_SO IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HD_DLT_SO',:new.HD_DLT_SO,:old.HD_DLT_SO);
   END IF;
      IF (:new.HD_DLT_NGAY <> :old.HD_DLT_NGAY  AND :old.HD_DLT_NGAY IS NOT NULL AND :new.HD_DLT_NGAY IS NOT NULL) OR
                 (:old.HD_DLT_NGAY IS NOT NULL AND :new.HD_DLT_NGAY IS NULL) OR
                 (:old.HD_DLT_NGAY IS NULL AND :new.HD_DLT_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_TK','HD_DLT_NGAY',:new.HD_DLT_NGAY,:old.HD_DLT_NGAY);
   END IF;
 End If;
END;
/


-- End of DDL Script for Table TEST.TB_TK

-- Start of DDL Script for Table TEST.TB_TK_SDDPNN
-- Generated 3-Oct-2013 16:32:41 from TEST@DCNC

CREATE TABLE tb_tk_sddpnn
    (ma_cqt_par                     VARCHAR2(5 CHAR) ,
    ma_cqt                         VARCHAR2(5 CHAR) ,
    kytt_tu_ngay                   VARCHAR2(15 BYTE),
    kytt_den_ngay                  VARCHAR2(15 BYTE),
    ngay_htoan                     VARCHAR2(15 BYTE),
    ma_tkhai                       VARCHAR2(22 CHAR) ,
    ltd                            NUMBER(*,0) ,
    ma_loai_tk                     VARCHAR2(2 CHAR),
    landau                         NUMBER(*,0),
    bs_lan_thu                     NUMBER(4,0),
    vang_chu                       NUMBER(*,0),
    chuyen_nhuong                  NUMBER(*,0),
    ngay_nop_tk                    VARCHAR2(15 BYTE),
    trang_thai_tk                  VARCHAR2(2 CHAR),
    trang_thai_cm                  VARCHAR2(2 CHAR),
    ma_tkhai_off                   VARCHAR2(22 CHAR),
    ma_tmuc                        VARCHAR2(4 CHAR),
    nnt_tin                        VARCHAR2(14 CHAR),
    nnt_ten_nnt                    VARCHAR2(300 CHAR),
    nnt_ngcap_mst                  VARCHAR2(15 BYTE),
    nnt_cap                        VARCHAR2(1 CHAR),
    nnt_chuong                     VARCHAR2(3 CHAR),
    nnt_loai                       VARCHAR2(3 CHAR),
    nnt_khoan                      VARCHAR2(3 CHAR),
    nnt_ngay_sinh                  VARCHAR2(15 BYTE),
    nnt_dia_chi                    VARCHAR2(300 CHAR),
    nnt_ma_tinh                    VARCHAR2(3 CHAR),
    nnt_ma_huyen                   VARCHAR2(5 CHAR),
    nnt_ma_xa                      VARCHAR2(7 CHAR),
    nnt_ma_thon                    VARCHAR2(9 CHAR),
    nnt_ten_thon                   VARCHAR2(100 CHAR),
    nnt_cmnd                       VARCHAR2(300 CHAR),
    nnt_cmnd_ngay_cap              VARCHAR2(15 BYTE),
    nnt_cmnd_noi_cap               VARCHAR2(100 CHAR),
    nnt_so_dt                      VARCHAR2(20 CHAR),
    nnt_so_tk                      VARCHAR2(30 CHAR),
    nnt_ngan_hang                  VARCHAR2(100 CHAR),
    nnt_nnkt_ctiet                 VARCHAR2(5 CHAR),
    thd_dia_chi                    VARCHAR2(300 CHAR),
    thd_ma_tinh                    VARCHAR2(3 CHAR),
    thd_ma_huyen                   VARCHAR2(5 CHAR),
    thd_ma_xa                      VARCHAR2(7 CHAR),
    thd_ma_thon                    VARCHAR2(9 CHAR),
    thd_gcn                        NUMBER(*,0),
    thd_gcn_so                     VARCHAR2(20 CHAR),
    thd_gcn_ngay_cap               VARCHAR2(15 BYTE),
    thd_thua_dat_so                VARCHAR2(20 CHAR),
    thd_ban_do_so                  VARCHAR2(50 CHAR),
    thd_gcn_dien_tich              NUMBER(16,2),
    thd_dtich_sd_tte               NUMBER(19,5),
    thd_gcn_ma_md                  VARCHAR2(3 CHAR),
    thd_han_muc                    NUMBER(16,2),
    thd_chua_gcn                   NUMBER(*,0),
    thd_chua_gcn_dtich             NUMBER(19,5),
    thd_chua_gcn_ma_md             VARCHAR2(3 CHAR),
    mgi_ma_ly_do                   VARCHAR2(5 CHAR),
    mgi_ghi_chu                    VARCHAR2(100 CHAR),
    mgi_so_tien                    NUMBER(16,2),
    cct_dtich_sd_tte               NUMBER(19,5),
    cct_han_muc                    NUMBER(16,2),
    cct_ma_loai_dat                VARCHAR2(6 CHAR),
    cct_ma_duong                   VARCHAR2(8 CHAR),
    cct_ma_doan_duong              VARCHAR2(11 CHAR),
    cct_ma_loai_duong              VARCHAR2(6 CHAR),
    cct_ma_vi_tri                  VARCHAR2(8 CHAR),
    cct_he_so                      NUMBER(16,7),
    cct_ma_gia_dat                 VARCHAR2(10 CHAR),
    cct_gia_dat                    NUMBER(16,2),
    cct_gia_1m2_dat                NUMBER(16,2),
    cct_co_bke                     NUMBER(*,0),
    dato_dtich_trong_hm            NUMBER(19,5),
    dato_dtich_duoi3               NUMBER(19,5),
    dato_dtich_vuot3               NUMBER(19,5),
    dato_stpn                      NUMBER(16,2),
    ccu_dtich                      NUMBER(19,5),
    ccu_stpn                       NUMBER(16,2),
    skd_dtich                      NUMBER(19,5),
    skd_stpn                       NUMBER(16,2),
    smd_dtich                      NUMBER(19,5),
    smd_ma_md                      VARCHAR2(3 CHAR),
    smd_gia_1m2_dat                NUMBER(16,2),
    smd_stpn                       NUMBER(16,2),
    lch_dtich                      NUMBER(19,5),
    lch_ma_md                      VARCHAR2(3 CHAR),
    lch_gia_1m2_dat                NUMBER(16,2),
    lch_stpn                       NUMBER(16,2),
    stpn_truoc_mgi                 NUMBER(16,2),
    stpn_tong                      NUMBER(16,2),
    stpn_clech_bsung               NUMBER(16,2),
    dkn_nop_5nam                   NUMBER(*,0),
    dkn_so_tien                    NUMBER(16,2),
    ttk_dato_stpn                  NUMBER(16,2),
    ttk_ccu_stpn                   NUMBER(16,2),
    ttk_skd_stpn                   NUMBER(16,2),
    ttk_smd_stpn                   NUMBER(16,2),
    ttk_lch_stpn                   NUMBER(16,2),
    dlt_tin                        VARCHAR2(14 CHAR),
    dlt_ten_dlt                    VARCHAR2(300 CHAR),
    dlt_dia_chi                    VARCHAR2(100 CHAR),
    dlt_ma_tinh                    VARCHAR2(3 CHAR),
    dlt_ma_huyen                   VARCHAR2(5 CHAR),
    dlt_ma_xa                      VARCHAR2(7 CHAR),
    dlt_ma_thon                    VARCHAR2(9 CHAR),
    dlt_so_dt                      VARCHAR2(20 CHAR),
    dlt_fax                        VARCHAR2(20 CHAR),
    dlt_email                      VARCHAR2(70 CHAR),
    dlt_so_hdong                   VARCHAR2(20 CHAR),
    dlt_ngay_hdong                 VARCHAR2(15 BYTE),
    mgi_ty_le                      NUMBER(16,7),
    ccu_he_so                      NUMBER(16,7),
    sthue_pnop                     NUMBER(16,2),
    han_nop                        VARCHAR2(18 BYTE),
    thd_gcn_ten_md                 VARCHAR2(100 BYTE),
    mgi_ten_ly_do                  VARCHAR2(200 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    ky_kkhai_tu_ngay               VARCHAR2(15 BYTE),
    ky_kkhai_den_ngay              VARCHAR2(15 BYTE),
    cct_ma_loai_dat_tms            VARCHAR2(6 BYTE),
    cct_ma_loai_duong_tms          VARCHAR2(6 BYTE),
    status                         CHAR(1 BYTE),
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
/


-- Indexes for TB_TK_SDDPNN

CREATE INDEX idx_ma_cqt ON tb_tk_sddpnn
  (
    ma_cqt                          ASC
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

CREATE INDEX tb_tk_sddpnn_ma_loai_tk_idx ON tb_tk_sddpnn
  (
    ma_loai_tk                      ASC
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

CREATE INDEX tb_tk_sddpnn_join_dd_idx ON tb_tk_sddpnn
  (
    cct_ma_doan_duong               ASC,
    cct_ma_duong                    ASC,
    thd_ma_huyen                    ASC
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

CREATE INDEX tb_tk_sddpnn_join_ld_idx ON tb_tk_sddpnn
  (
    cct_ma_loai_duong               ASC,
    thd_ma_tinh                     ASC
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

CREATE INDEX tb_tk_sddpnn_md_sai_idx ON tb_tk_sddpnn
  (
    smd_ma_md                       ASC
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

CREATE INDEX tb_tk_sddpnn_huyentd_idx ON tb_tk_sddpnn
  (
    thd_ma_huyen                    ASC
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

CREATE INDEX tb_tk_sddpnn_tin_idx ON tb_tk_sddpnn
  (
    nnt_tin                         ASC
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

CREATE INDEX tb_tk_sddpnn_md_lc_idx ON tb_tk_sddpnn
  (
    lch_ma_md                       ASC
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

CREATE INDEX tb_tk_sddpnn_tindlt_idx ON tb_tk_sddpnn
  (
    dlt_tin                         ASC
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

CREATE INDEX tb_tk_sddpnn_tinhdlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_tinh                     ASC
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

CREATE INDEX tb_tk_sddpnn_ma_duong_idx ON tb_tk_sddpnn
  (
    cct_ma_duong                    ASC,
    thd_ma_huyen                    ASC
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

CREATE INDEX tb_tk_sddpnn_ma_vtri_idx ON tb_tk_sddpnn
  (
    cct_ma_vi_tri                   ASC,
    thd_ma_tinh                     ASC
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

CREATE INDEX tb_tk_sddpnn_huyendlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_huyen                    ASC
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

CREATE INDEX tb_tk_sddpnn_xa_dlt_idx ON tb_tk_sddpnn
  (
    dlt_ma_xa                       ASC
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

CREATE INDEX tb_tk_sddpnn_thondlt ON tb_tk_sddpnn
  (
    dlt_ma_thon                     ASC
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

CREATE INDEX tb_tk_sddpnn_loaidat_idx ON tb_tk_sddpnn
  (
    cct_ma_loai_dat                 ASC,
    thd_ma_tinh                     ASC
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

CREATE INDEX tb_tk_sddpnn_tinhtd_idx ON tb_tk_sddpnn
  (
    thd_ma_tinh                     ASC
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

CREATE INDEX tb_tk_sddpnn_ak_idx ON tb_tk_sddpnn
  (
    ma_cqt                          ASC,
    ma_tkhai                        ASC,
    ltd                             ASC,
    ma_cqt_par                      ASC
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

CREATE INDEX tb_tk_sddpnn_xa_td_idx ON tb_tk_sddpnn
  (
    thd_ma_xa                       ASC
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

CREATE INDEX tb_tk_sddpnn_thon_td_idx ON tb_tk_sddpnn
  (
    thd_ma_thon                     ASC
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

CREATE INDEX tb_tk_sddpnn_md_idx ON tb_tk_sddpnn
  (
    thd_gcn_ma_md                   ASC
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

CREATE INDEX tb_tk_sddpnn_mg_idx ON tb_tk_sddpnn
  (
    mgi_ma_ly_do                    ASC
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



-- Constraints for TB_TK_SDDPNN

ALTER TABLE tb_tk_sddpnn
ADD CONSTRAINT tb_tk_sddpnn_pk PRIMARY KEY (ma_tkhai, ma_cqt, ltd, ma_cqt_par)
/

ALTER TABLE tb_tk_sddpnn
ADD CONSTRAINT tb_tk_sddpnn_uk UNIQUE (ma_tkhai, ma_cqt, ltd, bs_lan_thu, 
  ma_cqt_par)
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
/


-- End of DDL Script for Table TEST.TB_TK_SDDPNN

-- Start of DDL Script for Table TEST.TB_TK_SDDPNN_01_NNT
-- Generated 3-Oct-2013 16:32:42 from TEST@DCNC

CREATE TABLE tb_tk_sddpnn_01_nnt
    (ma_cqt_par                     VARCHAR2(5 CHAR) ,
    ma_cqt                         VARCHAR2(5 CHAR) ,
    ky_tthue                       VARCHAR2(15 BYTE),
    ma_tkhai                       VARCHAR2(22 CHAR) ,
    ltd                            NUMBER(*,0) ,
    trang_thai_cm                  VARCHAR2(2 CHAR),
    ma_mo_rong                     VARCHAR2(3 CHAR),
    so_hieu_tep                    VARCHAR2(200 CHAR),
    loai_dky                       NUMBER(*,0),
    ngay_nop                       VARCHAR2(15 BYTE),
    nnt_tin                        VARCHAR2(14 CHAR),
    nnt_ten_nnt                    VARCHAR2(300 CHAR),
    nnt_ngay_sinh                  VARCHAR2(15 BYTE),
    nnt_dia_chi                    VARCHAR2(300 CHAR),
    nnt_ma_tinh                    VARCHAR2(3 CHAR),
    nnt_ma_huyen                   VARCHAR2(5 CHAR),
    nnt_ma_xa                      VARCHAR2(7 CHAR),
    nnt_ma_thon                    VARCHAR2(9 CHAR),
    nnt_ten_thon                   VARCHAR2(100 CHAR),
    nnt_cmnd                       VARCHAR2(300 CHAR),
    nnt_cmnd_ngay_cap              VARCHAR2(15 BYTE),
    nnt_cmnd_noi_cap               VARCHAR2(100 CHAR),
    nnt_quoc_tich                  VARCHAR2(2 CHAR),
    nnt_so_dt                      VARCHAR2(20 CHAR),
    nnt_so_tk                      VARCHAR2(30 CHAR),
    nnt_ngan_hang                  VARCHAR2(100 CHAR),
    dlt_tin                        VARCHAR2(14 CHAR),
    dlt_ten_dlt                    VARCHAR2(300 CHAR),
    dlt_dia_chi                    VARCHAR2(100 CHAR),
    dlt_ma_tinh                    VARCHAR2(3 CHAR),
    dlt_ma_huyen                   VARCHAR2(5 CHAR),
    dlt_ma_xa                      VARCHAR2(7 CHAR),
    dlt_ma_thon                    VARCHAR2(9 CHAR),
    dlt_so_dt                      VARCHAR2(20 CHAR),
    dlt_fax                        VARCHAR2(20 CHAR),
    dlt_email                      VARCHAR2(70 CHAR),
    dlt_so_hdong                   VARCHAR2(20 CHAR),
    dlt_ngay_hdong                 VARCHAR2(15 BYTE),
    thd_dia_chi                    VARCHAR2(300 CHAR),
    thd_ma_tinh                    VARCHAR2(3 CHAR),
    thd_ma_huyen                   VARCHAR2(5 CHAR),
    thd_ma_xa                      VARCHAR2(7 CHAR),
    thd_ma_thon                    VARCHAR2(9 CHAR),
    thd_duy_nhat                   NUMBER(*,0),
    thd_ma_huyen_kkth              VARCHAR2(5 CHAR),
    thd_gcn                        NUMBER(*,0),
    thd_gcn_so                     VARCHAR2(20 CHAR),
    thd_gcn_ngay_cap               VARCHAR2(15 BYTE),
    thd_thua_dat_so                VARCHAR2(20 CHAR),
    thd_ban_do_so                  VARCHAR2(50 CHAR),
    thd_gcn_dien_tich              NUMBER(16,2),
    thd_gcn_ma_md                  VARCHAR2(3 BYTE),
    thd_tong_dtich_tte             NUMBER(19,5),
    thd_dtich_dung_md              NUMBER(19,5),
    thd_dtich_sai_md               NUMBER(19,5),
    thd_han_muc                    NUMBER(16,2),
    thd_dtich_lan_chiem            NUMBER(19,5),
    thd_chua_gcn                   NUMBER(*,0),
    thd_chua_gcn_dtich             NUMBER(19,5),
    thd_chua_gcn_ma_md             VARCHAR2(3 CHAR),
    ccu_loai_nha                   VARCHAR2(100 CHAR),
    ccu_dtich                      NUMBER(19,5),
    ccu_heso                       NUMBER(16,7),
    mgi_ma_ly_do                   VARCHAR2(5 CHAR),
    mgi_ghi_chu                    VARCHAR2(100 CHAR),
    dkn_dknt                       NUMBER(*,0),
    dkn_sonam                      NUMBER(4,0),
    thd_gcn_ten_md                 VARCHAR2(200 BYTE),
    thd_chua_gcn_ten_md            VARCHAR2(200 BYTE),
    mgi_ten_ly_do                  VARCHAR2(200 BYTE),
    short_name                     VARCHAR2(7 BYTE))
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


-- Indexes for TB_TK_SDDPNN_01_NNT

CREATE INDEX tb_tkhai_sddpnn_ma_thon_idx ON tb_tk_sddpnn_01_nnt
  (
    nnt_ma_thon                     ASC
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

CREATE INDEX tb_tkhai_sddpnn_ma_tinh_td_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_ma_tinh                     ASC
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

CREATE INDEX tb_tkhai_ma_huyen_td_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_ma_huyen                    ASC
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

CREATE INDEX tb_tkhai_sddpnn_ma_xa_td_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_ma_xa                       ASC
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

CREATE INDEX tb_tkhai_huyen_dkkk_th_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_ma_huyen_kkth               ASC
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

CREATE INDEX tb_tkhai_sddpnn_ma_md_idx ON tb_tk_sddpnn_01_nnt
  (
    thd_gcn_ma_md                   ASC
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



-- Constraints for TB_TK_SDDPNN_01_NNT

ALTER TABLE tb_tk_sddpnn_01_nnt
ADD CONSTRAINT tb_tkhai_sddpnn$pk PRIMARY KEY (ma_tkhai, ma_cqt, ltd, ma_cqt_par)
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
/



-- End of DDL Script for Table TEST.TB_TK_SDDPNN_01_NNT

-- Start of DDL Script for Table TEST.TB_TKMB_DTL
-- Generated 3-Oct-2013 16:32:42 from TEST@DCNC

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
    mst_dvtt                       VARCHAR2(100 BYTE),
    bmb_nnt_tms                    VARCHAR2(10 BYTE),
    bmb_cqt_tms                    VARCHAR2(10 BYTE))
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


-- Indexes for TB_TKMB_DTL

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
/



-- Constraints for TB_TKMB_DTL

ALTER TABLE tb_tkmb_dtl
ADD CONSTRAINT pk_tb_tkmb_dtl_id PRIMARY KEY (id)
/



-- End of DDL Script for Table TEST.TB_TKMB_DTL

-- Start of DDL Script for Table TEST.TB_TKMB_HDR
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

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
    tm_1806                        NUMBER(20,0),
    bmb_nnt_tms                    VARCHAR2(10 BYTE),
    bmb_cqt_tms                    VARCHAR2(10 BYTE))
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


-- Indexes for TB_TKMB_HDR

CREATE INDEX ind_tkmb_tin ON tb_tkmb_hdr
  (
    tin                             ASC
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

CREATE INDEX ind_tkmb_tax_model ON tb_tkmb_hdr
  (
    tax_model                       ASC
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

CREATE INDEX ind_tkmb_short_name ON tb_tkmb_hdr
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
/

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
/



-- Constraints for TB_TKMB_HDR

ALTER TABLE tb_tkmb_hdr
ADD CONSTRAINT pk_tb_tkmb_hdr_id PRIMARY KEY (id)
/


-- Triggers for TB_TKMB_HDR

CREATE OR REPLACE TRIGGER trg_tkmb_bi
 BEFORE
  INSERT
 ON tb_tkmb_hdr
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    CURSOR c1 (p_bmb VARCHAR2, p_tax_model VARCHAR2) IS
        SELECT bmb_tms FROM tb_dmuc_bac_mbai
            WHERE trim(ma) = p_bmb and tax_model = p_tax_model;
BEGIN    
    OPEN c1 (trim(:NEW.bmb_nnt), :NEW.tax_model);
    LOOP
        FETCH c1 into :NEW.bmb_nnt_tms;
        EXIT WHEN c1%notfound;
    END LOOP;
    CLOSE c1;                        

    OPEN c1 (trim(:NEW.bmb_cqt), :NEW.tax_model);
    LOOP
        FETCH c1 into :NEW.bmb_cqt_tms;
        EXIT WHEN c1%notfound;
    END LOOP;
    CLOSE c1;            
END;
/


-- End of DDL Script for Table TEST.TB_TKMB_HDR

-- Start of DDL Script for Table TEST.TB_UNSPLIT_DATA_ERROR
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_unsplit_data_error
    (short_name                     VARCHAR2(7 BYTE),
    rid                            VARCHAR2(25 BYTE),
    table_name                     VARCHAR2(30 BYTE),
    err_string                     VARCHAR2(1000 BYTE))
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


-- Indexes for TB_UNSPLIT_DATA_ERROR

CREATE INDEX ind_unlit_shn ON tb_unsplit_data_error
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
/

CREATE INDEX ind_unlit_tba ON tb_unsplit_data_error
  (
    table_name                      ASC
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



-- End of DDL Script for Table TEST.TB_UNSPLIT_DATA_ERROR

-- Start of DDL Script for Table TEST.TB_VAT_CON_KT_02
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_vat_con_kt_02
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    ma_tmuc                        VARCHAR2(4 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_tkhai_tms                   VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    err_id                         VARCHAR2(1 BYTE),
    err_des                        VARCHAR2(200 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


-- Constraints for TB_VAT_CON_KT_02

ALTER TABLE tb_vat_con_kt_02
ADD CONSTRAINT pk_vat_con_kt_02_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  users
  STORAGE   (
    INITIAL     458752
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Triggers for TB_VAT_CON_KT_02

CREATE OR REPLACE TRIGGER trg_vat_con_kt_02_b
 BEFORE
  INSERT
 ON tb_vat_con_kt_02
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_VAT_CON_KT_02

-- Start of DDL Script for Table TEST.TB_VAT_DKNTK
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_vat_dkntk
    (tin                            VARCHAR2(14 BYTE),
    ky_bat_dau                     VARCHAR2(10 BYTE),
    ky_ket_thuc                    VARCHAR2(10 BYTE),
    ma_tkhai                       VARCHAR2(20 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    khong_chuyen                   VARCHAR2(1 BYTE))
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


-- End of DDL Script for Table TEST.TB_VAT_DKNTK

-- Start of DDL Script for Table TEST.TB_VAT_DMUC_TKHAI
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_vat_dmuc_tkhai
    (id                             NUMBER(10,0),
    ten_tkhai                      VARCHAR2(100 BYTE),
    ma_tkhai_vatw                  VARCHAR2(20 BYTE),
    ma_tkhai_tms                   VARCHAR2(20 BYTE),
    tkhai_qtoan                    VARCHAR2(1 BYTE),
    loai_ky                        VARCHAR2(2 BYTE),
    ma_qtoan                       VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TB_VAT_DMUC_TKHAI

-- Start of DDL Script for Table TEST.TB_VAT_DTNT
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_vat_dtnt
    (madtnt                         VARCHAR2(20 BYTE),
    mabpql                         VARCHAR2(12 BYTE),
    macaptren                      VARCHAR2(12 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tenbophanquanly                VARCHAR2(120 BYTE),
    tencaptrenquanly               VARCHAR2(120 BYTE),
    tendtnt                        VARCHAR2(150 BYTE))
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


-- End of DDL Script for Table TEST.TB_VAT_DTNT

-- Start of DDL Script for Table TEST.TB_VAT_QTN_SO_NO
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tb_vat_qtn_so_no
    (id                             NUMBER(20,0) NOT NULL,
    tkhoan                         VARCHAR2(30 BYTE) NOT NULL,
    dtc_ma                         VARCHAR2(2 BYTE) NOT NULL,
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    tin                            VARCHAR2(14 BYTE) NOT NULL,
    tmt_ma_tmuc                    VARCHAR2(4 BYTE) NOT NULL,
    no_cuoi_ky                     NUMBER(20,0),
    han_nop                        VARCHAR2(10 BYTE),
    short_name                     VARCHAR2(7 BYTE) NOT NULL)
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


-- Triggers for TB_VAT_QTN_SO_NO

CREATE OR REPLACE TRIGGER trg_vat_qtn_so_no_b
 BEFORE
  INSERT
 ON tb_vat_qtn_so_no
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID FROM dual;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TB_VAT_QTN_SO_NO

-- Start of DDL Script for Table TEST.TEST
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE test
    (ma_tkhai                       VARCHAR2(20 BYTE))
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


-- End of DDL Script for Table TEST.TEST

-- Start of DDL Script for Table TEST.TEST_QTN
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE test_qtn
    (ma_loai                        VARCHAR2(4 BYTE) NOT NULL,
    ma_khoan                       VARCHAR2(4 BYTE) NOT NULL,
    ten                            VARCHAR2(200 BYTE) NOT NULL,
    ngay_bat_dau                   DATE,
    ngay_ket_thuc                  DATE)
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


-- End of DDL Script for Table TEST.TEST_QTN

-- Start of DDL Script for Table TEST.TMS_CDOI_STATUS
-- Generated 3-Oct-2013 16:32:43 from TEST@DCNC

CREATE TABLE tms_cdoi_status
    (id                             NUMBER(10,0) ,
    data_type                      VARCHAR2(100 BYTE),
    step                           VARCHAR2(100 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    staus                          VARCHAR2(1 BYTE))
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


-- Indexes for TMS_CDOI_STATUS

CREATE INDEX ind_cdoi_status_id ON tms_cdoi_status
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



-- Constraints for TMS_CDOI_STATUS

ALTER TABLE tms_cdoi_status
ADD CONSTRAINT pk_tms_cdoi_status_id PRIMARY KEY (id)
/


-- Triggers for TMS_CDOI_STATUS

CREATE OR REPLACE TRIGGER trg_tms_cdoi_status_id
 BEFORE
  INSERT
 ON tms_cdoi_status
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :new.id IS NULL
    THEN
        SELECT   seq_id_tables.NEXTVAL INTO :new.id FROM DUAL;
    END IF;
END;
/


-- End of DDL Script for Table TEST.TMS_CDOI_STATUS

-- Foreign Key
ALTER TABLE tb_columns
ADD CONSTRAINT fk_ztb_columns_id FOREIGN KEY (tbl_id)
REFERENCES tb_tables (id)
/
-- Foreign Key
ALTER TABLE tb_tk_sddpnn_01_nnt
ADD CONSTRAINT ttb_tkhai_sddpnn$cctt_fk FOREIGN KEY (ma_tkhai, ma_cqt, ltd, 
  ma_cqt_par)
REFERENCES tb_tk_sddpnn (ma_tkhai,ma_cqt,ltd,ma_cqt_par) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE tb_tkmb_dtl
ADD CONSTRAINT fk_tb_tkmb_dtl_hdr_id FOREIGN KEY (hdr_id)
REFERENCES tb_tkmb_hdr (id)
/
-- End of DDL script for Foreign Key(s)
