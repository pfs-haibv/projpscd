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


