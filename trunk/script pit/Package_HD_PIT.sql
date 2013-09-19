-- Start of DDL Script for Package TKTQ.PCK_CDOI_DLIEU_QCT
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_cdoi_dlieu_qct
IS
    PROCEDURE Prc_Thop(p_short_name varchar2);
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Job_Qlt_Thop_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Job_Qct_Thop_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Job_Qct_Thop_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Job_Qct_Thop_Tk(p_short_name VARCHAR2);
    
    PROCEDURE Prc_Qlt_Get_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_Tk(p_short_name VARCHAR2);
    PROCEDURE Prc_Qct_Get_Pt(p_short_name VARCHAR2);
    
    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2); 
    PROCEDURE Prc_Dchinh_No_Qct(p_short_name VARCHAR2);   
END;
/


-- End of DDL Script for Package TKTQ.PCK_CDOI_DLIEU_QCT

-- Start of DDL Script for Package TKTQ.PCK_CDOI_DLIEU_QLT
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_cdoi_dlieu_qlt
IS
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_short_name varchar2);
    PROCEDURE Prc_Job_Qlt_Thop_No(p_short_name varchar2);
    PROCEDURE Prc_Qlt_Get_Ps(p_short_name VARCHAR2);
    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2);

    PROCEDURE Prc_Thop(p_short_name varchar2);
    
    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Dchinh_No_Qlt(p_short_name VARCHAR2);
    PROCEDURE Prc_Dchinh_No(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Slech_MST(p_short_name VARCHAR2);
END;
/


-- End of DDL Script for Package TKTQ.PCK_CDOI_DLIEU_QLT

-- Start of DDL Script for Package TKTQ.PCK_CHECK_DATA
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_check_data
IS
   TYPE t_array IS TABLE OF tb_data_error%ROWTYPE
      INDEX BY BINARY_INTEGER;

   -- Modify by ManhTV3 on 24/02/2012
   PROCEDURE prc_ktra_du_lieu_no (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   );

   -- Modify by ManhTV3 on 24/02/2012
   PROCEDURE prc_ktra_du_lieu_ps (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   );

   -- Modify by ManhTV3 on 28/02/2012
   PROCEDURE prc_ktra_du_lieu_tk (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   );

   -- Modify by ManhTV3 on 11/03/2012
   FUNCTION fnc_split (p_short_name VARCHAR2, p_table_name VARCHAR2)
      RETURN t_array;

   -- Modify by ManhTV3 on 11/03/2012
   PROCEDURE prc_insert_splitted_err (
      p_short_name   VARCHAR2,
      p_table_name   VARCHAR2
   );

   PROCEDURE prc_ktra_dlieu_kylb (p_short_name VARCHAR2);

   -- Modify by ManhTV3 on 31/05/2012
   PROCEDURE prc_dchieu_vs_master (p_short_name VARCHAR2);
   -- Modify by ManhTV3 on 31/05/2012
   PROCEDURE prc_tang_gtri_update_no (p_short_name VARCHAR2);
   PROCEDURE prc_htro_dchieu(p_short_name VARCHAR2);
   PROCEDURE Prc_Jobs_Htdc(p_short_name VARCHAR2);
   PROCEDURE Prc_Check_Dblink(p_short_name VARCHAR2);
   PROCEDURE prc_htro_dchieu_vat (p_short_name VARCHAR2);
   PROCEDURE prc_ktra_truoc_cdoi_tk (p_short_name VARCHAR2);
END;
/


-- End of DDL Script for Package TKTQ.PCK_CHECK_DATA

-- Start of DDL Script for Package TKTQ.PCK_CHUYENDOI_VAT
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_chuyendoi_vat
  IS
--
-- To modify this template, edit file PKGSPEC.TXT in TEMPLATE 
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the package
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------       
   -- Enter package declarations as shown below

   PROCEDURE Prc_Tong_Dulieuphatsinh(p_short_name VARCHAR2);
   FUNCTION Fnc_convert_font_data(P_instring VARCHAR2)   
   RETURN VARCHAR2;
   PROCEDURE Prc_reset_log(p_short_name VARCHAR2, kind VARCHAR2);
   PROCEDURE Prc_Capnhatdanhmuc(p_short_name VARCHAR2);
   PROCEDURE Prc_ChitietTK10(p_short_name VARCHAR2);
   FUNCTION  Fnc_ChitietTK10(p_short_name VARCHAR2) RETURN NUMBER;
END; -- Package spec
/


-- End of DDL Script for Package TKTQ.PCK_CHUYENDOI_VAT

-- Start of DDL Script for Package TKTQ.PCK_CUTOVER
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_cutover
IS
    PROCEDURE Prc_Chan_Chuc_Nang(p_short_name VARCHAR2);
    PROCEDURE Prc_Tat_Toan(p_short_name VARCHAR2);
    PROCEDURE Prc_Dmuc_Hluc(p_short_name VARCHAR2);
END pck_cutover;
/


-- End of DDL Script for Package TKTQ.PCK_CUTOVER

-- Start of DDL Script for Package TKTQ.PCK_JAVA_WIN
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_java_win IS   
    PROCEDURE Prc_Host(p_command IN Varchar2);
END;
/


-- End of DDL Script for Package TKTQ.PCK_JAVA_WIN

-- Start of DDL Script for Package TKTQ.PCK_MANHTV
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_manhtv
  IS
--
-- To modify this template, edit file PKGSPEC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the package
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------
   -- Enter package declarations as shown below

    procedure prc_temp(p_string varchar2);

END; -- Package spec
/


-- End of DDL Script for Package TKTQ.PCK_MANHTV

-- Start of DDL Script for Package TKTQ.PCK_MOI_TRUONG
-- Generated 15-Jan-2013 13:16:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_moi_truong
IS
    PROCEDURE Prc_Cre_DBlink(p_short_name VARCHAR2);
    PROCEDURE Prc_Close_DBlink(p_link VARCHAR2);
    PROCEDURE Prc_Drop_DBlink(p_link VARCHAR2);
    PROCEDURE Prc_Remote_Sql(p_sql IN VARCHAR2);
    
    PROCEDURE Prc_Ktao_Seq;
    PROCEDURE Prc_DDep_Seq;
    PROCEDURE Prc_Ktao_tb_ext_qlt_ps;    
    PROCEDURE Prc_Ddep_tb_ext_qlt_ps;
    PROCEDURE Prc_Ktao_tb_ext_qlt_no;    
    PROCEDURE Prc_Ddep_tb_ext_qlt_no;
    PROCEDURE Prc_Ktao_tb_ext_qct_no;
    PROCEDURE Prc_Ddep_tb_ext_qct_no;    
    PROCEDURE Prc_Ktao_tb_ext_qct_ps;
    PROCEDURE Prc_Ddep_tb_ext_qct_ps;    
    PROCEDURE Prc_Ktao_tb_ext_qct_tk;
    PROCEDURE Prc_Ddep_tb_ext_qct_tk;
    PROCEDURE Prc_Ktao_tb_ext_slech_no;
    PROCEDURE Prc_Ddep_tb_ext_slech_no;            
    PROCEDURE Prc_Ktao_pck_qlt;
    PROCEDURE Prc_DDep_pck_qlt;
    PROCEDURE Prc_Ktao_Pck_Qct;
    PROCEDURE Prc_Ddep_Pck_Qct;   
    PROCEDURE Prc_Ktao_tb_ext_errors;
    PROCEDURE Prc_Ddep_tb_ext_errors;
    PROCEDURE Prc_Ktao_tb_ext_temp_dchieu;
    PROCEDURE Prc_Ddep_tb_ext_temp_dchieu;
    PROCEDURE Prc_Ktao_vw_qlt_dchieu_ps;
    PROCEDURE Prc_Ktao_vw_qlt_dchieu_no;
    PROCEDURE Prc_Ktao_vw_qct_dchieu_ps;
    PROCEDURE Prc_Ktao_vw_qct_dchieu_no;
    
    PROCEDURE Prc_Ktao_Qlt(p_short_name varchar2);
    PROCEDURE Prc_Ddep_Qlt(p_short_name varchar2);
    PROCEDURE Prc_Ktao_Qct(p_short_name varchar2);
    PROCEDURE Prc_Ddep_Qct(p_short_name varchar2);
    
    PROCEDURE Prc_Ktao(p_short_name VARCHAR2);
    PROCEDURE Prc_Ddep(p_short_name VARCHAR2);    
           
    PROCEDURE Prc_Set_glView(p_short_name VARCHAR2);
    PROCEDURE Prc_Get_Errors(p_short_name VARCHAR2);
    PROCEDURE Prc_Chot_Dlieu(p_short_name varchar2);
   
END;
/


-- End of DDL Script for Package TKTQ.PCK_MOI_TRUONG

-- Start of DDL Script for Package TKTQ.PCK_QCT_SLECH_MST
-- Generated 15-Jan-2013 13:16:07 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_qct_slech_mst
  IS

END; -- Package spec
/


-- End of DDL Script for Package TKTQ.PCK_QCT_SLECH_MST

-- Start of DDL Script for Package TKTQ.PCK_QLT_SLECH_MST
-- Generated 15-Jan-2013 13:16:07 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_qlt_slech_mst
IS
   PROCEDURE prc_jobs_gets_slech_mst (p_short_name VARCHAR2);

   PROCEDURE prc_gets_slech_mst (p_short_name VARCHAR2);

   PROCEDURE prc_load_dsach_dtnt (p_short_name VARCHAR2);

   PROCEDURE prc_sets_update_no (p_short_name VARCHAR2);

   PROCEDURE prc_unload_dsach_dtnt (p_short_name VARCHAR2);

   PROCEDURE prc_ins_slech (p_short_name VARCHAR2);
END;                                                           -- Package spec
/


-- End of DDL Script for Package TKTQ.PCK_QLT_SLECH_MST

-- Start of DDL Script for Package TKTQ.PCK_TRACE_LOG
-- Generated 15-Jan-2013 13:16:07 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_trace_log
IS
/*******************************************************************************
  Su dung cho viec trace time log khi co error, error luc nao, cho nao ?
  Declare:
    Tao table cho viec insert du lieu
        CREATE TABLE tb_log_pck
        (
            id           NUMBER(10, 0),
            short_name   VARCHAR2(7 BYTE),
            time_exec    DATE,
            pck          VARCHAR2(50 BYTE),
            status       VARCHAR2(2 BYTE),
            ltd          NUMBER(3, 0),
            where_log    VARCHAR2(50 BYTE),
            err_code     VARCHAR2(1000 BYTE)
        )
        /
        CREATE UNIQUE INDEX pk_tb_log_pck ON tb_log_pck (id ASC)
        /
        CREATE INDEX ind_tlp_short_name ON tb_log_pck (short_name ASC)
        /
        CREATE INDEX ind_log_pck_ltd ON tb_log_pck (ltd ASC)
        /
        ALTER TABLE tb_log_pck
          ADD CONSTRAINT pk_log_pck PRIMARY KEY (id)
        /
        ALTER TABLE tb_log_pck
          ADD CONSTRAINT uq_log_pck UNIQUE (short_name, time_exec, pck)
        USING INDEX

  Example:

    PROCEDURE Prc_Ins_Log IS
        v_error_message varchar2(255);
        v_trace pck_trace_log.error_rt;
    BEGIN
        v_error_message:=SQLERRM;
        v_trace := pck_trace_log.info(DBMS_UTILITY.format_error_backtrace);
        INSERT INTO EXT_ERROR_LOG(time_log, where_log, err_code)
        VALUES(sysdate,
               v_trace.program_name||' at line: '||v_trace.line_number,
               v_error_message);
    END;
*******************************************************************************/
    c_name_delim   CONSTANT CHAR (1) := '"';
    c_dot_delim    CONSTANT CHAR (1) := '.';
    c_line_delim   CONSTANT CHAR (4) := 'line';
    c_eol_delim    CONSTANT CHAR (1) := CHR (10);

    rindex       PLS_INTEGER := dbms_application_info.set_session_longops_nohint;
    slno         PLS_INTEGER;
    target       PLS_INTEGER := 0;          -- ie. The object being worked on
    CONTEXT      PLS_INTEGER;               -- Any info
    sofar        NUMBER;                    -- how far proceeded
    totalwork    NUMBER := 1000000;         -- finished when sofar=totalwork
    target_desc  VARCHAR2(32) := 'A long running procedure';
    units        VARCHAR2(32) := 'inserts';  -- unit of sofar and totalwork

    TYPE error_rt IS RECORD (
      /* Thuoc tinh gia tri user dang nhap*/
      program_owner   all_objects.owner%TYPE
      /* Thuoc tinh gia tri Package */
     ,program_name    all_objects.object_name%TYPE
      /* Thuoc tinh gia tri dong bi loi */
     ,line_number     PLS_INTEGER
    );

    FUNCTION info (backtrace_in IN VARCHAR2) RETURN error_rt;

    PROCEDURE Prc_dbms_app_info(p_pck_name IN VARCHAR2, p_target_desc IN VARCHAR2);

    PROCEDURE Prc_Ins_Log(p_short_name VARCHAR2 DEFAULT NULL,
                          p_pck VARCHAR2,
                          p_status VARCHAR2 DEFAULT NULL);

    PROCEDURE Prc_Ins_Log_Vs(p_short_name VARCHAR2,
                             p_pck VARCHAR2,
                             p_status VARCHAR2,
                             p_mesg VARCHAR2);

    PROCEDURE Prc_Upd_Log_Max(p_short_name VARCHAR2,
                              p_pck VARCHAR2);
                              
    PROCEDURE Prc_Upd_Log(p_id NUMBER,
                          p_status VARCHAR2,
                          p_error_message VARCHAR2 DEFAULT NULL);
    PROCEDURE Prc_Out_Log;

    PROCEDURE Prc_WhoCalledMe(p_owner     OUT VARCHAR2,
                              p_type      OUT VARCHAR2,
                              p_name      OUT VARCHAR2,
                              p_lineNo    OUT PLS_INTEGER);
    FUNCTION Fnc_WhoCalledMe RETURN VARCHAR2;
    
/*******************************************************************************
This is the test harness I use to try out different ideas.
It shows two vital sets of statistics for me.
    The elapsed time difference between two approaches
    How many resources each approach takes

Requirements:
    In order to run this test harness you must at a minimum have:
    - Access to V$STATNAME, V$MYSTAT, v$TIMER and V$LATCH
    - You must be granted select DIRECTLY on SYS.V_$STATNAME, SYS.V_$MYSTAT,
      SYS.V_$TIMER and SYS.V_$LATCH.
      It will not work to have select on these via a ROLE.
    - The ability to create a table -- run_stats -- to hold the before, during and after information.
    - The ability to create a package -- rs_pkg -- the statistics collection/reporting piece
DECLARE:
    create global temporary table run_stats
    ( runid varchar2(15),
      name varchar2(80),
      value int )
    on commit preserve rows
    /
    create or replace view stats
    as select 'STAT...' || a.name name, b.value
          from v$statname a, v$mystat b
         where a.statistic# = b.statistic#
        union all
        select 'LATCH.' || name,  gets
          from v$latch
        union all
        select 'STAT...Elapsed Time', hsecs from v$timer;
*******************************************************************************/
    g_start NUMBER;
    g_run1  NUMBER;
    g_run2  NUMBER;

    PROCEDURE rs_start;
    PROCEDURE rs_middle;
    PROCEDURE rs_stop( p_difference_threshold IN NUMBER DEFAULT 0 );
    
END pck_trace_log;
/


-- End of DDL Script for Package TKTQ.PCK_TRACE_LOG

-- Start of DDL Script for Package TKTQ.PCK_ULT
-- Generated 15-Jan-2013 13:16:07 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE pck_ult
  IS  
    FUNCTION Fnc_Check_Digit(v_tin IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION Fnc_Check_Tin(P_TIN Varchar2) RETURN NUMBER;
    PROCEDURE Prc_Read_File(p_fname Varchar2, p_id_hdr number);
    FUNCTION Fnc_Excel_Tag_Cell(p_style VARCHAR2, 
                               p_type VARCHAR2, 
                               p_data VARCHAR2) RETURN VARCHAR2;
    PROCEDURE Prc_Write_File(p_sql varchar2,
                             p_dir varchar2,
                             p_fname varchar2, 
                             p_separator varchar2 DEFAULT ',');
    FUNCTION Fnc_Find_strInFile(p_dir Varchar2, p_fname Varchar2, p_str Varchar2) RETURN boolean;
    FUNCTION Fnc_Split_strFile(p_str Varchar2) RETURN varchar2;
    FUNCTION Fnc_Split_strFolder(p_str Varchar2) RETURN varchar2;    
END;
/


-- End of DDL Script for Package TKTQ.PCK_ULT

