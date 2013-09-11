CREATE OR REPLACE 
PACKAGE BODY ext_pck_pnn
IS
    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Finnal
    ***************************************************************************/
    PROCEDURE prc_finnal (p_fnc_name VARCHAR2)
    IS
    BEGIN
        prc_remove_job (p_fnc_name);
        prc_ins_log (p_fnc_name);
    END;

    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Create_Job
    ***************************************************************************/
    PROCEDURE prc_create_job (p_name_exe VARCHAR2)
    IS
        jobno   user_jobs.job%TYPE;
    BEGIN
        DBMS_JOB.submit (jobno,
                         p_name_exe,
                         SYSDATE + 10 / 86400,
                         'SYSDATE + 365');
        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            prc_ins_log ('Create_Job_' || p_name_exe);
    END;

    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Del_Log
    ***************************************************************************/
    PROCEDURE prc_del_log (p_pck VARCHAR2)
    IS
        v_status   VARCHAR2 (1);
        v_ltd      NUMBER (4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT   NVL (MAX (ltd), 0) + 1
          INTO   v_ltd
          FROM   ext_errors
         WHERE   pck = p_pck;

        UPDATE   ext_errors
           SET   ltd = v_ltd
         WHERE   ltd = 0 AND pck = p_pck;
    END;

    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE prc_remove_job (p_pro_name VARCHAR2)
    IS
        CURSOR c
        IS
            SELECT   job
              FROM   user_jobs
             WHERE   INSTR (UPPER (what), UPPER (p_pro_name)) > 0;
    BEGIN
        FOR v IN c
        LOOP
            IF (v.job IS NOT NULL)
            THEN
                DBMS_JOB.remove (v.job);
            END IF;
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            prc_ins_log ('Remove_Job_' || p_pro_name);
    END;

    /***************************************************************************
    TMS_QLT_CDOI_TK.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE prc_ins_log (p_pck VARCHAR2)
    IS
        v_status   VARCHAR2 (1);
        v_ltd      NUMBER (4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT   NVL (MAX (ltd), 0) + 1
          INTO   v_ltd
          FROM   ext_errors
         WHERE   pck = p_pck;

        UPDATE   ext_errors
           SET   ltd = v_ltd
         WHERE   ltd = 0 AND pck = p_pck;

        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.format_error_stack IS NULL
        THEN
            v_status := 'Y';
        ELSE
            v_status := 'N';
        END IF;

        -- Insert log
        INSERT INTO ext_errors (seq_number,
                                error_stack,
                                call_stack,
                                timestamp,
                                pck,
                                status)
          VALUES   (ext_seq.NEXTVAL,
                    DBMS_UTILITY.format_error_stack,
                    DBMS_UTILITY.format_call_stack,
                    SYSDATE,
                    p_pck,
                    v_status);

        COMMIT;
    END;

    /**
     * @package: ext_pck_pnn.prc_job_pnn_thop_no
     * @desc:    Chuyen doi so con phai nop, nop thua
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:   p_chot
     */
    PROCEDURE prc_job_pnn_thop_no (p_chot DATE, tax_code varchar2)
    IS
    BEGIN
        prc_del_log ('prc_pnn_thop_no');
        COMMIT;
        prc_create_job('BEGIN EXT_PCK_PNN.prc_pnn_thop_no('''
                                                        || p_chot || ''', '''||tax_code||''');
                        END;'
                             );
    END;

    PROCEDURE prc_pnn_thop_no (p_chot DATE, tax_code varchar2)
    IS
    BEGIN
        --Clear data
        DBMS_UTILITY.exec_ddl_statement ('truncate table ext_pnn_no');

        INSERT INTO ext_pnn_no a
        (
        a.id,
        a.ma_cqt,
        a.ma_tkhai,
        a.ngay_qd,
        a.tin,
        a.han_nop,
        a.tkhoan,
        a.ma_chuong,
        a.ma_khoan,
        a.tmt_ma_tmuc,
        a.ngay_hach_toan,
        a.kykk_tu_ngay,
        a.so_tien
       )
         SELECT
            ext_seq.NEXTVAL id,
            a.ma_cqt,
            a.ma_tkhai,
            to_char(a.ky_htoan, 'DD/MM/YYYY') ngay_qd,
            a.nnt_tin tin,
            CASE
             WHEN TO_CHAR (a.ky_htoan, 'YYYY') =
                      TO_CHAR (p_chot, 'YYYY')
             THEN
                 TO_CHAR(LAST_DAY (p_chot), 'DD/MM/YYYY')
             ELSE
                 TO_CHAR(LAST_DAY (p_chot), 'DD/MM/YYYY')
         END
             AS han_nop,
            '741' tkhoan,
            a.nnt_chuong ma_chuong,
            '000' ma_khoan,
            a.ma_tmuc tmt_ma_tmuc,
            CASE
                 WHEN TO_CHAR (a.ky_htoan, 'YYYY') =
                          TO_CHAR (p_chot, 'YYYY')
                 THEN
                     TO_CHAR(LAST_DAY (p_chot), 'DD/MM/YYYY')
                 ELSE
                     TO_CHAR(LAST_DAY (p_chot), 'DD/MM/YYYY')
             END
             AS ngay_hach_toan,
         --Neu ky kê khai nho hon 01/2005: dua ve ky kê khai 01/2005
         CASE
             WHEN a.ky_kkhai < LAST_DAY (p_chot)
             THEN
                 '01/01/2005'
             --   Neu ky kê khai tu ngày không phai là ngày dau tháng/ quý/ nam:
             --   Ky kê khai tu ngày = ngày dau tiên cua tháng chua ky kê khai tu ngày
         ELSE
                 '01/' || TO_CHAR (a.ky_kkhai, 'MM/YYYY')
         END
             AS kykk_tu_ngay,
             a.sth_chuyen_ksau so_tien
  FROM   pnn_so_tdtn a where a.ma_cqt = tax_code;

    END;

    /**
     * @package: ext_pck_pnn.prc_job_pnn_thop_no
     * @desc:    Chuyen doi chi tiet to khai 01/TK-SDDPNN
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:   p_chot
     */
    PROCEDURE prc_job_pnn_thop_01_tk_sddpnn (p_chot DATE)
    IS
    BEGIN
        dbms_output.put_line('');
    END;

    PROCEDURE prc_pnn_thop_01_tk_sddpnn (p_chot DATE)
    IS
    BEGIN
        dbms_output.put_line('');
    END;

    /**
     * @package: ext_pck_pnn.prc_job_pnn_thop_no
     * @desc:    Chuyen doi chi tiet to khai 02/TK-SDDPNN
     * @author:  Administrator
     * @date:    29/05/2013
     * @param:   p_chot
     */
    PROCEDURE prc_job_pnn_thop_02_tk_sddpnn (p_chot DATE)
    IS
    BEGIN
        dbms_output.put_line('');
    END;

    PROCEDURE prc_pnn_thop_02_tk_sddpnn (p_chot DATE)
    IS
    BEGIN
        dbms_output.put_line('');
    END;


END;
/


