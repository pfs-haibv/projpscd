CREATE OR REPLACE 
PACKAGE BODY pck_qlt_slech_mst
IS
   /* PCK_QLT_SLECH_MST.Prc_Jobs_Gets_Slech_Mst
    * Modify by ManhTV3 on 19.06.2012
    * Tao jobs lay sai lech ma so thue
    **/
   PROCEDURE prc_jobs_gets_slech_mst (p_short_name VARCHAR2)
   IS
   BEGIN
      DBMS_SCHEDULER.create_job
         (job_name        => DBMS_SCHEDULER.generate_job_name ('QLT_SLECH_'|| p_short_name|| '_'),
          job_type        => 'PLSQL_BLOCK',
          job_action      =>    'BEGIN
                        PCK_QLT_SLECH_MST.PRC_GETS_SLECH_MST('''|| p_short_name|| ''');
                        END;',
          enabled         => TRUE,
          auto_drop       => TRUE
         );
      pck_trace_log.prc_ins_log (p_short_name, 'PRC_HTRO_DCHIEU', 'P');
   END;

   /* PCK_QLT_SLECH_MST.Prc_Gets_Slech_Mst
    * Modify by ManhTV3 on 19.06.2012
    * lay sai lech ma so thue
    **/
   PROCEDURE prc_gets_slech_mst (p_short_name VARCHAR2)
   IS
   BEGIN
      prc_load_dsach_dtnt (p_short_name);
      prc_sets_update_no (p_short_name);
      prc_ins_slech (p_short_name);
      prc_unload_dsach_dtnt (p_short_name);
      pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
      COMMIT;
      EXCEPTION
      WHEN OTHERS
      THEN
         pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
   END;

   /* PCK_QLT_SLECH_MST.Prc_Gets_Slech_Mst
    * Modify by ManhTV3 on 19.06.2012
    * Set client_info
    **/
   PROCEDURE prc_load_dsach_dtnt (p_short_name VARCHAR2)
   IS
   BEGIN
      EXECUTE IMMEDIATE    '
        BEGIN
          DBMS_APPLICATION_INFO.set_client_info ('''
                        || p_short_name
                        || ''');
          qlt_pck_thop_no_thue.prc_load_dsach_dtnt@qlt_'
                        || p_short_name
                        || ';
        END;';
   END;

   PROCEDURE prc_unload_dsach_dtnt (p_short_name VARCHAR2)
   IS
   BEGIN
      EXECUTE IMMEDIATE    '
        BEGIN
           qlt_pck_thop_no_thue.prc_unload_dsach_dtnt@qlt_'
                        || p_short_name
                        || ';
        END;';
   END;

   /*
    * PCK_QLT_SLECH_MST.Prc_Sets_Update_No
    * Modify by ManhTV3 on 21.06.2012
    * Update field update_no
    **/
   PROCEDURE prc_sets_update_no (p_short_name VARCHAR2)
   IS
   BEGIN
      UPDATE tb_slech_tin
         SET update_no = (SELECT NVL (MAX (update_no), 0) + 1 old_upd
                            FROM tb_slech_tin
                           WHERE short_name = p_short_name)
       WHERE update_no = 0
         AND short_name = p_short_name
         AND (SELECT 1
                FROM tb_slech_tin
               WHERE update_no = 0 AND short_name = p_short_name
                     AND ROWNUM = 1) IS NOT NULL;

      COMMIT;
   END;

   PROCEDURE prc_ins_slech (p_short_name VARCHAR2)
   IS
      v_sql   VARCHAR2 (10000);
   BEGIN

      EXECUTE IMMEDIATE    'BEGIN
            INSERT INTO tb_slech_tin(tin, status, regi_date, payer_type, norm_name,
                                 ten_phong, ten_canbo, update_no, short_name)
             select a.tin, a.status, a.regi_date, a.payer_type, a.norm_name,
                    (select ten
                       from qlt_phongban@qlt_'
                        || p_short_name
                        || ' pb
                      where pb.ma_phong = nnt.ma_phong) ten_phong,
                    (select ten
                       from qlt_canbo@qlt_'
                        || p_short_name
                        || ' cb
                      where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                    0 update_no, '''
                        || p_short_name
                        || ''' short_name
               from tin_payer@qlt_'
                        || p_short_name
                        || ' a, qlt_nsd_dtnt@qlt_'
                        || p_short_name
                        || ' nnt
              where update_no = 0
                and (regi_date is null
                        or
                     status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
                and (
                     exists (select 1
                               from qlt_so_thue@qlt_'
                        || p_short_name
                        || ' b
                              where b.tin = a.tin)
                        or
                     exists (select 1
                               from qlt_so_no@qlt_'
                        || p_short_name
                        || ' c
                              where c.tin = a.tin))
                and a.tin(+) = nnt.tin
              union all
             select a.tin, a.status, a.regi_date, a.payer_type, a.norm_name,
                    (select ten
                       from qlt_phongban@qlt_'
                        || p_short_name
                        || ' pb
                      where pb.ma_phong = nnt.ma_phong) ten_phong,
                    (select ten from qlt_canbo@qlt_'
                        || p_short_name
                        || ' cb
                      where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                    0 update_no, '''
                        || p_short_name
                        || ''' short_name
               from tin_personal_payer@qlt_'
                        || p_short_name
                        || ' a, qlt_nsd_dtnt@qlt_'
                        || p_short_name
                        || ' nnt
              where update_no = 0
                and (regi_date is null
                        or
                     status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
                and (
                     exists (select 1
                               from qlt_so_thue@qlt_'
                        || p_short_name
                        || ' b
                              where b.tin = a.tin)
                     or
                     exists (select 1
                               from qlt_so_no@qlt_'
                        || p_short_name
                        || ' c
                              where c.tin = a.tin))
                and a.tin(+) = nnt.tin;
      END;';
   END;
END;
/


