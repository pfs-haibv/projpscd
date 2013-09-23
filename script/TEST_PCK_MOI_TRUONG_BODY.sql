-- Start of DDL Script for Package Body TEST.PCK_MOI_TRUONG
-- Generated 23/09/2013 10:37:14 AM from TEST@DCNC

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
            BEGIN
                EXECUTE IMMEDIATE 'DROP DATABASE LINK ' || v.db_link;
            EXCEPTION
                WHEN OTHERS THEN
                pck_trace_log.prc_ins_log (USERENV ('client_info'),pck_trace_log.fnc_whocalledme);
            END;
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
        cur  sys_refcursor;
        v_table varchar2(100);
        SQL_Text varchar2(500) := 'SELECT   1
                                      FROM   user_objects@qlt a
                                     WHERE   object_type = ''SEQUENCE'' AND OBJECT_NAME = '''||c_name_drop||'''
                                   ';
    BEGIN
        open cur for SQL_Text;
        loop
            fetch cur into v_table;
            exit when cur%notfound;
            prc_remote_sql ('DROP SEQUENCE ' || c_name_drop);
        END LOOP;
        --Close cursor
        close cur;

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
     * Thuc hien khoi tao moi truong
     *<p> Khoi tao sequence cho PNN
     *@author Administrator
     *@date   29/05/2013
     *@see PCK_MOI_TRUONG.prc_remote_sql_pnn
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
     * Thuc hien don dep moi truong
     *<p> don dep sequence PNN-APP
     *@author  Administrator
     *@date    29/05/2013
     *@see PCK_MOI_TRUONG.prc_ddep_seq_pnn
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

    /**
     * Thuc hien khoi tao moi truong
     *<p> khoi tao table cho qlt-app vs qct-app
     *@author Administrator
     *@date   04/08/2013
     *@param  tax_model
     *@see PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_app
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

    /**
     * Thuc hien khoi tao moi truong
     *<p> khoi tao table cho pnn-app
     *@author Administrator
     *@date   04/08/2013
     *@param  tax_model
     *@see PCK_MOI_TRUONG.prc_ktao_table_pnn
     */
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
     * Thuc hien khoi tao moi truong
     *<p> Dua danh muc dung chung sang qlt-app, qct-app
     * @package PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_app
     * @desc    Lay du lieu danh muc to khai voi tax_mode: QLT, QCT ...
     * @author  Administrator
     * @date    06/05/2013
     * @param
     */
    PROCEDURE prc_getdata_dmuc_tkhai
    IS
        sql_text   VARCHAR (1000);
    BEGIN
        --Clear data
        delete from ext_dmuc_tkhai@qlt;
        --
        INSERT INTO ext_dmuc_tkhai@qlt (
                                id,
                                ma,
                                tax_model,
                                ten,
                                ma_tms,
                                loai_kkhai,
                                flg_dkntk,
                                flg_ps)
                    SELECT   id,
                             ma,
                             tax_model,
                             ten,
                             ma_tms,
                             loai_kkhai,
                             flg_dkntk,
                             flg_ps
                      FROM   tb_dmuc_tkhai;
        commit;

    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'), pck_trace_log.fnc_whocalledme);
    END;

     /**
     * @package:
     * @desc:    Insert du lieu danh muc to khai phat sinh
     * @author:  Administrator
     * @date:
     * @param:
     **/
    PROCEDURE prc_insert_dmuc_tkhai_ps_qlt
    IS
        sql_text   VARCHAR (200);
    BEGIN
        --Clear data
        prc_remote_sql('truncate table ext_qlt_dmtk_ps');

        sql_text :='insert into ext_qlt_dmtk_ps@QLT (ma_loai_tkhai, ten_tkhai)
                    select ma_loai_tkhai, ten_tkhai from TB_LST_TKHAI_PS';

        EXECUTE IMMEDIATE sql_text;

        prc_remote_sql('commit');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'), pck_trace_log.fnc_whocalledme);
    END;

    /**
     * @package:
     * @desc:    Insert du lieu danh muc to khai phat sinh
     * @author:  Administrator
     * @date:
     * @param:
     **/
    PROCEDURE prc_insert_dm_gdich_qdinh_qlt
    IS
        sql_text   VARCHAR (1000);
    BEGIN
        --Clear data
        prc_remote_sql('truncate table ext_qlt_dm_gdich_qdinh');
        sql_text :='INSERT INTO ext_qlt_dm_gdich_qdinh@qlt
                    (ten_gdich, ma_gdich, kieu_gdich, bang_hdr, ten_qdinh,
                    ten_cot_sqd, ten_cot_nqd)
                    SELECT ten_gdich, ma_gdich, kieu_gdich, bang_hdr, ten_qdinh,
                    ten_cot_sqd, ten_cot_nqd
                    FROM tb_qlt_dm_gdich_qdinh';

        EXECUTE IMMEDIATE sql_text;

        prc_remote_sql('commit');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'), pck_trace_log.fnc_whocalledme);
    END;

     /**
     * @package:
     * @desc:    Insert du lieu danh muc to khai phat sinh
     * @author:  Administrator
     * @date:
     * @param:
     **/
    PROCEDURE prc_insert_dm_gdich_qdinh_qct
    IS
        sql_text   VARCHAR (1000);
    BEGIN
        --Clear data
        prc_remote_sql('truncate table ext_qct_dm_gdich_qdinh');

        sql_text := 'INSERT INTO ext_qct_dm_gdich_qdinh@qlt
                     (ten_gdich, ma_gdich, kieu_gdich, bang_hdr, ten_qdinh,
                     ten_cot_sqd, ten_cot_nqd)
                     SELECT ten_gdich, ma_gdich, kieu_gdich, bang_hdr, ten_qdinh,
                     ten_cot_sqd, ten_cot_nqd
                     FROM tb_qct_dm_gdich_qdinh';

        EXECUTE IMMEDIATE sql_text;

        prc_remote_sql('commit');
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (USERENV ('client_info'), pck_trace_log.fnc_whocalledme);
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
        prc_cre_dblink(p_short_name);
        prc_ktao_seq; --khoi tao sequence
        prc_ktao_table ('QLT-APP');--Khoi tao toan bo cac table tren QLT-APP

        pck_ult.Prc_Crt_Pck_File('QLT-APP');--khoi tao package

        Prc_GetData_DMuc_TKhai;
        prc_insert_dm_gdich_qdinh_qlt;
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
        pck_moi_truong.prc_ddep_seq;
        --Xoa toan bo cac table da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_drop_tbl_qlt ('user_objects@qlt', 'QLT-APP');
        --Xoa toan bo cac package da khoi tao tren QLT-APP cua tung cqt
        pck_ult.prc_ddep_pck_qlt ('user_objects@qlt', 'QLT-APP');
    END;
    /**
     * Thuc hien khoi tao moi truong PNN-APP
     *@author  Administrator
     *@date    29/05/2013
     *@see PCK_MOI_TRUONG.prc_ktao_pnn
     *@param p_short_name
     */
    PROCEDURE prc_ktao_pnn (p_short_name VARCHAR2)
        IS
        BEGIN
            prc_cre_dblink_pnn(p_short_name);
            prc_ktao_seq_pnn; --khoi tao sequence
            prc_ktao_table_pnn ('PNN-APP');  --Khoi tao toan bo cac table tren PNN-APP
            pck_ult.Prc_Crt_Pck_File_Pnn('PNN-APP');--khoi tao package
        END;

    /**
     * Thuc hien don dep moi truong PNN-APP
     *@author  Administrator
     *@date    29/05/2013
     *@see PCK_MOI_TRUONG.prc_ddep_pnn
     *@param p_short_name
     */
    PROCEDURE prc_ddep_pnn (p_short_name VARCHAR2)
        IS
        BEGIN
        prc_cre_dblink_pnn(p_short_name);
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
    /**
     * Khoi tao toan bo cac table tren QLT-APP.
     * Nen khoi tao voi tham so TAX_MODEL = QLT-APP, Database QCT co them can cu tinh thue GTGT
     **/
    prc_ktao_table ('QCT-APP');

    prc_insert_dm_gdich_qdinh_qct;

    --khoi tao package
    pck_ult.Prc_Crt_Pck_File('QCT-APP');
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
        PCK_ULT.Prc_Ddep_Pck_Qlt('user_objects@qlt','QCT-APP');
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
