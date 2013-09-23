-- Start of DDL Script for Package Body TEST.PCK_ULT
-- Generated 23/09/2013 9:18:57 AM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_ult
IS
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Cre_DBlink(p_pay_taxo_id)
    Noi dung: Tao DB link
    ***************************************************************************/
    PROCEDURE prc_cre_dblink (p_short_name VARCHAR2, p_name VARCHAR2,p_user VARCHAR2
                              ,p_pass VARCHAR2,p_connect VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE   'CREATE DATABASE LINK '
                                 || p_name
                                 || ' CONNECT TO '
                                 || p_user
                                 || ' IDENTIFIED BY '
                                 || p_pass
                                 || '
                         USING '''
                                 || p_connect
                                 || '''';
        EXCEPTION
            WHEN OTHERS THEN
                pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Close_DBlink
    Noi dung: Dong phien lam viec DBLINK
    ***************************************************************************/
    PROCEDURE prc_close_dblink (p_short_name VARCHAR2, p_link VARCHAR2)
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
    PROCEDURE prc_drop_dblink (p_short_name VARCHAR2, p_link VARCHAR2)
    IS
    BEGIN
        prc_close_dblink (p_short_name, p_link);

        FOR v IN (SELECT   db_link
                    FROM   all_db_links
                   WHERE   db_link = p_link)
        LOOP
            EXECUTE IMMEDIATE 'DROP DATABASE LINK ' || v.db_link;
        END LOOP;
    END;

    /* Kiem tra tinh dung dan cua MST theo dung quy tac ************************ PCK_ULT.FNC_CHECK_DIGIT
    ***************************************************************************/
    FUNCTION Fnc_Check_Digit(V_tin IN VARCHAR2) RETURN VARCHAR2
    IS
       Prod    NUMBER;
       Chkdg   NUMBER(2);
    BEGIN
       Prod :=  31 * TO_NUMBER(SUBSTR(V_tin, 1, 1))
              + 29 * TO_NUMBER(SUBSTR(V_tin, 2, 1))
              + 23 * TO_NUMBER(SUBSTR(V_tin, 3, 1))
              + 19 * TO_NUMBER(SUBSTR(V_tin, 4, 1))
              + 17 * TO_NUMBER(SUBSTR(V_tin, 5, 1))
              + 13 * TO_NUMBER(SUBSTR(V_tin, 6, 1))
              +  7 * TO_NUMBER(SUBSTR(V_tin, 7, 1))
              +  5 * TO_NUMBER(SUBSTR(V_tin, 8, 1))
              +  3 * TO_NUMBER(SUBSTR(V_tin, 9, 1));
       Chkdg := 10 - MOD(Prod, 11);
       RETURN TO_CHAR(Chkdg);
    END;

    /* Kiem tra tinh dung dan cua MST theo dung quy tac ************************
    PCK_ULT.FNC_CHECK_TIN
    ***************************************************************************/
    FUNCTION Fnc_Check_Tin(P_TIN Varchar2) RETURN Number IS
        Prod Number(10);
        Chkdg varchar2(2);
        pos number;
        v_Prefix varchar2(14);
        v_Suffix varchar2(4);

    BEGIN
      Pos := Instr(p_Tin, '-');
      If Pos = 0 then -- Khong co Suffix
            v_prefix := p_Tin;
            If NVL(Length(v_prefix), 0) <> 10 Then
            Return 2;
            End if;
            prod := To_Number(v_prefix); -- Kiem tra ma Tin co ky tu khong hop le?
            Chkdg := PCK_ULT.Fnc_Check_Digit(v_Prefix);
            If Chkdg != substr(v_prefix, -1, 1) Then
              Return 1;
            End if;
      Else -- co Suffix
            v_prefix := Substr( p_Tin, 1, POS-1);
            v_Suffix := Substr( p_Tin, Pos+1);
            If ( NVL(Length( v_prefix), 0) <> 10 or NVL(Length( v_Suffix), 0)<>3) then
                Return 2;
            End if;
            prod := To_Number( v_prefix); -- Kiem tra ma Tin co ky tu khong hop le?
            prod := To_Number( v_Suffix); -- Kiem tra Suffix co ky tu khong hop le?
            Chkdg := PCK_ULT.Fnc_Check_Digit( v_Prefix);
            if Chkdg != substr( v_prefix, -1, 1) then
              Return 1;
            End if;
      End if;
      Return 0;
    EXCEPTION
       When Others then -- Neu Prefix hay Suffix co chua ky tu khong hop le
             Return 3;
    END;

    /* Kiem tra su ton tai cua mot file ****************************************
    PCK_ULT.Prc_Read_File(p_file)
    ***************************************************************************/
    PROCEDURE Prc_Read_File(p_fname Varchar2, p_id_hdr number) IS
        v_SFile   utl_file.file_type;
        v_NewLine VARCHAR2(1000);
    BEGIN
        v_SFile := utl_file.fopen('DIR_TEMP', p_fname,'r');
        IF utl_file.is_open(v_SFile) THEN
            LOOP
                BEGIN
                    utl_file.get_line(v_SFile, v_NewLine);

                    IF v_NewLine IS NULL THEN
                        EXIT;
                    END IF;

                    INSERT INTO tb_excel(id_hdr, id_dtl, col_text)
                        VALUES(p_id_hdr, SEQ_ID_LOG_PCK.NEXTVAL, v_NewLine);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    EXIT;
                END;
            END LOOP;

            COMMIT;
        END IF;
        utl_file.fclose(v_SFile);
    END;

    /* tim chuoi p_str trong file p_fname voi duong dan p_dir ******************
    PCK_ULT.Fnc_Find_strInFile(p_dir Varchar2, p_fname Varchar2, p_str Varchar2)
    ***************************************************************************/
    FUNCTION Fnc_Find_StrInFile(p_dir Varchar2, p_fname Varchar2, p_str Varchar2)
    RETURN boolean
    IS
        v_SFile   utl_file.file_type;
        v_NewLine VARCHAR2(1000);
        v_return boolean := false;
    BEGIN
        dbms_output.put_line(p_dir);
        dbms_output.put_line(p_fname);

        v_SFile := utl_file.fopen(p_dir, p_fname,'r');
        dbms_output.put_line('2 ');
        IF utl_file.is_open(v_SFile) THEN
            LOOP
                BEGIN
                    utl_file.get_line(v_SFile, v_NewLine);

                    IF instr(v_NewLine, p_str)>0 THEN
                        v_return:=TRUE;
                        RETURN v_return;
                    END IF;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    EXIT;
                END;
            END LOOP;
        END IF;
        utl_file.fclose(v_SFile);

        RETURN v_return;

        EXCEPTION
            WHEN OTHERS THEN
            utl_file.fclose(v_SFile);
            dbms_output.put_line('co loi xay ra '||SQLERRM);
            RETURN v_return;
    END;

    /* tach ten File tu chuoi duong dan ****************************************
    PCK_ULT.Fnc_Split_strFile(p_str Varchar2)
    Example: Fnc_Split_strFile('E:\KT_{1}_{2}.exe.txt') = 'KT_{1}_{2}.exe.txt'
    ***************************************************************************/
    FUNCTION Fnc_Split_strFile(p_str Varchar2)
    RETURN varchar2 IS
        v_filename varchar2(300);
        v_return varchar2(300);
    BEGIN
        v_filename:=substr(p_str
                          ,instr(p_str, '\', -1) + 1
                          ,length(p_str)-instr(p_str, '\', -1));
        IF instr(v_filename, '.')>0 THEN
            v_return:=v_filename;
        Else
            v_return:='';
        END IF;

        return v_return;
    END;

    /* tach duong dan Folder tu chuoi duong dan ****************************************
    PCK_ULT.Fnc_Split_strFolder(p_str Varchar2)
    Example: Fnc_Split_strFile('E:\KT_{1}_{2}.exe.txt') = 'E:\'
    ***************************************************************************/
    FUNCTION Fnc_Split_strFolder(p_str Varchar2)
    RETURN varchar2 IS
        v_return varchar2(300);
    BEGIN
        return replace(p_str, Fnc_Split_strFile(p_str), '');
    END;

    /* Kiem tra tinh dung dan cua MST theo dung quy tac ************************
    PCK_ULT.FNC_CHECK_DIGIT
    ***************************************************************************/
    FUNCTION Fnc_Excel_Tag_Cell(p_style VARCHAR2, p_type VARCHAR2, p_data VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN '<Cell ss:StyleID="'||p_style||'"><Data ss:Type="'
                                  ||p_type||'">'||p_data||'</Data></Cell>';
    END;

    /* Tao ra 1 file tu query **************************************************
    PCK_ULT.Prc_Write_File( )
    ***************************************************************************/
    PROCEDURE Prc_Write_File(p_sql varchar2,
                             p_dir varchar2,
                             p_fname varchar2,
                             p_separator varchar2 DEFAULT ',')
    IS
    L_output        UTL_FILE.File_type;
    L_thecursor     INTEGER                 DEFAULT DBMS_SQL.Open_cursor;
    L_columnvalue   NVARCHAR2(4000);
    L_status        INTEGER;
    L_colcnt        NUMBER                  := 0;
    L_separator     NVARCHAR2(1);
    L_desctbl       DBMS_SQL.Desc_tab;

    v_error_message varchar2(255);
    BEGIN

    -- phan tich query
    DBMS_SQL.Parse(L_thecursor, p_sql, DBMS_SQL.Native);
    DBMS_SQL.Describe_columns(L_thecursor, L_colcnt, L_desctbl);

    -- dinh nghia cot cho ket qua query
    FOR I IN 1 .. L_colcnt LOOP
        DBMS_SQL.Define_column(L_thecursor, I, L_columnvalue, 4000);
    END LOOP;

    -- thuc hien ket qua query
    L_status := DBMS_SQL.EXECUTE(L_thecursor);

    -- Bat dau ket xuat File ---------------------------------------------------
    WHILE(DBMS_SQL.Fetch_rows(L_thecursor) > 0) LOOP
    L_output := UTL_FILE.FOPEN_NCHAR(p_dir, p_fname, 'W');

        -- Ghi du lieu ra file -------------------------------------------------
        L_separator := '';
        FOR I IN 1 .. L_colcnt LOOP
            DBMS_SQL.COLUMN_VALUE(L_thecursor, I, L_columnvalue);
            UTL_FILE.PUT_NCHAR(L_output, L_separator || L_columnvalue);
            -- Xac dinh phan cach cho cac ket qua
            L_separator := p_separator;
        END LOOP;
        UTL_FILE.New_line(L_output);
    END LOOP;
    UTL_FILE.Fclose(L_output);
    -- Ket thuc ket xuat File --------------------------------------------------
    DBMS_SQL.Close_cursor(L_thecursor);

    EXCEPTION
        WHEN others THEN
        v_error_message:=SQLERRM;
        dbms_output.put_line('Co loi: '||v_error_message);
        -- dong file neu bi loi
        IF UTL_FILE.is_open(L_output) THEN
            UTL_FILE.Fclose(L_output);
        END IF;
        -- dong con tro neu bi loi
        IF dbms_sql.is_open(L_thecursor) THEN
            dbms_sql.close_cursor(L_thecursor);
        END IF;
    END;

    /**
     * Thuc hien don dep sau khi thuc hien lay du lieu hoan thanh
     * <p> xoa package duoc config trong table tb_package
     *@author  Administrator
     *@date    04/08/2013
     *@param   tble_user_object = user_objects@db_link
     *         v_tax_model  qlt-app
     *@see PCK_UTL.Prc_Ddep_Pck_Qlt
     */
    PROCEDURE Prc_Ddep_Pck_Qlt(tbl_user_objects varchar2, v_tax_model varchar2) IS

        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Ddep_Pck_Qlt';
        cur  sys_refcursor;
        v_table varchar2(100);
        SQL_Text varchar2(500) := 'select object_name FROM '||tbl_user_objects||
                                  ' WHERE object_type = '''||c_object_type_package||
                                  ''' AND object_name in (select pck_name
                                                                from tb_package
                                                          where tax_model = '''||v_tax_model||'''
                                                                and directory is null)
                                                            ';
    BEGIN
        open cur for SQL_Text;
        loop
            fetch cur into v_table;
            exit when cur%notfound;
            pck_moi_truong.prc_remote_sql('DROP PACKAGE '||v_table);
        END LOOP;

        --Close cursor
        close cur;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN
                others THEN Prc_Finnal(c_pro_name);
    END;

    /**
     * Thuc hien don dep sau khi thuc hien lay du lieu hoan thanh
     * <p> xoa table duoc config trong table tb_tables
     *@author  Administrator
     *@date    04/08/2013
     *@param   tble_user_object = user_objects@db_link
     *         v_tax_model  qlt-app
     *@see PCK_UTL.Prc_Drop_Tbl_Qlt
     */
    PROCEDURE Prc_Drop_Tbl_Qlt (tbl_user_objects varchar2, v_tax_model varchar2)
    IS
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Drop_Tbl_Qlt';
        cur  sys_refcursor;
        v_table varchar2(100);
        SQL_Text varchar2(400) :=  'select object_name FROM '||tbl_user_objects||
                                  ' WHERE object_type = '''||c_object_type_table||
                                  ''' AND object_name in (select upper(tbl_name) from tb_tables where tax_model = '''||v_tax_model||''' or tax_model is null)';
    BEGIN
        open cur for SQL_Text;
        loop
            fetch cur into v_table;
            exit when cur%notfound;
            pck_moi_truong.prc_remote_sql('DROP TABLE '||v_table);
        END LOOP;
        --Close cursor
        close cur;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN
                others THEN Prc_Finnal(c_pro_name);
    END;

    PROCEDURE Prc_Drop_Tbl_pnn (tbl_user_objects varchar2, v_tax_model varchar2)
    IS
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Drop_Tbl_pnn';
        cur  sys_refcursor;
        v_table varchar2(100);
        SQL_Text varchar2(400) :=  'select object_name FROM '||tbl_user_objects||
                                  ' WHERE object_type = '''||c_object_type_table||
                                  ''' AND object_name in (select tbl_name from tb_tables where tax_model = '''||v_tax_model||''')';
    BEGIN
        open cur for SQL_Text;
        loop
            fetch cur into v_table;
            exit when cur%notfound;
            pck_moi_truong.prc_remote_sql_pnn('DROP TABLE '||v_table);
        END LOOP;
        --Close cursor
        close cur;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN
                others THEN Prc_Finnal(c_pro_name);
    END;

    /**
     * Thuc hien khoi tao moi truong
     * <p>Khoi tao table tren he thong QLT, QCT duoc config trong table tb_tables.
     *@author  Administrator
     *@date    04/08/2013
     *@param   tbl_create, table_space, pk_name,
     *         pk_column, idx_name, idx_column
     *@see PCK_UTL.Prc_Create_Tbl_Qlt
     */
    PROCEDURE Prc_Create_Tbl_Qlt (v_tax_model varchar2)
    IS
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Create_Tbl_Qlt';
        --Cursor table name
        CURSOR c_tbl_create
        IS
              SELECT   id, tbl_name, tablespace, p_name, p_value, index_name, index_value
                FROM   tb_tables where tax_model = ''||v_tax_model||'' or tax_model is null;
        --Cursor column
        CURSOR c_col_name (p_tbl_id VARCHAR2) -- id tb_tables
        IS
              SELECT   tbl_id, col_name, TYPE types
                FROM   tb_columns
               WHERE   tbl_id = p_tbl_id;

        v_list_col   VARCHAR2 (1000);
        Sql_Text     varchar2 (2000);
    BEGIN
        FOR vc_tbl_list IN c_tbl_create

            LOOP
            v_list_col := NULL;
            FOR vc_col_name IN c_col_name (vc_tbl_list.id)

            LOOP
                v_list_col := v_list_col|| vc_col_name.col_name || ' '|| vc_col_name.types || ',';

            END LOOP;
            -- create table
            Sql_Text := 'CREATE TABLE '|| vc_tbl_list.tbl_name || '('
                             || SUBSTR (v_list_col, 1, LENGTH (v_list_col) - 1)||
                             ')';
            -- Set value cho tablespace
            if vc_tbl_list.tablespace is not null then
                Sql_Text := Sql_Text ||'
                                    PCTFREE 10
                                    INITRANS 1
                                    MAXTRANS 255
                                    TABLESPACE '||vc_tbl_list.tablespace||'
                                    STORAGE (INITIAL 65536 MINEXTENTS 1 MAXEXTENTS 2147483645)
                                    NOCACHE
                                    MONITORING
                                    NOPARALLEL
                                    LOGGING';
             end if;
            pck_moi_truong.prc_remote_sql(''||Sql_Text||'');

            -- Index
            if vc_tbl_list.index_name is not null and vc_tbl_list.index_value is not null then
                Sql_Text := 'CREATE INDEX '||vc_tbl_list.index_name||'
                                        ON '||vc_tbl_list.tbl_name||' ('||vc_tbl_list.index_value||' ASC)';
                 -- Set value cho tablespace
                 if vc_tbl_list.tablespace is not null then
                 Sql_Text := Sql_Text ||'
                                        PCTFREE 10
                                        INITRANS 2
                                        MAXTRANS 255
                                        TABLESPACE '||vc_tbl_list.tablespace||'
                                        STORAGE (INITIAL 65536 MINEXTENTS 1 MAXEXTENTS 2147483645)
                                        NOPARALLEL
                                        LOGGING';
                  end if;
                pck_moi_truong.prc_remote_sql(''||Sql_Text||'');
            end if;

            -- Constraint
            if vc_tbl_list.p_name is not null and vc_tbl_list.p_value is not null then
                Sql_Text := 'ALTER TABLE '||vc_tbl_list.tbl_name||'
                                    ADD CONSTRAINT '||vc_tbl_list.p_name||' PRIMARY KEY ('||vc_tbl_list.p_value||')';
                     -- Set value cho tablespace
                     if vc_tbl_list.tablespace is not null then
                         Sql_Text := Sql_Text ||'
                                        USING INDEX
                                          PCTFREE     10
                                          INITRANS    2
                                          MAXTRANS    255
                                          TABLESPACE  '||vc_tbl_list.tablespace||'
                                          STORAGE   (
                                            INITIAL     65536
                                            MINEXTENTS  1
                                            MAXEXTENTS  2147483645
                                          )';
                      end if;
                pck_moi_truong.prc_remote_sql(''||Sql_Text||'');
            end if;

        END LOOP;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN
                others THEN Prc_Finnal(c_pro_name);
    END;

     /**
     * Thuc hien khoi tao moi truong
     * <p>Khoi tao table tren he thong PNN duoc config trong table tb_tables.
     *@author  Administrator
     *@date    04/08/2013
     *@param   tbl_create, table_space, pk_name,
     *         pk_column, idx_name, idx_column
     *@see PCK_UTL.Prc_Create_Tbl_Pnn
     */
    PROCEDURE Prc_Create_Tbl_Pnn(v_tax_model varchar2)
    IS
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Create_Tbl_Pnn';
        --Cursor table name
        CURSOR c_tbl_create
        IS
              SELECT   id, tbl_name, tablespace, p_name, p_value, index_name, index_value
                FROM   tb_tables where tax_model = ''||v_tax_model||'' or tax_model is null;
        --Cursor column
        CURSOR c_col_name (p_tbl_id VARCHAR2) -- id tb_table
        IS
              SELECT   tbl_id, col_name, TYPE types
                FROM   tb_columns
               WHERE   tbl_id = p_tbl_id;

        v_list_col   VARCHAR2 (1000);
        Sql_Text     varchar2 (2000);
    BEGIN
        FOR vc_tbl_list IN c_tbl_create
            LOOP
            v_list_col := NULL;
            FOR vc_col_name IN c_col_name (vc_tbl_list.id)

            LOOP
                v_list_col := v_list_col|| vc_col_name.col_name || ' '|| vc_col_name.types || ',';

            END LOOP;
            -- create table
            Sql_Text := 'CREATE TABLE '|| vc_tbl_list.tbl_name || '('
                             || SUBSTR (v_list_col, 1, LENGTH (v_list_col) - 1)||
                             ')';
            -- Set value cho tablespace
            if vc_tbl_list.tablespace is not null then
                Sql_Text := Sql_Text ||'
                                    PCTFREE 10
                                    INITRANS 1
                                    MAXTRANS 255
                                    TABLESPACE '||vc_tbl_list.tablespace||'
                                    STORAGE (INITIAL 65536 MINEXTENTS 1 MAXEXTENTS 2147483645)
                                    NOCACHE
                                    MONITORING
                                    NOPARALLEL
                                    LOGGING';
             end if;
            pck_moi_truong.prc_remote_sql_pnn(''||Sql_Text||'');

            -- Index
            if vc_tbl_list.index_name is not null and vc_tbl_list.index_value is not null then
                Sql_Text := 'CREATE INDEX '||vc_tbl_list.index_name||'
                                        ON '||vc_tbl_list.tbl_name||' ('||vc_tbl_list.index_value||' ASC)';
                 -- Set value cho tablespace
                 if vc_tbl_list.tablespace is not null then
                 Sql_Text := Sql_Text ||'
                                        PCTFREE 10
                                        INITRANS 2
                                        MAXTRANS 255
                                        TABLESPACE '||vc_tbl_list.tablespace||'
                                        STORAGE (INITIAL 65536 MINEXTENTS 1 MAXEXTENTS 2147483645)
                                        NOPARALLEL
                                        LOGGING';
                  end if;
                pck_moi_truong.prc_remote_sql_pnn(''||Sql_Text||'');
            end if;

            -- Constraint
            if vc_tbl_list.p_name is not null and vc_tbl_list.p_value is not null then
                Sql_Text := 'ALTER TABLE '||vc_tbl_list.tbl_name||'
                                    ADD CONSTRAINT '||vc_tbl_list.p_name||' PRIMARY KEY ('||vc_tbl_list.p_value||')';
                     -- Set value cho tablespace
                     if vc_tbl_list.tablespace is not null then
                         Sql_Text := Sql_Text ||'
                                        USING INDEX
                                          PCTFREE     10
                                          INITRANS    2
                                          MAXTRANS    255
                                          TABLESPACE  '||vc_tbl_list.tablespace||'
                                          STORAGE   (
                                            INITIAL     65536
                                            MINEXTENTS  1
                                            MAXEXTENTS  2147483645
                                          )';
                      end if;
                pck_moi_truong.prc_remote_sql_pnn(''||Sql_Text||'');
            end if;

        END LOOP;

        Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN
                others THEN Prc_Finnal(c_pro_name);

    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal (p_fnc_name VARCHAR2 ) IS
    BEGIN
        Prc_Remove_Job (p_fnc_name );
        Prc_Ins_Log (p_fnc_name );
    END;
   /***************************************************************************
    EXT_PCK_CONTROL.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Remove_Job (p_pro_name VARCHAR2 )
    IS
        CURSOR c IS
        SELECT JOB FROM user_jobs
            WHERE instr (upper (what ), upper( p_pro_name ))>0 ;
    BEGIN
        FOR v IN c LOOP
            IF ( v. job IS NOT NULL) THEN
                dbms_job .remove (v .job );
            END IF ;
        END LOOP ;
        COMMIT ;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log ( 'Remove_Job_'|| p_pro_name );
    END;
   /***************************************************************************
    EXT_PCK_CONTROL.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log (p_pck VARCHAR2 ) IS
        v_status VARCHAR2 (1 );
        v_ltd NUMBER (4 );
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl (max (ltd ),0 )+1 INTO v_ltd FROM ext_errors WHERE pck = p_pck;
        UPDATE ext_errors SET ltd =v_ltd WHERE ltd =0 AND pck= p_pck ;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY. FORMAT_ERROR_STACK IS NULL THEN
            v_status := 'Y';
        ELSE
            v_status := 'N';
        END IF ;

        -- Insert log
        INSERT INTO ext_errors (seq_number , error_stack , call_stack ,  timestamp ,
                               pck , status )
                      VALUES (ext_seq .NEXTVAL ,
                             DBMS_UTILITY .FORMAT_ERROR_STACK ,
                             DBMS_UTILITY .FORMAT_CALL_STACK ,
                             SYSDATE, p_pck , v_status );
        COMMIT ;
    END;
    /**
     * Thuc hien khoi tao moi truong
     * <p>Khoi tao package tren he thong QLT, QCT duoc config trong table tb_package.
     * <p>Khoi tao bang cach doc du lieu trong file.
     *@author  Administrator
     *@date    20/05/2013
     *@param   p_file, p_dir
     *@see pck_ult.Prc_Crt_Pck_File
     */
    PROCEDURE Prc_Crt_Pck_File (v_tax_model varchar2)is
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Crt_Pck_File';

        filehandler   UTL_FILE.file_type;
        buffer        CLOB;
        sql_text      VARCHAR2 (32767);

        --Lay thong tin file can tao trong table tb_package
        CURSOR c_lstFile is

            select DIRECTORY, PCK_NAME
                from tb_package
            where tax_model = v_tax_model and directory is not null order by PCK_ORDER;
    BEGIN

        FOR vc_lstFile IN c_lstFile
            LOOP
                begin
                    --Create directory
                    EXECUTE immediate 'Create OR replace DIRECTORY FILE_DIR AS '''||vc_lstFile.DIRECTORY||'''';
                    --Grand to all user
                    EXECUTE immediate 'GRANT READ, WRITE ON DIRECTORY FILE_DIR TO public';
                end;
                --UTL_FILE.fopen (thu_muc, ten_file, quyen)
                filehandler := UTL_FILE.fopen ('FILE_DIR', vc_lstFile.PCK_NAME, 'r');
                    LOOP
                        BEGIN
                            UTL_FILE.get_line (filehandler, buffer);

                            sql_text := sql_text || buffer || CHR(10); --new line

                        EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                                EXIT;
                        END;
                    END LOOP;
                    --SQL code
                    pck_moi_truong.prc_remote_sql(sql_text);

                    --Clear sql_text
                    sql_text :='';

                    --Close file
                    UTL_FILE.fclose (filehandler);

                END LOOP;
           Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN OTHERS
            THEN

            Prc_Finnal(c_pro_name);

    END;

    /**
     * Thuc hien khoi tao moi truong
     * <p>Khoi tao package tren he thong PNN duoc config trong table tb_package.
     * <p>Khoi tao bang cach doc du lieu trong file.
     *@package PCK_UTL.Prc_Crt_Pck_File_Pnn
     *@author  Administrator
     *@date    20/05/2013
     *@param   p_file, p_dir
     */
    PROCEDURE Prc_Crt_Pck_File_Pnn (v_tax_model varchar2)is
        c_pro_name CONSTANT VARCHAR2(30) := 'Prc_Crt_Pck_File';

        filehandler   UTL_FILE.file_type;
        buffer        CLOB;
        sql_text      VARCHAR2 (32767);

        --Lay thong tin file can tao trong table tb_package
        CURSOR c_lstFile is

            select DIRECTORY, PCK_NAME
                from tb_package
            where tax_model = v_tax_model and directory is not null order by PCK_ORDER;
    BEGIN

        FOR vc_lstFile IN c_lstFile
            LOOP
                begin
                    --Create directory
                    EXECUTE immediate 'Create OR replace DIRECTORY FILE_DIR AS '''||vc_lstFile.DIRECTORY||'''';
                    --Grand to all user
                    EXECUTE immediate 'GRANT READ, WRITE ON DIRECTORY FILE_DIR TO public';
                end;
                --UTL_FILE.fopen (thu_muc, ten_file, quyen)
                filehandler := UTL_FILE.fopen ('FILE_DIR', vc_lstFile.PCK_NAME, 'r');
                    LOOP
                        BEGIN
                            UTL_FILE.get_line (filehandler, buffer);

                            sql_text := sql_text || buffer || CHR(10); --new line

                        EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                                EXIT;
                        END;
                    END LOOP;
                    --SQL code
                    pck_moi_truong.prc_remote_sql_pnn(sql_text);

                    --Clear sql_text
                    sql_text :='';
                    --Close file
                    UTL_FILE.fclose (filehandler);
                END LOOP;
           Prc_Finnal(c_pro_name);

        EXCEPTION
            WHEN OTHERS
            THEN

            Prc_Finnal(c_pro_name);

    END;

    /**
     * Thuc hien dong bo can cu tinh thue gia tri gia tang,
     *<p> va chi tiet to khai 10 tren he thong TMS
     *
     *@author  Administrator
     *@date    10/07/2013
     *@param   p_short_name
     *@see PCK_UTL.Prc_sync_01_thkh
     */
    PROCEDURE Prc_sync_01_thkh (p_short_name varchar2) is
        v_ma_cqt varchar2(10);
    BEGIN
        --get ma cqt
        select tax_code into v_ma_cqt from tb_lst_taxo where short_name = p_short_name;
        --Update 01/THKH
        UPDATE   tb_01_thkh_hdr a
           SET
                 (a.tkh_id,
                 a.ma_cqt,
                 a.tin,
                 a.ten_nnt,
                 a.kytt_tu_ngay,
                 a.kytt_den_ngay,
                 a.ngay_htoan,
                 a.ngay_nop_tk,
                 a.han_nop,
                 a.short_name,
                 a.tax_model,
                 a.ma_cbo,
                 a.ten_cbo,
                 a.ma_pban,
                 a.ten_pban,
                 a.thnhap_tinhthue,
                 a.doanh_thu_ts_5,
                 a.gtgt_chiu_thue_ts_5,
                 a.thue_gtgt_ts_5,
                 a.doanh_thu_ts_10,
                 a.gtgt_chiu_thue_ts_10,
                 a.thue_gtgt_ts_10,
                 a.tm_1701
                 ) =
                     (SELECT   b.tkh_id,
                               b.ma_cqt,
                               b.tin,
                               b.ten_nnt,
                               b.kytt_tu_ngay,
                               b.kytt_den_ngay,
                               b.ngay_htoan,
                               b.ngay_nop_tk,
                               b.han_nop,
                               b.short_name,
                               b.tax_model,
                               b.ma_cbo,
                               b.ten_cbo,
                               b.ma_pban,
                               b.ten_pban,
                               b.thnhap_tinhthue,
                               b.doanh_thu_ts_5,
                               b.gtgt_chiu_thue_ts_5,
                               b.thue_gtgt_ts_5,
                               b.doanh_thu_ts_10,
                               b.gtgt_chiu_thue_ts_10,
                               b.thue_gtgt_ts_10,
                               b.tm_1701
                        FROM   tb_cctt b
                       WHERE       a.ma_cqt = b.ma_cqt
                               AND a.tin = b.tin
                               AND a.ma_cqt = v_ma_cqt)
         WHERE   a.ma_cqt = v_ma_cqt
                 AND EXISTS
                        (SELECT   1
                           FROM   tb_cctt c
                          WHERE       a.ma_cqt = c.ma_cqt
                                  AND a.tin = c.tin
                                  AND c.ma_cqt = v_ma_cqt);
        --Insert
        INSERT INTO tb_01_thkh_hdr (id,
                            tkh_id,
                            ma_cqt,
                            tin,
                            ten_nnt,
                            kytt_tu_ngay,
                            kytt_den_ngay,
                            ngay_htoan,
                            ngay_nop_tk,
                            han_nop,
                            short_name,
                            tax_model,
                            ma_cbo,
                            ten_cbo,
                            ma_pban,
                            ten_pban,
                            thnhap_tinhthue,
                            doanh_thu_ts_5,
                            gtgt_chiu_thue_ts_5,
                            thue_gtgt_ts_5,
                            doanh_thu_ts_10,
                            gtgt_chiu_thue_ts_10,
                            thue_gtgt_ts_10,
                            tm_1701)
    SELECT   seq_data_cdoi.NEXTVAL id,
             b.tkh_id,
             b.ma_cqt,
             b.tin,
             b.ten_nnt,
             b.kytt_tu_ngay,
             b.kytt_den_ngay,
             b.ngay_htoan,
             b.ngay_nop_tk,
             b.han_nop,
             b.short_name,
             b.tax_model,
             b.ma_cbo,
             b.ten_cbo,
             b.ma_pban,
             b.ten_pban,
             b.thnhap_tinhthue,
             b.doanh_thu_ts_5,
             b.gtgt_chiu_thue_ts_5,
             b.thue_gtgt_ts_5,
             b.doanh_thu_ts_10,
             b.gtgt_chiu_thue_ts_10,
             b.thue_gtgt_ts_10,
             b.tm_1701
      FROM   tb_cctt b
     WHERE   b.ma_cqt = v_ma_cqt
             AND b.tin NOT IN (SELECT   tin FROM tb_01_thkh_hdr)
        ;
    --commit
    commit;

    END;

END;
