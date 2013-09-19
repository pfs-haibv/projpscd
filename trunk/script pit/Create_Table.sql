-- Start of DDL Script for Table TKTQ.QUEST_SL_TEMP_EXPLAIN1
-- Generated 5-Jan-2013 10:42:32 from TKTQ@DPPIT_199

/*CREATE GLOBAL TEMPORARY TABLE quest_sl_temp_explain1
    (statement_id                   VARCHAR2(30 BYTE),
    plan_id                        NUMBER,
    timestamp                      DATE,
    remarks                        VARCHAR2(80 BYTE),
    operation                      VARCHAR2(30 BYTE),
    options                        VARCHAR2(255 BYTE),
    object_node                    VARCHAR2(128 BYTE),
    object_owner                   VARCHAR2(30 BYTE),
    object_name                    VARCHAR2(30 BYTE),
    object_alias                   VARCHAR2(65 BYTE),
    object_instance                NUMBER,
    object_type                    VARCHAR2(30 BYTE),
    optimizer                      VARCHAR2(255 BYTE),
    search_columns                 NUMBER,
    id                             NUMBER,
    parent_id                      NUMBER,
    depth                          NUMBER,
    position                       NUMBER,
    cost                           NUMBER,
    cardinality                    NUMBER,
    bytes                          NUMBER,
    other_tag                      VARCHAR2(255 BYTE),
    partition_start                VARCHAR2(255 BYTE),
    partition_stop                 VARCHAR2(255 BYTE),
    partition_id                   NUMBER,
    other                          LONG,
    distribution                   VARCHAR2(30 BYTE),
    cpu_cost                       NUMBER(38,0),
    io_cost                        NUMBER(38,0),
    temp_space                     NUMBER(38,0),
    access_predicates              VARCHAR2(4000 BYTE),
    filter_predicates              VARCHAR2(4000 BYTE))
ON COMMIT PRESERVE ROWS
  NOPARALLEL
  NOLOGGING
;





-- End of DDL Script for Table TKTQ.QUEST_SL_TEMP_EXPLAIN1

-- Start of DDL Script for Table TKTQ.RUN_STATS
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE GLOBAL TEMPORARY TABLE run_stats
    (runid                          VARCHAR2(15 BYTE),
    name                           VARCHAR2(80 BYTE),
    value                          NUMBER(*,0))
ON COMMIT PRESERVE ROWS
  NOPARALLEL
  NOLOGGING
;



*/

-- End of DDL Script for Table TKTQ.RUN_STATS

-- Start of DDL Script for Table TKTQ.SQLN_EXPLAIN_PLAN
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE sqln_explain_plan
    (statement_id                   VARCHAR2(30 BYTE),
    timestamp                      DATE,
    remarks                        VARCHAR2(80 BYTE),
    operation                      VARCHAR2(30 BYTE),
    options                        VARCHAR2(30 BYTE),
    object_node                    VARCHAR2(128 BYTE),
    object_owner                   VARCHAR2(30 BYTE),
    object_name                    VARCHAR2(30 BYTE),
    object_instance                NUMBER(*,0),
    object_type                    VARCHAR2(30 BYTE),
    optimizer                      VARCHAR2(255 BYTE),
    search_columns                 NUMBER(*,0),
    id                             NUMBER(*,0),
    parent_id                      NUMBER(*,0),
    position                       NUMBER(*,0),
    cost                           NUMBER(*,0),
    cardinality                    NUMBER(*,0),
    bytes                          NUMBER(*,0),
    other_tag                      VARCHAR2(255 BYTE),
    partition_start                VARCHAR2(255 BYTE),
    partition_stop                 VARCHAR2(255 BYTE),
    partition_id                   NUMBER(*,0),
    other                          LONG,
    distribution                   VARCHAR2(30 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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

-- Grants for Table
GRANT DELETE ON sqln_explain_plan TO public
;
GRANT INSERT ON sqln_explain_plan TO public
;
GRANT SELECT ON sqln_explain_plan TO public
;
GRANT UPDATE ON sqln_explain_plan TO public
;




-- End of DDL Script for Table TKTQ.SQLN_EXPLAIN_PLAN

-- Start of DDL Script for Table TKTQ.TB_01_PARA
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- Constraints for TB_01_PARA

ALTER TABLE tb_01_para
ADD CONSTRAINT pk_para PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_01_PARA

-- Start of DDL Script for Table TKTQ.TB_CHK_LST
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_chk_lst
    (short_name                     VARCHAR2(3 BYTE) NOT NULL,
    step                           VARCHAR2(30 BYTE),
    status                         VARCHAR2(1 BYTE),
    stt                            NUMBER,
    note                           VARCHAR2(50 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_CHK_LST

-- Start of DDL Script for Table TKTQ.TB_CTU
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_ctu
    (file_name                      CHAR(100 BYTE),
    tran_no                        VARCHAR2(60 BYTE),
    total                          NUMBER,
    comp_code                      VARCHAR2(12 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_CTU

-- Start of DDL Script for Table TKTQ.TB_DATA_ERROR
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_data_error
    (short_name                     VARCHAR2(7 BYTE),
    rid                            VARCHAR2(25 BYTE),
    table_name                     VARCHAR2(30 BYTE),
    err_id                         VARCHAR2(3 BYTE),
    field_name                     VARCHAR2(25 BYTE),
    update_no                      NUMBER(3,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
;





-- Indexes for TB_DATA_ERROR

CREATE INDEX ind_der_short ON tb_data_error
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_der_rid ON tb_data_error
  (
    rid                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     3145728
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_der_tname ON tb_data_error
  (
    table_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_der_eid ON tb_data_error
  (
    err_id                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_DATA_ERROR

-- Start of DDL Script for Table TKTQ.TB_DCONVERT_OVER
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_dconvert_over
    (short_name                     VARCHAR2(7 BYTE),
    loai                           VARCHAR2(20 BYTE),
    ma_gdich                       VARCHAR2(10 BYTE),
    ten_gdich                      VARCHAR2(150 BYTE),
    so_luong                       NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_DCONVERT_OVER

-- Start of DDL Script for Table TKTQ.TB_DPPIT
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_dppit
    (ma_cqt                         VARCHAR2(12 BYTE) NOT NULL,
    persl                          CHAR(4 BYTE),
    total                          NUMBER,
    he_thong                       CHAR(6 BYTE),
    mst                            VARCHAR2(14 BYTE) NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_DPPIT

-- Start of DDL Script for Table TKTQ.TB_DTNT
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_dtnt
    (madtnt                         VARCHAR2(20 BYTE),
    mabpql                         VARCHAR2(12 BYTE),
    macaptren                      VARCHAR2(12 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tencaptrenquanly               VARCHAR2(120 BYTE),
    tenbophanquanly                VARCHAR2(120 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_DTNT

CREATE INDEX dtnt_tin ON tb_dtnt
  (
    madtnt                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_DTNT

-- Start of DDL Script for Table TKTQ.TB_DTNT_BK01
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_dtnt_bk01
    (madtnt                         VARCHAR2(20 BYTE),
    mabpql                         VARCHAR2(12 BYTE),
    macaptren                      VARCHAR2(12 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tencaptrenquanly               VARCHAR2(120 BYTE),
    tenbophanquanly                VARCHAR2(120 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_DTNT_BK01

-- Start of DDL Script for Table TKTQ.TB_DTNTBK02
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_dtntbk02
    (madtnt                         VARCHAR2(20 BYTE),
    mabpql                         VARCHAR2(12 BYTE),
    macaptren                      VARCHAR2(12 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    tencaptrenquanly               VARCHAR2(120 BYTE),
    tenbophanquanly                VARCHAR2(120 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_DTNTBK02

-- Start of DDL Script for Table TKTQ.TB_ERRORS
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- Constraints for TB_ERRORS

ALTER TABLE tb_errors
ADD CONSTRAINT tb_qlt_pk_errors PRIMARY KEY (seq_number)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_ERRORS

-- Start of DDL Script for Table TKTQ.TB_EXCEL
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_excel
    (id_hdr                         NUMBER(10,0) NOT NULL,
    id_dtl                         NUMBER(10,0) NOT NULL,
    col_text                       VARCHAR2(1000 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Constraints for TB_EXCEL

ALTER TABLE tb_excel
ADD CONSTRAINT pk_excel PRIMARY KEY (id_dtl)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_EXCEL

-- Start of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_HTOAN
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- End of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_HTOAN

-- Start of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_NO
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- End of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_NO

-- Start of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_PS
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- End of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_PS

-- Start of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_TK
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_htro_dchieu_tk
    (short_name                     VARCHAR2(21 BYTE),
    dtg_sotien                     NUMBER,
    pit_sotien                     NUMBER,
    sle_sotien                     NUMBER,
    sai_lech                       NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_HTRO_DCHIEU_TK

-- Start of DDL Script for Table TKTQ.TB_LOG_DATA
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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
;


-- End of DDL Script for Table TKTQ.TB_LOG_DATA

-- Start of DDL Script for Table TKTQ.TB_LOG_EXCEL
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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





-- Comments for TB_LOG_EXCEL

COMMENT ON COLUMN tb_log_excel.desc_err IS 'mo ta loi'
;
COMMENT ON COLUMN tb_log_excel.file_imp IS 'ten file nhap ngoai'
;
COMMENT ON COLUMN tb_log_excel.imp_date IS 'thoi gian nhan vao'
;
COMMENT ON COLUMN tb_log_excel.row_err IS 'dong excel loi'
;
COMMENT ON COLUMN tb_log_excel.sheet IS 'ten sheep trong excel'
;
COMMENT ON COLUMN tb_log_excel.short_name IS 'Ten ngan cqt'
;
COMMENT ON COLUMN tb_log_excel.status IS 'trang thai S: thanh cong, E:loi'
;
COMMENT ON COLUMN tb_log_excel.total_row_imp IS 'tong so dong nhan vao'
;

-- End of DDL Script for Table TKTQ.TB_LOG_EXCEL

-- Start of DDL Script for Table TKTQ.TB_LOG_PCK_BK
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

CREATE TABLE tb_log_pck_bk
    (id                             NUMBER(10,0) NOT NULL,
    short_name                     VARCHAR2(7 BYTE),
    time_exec                      DATE,
    pck                            VARCHAR2(50 BYTE),
    status                         VARCHAR2(2 BYTE),
    ltd                            NUMBER(4,0),
    where_log                      VARCHAR2(250 BYTE),
    err_code                       VARCHAR2(4000 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_LOG_PCK_BK

-- Start of DDL Script for Table TKTQ.TB_LOG_PSCD
-- Generated 5-Jan-2013 10:42:33 from TKTQ@DPPIT_199

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
    id_hdr                         NUMBER(15,0) )
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Constraints for TB_LOG_PSCD

ALTER TABLE tb_log_pscd
ADD CONSTRAINT pk_log_pscd PRIMARY KEY (id_hdr)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- Triggers for TB_LOG_PSCD

CREATE OR REPLACE TRIGGER trg_pscd_b
 BEFORE
  INSERT
 ON tb_log_pscd
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF :NEW.ID_HDR IS NULL THEN
        SELECT seq_id_csv.NEXTVAL INTO :NEW.ID_HDR FROM dual;
    END IF;
END;
;


-- Comments for TB_LOG_PSCD

COMMENT ON COLUMN tb_log_pscd.id IS 'NO,PS,TK DTL'
;
COMMENT ON COLUMN tb_log_pscd.imp_date IS 'current date time  import'
;
COMMENT ON COLUMN tb_log_pscd.type_data IS 'NO,PS,TK'
;

-- End of DDL Script for Table TKTQ.TB_LOG_PSCD

-- Start of DDL Script for Table TKTQ.TB_LST_ERR
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_err
    (err_id                         VARCHAR2(3 BYTE),
    err_name                       VARCHAR2(150 BYTE),
    err_type                       NUMBER(2,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_LST_ERR

-- Start of DDL Script for Table TKTQ.TB_LST_ERR_Q
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_err_q
    (err_id                         VARCHAR2(3 BYTE),
    err_name                       VARCHAR2(150 BYTE),
    err_type                       NUMBER(2,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_LST_ERR_Q

-- Start of DDL Script for Table TKTQ.TB_LST_MAP_CQT
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

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
  STORAGE   (
    INITIAL     196608
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
;





-- Indexes for TB_LST_MAP_CQT

CREATE INDEX ind_lst_map_cqt ON tb_lst_map_cqt
  (
    ma_cqt                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_lst_map_cqt7 ON tb_lst_map_cqt
  (
    ma_cqt_7                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_LST_MAP_CQT

-- Start of DDL Script for Table TKTQ.TB_LST_MAP_TMUC
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_map_tmuc
    (ma_pit                         VARCHAR2(9 BYTE),
    tmuc                           VARCHAR2(4 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_LST_MAP_TMUC

-- Start of DDL Script for Table TKTQ.TB_LST_PROVINCE
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_province
    (province                       VARCHAR2(3 BYTE) ,
    prov_name                      VARCHAR2(30 BYTE) NOT NULL,
    province_old                   VARCHAR2(2 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_LST_PROVINCE

CREATE UNIQUE INDEX ind_lst_pro_id ON tb_lst_province
  (
    province                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_LST_PROVINCE

ALTER TABLE tb_lst_province
ADD CHECK ("PROVINCE" IS NOT NULL)
;


-- End of DDL Script for Table TKTQ.TB_LST_PROVINCE

-- Start of DDL Script for Table TKTQ.TB_LST_STACQT
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_stacqt
    (id                             NUMBER(3,0) NOT NULL,
    id_name                        VARCHAR2(100 BYTE),
    tax_model                      VARCHAR2(6 BYTE),
    stt                            NUMBER(2,0),
    func_name                      VARCHAR2(30 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_LST_STACQT

CREATE INDEX ind_stacqt_func ON tb_lst_stacqt
  (
    func_name                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_LST_STACQT

ALTER TABLE tb_lst_stacqt
ADD CONSTRAINT pk_stacqt PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_LST_STACQT

-- Start of DDL Script for Table TKTQ.TB_LST_TAXO
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

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
    giai_doan                      VARCHAR2(20 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  STORAGE   (
    INITIAL     196608
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
;





-- Indexes for TB_LST_TAXO

CREATE INDEX ind_lst_taxo_sn ON tb_lst_taxo
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_LST_TAXO

ALTER TABLE tb_lst_taxo
ADD CONSTRAINT pk_lst_taxo PRIMARY KEY (tax_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_LST_TAXO

-- Start of DDL Script for Table TKTQ.TB_LST_TKHAI
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_lst_tkhai
    (id                             NUMBER(10,0) NOT NULL,
    ma_tkhai                       VARCHAR2(20 BYTE),
    ten_tkhai                      VARCHAR2(100 BYTE),
    trang_thai                     VARCHAR2(5 BYTE),
    ma_tkhai_cu                    VARCHAR2(2 BYTE),
    loai                           VARCHAR2(10 BYTE),
    loai_sub                       VARCHAR2(1 BYTE),
    ma_pit                         VARCHAR2(4 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Constraints for TB_LST_TKHAI

ALTER TABLE tb_lst_tkhai
ADD CONSTRAINT tb_dm_tkhai_pk PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;

ALTER TABLE tb_lst_tkhai
ADD CONSTRAINT tb_dm_tkhai_uk UNIQUE (trang_thai, ma_tkhai_cu)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


-- End of DDL Script for Table TKTQ.TB_LST_TKHAI

-- Start of DDL Script for Table TKTQ.TB_MASTER
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_master
    (short_name                     VARCHAR2(7 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE) NOT NULL,
    ky_psinh_tu                    VARCHAR2(10 BYTE) NOT NULL,
    ky_psinh_den                   VARCHAR2(10 BYTE) NOT NULL,
    so_tien                        NUMBER,
    han_nop                        VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_MASTER

CREATE INDEX ind_master_tin ON tb_master
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_master_short_name ON tb_master
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_MASTER

-- Start of DDL Script for Table TKTQ.TB_MASTER_SL
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

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





-- Indexes for TB_MASTER_SL

CREATE INDEX ind_master_sl_tin ON tb_master_sl
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_MASTER_SL

-- Start of DDL Script for Table TKTQ.TB_MESS_LOG
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

CREATE TABLE tb_mess_log
    (mes_no                         VARCHAR2(3 BYTE),
    mes_desc                       VARCHAR2(1000 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_MESS_LOG

-- Start of DDL Script for Table TKTQ.TB_NO
-- Generated 5-Jan-2013 10:42:34 from TKTQ@DPPIT_199

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
    ngay_hach_toan                 VARCHAR2(10 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    dkt_ma                         VARCHAR2(2 BYTE),
    no_cuoi_ky                     NUMBER(15,0),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) DEFAULT NULL NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    ten_gdich                      VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_NO

CREATE INDEX ind_qlt_no_short_name ON tb_no
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
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
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_NO

ALTER TABLE tb_no
ADD CONSTRAINT pk_no_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


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
   IF (:new.NGAY_HACH_TOAN <> :old.NGAY_HACH_TOAN  AND :old.NGAY_HACH_TOAN IS NOT NULL AND :new.NGAY_HACH_TOAN IS NOT NULL) OR
                 (:old.NGAY_HACH_TOAN IS NOT NULL AND :new.NGAY_HACH_TOAN IS NULL) OR
                 (:old.NGAY_HACH_TOAN IS NULL AND :new.NGAY_HACH_TOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','NGAY_HACH_TOAN',:new.NGAY_HACH_TOAN,:old.NGAY_HACH_TOAN);
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
   IF (:new.DKT_MA <> :old.DKT_MA  AND :old.DKT_MA IS NOT NULL AND :new.DKT_MA IS NOT NULL) OR
                 (:old.DKT_MA IS NOT NULL AND :new.DKT_MA IS NULL) OR
                 (:old.DKT_MA IS NULL AND :new.DKT_MA IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','DKT_MA',:new.DKT_MA,:old.DKT_MA);
   END IF;
   IF (:new.NO_CUOI_KY <> :old.NO_CUOI_KY  AND :old.NO_CUOI_KY IS NOT NULL AND :new.NO_CUOI_KY IS NOT NULL) OR
                 (:old.NO_CUOI_KY IS NOT NULL AND :new.NO_CUOI_KY IS NULL) OR
                 (:old.NO_CUOI_KY IS NULL AND :new.NO_CUOI_KY IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_NO','NO_CUOI_KY',:new.NO_CUOI_KY,:old.NO_CUOI_KY);
   END IF;

END;
;


-- Comments for TB_NO

COMMENT ON COLUMN tb_no.imp_file IS 't?n file convert t? excel'
;

-- End of DDL Script for Table TKTQ.TB_NO

-- Start of DDL Script for Table TKTQ.TB_NO_BU
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_no_bu
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    tmt_ma_tmuc                    VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    ngay_hach_toan                 VARCHAR2(10 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    dkt_ma                         VARCHAR2(2 BYTE),
    no_cuoi_ky                     NUMBER(15,0),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    ten_gdich                      VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_NO_BU

-- Start of DDL Script for Table TKTQ.TB_NO_PTH_LTH_PNI
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_no_pth_lth_pni
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    tmt_ma_tmuc                    VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    ngay_hach_toan                 VARCHAR2(10 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    dkt_ma                         VARCHAR2(2 BYTE),
    no_cuoi_ky                     NUMBER(15,0),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    ten_gdich                      VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_NO_PTH_LTH_PNI

-- Start of DDL Script for Table TKTQ.TB_NO_PTH_PNI_LTH
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_no_pth_pni_lth
    (short_name                     VARCHAR2(7 BYTE),
    stt                            NUMBER(10,0),
    loai                           VARCHAR2(2 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_chuong                      VARCHAR2(3 BYTE),
    ma_khoan                       VARCHAR2(3 BYTE),
    tmt_ma_tmuc                    VARCHAR2(4 BYTE),
    tkhoan                         VARCHAR2(20 BYTE),
    ngay_hach_toan                 VARCHAR2(10 BYTE),
    kykk_tu_ngay                   VARCHAR2(10 BYTE),
    kykk_den_ngay                  VARCHAR2(10 BYTE),
    han_nop                        VARCHAR2(10 BYTE),
    dkt_ma                         VARCHAR2(2 BYTE),
    no_cuoi_ky                     NUMBER(15,0),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) NOT NULL,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE),
    ma_gdich                       VARCHAR2(3 BYTE),
    ten_gdich                      VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_NO_PTH_PNI_LTH

-- Start of DDL Script for Table TKTQ.TB_PIT
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_pit
    (ma_cqt                         VARCHAR2(12 BYTE) NOT NULL,
    persl                          VARCHAR2(12 BYTE) NOT NULL,
    total                          NUMBER,
    he_thong                       CHAR(3 BYTE),
    mst                            VARCHAR2(180 BYTE) NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_PIT

-- Start of DDL Script for Table TKTQ.TB_PITMS_DPPIT_MAPPING
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_pitms_dppit_mapping
    (pitms_column                   VARCHAR2(50 BYTE),
    dppit_column                   VARCHAR2(50 BYTE),
    table_name                     VARCHAR2(5 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_PITMS_DPPIT_MAPPING

-- Start of DDL Script for Table TKTQ.TB_PS
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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
    ky_psinh_tu                    VARCHAR2(10 BYTE),
    ky_psinh_den                   VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0) ,
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  STORAGE   (
    INITIAL     2097152
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
;





-- Indexes for TB_PS

CREATE INDEX ind_qlt_ps_short_name ON tb_ps
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     589824
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_ps_model ON tb_ps
  (
    tax_model                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     524288
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_ps_tin ON tb_ps
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     655360
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_PS

ALTER TABLE tb_ps
ADD CONSTRAINT pk_ps_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     458752
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


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
;

CREATE OR REPLACE TRIGGER trg_au_tb_ps
 AFTER
  UPDATE
 ON tb_ps
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
   IF (:new.MA_TKHAI <> :old.MA_TKHAI  AND :old.MA_TKHAI IS NOT NULL AND :new.MA_TKHAI IS NOT NULL) OR
                 (:old.MA_TKHAI IS NOT NULL AND :new.MA_TKHAI IS NULL) OR
                 (:old.MA_TKHAI IS NULL AND :new.MA_TKHAI IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','MA_TKHAI',:new.MA_TKHAI,:old.MA_TKHAI);
   END IF;
   IF (:new.MA_CHUONG <> :old.MA_CHUONG  AND :old.MA_CHUONG IS NOT NULL AND :new.MA_CHUONG IS NOT NULL) OR
                 (:old.MA_CHUONG IS NOT NULL AND :new.MA_CHUONG IS NULL) OR
                 (:old.MA_CHUONG IS NULL AND :new.MA_CHUONG IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','MA_CHUONG',:new.MA_CHUONG,:old.MA_CHUONG);
   END IF;
   IF (:new.MA_TMUC <> :old.MA_TMUC  AND :old.MA_TMUC IS NOT NULL AND :new.MA_TMUC IS NOT NULL) OR
                 (:old.MA_TMUC IS NOT NULL AND :new.MA_TMUC IS NULL) OR
                 (:old.MA_TMUC IS NULL AND :new.MA_TMUC IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','MA_TMUC',:new.MA_TMUC,:old.MA_TMUC);
   END IF;
   IF (:new.TKHOAN <> :old.TKHOAN  AND :old.TKHOAN IS NOT NULL AND :new.TKHOAN IS NOT NULL) OR
                 (:old.TKHOAN IS NOT NULL AND :new.TKHOAN IS NULL) OR
                 (:old.TKHOAN IS NULL AND :new.TKHOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','TKHOAN',:new.TKHOAN,:old.TKHOAN);            
   END IF;
   IF (:new.MA_KHOAN <> :old.MA_KHOAN  AND :old.MA_KHOAN IS NOT NULL AND :new.MA_KHOAN IS NOT NULL) OR
                 (:old.MA_KHOAN IS NOT NULL AND :new.MA_KHOAN IS NULL) OR
                 (:old.MA_KHOAN IS NULL AND :new.MA_KHOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','MA_KHOAN',:new.MA_KHOAN,:old.MA_KHOAN);            
   END IF;
   IF (:new.KY_PSINH_TU <> :old.KY_PSINH_TU  AND :old.KY_PSINH_TU IS NOT NULL AND :new.KY_PSINH_TU IS NOT NULL) OR
                 (:old.KY_PSINH_TU IS NOT NULL AND :new.KY_PSINH_TU IS NULL) OR
                 (:old.KY_PSINH_TU IS NULL AND :new.KY_PSINH_TU IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','KY_PSINH_TU',:new.KY_PSINH_TU,:old.KY_PSINH_TU);
   END IF;
   IF (:new.KY_PSINH_DEN <> :old.KY_PSINH_DEN  AND :old.KY_PSINH_DEN IS NOT NULL AND :new.KY_PSINH_DEN IS NOT NULL) OR
                 (:old.KY_PSINH_DEN IS NOT NULL AND :new.KY_PSINH_DEN IS NULL) OR
                 (:old.KY_PSINH_DEN IS NULL AND :new.KY_PSINH_DEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','KY_PSINH_DEN',:new.KY_PSINH_DEN,:old.KY_PSINH_DEN);
   END IF;
   IF (:new.SO_TIEN <> :old.SO_TIEN  AND :old.SO_TIEN IS NOT NULL AND :new.SO_TIEN IS NOT NULL) OR
                 (:old.SO_TIEN IS NOT NULL AND :new.SO_TIEN IS NULL) OR
                 (:old.SO_TIEN IS NULL AND :new.SO_TIEN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','SO_TIEN',:new.SO_TIEN,:old.SO_TIEN);
   END IF;
   IF (:new.HAN_NOP <> :old.HAN_NOP  AND :old.HAN_NOP IS NOT NULL AND :new.HAN_NOP IS NOT NULL) OR
                 (:old.HAN_NOP IS NOT NULL AND :new.HAN_NOP IS NULL) OR
                 (:old.HAN_NOP IS NULL AND :new.HAN_NOP IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','HAN_NOP',:new.HAN_NOP,:old.HAN_NOP);
   END IF;
   IF (:new.NGAY_HTOAN <> :old.NGAY_HTOAN  AND :old.NGAY_HTOAN IS NOT NULL AND :new.NGAY_HTOAN IS NOT NULL) OR
                 (:old.NGAY_HTOAN IS NOT NULL AND :new.NGAY_HTOAN IS NULL) OR
                 (:old.NGAY_HTOAN IS NULL AND :new.NGAY_HTOAN IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','NGAY_HTOAN',:new.NGAY_HTOAN,:old.NGAY_HTOAN);
   END IF;
   IF (:new.NGAY_NOP <> :old.NGAY_NOP  AND :old.NGAY_NOP IS NOT NULL AND :new.NGAY_NOP IS NOT NULL) OR
                 (:old.NGAY_NOP IS NOT NULL AND :new.NGAY_NOP IS NULL) OR
                 (:old.NGAY_NOP IS NULL AND :new.NGAY_NOP IS NOT NULL) THEN
            Insert Into tb_log_data( id_dtl, table_name, filed_name, new_value, old_value)
            Values (:old.ID,'TB_PS','NGAY_NOP',:new.NGAY_NOP,:old.NGAY_NOP);
   END IF;

END;
;


-- End of DDL Script for Table TKTQ.TB_PS

-- Start of DDL Script for Table TKTQ.TB_PS_10PB
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_ps_10pb
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
    ky_psinh_tu                    VARCHAR2(10 BYTE),
    ky_psinh_den                   VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_PS_10PB

-- Start of DDL Script for Table TKTQ.TB_PS_PTH_LTH_PNI
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_ps_pth_lth_pni
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
    ky_psinh_tu                    VARCHAR2(10 BYTE),
    ky_psinh_den                   VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_PS_PTH_LTH_PNI

-- Start of DDL Script for Table TKTQ.TB_PS_PTH_PNI_LTH
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_ps_pth_pni_lth
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
    ky_psinh_tu                    VARCHAR2(10 BYTE),
    ky_psinh_den                   VARCHAR2(10 BYTE),
    so_tien                        NUMBER(15,0),
    han_nop                        VARCHAR2(10 BYTE),
    ngay_htoan                     VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    tax_model                      VARCHAR2(7 BYTE),
    status                         VARCHAR2(1 BYTE),
    id                             NUMBER(15,0),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(150 BYTE),
    imp_file                       VARCHAR2(50 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- End of DDL Script for Table TKTQ.TB_PS_PTH_PNI_LTH

-- Start of DDL Script for Table TKTQ.TB_PS_TK10_SAILECH
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_ps_tk10_sailech
    (short_name                     VARCHAR2(7 BYTE),
    tin                            VARCHAR2(14 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    thuetky                        NUMBER(15,0),
    thuepbo                        NUMBER(15,0),
    lydoloi                        VARCHAR2(150 BYTE),
    id                             NUMBER(8,0) NOT NULL,
    update_no                      NUMBER(3,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_PS_TK10_SAILECH

CREATE INDEX ind_ps_tk10_sailech_tin ON tb_ps_tk10_sailech
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_PS_TK10_SAILECH

-- Start of DDL Script for Table TKTQ.TB_PS10_MASTER
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

CREATE TABLE tb_ps10_master
    (short_name                     VARCHAR2(7 BYTE),
    ma_cqt                         VARCHAR2(5 BYTE),
    tin                            VARCHAR2(14 BYTE) NOT NULL,
    ky_psinh_tu                    VARCHAR2(10 BYTE) NOT NULL,
    ky_psinh_den                   VARCHAR2(10 BYTE) NOT NULL,
    so_tien                        NUMBER,
    han_nop                        VARCHAR2(10 BYTE),
    ngay_nop                       VARCHAR2(10 BYTE),
    ma_cbo                         VARCHAR2(10 BYTE),
    ten_cbo                        VARCHAR2(100 BYTE),
    ma_pban                        VARCHAR2(10 BYTE),
    ten_pban                       VARCHAR2(100 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_PS10_MASTER

CREATE INDEX ind_ps10_master_tin ON tb_ps10_master
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_ps10_master_short_name ON tb_ps10_master
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_PS10_MASTER

-- Start of DDL Script for Table TKTQ.TB_PT
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- Indexes for TB_PT

CREATE INDEX ind_pt_sname ON tb_pt
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



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
;


-- End of DDL Script for Table TKTQ.TB_PT

-- Start of DDL Script for Table TKTQ.TB_SLECH_NO
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- Indexes for TB_SLECH_NO

CREATE INDEX ind_slno_short_name ON tb_slech_no
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_SLECH_NO

-- Start of DDL Script for Table TKTQ.TB_SLECH_TIN
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- Indexes for TB_SLECH_TIN

CREATE INDEX ind_sltin_upn ON tb_slech_tin
  (
    update_no                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_sltin_shn ON tb_slech_tin
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_SLECH_TIN

-- Start of DDL Script for Table TKTQ.TB_TEMP_DCHIEU
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- Indexes for TB_TEMP_DCHIEU

CREATE INDEX ind_tmpdchieu_sname ON tb_temp_dchieu
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_TEMP_DCHIEU

-- Start of DDL Script for Table TKTQ.TB_TEMP_HTDC_NO
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- End of DDL Script for Table TKTQ.TB_TEMP_HTDC_NO

-- Start of DDL Script for Table TKTQ.TB_TEMP_HTDC_PS
-- Generated 5-Jan-2013 10:42:35 from TKTQ@DPPIT_199

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





-- End of DDL Script for Table TKTQ.TB_TEMP_HTDC_PS

-- Start of DDL Script for Table TKTQ.TB_TEMP_HTDC_TK
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

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





/*-- End of DDL Script for Table TKTQ.TB_TEMP_HTDC_TK

-- Start of DDL Script for Table TKTQ.TB_TEMP_RPDTL
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

CREATE GLOBAL TEMPORARY TABLE tb_temp_rpdtl
    (grb_tinh                       NUMBER(1,0),
    grb_short_name                 NUMBER(1,0),
    grb_err_name                   NUMBER(1,0),
    grb_so_luong                   NUMBER(1,0),
    tinh                           VARCHAR2(3 BYTE),
    short_name                     VARCHAR2(7 BYTE),
    so_luong                       NUMBER(15,0))
ON COMMIT DELETE ROWS
  NOPARALLEL
  NOLOGGING
;*/





-- End of DDL Script for Table TKTQ.TB_TEMP_RPDTL

-- Start of DDL Script for Table TKTQ.TB_TK
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

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
  STORAGE   (
    INITIAL     13631488
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
;





-- Indexes for TB_TK

CREATE INDEX ind_vat_tk_short_name ON tb_tk
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_tk_tin ON tb_tk
  (
    tin                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- Constraints for TB_TK

ALTER TABLE tb_tk
ADD CONSTRAINT pk_tk_id PRIMARY KEY (id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     917504
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
;


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
;

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
;


-- End of DDL Script for Table TKTQ.TB_TK

-- Start of DDL Script for Table TKTQ.TB_TK_BU
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

CREATE TABLE tb_tk_bu
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





-- End of DDL Script for Table TKTQ.TB_TK_BU

-- Start of DDL Script for Table TKTQ.TB_TK_PTH_LTH_PNI
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

CREATE TABLE tb_tk_pth_lth_pni
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





-- End of DDL Script for Table TKTQ.TB_TK_PTH_LTH_PNI

-- Start of DDL Script for Table TKTQ.TB_UNSPLIT_DATA_ERROR
-- Generated 5-Jan-2013 10:42:36 from TKTQ@DPPIT_199

CREATE TABLE tb_unsplit_data_error
    (short_name                     VARCHAR2(7 BYTE),
    rid                            VARCHAR2(25 BYTE),
    table_name                     VARCHAR2(30 BYTE),
    err_string                     VARCHAR2(1000 BYTE))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
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





-- Indexes for TB_UNSPLIT_DATA_ERROR

CREATE INDEX ind_unlit_shn ON tb_unsplit_data_error
  (
    short_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;

CREATE INDEX ind_unlit_tba ON tb_unsplit_data_error
  (
    table_name                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
;



-- End of DDL Script for Table TKTQ.TB_UNSPLIT_DATA_ERROR

