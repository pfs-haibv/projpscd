CREATE OR REPLACE 
PACKAGE BODY pck_moi_truong
IS
    /*************************************************************************** PCK_MOI_TRUONG.Prc_Cre_DBlink(p_pay_taxo_id)
    Noi dung: Dua ra danh sach chenh lech
    ***************************************************************************/
    PROCEDURE prc_cre_dblink (p_short_name VARCHAR2)
    IS
        v_user_qlt   VARCHAR2 (20);
        v_pass_qlt   VARCHAR2 (20);
        v_ses        NUMBER (2);

    BEGIN
        FOR v IN (SELECT   qlt_user, qlt_pass
                    FROM   tb_lst_taxo
                   WHERE   short_name = p_short_name)
        LOOP
            IF ( (v.qlt_user IS NOT NULL) AND (v.qlt_pass IS NOT NULL))
            THEN
                prc_drop_dblink ('QLT');
                prc_drop_dblink ('QLT_' || p_short_name);

                EXECUTE IMMEDIATE   'CREATE DATABASE LINK QLT '
                                 || 'CONNECT TO '
                                 || v.qlt_user
                                 || ' IDENTIFIED BY '
                                 || v.qlt_pass
                                 || '
                         USING ''QLT_'
                                 || p_short_name
                                 || '''';

                EXECUTE IMMEDIATE   'CREATE DATABASE LINK QLT_'
                                 || p_short_name
                                 || ' CONNECT TO '
                                 || v.qlt_user
                                 || ' IDENTIFIED BY '
                                 || v.qlt_pass
                                 || '
                         USING ''QLT_'
                                 || p_short_name
                                 || '''';
            END IF;
        END LOOP;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Cre_DBlink(p_pay_taxo_id)
    Noi dung: Dua ra danh sach chenh lech
    ***************************************************************************/
    PROCEDURE prc_cre_dblink_pnn (p_short_name VARCHAR2)
    IS
        v_user_qlt   VARCHAR2 (20);
        v_pass_qlt   VARCHAR2 (20);
        v_ses        NUMBER (2);

    BEGIN
        FOR v IN (SELECT   pnn_user, pnn_pass
                    FROM   tb_lst_taxo
                   WHERE   short_name = p_short_name)
        LOOP
            IF ( (v.pnn_user IS NOT NULL) AND (v.pnn_pass IS NOT NULL))
            THEN
                prc_drop_dblink ('PNN');
                prc_drop_dblink ('PNN_' || p_short_name);

                EXECUTE IMMEDIATE   'CREATE DATABASE LINK PNN '
                                 || 'CONNECT TO '
                                 || v.pnn_user
                                 || ' IDENTIFIED BY '
                                 || v.pnn_pass
                                 || ' USING ''PNN'''
                                 ;

                EXECUTE IMMEDIATE   'CREATE DATABASE LINK PNN_'
                                 || p_short_name
                                 || ' CONNECT TO '
                                 || v.pnn_user
                                 || ' IDENTIFIED BY '
                                 || v.pnn_pass
                                 || ' USING ''PNN'''
                                ;
            END IF;
        END LOOP;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Close_DBlink
    Noi dung: Dong phien lam viec DBLINK
    ***************************************************************************/
    PROCEDURE prc_close_dblink (p_link VARCHAR2)
    IS
    BEGIN
        COMMIT;

        FOR v IN (SELECT   db_link
                    FROM   v$dblink
                   WHERE   db_link = p_link)
        LOOP
            DBMS_SESSION.close_database_link (v.db_link);
        END LOOP;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Drop_DBlink
    Noi dung: Xoa DATABASE LINK
    ***************************************************************************/
    PROCEDURE prc_drop_dblink (p_link VARCHAR2)
    IS
    BEGIN
        prc_close_dblink (p_link);

        FOR v IN (SELECT   db_link
                    FROM   all_db_links
                   WHERE   db_link = p_link)
        LOOP
            EXECUTE IMMEDIATE 'DROP DATABASE LINK ' || v.db_link;
        END LOOP;
    END;

    /***************************************************************************
    pck_trace_log.Fnc_WhoCalledMe: Xac dinh noi PROCEDURE goi trong PCK
    ***************************************************************************/
    PROCEDURE prc_remote_sql (p_sql IN VARCHAR2)
    AS
        exec_cursor      INTEGER DEFAULT DBMS_SQL.open_cursor@qlt;
        rows_processed   NUMBER DEFAULT 0;
    BEGIN
        DBMS_SQL.parse@qlt (exec_cursor, p_sql, DBMS_SQL.native);
        rows_processed := DBMS_SQL.execute@qlt (exec_cursor);
        DBMS_SQL.close_cursor@qlt (exec_cursor);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Seq
    Noi dung: Khoi tao SEQUENCE
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_seq
    IS
        v_str   VARCHAR2 (5000);
    BEGIN
        prc_ddep_seq;
        prc_remote_sql('CREATE SEQUENCE ext_seq
                        INCREMENT BY 1
                        START WITH 1
                        MINVALUE 1
                        MAXVALUE 999999999999999999999999999
                        NOCYCLE
                        ORDER
                        CACHE 20'
                                 );
    END;


    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDep_Seq
    Noi dung: Don dep SEQUENCE
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_seq
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'EXT_SEQ';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'SEQUENCE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP SEQUENCE ' || c_name_drop);
        END LOOP;
    END;
    /**
     * @package: PCK_MOI_TRUONG.prc_remote_sql_pnn
     * @desc:    remote sql PNN-APP
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:
     */
    PROCEDURE prc_remote_sql_pnn (p_sql IN VARCHAR2)
    AS
        exec_cursor      INTEGER DEFAULT DBMS_SQL.open_cursor@pnn;
        rows_processed   NUMBER DEFAULT 0;
    BEGIN
        DBMS_SQL.parse@pnn (exec_cursor, p_sql, DBMS_SQL.native);
        rows_processed := DBMS_SQL.execute@pnn (exec_cursor);
        DBMS_SQL.close_cursor@pnn (exec_cursor);
    END;
    /**
     * @package: PCK_MOI_TRUONG.prc_remote_sql_pnn
     * @desc:    create sequence PNN-APP
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:
     */
    PROCEDURE prc_ktao_seq_pnn
    IS
        v_str   VARCHAR2 (5000);
    BEGIN
        prc_ddep_seq_pnn;
        prc_remote_sql_pnn('CREATE SEQUENCE ext_seq
                        INCREMENT BY 1
                        START WITH 1
                        MINVALUE 1
                        MAXVALUE 999999999999999999999999999
                        NOCYCLE
                        ORDER
                        CACHE 20'
                                 );
    END;
    /**
     * @package: PCK_MOI_TRUONG.prc_ddep_seq_pnn
     * @desc:    drop sequence PNN-APP
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:
     */
    PROCEDURE prc_ddep_seq_pnn
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'EXT_SEQ';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@pnn
             WHERE   object_type = 'SEQUENCE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql_pnn ('DROP SEQUENCE ' || c_name_drop);
        END LOOP;
    END;
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_ps
    Noi dung: Khoi tao bang ext_qlt_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_qlt_ps
    IS
    BEGIN
        prc_ddep_tb_ext_qlt_ps;
        prc_remote_sql('CREATE TABLE ext_qlt_ps(id  NUMBER(10,0) NOT NULL,
                tin                         VARCHAR2(14),
                ma_chuong                   VARCHAR2(3),
                ma_khoan                    VARCHAR2(3),
                ma_tmuc                     VARCHAR2(4),
                so_tien                     NUMBER(20,2),
                ma_loai_tkhai               VARCHAR2(2),
                ky_psinh_tu                 DATE,
                ky_psinh_den                DATE,
                han_nop                     DATE,
                ma_cbo                      VARCHAR2(15),
                ten_cbo                     VARCHAR2(150),
                ma_pban                     VARCHAR2(15),
                ten_pban                    VARCHAR2(250))'
                                                          );
        prc_remote_sql('ALTER TABLE ext_qlt_ps
                        ADD CONSTRAINT ext_qpd_pk PRIMARY KEY (id)
                        USING INDEX'
                                    );
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),
                                       pck_trace_log.fnc_whocalledme);
    END;

    PROCEDURE prc_ktao_tb_ext_qlt_dmtk_ps

    IS
        sql_text   VARCHAR (200);

    BEGIN
        prc_ddep_tb_ext_qlt_dmtk_ps;


        prc_remote_sql('CREATE TABLE ext_qlt_dmtk_ps(
                MA_LOAI_TKHAI              VARCHAR2(2),
                TEN_TKHAI                  VARCHAR2(100))'
                                                          );

        sql_text :='insert into ext_qlt_dmtk_ps@QLT select * from TB_LST_TKHAI_PS';

        EXECUTE IMMEDIATE sql_text;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
    END;


    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_ps
    Noi dung: Khoi tao bang ext_qlt_ps
    Nguoi thuc hien: DuBV
    ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_qlt_con_kt
    IS
    BEGIN
        prc_ddep_tb_ext_qlt_con_kt;

        prc_remote_sql('CREATE TABLE ext_qlt_CON_KT(id  NUMBER(10,0) NOT NULL,
                tin                         VARCHAR2(14),
                ma_chuong                   VARCHAR2(3),
                ma_khoan                    VARCHAR2(3),
                ma_tmuc                     VARCHAR2(4),
                ma_loai_tkhai               VARCHAR2(2),
                KYKK_TU_NGAY                 DATE,
                KYKK_DEN_NGAY                DATE,
                han_nop                     DATE,
                so_tien                     NUMBER(20,2),
                ma_cbo                      VARCHAR2(15),
                ten_cbo                     VARCHAR2(150),
                ma_pban                     VARCHAR2(15),
                ten_pban                    VARCHAR2(250))'

                                                           );
        prc_remote_sql('ALTER TABLE ext_qlt_ps
                        ADD CONSTRAINT ext_qpd_pk PRIMARY KEY (id)
                        USING INDEX'
                                    );
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
    END;

    /**
     * @package: PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_app
     * @desc:    Create table qlt-app vs qct-app
     * @author:  Administrator
     * @date:    04/08/2013
     * @param:
     */
    PROCEDURE prc_ktao_table (tax_model VARCHAR2)
    IS
    BEGIN
        --drop table
        pck_ult.prc_drop_tbl_qlt ('user_objects@qlt', '' || tax_model || '');
        --create table
        pck_ult.prc_create_tbl_qlt ('' || tax_model || '');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
    END;

    PROCEDURE prc_ktao_table_pnn (tax_model VARCHAR2)
    IS
    BEGIN
        --drop table
        pck_ult.prc_drop_tbl_pnn ('user_objects@pnn', '' || tax_model || '');
        --create table
        pck_ult.prc_create_tbl_pnn ('' || tax_model || '');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
    END;
    /**
     * @package: PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_app
     * @desc:    Lay du lieu danh muc to khai voi tax_mode: QLT, QCT ...
     * @author:  Administrator
     * @date:    06/05/2013
     * @param:
     **/
    PROCEDURE prc_getdata_dmuc_tkhai (v_tax_model VARCHAR2)
    IS
        sql_text   VARCHAR (200);
    BEGIN
        --Clear data
        prc_remote_sql('truncate table ext_dmuc_tkhai');
        sql_text := 'INSERT INTO ext_dmuc_tkhai@qlt
                        SELECT * FROM tb_dmuc_tkhai where tax_model ='''||v_tax_model||'''';
        EXECUTE IMMEDIATE sql_text;

        prc_remote_sql('commit');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'), pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_ps
    Noi dung: Don dep bang ext_qlt_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_qlt_ps
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'EXT_QLT_PS';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

   /***************************************************************************
   PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_conkt
   Noi dung: Don dep bang ext_qlt_ps
   Nguoi thuc hien: ThanhNH5
   Ngay thuc hien: 29/09/2011
   ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_qlt_con_kt
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'ext_qlt_CON_KT';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
        PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_ps
        Noi dung: Don dep bang ext_qlt_ps
        Nguoi thuc hien: ThanhNH5
        Ngay thuc hien: 29/09/2011
        ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_qlt_dmtk_ps
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'EXT_QLT_DMTK_PS';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_no
    Noi dung: Khoi tao bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_qlt_no
    IS
    BEGIN
        prc_ddep_tb_ext_qlt_no;

        prc_remote_sql('CREATE TABLE ext_qlt_no
                      ( ma_cbo                         VARCHAR2(15),
                        ten_cbo                        VARCHAR2(150),
                        ma_pban                        VARCHAR2(15),
                        ten_pban                       VARCHAR2(250),
                        tin                            VARCHAR2(14),
                        tkhoan                         VARCHAR2(30),
                        ma_chuong                      VARCHAR2(3),
                        ma_khoan                       VARCHAR2(3),
                        tmt_ma_tmuc                    VARCHAR2(4),
                        kykk_tu_ngay                   DATE,
                        kykk_den_ngay                  DATE,
                        ngay_hach_toan                 DATE,
                        han_nop                        DATE,
                        nguon_goc                      VARCHAR2(100),
                        tinh_chat                      VARCHAR2(10),
                        so_qd                          VARCHAR2(20),
                        ngay_qd                        DATE,
                        so_tien                        NUMBER(20,0),
                        NO_NTE                         VARCHAR2(1),
                        DON_VI_TIEN                    VARCHAR2(5),
                        id                             NUMBER(10,0))'
                                                                     );

        prc_remote_sql('CREATE TABLE ext_qlt_no_thanh_toan
                      (
                          TIN                   VARCHAR2(14)
                        , HDR_ID                NUMBER(10,0)
                        , DTL_ID                NUMBER(10,0)
                        , TKHOAN                VARCHAR2(30)
                        , MA_CHUONG             VARCHAR2(3)
                        , MA_KHOAN              VARCHAR2(3)
                        , MA_MUC                VARCHAR2(4)
                        , MA_TMUC               VARCHAR2(4)
                        , KY_TTOAN_TU_NGAY      DATE
                        , KY_TTOAN_DEN_NGAY     DATE
                        , KYLB_TU_NGAY          DATE
                        , KYLB_DEN_NGAY         DATE
                        , KYKK_TU_NGAY          DATE
                        , KYKK_DEN_NGAY         DATE
                        , MA_THUE               VARCHAR2(30)
                        , NO_DAU_KY             NUMBER(20,0)
                        , PHAI_NOP              NUMBER(20,0)
                        , HAN_NOP               DATE
                        , KYTP_TU_NGAY          DATE
                        , MA_GDICH              VARCHAR2(3)
                        , KIEU_GDICH            VARCHAR2(2)
                        , TEN_GDICH             VARCHAR2(100)
                        , CHK_KNO               VARCHAR2(1)
                        , QDINH_ID              NUMBER(20,0)
                        , Loai_Qdinh            VARCHAR2(2)
                        , Nguon_Goc             VARCHAR2(100)
                        , NO_NTE                VARCHAR2(1)
                        , DON_VI_TIEN           VARCHAR2(5)
                        , id                    NUMBER(10,0)
                      )'

                        );

        prc_remote_sql('CREATE TABLE ext_qlt_tc_no
                            (pnop_id                        NUMBER(10,0),
                             dtc_ma                         VARCHAR2(2)
                        )'
                      );

        prc_remote_sql('CREATE TABLE ext_qtn_so_no_qlt
    (
    id                             NUMBER(20,0),
    kyno_den_ngay                  DATE ,
    hdr_id                         NUMBER(10,0) ,
    dtl_id                         NUMBER(10,0) ,
    dgd_ma_gdich                   VARCHAR2(3) ,
    dgd_kieu_gdich                 VARCHAR2(2) ,
    tkn_ma                         VARCHAR2(2) ,
    dtc_ma                         VARCHAR2(2) ,
    kylb_tu_ngay                   DATE ,
    kylb_den_ngay                  DATE ,
    kykk_tu_ngay                   DATE,
    kykk_den_ngay                  DATE,
    tin                            VARCHAR2(14) ,
    tmt_ma_tmuc                    VARCHAR2(4) ,
    tmt_ma_thue                    VARCHAR2(2) ,
    han_nop                        DATE)
    '
     );
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_no
    Noi dung: Khoi tao bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_qct_no
    IS
    BEGIN
        prc_ddep_tb_ext_qct_no;

        prc_remote_sql('CREATE TABLE ext_qct_no
                      ( ma_cbo                         VARCHAR2(15),
                        ten_cbo                        VARCHAR2(150),
                        ma_pban                        VARCHAR2(15),
                        ten_pban                       VARCHAR2(250),
                        tin                            VARCHAR2(14),
                        tkhoan                         VARCHAR2(30),
                        ma_chuong                      VARCHAR2(3),
                        ma_khoan                       VARCHAR2(3),
                        tmt_ma_tmuc                    VARCHAR2(4),
                        kykk_tu_ngay                   DATE,
                        kykk_den_ngay                  DATE,
                        ngay_hach_toan                 DATE,
                        han_nop                        DATE,
                        nguon_goc                      VARCHAR2(100),
                        tinh_chat                      VARCHAR2(10),
                        so_qd                          VARCHAR2(20),
                        ngay_qd                        DATE,
                        so_tien                        NUMBER(20,0),
                        id                             NUMBER(10,0))'
                                                                     );

        prc_remote_sql('CREATE TABLE ext_qct_no_thanh_toan
                      (
                          TIN                   VARCHAR2(14)
                        , HDR_ID                NUMBER(10,0)
                        , DTL_ID                NUMBER(10,0)
                        , TKHOAN                VARCHAR2(30)
                        , MA_CHUONG             VARCHAR2(3)
                        , MA_KHOAN              VARCHAR2(3)
                        , MA_MUC                VARCHAR2(4)
                        , MA_TMUC               VARCHAR2(4)
                        , KY_TTOAN_TU_NGAY      DATE
                        , KY_TTOAN_DEN_NGAY     DATE
                        , KYLB_TU_NGAY          DATE
                        , KYLB_DEN_NGAY         DATE
                        , KYKK_TU_NGAY          DATE
                        , KYKK_DEN_NGAY         DATE
                        , MA_THUE               VARCHAR2(30)
                        , NO_DAU_KY             NUMBER(20,0)
                        , PHAI_NOP              NUMBER(20,0)
                        , HAN_NOP               DATE
                        , KYTP_TU_NGAY          DATE
                        , MA_GDICH              VARCHAR2(3)
                        , KIEU_GDICH            VARCHAR2(2)
                        , TEN_GDICH             VARCHAR2(100)
                        , CHK_KNO               VARCHAR2(1)
                        , QDINH_ID              NUMBER(20,0)
                        , Loai_Qdinh            VARCHAR2(2)
                        , Nguon_Goc             VARCHAR2(100)
                        , id                    NUMBER(10,0)
                      )'

                        );

        prc_remote_sql('CREATE TABLE ext_qct_tc_no
                            (pnop_id                        NUMBER(10,0),
                             dtc_ma                         VARCHAR2(2)
                        )'
                      );

        prc_remote_sql('CREATE TABLE ext_qtn_so_no_qct
    (
    id                             NUMBER(20,0),
    kyno_den_ngay                  DATE ,
    hdr_id                         NUMBER(10,0) ,
    dtl_id                         NUMBER(10,0) ,
    dgd_ma_gdich                   VARCHAR2(3) ,
    dgd_kieu_gdich                 VARCHAR2(2) ,
    tkn_ma                         VARCHAR2(2) ,
    dtc_ma                         VARCHAR2(2) ,
    kylb_tu_ngay                   DATE ,
    kylb_den_ngay                  DATE ,
    kykk_tu_ngay                   DATE,
    kykk_den_ngay                  DATE,
    tin                            VARCHAR2(14) ,
    tmt_ma_tmuc                    VARCHAR2(4) ,
    tmt_ma_thue                    VARCHAR2(2) ,
    han_nop                        DATE)
    '
     );
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
   PCK_MOI_TRUONG.Prc_Ktao_tb_ext_dm_gdich_qdinh
   Noi dung: Khoi tao bang danh muc giao dich cac quyet dinh
   Nguoi thuc hien: DUBV
   Ngay thuc hien: 9/04/2013
   ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_dm_gdich_qlt
    IS
        sql_text   VARCHAR (200);
    BEGIN
        Prc_Ddep_tb_ext_dm_gdich_qlt;
        prc_remote_sql('CREATE TABLE EXT_QLT_DM_GDICH_QDINH
                       (ten_gdich                     VARCHAR2(100),
                        ma_gdich                       VARCHAR2(3),
                        kieu_gdich                     VARCHAR2(2),
                        bang_hdr                       VARCHAR2(50),
                        ten_qdinh                      VARCHAR2(100),
                        ten_cot_sqd                    VARCHAR2(20),
                        ten_cot_nqd                    VARCHAR2(20))'
                                                                     );

        sql_text :='INSERT INTO ext_qlt_dm_gdich_qdinh@qlt SELECT * FROM tb_qlt_dm_gdich_qdinh';

        EXECUTE IMMEDIATE sql_text;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),
                                          pck_trace_log.fnc_whocalledme);
    END;

   /***************************************************************************
   PCK_MOI_TRUONG.Prc_Ktao_tb_ext_dm_gdich_qdinh
   Noi dung: Khoi tao bang danh muc giao dich cac quyet dinh
   Nguoi thuc hien: DUBV
   Ngay thuc hien: 9/04/2013
   ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_dm_gdich_qct
    IS
        sql_text   VARCHAR (200);
    BEGIN
        Prc_Ddep_tb_ext_dm_gdich_qct;
        prc_remote_sql('CREATE TABLE EXT_QCT_DM_GDICH_QDINH
                       (ten_gdich                     VARCHAR2(100),
                        ma_gdich                       VARCHAR2(3),
                        kieu_gdich                     VARCHAR2(2),
                        bang_hdr                       VARCHAR2(50),
                        ten_qdinh                      VARCHAR2(100),
                        ten_cot_sqd                    VARCHAR2(20),
                        ten_cot_nqd                    VARCHAR2(20))'
                                                                     );

        sql_text :=
            'INSERT INTO ext_qct_dm_gdich_qdinh@qlt SELECT * FROM tb_qct_dm_gdich_qdinh';

        EXECUTE IMMEDIATE sql_text;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'),
                                          pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_no
    Noi dung: Don dep bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_qlt_no
    IS
        c_name_drop    CONSTANT VARCHAR2 (20) := 'EXT_QLT_NO';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;

        c_name_drop1   CONSTANT VARCHAR2 (30) := 'EXT_QLT_NO_THANH_TOAN';

        CURSOR c1
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop1;

        c_name_drop2   CONSTANT VARCHAR2 (30) := 'EXT_QLT_TC_NO';

        CURSOR c2
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop2;

        c_name_drop3   CONSTANT VARCHAR2 (30) := 'EXT_QTN_SO_NO';

        CURSOR c3
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop3;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;

        FOR v IN c1
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop1);
        END LOOP;

        FOR v IN c2
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop2);
        END LOOP;

        FOR v IN c3
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop3);
        END LOOP;
    END;

    /***************************************************************************

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_no
    Noi dung: Don dep bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_qct_no
    IS
        c_name_drop    CONSTANT VARCHAR2 (20) := 'EXT_QCT_NO';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;

        c_name_drop1   CONSTANT VARCHAR2 (30) := 'EXT_QCT_NO_THANH_TOAN';

        CURSOR c1
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop1;

        c_name_drop2   CONSTANT VARCHAR2 (30) := 'EXT_QCT_TC_NO';

        CURSOR c2
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop2;

        c_name_drop3   CONSTANT VARCHAR2 (30) := 'EXT_QTN_SO_NO_QCT';

        CURSOR c3
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop3;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;

        FOR v IN c1
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop1);
        END LOOP;

        FOR v IN c2
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop2);
        END LOOP;

        FOR v IN c3
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop3);
        END LOOP;
    END;


    PROCEDURE Prc_Ddep_tb_ext_dm_gdich_qlt
    IS
        c_name_drop   CONSTANT VARCHAR2 (30) := 'EXT_QLT_DM_GDICH_QDINH';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

    PROCEDURE Prc_Ddep_tb_ext_dm_gdich_qct
    IS
        c_name_drop   CONSTANT VARCHAR2 (30) := 'EXT_QCT_DM_GDICH_QDINH';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Pck_Qlt_XL_NO
    Noi dung: Khoi tao Prc_Ktao_Pck_Qlt_XL_NO cho QLT.
              Package nay nham muc dich xu ly cac khoan no truoc khi tong hop du lieu no
              Do xu ly du lieu no dai nen tach ra cho de quan ly
    Nguoi thuc hien: DuBV
    Ngay thuc hien: 11/04/2013
    ***************************************************************************/
    PROCEDURE prc_ktao_pck_qlt_xl_no
    IS
    BEGIN
        prc_remote_sql('
        CREATE OR REPLACE
        PACKAGE EXT_PCK_Qlt_XL_NO IS
            PROCEDURE Prc_Qlt_No(p_ky_no Date);
        END;'
             );

        prc_remote_sql('
CREATE OR REPLACE
PACKAGE BODY EXT_PCK_Qlt_XL_NO
IS
    PROCEDURE Prc_Qlt_No(p_ky_no DATE) IS

        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;

        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma, hoac lay het (NULL)

        PROCEDURE Prc_THop_No_Thue(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , PNOP.TKHOAN               TKHOAN
                        , DTNT.MA_CHUONG            MA_CHUONG
                        , DTNT.MA_KHOAN             MA_KHOAN
                        , MA_MUC                    MA_MUC
                        , MA_TMUC                   MA_TMUC
                        , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                        , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                        , KYLB_TU_NGAY              KYLB_TU_NGAY
                        , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                        , KYKK_TU_NGAY              KYKK_TU_NGAY
                        , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                        , MA_THUE                   MA_THUE
                        , NO_DAU_KY                 NO_DAU_KY
                        , PHAI_NOP                  PHAI_NOP
                        , HAN_NOP                   HAN_NOP
                        , KYTP_TU_NGAY              KYTP_TU_NGAY
                        , MA_GDICH                  MA_GDICH
                        , KIEU_GDICH                KIEU_GDICH
                        , TEN_GDICH                 TEN_GDICH
                        , CHK_KNO                   CHK_KNO
                        , QDINH_ID                  QDINH_ID
                        , Loai_Qdinh                Loai_Qdinh
                FROM(
                        SELECT  ST.TIN                  TIN
                                , ST.HDR_ID             HDR_ID
                                , ST.DTL_ID             DTL_ID
                                , Max(ST.KYTT_TU_NGAY)       KY_TTOAN_TU_NGAY
                                , Max(ST.KYTT_DEN_NGAY)      KY_TTOAN_DEN_NGAY
                                , Max(ST.KYLB_TU_NGAY)       KYLB_TU_NGAY
                                , Max(ST.KYLB_DEN_NGAY)      KYLB_DEN_NGAY
                                , ST.KYKK_TU_NGAY       KYKK_TU_NGAY
                                , ST.KYKK_DEN_NGAY      KYKK_DEN_NGAY
                                , ST.TMT_MA_MUC         MA_MUC
                                , ST.TMT_MA_TMUC        MA_TMUC
                                , ST.TMT_MA_THUE        MA_THUE
                                , ST.TKHOAN             TKHOAN
                                , Sum(Decode(CHECK_KNO,''1'',NO_CUOI_KY,0))    NO_DAU_KY
                                , Sum(ST.NO_CUOI_KY)         PHAI_NOP
                                , St.han_nop            HAN_NOP
                                , Max(Decode(CHECK_KNO,''1'', Trunc(p_den_ky,''Month'')-1,ST.HAN_NOP))    KYTP_TU_NGAY
                                , ST.DGD_MA_GDICH       MA_GDICH
                                , ST.DGD_KIEU_GDICH     KIEU_GDICH
                                , (''XLTK_GDICH'')        TEN_GDICH
                                , Max(Nvl(ST.CHECK_KNO,''0'')) CHK_KNO
                                , Max(QDINH_ID)         QDINH_ID
                                , Max(Loai_Qdinh)       Loai_Qdinh
                        FROM    QLT_SO_NO  ST
                        WHERE   ST.KYNO_TU_NGAY = Trunc(p_den_ky,''Month'')
                                AND (Tmt_Ma_Muc <> ''1000'' AND Tmt_Ma_Tmuc <> ''4268'')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.kykk_tu_ngay,st.kykk_den_ngay,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.dgd_ma_gdich,st.dgd_kieu_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, PNOP.TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;

            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT Ten
                FROM  QLT_DM_GDICH DM
                WHERE DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),''NULL'')    =   ''XLTK_GDICH''
                UNION ALL
                SELECT trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM Dual
                WHERE NVL(trim(pc_Ten_GDich),''NULL'')    <>  ''XLTK_GDICH'';

            TYPE tab_phai_nop IS TABLE OF c_phai_nop%ROWTYPE INDEX BY BINARY_INTEGER;
            vt_PN tab_PHAI_NOP;
            i NUMBER;
            j NUMBER;
            k NUMBER;
            l NUMBER;
            v_kno_num           NUMBER;
            v_kno_first_index   NUMBER;
            v_kno_index         NUMBER;
            v_last_tin VARCHAR2(14):=''HHHHHHHHHHHHHH'';
            v_last_tkhoan   VARCHAR2(20):=''HHHHHHHHHHHHHHHHHHHH'';
            v_last_muc      VARCHAR2(4):=''HHH'';
            v_last_tmuc     VARCHAR2(4):=''HH'';
            v_ten_gdich     VARCHAR2(100);
            v_Temp  VARCHAR2(10);

            /*Thu tuc thuc hien qua trinh thanh toan doi voi 1 tap du lieu TIN-TKHOAN-MUC-TMUC
            Nguoi tao:  HoangNL
            Ngay tao:   02/11/2006
            Muc dich:   + Thuc hien thanh toan tren mang du lieu vt_PN(i) (i=1..k):
            */
            PROCEDURE PRC_THANH_TOAN IS
                v_No_Dky NUMBER;
            BEGIN
                -- So luong phan tu mang vt_PN, lay chi so khoan no dau tien
                v_kno_num:=k;
                v_kno_first_index:=v_kno_num+1;
                i:=1;
                WHILE (i<=v_kno_num) LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN
                        v_kno_first_index:=i;
                        EXIT;
                    END IF;
                    i:=i+1;
                END LOOP;

                -- Duyet cac khoan dieu chinh de tim giao dich dac biet
                FOR i IN 1..v_kno_first_index-1 LOOP
                    --  Tim thay giao dich dac biet
                    IF (vt_PN(i).ma_gdich IN (''H7'',''H5'',''78'',''B4'')) THEN
                        -- Duyet cac khoan phai nop de tim giao dich can dieu chinh tuong ung
                        j :=v_kno_first_index;
                        WHILE (j<=v_kno_num) AND (vt_PN(i).phai_nop <0)LOOP
                            IF  (   vt_PN(j).phai_nop>0
                                AND (((  (vt_PN(i).ma_gdich=''H7'' AND vt_PN(j).ma_gdich=''24'')
                                    OR  (vt_PN(i).ma_gdich=''H5'' AND vt_PN(j).ma_gdich=''H1'')
                                    OR  (vt_PN(i).ma_gdich=''78'' AND vt_PN(j).ma_gdich IN(''04'',''16'')))
                                AND vt_PN(i).ky_ttoan_tu_ngay    =   vt_PN(j).ky_ttoan_tu_ngay
                                AND vt_PN(i).ky_ttoan_den_ngay   =   vt_PN(j).ky_ttoan_den_ngay)
                                OR  (vt_PN(i).ma_gdich=''B4'' AND vt_PN(j).ma_gdich=''I3''))) THEN

                                IF  vt_PN(i).Han_Nop>vt_PN(j).kytp_tu_ngay  THEN
                                    vt_PN(j).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(j).CHK_KNO:=''1'';
                                END IF;

                                IF abs(vt_PN(i).phai_nop)>vt_pn(j).phai_nop THEN
                                    vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(j).phai_nop;
                                    vt_PN(j).phai_nop:=0;
                                ELSE
                                    vt_PN(j).phai_nop:=vt_PN(j).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop:=0;
                                END IF;
                            END IF;
                            j:=j+1;
                        END LOOP;
                    END IF;
                END LOOP;
                --Thanh toan theo ky va theo han nop xa nhat
                IF(v_kno_first_index<=v_kno_num)THEN
                    i:=1;
                    v_kno_index := v_kno_first_index;
                    WHILE (i<v_kno_first_index) LOOP
                        -- Thanh toan cac khoan co cung nguon goc hoac chung tu co chi ro quyet dinh
                        l := v_kno_index;
                        WHILE l <= v_kno_num LOOP
                            IF vt_PN(l).Phai_Nop > 0
                                AND ((vt_PN(l).Hdr_Id = vt_PN(i).Hdr_Id AND vt_PN(l).Dtl_Id = vt_PN(i).Dtl_Id)
                                OR (vt_PN(i).Qdinh_Id = vt_PN(l).Hdr_Id AND Qlt_Pck_Thop_No_Thue.Fnc_Ttoan(vt_PN(i).Ma_Gdich,vt_Pn(l).Ma_Gdich,vt_Pn(i).Loai_Qdinh))
                                OR (vt_PN(i).Loai_Qdinh = vt_PN(l).Loai_Qdinh AND vt_PN(i).Qdinh_Id = vt_PN(l).Qdinh_Id)
                                ) THEN
                                        IF vt_PN(i).Han_Nop > vt_PN(l).KyTp_Tu_Ngay THEN
                                            vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                            vt_PN(l).CHK_KNO:=''1'';
                                        END IF;

                                IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                   vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                   vt_PN(i).phai_nop:=0;
                                   EXIT;
                                ELSE
                                   vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                   vt_PN(l).phai_nop:=0;
                                   l:=l+1;
                                END IF;
                            ELSE
                                l:=l+1;
                            END IF;
                        END LOOP;
                        --Thanh toan theo ky
                        IF(vt_PN(i).Ky_ttoan_tu_ngay IS NOT NULL) THEN
                            l:=v_kno_index;
                            WHILE (l<=v_kno_num) LOOP
                                IF (vt_PN(l).phai_nop>0 AND vt_PN(i).Ma_Gdich <> ''B4'' AND vt_PN(l).Ma_Gdich <> ''I3'')
                                    AND vt_PN(i).ky_ttoan_tu_ngay<=vt_PN(l).ky_ttoan_tu_ngay
                                    AND vt_PN(i).ky_ttoan_den_ngay>=vt_PN(l).ky_ttoan_den_ngay
                                THEN
                                    --Neu khoan phai nop duoc thanh toan qua han==>tinh phat ncham
                                    IF vt_PN(i).Han_Nop>vt_PN(l).kytp_tu_ngay THEN
                                        vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                        vt_PN(l).CHK_KNO:=''1'';
                                    END IF;

                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
                                       EXIT;
                                    ELSE
                                       vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                       vt_PN(l).phai_nop:=0;
                                       l:=l+1;
                                    END IF;
                                ELSE
                                    l:=l+1;
                                END IF;
                            END LOOP;
                        END IF;

                        --Thuc hien ttoan doi voi khoan da nop vt_PN(i)
                        WHILE (vt_PN(i).Phai_nop<0 AND vt_Pn(i).Ma_Gdich NOT IN(''B4'')) LOOP
                            --Duyet cac khoan phai nop: (Bat dau tu khoan con phai nop dau tien)
                            --Neu khoan phai nop van chua ttoan het
                            IF  (vt_PN(v_kno_index).Phai_nop>0 AND vt_Pn(v_kno_index).Ma_Gdich NOT IN(''I3''))THEN
                                --So sanh han nop, tinh phat ncham
                                IF vt_PN(i).Han_Nop>vt_PN(v_kno_index).kytp_tu_ngay THEN
                                    vt_PN(v_kno_index).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(v_kno_index).CHK_KNO:=''1'';
                                END IF;
                                --Thanh toan
                                IF abs(vt_PN(i).phai_nop) >= vt_pn(v_kno_index).phai_nop THEN
                                    vt_PN(i).phai_nop :=vt_PN(i).phai_nop+vt_PN(v_kno_index).phai_nop;
                                    vt_PN(v_kno_index).phai_nop   :=0;
                                    --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                    v_kno_index := v_kno_index+1;
                                ELSE
                                    vt_PN(v_kno_index).phai_nop :=vt_PN(v_kno_index).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop := 0;
                                END IF;
                            ELSE
                                --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                v_kno_index := v_kno_index+1;
                            END IF;
                            EXIT WHEN (v_kno_index>v_kno_num);
                        END LOOP;
                        EXIT WHEN (v_kno_index > v_kno_num);
                        i:=i+1;
                    END LOOP;
                END IF;

                -- Thanh toan xong dua du lieu vao bang so no
                FOR i IN 1 .. v_kno_num LOOP
                    v_ten_gdich:=NULL;
                    IF vt_Pn(i).Phai_Nop >= 0 AND vt_Pn(i).Han_Nop <= Last_Day(p_den_ky) THEN
                        v_No_Dky := vt_Pn(i).No_Dau_Ky;
                    END IF;
                    FOR vc_DM_GDich IN c_DM_GDich(  vt_PN(i).ma_gdich
                                                    ,vt_PN(i).kieu_gdich
                                                    ,vt_PN(i).Ten_GDich)LOOP
                        v_ten_gdich :=  vc_DM_GDich.TEN;
                    END LOOP;
                    v_Nguon_Goc := QLT_PCK_GDICH.Fnc_Lay_Nguon_Goc_So_Lieu(
                                                    vt_pn(i).MA_GDICH
                                                    , v_Ten_GDich
                                                    , Nvl(vt_pn(i).KYKK_TU_NGAY, vt_pn(i).KYLB_TU_NGAY)
                                                    , Nvl(vt_pn(i).KYKK_DEN_NGAY, vt_pn(i).KYLB_DEN_NGAY)
                                                    , vt_pn(i).KYLB_DEN_NGAY
                                                    , ''QLT_XLTK_GDICH''
                                                    , vt_pn(i).HAN_NOP);

                    INSERT INTO EXT_QLT_NO_THANH_TOAN (
                                              TIN
                                            , HDR_ID
                                            , DTL_ID
                                            , TKHOAN
                                            , MA_CHUONG
                                            , MA_KHOAN
                                            , MA_MUC
                                            , MA_TMUC
                                            , KY_TTOAN_TU_NGAY
                                            , KY_TTOAN_DEN_NGAY
                                            , KYLB_TU_NGAY
                                            , KYLB_DEN_NGAY
                                            , KYKK_TU_NGAY
                                            , KYKK_DEN_NGAY
                                            , MA_THUE
                                            , NO_DAU_KY
                                            , PHAI_NOP
                                            , HAN_NOP
                                            , KYTP_TU_NGAY
                                            , MA_GDICH
                                            , KIEU_GDICH
                                            , TEN_GDICH
                                            , CHK_KNO
                                            , QDINH_ID
                                            , Loai_Qdinh
                                            , Nguon_Goc
                                            , id
                                            )
                                    VALUES  (
                                              vt_PN(i).TIN
                                            , vt_PN(i).HDR_ID
                                            , vt_PN(i).DTL_ID
                                            , vt_PN(i).TKHOAN
                                            , vt_PN(i).MA_CHUONG
                                            , vt_PN(i).MA_KHOAN
                                            , vt_PN(i).MA_MUC
                                            , vt_PN(i).MA_TMUC
                                            , vt_PN(i).KY_TTOAN_TU_NGAY
                                            , vt_PN(i).KY_TTOAN_DEN_NGAY
                                            , vt_PN(i).KYLB_TU_NGAY
                                            , vt_PN(i).KYLB_DEN_NGAY
                                            , vt_PN(i).KYKK_TU_NGAY
                                            , vt_PN(i).KYKK_DEN_NGAY
                                            , vt_PN(i).MA_THUE
                                            , vt_PN(i).NO_DAU_KY
                                            , vt_PN(i).PHAI_NOP
                                            , vt_PN(i).HAN_NOP
                                            , vt_PN(i).KYTP_TU_NGAY
                                            , vt_PN(i).MA_GDICH
                                            , vt_PN(i).KIEU_GDICH
                                            , vt_PN(i).TEN_GDICH
                                            , vt_PN(i).CHK_KNO
                                            , vt_PN(i).QDINH_ID
                                            , vt_PN(i).Loai_Qdinh
                                            , v_Nguon_Goc
                                            , ext_seq.NEXTVAL
                                            );
                END LOOP;
            END;--End Prc_Thanh_Toan
        BEGIN
            --Khoi tao gia tri bien dem so luong phan tu mang vt_PN(i)
            k:=0;
            FOR v_dtnt IN c_PHAI_NOP LOOP
                --Neu gap tap du lieu moi, thuc hien thanh toan tren tap du lieu da cap nhat vao mang
                IF    (v_last_tin<>''HHHHHHHHHHHHHH'')
                    AND (k > 0)
                    AND (   (v_dtnt.tin     <>  v_last_tin)
                                                    OR  (v_dtnt.tkhoan  <>  v_last_tkhoan)
                                                    OR  (v_dtnt.ma_muc  <>  v_last_muc)
                                                    OR  (v_dtnt.ma_tmuc <>  v_last_tmuc)
                                                    )THEN
                    --Thuc hien ttoan,tinh phat ncham, cap nhat du lieu so no
                    PRC_THANH_TOAN;
                    k:=0;
                END IF;
                -- Gan vao mang
                k := k+1;
                vt_PN(k) := v_dtnt;
                -- Cap nhat cac gia tri kiem tra v_last_TIN, v_Last_Ma_Muc,...
                v_last_tin := v_dtnt.tin;
                v_last_tkhoan := v_dtnt.tkhoan;
                v_last_muc := v_dtnt.ma_muc;
                v_last_tmuc := v_dtnt.ma_tmuc;
            END LOOP; -- danop

            --Thuc hien thanh toan tren tap du lieu cuoi cung trong con tro c_Phai_Nop
            IF(k>0)THEN
                PRC_THANH_TOAN;
            END IF;
        END;
    BEGIN
        Prc_THop_No_Thue(p_ky_no);
    END;
END;
    '
     );

        prc_remote_sql('
        CREATE OR REPLACE
        PACKAGE EXT_PCK_QLT_XL_NO_NTE IS
            PROCEDURE Prc_Qlt_No_NTE(p_ky_no Date);
        END;'
             );

        prc_remote_sql('

CREATE OR REPLACE
PACKAGE BODY EXT_PCK_QLT_XL_NO_NTE
IS
    /* Thu tuc lay du lieu va thanh toan no ngoai te */
    PROCEDURE Prc_Qlt_No_NTE(p_ky_no DATE) IS

        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;

        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma, hoac lay het (NULL)

        PROCEDURE Prc_THop_No_Thue(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , PNOP.TKHOAN               TKHOAN
                        , DTNT.MA_CHUONG            MA_CHUONG
                        , DTNT.MA_KHOAN             MA_KHOAN
                        , MA_MUC                    MA_MUC
                        , MA_TMUC                   MA_TMUC
                        , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                        , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                        , KYLB_TU_NGAY              KYLB_TU_NGAY
                        , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                        , KYKK_TU_NGAY              KYKK_TU_NGAY
                        , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                        , MA_THUE                   MA_THUE
                        , NO_DAU_KY                 NO_DAU_KY
                        , PHAI_NOP                  PHAI_NOP
                        , HAN_NOP                   HAN_NOP
                        , KYTP_TU_NGAY              KYTP_TU_NGAY
                        , MA_GDICH                  MA_GDICH
                        , KIEU_GDICH                KIEU_GDICH
                        , TEN_GDICH                 TEN_GDICH
                        , CHK_KNO                   CHK_KNO
                        , QDINH_ID                  QDINH_ID
                        , Loai_Qdinh                Loai_Qdinh
                        , DON_VI_TIEN               DON_VI_TIEN
                FROM(
                        SELECT  ST.TIN                  TIN
                                , ST.HDR_ID             HDR_ID
                                , ST.DTL_ID             DTL_ID
                                , Max(ST.KYTT_TU_NGAY)       KY_TTOAN_TU_NGAY
                                , Max(ST.KYTT_DEN_NGAY)      KY_TTOAN_DEN_NGAY
                                , Max(ST.KYLB_TU_NGAY)       KYLB_TU_NGAY
                                , Max(ST.KYLB_DEN_NGAY)      KYLB_DEN_NGAY
                                , ST.KYKK_TU_NGAY       KYKK_TU_NGAY
                                , ST.KYKK_DEN_NGAY      KYKK_DEN_NGAY
                                , ST.TMT_MA_MUC         MA_MUC
                                , ST.TMT_MA_TMUC        MA_TMUC
                                , ST.TMT_MA_THUE        MA_THUE
                                , ST.TKHOAN             TKHOAN
                                , Sum(Decode(CHECK_KNO,''1'',NO_CUOI_KY,0))    NO_DAU_KY
                                , Sum(ST.NO_CUOI_KY)         PHAI_NOP
                                , St.han_nop            HAN_NOP
                                , Max(Decode(CHECK_KNO,''1'', Trunc(p_den_ky,''Month'')-1,ST.HAN_NOP))    KYTP_TU_NGAY
                                , ST.DGD_MA_GDICH       MA_GDICH
                                , ST.DGD_KIEU_GDICH     KIEU_GDICH
                                , (''XLTK_GDICH'')        TEN_GDICH
                                , Max(Nvl(ST.CHECK_KNO,''0'')) CHK_KNO
                                , Max(QDINH_ID)         QDINH_ID
                                , Max(Loai_Qdinh)       Loai_Qdinh
                                , Max(DON_VI_TIEN)      DON_VI_TIEN
                        FROM    QLT_SO_NO_NTE  ST
                        WHERE   ST.KYNO_TU_NGAY = Trunc(p_den_ky,''Month'')
                                AND (Tmt_Ma_Muc <> ''1000'' AND Tmt_Ma_Tmuc <> ''4268'')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.kykk_tu_ngay,st.kykk_den_ngay,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.dgd_ma_gdich,st.dgd_kieu_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop, ST.DON_VI_TIEN
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, PNOP.TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , DON_VI_TIEN
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;

            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT Ten
                FROM  QLT_DM_GDICH DM
                WHERE DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),''NULL'')    =   ''XLTK_GDICH''
                UNION ALL
                SELECT trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM Dual
                WHERE NVL(trim(pc_Ten_GDich),''NULL'')    <>  ''XLTK_GDICH'';

           TYPE tab_phai_nop IS TABLE OF c_phai_nop%ROWTYPE INDEX BY BINARY_INTEGER;
            vt_PN tab_PHAI_NOP;
            i NUMBER;
            j NUMBER;
            k NUMBER;
            l NUMBER;
            v_kno_num           NUMBER;
            v_kno_first_index   NUMBER;
            v_kno_index         NUMBER;
            v_last_tin VARCHAR2(14):=''HHHHHHHHHHHHHH'';
            v_last_tkhoan   VARCHAR2(20):=''HHHHHHHHHHHHHHHHHHHH'';
            v_last_muc      VARCHAR2(4):=''HHH'';
            v_last_tmuc     VARCHAR2(4):=''HH'';
            v_last_dvt      VARCHAR2(5):=''HHHHH'';
            v_ten_gdich     VARCHAR2(100);
            v_Temp  VARCHAR2(10);

            /*Thu tuc thuc hien qua trinh thanh toan doi voi 1 tap du lieu TIN-TKHOAN-MUC-TMUC
            Nguoi tao:  HoangNL
            Ngay tao:   02/11/2006
            Muc dich:   + Thuc hien thanh toan tren mang du lieu vt_PN(i) (i=1..k):
            */
            PROCEDURE PRC_THANH_TOAN IS
                v_No_Dky NUMBER;
            BEGIN
                -- So luong phan tu mang vt_PN, lay chi so khoan no dau tien
                v_kno_num:=k;
                v_kno_first_index:=v_kno_num+1;
                i:=1;
                WHILE (i<=v_kno_num) LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN
                        v_kno_first_index:=i;
                        EXIT;
                    END IF;
                    i:=i+1;
                END LOOP;

                -- Duyet cac khoan dieu chinh de tim giao dich dac biet
                FOR i IN 1..v_kno_first_index-1 LOOP
                    --  Tim thay giao dich dac biet
                    IF (vt_PN(i).ma_gdich IN (''H7'',''H5'',''78'',''B4'')) THEN
                        -- Duyet cac khoan phai nop de tim giao dich can dieu chinh tuong ung
                        j :=v_kno_first_index;
                        WHILE (j<=v_kno_num) AND (vt_PN(i).phai_nop <0)LOOP
                            IF  (   vt_PN(j).phai_nop>0
                                AND (((  (vt_PN(i).ma_gdich=''H7'' AND vt_PN(j).ma_gdich=''24'')
                                    OR  (vt_PN(i).ma_gdich=''H5'' AND vt_PN(j).ma_gdich=''H1'')
                                    OR  (vt_PN(i).ma_gdich=''78'' AND vt_PN(j).ma_gdich IN(''04'',''16'')))
                                AND vt_PN(i).ky_ttoan_tu_ngay    =   vt_PN(j).ky_ttoan_tu_ngay
                                AND vt_PN(i).ky_ttoan_den_ngay   =   vt_PN(j).ky_ttoan_den_ngay)
                                OR  (vt_PN(i).ma_gdich=''B4'' AND vt_PN(j).ma_gdich=''I3''))) THEN

                                IF  vt_PN(i).Han_Nop>vt_PN(j).kytp_tu_ngay  THEN
                                    vt_PN(j).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(j).CHK_KNO:=''1'';
                                END IF;

                                IF abs(vt_PN(i).phai_nop)>vt_pn(j).phai_nop THEN
                                    vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(j).phai_nop;
                                    vt_PN(j).phai_nop:=0;
                                ELSE
                                    vt_PN(j).phai_nop:=vt_PN(j).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop:=0;
                                END IF;
                            END IF;
                            j:=j+1;
                        END LOOP;
                    END IF;
                END LOOP;
                --Thanh toan theo ky va theo han nop xa nhat
                IF(v_kno_first_index<=v_kno_num)THEN
                    i:=1;
                    v_kno_index := v_kno_first_index;
                    WHILE (i<v_kno_first_index) LOOP
                        -- Thanh toan cac khoan co cung nguon goc hoac chung tu co chi ro quyet dinh
                        l := v_kno_index;
                        WHILE l <= v_kno_num LOOP
                            IF vt_PN(l).Phai_Nop > 0
                                AND ((vt_PN(l).Hdr_Id = vt_PN(i).Hdr_Id AND vt_PN(l).Dtl_Id = vt_PN(i).Dtl_Id)
                                OR (vt_PN(i).Qdinh_Id = vt_PN(l).Hdr_Id AND Qlt_Pck_Thop_No_Thue.Fnc_Ttoan(vt_PN(i).Ma_Gdich,vt_Pn(l).Ma_Gdich,vt_Pn(i).Loai_Qdinh))
                                OR (vt_PN(i).Loai_Qdinh = vt_PN(l).Loai_Qdinh AND vt_PN(i).Qdinh_Id = vt_PN(l).Qdinh_Id)
                                ) THEN
                                        IF vt_PN(i).Han_Nop > vt_PN(l).KyTp_Tu_Ngay THEN
                                            vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                            vt_PN(l).CHK_KNO:=''1'';
                                        END IF;

                                IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                   vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                   vt_PN(i).phai_nop:=0;
                                   EXIT;
                                ELSE
                                   vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                   vt_PN(l).phai_nop:=0;
                                   l:=l+1;
                                END IF;
                            ELSE
                                l:=l+1;
                            END IF;
                        END LOOP;
                        --Thanh toan theo ky
                        IF(vt_PN(i).Ky_ttoan_tu_ngay IS NOT NULL) THEN
                            l:=v_kno_index;
                            WHILE (l<=v_kno_num) LOOP
                                IF (vt_PN(l).phai_nop>0 AND vt_PN(i).Ma_Gdich <> ''B4'' AND vt_PN(l).Ma_Gdich <> ''I3'')
                                    AND vt_PN(i).ky_ttoan_tu_ngay<=vt_PN(l).ky_ttoan_tu_ngay
                                    AND vt_PN(i).ky_ttoan_den_ngay>=vt_PN(l).ky_ttoan_den_ngay
                                THEN
                                    --Neu khoan phai nop duoc thanh toan qua han==>tinh phat ncham
                                    IF vt_PN(i).Han_Nop>vt_PN(l).kytp_tu_ngay THEN
                                        vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                        vt_PN(l).CHK_KNO:=''1'';
                                    END IF;

                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
                                       EXIT;
                                    ELSE
                                       vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                       vt_PN(l).phai_nop:=0;
                                       l:=l+1;
                                    END IF;
                                ELSE
                                    l:=l+1;
                                END IF;
                            END LOOP;
                        END IF;

                        --Thuc hien ttoan doi voi khoan da nop vt_PN(i)
                        WHILE (vt_PN(i).Phai_nop<0 AND vt_Pn(i).Ma_Gdich NOT IN(''B4'')) LOOP
                            --Duyet cac khoan phai nop: (Bat dau tu khoan con phai nop dau tien)
                            --Neu khoan phai nop van chua ttoan het
                            IF  (vt_PN(v_kno_index).Phai_nop>0 AND vt_Pn(v_kno_index).Ma_Gdich NOT IN(''I3''))THEN
                                --So sanh han nop, tinh phat ncham
                                IF vt_PN(i).Han_Nop>vt_PN(v_kno_index).kytp_tu_ngay THEN
                                    vt_PN(v_kno_index).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(v_kno_index).CHK_KNO:=''1'';
                                END IF;
                                --Thanh toan
                                IF abs(vt_PN(i).phai_nop) >= vt_pn(v_kno_index).phai_nop THEN
                                    vt_PN(i).phai_nop :=vt_PN(i).phai_nop+vt_PN(v_kno_index).phai_nop;
                                    vt_PN(v_kno_index).phai_nop   :=0;
                                    --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                    v_kno_index := v_kno_index+1;
                                ELSE
                                    vt_PN(v_kno_index).phai_nop :=vt_PN(v_kno_index).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop := 0;
                                END IF;
                            ELSE
                                --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                v_kno_index := v_kno_index+1;
                            END IF;
                            EXIT WHEN (v_kno_index>v_kno_num);
                        END LOOP;
                        EXIT WHEN (v_kno_index > v_kno_num);
                        i:=i+1;
                    END LOOP;
                END IF;

                -- Thanh toan xong dua du lieu vao bang so no
                FOR i IN 1 .. v_kno_num LOOP
                    v_ten_gdich:=NULL;
                    IF vt_Pn(i).Phai_Nop >= 0 AND vt_Pn(i).Han_Nop <= Last_Day(p_den_ky) THEN
                        v_No_Dky := vt_Pn(i).No_Dau_Ky;
                    END IF;
                    FOR vc_DM_GDich IN c_DM_GDich(  vt_PN(i).ma_gdich
                                                    ,vt_PN(i).kieu_gdich
                                                    ,vt_PN(i).Ten_GDich)LOOP
                        v_ten_gdich :=  vc_DM_GDich.TEN;
                    END LOOP;
                    v_Nguon_Goc := QLT_PCK_GDICH.Fnc_Lay_Nguon_Goc_So_Lieu(
                                                    vt_pn(i).MA_GDICH
                                                    , v_Ten_GDich
                                                    , Nvl(vt_pn(i).KYKK_TU_NGAY, vt_pn(i).KYLB_TU_NGAY)
                                                    , Nvl(vt_pn(i).KYKK_DEN_NGAY, vt_pn(i).KYLB_DEN_NGAY)
                                                    , vt_pn(i).KYLB_DEN_NGAY
                                                    , ''QLT_XLTK_GDICH''
                                                    , vt_pn(i).HAN_NOP);

                    INSERT INTO EXT_QLT_NO_THANH_TOAN (
                                              TIN
                                            , HDR_ID
                                            , DTL_ID
                                            , TKHOAN
                                            , MA_CHUONG
                                            , MA_KHOAN
                                            , MA_MUC
                                            , MA_TMUC
                                            , KY_TTOAN_TU_NGAY
                                            , KY_TTOAN_DEN_NGAY
                                            , KYLB_TU_NGAY
                                            , KYLB_DEN_NGAY
                                            , KYKK_TU_NGAY
                                            , KYKK_DEN_NGAY
                                            , MA_THUE
                                            , NO_DAU_KY
                                            , PHAI_NOP
                                            , HAN_NOP
                                            , KYTP_TU_NGAY
                                            , MA_GDICH
                                            , KIEU_GDICH
                                            , TEN_GDICH
                                            , CHK_KNO
                                            , QDINH_ID
                                            , Loai_Qdinh
                                            , Nguon_Goc
                                            , NO_NTE
                                            , DON_VI_TIEN
                                            , id
                                            )
                                    VALUES  (
                                              vt_PN(i).TIN
                                            , vt_PN(i).HDR_ID
                                            , vt_PN(i).DTL_ID
                                            , vt_PN(i).TKHOAN
                                            , vt_PN(i).MA_CHUONG
                                            , vt_PN(i).MA_KHOAN
                                            , vt_PN(i).MA_MUC
                                            , vt_PN(i).MA_TMUC
                                            , vt_PN(i).KY_TTOAN_TU_NGAY
                                            , vt_PN(i).KY_TTOAN_DEN_NGAY
                                            , vt_PN(i).KYLB_TU_NGAY
                                            , vt_PN(i).KYLB_DEN_NGAY
                                            , vt_PN(i).KYKK_TU_NGAY
                                            , vt_PN(i).KYKK_DEN_NGAY
                                            , vt_PN(i).MA_THUE
                                            , vt_PN(i).NO_DAU_KY
                                            , vt_PN(i).PHAI_NOP
                                            , vt_PN(i).HAN_NOP
                                            , vt_PN(i).KYTP_TU_NGAY
                                            , vt_PN(i).MA_GDICH
                                            , vt_PN(i).KIEU_GDICH
                                            , vt_PN(i).TEN_GDICH
                                            , vt_PN(i).CHK_KNO
                                            , vt_PN(i).QDINH_ID
                                            , vt_PN(i).Loai_Qdinh
                                            , v_Nguon_Goc
                                            , ''Y''
                                            , vt_PN(i).DON_VI_TIEN
                                            , ext_seq.NEXTVAL
                                            );
                END LOOP;
            END;--End Prc_Thanh_Toan

        BEGIN

            --Khoi tao gia tri bien dem so luong phan tu mang vt_PN(i)
            k:=0;
            FOR v_dtnt IN c_PHAI_NOP LOOP
                --Neu gap tap du lieu moi, thuc hien thanh toan tren tap du lieu da cap nhat vao mang
                IF    (v_last_tin<>''HHHHHHHHHHHHHH'')
                    AND (k > 0)
                    AND (   (v_dtnt.tin     <>  v_last_tin)
                                                    OR  (v_dtnt.tkhoan  <>  v_last_tkhoan)
                                                    OR  (v_dtnt.ma_muc  <>  v_last_muc)
                                                    OR  (v_dtnt.ma_tmuc <>  v_last_tmuc)
                                                    OR  (v_dtnt.DON_VI_TIEN <>  v_last_dvt)
                                                    )THEN
                    --Thuc hien ttoan,tinh phat ncham, cap nhat du lieu so no
                    PRC_THANH_TOAN;
                    k:=0;
                END IF;
                -- Gan vao mang
                k := k+1;
                vt_PN(k) := v_dtnt;
                -- Cap nhat cac gia tri kiem tra v_last_TIN, v_Last_Ma_Muc,...
                v_last_tin := v_dtnt.tin;
                v_last_tkhoan := v_dtnt.tkhoan;
                v_last_muc := v_dtnt.ma_muc;
                v_last_tmuc := v_dtnt.ma_tmuc;
                v_last_dvt := v_dtnt.DON_VI_TIEN;
            END LOOP; -- danop

            --Thuc hien thanh toan tren tap du lieu cuoi cung trong con tro c_Phai_Nop
            IF(k>0)THEN
                PRC_THANH_TOAN;
            END IF;
        END;
    BEGIN
        Prc_THop_No_Thue(p_ky_no);
    END;
END;

'
 );
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Pck_Qct_XL_NO
    Noi dung: Khoi tao Prc_Ktao_Pck_Qct_XL_NO cho QCT.
              Package nay nham muc dich xu ly cac khoan no truoc khi tong hop du lieu no
              Do xu ly du lieu no dai nen tach ra cho de quan ly
    Nguoi thuc hien: DuBV
    Ngay thuc hien: 11/04/2013
    ***************************************************************************/
    PROCEDURE prc_ktao_pck_qct_xl_no
    IS
    BEGIN
        prc_remote_sql('
    CREATE OR REPLACE
    PACKAGE EXT_PCK_Qct_XL_NO IS
        PROCEDURE Prc_Qct_No(p_ky_no Date);
    END;'
         );

        prc_remote_sql('
CREATE OR REPLACE
PACKAGE BODY EXT_PCK_Qct_XL_NO
IS
    PROCEDURE Prc_Qct_No(p_ky_no DATE) IS

        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;

        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma, hoac lay het (NULL)

        PROCEDURE Prc_THop_No_Thue(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , PNOP.TKHOAN               TKHOAN
                        , DTNT.MA_CHUONG            MA_CHUONG
                        , DTNT.MA_KHOAN             MA_KHOAN
                        , MA_MUC                    MA_MUC
                        , MA_TMUC                   MA_TMUC
                        , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                        , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                        , KYLB_TU_NGAY              KYLB_TU_NGAY
                        , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                        , KYKK_TU_NGAY              KYKK_TU_NGAY
                        , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                        , MA_THUE                   MA_THUE
                        , NO_DAU_KY                 NO_DAU_KY
                        , PHAI_NOP                  PHAI_NOP
                        , HAN_NOP                   HAN_NOP
                        , KYTP_TU_NGAY              KYTP_TU_NGAY
                        , MA_GDICH                  MA_GDICH
                        , KIEU_GDICH                KIEU_GDICH
                        , TEN_GDICH                 TEN_GDICH
                        , CHK_KNO                   CHK_KNO
                        , QDINH_ID                  QDINH_ID
                        , Loai_Qdinh                Loai_Qdinh
                FROM(
                        SELECT  ST.TIN                  TIN
                                , ST.HDR_ID             HDR_ID
                                , ST.DTL_ID             DTL_ID
                                , Max(ST.KY_TTOAN_TU_NGAY)       KY_TTOAN_TU_NGAY
                                , Max(ST.KY_TTOAN_DEN_NGAY)      KY_TTOAN_DEN_NGAY
                                , Max(ST.KYLB_TU_NGAY)       KYLB_TU_NGAY
                                , Max(ST.KYLB_DEN_NGAY)      KYLB_DEN_NGAY
                                , ST.KY_THUE_TU_NGAY       KYKK_TU_NGAY
                                , ST.KY_THUE_DEN_NGAY      KYKK_DEN_NGAY
                                , ST.TMT_MA_MUC         MA_MUC
                                , ST.TMT_MA_TMUC        MA_TMUC
                                , ST.TMT_MA_THUE        MA_THUE
                                , ST.TKHOAN             TKHOAN
                                , Sum(Decode(CHECK_KNO,''1'',NO_CUOI_KY,0))    NO_DAU_KY
                                , Sum(ST.NO_CUOI_KY)         PHAI_NOP
                                , St.han_nop            HAN_NOP
                                , Max(Decode(CHECK_KNO,''1'', Trunc(p_den_ky,''Month'')-1,ST.HAN_NOP))    KYTP_TU_NGAY
                                , ST.MA_GDICH       MA_GDICH
                                , '' ''     KIEU_GDICH
                                , (''XLTK_GDICH'')        TEN_GDICH
                                , Max(Nvl(ST.CHECK_KNO,''0'')) CHK_KNO
                                , Max(QDINH_ID)         QDINH_ID
                                , Max(Loai_Qdinh)       Loai_Qdinh
                        FROM    QCT_SO_NO  ST
                        WHERE   ST.KYNO_TU_NGAY = Trunc(p_den_ky,''Month'')
                                AND (Tmt_Ma_Muc <> ''1000'' AND Tmt_Ma_Tmuc <> ''4268'')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.KY_THUE_TU_NGAY,st.KY_THUE_DEN_NGAY,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.ma_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, PNOP.TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;

            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT Ten
                FROM  QCT_DM_GDICH DM
                WHERE DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),''NULL'')    =   ''XLTK_GDICH''
                UNION ALL
                SELECT trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM Dual
                WHERE NVL(trim(pc_Ten_GDich),''NULL'')    <>  ''XLTK_GDICH'';

            TYPE tab_phai_nop IS TABLE OF c_phai_nop%ROWTYPE INDEX BY BINARY_INTEGER;
            vt_PN tab_PHAI_NOP;
            i NUMBER;
            j NUMBER;
            k NUMBER;
            l NUMBER;
            v_kno_num           NUMBER;
            v_kno_first_index   NUMBER;
            v_kno_index         NUMBER;
            v_last_tin VARCHAR2(14):=''HHHHHHHHHHHHHH'';
            v_last_tkhoan   VARCHAR2(20):=''HHHHHHHHHHHHHHHHHHHH'';
            v_last_muc      VARCHAR2(4):=''HHH'';
            v_last_tmuc     VARCHAR2(4):=''HH'';
            v_ten_gdich     VARCHAR2(100);
            v_Temp  VARCHAR2(10);

            /*Thu tuc thuc hien qua trinh thanh toan doi voi 1 tap du lieu TIN-TKHOAN-MUC-TMUC
            Nguoi tao:  HoangNL
            Ngay tao:   02/11/2006
            Muc dich:   + Thuc hien thanh toan tren mang du lieu vt_PN(i) (i=1..k):
            */
            PROCEDURE PRC_THANH_TOAN IS
                v_No_Dky NUMBER;
            BEGIN
                -- So luong phan tu mang vt_PN, lay chi so khoan no dau tien
                v_kno_num:=k;
                v_kno_first_index:=v_kno_num+1;
                i:=1;
                WHILE (i<=v_kno_num) LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN
                        v_kno_first_index:=i;
                        EXIT;
                    END IF;
                    i:=i+1;
                END LOOP;

                -- Duyet cac khoan dieu chinh de tim giao dich dac biet
                FOR i IN 1..v_kno_first_index-1 LOOP
                    --  Tim thay giao dich dac biet
                    IF (vt_PN(i).ma_gdich IN (''H7'',''H5'',''78'',''B4'')) THEN
                        -- Duyet cac khoan phai nop de tim giao dich can dieu chinh tuong ung
                        j :=v_kno_first_index;
                        WHILE (j<=v_kno_num) AND (vt_PN(i).phai_nop <0)LOOP
                            IF  (   vt_PN(j).phai_nop>0
                                AND (((  (vt_PN(i).ma_gdich=''H7'' AND vt_PN(j).ma_gdich=''24'')
                                    OR  (vt_PN(i).ma_gdich=''H5'' AND vt_PN(j).ma_gdich=''H1'')
                                    OR  (vt_PN(i).ma_gdich=''78'' AND vt_PN(j).ma_gdich IN(''04'',''16'')))
                                AND vt_PN(i).ky_ttoan_tu_ngay    =   vt_PN(j).ky_ttoan_tu_ngay
                                AND vt_PN(i).ky_ttoan_den_ngay   =   vt_PN(j).ky_ttoan_den_ngay)
                                OR  (vt_PN(i).ma_gdich=''B4'' AND vt_PN(j).ma_gdich=''I3''))) THEN

                                IF  vt_PN(i).Han_Nop>vt_PN(j).kytp_tu_ngay  THEN
                                    vt_PN(j).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(j).CHK_KNO:=''1'';
                                END IF;

                                IF abs(vt_PN(i).phai_nop)>vt_pn(j).phai_nop THEN
                                    vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(j).phai_nop;
                                    vt_PN(j).phai_nop:=0;
                                ELSE
                                    vt_PN(j).phai_nop:=vt_PN(j).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop:=0;
                                END IF;
                            END IF;
                            j:=j+1;
                        END LOOP;
                    END IF;
                END LOOP;
                --Thanh toan theo ky va theo han nop xa nhat
                IF(v_kno_first_index<=v_kno_num)THEN
                    i:=1;
                    v_kno_index := v_kno_first_index;
                    WHILE (i<v_kno_first_index) LOOP
                        -- Thanh toan cac khoan co cung nguon goc hoac chung tu co chi ro quyet dinh
                        l := v_kno_index;
                        WHILE l <= v_kno_num LOOP
                            IF vt_PN(l).Phai_Nop > 0
                                AND ((vt_PN(l).Hdr_Id = vt_PN(i).Hdr_Id AND vt_PN(l).Dtl_Id = vt_PN(i).Dtl_Id)
                                OR (vt_PN(i).Qdinh_Id = vt_PN(l).Hdr_Id AND Qlt_Pck_Thop_No_Thue.Fnc_Ttoan(vt_PN(i).Ma_Gdich,vt_Pn(l).Ma_Gdich,vt_Pn(i).Loai_Qdinh))
                                OR (vt_PN(i).Loai_Qdinh = vt_PN(l).Loai_Qdinh AND vt_PN(i).Qdinh_Id = vt_PN(l).Qdinh_Id)
                                ) THEN
                                        IF vt_PN(i).Han_Nop > vt_PN(l).KyTp_Tu_Ngay THEN
                                            vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                            vt_PN(l).CHK_KNO:=''1'';
                                        END IF;

                                IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                   vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                   vt_PN(i).phai_nop:=0;
                                   EXIT;
                                ELSE
                                   vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                   vt_PN(l).phai_nop:=0;
                                   l:=l+1;
                                END IF;
                            ELSE
                                l:=l+1;
                            END IF;
                        END LOOP;
                        --Thanh toan theo ky
                        IF(vt_PN(i).Ky_ttoan_tu_ngay IS NOT NULL) THEN
                            l:=v_kno_index;
                            WHILE (l<=v_kno_num) LOOP
                                IF (vt_PN(l).phai_nop>0 AND vt_PN(i).Ma_Gdich <> ''B4'' AND vt_PN(l).Ma_Gdich <> ''I3'')
                                    AND vt_PN(i).ky_ttoan_tu_ngay<=vt_PN(l).ky_ttoan_tu_ngay
                                    AND vt_PN(i).ky_ttoan_den_ngay>=vt_PN(l).ky_ttoan_den_ngay
                                THEN
                                    --Neu khoan phai nop duoc thanh toan qua han==>tinh phat ncham
                                    IF vt_PN(i).Han_Nop>vt_PN(l).kytp_tu_ngay THEN
                                        vt_PN(l).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                        vt_PN(l).CHK_KNO:=''1'';
                                    END IF;

                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
                                       EXIT;
                                    ELSE
                                       vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                       vt_PN(l).phai_nop:=0;
                                       l:=l+1;
                                    END IF;
                                ELSE
                                    l:=l+1;
                                END IF;
                            END LOOP;
                        END IF;

                        --Thuc hien ttoan doi voi khoan da nop vt_PN(i)
                        WHILE (vt_PN(i).Phai_nop<0 AND vt_Pn(i).Ma_Gdich NOT IN(''B4'')) LOOP
                            --Duyet cac khoan phai nop: (Bat dau tu khoan con phai nop dau tien)
                            --Neu khoan phai nop van chua ttoan het
                            IF  (vt_PN(v_kno_index).Phai_nop>0 AND vt_Pn(v_kno_index).Ma_Gdich NOT IN(''I3''))THEN
                                --So sanh han nop, tinh phat ncham
                                IF vt_PN(i).Han_Nop>vt_PN(v_kno_index).kytp_tu_ngay THEN
                                    vt_PN(v_kno_index).Kytp_tu_Ngay := vt_PN(i).Han_Nop;
                                    vt_PN(v_kno_index).CHK_KNO:=''1'';
                                END IF;
                                --Thanh toan
                                IF abs(vt_PN(i).phai_nop) >= vt_pn(v_kno_index).phai_nop THEN
                                    vt_PN(i).phai_nop :=vt_PN(i).phai_nop+vt_PN(v_kno_index).phai_nop;
                                    vt_PN(v_kno_index).phai_nop   :=0;
                                    --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                    v_kno_index := v_kno_index+1;
                                ELSE
                                    vt_PN(v_kno_index).phai_nop :=vt_PN(v_kno_index).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop := 0;
                                END IF;
                            ELSE
                                --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                v_kno_index := v_kno_index+1;
                            END IF;
                            EXIT WHEN (v_kno_index>v_kno_num);
                        END LOOP;
                        EXIT WHEN (v_kno_index > v_kno_num);
                        i:=i+1;
                    END LOOP;
                END IF;

                -- Thanh toan xong dua du lieu vao bang so no
                FOR i IN 1 .. v_kno_num LOOP
                    v_ten_gdich:=NULL;
                    IF vt_Pn(i).Phai_Nop >= 0 AND vt_Pn(i).Han_Nop <= Last_Day(p_den_ky) THEN
                        v_No_Dky := vt_Pn(i).No_Dau_Ky;
                    END IF;
                    FOR vc_DM_GDich IN c_DM_GDich(  vt_PN(i).ma_gdich
                                                    ,vt_PN(i).kieu_gdich
                                                    ,vt_PN(i).Ten_GDich)LOOP
                        v_ten_gdich :=  vc_DM_GDich.TEN;
                    END LOOP;
                    v_Nguon_Goc := QCT_PCK_GDICH.fnc_get_nguon_goc_so_lieu(
                                                     vt_pn(i).MA_GDICH
                                                    ,vt_PN(i).kieu_gdich
                                                    , v_Ten_GDich
                                                    , Nvl(vt_pn(i).KYKK_DEN_NGAY, vt_pn(i).KYLB_DEN_NGAY)
                                                    , vt_pn(i).KYLB_DEN_NGAY
                                                    , vt_pn(i).HAN_NOP);

                    INSERT INTO EXT_QCT_NO_THANH_TOAN (
                                              TIN
                                            , HDR_ID
                                            , DTL_ID
                                            , TKHOAN
                                            , MA_CHUONG
                                            , MA_KHOAN
                                            , MA_MUC
                                            , MA_TMUC
                                            , KY_TTOAN_TU_NGAY
                                            , KY_TTOAN_DEN_NGAY
                                            , KYLB_TU_NGAY
                                            , KYLB_DEN_NGAY
                                            , KYKK_TU_NGAY
                                            , KYKK_DEN_NGAY
                                            , MA_THUE
                                            , NO_DAU_KY
                                            , PHAI_NOP
                                            , HAN_NOP
                                            , KYTP_TU_NGAY
                                            , MA_GDICH
                                            , KIEU_GDICH
                                            , TEN_GDICH
                                            , CHK_KNO
                                            , QDINH_ID
                                            , Loai_Qdinh
                                            , Nguon_Goc
                                            , id
                                            )
                                    VALUES  (
                                              vt_PN(i).TIN
                                            , vt_PN(i).HDR_ID
                                            , vt_PN(i).DTL_ID
                                            , vt_PN(i).TKHOAN
                                            , vt_PN(i).MA_CHUONG
                                            , vt_PN(i).MA_KHOAN
                                            , vt_PN(i).MA_MUC
                                            , vt_PN(i).MA_TMUC
                                            , vt_PN(i).KY_TTOAN_TU_NGAY
                                            , vt_PN(i).KY_TTOAN_DEN_NGAY
                                            , vt_PN(i).KYLB_TU_NGAY
                                            , vt_PN(i).KYLB_DEN_NGAY
                                            , vt_PN(i).KYKK_TU_NGAY
                                            , vt_PN(i).KYKK_DEN_NGAY
                                            , vt_PN(i).MA_THUE
                                            , vt_PN(i).NO_DAU_KY
                                            , vt_PN(i).PHAI_NOP
                                            , vt_PN(i).HAN_NOP
                                            , vt_PN(i).KYTP_TU_NGAY
                                            , vt_PN(i).MA_GDICH
                                            , vt_PN(i).KIEU_GDICH
                                            , vt_PN(i).TEN_GDICH
                                            , vt_PN(i).CHK_KNO
                                            , vt_PN(i).QDINH_ID
                                            , vt_PN(i).Loai_Qdinh
                                            , v_Nguon_Goc
                                            , ext_seq.NEXTVAL
                                            );
                END LOOP;
            END;--End Prc_Thanh_Toan

        BEGIN

            --Khoi tao gia tri bien dem so luong phan tu mang vt_PN(i)
            k:=0;
            FOR v_dtnt IN c_PHAI_NOP LOOP
                --Neu gap tap du lieu moi, thuc hien thanh toan tren tap du lieu da cap nhat vao mang
                IF    (v_last_tin<>''HHHHHHHHHHHHHH'')
                    AND (k > 0)
                    AND (   (v_dtnt.tin     <>  v_last_tin)
                                                    OR  (v_dtnt.tkhoan  <>  v_last_tkhoan)
                                                    OR  (v_dtnt.ma_muc  <>  v_last_muc)
                                                    OR  (v_dtnt.ma_tmuc <>  v_last_tmuc)
                                                    )THEN
                    --Thuc hien ttoan,tinh phat ncham, cap nhat du lieu so no
                    PRC_THANH_TOAN;
                    k:=0;
                END IF;
                -- Gan vao mang
                k := k+1;
                vt_PN(k) := v_dtnt;
                -- Cap nhat cac gia tri kiem tra v_last_TIN, v_Last_Ma_Muc,...
                v_last_tin := v_dtnt.tin;
                v_last_tkhoan := v_dtnt.tkhoan;
                v_last_muc := v_dtnt.ma_muc;
                v_last_tmuc := v_dtnt.ma_tmuc;
            END LOOP; -- danop

            --Thuc hien thanh toan tren tap du lieu cuoi cung trong con tro c_Phai_Nop
            IF(k>0)THEN
                PRC_THANH_TOAN;
            END IF;
        END;
    BEGIN
        Prc_THop_No_Thue(p_ky_no);
    END;
END;
    '
     );
    END;

    /**
     * @package: PCK_MOI_TRUONG.Prc_Ktao_pck_qlt
     * @desc:    create package on qlt-app
     * @author:  Administrator
     * @date:    04/08/2013
     * @param:
     *
     */
    PROCEDURE prc_ktao_pck_qlt

    IS
    BEGIN
        --Create package tong hop du lieu to khai quyet toan va thue mon bai
        --Package
        prc_remote_sql('
            CREATE OR REPLACE
            PACKAGE tms_qlt_cdoi_tk
              IS

                PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);

                PROCEDURE Prc_Qlt_Thop_Dkntk(p_chot DATE);
                PROCEDURE Prc_Job_Qlt_Thop_Dkntk(p_chot DATE);

                PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);
                PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);

                PROCEDURE Prc_Qlt_Thop_Monbai(p_chot DATE);
                PROCEDURE Prc_Job_Qlt_Thop_Monbai(p_chot DATE);

                PROCEDURE Prc_Del_Log(p_pck VARCHAR2);

                FUNCTION Fnc_GetKyTK (ma_tk varchar2)
                return varchar2;

            END;
        '
         );
        --Package body
        prc_remote_sql('
            CREATE OR REPLACE
PACKAGE BODY tms_qlt_cdoi_tk
IS
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2)
    IS
        JobNo user_jobs.job%TYPE;
    BEGIN
        dbms_job.submit(JobNo,
                        p_name_exe,
                        SYSDATE + 10/86400,
                        ''SYSDATE + 365'');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Create_Job_''||p_name_exe);
    END;
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;
    END;
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2)
    IS
        CURSOR c IS
        SELECT JOB FROM user_jobs
            WHERE instr(upper(what), upper(p_pro_name))>0;
    BEGIN
        FOR v IN c LOOP
            IF (v.job IS NOT NULL) THEN
                dbms_job.remove(v.job);
            END IF;
        END LOOP;
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Remove_Job_''||p_pro_name);
    END;
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.FORMAT_ERROR_STACK IS NULL THEN
            v_status:=''Y'';
        ELSE
            v_status:=''N'';
        END IF;

        -- Insert log
        INSERT INTO ext_errors(seq_number, error_stack, call_stack, timestamp,
                               pck, status)
                      VALUES(ext_seq.NEXTVAL,
                             DBMS_UTILITY.FORMAT_ERROR_STACK,
                             DBMS_UTILITY.FORMAT_CALL_STACK,
                             SYSDATE, p_pck, v_status);
        COMMIT;
    END;
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE ''
        UPDATE ''||p_table_name||'' a
           SET (ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT b.ma_canbo,
                       (SELECT d.ten FROM qlt_canbo d
                            WHERE d.ngay_hl_den IS NULL
                              AND b.ma_canbo=d.ma_canbo AND rownum=1) ten_canbo,
                       b.ma_phong,
                       (SELECT c.ten FROM qlt_phongban c
                            WHERE c.hluc_den_ngay IS NULL
                              AND b.ma_phong=c.ma_phong AND rownum=1) ten_phong
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin and rownum=1)'';
    END;

  /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Job_Qlt_Thop_Dkntk(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Dkntk(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''Prc_Qlt_Thop_Dkntk'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Dkntk(''''||p_chot||'''');
                        END;'');
    END;

    /**
     * @package: TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Dkntk
     * @desc:    Lay danh sach
     * @author:  Administrator
     * @date:    11/04/2013
     * @param:   p_chot
     */
    PROCEDURE Prc_Qlt_Thop_Dkntk(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_DKNTK'';
        v_last_ky_dkntk DATE:= last_day(add_months(trunc(p_chot, ''YEAR''),11));
        v_firt_ky_dkntk DATE:= last_day(sysdate)+1;
        v_ky_bat_dau varchar2(15);
        v_ky_ket_thuc varchar2(15);
        v_ma_tk varchar2(1);
        v_last_current_year date;
        v_quarter number(1);

    CURSOR cLoop IS
    SELECT dk_hdr.tin tin, dk_hdr.ten_dtnt, dk_dtl.MA_LOAI MA_LOAI,
               dk_dtl.NGAY_BAT_DAU ky_bat_dau,
               dk_dtl.NGAY_KET_THUC ky_ket_thuc
        FROM qlt_dknop_tkhai_hdr dk_hdr,
             qlt_dknop_tkhai_dtl dk_dtl,
             qlt_nsd_dtnt nnt

        WHERE dk_hdr.id = dk_dtl.DKNH_ID
        and dk_dtl.ma_loai in
        ( select dtk_ma from qlt_dm_tkhai_hluc where hluc_den_ngay is null and dtk_ma not in (''19'',''21'',''29'',''30'',''55'',''56'',''57'',''58'',''60'',''65''))
        AND nnt.tin=dk_hdr.tin
        AND nnt.trang_thai in (''01'',''02'',''03'')
        AND dk_dtl.DKY_NOP=''Y''
        AND (dk_dtl.NGAY_KET_THUC > last_day(p_chot)
          OR dk_dtl.NGAY_KET_THUC IS NULL);

    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        --Clear data TMS_DKNTK_QT
        DELETE FROM tms_dkntk_qt;
        -- Lay ngay cuoi cung cua thang chua ky chot du lieu
        select LAST_DAY(ADD_MONTHS(TRUNC(to_date(p_chot, ''DD/MM/RRRR'') , ''Year''),11)) into v_last_current_year from dual;
        /* day du lieu dang ky nop to khai */
        FOR vLoop IN cLoop LOOP
            --loai tk
            v_ma_tk := Fnc_GetKyTK(vLoop.MA_LOAI);

            -- Xac dinh ky bat dau voi tung loai to khai
            if v_ma_tk = ''M'' then -- ky thang ky bat dau = ky dau tien caa nam chua ky chot du lieu
                v_ky_bat_dau := substr(p_chot,-2)||''01'';
                dbms_output.put_line(''ma_tk: M''||v_ma_tk);
            elsif v_ma_tk = ''Q'' then -- ky quy ky bat dau = quy dau tien cua nam chua ky chot du lieu
                v_ky_bat_dau := substr(p_chot,-2)||''Q1'';
                 dbms_output.put_line(''ma_tk: Q''||v_ma_tk);
            elsif v_ma_tk = ''Y'' then -- ky nam ky bat dau = nam chua ky chot du lieu chuyen doi
                v_ky_bat_dau := substr(p_chot,-2)||''CN'';
                 dbms_output.put_line(''ma_tk: CN''||v_ma_tk);
            end if;

            -- Xac dinh ky ket thuc tuong ung voi tung mau to khai
            -- Neu ngay ket thuc trong hoac > ngay cuoi cung cua nam chua ky chot du lieu chuyen doi
            if vLoop.ky_ket_thuc is null or vLoop.ky_ket_thuc > v_last_current_year then
                if v_ma_tk = ''M'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||''12'';
                     dbms_output.put_line(''ma_tk: M''||v_ma_tk);
                elsif v_ma_tk = ''Q'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||''Q4'';
                     dbms_output.put_line(''ma_tk: Q''||v_ma_tk);
                elsif v_ma_tk = ''Y'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||''CN'';
                     dbms_output.put_line(''ma_tk: CN''||v_ma_tk);
                end if;
            else
                -- lay quarter theo ky_ket_thuc
                SELECT to_number(TO_char(TO_DATE(vLoop.ky_ket_thuc, ''dd.mm.yyyy''), ''Q'')) quarter into v_quarter  FROM dual;

                if v_ma_tk = ''M'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||substr(to_char(to_date(vLoop.ky_ket_thuc, ''DD/MM/RRRR''),''DD/MM/YYYY''),4,2);
                     dbms_output.put_line(''ma_tk: M''||v_ma_tk);
                elsif v_ma_tk = ''Q'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||''Q''||v_quarter;
                     dbms_output.put_line(''ma_tk: Q''||v_ma_tk);
                elsif v_ma_tk = ''Y'' then
                    v_ky_ket_thuc := substr(p_chot,-2)||''CN'';
                     dbms_output.put_line(''ma_tk: CN''||v_ma_tk);
                end if;

            end if;

            INSERT INTO tms_dkntk_qt(id, tin, ten_nnt,mau_tk, ky_bd, ky_kt, ky_bd_qlt, ky_kt_qlt)
                VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ten_dtnt,vLoop.MA_LOAI, v_ky_bat_dau, v_ky_ket_thuc, vLoop.ky_bat_dau, vLoop.ky_ket_thuc);
            --clear ma_tk
            v_ma_tk := null;
        END LOOP;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''tms_dkntk_qt'');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN others THEN
            Prc_Finnal(c_pro_name);
    END;
   /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Job_Qlt_Thop_Monbai(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Monbai(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''Prc_Qlt_Thop_Monbai'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Monbai(''''||p_chot||'''');
                        END;'');
    END;

    /**
     * @package: TMS_QLT_CDOI_TK.Prc_Qlt_Thop_Monbai
     * @desc:    Lay danh sach
     * @author:  Administrator
     * @date:    16/04/2013
     * @param:   p_chot
     */
    PROCEDURE Prc_Qlt_Thop_Monbai(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_MONBAI'';
        v_ky_den DATE := last_day(p_chot);
        v_chi_tieu   NUMBER (1);
        -- List Hdr
        CURSOR cLoop IS
            SELECT tk_hdr.tin tin,
                       tk_hdr.ten_dtnt ten_nnt,
                       tk_hdr.id TKH_ID,
                       tk_hdr.KYKK_TU_NGAY KYKK_TU_NGAY,
                       tk_hdr.KYKK_DEN_NGAY KYKK_DEN_NGAY,
                       tk_hdr.HAN_NOP HAN_NOP,
                       tk_hdr.NGAY_NOP NGAY_NOP
                FROM Qlt_tkhai_hdr tk_hdr,
                     qlt_nsd_dtnt nnt
                WHERE nnt.tin=tk_hdr.tin
                AND tk_hdr.TTHAI IN (''1'',''3'',''4'')
                AND SUBSTR(tk_hdr.kykk_tu_ngay,-4) = substr(p_chot,-4)
                AND tk_hdr.LTD = 0
                AND tk_hdr.KYLB_DEN_NGAY <= v_ky_den
                and tk_hdr.dtk_ma_loai_tkhai = ''53'';
            -- List Dtl
            CURSOR cDtl (v_tkh_id varchar2) IS
                SELECT * FROM Qlt_tkhai_mbai
                    WHERE tkh_ltd = 0
                    and tkh_id = v_tkh_id order by id;

        BEGIN
            qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

            DELETE FROM tms_tktmb_hdr;
            DELETE FROM tms_tktmb_dtl;
            DELETE FROM tms_tktmb_ps;

            /* day du lieu bang master to khai mon bai */
            FOR vLoop IN cLoop

            LOOP
                --Insert table tms_tktmb_hdr
                INSERT INTO tms_tktmb_hdr(tkh_id, tin, ten_nnt, kytt_tu_ngay,
                                          kytt_den_ngay, ngay_htoan, ngay_nop_tk, han_nop)
                    VALUES(vLoop.TKH_ID, vLoop.tin, vLoop.ten_nnt,
                        vLoop.KYKK_TU_NGAY, vLoop.KYKK_DEN_NGAY,v_ky_den,vLoop.NGAY_NOP, vLoop.HAN_NOP);


                    FOR v_Dtl IN cDtl(vLoop.TKH_ID)
                        LOOP
                            IF v_Dtl.ky_hieu = ''[10]''
                            THEN
                                v_chi_tieu := 1;--Nguoi nop thue
                            ELSIF v_Dtl.ky_hieu = ''[11]''
                            THEN
                                v_chi_tieu := 2;--Don vi truc thuoc
                            ELSIF v_Dtl.ky_hieu = ''[12]''
                            THEN
                                v_chi_tieu := 3;--Tong so
                            END IF;

                            IF v_Dtl.ky_hieu IS NULL OR v_Dtl.ky_hieu = ''12''
                            THEN
                                 --Insert table tms_tktmb_dtl
                                 INSERT INTO tms_tktmb_dtl(id, tkh_id, chi_tieu, bmb_id_nnt, bmb_id_cqt, so_nnt,so_cqt,von_dky_nnt, von_dky_cqt)
                                 VALUES(ext_seq.NEXTVAL, v_Dtl.tkh_id, v_chi_tieu, v_Dtl.bmb_id_nnt, v_Dtl.bmb_id_cqt,
                                        v_Dtl.so_nnt,v_Dtl.so_cqt,v_Dtl.von_dky_nnt, v_Dtl.von_dky_cqt);
                            END IF;
                        END LOOP;

                 --Insert table tms_tktmb_ps
                 INSERT INTO tms_tktmb_ps(id, tkh_ID, tmt_ma_tmuc, thue_psinh)
                 SELECT ext_seq.NEXTVAL,tkh_id,tmt_ma_tmuc,thue_psinh
                    FROM qlt_psinh_tkhai
                 WHERE TKH_ID = vLoop.TKH_ID;

            END LOOP;

            /* cap nhat phong ban can bo */
            Prc_Update_Pbcb(''tms_tktmb_hdr'');

            COMMIT;

            qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

            Prc_Finnal(c_pro_name);

            EXCEPTION
                WHEN others THEN
                    Prc_Finnal(c_pro_name);

        END;
    /**
     * @package: TMS_QLT_CDOI_TK.Fnc_GetKyTK
     * @desc:    lay loai tk (thang, quy, nam)
     * @author:  Administrator
     * @date:    22/04/2013
     * @param:   ma_tk
     */
        FUNCTION Fnc_GetKyTK (ma_tk varchar2)
         return varchar2
        is
        rt_loaitk varchar2(1);
        begin

            SELECT a.kieu_ky into rt_loaitk
                FROM qlt_dm_tkhai_hluc a where a.hluc_den_ngay is null and dtk_ma = ''''||ma_tk||'''';

            return rt_loaitk;

        end;

END;
        '
         );
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_pck_qlt
    Noi dung: Khoi tao EXT_PCK_CONTROL cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_pck_qlt_du
    IS
    BEGIN
        prc_remote_sql('
                        CREATE OR REPLACE
                        PACKAGE ext_pck_qlt_control IS

                            PROCEDURE Prc_Qlt_Thop_No(p_chot DATE);
                            PROCEDURE Prc_Qlt_Thop_PS(p_chot DATE);
                            PROCEDURE Prc_Qlt_Thop_Ckt(p_chot DATE);

                            PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE);
                            PROCEDURE Prc_Job_Qlt_Thop_PS(p_chot DATE);
                            PROCEDURE Prc_Job_Qlt_Thop_Ckt(p_chot DATE);

                            PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                            PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);

                            PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                            PROCEDURE Prc_Del_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
                        END;'
                             );
        prc_remote_sql('
CREATE OR REPLACE
PACKAGE BODY ext_pck_qlt_control
IS
    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE) IS
        v_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_NO'';
        v_kykk_hluc CONSTANT DATE := to_date(''1-jan-2005'',''DD/MM/RRRR'');

        v_bang_hdr          VARCHAR2(50);
        v_ten_cot_sqd       VARCHAR2(20);
        v_ten_cot_nqd       VARCHAR2(20);

        TYPE cv_typ IS REF CURSOR;
        c_SO_QD cv_typ;
        v_so_qd VARCHAR2(20);
        v_ngay_qd DATE;

        SQL_Text  VARCHAR2(200);

        v_DTC_MA VARCHAR2(2);

        v_kykk_tu_ngay  DATE ;
        v_kykk_den_ngay  DATE ;
        v_ngay_hach_toan DATE ;

        CURSOR c_GDich_QD(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2)IS
            SELECT *
            FROM  EXT_DM_GDICH_QDINH DM
            WHERE DM.ma_gdich     =   pc_MA_GDICH
                AND DM.kieu_gdich   =   pc_Kieu_GDich ;

        CURSOR c_TC_NO(pn_PNOP_ID NUMBER)IS
            SELECT TCNO.dtc_ma
            FROM  EXT_QLT_TC_NO TCNO
            WHERE TCNO.pnop_id = pn_PNOP_ID;

        CURSOR cPNOP (p_chot DATE) IS
        SELECT    PNOP.TIN
                , HDR_ID                    HDR_ID
                , DTL_ID                    DTL_ID
                , PNOP.TKHOAN               TKHOAN
                , MA_CHUONG            MA_CHUONG
                , MA_KHOAN             MA_KHOAN
                , MA_MUC                    MA_MUC
                , MA_TMUC                   MA_TMUC
                , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                , KYLB_TU_NGAY              KYLB_TU_NGAY
                , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                , KYKK_TU_NGAY              KYKK_TU_NGAY
                , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                , MA_THUE                   MA_THUE
                , NO_DAU_KY                 NO_DAU_KY
                , PHAI_NOP                  PHAI_NOP
                , HAN_NOP                   HAN_NOP
                , KYTP_TU_NGAY              KYTP_TU_NGAY
                , MA_GDICH                  MA_GDICH
                , KIEU_GDICH                KIEU_GDICH
                , TEN_GDICH                 TEN_GDICH
                , CHK_KNO                   CHK_KNO
                , QDINH_ID                  QDINH_ID
                , Loai_Qdinh                Loai_Qdinh
                , Nguon_Goc                 Nguon_Goc
                , NO_NTE                    NO_NTE
                , DON_VI_TIEN               DON_VI_TIEN
                , id                        pnop_id
        FROM ext_qlt_no_thanh_toan PNOP ;

        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qlt_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));
    BEGIN
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        -- Xoa du lieu bang du lieu tren cac bang trung gian
        DELETE FROM EXT_QLT_NO_THANH_TOAN NOTT ;
        DELETE FROM EXT_QLT_NO NOCD ;
        DELETE FROM EXT_QLT_TC_NO;
        DELETE FROM ext_QTN_SO_NO_QLT;

        EXT_PCK_Qlt_XL_NO.prc_qlt_no(p_chot);
        EXT_PCK_Qlt_XL_NO_NTE.prc_qlt_no_nte(p_chot);

        INSERT INTO ext_QTN_SO_NO_QLT (KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                                   dgd_kieu_gdich,TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA)
            select KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich, dgd_kieu_gdich,
                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA
            from QTN_SO_NO@QTN TCNO where TCNO.KYNO_DEN_NGAY = p_chot;

        INSERT INTO EXT_QLT_TC_NO
        SELECT    PNOP.ID       PNOP_ID
                , TCNO.DTC_MA  DTC_MA
        FROM ext_qlt_no_thanh_toan PNOP, ext_QTN_SO_NO_QLT TCNO
        WHERE TCNO.KYNO_DEN_NGAY = p_chot
            AND PNOP.NO_NTE IS NULL
            AND PNOP.hdr_id=TCNO.hdr_id AND PNOP.dtl_id=TCNO.dtl_id
            AND PNOP.ma_gdich = TCNO.dgd_ma_gdich AND PNOP.kieu_gdich = TCNO.dgd_kieu_gdich
            AND PNOP.tin = TCNO.TIN AND PNOP.ma_tmuc = TCNO.tmt_ma_tmuc
            AND PNOP.han_nop = TCNO.han_nop AND PNOP.ma_thue = TCNO.tmt_ma_thue
            AND decode(PNOP.tkhoan,''TK_TAM_GIU'',''1'',
                              ''TK_NGAN_SACH'',''2'',
                              ''TK_TAM_THU'',''3'',
                              ''TK_TH_HOAN'',''4'') = TCNO.tkn_ma
            AND PNOP.PHAI_NOP>0 ;

        FOR vPNOP IN cPNOP(p_chot) LOOP
            v_bang_hdr    := null;
            v_ten_cot_sqd := null;
            v_ten_cot_nqd := null;

             --Neu la no ngoai te thi khong lay so quyet dinh
            if vPNOP.NO_NTE IS NULL then
                FOR vc_GDICH_QD IN c_GDICH_QD (vPNOP.ma_gdich
                                               ,vPNOP.kieu_gdich) LOOP
                    v_bang_hdr    := trim(vc_GDICH_QD.BANG_HDR);
                    v_ten_cot_sqd := trim(vc_GDICH_QD.TEN_COT_SQD);
                    v_ten_cot_nqd := trim(vc_GDICH_QD.TEN_COT_NQD);
                END LOOP;
            End if;

            v_so_qd := null;
            v_ngay_qd := null;

            if v_bang_hdr is not null then
                SQL_Text := ''SELECT '' || v_ten_cot_sqd || '' SO_QD, ''
                                  || v_ten_cot_nqd || '' NGAY_QD FROM ''
                                  || v_bang_hdr || '' HDR WHERE HDR.ID = ''
                                  || Nvl(vPNOP.HDR_ID,0) ;

                OPEN c_SO_QD for SQL_Text;
                LOOP
                    FETCH c_SO_QD into v_so_qd, v_ngay_qd;
                    EXIT WHEN c_SO_QD%notfound;
                END LOOP;
                --Close cursor
                CLOSE c_SO_QD;
             END IF;

            IF v_ngay_qd is null THEN
                 v_ngay_qd := Trunc(vPNOP.kylb_tu_ngay,''Month'') ;
            END IF;

            v_DTC_MA := null;
            --Neu la no ngoai te thi khong lay tinh chat no
            if vPNOP.NO_NTE IS NULL then
                FOR vc_TC_NO IN c_TC_NO (vPNOP.PNOP_ID) LOOP
                    v_DTC_MA    := trim(vc_TC_NO.DTC_MA);
                END LOOP;
            End if;

            v_kykk_tu_ngay := vPNOP.kykk_tu_ngay ;
            v_kykk_den_ngay := vPNOP.kykk_den_ngay ;
            if vPNOP.kykk_tu_ngay is null then
                v_kykk_tu_ngay := vPNOP.kylb_tu_ngay ;
            end if;

            if vPNOP.kykk_den_ngay is null then
                v_kykk_den_ngay := vPNOP.kylb_den_ngay ;
            end if;

            if vPNOP.KYLB_DEN_NGAY < Trunc(p_chot,''Year'') then
                v_ngay_hach_toan := Trunc(p_chot,''Year'') - 1 ;
            else
                v_ngay_hach_toan := last_day(p_chot);
            end if;

            INSERT INTO EXT_QLT_NO (TIN,
                        tkhoan,
                        ma_chuong,
                        ma_khoan,
                        tmt_ma_tmuc,
                        kykk_tu_ngay,
                        kykk_den_ngay,
                        ngay_hach_toan,
                        han_nop,
                        nguon_goc,
                        tinh_chat,
                        so_qd,
                        ngay_qd,
                        so_tien,
                        no_nte,
                        don_vi_tien,
                        id
                        )
            VALUES      (
                        vPNOP.TIN
                        ,vPNOP.tkhoan
                        ,vPNOP.ma_chuong
                        ,vPNOP.ma_khoan
                        ,vPNOP.ma_tmuc
                        ,v_kykk_tu_ngay
                        ,v_kykk_den_ngay
                        ,v_ngay_hach_toan
                        ,vPNOP.han_nop
                        ,vPNOP.nguon_goc
                        ,v_DTC_MA
                        ,v_so_qd
                        ,v_ngay_qd
                        ,vPNOP.PHAI_NOP
                        ,vPNOP.NO_NTE
                        ,vPNOP.DON_VI_TIEN
                        ,ext_seq.NEXTVAL
                        );
        END LOOP;

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qlt_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, ''MONTH''),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, ''MONTH''))
            WHERE id=vUp_Ky.id;
        END LOOP;

        UPDATE ext_qlt_no SET KYKK_TU_NGAY=v_kykk_hluc,
                              KYKK_DEN_NGAY=last_day(v_kykk_hluc)
                        WHERE KYKK_TU_NGAY<v_kykk_hluc;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_no'');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ps(p_chot date) IS

    v_Alert_button NUMBER;
    v_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_PS'';

    v_tu_ky date := trunc(p_chot,''Year'');
    v_den_ky date := p_chot;

    CURSOR cLoop IS
    /* TO KHAI PHAT SINH */
    SELECT tkha.tin tin, tkha.dtk_ma_loai_tkhai dtk_ma, nnt.ma_chuong ma_chuong,
               nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc tmt_ma_tmuc,
               tkha.kykk_tu_ngay kykk_tu_ngay, tkha.kykk_den_ngay kykk_den_ngay,
               psin.thue_psinh so_tien, tkha.han_nop
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >= v_tu_ky)
        AND (tkha.kylb_tu_ngay <= v_den_ky)
        AND (tkha.dtk_ma_loai_tkhai IN  (SELECT MA_LOAI_TKHAI FROM ext_qlt_dmtk_ps) )
        AND (psin.thue_psinh<>0)
        UNION ALL
    /* AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
               hdr.kykk_tu_ngay, hdr.kykk_den_ngay, dtl.so_thue so_tien, to_date(NULL) han_nop
        FROM qlt_ds_an_dinh_hdr hdr,
             qlt_ds_an_dinh_dtl dtl,
             qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.adh_id
        AND (nnt.tin=hdr.tin)
        AND (hdr.ly_do IN (''02'',''03''))
        AND (hdr.kykk_tu_ngay >= v_tu_ky)
        AND (hdr.kylb_tu_ngay <= v_den_ky)
        AND (hdr.dtk_ma IN  (SELECT MA_LOAI_TKHAI FROM ext_qlt_dmtk_ps) )
        UNION ALL
    /* BAI BO AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
            hdr.kykk_tu_ngay, hdr.kykk_den_ngay, (-1)*dtl.so_thue so_tien, to_date(NULL) han_nop
        FROM qlt_qd_bbo_ad_hdr hdr,
            qlt_qd_bbo_ad_dtl dtl,
            qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.qba_id
            AND (nnt.tin=hdr.tin)
            AND (hdr.kykk_tu_ngay >= v_tu_ky)
        AND (hdr.kylb_tu_ngay <= v_den_ky)
        AND (hdr.dtk_ma IN  (SELECT MA_LOAI_TKHAI FROM ext_qlt_dmtk_ps) );

    /* XU LY KHIEU NAI */
        CURSOR cADI IS
        SELECT hdr.id, hdr.so_qd_goc, adi.dtk_ma, adi.kykk_tu_ngay, adi.kykk_den_ngay,
               adi.tin, nnt.ma_chuong, nnt.ma_khoan, ''KHIEU_NAI_AN_DINH'' trang_thai, adi.KYLB_TU_NGAY,
               to_date(NULL) han_nop
        FROM qlt_ds_an_dinh_hdr adi,
               qlt_ds_an_dinh_dtl dtl,
             qlt_qd_xlkn_hdr hdr,
             qlt_nsd_dtnt nnt
        WHERE adi.so_qd=hdr.so_qd_goc
        AND (adi.id=dtl.adh_id)
        AND (adi.tin=nnt.tin)
        AND (adi.ly_do IN (''03''))
        AND (adi.kykk_tu_ngay >= v_tu_ky)
        AND (adi.kylb_tu_ngay <= v_den_ky)
        AND (adi.dtk_ma IN  (SELECT MA_LOAI_TKHAI FROM ext_qlt_dmtk_ps) );

        CURSOR cKHN(p_so_qd_goc VARCHAR2) IS
        SELECT dtl.tmt_ma_tmuc, dtl.stien_clech so_tien
        FROM qlt_qd_xlkn_hdr hdr,
             qlt_qd_xlkn_dtl dtl
        WHERE hdr.id=dtl.qxkh_id
        AND EXISTS (SELECT 1
                    FROM qlt_qd_xlkn_hdr subhdr
                    WHERE subhdr.id=hdr.id
                    START WITH subhdr.so_qd_goc = p_so_qd_goc
                    CONNECT BY PRIOR subhdr.so_qd_xly = subhdr.so_qd_goc);

    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        DELETE FROM ext_qlt_ps dtl ;

        /* day du lieu phat sinh to khai, an dinh, bai bo */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                          ma_loai_tkhai, ky_psinh_tu,
                                          ky_psinh_den, han_nop)
                VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ma_chuong, vLoop.ma_khoan,
                       vLoop.tmt_ma_tmuc, vLoop.so_tien,
                       vLoop.dtk_ma, vLoop.kykk_tu_ngay, vLoop.kykk_den_ngay,
                       vLoop.han_nop);
        END LOOP;

        /* day du lieu khieu nai */
        FOR vADI IN cADI LOOP
            FOR vKHN IN cKHN(vADI.so_qd_goc) LOOP
                INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc,
                                              so_tien, ma_loai_tkhai, ky_psinh_tu,
                                              ky_psinh_den, han_nop)
                    VALUES(ext_seq.NEXTVAL, vADI.tin, vADI.ma_chuong, vADI.ma_khoan,
                           vKHN.tmt_ma_tmuc, vKHN.so_tien,
                           vADI.dtk_ma, vADI.kykk_tu_ngay, vADI.kykk_den_ngay, null);
            END LOOP;
        END LOOP;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_ps'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;

         Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ckt
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ckt(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_CKT'';

   v_ky_tu DATE:= trunc(p_chot, ''YEAR'');
    v_ky_den DATE:= last_day(p_chot);

    CURSOR cLoop IS
    SELECT tk_hdr.tin tin, nnt.ma_chuong, nnt.ma_khoan,
               tk_hdr.DTK_MA_LOAI_TKHAI dtk_ma,
               tk_hdr.KYKK_TU_NGAY KYKK_TU_NGAY,
               tk_hdr.KYKK_DEN_NGAY KYKK_DEN_NGAY,
               tk_hdr.HAN_NOP HAN_NOP,
               tk_dtl.tmt_ma_tmuc MA_TMUC,
               tk_dtl.thue_ktru_ksau SO_TIEN
        FROM Qlt_tkhai_hdr tk_hdr,
             qlt_htoan_tkhai_gtgt_kt_2004 tk_dtl,
             qlt_nsd_dtnt nnt
        WHERE tk_hdr.id=tk_dtl.tkh_id
        AND tk_dtl.tkh_ltd = 0
        AND nnt.tin=tk_hdr.tin
        AND tk_hdr.TTHAI IN (''1'',''3'',''4'')
        AND tk_hdr.LTD = 0
        AND tk_hdr.DTK_MA_LOAI_TKHAI = ''14''
        AND tk_hdr.KYLB_DEN_NGAY <= v_ky_den
        AND tk_hdr.KYKK_TU_NGAY =( SELECT MAX(KYKK_TU_NGAY)
            from qlt_tkhai_hdr a
            where a.tin =tk_hdr.TIN
            AND a.TTHAI IN (''1'',''3'',''4'')
            AND a.LTD = 0
            AND a.DTK_MA_LOAI_TKHAI = ''14''
            AND a.KYLB_DEN_NGAY <= v_ky_den)
    UNION ALL
        SELECT tk_hdr.tin tin, nnt.ma_chuong, nnt.ma_khoan,
               tk_hdr.DTK_MA_LOAI_TKHAI dtk_ma,
               tk_hdr.KYKK_TU_NGAY KYKK_TU_NGAY,
               tk_hdr.KYKK_DEN_NGAY KYKK_DEN_NGAY,
               tk_hdr.HAN_NOP HAN_NOP,
               ''1701'' MA_TMUC,
               tk_dtl.sothue_dtnt SO_TIEN
        FROM Qlt_tkhai_hdr tk_hdr,
             qlt_tkhai_gtgt_kt tk_dtl,
             qlt_nsd_dtnt nnt
        WHERE tk_hdr.id=tk_dtl.tkh_id
        AND tk_dtl.tkh_ltd = 0
        AND nnt.tin=tk_hdr.tin
        AND tk_hdr.TTHAI IN (''1'',''3'',''4'')
        AND tk_hdr.LTD = 0
        AND tk_hdr.DTK_MA_LOAI_TKHAI = ''68''
        AND tk_hdr.KYLB_DEN_NGAY <= v_ky_den
        AND tk_dtl.CTK_ID = ''2221''
        AND tk_hdr.KYKK_TU_NGAY =(SELECT MAX(KYKK_TU_NGAY)
            from qlt_tkhai_hdr a
            where a.tin =tk_hdr.TIN
            AND a.TTHAI IN (''1'',''3'',''4'')
            AND a.LTD = 0
            AND a.DTK_MA_LOAI_TKHAI = ''68''
            AND a.KYLB_DEN_NGAY <= v_ky_den) ;
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        DELETE FROM ext_qlt_con_kt dtl ;

        /* day du lieu dang ky nop to khai */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_CON_KT(id, tin, ma_chuong, ma_khoan,
                                          ma_loai_tkhai, MA_TMUC,
                                          KYKK_TU_NGAY,
                                          KYKK_DEN_NGAY,
                                          han_nop,
                                          SO_TIEN)
                VALUES(ext_seq.NEXTVAL, vLoop.tin,vLoop.ma_chuong,
                    vLoop.ma_khoan, vLoop.dtk_ma,
                    vLoop.MA_TMUC, vLoop.KYKK_TU_NGAY,
                    vLoop.KYKK_TU_NGAY, vLoop.han_nop, vLoop.SO_TIEN);
        END LOOP;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_con_kt'');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN Prc_Finnal(c_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_No(''''''||p_chot||'''''');
                        END;'');
    END;

   /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_PS'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_Ps(''''''||p_chot||'''''');
                        END;'');
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ckt
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ckt(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_CKT'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            EXT_PCK_QLT_CONTROL.Prc_Qlt_Thop_CKT(''''''||p_chot||'''''');
                        END;'');
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2)
    IS
        CURSOR c IS
        SELECT JOB FROM user_jobs
            WHERE instr(upper(what), upper(p_pro_name))>0;
    BEGIN
        FOR v IN c LOOP
            IF (v.job IS NOT NULL) THEN
                dbms_job.remove(v.job);
            END IF;
        END LOOP;
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Remove_Job_''||p_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2)
    IS
        JobNo user_jobs.job%TYPE;
    BEGIN
        dbms_job.submit(JobNo,
                        p_name_exe,
                        SYSDATE + 10/86400,
                        ''SYSDATE + 365'');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Create_Job_''||p_name_exe);
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.FORMAT_ERROR_STACK IS NULL THEN
            v_status:=''Y'';
        ELSE
            v_status:=''N'';
        END IF;

        -- Insert log
        INSERT INTO ext_errors(seq_number, error_stack, call_stack, timestamp,
                               pck, status)
                      VALUES(ext_seq.NEXTVAL,
                             DBMS_UTILITY.FORMAT_ERROR_STACK,
                             DBMS_UTILITY.FORMAT_CALL_STACK,
                             SYSDATE, p_pck, v_status);
        COMMIT;
    END;

    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;
    END;
    /***************************************************************************
    EXT_PCK_QLT_CONTROL.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE ''
        UPDATE ''||p_table_name||'' a
           SET (ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT b.ma_canbo,
                       (SELECT d.ten FROM qlt_canbo d
                            WHERE d.ngay_hl_den IS NULL
                              AND b.ma_canbo=d.ma_canbo AND rownum=1) ten_canbo,
                       b.ma_phong,
                       (SELECT c.ten FROM qlt_phongban c
                            WHERE c.hluc_den_ngay IS NULL
                              AND b.ma_phong=c.ma_phong AND rownum=1) ten_phong
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin and rownum=1)'';
    END;
END;'
     );
    /* END PRC_KTAO_PCK_QLT*/
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_pck_qlt
    Noi dung: Khoi tao EXT_PCK_CONTROL cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_pck_qct_du
    IS
    BEGIN
        prc_remote_sql('
                        CREATE OR REPLACE
                        PACKAGE ext_pck_qct_control IS

                            PROCEDURE Prc_Qct_Thop_No(p_chot DATE);

                            PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE);

                            PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
                            PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);

                            PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
                            PROCEDURE Prc_Del_Log(p_pck VARCHAR2);
                            PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
                        END;'
                             );
        prc_remote_sql('
CREATE OR REPLACE
PACKAGE BODY ext_pck_qct_control
IS
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Qct_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE) IS
        v_pro_name CONSTANT VARCHAR2(30) := ''PRC_QCT_THOP_NO'';
        v_kykk_hluc CONSTANT DATE := to_date(''1-jan-2005'',''DD/MM/RRRR'');

        v_bang_hdr          VARCHAR2(50);
        v_ten_cot_sqd       VARCHAR2(20);
        v_ten_cot_nqd       VARCHAR2(20);

        TYPE cv_typ IS REF CURSOR;
        c_SO_QD cv_typ;
        v_so_qd VARCHAR2(20);
        v_ngay_qd DATE;

        SQL_Text  VARCHAR2(200);

        v_DTC_MA VARCHAR2(2);

        v_kykk_tu_ngay  DATE ;
        v_kykk_den_ngay  DATE ;
        v_ngay_hach_toan DATE ;

        CURSOR c_GDich_QD(pc_MA_GDICH VARCHAR2)IS
            SELECT *
            FROM  EXT_QCT_DM_GDICH_QDINH DM
            WHERE DM.ma_gdich     =   pc_MA_GDICH   ;

        CURSOR c_TC_NO(pn_PNOP_ID NUMBER)IS
            SELECT TCNO.dtc_ma
            FROM  EXT_QCT_TC_NO TCNO
            WHERE TCNO.pnop_id = pn_PNOP_ID;

        CURSOR cPNOP (p_chot DATE) IS
        SELECT    PNOP.TIN
                , HDR_ID                    HDR_ID
                , DTL_ID                    DTL_ID
                , PNOP.TKHOAN               TKHOAN
                , MA_CHUONG            MA_CHUONG
                , MA_KHOAN             MA_KHOAN
                , MA_MUC                    MA_MUC
                , MA_TMUC                   MA_TMUC
                , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                , KYLB_TU_NGAY              KYLB_TU_NGAY
                , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                , KYKK_TU_NGAY              KYKK_TU_NGAY
                , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                , MA_THUE                   MA_THUE
                , NO_DAU_KY                 NO_DAU_KY
                , PHAI_NOP                  PHAI_NOP
                , HAN_NOP                   HAN_NOP
                , KYTP_TU_NGAY              KYTP_TU_NGAY
                , MA_GDICH                  MA_GDICH
                , KIEU_GDICH                KIEU_GDICH
                , TEN_GDICH                 TEN_GDICH
                , CHK_KNO                   CHK_KNO
                , QDINH_ID                  QDINH_ID
                , Loai_Qdinh                Loai_Qdinh
                , Nguon_Goc                 Nguon_Goc
                , id                        pnop_id
        FROM ext_qct_no_thanh_toan PNOP ;

        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qct_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));
    BEGIN
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        -- Xoa du lieu bang du lieu tren cac bang trung gian
        DELETE FROM EXT_QCT_NO_THANH_TOAN NOTT ;
        DELETE FROM EXT_QCT_NO NOCD ;
        DELETE FROM EXT_QCT_TC_NO;
        DELETE FROM ext_QTN_SO_NO_QCT;

        EXT_PCK_Qct_XL_NO.prc_qct_no(p_chot);

        INSERT INTO ext_QTN_SO_NO_QCT (KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA)
            select KYNO_DEN_NGAY, hdr_id, dtl_id, dgd_ma_gdich,
                   TIN, tmt_ma_tmuc, han_nop, tmt_ma_thue, tkn_ma, DTC_MA
            from QTN_SO_NO_CTH@QTN TCNO where TCNO.KYNO_DEN_NGAY = p_chot;

        INSERT INTO EXT_QCT_TC_NO
        SELECT    PNOP.ID       PNOP_ID
                , TCNO.DTC_MA  DTC_MA
        FROM ext_qct_no_thanh_toan PNOP, ext_QTN_SO_NO_QCT TCNO
        WHERE TCNO.KYNO_DEN_NGAY = p_chot
            AND PNOP.hdr_id=TCNO.hdr_id AND PNOP.dtl_id=TCNO.dtl_id
            AND PNOP.ma_gdich = TCNO.dgd_ma_gdich
            AND PNOP.tin = TCNO.TIN AND PNOP.ma_tmuc = TCNO.tmt_ma_tmuc
            AND PNOP.han_nop = TCNO.han_nop AND PNOP.ma_thue = TCNO.tmt_ma_thue
            AND decode(PNOP.tkhoan,''TK_TAM_GIU'',''1'',
                              ''TK_NGAN_SACH'',''2'',
                              ''TK_TAM_THU'',''3'',
                              ''TK_TH_HOAN'',''4'') = TCNO.tkn_ma
            AND PNOP.PHAI_NOP>0 ;

        FOR vPNOP IN cPNOP(p_chot) LOOP
            v_bang_hdr    := null;
            v_ten_cot_sqd := null;
            v_ten_cot_nqd := null;

            FOR vc_GDICH_QD IN c_GDICH_QD (vPNOP.ma_gdich) LOOP
                v_bang_hdr    := trim(vc_GDICH_QD.BANG_HDR);
                v_ten_cot_sqd := trim(vc_GDICH_QD.TEN_COT_SQD);
                v_ten_cot_nqd := trim(vc_GDICH_QD.TEN_COT_NQD);
            END LOOP;

            v_so_qd := null;
            v_ngay_qd := null;

            if v_bang_hdr is not null then
                SQL_Text := ''SELECT '' || v_ten_cot_sqd || '' SO_QD, ''
                                  || v_ten_cot_nqd || '' NGAY_QD FROM ''
                                  || v_bang_hdr || '' HDR WHERE HDR.ID = ''
                                  || Nvl(vPNOP.HDR_ID,0) ;

                OPEN c_SO_QD for SQL_Text;
                LOOP
                    FETCH c_SO_QD into v_so_qd, v_ngay_qd;
                    EXIT WHEN c_SO_QD%notfound;
                END LOOP;
                --Close cursor
                CLOSE c_SO_QD;
             END IF;

            IF v_ngay_qd is null THEN
                 v_ngay_qd := Trunc(vPNOP.kylb_tu_ngay,''Month'') ;
            END IF;

            v_DTC_MA := null;
            FOR vc_TC_NO IN c_TC_NO (vPNOP.PNOP_ID) LOOP
                v_DTC_MA    := trim(vc_TC_NO.DTC_MA);
            END LOOP;

            v_kykk_tu_ngay := vPNOP.kykk_tu_ngay ;
            v_kykk_den_ngay := vPNOP.kykk_den_ngay ;
            if vPNOP.kykk_tu_ngay is null then
                v_kykk_tu_ngay := vPNOP.kylb_tu_ngay ;
            end if;

            if vPNOP.kykk_den_ngay is null then
                v_kykk_den_ngay := vPNOP.kylb_den_ngay ;
            end if;

            if vPNOP.KYLB_DEN_NGAY < Trunc(p_chot,''Year'') then
                v_ngay_hach_toan := Trunc(p_chot,''Year'') - 1 ;
            else
                v_ngay_hach_toan := last_day(p_chot);
            end if;

            INSERT INTO EXT_QCT_NO (TIN,
                        tkhoan,
                        ma_chuong,
                        ma_khoan,
                        tmt_ma_tmuc,
                        kykk_tu_ngay,
                        kykk_den_ngay,
                        ngay_hach_toan,
                        han_nop,
                        nguon_goc,
                        tinh_chat,
                        so_qd,
                        ngay_qd,
                        so_tien,
                        id
                        )
            VALUES      (
                        vPNOP.TIN
                        ,vPNOP.tkhoan
                        ,vPNOP.ma_chuong
                        ,vPNOP.ma_khoan
                        ,vPNOP.ma_tmuc
                        ,v_kykk_tu_ngay
                        ,v_kykk_den_ngay
                        ,v_ngay_hach_toan
                        ,vPNOP.han_nop
                        ,vPNOP.nguon_goc
                        ,v_DTC_MA
                        ,v_so_qd
                        ,v_ngay_qd
                        ,vPNOP.PHAI_NOP
                        ,ext_seq.NEXTVAL
                        );
        END LOOP;

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qct_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, ''MONTH''),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, ''MONTH''))
            WHERE id=vUp_Ky.id;
        END LOOP;

        UPDATE ext_qct_no SET KYKK_TU_NGAY=v_kykk_hluc,
                              KYKK_DEN_NGAY=last_day(v_kykk_hluc)
                        WHERE KYKK_TU_NGAY<v_kykk_hluc;

        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qct_no'');
        COMMIT;

        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(v_pro_name);
        EXCEPTION WHEN others
            THEN
                Rollback;
                Prc_Finnal(v_pro_name);
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Job_Qct_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QCT_THOP_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN
                            EXT_PCK_QCT_CONTROL.Prc_Qct_Thop_No(''''''||p_chot||'''''');
                        END;'');
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2)
    IS
        CURSOR c IS
        SELECT JOB FROM user_jobs
            WHERE instr(upper(what), upper(p_pro_name))>0;
    BEGIN
        FOR v IN c LOOP
            IF (v.job IS NOT NULL) THEN
                dbms_job.remove(v.job);
            END IF;
        END LOOP;
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Remove_Job_''||p_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2)
    IS
        JobNo user_jobs.job%TYPE;
    BEGIN
        dbms_job.submit(JobNo,
                        p_name_exe,
                        SYSDATE + 10/86400,
                        ''SYSDATE + 365'');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Create_Job_''||p_name_exe);
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.FORMAT_ERROR_STACK IS NULL THEN
            v_status:=''Y'';
        ELSE
            v_status:=''N'';
        END IF;

        -- Insert log
        INSERT INTO ext_errors(seq_number, error_stack, call_stack, timestamp,
                               pck, status)
                      VALUES(ext_seq.NEXTVAL,
                             DBMS_UTILITY.FORMAT_ERROR_STACK,
                             DBMS_UTILITY.FORMAT_CALL_STACK,
                             SYSDATE, p_pck, v_status);
        COMMIT;
    END;

    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;
    END;
    /***************************************************************************
    EXT_PCK_QCT_CONTROL.Prc_Update_Pbcb
    ***************************************************************************/
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE ''
        UPDATE ''||p_table_name||'' a
           SET (ma_cbo, ten_cbo, ma_pban, ten_pban)=
               (SELECT b.ma_canbo,
                       (SELECT d.ten FROM qlt_canbo d
                            WHERE d.ngay_hl_den IS NULL
                              AND b.ma_canbo=d.ma_canbo AND rownum=1) ten_canbo,
                       b.ma_phong,
                       (SELECT c.ten FROM qlt_phongban c
                            WHERE c.hluc_den_ngay IS NULL
                              AND b.ma_phong=c.ma_phong AND rownum=1) ten_phong
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin and rownum=1)'';
    END;
END;'
     );
    /* END PRC_KTAO_PCK_QLT*/
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_errors
    Noi dung: Don dep bang ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_tb_ext_errors
    IS
        c_name_drop   CONSTANT VARCHAR2 (20) := 'EXT_ERRORS';

        CURSOR c
        IS
            SELECT   1
              FROM   user_objects@qlt
             WHERE   object_type = 'TABLE' AND object_name = c_name_drop;
    BEGIN
        FOR v IN c
        LOOP
            prc_remote_sql ('DROP TABLE ' || c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_errors
    Noi dung: Don dep ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_tb_ext_errors
    IS
    BEGIN
        prc_ddep_tb_ext_errors;

        prc_remote_sql('CREATE TABLE ext_errors (
        seq_number   NUMBER,
        timestamp    DATE,
        error_stack  VARCHAR2(2000),
        pck          VARCHAR2(50),
        status       VARCHAR2(1),
        ltd          NUMBER(5,0) DEFAULT 0,
        call_stack   VARCHAR2(2000)
        )'
          );

        prc_remote_sql('ALTER TABLE ext_errors
        ADD CONSTRAINT ext_pk_errors
        PRIMARY KEY (seq_number)
        USING INDEX'
                    );
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Qlt
    Noi dung: Khoi tao moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_qlt (p_short_name VARCHAR2)
    IS
    BEGIN
        prc_ktao_seq;                                      --khoi tao sequence
        --prc_ktao_pck_qlt;                                   --khoi tao package
        prc_ktao_table ('QLT-APP');  --Khoi tao toan bo cac table tren QLT-APP

        prc_ktao_tb_ext_qlt_no;
        prc_ktao_tb_ext_qlt_ps;
        prc_ktao_tb_ext_qlt_dmtk_ps;
/*        prc_ktao_tb_ext_dm_gdich_qlt;
        prc_ktao_tb_ext_qlt_con_kt;
        prc_ktao_tb_ext_qlt_dmtk_ps;*/

        prc_ktao_tb_ext_errors;

        prc_ktao_pck_qlt_xl_no;
        prc_ktao_pck_qlt_du;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.PRC_KTAO
    Noi dung: Khoi tao moi truong
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 23/11/2011
    ***************************************************************************/
    PROCEDURE prc_ktao (p_short_name VARCHAR2)
    IS
        CURSOR c
        IS
            SELECT   tax_model
              FROM   tb_lst_taxo
             WHERE   short_name = p_short_name;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = ''SIGNATURE''';

        -- Chay thu tuc khoi tao moi truong
        FOR v IN c
        LOOP
            EXECUTE IMMEDIATE   'CALL PCK_MOI_TRUONG.Prc_Ktao_'
                             || v.tax_model
                             || '('''
                             || USERENV ('client_info')
                             || ''')';
        END LOOP;

        -- Cap nhat trang thai CQT
        UPDATE   tb_lst_taxo
           SET   status = 1
         WHERE   short_name = p_short_name;

        -- Xac nhan cap nhat
        COMMIT;

        -- Ghi log
        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Qlt
    Noi dung: Don dep moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011

    Noi dung: Thuc hien don dep cac table khoi tao tren db QLT
    Ngay thuc hien: 22/04/2013
    Nguoi thuc hien: Administrator
    ***************************************************************************/
    PROCEDURE prc_ddep_qlt (p_short_name VARCHAR2)
    IS
    BEGIN
        pck_moi_truong.prc_ddep_tb_ext_qlt_ps;
        pck_moi_truong.prc_ddep_tb_ext_qlt_no;
        pck_moi_truong.prc_ddep_tb_ext_dm_gdich_qlt;
        pck_moi_truong.prc_ddep_tb_ext_qlt_con_kt;
        pck_moi_truong.prc_ddep_tb_ext_errors;
        pck_moi_truong.prc_ddep_seq;
        --Xoa toan bo cac table da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_drop_tbl_qlt ('user_objects@qlt', 'QLT-APP');
        --Xoa toan bo cac package da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_ddep_pck_qlt ('user_objects@qlt', 'QLT-APP');
    END;
    /**
     * @package: PCK_MOI_TRUONG.prc_ktao_pnn
     * @desc:    khoi tao moi truong PNN-APP
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:
     */
    PROCEDURE prc_ktao_pnn (p_short_name VARCHAR2)
        IS
        BEGIN
            prc_ktao_seq_pnn; --khoi tao sequence
            prc_ktao_table_pnn ('PNN-APP');  --Khoi tao toan bo cac table tren PNN-APP

        END;
    /**
     * @package: PCK_MOI_TRUONG.prc_ddep_pnn
     * @desc:    don dep moi truong PNN-APP
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:
     */
    PROCEDURE prc_ddep_pnn (p_short_name VARCHAR2)
        IS
        BEGIN

        pck_moi_truong.prc_ddep_seq_pnn;
        --Xoa toan bo cac table da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_drop_tbl_pnn ('user_objects@pnn', 'PNN-APP');
        --Xoa toan bo cac package da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_ddep_pck_qlt ('user_objects@pnn', 'PNN-APP');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep
    Noi dung: Don dep moi truong
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 23/11/2011
    ***************************************************************************/
    PROCEDURE prc_ddep (p_short_name VARCHAR2)

    IS
        CURSOR c
        IS
            SELECT   tax_model
              FROM   tb_lst_taxo
             WHERE   short_name = p_short_name;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = ''SIGNATURE''';

        -- Cap nhat trang thai CQT
        UPDATE   tb_lst_taxo
           SET   status = 99
         WHERE   short_name = p_short_name AND tax_model <> 'VAT';

        -- Chay thu tuc don dep moi truong
        FOR v IN c
        LOOP
            IF v.tax_model <> 'VAT'
            THEN
                EXECUTE IMMEDIATE 'BEGIN
                    PCK_MOI_TRUONG.Prc_Ddep_'
                                 || v.tax_model
                                 || '('''
                                 || USERENV ('client_info')
                                 || ''');
                 END;'
                      ;
            END IF;
        END LOOP;

        -- Xoa log
        DELETE FROM   tb_log_pck
              WHERE   short_name = p_short_name;

        DELETE FROM   tb_errors
              WHERE   short_name = p_short_name;

        DELETE FROM   tb_data_error
              WHERE   short_name = p_short_name;

        -- Xac nhan cap nhat
        COMMIT;

        -- Ghi log
        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Qct
    Noi dung: Khoi tao moi truong cho QCT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE prc_ktao_qct (p_short_name VARCHAR2)
    IS
    BEGIN
    prc_ktao_seq;                                      --khoi tao sequence

    prc_ktao_qlt(p_short_name);

    --Khoi tao toan bo cac table tren QLT-APP. Vi QLT vs QCT dung chung database
    --Nen khoi tao voi tham so TAX_MODEL = QLT-APP
    prc_ktao_table ('QCT-APP');

    prc_ktao_tb_ext_dm_gdich_qct;
    Prc_Ktao_tb_ext_qct_no;
    prc_ktao_tb_ext_errors;
    prc_ktao_pck_qct_xl_no;
    Prc_Ktao_Pck_Qct_du;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Qct
    Noi dung: Don dep moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE prc_ddep_qct (p_short_name VARCHAR2)
    IS
    BEGIN
        pck_moi_truong.prc_ddep_seq;
        prc_ddep_qlt(p_short_name);
        --Xoa toan bo cac table da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_drop_tbl_qlt ('user_objects@qlt', 'QCT-APP');
        --Xoa toan bo cac package da khoi tao tren QLT-APP cua tung cqt
        --PCK_ULT.Prc_Ddep_Pck_Qlt('user_objects@qlt','QLT-APP');
        pck_moi_truong.prc_ddep_tb_ext_dm_gdich_qct;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_no;
        PCK_MOI_TRUONG.prc_ddep_tb_ext_errors;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Set_glView(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 15/09/2011
    Noi dung: SET short_name toan cuc cho phien lam viec
    ***************************************************************************/
    PROCEDURE prc_set_glview (p_short_name VARCHAR2)
    IS
        v_temp   VARCHAR2 (3);
    BEGIN
        DBMS_APPLICATION_INFO.set_client_info (p_short_name);
    -- Ghi log
    --PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Get_Errors(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin tu TABLE ext_errors
    ***************************************************************************/
    PROCEDURE prc_get_errors (p_short_name VARCHAR2)
    IS
    BEGIN
        DELETE FROM   tb_errors
              WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE '
        INSERT INTO tb_errors(seq_number, short_name, timestamp,
                                  error_stack, call_stack, pck, status)
        SELECT SEQ_ID_LOG_PCK.NEXTVAL, '''
                         || p_short_name
                         || ''', timestamp, error_stack, call_stack,
               pck, status
          FROM ext_errors@QLT_'
                         || p_short_name
                         || '
         WHERE ltd=0'
                     ;

        COMMIT;

        -- Ghi log
        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;


    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Chot_Dlieu
    ***************************************************************************/
    PROCEDURE prc_chot_dlieu (p_short_name VARCHAR2)
    IS
    BEGIN
        UPDATE   tb_lst_taxo
           SET   status = 98
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;
END;
/


