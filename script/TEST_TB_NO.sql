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
    ma_tkhai                       VARCHAR2(22 BYTE))
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
;

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
;

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
;


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
;

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
;

CREATE OR REPLACE TRIGGER trg_au_tb_no
 AFTER
  UPDATE
 ON tb_no
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
   IF (:new.ma_chuong <> :old.ma_chuong  AND :old.ma_chuong IS NOT NULL AND :new.ma_chuong IS NOT NULL) OR
                 (:old.ma_chuong IS NOT NULL AND :new.ma_chuong IS NULL) OR
                 (:old.ma_chuong IS NULL AND :new.ma_chuong IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','MA_CHUONG',:new.ma_chuong,:old.ma_chuong);
   END IF;
   IF (:new.ma_khoan <> :old.ma_khoan  AND :old.ma_khoan IS NOT NULL AND :new.ma_khoan IS NOT NULL) OR
                 (:old.ma_khoan IS NOT NULL AND :new.ma_khoan IS NULL) OR
                 (:old.ma_khoan IS NULL AND :new.ma_khoan IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','MA_KHOAN',:new.ma_khoan,:old.ma_khoan);
   END IF;
   IF (:new.TMT_MA_TMUC <> :old.TMT_MA_TMUC  AND :old.TMT_MA_TMUC IS NOT NULL AND :new.TMT_MA_TMUC IS NOT NULL) OR
                 (:old.TMT_MA_TMUC IS NOT NULL AND :new.TMT_MA_TMUC IS NULL) OR
                 (:old.TMT_MA_TMUC IS NULL AND :new.TMT_MA_TMUC IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','TMT_MA_TMUC',:new.TMT_MA_TMUC,:old.TMT_MA_TMUC);
   END IF;
   IF (:new.TKHOAN <> :old.TKHOAN  AND :old.TKHOAN IS NOT NULL AND :new.TKHOAN IS NOT NULL) OR
                 (:old.TKHOAN IS NOT NULL AND :new.TKHOAN IS NULL) OR
                 (:old.TKHOAN IS NULL AND :new.TKHOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','TKHOAN',:new.TKHOAN,:old.TKHOAN);
   END IF;
   IF (:new.NGAY_HTOAN <> :old.NGAY_HTOAN  AND :old.NGAY_HTOAN IS NOT NULL AND :new.NGAY_HTOAN IS NOT NULL) OR
                 (:old.NGAY_HTOAN IS NOT NULL AND :new.NGAY_HTOAN IS NULL) OR
                 (:old.NGAY_HTOAN IS NULL AND :new.NGAY_HTOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','NGAY_HTOAN',:new.NGAY_HTOAN,:old.NGAY_HTOAN);
   END IF;
   IF (:new.KYKK_TU_NGAY <> :old.KYKK_TU_NGAY  AND :old.KYKK_TU_NGAY IS NOT NULL AND :new.KYKK_TU_NGAY IS NOT NULL) OR
                 (:old.KYKK_TU_NGAY IS NOT NULL AND :new.KYKK_TU_NGAY IS NULL) OR
                 (:old.KYKK_TU_NGAY IS NULL AND :new.KYKK_TU_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','KYKK_TU_NGAY',:new.KYKK_TU_NGAY,:old.KYKK_TU_NGAY);
   END IF;
   IF (:new.KYKK_DEN_NGAY <> :old.KYKK_DEN_NGAY  AND :old.KYKK_DEN_NGAY IS NOT NULL AND :new.KYKK_DEN_NGAY IS NOT NULL) OR
                 (:old.KYKK_DEN_NGAY IS NOT NULL AND :new.KYKK_DEN_NGAY IS NULL) OR
                 (:old.KYKK_DEN_NGAY IS NULL AND :new.KYKK_DEN_NGAY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','KYKK_DEN_NGAY',:new.KYKK_DEN_NGAY,:old.KYKK_DEN_NGAY);
   END IF;
   IF (:new.HAN_NOP <> :old.HAN_NOP  AND :old.HAN_NOP IS NOT NULL AND :new.HAN_NOP IS NOT NULL) OR
                 (:old.HAN_NOP IS NOT NULL AND :new.HAN_NOP IS NULL) OR
                 (:old.HAN_NOP IS NULL AND :new.HAN_NOP IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','HAN_NOP',:new.HAN_NOP,:old.HAN_NOP);
   END IF;

END;
;

