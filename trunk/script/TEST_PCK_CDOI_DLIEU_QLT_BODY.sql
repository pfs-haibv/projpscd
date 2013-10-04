-- Start of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_QLT
-- Generated 04/10/2013 2:41:53 PM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_cdoi_dlieu_qlt
IS
    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_Ps(p_short_name)
    Noi dung: Tong hop du lieu phat sinh QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_ps (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
               EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ps@QLT_'
                         || p_short_name
                         || '('''
                         || p_chot
                         || ''');
             END;'
                  ;
        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_job_qlt_thop_ps');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_Ckt(p_short_name)
    Noi dung: Tong hop du lieu con khau tru QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_ckt (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
               EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_Ckt@QLT_'
                         || p_short_name
                         || '('''
                         || p_chot
                         || ''');
             END;'
                  ;

        pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_QLT_GET_Ckt');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_Ckt');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_No(p_short_name)
    Noi dung: Tong hop du lieu nghia vu thue QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_no (p_short_name VARCHAR2)
    IS
        p_chot   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_chot
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                EXT_PCK_QLT_CONTROL.Prc_Job_Qlt_Thop_No@QLT_'
                         || p_short_name
                         || '('''
                         || p_chot
                         || ''');
             END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_QLT_GET_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_job_slech_no (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        EXECUTE IMMEDIATE 'BEGIN
                                ext_pck_qlt_chk_stn.Prc_Job_Qlt_Slech_No@QLT_'
                                         || p_short_name
                                         || ';
                           END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_GET_SLECH_NO');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Thop(p_short_name)
    Noi dung: Tong hop du lieu
    ***************************************************************************/
    PROCEDURE prc_thop (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set REMOTE_DEPENDENCIES_MODE=SIGNATURE';
    END;

    /*************************************************************************** PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_Ps(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin ps tu CQT
    ***************************************************************************/
    PROCEDURE prc_qlt_get_ps (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_ps
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        EXECUTE IMMEDIATE '
             INSERT INTO tb_ps (stt, loai, tax_model, ma_cqt, ma_tkhai,ma_tkhai_tms,
               short_name, tkhoan, tin, ma_chuong, ma_khoan, ma_tmuc,
               KYKK_TU_NGAY, KYKK_DEN_NGAY,
               han_nop, ngay_htoan,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien)
        SELECT rownum stt, ''TK'' loai, ''QLT-APP'' tax_model,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''
                                                                      || p_short_name || ''') MA_CQT,
                b.ma_loai_tkhai ma_tkhai,
               (Select ma_tkhai_tms from tb_lst_tkhai c where c.ma_loai_tkhai_qlt=b.ma_loai_tkhai and TKHAI_QTOAN IS NULL) ma_tkhai_tms,
               '''

                   || p_short_name || ''' short_name,
               ''TKNS'' tkhoan,
               tin, ma_chuong, ma_khoan, ma_tmuc,
               ky_psinh_tu, ky_psinh_den, han_nop,
               (SELECT to_char(ky_chot, ''DD/MM/YYYY'') FROM tb_lst_taxo WHERE short_name='''

                                                                                              || p_short_name || ''') ngay_htoan,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien
        FROM (
        SELECT tin, ma_chuong, ma_khoan, ma_tmuc,
               ma_loai_tkhai ma_loai_tkhai,
               to_char(ky_psinh_tu, ''DD/MM/YYYY'') ky_psinh_tu,
               to_char(ky_psinh_den, ''DD/MM/YYYY'') ky_psinh_den,
               to_char(min(han_nop), ''DD/MM/YYYY'') han_nop,
               max(ma_cbo) ma_cbo, max(ten_cbo) ten_cbo,
               max(ma_pban) ma_pban, max(ten_pban) ten_pban, sum(so_tien) so_tien
        FROM (SELECT tin, ma_chuong, ma_khoan, ma_tmuc, ma_loai_tkhai,
               ky_psinh_tu, ky_psinh_den, han_nop,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien
        FROM ext_qlt_ps@qlt_'

                              || p_short_name || ' a)
        GROUP BY tin, ma_loai_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                 ky_psinh_tu, ky_psinh_den
        ) b Where so_tien <> 0'

                               ;

        COMMIT;

        pck_trace_log.prc_ins_log (p_short_name,
                                   pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
       PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_Ckt(p_short_name)
       Nguoi thuc hien: DuBV
       Ngay thuc hien: 26/04/2013
       Noi dung: lay thong tin Ckt tu CQT
       ***************************************************************************/
    PROCEDURE prc_qlt_get_ckt (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_ps
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        EXECUTE IMMEDIATE '
             INSERT INTO tb_con_kt (stt, tax_model, ma_cqt, ma_tkhai, ma_tkhai_tms,
               short_name, tin, ma_chuong, ma_khoan, ma_tmuc,
               KYKK_TU_NGAY, KYKK_DEN_NGAY,
               han_nop, ngay_htoan,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien)
        SELECT rownum stt, ''QLT-APP'' tax_model,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''

                                                                      || p_short_name || ''') MA_CQT,
               (Select ma_tkhai_qlt from tb_lst_tkhai c where c.ma_loai_tkhai_qlt=b.ma_loai_tkhai and TKHAI_QTOAN IS NULL) ma_tkhai,
               (Select ma_tkhai_tms from tb_lst_tkhai c where c.ma_loai_tkhai_qlt=b.ma_loai_tkhai and TKHAI_QTOAN IS NULL) ma_tkhai_tms,
               '''
                   || p_short_name || ''' short_name,
               tin, ma_chuong, ma_khoan, ma_tmuc,
               ky_psinh_tu, ky_psinh_den, han_nop,
               (SELECT to_char(ky_chot, ''DD/MM/YYYY'')
               FROM tb_lst_taxo WHERE short_name='''|| p_short_name || ''') ngay_htoan,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien
        FROM (
        SELECT tin, ma_chuong, ma_khoan, ma_tmuc,
               ma_loai_tkhai ma_loai_tkhai,
               to_char(ky_psinh_tu, ''DD/MM/YYYY'') ky_psinh_tu,
               to_char(ky_psinh_den, ''DD/MM/YYYY'') ky_psinh_den,
               to_char(min(han_nop), ''DD/MM/YYYY'') han_nop,
               max(ma_cbo) ma_cbo, max(ten_cbo) ten_cbo,
               max(ma_pban) ma_pban, max(ten_pban) ten_pban, sum(so_tien) so_tien
        FROM (SELECT tin, ma_chuong, ma_khoan, ma_tmuc, ma_loai_tkhai,
               KYKK_TU_NGAY ky_psinh_tu, KYKK_DEN_NGAY ky_psinh_den, han_nop,
               ma_cbo, ten_cbo, ma_pban, ten_pban, so_tien
        FROM ext_qlt_con_kt@qlt_'|| p_short_name || ' a)
        GROUP BY tin, ma_loai_tkhai, ma_chuong, ma_khoan, ma_tmuc,
                 ky_psinh_tu, ky_psinh_den
        ) b Where so_tien <> 0'
                               ;

        COMMIT;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin no tu CQT
    ***************************************************************************/
    PROCEDURE prc_qlt_get_no (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_no
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        EXECUTE IMMEDIATE '
        INSERT INTO tb_no(stt, loai, ma_cqt, tin, ma_chuong, ma_khoan,
               tmt_ma_tmuc, tkhoan, NGAY_HTOAN, kykk_tu_ngay,
               kykk_den_ngay, han_nop, so_tien, nguon_goc, tinh_chat,
               so_qd, ngay_qd, no_nte, don_vi_tien, short_name, tax_model,
               ma_cbo, ten_cbo, ma_pban, ten_pban)
        SELECT ROWNUM STT,
               ''CD'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''
                         || p_short_name
                         || ''') MA_CQT,
               tin,
               ma_chuong,
               ma_khoan,
               tmt_ma_tmuc,
               tkhoan tkhoan,
               to_char(ngay_hach_toan,''dd/mm/rrrr'') ngay_hach_toan,
               to_char(kykk_tu_ngay,''dd/mm/rrrr'') kykk_tu_ngay,
               to_char(kykk_den_ngay,''dd/mm/rrrr'') kykk_den_ngay,
               to_char(han_nop,''dd/mm/rrrr'') han_nop,
               so_tien, nguon_goc, tinh_chat, so_qd,
               to_char(ngay_qd,''dd/mm/rrrr'') ngay_qd,
               no_nte, don_vi_tien,
               '''

                         || p_short_name
                         || ''' short_name,
               ''QLT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban
        FROM ext_qlt_no@qlt_'

                         || p_short_name
                         || ' a
        WHERE so_tien<>0 '
                          ;

        -- Ghi log
        --UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_get_slech_no (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        DELETE FROM   tb_slech_no
              WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE '
        INSERT INTO tb_slech_no(short_name, loai, ky_thue,
                        tin, ten_dtnt, tai_khoan, muc, tieumuc, mathue,
                        sothue_no_cky, sono_no_cky, clech_no_cky,
                        ma_cbo, ten_cbo, ma_pban, ten_pban, ma_slech,
                        ma_gdich, ten_gdich)
        SELECT '''       || p_short_name
                         || ''' short_name, loai, ky_thue,
               tin, ten_dtnt, tai_khoan, muc, tieumuc, mathue,
               sothue_no_cky, sono_no_cky, clech_no_cky,
               ma_cbo, ten_cbo, ma_pban, ten_pban, ma_slech, ma_gdich, ten_gdich
          FROM ext_slech_no@QLT_'|| p_short_name
                         || ' WHERE update_no=0';

        COMMIT;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);

        COMMIT;
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Dchinh_No_Qlt(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_dchinh_no_qlt (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        EXECUTE IMMEDIATE '
        BEGIN EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qlt@QLT_'
                         || p_short_name
                         || '; END;';

        pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Dchinh_No(p_short_name)
    ***************************************************************************/
    PROCEDURE prc_dchinh_no (p_short_name VARCHAR2)
    IS
        v_tax_model   VARCHAR2 (3);
    BEGIN
        SELECT   tax_model
          INTO   v_tax_model
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        IF v_tax_model = 'QLT'
        THEN
            pck_cdoi_dlieu_qlt.prc_dchinh_no_qlt (p_short_name);
        ELSIF v_tax_model = 'QCT'
        THEN
            pck_cdoi_dlieu_qct.prc_dchinh_no_qct (p_short_name);
        END IF;
    END;

    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_MST(p_short_name)
    ***************************************************************************/

    PROCEDURE prc_get_slech_mst (p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'begin
            declare
                v_short_name varchar2(7) := '''
                                                || p_short_name || ''';
            begin
                dbms_application_info.set_client_info(v_short_name);
                qlt_pck_thop_no_thue.prc_load_dsach_dtnt@qlt_'

                                                               || p_short_name || ';
            end;

            UPDATE tb_slech_tin
               SET update_no = (select NVL(max(update_no), 0) + 1 old_upd
                                  from tb_slech_tin
                                 where short_name = userenv(''client_info''))
            WHERE update_no = 0 and short_name = userenv(''client_info'')
              and (select 1
             from tb_slech_tin
            where update_no = 0
              and short_name = userenv(''client_info'')
              and rownum = 1) is not null;

            insert into tb_slech_tin(tin, status, regi_date, payer_type, norm_name,
                                     ten_phong, ten_canbo, update_no, short_name)
            select a.tin, a.status, a.regi_date, a.payer_type, a.norm_name,
                   (select ten
                      from qlt_phongban@qlt_'

                                              || p_short_name || ' pb
                     where pb.ma_phong = nnt.ma_phong) ten_phong,
                   (select ten
                      from qlt_canbo@qlt_'

                                           || p_short_name || ' cb
                     where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                   0 update_no, userenv(''client_info'') short_name
              from tin_payer@qlt_'

                                   || p_short_name || ' a, qlt_nsd_dtnt@qlt_' || p_short_name || ' nnt
             where update_no = 0
               and (regi_date is null
                    or status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
               and (
                    exists (select 1
                              from qlt_so_thue@qlt_'

                                                     || p_short_name || ' b where b.tin = a.tin)
                    or
                    exists (select 1
                              from qlt_so_no@qlt_'

                                                   || p_short_name || ' c where c.tin = a.tin)
                   )
               and a.tin(+) = nnt.tin
             union all
            select a.tin, a.status, a.regi_date, a.payer_type, a.norm_name,
                   (select ten
                      from qlt_phongban@qlt_'

                                              || p_short_name || ' pb
                     where pb.ma_phong = nnt.ma_phong) ten_phong,
                   (select ten
                      from qlt_canbo@qlt_'
                                           || p_short_name || ' cb
                     where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                   0 update_no, userenv(''client_info'') short_name
              from tin_personal_payer@qlt_'

                                            || p_short_name || ' a, qlt_nsd_dtnt@qlt_' || p_short_name || ' nnt
             where update_no = 0
               and (regi_date is null
                    or status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
               and (
                     exists (select 1
                               from qlt_so_thue@qlt_'

                                                      || p_short_name || ' b
                              where b.tin = a.tin)
                     or
                     exists (select 1
                               from qlt_so_no@qlt_'
                                                    || p_short_name || ' c
                              where c.tin = a.tin)
                   )
               and a.tin(+) = nnt.tin;

            begin
                qlt_pck_thop_no_thue.prc_unload_dsach_dtnt@qlt_'
                                                                 || p_short_name || ';
            end;

            COMMIT;
        end;'
             ;
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_DKNTK_QT(p_short_name)
    Noi dung: Tong hop du lieu Dang ky nop to khai quyet toan QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE prc_job_qlt_thop_dkntk_qt (p_short_name VARCHAR2)
    IS
        p_tu   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_tu
          FROM   tb_lst_taxo
         WHERE   short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
                               ext_pck_qlt_tkhai.Prc_Job_Qlt_Thop_Dkntk@QLT_'
                                         || p_short_name
                                         || '('''
                                         || p_tu
                                         || ''');
                           END;'
                                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'Prc_Job_Qlt_Thop_DKNTK_QT');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;

    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
    END;

    /**
     * Thuc hien lay du lieu dang ky nop to khai
     *@author Administrator
     *@date 15/04/2013
     *@param p_short_name
     *@see p_short_name
     */
    PROCEDURE prc_qlt_get_dkntk_qt (p_short_name VARCHAR2)
    IS
        c_tax_model   CONSTANT VARCHAR2 (3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data
        DELETE FROM   tb_dkntk
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        --Insert tb_dkntk
        EXECUTE IMMEDIATE '
            INSERT INTO tb_dkntk (  id,
                                    tkh_id,
                                    ma_cqt,
                                    tin,
                                    ten_nnt,
                                    ma_cbo,
                                    ten_cbo,
                                    ma_pban,
                                    ten_pban,
                                    ky_bat_dau,
                                    ky_ket_thuc,
                                    ma_tkhai,
                                    short_name,
                                    tax_model,
                                    ky_bd_hthong_cu,
                                    ky_kt_hthong_cu,
                                    mau_tkhai_tms)
            SELECT   seq_data_cdoi.NEXTVAL id,
                                    id tkh_id,
                                    (SELECT   tax_code FROM tb_lst_taxo WHERE short_name = ''' || p_short_name || ''') ma_cqt,
                                    tin,
                                    ten_nnt,
                                    ma_cbo,
                                    ten_cbo,
                                    ma_pban,
                                    ten_pban,
                                    ky_bd,
                                    ky_kt,
                                    mau_tk,
                                    ''' || p_short_name || ''' short_name,
                                    ''QLT-APP'' tax_model,
                                    ky_bd_qlt,
                                    ky_kt_qlt,
                                    mau_tk_tms
            FROM   ext_dkntk_qt@qlt_'|| p_short_name ||
            ' where tax_model = ''QLT-APP'''
                           ;
        COMMIT;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'Prc_Qlt_Get_DKNTK_QT');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;

    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
    END;

    /**
     * Thuc hien tao job tong hop to khai thue mon bai
     * @author Administrator
     * @param p_short_name
     * @see pck_cdoi_dlieu_qlt.Prc_Job_Qct_Thop_TKTMB(p_short_name)
     */
    PROCEDURE prc_job_qlt_thop_tktmb (p_short_name VARCHAR2)
    IS
        p_tu   DATE;
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        SELECT   ky_chot
          INTO   p_tu
          FROM   tb_lst_taxo
         WHERE   tax_model = 'QLT' AND short_name = p_short_name;

        EXECUTE IMMEDIATE 'BEGIN
               tms_qlt_cdoi_tk.Prc_Job_Qlt_Thop_Monbai@QLT_'
                         || p_short_name
                         || '('''
                         || p_tu
                         || ''');
             END;'
                  ;

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 2
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_job_qlt_thop_tktmb');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');
        COMMIT;

    EXCEPTION
        WHEN OTHERS
        THEN
            pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);

    END;

    /**
     * Thuc hien lay du lieu to khai thue mon bai tu dia phuong
     * @author Administrator
     * @param p_short_name
     * @see pck_cdoi_dlieu_qlt.prc_qlt_get_tktmb(p_short_name)
     */
    PROCEDURE prc_qlt_get_tktmb (p_short_name VARCHAR2)
    IS
        --c_tax_model CONSTANT VARCHAR2(3) := 'QLT';

        CURSOR c_update_hdr_id
        IS
            SELECT   id, tkh_id
              FROM   tb_tkmb_hdr b
             WHERE   b.short_name = '' || p_short_name || ''
                     AND b.tax_model = 'QLT-APP';
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

        --Clear data

        DELETE FROM   tb_tkmb_dtl
              WHERE   hdr_id IN
                              (SELECT   id
                                 FROM   tb_tkmb_hdr
                                WHERE   short_name = p_short_name
                                        AND tax_model = 'QLT-APP');

        DELETE FROM   tb_tkmb_hdr
              WHERE   short_name = p_short_name AND tax_model = 'QLT-APP';

        --Insert tms_tktmb_hdr
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_tkmb_hdr(id,
                                            tkh_id,
                                            ma_cqt,
                                            tin,
                                            ten_nnt,
                                            kytt_tu_ngay,
                                            kytt_den_ngay,
                                            ngay_htoan,
                                            ngay_nop_tk,
                                            han_nop,
                                            ma_cbo,
                                            ten_cbo,
                                            ma_pban,
                                            ten_pban,
                                            short_name,
                                            tax_model,
                                            THUE_PN_NNT,
                                            THUE_PN_CQT,
                                            VON_DKY_NNT,
                                            BMB_NNT,
                                            BMB_CQT,
                                            TONG_THUE_PN_NNT,
                                            TONG_THUE_PN_CQT
                                            )
                    SELECT seq_data_cdoi.NEXTVAL id,
                                            tkh_id,(SELECT   tax_code FROM tb_lst_taxo WHERE short_name = '''|| p_short_name|| ''')ma_cqt,
                                            tin,
                                            ten_nnt,
                                            kytt_tu_ngay,
                                            kytt_den_ngay,
                                            ngay_htoan,
                                            ngay_nop_tk,
                                            han_nop,
                                            ma_cbo,
                                            ten_cbo,
                                            ma_pban,
                                            ten_pban,
                                            '''|| p_short_name|| ''' short_name,
                                            ''QLT-APP'' tax_model,
                                            THUE_PN_NNT,
                                            THUE_PN_CQT,
                                            VON_DKY_NNT,
                                            BMB_NNT,
                                            BMB_CQT,
                                            TONG_THUE_PN_NNT,
                                            TONG_THUE_PN_CQT

                           FROM   ext_tktmb_hdr@qlt_'|| p_short_name|| ''
                            ;
        --Insert tms_tktmb_dtl
        EXECUTE IMMEDIATE '
                    INSERT INTO tb_tkmb_dtl(
                                            id,
                                            tkh_id,
                                            bmb_nnt,
                                            bmb_cqt,
                                            THUE_PN_NNT,
                                            THUE_PN_CQT,
                                            von_dky_nnt,
                                            von_dky_cqt,
                                            mst_dvtt
                                            )
                    SELECT seq_data_cdoi.NEXTVAL id,
                                            tkh_id,
                                            bmb_id_nnt,
                                            bmb_id_cqt,
                                            so_nnt,
                                            so_cqt,
                                            von_dky_nnt,
                                            von_dky_cqt,
                                            mst_dvtt
                        FROM ext_tktmb_dtl@qlt_'|| p_short_name|| ''
                         ;
        --Update hdr_id cho detail(tb_tkmb_dtl)
        FOR v IN c_update_hdr_id
        LOOP
            UPDATE   tb_tkmb_dtl a
               SET   a.hdr_id = (v.id)
             WHERE   a.tkh_id = v.tkh_id AND a.hdr_id IS NULL;
        END LOOP;

        --Thuc hien dong bo bac mon bai
        pck_map_tms.Prc_Update_bac_mbai();

        -- Ghi log
        UPDATE   tb_lst_taxo
           SET   status = 3
         WHERE   short_name = p_short_name;

        pck_trace_log.prc_ins_log (p_short_name,pck_trace_log.fnc_whocalledme);
        pck_trace_log.prc_upd_log_max (p_short_name, 'prc_qlt_get_tktmb');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KTRA_PS');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_SLECH');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_BBAN');
        pck_trace_log.prc_upd_log_max (p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;

    EXCEPTION
        WHEN OTHERS

        THEN
            pck_trace_log.prc_ins_log (p_short_name,
                                       pck_trace_log.fnc_whocalledme);
    END;
END;
/


-- End of DDL Script for Package Body TEST.PCK_CDOI_DLIEU_QLT

