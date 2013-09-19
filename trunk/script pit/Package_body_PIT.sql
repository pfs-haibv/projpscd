-- Start of DDL Script for Package Body TKTQ.PCK_CDOI_DLIEU_QCT
-- Generated 15-Jan-2013 13:17:05 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_cdoi_dlieu_qct
IS

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qlt_Thop_Ps(p_short_name)
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_short_name VARCHAR2) IS
        p_tu DATE;
        p_den DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        SELECT ky_ps_tu, ky_ps_den INTO p_tu, p_den
            FROM tb_lst_taxo WHERE tax_model='QCT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_Ps@QLT_'||p_short_name||'('''
                                                         ||p_tu||''', '''
                                                         ||p_den||''');
             END;';
             
        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QLT_GET_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');

        COMMIT;                       
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);             
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qlt_Thop_No(p_short_name)
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_short_name VARCHAR2) IS
        p_chot DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        SELECT ky_no_den INTO p_chot FROM tb_lst_taxo
            WHERE tax_model='QCT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_No@QLT_'||p_short_name||'('''
                                                         ||p_chot||''');
             END;';
        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QLT_GET_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET'); 

        COMMIT;                     
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);             
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_Ps(p_short_name)
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_Ps(p_short_name VARCHAR2) IS
        p_tu DATE;
        p_den DATE;
        p_ps10 DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        SELECT ky_ps_tu, ky_ps_den, ky_ps10_den INTO p_tu, p_den, p_ps10
            FROM tb_lst_taxo WHERE tax_model='QCT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qct_Thop_Ps@QLT_'||p_short_name||'('''
                                                         ||p_tu||''', '''
                                                         ||p_den||''', '''
                                                         ||p_ps10||''');
             END;';

        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QCT_GET_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');      
        
        COMMIT;      
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);             
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_No(p_short_name)
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_No(p_short_name VARCHAR2) IS
        p_chot DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        SELECT ky_no_den INTO p_chot FROM tb_lst_taxo
            WHERE tax_model='QCT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qct_Thop_No@QLT_'||p_short_name||'('''
                                                         ||p_chot||''');
             END;';
             
        -- Ghi log        
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QCT_GET_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');
        
        COMMIT;            
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);             
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Qct_Thop_Tk(p_short_name)
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_Tk(p_short_name VARCHAR2) IS
        p_tu DATE;
        p_den DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        SELECT ky_tk10_tu, ky_tk10_den INTO p_tu, p_den FROM tb_lst_taxo
            WHERE tax_model='QCT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qct_Thop_Tk@QLT_'||p_short_name||'('''
                                                         ||p_tu||''', '''
                                                         ||p_den||''');
             END;';
        
        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QCT_GET_TK');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_TK');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');
        
        COMMIT;             
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);            
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Thop(p_short_name)
    Noi dung: Tong hop du lieu
    ***************************************************************************/
    PROCEDURE Prc_Thop(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set REMOTE_DEPENDENCIES_MODE=SIGNATURE';
    END;
    
    /*************************************************************************** PCK_CDOI_DLIEU_QCT.Prc_Qlt_Get_Ps(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung:
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Get_Ps(p_short_name VARCHAR2) IS
    BEGIN
        PCK_CDOI_DLIEU_QLT.prc_qlt_get_ps(p_short_name);         
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Qlt_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung:
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2) IS
    BEGIN
        PCK_CDOI_DLIEU_QLT.prc_qlt_get_no(p_short_name);          
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_Ps(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Qct_Get_Ps(p_short_name VARCHAR2) IS
        c_tax_model CONSTANT VARCHAR2(3) := 'QCT';    
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        DELETE FROM tb_ps WHERE short_name=p_short_name AND tax_model='QCT-APP';
        EXECUTE IMMEDIATE '
        INSERT INTO tb_ps (stt, loai, ma_cqt, tin, ma_tkhai, ma_chuong,
                           ma_khoan, ma_tmuc, tkhoan, ky_psinh_tu, ky_psinh_den,
                           so_tien, han_nop, ngay_htoan, ngay_nop, short_name, tax_model,
                           ma_cbo, ten_cbo, ma_pban, ten_pban)
        SELECT ROWNUM stt, loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, 
               ma_tmuc, tkhoan, ky_psinh_tu, ky_psinh_den, so_tien, han_nop, 
               ngay_htoan, ngay_nop, short_name, tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban
        FROM (
        SELECT loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, ma_tmuc, tkhoan, 
               ky_psinh_tu, ky_psinh_den, sum(so_tien) so_tien, 
               to_char(min(han_nop),''DD/MM/RRRR'') han_nop, 
               to_char(min(ngay_htoan),''DD/MM/RRRR'') ngay_htoan, 
               to_char(min(ngay_nop),''DD/MM/RRRR'') ngay_nop, 
               short_name, 
               tax_model, max(ma_cbo) ma_cbo, max(ten_cbo) ten_cbo, 
               max(ma_pban) ma_pban, max(ten_pban) ten_pban
        FROM (
        SELECT ''TK'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''||p_short_name||''') MA_CQT,
               tin,
               (SELECT b.ma_tkhai FROM tb_lst_tkhai b WHERE b.ma_tkhai_cu=a.ma_tkhai) ma_tkhai,
               ma_chuong,
               ma_khoan,
               ma_tmuc,
               ''TKNS'' TKHOAN,
               to_char(ky_psinh_tu, ''DD/MM/YYYY'') ky_psinh_tu,
               to_char(ky_psinh_den, ''DD/MM/YYYY'') ky_psinh_den,
               so_tien, han_nop, ngay_htoan, ngay_nop,
               '''||p_short_name||''' short_name,
               ''QCT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban
          FROM ext_qct_ps@qlt_'||p_short_name||' a
        ) GROUP BY loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, ma_tmuc, 
                   tkhoan, ky_psinh_tu, ky_psinh_den, short_name, tax_model
        ) WHERE so_tien <> 0';    
                         
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;        
        COMMIT;

        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);

        COMMIT;            
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Qct_Get_No(p_short_name VARCHAR2) IS
        c_tax_model CONSTANT VARCHAR2(3) := 'QCT';
        v_chot VARCHAR2(20);
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        DELETE FROM tb_no WHERE short_name=p_short_name AND tax_model='QCT-APP';
        SELECT to_char(trunc(KY_NO_DEN, 'MONTH'), 'DD-MON-RRRR') INTO v_chot
          FROM tb_lst_taxo WHERE short_name=p_short_name;
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_no (stt, loai, ma_cqt, tin, ma_chuong, ma_khoan,
                           tmt_ma_tmuc, tkhoan, ngay_hach_toan, kykk_tu_ngay,
                           kykk_den_ngay, han_nop, dkt_ma, no_cuoi_ky, short_name,
                           tax_model, ma_cbo, ten_cbo, ma_pban, 
                           ten_pban, ma_gdich, ten_gdich)
        SELECT ROWNUM STT,
               ''CD'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''||p_short_name||''') MA_CQT,
               tin, 
               ma_chuong, 
               ma_khoan, 
               tmt_ma_tmuc, 
               ''TKNS'' tkhoan,
               decode(abs(no_cuoi_ky-no_cuoi_ky)
                      , 0
                      , to_char((SELECT last_day(ky_no_den) FROM tb_lst_taxo 
                                  WHERE short_name='''||p_short_name||'''),''dd/mm/rrrr'')
                      , to_char((SELECT last_day(ky_no_den) FROM tb_lst_taxo 
                                  WHERE short_name='''||p_short_name||'''),''dd/mm/rrrr'')
                     ) ngay_hach_toan,
               decode(ky_thue_tu_ngay
                     , NULL
                     , to_char(kylb_tu_ngay,''dd/mm/rrrr'')
                     , to_char(ky_thue_tu_ngay,''dd/mm/rrrr'')) kykk_tu_ngay,              
               decode(ky_thue_den_ngay
                     , NULL
                     , to_char(kylb_den_ngay,''dd/mm/rrrr'')
                     , to_char(ky_thue_den_ngay,''dd/mm/rrrr'')) kykk_den_ngay, 
               to_char(han_nop,''dd/mm/rrrr'') han_nop, 
               NULL dkt_ma, 
               no_cuoi_ky,
               '''||p_short_name||''' short_name,
               ''QCT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban,
               ma_gdich,
               (SELECT ten FROM qct_dm_gdich@qlt_'||p_short_name||' b 
                          WHERE a.ma_gdich=b.ma_gdich) ten_gdich               
          FROM ext_qct_no@qlt_'||p_short_name||' a 
         WHERE no_cuoi_ky<>0 AND tkhoan=''TK_NGAN_SACH''
           AND to_char(trunc(kyno_tu_ngay,''MONTH''),''DD-MON-RRRR'')='''||v_chot||'''';
        
        UPDATE tb_no 
           SET KYKK_DEN_NGAY = to_char(last_day(to_date(KYKK_TU_NGAY,'DD/MM/RRRR')),'DD/MM/RRRR') 
         WHERE short_name=p_short_name AND tax_model='QCT-APP' AND TMT_MA_TMUC='1014';

        UPDATE tb_no 
           SET KYKK_TU_NGAY = to_char(trunc(to_date(KYKK_TU_NGAY,'DD/MM/RRRR'), 'MONTH'),'DD/MM/RRRR'),
               KYKK_DEN_NGAY = to_char(last_day(trunc(to_date(KYKK_DEN_NGAY,'DD/MM/RRRR'), 'MONTH')),'DD/MM/RRRR')
        WHERE KYKK_TU_NGAY=KYKK_DEN_NGAY AND short_name=p_short_name AND tax_model='QCT-APP';
        
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;                  
        COMMIT;

        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_Tk(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Qct_Get_Tk(p_short_name VARCHAR2) IS   
        v_chot_no DATE;
        v_rv_so_tien NUMBER;
    BEGIN
        SELECT trunc(ky_no_den,'MONTH') INTO v_chot_no FROM tb_lst_taxo 
         WHERE short_name=p_short_name;
        
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        DELETE FROM tb_tk WHERE short_name=p_short_name AND tax_model='QCT-APP';
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_tk(stt, ma_cqt, tin, kykk_tu_ngay, kykk_den_ngay,
                          kylb_tu_ngay, dthu_dkien, tl_thnhap_dkien, 
                          thnhap_cthue_dkien, gtru_gcanh, ban_than, 
                          phu_thuoc, thnhap_tthue_dkien, tncn, mst_dtk, hd_dlt_ngay, 
                          pb01, kytt01, ht01, hn01, pb02,
                          kytt02, ht02, hn02, pb03, kytt03, ht03, hn03,
                          pb04, kytt04, ht04, hn04, short_name, tax_model, 
                          ma_cbo, ten_cbo, ma_pban, ten_pban)
        SELECT ROWNUM STT,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''||p_short_name||''') MA_CQT,
               TIN,
               to_char(KYKK_TU_NGAY,''DD/MM/YYYY'') KYKK_TU_NGAY,
               to_char(KYKK_DEN_NGAY,''DD/MM/YYYY'') KYKK_DEN_NGAY,
               to_char(KYLB_TU_NGAY,''DD/MM/YYYY'') KYLB_TU_NGAY,
               dthu_dkien, tl_thnhap_dkien, 
               thnhap_cthue_dkien, gtru_gcanh, ban_than, 
               phu_thuoc, thnhap_tthue_dkien, tncn, ma_dlt, to_char(ngay_hdong_dlt,''DD/MM/YYYY'') ngay_hdong_dlt,
               NVL(PB01,0) PB01,
               NVL(KYTT01, to_char(KYKK_TU_NGAY, ''YY'')||''Q1'') KYTT01,
               NVL(to_char(HT01,''DD/MM/YYYY''), ''01/01/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HT01,
               NVL(to_char(HN01,''DD/MM/YYYY''), ''31/03/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HN01,
               NVL(PB02,0) PB02,
               NVL(KYTT02, to_char(KYKK_TU_NGAY, ''YY'')||''Q2'') KYTT02,
               NVL(to_char(HT02,''DD/MM/YYYY''), ''01/04/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HT02,
               NVL(to_char(HN02,''DD/MM/YYYY''), ''30/06/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HN02,
               NVL(PB03,0) PB03,
               NVL(KYTT03, to_char(KYKK_TU_NGAY, ''YY'')||''Q3'') KYTT03,
               NVL(to_char(HT03,''DD/MM/YYYY''), ''01/07/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HT03,
               NVL(to_char(HN03,''DD/MM/YYYY''), ''30/09/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HN03,
               NVL(PB04,0) PB04,
               NVL(KYTT04, to_char(KYKK_TU_NGAY, ''YY'')||''Q4'') KYTT04,
               NVL(to_char(HT04,''DD/MM/YYYY''), ''01/10/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HT04,
               NVL(to_char(HN04,''DD/MM/YYYY''), ''31/12/''||to_char(KYKK_TU_NGAY, ''YYYY'')) HN04,
               '''||p_short_name||''' short_name,
               ''QCT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban
          FROM ext_qct_tk@qlt_'||p_short_name;
        
        -- Cap nhat so tien revert
        FOR v IN (SELECT ROWID rid, a.* FROM tb_tk a WHERE a.short_name=p_short_name) 
        LOOP
            v_rv_so_tien:=0;
            IF trunc(to_date(v.HT01, 'DD/MM/YYYY'),'MONTH')<=v_chot_no THEN
                v_rv_so_tien:=v_rv_so_tien+v.PB01;
            END IF;
            IF trunc(to_date(v.HT02, 'DD/MM/YYYY'),'MONTH')<=v_chot_no THEN
                v_rv_so_tien:=v_rv_so_tien+v.PB02;
            END IF;
            IF trunc(to_date(v.HT03, 'DD/MM/YYYY'),'MONTH')<=v_chot_no THEN
                v_rv_so_tien:=v_rv_so_tien+v.PB03;
            END IF;
            IF trunc(to_date(v.HT04, 'DD/MM/YYYY'),'MONTH')<=v_chot_no THEN
                v_rv_so_tien:=v_rv_so_tien+v.PB04;
            END IF;
            UPDATE tb_tk SET rv_so_tien=v_rv_so_tien WHERE ROWID=v.rid;
        END LOOP;
        
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;        
        COMMIT;
        
        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;                
    
    /***************************************************************************
    pck_cdoi_dlieu_qct.Prc_Job_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Slech_No@QLT_'||p_short_name||';
             END;';
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qct_Slech_No@QLT_'||p_short_name||';
             END;';
        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;        
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_GET_SLECH_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');        
        COMMIT;            
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2) IS
    BEGIN
        PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No(p_short_name);        
    END;        
    
/***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    Noi dung: 
    ***************************************************************************/
    PROCEDURE Prc_Qct_Get_Pt(p_short_name VARCHAR2) IS  
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                
        DELETE FROM tb_pt WHERE short_name=p_short_name;
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_pt(short_name, tin, ky_tthue, loai_tk, loai_bk, mst_npt,
               ten_npt, ngay_sinh, so_cmt, qhe_nnt, sothang_gtru,
               sotien_gtru, qhe_vchong)
        SELECT '''||p_short_name||''' SHORT_NAME,
               a.tin, 
               to_char(KYLB_TU_NGAY, ''RR'')||''CN'' KY_TTHUE, 
               ''0013'' LOAI_TK, 
               ''0026'' LOAI_BK,
               NULL MST_NPT,
               a.ho_ten TEN_NPT,
               to_char(a.ngay_sinh,''DD/MM/RRRR'') NGAY_SINH,
               NULL SO_CMT,
               a.qhe_nnt QHE_NNT,
               a.so_thang SOTHANG_GTRU,
               a.so_tien SOTIEN_GTRU,
               ''N'' QHE_VCHONG
          FROM qct_pluc_tncn_npt@qlt_'||p_short_name||' a 
         WHERE EXISTS (SELECT 1 FROM qct_cctt_hdr@qlt_'||p_short_name||' b 
                        WHERE b.id=a.hdr_id
                          AND b.dcc_ma=''26''
                          AND b.kykk_tu_ngay>=
                              (SELECT ky_tk10_tu FROM tb_lst_taxo 
                                WHERE short_name='''||p_short_name||''')
                          AND b.kylb_tu_ngay<=
                              (SELECT ky_no_den FROM tb_lst_taxo 
                                WHERE short_name='''||p_short_name||'''))';

        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;                  
        COMMIT;

        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    /***************************************************************************
    PCK_CDOI_DLIEU_QCT.Prc_Dchinh_No_Qct(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Dchinh_No_Qct(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';              
        EXECUTE IMMEDIATE '
        BEGIN EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qlt@QLT_'||p_short_name||'; END;';
        EXECUTE IMMEDIATE '
        BEGIN EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qct@QLT_'||p_short_name||'; END;';
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;        
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_CDOI_DLIEU_QCT

-- Start of DDL Script for Package Body TKTQ.PCK_CDOI_DLIEU_QLT
-- Generated 15-Jan-2013 13:17:05 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_cdoi_dlieu_qlt
IS

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_Ps(p_short_name)
    Noi dung: Tong hop du lieu phat sinh QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_short_name VARCHAR2) IS
        p_tu DATE;
        p_den DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
        
        SELECT ky_ps_tu, ky_ps_den INTO p_tu, p_den
            FROM tb_lst_taxo WHERE tax_model='QLT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_Ps@QLT_'||p_short_name||'('''
                                                         ||p_tu||''', '''
                                                         ||p_den||''');
             END;';

        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
        
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QLT_GET_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_PS');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');
        
        COMMIT;            
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    END;

    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Qlt_Thop_No(p_short_name)
    Noi dung: Tong hop du lieu nghia vu thue QLT thong qua DBlink QLT
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_short_name VARCHAR2) IS
        p_chot DATE;
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
                    
        SELECT ky_no_den INTO p_chot FROM tb_lst_taxo
            WHERE tax_model='QLT' AND short_name=p_short_name;
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_No@QLT_'||p_short_name||'('''||p_chot||''');
             END;';
        
        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_QLT_GET_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');            
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);             
    END;
    
    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Job_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Job_Slech_No(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
        EXECUTE IMMEDIATE
            'BEGIN
                EXT_PCK_CONTROL.Prc_Job_Qlt_Slech_No@QLT_'||p_short_name||';
             END;';

        -- Ghi log
        UPDATE tb_lst_taxo SET status=2 WHERE short_name=p_short_name;        
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_GET_SLECH_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');        
        COMMIT;            
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    END;
    
    /***************************************************************************
    pck_cdoi_dlieu_qlt.Prc_Thop(p_short_name)
    Noi dung: Tong hop du lieu
    ***************************************************************************/
    PROCEDURE Prc_Thop(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set REMOTE_DEPENDENCIES_MODE=SIGNATURE';
    END;
    
    /*************************************************************************** PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_Ps(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin ps tu CQT
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Get_Ps(p_short_name VARCHAR2) IS
        c_tax_model CONSTANT VARCHAR2(3) := 'QLT';        
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';        
        
        DELETE FROM tb_ps WHERE short_name=p_short_name AND tax_model='QLT-APP';
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_ps (stt, loai, ma_cqt, tin, ma_tkhai, ma_chuong,
               ma_khoan, ma_tmuc, tkhoan, ky_psinh_tu, ky_psinh_den,
               so_tien, han_nop, ngay_htoan, ngay_nop, short_name, tax_model,
               ma_cbo, ten_cbo, ma_pban, ten_pban)
        SELECT rownum stt, loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, 
               ma_tmuc, tkhoan, ky_psinh_tu, ky_psinh_den, so_tien, han_nop, 
               ngay_htoan, ngay_nop, short_name, tax_model, ma_cbo, ten_cbo, ma_pban,
               ten_pban
        FROM (
        SELECT loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, ma_tmuc, tkhoan, 
               ky_psinh_tu, ky_psinh_den, sum(so_tien) so_tien, 
               to_char(min(han_nop),''DD/MM/RRRR'') han_nop, 
               to_char(min(ngay_htoan),''DD/MM/RRRR'') ngay_htoan, 
               to_char(min(ngay_nop),''DD/MM/RRRR'') ngay_nop, 
               short_name, tax_model, max(ma_cbo) ma_cbo, 
               max(ten_cbo) ten_cbo, max(ma_pban) ma_pban, max(ten_pban) ten_pban
        FROM (        
        SELECT ''TK'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''||p_short_name||''') MA_CQT,
               tin,
               (select b.ma_tkhai from tb_lst_tkhai b where b.ma_tkhai_cu=a.ma_tkhai) ma_tkhai,
               ma_chuong,
               ma_khoan,
               ma_tmuc,
               ''TKNS'' TKHOAN,
               to_char(ky_psinh_tu, ''DD/MM/YYYY'') ky_psinh_tu,
               to_char(ky_psinh_den, ''DD/MM/YYYY'') ky_psinh_den,
               so_tien, han_nop, ngay_htoan, ngay_nop,
               '''||p_short_name||''' short_name,
               ''QLT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban
        FROM ext_qlt_ps@qlt_'||p_short_name||' a
        ) GROUP BY loai, ma_cqt, tin, ma_tkhai, ma_chuong, ma_khoan, ma_tmuc, 
                   tkhoan, ky_psinh_tu, ky_psinh_den, short_name, tax_model
        ) Where so_tien <> 0';
        COMMIT;
        
        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_No(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin no tu CQT
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Get_No(p_short_name VARCHAR2) IS
        c_tax_model CONSTANT VARCHAR2(3) := 'QLT';
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';        
        
        DELETE FROM tb_no WHERE short_name=p_short_name AND tax_model='QLT-APP';
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_no(stt, loai, ma_cqt, tin, ma_chuong, ma_khoan,
               tmt_ma_tmuc, tkhoan, ngay_hach_toan, kykk_tu_ngay,
               kykk_den_ngay, han_nop, dkt_ma, no_cuoi_ky, short_name, tax_model,
               ma_cbo, ten_cbo, ma_pban, ten_pban, ma_gdich, ten_gdich)
        SELECT ROWNUM STT,
               ''CD'' LOAI,
               (SELECT tax_code FROM tb_lst_taxo WHERE short_name='''||p_short_name||''') MA_CQT,
               tin,
               ma_chuong,
               ma_khoan,
               tmt_ma_tmuc,
               ''TKNS'' tkhoan,
               decode(abs(no_cuoi_ky-no_cuoi_ky)
                      , 0
                      , to_char((SELECT last_day(ky_no_den) FROM tb_lst_taxo 
                                  WHERE short_name='''||p_short_name||'''),''dd/mm/rrrr'')
                      , to_char((SELECT last_day(ky_no_den) FROM tb_lst_taxo 
                                  WHERE short_name='''||p_short_name||'''),''dd/mm/rrrr'')
                     ) ngay_hach_toan,
               decode(kykk_tu_ngay
                     , NULL
                     , to_char(kylb_tu_ngay,''dd/mm/rrrr'')
                     , to_char(kykk_tu_ngay,''dd/mm/rrrr'')) kykk_tu_ngay,
               decode(kykk_den_ngay
                     , NULL
                     , to_char(kylb_den_ngay,''dd/mm/rrrr'')
                     , to_char(kykk_den_ngay,''dd/mm/rrrr'')) kykk_den_ngay,
               to_char(han_nop,''dd/mm/rrrr'') han_nop,
               NULL dkt_ma,
               no_cuoi_ky,
               '''||p_short_name||''' short_name,
               ''QLT-APP'' tax_model, ma_cbo, ten_cbo, ma_pban, ten_pban,
               dgd_ma_gdich,
               (SELECT ten FROM qlt_dm_gdich@qlt_'||p_short_name||' b 
                          WHERE a.dgd_ma_gdich=b.ma_gdich) ten_gdich
          FROM ext_qlt_no@qlt_'||p_short_name||' a
         WHERE no_cuoi_ky<>0 AND tkhoan=''TK_NGAN_SACH''';        

        UPDATE tb_no 
           SET KYKK_DEN_NGAY = to_char(last_day(to_date(KYKK_TU_NGAY,'DD/MM/RRRR')),'DD/MM/RRRR') 
         WHERE short_name=p_short_name AND tax_model='QLT-APP' AND TMT_MA_TMUC='1014';

        UPDATE tb_no 
           SET KYKK_TU_NGAY = to_char(trunc(to_date(KYKK_TU_NGAY,'DD/MM/RRRR'), 'MONTH'),'DD/MM/RRRR'),
               KYKK_DEN_NGAY = to_char(last_day(trunc(to_date(KYKK_DEN_NGAY,'DD/MM/RRRR'), 'MONTH')),'DD/MM/RRRR')
        WHERE KYKK_TU_NGAY=KYKK_DEN_NGAY AND short_name=p_short_name AND tax_model='QLT-APP';        

        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Get_Slech_No(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';        
        
        DELETE FROM tb_slech_no WHERE short_name=p_short_name;
        
        EXECUTE IMMEDIATE '
        INSERT INTO tb_slech_no(short_name, loai, ky_thue,
                        tin, ten_dtnt, tai_khoan, muc, tieumuc, mathue,
                        sothue_no_cky, sono_no_cky, clech_no_cky, 
                        ma_cbo, ten_cbo, ma_pban, ten_pban, ma_slech,
                        ma_gdich, ten_gdich)
        SELECT '''||p_short_name||''' short_name, loai, ky_thue,
               tin, ten_dtnt, tai_khoan, muc, tieumuc, mathue,
               sothue_no_cky, sono_no_cky, clech_no_cky, 
               ma_cbo, ten_cbo, ma_pban, ten_pban, ma_slech, ma_gdich, ten_gdich
          FROM ext_slech_no@QLT_'||p_short_name||' WHERE update_no=0';        
        COMMIT;
        
        -- Ghi log
        UPDATE tb_lst_taxo SET status=3 WHERE short_name=p_short_name;
                
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Dchinh_No_Qlt(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Dchinh_No_Qlt(p_short_name VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';              
        EXECUTE IMMEDIATE '
        BEGIN EXT_PCK_CONTROL_4.Prc_Dchinh_No_Qlt@QLT_'||p_short_name||'; END;';
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);    
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);          
    END;
    /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Dchinh_No(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Dchinh_No(p_short_name VARCHAR2) IS
        v_tax_model VARCHAR2(3);
    BEGIN
        SELECT tax_model INTO v_tax_model FROM tb_lst_taxo 
         WHERE short_name=p_short_name;
        IF v_tax_model='QLT' THEN
            PCK_CDOI_DLIEU_QLT.prc_dchinh_no_qlt(p_short_name);
        ELSIF v_tax_model='QCT' THEN
            PCK_CDOI_DLIEU_QCT.prc_dchinh_no_qct(p_short_name);
        END IF;
    END;                    
    
        /***************************************************************************
    PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_MST(p_short_name)
    ***************************************************************************/
        
    PROCEDURE Prc_Get_Slech_MST(p_short_name VARCHAR2)
    IS
    BEGIN
        EXECUTE immediate 'begin
            declare
                v_short_name varchar2(7) := '''|| p_short_name ||''';
            begin
                dbms_application_info.set_client_info(v_short_name);                  
                qlt_pck_thop_no_thue.prc_load_dsach_dtnt@qlt_'|| p_short_name ||';
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
                      from qlt_phongban@qlt_'|| p_short_name ||' pb
                     where pb.ma_phong = nnt.ma_phong) ten_phong, 
                   (select ten 
                      from qlt_canbo@qlt_'|| p_short_name ||' cb 
                     where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                   0 update_no, userenv(''client_info'') short_name
              from tin_payer@qlt_' || p_short_name || ' a, qlt_nsd_dtnt@qlt_'||p_short_name||' nnt
             where update_no = 0 
               and (regi_date is null 
                    or status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
               and (
                    exists (select 1 
                              from qlt_so_thue@qlt_'|| p_short_name ||' b where b.tin = a.tin) 
                    or
                    exists (select 1 
                              from qlt_so_no@qlt_'|| p_short_name ||' c where c.tin = a.tin)
                   )
               and a.tin(+) = nnt.tin
             union all
            select a.tin, a.status, a.regi_date, a.payer_type, a.norm_name,
                   (select ten 
                      from qlt_phongban@qlt_'|| p_short_name ||' pb 
                     where pb.ma_phong = nnt.ma_phong) ten_phong, 
                   (select ten 
                      from qlt_canbo@qlt_'|| p_short_name ||' cb 
                     where cb.ma_canbo = nnt.ma_canbo) ten_canbo,
                   0 update_no, userenv(''client_info'') short_name
              from tin_personal_payer@qlt_'|| p_short_name ||' a, qlt_nsd_dtnt@qlt_' || p_short_name ||' nnt
             where update_no = 0 
               and (regi_date is null 
                    or status not in (''00'',''01'',''02'',''03'',''04'',''05'',''99''))
               and (
                     exists (select 1 
                               from qlt_so_thue@qlt_'|| p_short_name ||' b 
                              where b.tin = a.tin) 
                     or
                     exists (select 1 
                               from qlt_so_no@qlt_'|| p_short_name ||' c 
                              where c.tin = a.tin)
                   )
               and a.tin(+) = nnt.tin;

            begin
                qlt_pck_thop_no_thue.prc_unload_dsach_dtnt@qlt_'||p_short_name ||';
            end;
           
            COMMIT;
        end;';
    END;
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_CDOI_DLIEU_QLT

-- Start of DDL Script for Package Body TKTQ.PCK_CHECK_DATA
-- Generated 15-Jan-2013 13:17:05 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_check_data
IS
   /***************************************************************************
   MODIFY BY ManhTV3 ON 13/12/2011
   prc_check_data.Prc_ktra_du_lieu_no(p_short_name)
   Noi dung: Kiem tra du lieu trong bang tb_no
   ***************************************************************************/
   PROCEDURE prc_ktra_du_lieu_no (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   )
   IS
      CURSOR c
      IS
         SELECT ROWID, a.*
           FROM tb_no a
          WHERE a.short_name = p_short_name;

      v_ky_no_tu           DATE;
      v_trang_thai_dlieu   CHAR (1);
   BEGIN
      SELECT TRUNC (a.ky_no_tu, 'MM')
        INTO v_ky_no_tu
        FROM tb_lst_taxo a
       WHERE a.short_name = p_short_name;

      FOR v IN c
      LOOP
         -- Kiem tra loai giao dich
         IF v.loai <> 'CD'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_NO', '004', 'LOAI',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 14/12/2011
         -- Kiem tra chuong
         -- Chu y: ma chuong se duoc fix co dinh theo cqt cho nen khong phai kiem
         -- tra xem ma chuong do co ton tai hay khong
         IF LENGTH (v.short_name) = 3
         THEN
            IF v.tmt_ma_tmuc IN ('1001', '1003', '1004', '1005')
            THEN
               IF v.ma_chuong <> '557'
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_NO', '074',
                               'MA_CHUONG', 0
                              );
               END IF;
            ELSE
               IF v.ma_chuong <> '757'
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_NO', '075',
                               'MA_CHUONG', 0
                              );
               END IF;
            END IF;
         ELSE
            IF v.ma_chuong <> '757'
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '076',
                            'MA_CHUONG', 0
                           );
            END IF;
         END IF;

         -- Modify by ManhTV3 on 14/12/2011
         -- Kiem tra khoan
         IF v.ma_khoan <> '000'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_NO', '014', 'MA_KHOAN',
                         0
                        );
         END IF;

         -- Create by ManhTV3 on 14/12/2011
         -- Kiem tra tieu muc
         -- Modify by ManhTV3 on 16/1/2012: Them tieu muc 4268
         -- ThanhNH5 rao code 22/05/2012: do SAP da check theo err_id='016'
/*
         IF v.tmt_ma_tmuc NOT IN
               ('1001',
                '1003',
                '1004',
                '1005',
                '1006',
                '1007',
                '1008',
                '1012',
                '1014',
                '1049',
                '4268'
               )
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_NO', '077', 'TMT_MA_TMUC', 0
                        );
         END IF;
*/

         -- Modify by ManhTV3 on 14/12/2011
         -- Kiem tra tai khoan
         IF v.tkhoan <> 'TKNS'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_NO', '019', 'TKHOAN',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 24/02/2012
         -- Kiem tra ngay hach toan
         BEGIN
            IF TO_DATE (v.ngay_hach_toan, 'DD/MM/YYYY') >
                           LAST_DAY (TO_DATE (p_ngay_chot_dl, 'dd-Mon-yyyy'))
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '079',
                            'NGAY_HACH_TOAN', 0
                           );
            END IF;
         -- Modify by ManhTV3 on 16/03/2012
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '026',
                            'NGAY_HACH_TOAN', 0
                           );
         END;

         -- Modify by ManhTV3 on 16/12/2011
         -- Kiem tra truong Ky tinh thue tu ngay
         BEGIN
            IF SUBSTR (v.kykk_tu_ngay, 1, 2) <> '01'
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '021',
                            'KYKK_TU_NGAY', 0
                           );
            END IF;
         END;

         -- Modify by ManhTV3 on 03/01/2012
         -- Kiem tra truong Ky tinh thue den ngay
         DECLARE
            v_date   DATE;
         BEGIN
            v_date := TO_DATE (v.kykk_den_ngay, 'DD/MM/YYYY');

            IF v_date <> LAST_DAY (v_date)
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '023',
                            'KYKK_DEN_NGAY', 0
                           );
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '023',
                            'KYKK_DEN_NGAY', 0
                           );
         END;

         -- Modify by ManhTV3 on 04/01/2012
         -- Kiem tra ky tinh thue
/*         DECLARE
            v_ky_tinh_thue_tu   DATE
                                    := TO_DATE (v.kykk_tu_ngay, 'DD/MM/YYYY');*/
/*            v_ky_tinh_thue_den   DATE
                                   := TO_DATE (v.kykk_den_ngay, 'DD/MM/YYYY');*/
/*
         BEGIN
           IF    (   v_ky_tinh_thue_tu <
                                         TO_DATE ('1-Jan-2011', 'dd-Mon-yyyy')
                   OR v_ky_tinh_thue_tu >
                                        TO_DATE ('31-Dec-2012', 'dd-Mon-yyyy')
                  )
               OR (   v_ky_tinh_thue_den <
                                         TO_DATE ('1-Jan-2011', 'dd-Mon-yyyy')
                   OR v_ky_tinh_thue_den >
                                        TO_DATE ('31-Dec-2012', 'dd-Mon-yyyy')
                  )
            IF    TO_DATE (v.kykk_tu_ngay, 'dd/mm/yyyy') >
                                                      TO_DATE ('31-Dec-2012')
               OR TO_DATE (v.kykk_den_ngay, 'dd/mm/yyyy') >
                                                       TO_DATE ('31-Dec-2012')
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_NO', '024',
                            'KYKK_TU_NGAY'
                           );
            END IF;
         END;
*/
         COMMIT;
      END LOOP;
   END;

   /****************************************************************************
   MODIFY BY ManhTV3 ON 04/01/2012
   prc_check_data.Prc_ktra_du_lieu_ps(p_short_name)
   Noi dung: Kiem tra du lieu trong bang tb_ps
   ****************************************************************************/
   PROCEDURE prc_ktra_du_lieu_ps (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   )
   IS
      CURSOR c
      IS
         SELECT ROWID, a.*
           FROM tb_ps a
          WHERE a.short_name = p_short_name;

      v_ky_ps_tu   DATE;
   BEGIN
      SELECT TRUNC (a.ky_ps_tu, 'mm')
        INTO v_ky_ps_tu
        FROM tb_lst_taxo a
       WHERE a.short_name = p_short_name;

--     v_ky_ps_tu := first_day(v_ky_ps_tu);
      -- MODIFY BY ManhTV3 ON 04/01/2012
      -- Kiem tra loai giao dich
      FOR v IN c
      LOOP
         IF v.loai <> 'TK'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_PS', '004', 'LOAI',
                         0
                        );
         END IF;

         -- MODIFY BY ManhTV3 ON 04/01/2012
         -- Kiem tra ma chuong
         IF (   (LENGTH (v.short_name) = 3 AND v.ma_chuong <> '557')
             OR (LENGTH (v.short_name) = 7 AND v.ma_chuong <> '757')
            )
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_PS', '080', 'MA_CHUONG',
                         0
                        );
         END IF;

         -- MODIFY BY ManhTV3 ON 04/01/2012
         -- Kiem tra ma tieu muc
         IF    (    v.ma_tkhai IN ('02T/KK-TNCN', '02Q/KK-TNCN')
                AND v.ma_tmuc <> '1001'
               )
            OR (    v.ma_tkhai IN ('03T/KK-TNCN', '03Q/KK-TNCN')
                AND v.ma_tmuc NOT IN ('1003', '1004', '1007', '1008')
               )
            OR (    v.ma_tkhai IN
                        ('01/KK-BH', '01/KK-XS', '10/KK-TNCN', '10A/KK-TNCN')
                AND v.ma_tmuc <> '1003'
               )
            OR (    v.ma_tkhai IN ('08/KK-TNCN', '08A/KK-TNCN')
                AND v.ma_tmuc NOT IN ('1003', '1014')
               )
            OR (    v.ma_tkhai IN ('07/KK-TNCN')
                AND v.ma_tmuc NOT IN ('1001', '1003')
               )
--         or (v.ma_tkhai in ()  and v.ma_tmuc <> '1014')
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_PS', '081', 'MA_TMUC',
                         0
                        );
         END IF;

         -- MODIFY BY ManhTV3 ON 04/01/2012
         -- Kiem tra ma tai khoan
         IF v.tkhoan <> 'TKNS'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_PS', '019', 'TKHOAN',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 7/03/2012
         -- Kiem tra ngay hach toan
         BEGIN
            IF TO_DATE (v.ngay_htoan, 'DD/MM/YYYY') >
                           LAST_DAY (TO_DATE (p_ngay_chot_dl, 'DD-MON-RRRR'))
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '079',
                            'NGAY_HTOAN', 0
                           );
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '026',
                            'NGAY_HTOAN', 0
                           );
         END;

         -- Modify by ManhTV3 on 16/12/2011
         -- Kiem tra truong Ky tinh thue tu ngay
         BEGIN
            IF SUBSTR (v.ky_psinh_tu, 1, 2) <> '01'
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '021',
                            'KY_PSINH_TU', 0
                           );
            END IF;
         END;

         -- Modify by ManhTV3 on 03/01/2012
         -- Kiem tra truong Ky tinh thue den ngay
         DECLARE
            v_date   DATE;
         BEGIN
            v_date := TO_DATE (v.ky_psinh_den, 'DD/MM/YYYY');

            IF v_date <> LAST_DAY (v_date)
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '023',
                            'KY_PSINH_DEN', 0
                           );
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '023',
                            'KY_PSINH_DEN', 0
                           );
         END;

         -- Modify by ManhTV3 on 04/01/2012
         -- Kiem tra ky tinh thue
         DECLARE
            v_ky_tinh_thue_tu   DATE := TO_DATE (v.ky_psinh_tu, 'DD/MM/YYYY');
/*            v_ky_tinh_thue_den   DATE
                                    := TO_DATE (v.ky_psinh_den, 'DD/MM/YYYY');*/
         BEGIN
            /* IF    (   v_ky_tinh_thue_tu <
                                          TO_DATE ('1-Jan-2011', 'dd-Mon-yyyy')
                    OR v_ky_tinh_thue_tu >
                                         TO_DATE ('31-Dec-2012', 'dd-Mon-yyyy')
                   )
                OR (   v_ky_tinh_thue_den <
                                          TO_DATE ('1-Jan-2011', 'dd-Mon-yyyy')
                    OR v_ky_tinh_thue_den >
                                         TO_DATE ('31-Dec-2012', 'dd-Mon-yyyy')
                   )*/
            IF (v_ky_tinh_thue_tu < v_ky_ps_tu)
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_PS', '024',
                            'KY_PSINH_TU', 0
                           );
            END IF;
         END;

         -- Modify by ManhTV3 on 04/01/2012
         -- Kiem tra ma to khai
         IF v.ma_tkhai NOT IN
               ('02T/KK-TNCN',
                '02Q/KK-TNCN',
                '03T/KK-TNCN',
                '03Q/KK-TNCN',
                '07/KK-TNCN',
                '01/KK-BH',
                '01/KK-XS',
                '08/KK-TNCN',
                '08A/KK-TNCN',
                '08TN/KK-TNCN',
                '08ATN/KK-TNCN',
                '10/KK-TNCN',
                '10A/KK-TNCN'
               )
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_PS', '031', 'MA_TKHAI',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 24/02/2012
         -- Kiem tra ky ke khai theo
         BEGIN
            -- Ky ke khai dinh dang thang
            IF (SUBSTR (v.ky_psinh_tu, 4, 2) = SUBSTR (v.ky_psinh_den, 4, 2)
               )
            THEN
               IF (v.ma_tkhai NOT IN
                      ('02T/KK-TNCN',
                       '03T/KK-TNCN',
                       '07/KK-TNCN',
                       '01/KK-BH',
                       '01/KK-XS',
                       '08/KK-TNCN',
                       '08A/KK-TNCN'
                      )
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_PS', '071',
                               'MA_TKHAI', 0
                              );
               END IF;
            END IF;

            -- End of Ky ke khai dinh dang thang

            -- Ky ke khai dinh dang quy
            IF    (    SUBSTR (v.ky_psinh_tu, 4, 2) = '01'
                   AND SUBSTR (v.ky_psinh_den, 4, 2) = '03'
                  )
               OR (    SUBSTR (v.ky_psinh_tu, 4, 2) = '04'
                   AND SUBSTR (v.ky_psinh_den, 4, 2) = '06'
                  )
               OR (    SUBSTR (v.ky_psinh_tu, 4, 2) = '07'
                   AND SUBSTR (v.ky_psinh_den, 4, 2) = '09'
                  )
               OR (    SUBSTR (v.ky_psinh_tu, 4, 2) = '10'
                   AND SUBSTR (v.ky_psinh_den, 4, 2) = '12'
                  )
            THEN
               IF (v.ma_tkhai NOT IN
                      ('02Q/KK-TNCN',
                       '03Q/KK-TNCN',
                       '08/KK-TNCN',
                       '08A/KK-TNCN'
                      )
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_PS', '072',
                               'MA_TKHAI', 0
                              );
               END IF;
            END IF;

            -- End of Ky ke khai dinh dang quy

            -- Ky ke khai dinh dang nam
            IF (    SUBSTR (v.ky_psinh_tu, 4, 2) = '01'
                AND SUBSTR (v.ky_psinh_den, 4, 2) = '12'
               )
            THEN
               IF (v.ma_tkhai NOT IN
                      ('10/KK-TNCN',
                       '10A/KK-TNCN',
                       '08/KK-TNCN',
                       '08A/KK-TNCN'
                      )
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_PS', '073',
                               'MA_TKHAI', 0
                              );
               END IF;
            END IF;
         --End of Ky ke khai dinh dang nam
         END;

         -- End of Kiem tra ky ke khai
         COMMIT;
      END LOOP;
   END;

   /**************************************************************************
**************************************************************************/
   PROCEDURE prc_ktra_du_lieu_tk (
      p_short_name     VARCHAR2,
      p_ngay_chot_dl   VARCHAR2
   )
   IS
      v_year            VARCHAR2 (4);
      v_rv_so_tien      NUMBER (15);
      v_error_message   VARCHAR2 (255);

      CURSOR c
      IS
         SELECT ROWID, a.*
           FROM tb_tk a
          WHERE a.short_name = p_short_name;
   BEGIN
      /* Modify by ThanhNH5 on 02/03/2012
         Kiem tra ton tai cua to khai 10/KK-TNCN*/
      INSERT INTO tb_data_error
                  (short_name, rid, table_name, err_id, field_name,
                   update_no)
         SELECT p_short_name short_name, ROWID rid, 'TB_TK' table_name,
                '069' err_id, NULL field_name, 0
           FROM tb_tk a
          WHERE a.ROWID >
                   (SELECT   MIN (ROWID)
                        FROM tb_tk b
                       WHERE short_name = p_short_name
                         AND a.tin = b.tin
                         AND a.kykk_tu_ngay = b.kykk_tu_ngay
                         AND a.kykk_den_ngay = b.kykk_den_ngay
                    GROUP BY tin, kykk_tu_ngay, kykk_den_ngay
                      HAVING COUNT (1) > 1);

      FOR v IN c
      LOOP
         /*-- Modify by ThanhNH5 on 02/03/2012
         -- Content: Kiem tra so tien rv
         v_rv_so_tien := 0;

         -- Modify by ManhTV3 on 16/03/2012
         BEGIN
            IF TRUNC (TO_DATE (v.ht01, 'DD/MM/YYYY'), 'MONTH') <=
                                       TO_DATE (p_ngay_chot_dl, 'DD/MM/YYYY')
            THEN
               v_rv_so_tien := v_rv_so_tien + v.pb01;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id, field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '059', 'HT01', 0
                           );
         END;

         -- Modify by ManhTV3 on 16/03/2012
         BEGIN
            IF TRUNC (TO_DATE (v.ht02, 'DD/MM/YYYY'), 'MONTH') <=
                                       TO_DATE (p_ngay_chot_dl, 'DD/MM/YYYY')
            THEN
               v_rv_so_tien := v_rv_so_tien + v.pb02;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id, field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '059', 'HT02', 0
                           );
         END;

         BEGIN
            IF TRUNC (TO_DATE (v.ht03, 'DD/MM/YYYY'), 'MONTH') <=
                                       TO_DATE (p_ngay_chot_dl, 'DD/MM/YYYY')
            THEN
               v_rv_so_tien := v_rv_so_tien + v.pb03;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id, field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '059', 'HT03', 0
                           );
         END;

         -- Modify by ManhTV3 on 16/03/2012
         BEGIN
            IF TRUNC (TO_DATE (v.ht04, 'DD/MM/YYYY'), 'MONTH') <=
                                       TO_DATE (p_ngay_chot_dl, 'DD/MM/YYYY')
            THEN
               v_rv_so_tien := v_rv_so_tien + v.pb04;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id, field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '059', 'HT04', 0
                           );
         END;

         -- Modify by ManhTV3 on 16/03/2012
         BEGIN
            IF (v.rv_so_tien > v_rv_so_tien)
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '089',
                            'RV_SO_TIEN', 0
                           );
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id, field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '059', 'HT02', 0
                           );
         END;*/

         -- Modify by ManhTV3 on 28/02/2012
         -- Content: Kiem tra ma cqt
         IF SUBSTR (v.ma_cqt, 4, 2) = '00'
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '082', 'MA_CQT',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 28/02/2012
         -- Content: Kiem tra ngay hop dong
         BEGIN
            IF TO_DATE (v.hd_dlt_ngay, 'dd/mm/yyyy') > SYSDATE
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '083',
                            'HD_DLT_NGAY', 0
                           );
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name, update_no
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', '090',
                            'HD_DLT_NGAY', 0
                           );
         END;

         -- Modify by ManhTV3 on 29/02/2012
         -- Content: Kiem tra chi tieu 11
         IF (v.gtru_gcanh <> (v.ban_than + v.phu_thuoc))
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '085',
                         'GTRU_GCANH', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 29/02/2012
         -- Content: Kiem tra chi tieu 12
         IF (v.ban_than > 48000000)
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '084', 'BAN_THAN',
                         0
                        );
         END IF;

         -- Modify by ManhTV3 on 29/02/2012
         -- Content: Kiem tra chi tieu [15]
         IF (v.tncn <> (v.pb01 + v.pb02 + v.pb03 + v.pb04))
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id, field_name,
                         update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '086', 'TNCN',
                         0
                        );
         END IF;

         BEGIN
            -- Modify ManhTV3 on 29/02/2012
            -- Content: Kiem tra han nop cua phan bo quy 1
            BEGIN
               v_year := TO_CHAR (TO_DATE (v.hn01, 'dd/mm/yyyy'), 'yyyy');

               IF (TO_DATE (v.hn01, 'dd/mm/yyyy') <>
                                    TO_DATE ('31/03/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '087',
                               'HN01', 0
                              );
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '090',
                               'HN01', 0
                              );
            END;

            -- Modify ManhTV3 on 29/02/2012
            -- Content: Kiem tra han nop cua phan bo quy 2
            BEGIN
               v_year := TO_CHAR (TO_DATE (v.hn02, 'dd/mm/yyyy'), 'yyyy');

               IF (TO_DATE (v.hn02, 'dd/mm/yyyy') <>
                                    TO_DATE ('30/06/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '087',
                               'HN02', 0
                              );
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '090',
                               'HN02', 0
                              );
            END;

            -- Modify ManhTV3 on 29/02/2012
            -- Content: Kiem tra han nop cua phan bo quy 3
            BEGIN
               v_year := TO_CHAR (TO_DATE (v.hn03, 'dd/mm/yyyy'), 'yyyy');

               IF (TO_DATE (v.hn03, 'dd/mm/yyyy') <>
                                    TO_DATE ('30/09/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '087',
                               'HN03', 0
                              );
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '090',
                               'HN03', 0
                              );
            END;

            -- Modify ManhTV3 on 29/02/2012
            -- Content: Kiem tra han nop cua phan bo quy 4
            BEGIN
               v_year := TO_CHAR (TO_DATE (v.hn04, 'dd/mm/yyyy'), 'yyyy');

               IF (TO_DATE (v.hn04, 'dd/mm/yyyy') <>
                                    TO_DATE ('31/12/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '087',
                               'HN04', 0
                              );
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name, update_no
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '090',
                               'HN04', 0
                              );
            END;
         END;

         -- Modify by ManhTV3 on 29/02/2012
         -- Content: Kiem tra ngay hach toan
         /*BEGIN
            -- Truong hop: kylb_tu_ngay thuoc quy I
            v_year :=
                     TO_CHAR (TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy'), 'yyyy');

            IF (    TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') >=
                          TO_DATE ('01/01/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                AND TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') <=
                          TO_DATE ('31/03/' || TO_CHAR (v_year), 'dd/mm/yyyy')
               )
            THEN
               -- Kiem tra truong ht01
               IF (TO_DATE (v.ht01, 'dd/mm/yyyy') <>
                          TRUNC (TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy'), 'mm')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT01'
                              );
               ELSE
                  -- Kiem tra truong ht02
                  IF (TO_DATE (v.ht02, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/04/' || v_year, 'dd/mm/yyyy')
                     )
                  THEN
                     INSERT INTO tb_data_error
                                 (short_name, rid, table_name, err_id,
                                  field_name
                                 )
                          VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                                  'HT02'
                                 );
                  END IF;                       -- End of kiem tra truong ht02

                  -- Kiem tra truong ht03
                  IF (TO_DATE (v.ht03, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/07/' || v_year, 'dd/mm/yyyy')
                     )
                  THEN
                     INSERT INTO tb_data_error
                                 (short_name, rid, table_name, err_id,
                                  field_name
                                 )
                          VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                                  'HT03'
                                 );
                  END IF;                       -- End of kiem tra truong ht03

                  -- Kiem tra truong ht04
                  IF (TO_DATE (v.ht04, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/10/' || v_year, 'dd/mm/yyyy')
                     )
                  THEN
                     INSERT INTO tb_data_error
                                 (short_name, rid, table_name, err_id,
                                  field_name
                                 )
                          VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                                  'HT04'
                                 );
                  END IF;                       -- End of kiem tra truong ht04
               END IF;                          -- End of kiem tra truong ht01
            -- End of Truong hop 1

            -- Truong hop 2: ky_lbo_tu_ngay thuoc quy II
            ELSIF (    TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') >=
                          TO_DATE ('01/04/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                   AND TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') <=
                          TO_DATE ('30/06/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                  )
            THEN
               -- Kiem tra truong ht01
               IF (TO_DATE (v.ht01, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/01/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT01'
                              );
               END IF;                          -- End of kiem tra truong ht02

               IF (TO_DATE (v.ht02, 'dd/mm/yyyy') <>
                          TRUNC (TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy'), 'mm')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT02'
                              );
               END IF;

               -- Kiem tra truong ht03
               IF (TO_DATE (v.ht03, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/07/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT03'
                              );
               END IF;                          -- End of kiem tra truong ht03

               -- Kiem tra truong ht04
               IF (TO_DATE (v.ht04, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/10/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT04'
                              );
               END IF;                          -- End of kiem tra truong ht04
                                        -- End of Truong hop 2
            -- Truong hop 3: ky_lbo_tu_ngay thuoc quy III
            ELSIF (    TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') >=
                          TO_DATE ('01/07/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                   AND TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') <=
                          TO_DATE ('30/09/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                  )
            THEN
               -- Kiem tra truong ht01
               IF (TO_DATE (v.ht01, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/01/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT01'
                              );
               END IF;                          -- End of kiem tra truong ht01

               -- Kiem tra truong ht02
               IF (TO_DATE (v.ht02, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/04/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT02'
                              );
               END IF;                          -- End of kiem tra truong ht02

               -- Kiem tra truong ht03
               IF (TO_DATE (v.ht03, 'dd/mm/yyyy') <>
                          TRUNC (TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy'), 'mm')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT03'
                              );
               END IF;                          -- End of kiem tra truong ht03

               -- Kiem tra truong ht04
               IF (TO_DATE (v.ht04, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/10/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT04'
                              );
               END IF;                          -- End of kiem tra truong ht04
                                        -- End of Truong hop 3
            -- Truong hop 4: ky_lbo_tu_ngay thuoc quy IV
            ELSIF (    TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') >=
                          TO_DATE ('01/10/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                   AND TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy') <=
                          TO_DATE ('31/12/' || TO_CHAR (v_year), 'dd/mm/yyyy')
                  )
            THEN
               -- Kiem tra truong ht01
               IF (TO_DATE (v.ht01, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/01/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT01'
                              );
               END IF;                          -- End of kiem tra truong ht01

               -- Kiem tra truong ht02
               IF (TO_DATE (v.ht02, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/04/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT02'
                              );
               END IF;                          -- End of kiem tra truong ht02

               -- Kiem tra truong ht03
               IF (TO_DATE (v.ht03, 'dd/mm/yyyy') <>
                                    TO_DATE ('01/07/' || v_year, 'dd/mm/yyyy')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT03'
                              );
               END IF;                          -- End of kiem tra truong ht03

               -- Kiem tra truong ht04
               IF (TO_DATE (v.ht04, 'dd/mm/yyyy') <>
                          TRUNC (TO_DATE (v.kylb_tu_ngay, 'dd/mm/yyyy'), 'mm')
                  )
               THEN
                  INSERT INTO tb_data_error
                              (short_name, rid, table_name, err_id,
                               field_name
                              )
                       VALUES (p_short_name, v.ROWID, 'TB_TK', '088',
                               'HT04'
                              );
               END IF;                          -- End of kiem tra truong ht04
            -- End of Truong hop 4
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_error_message := SQLERRM;

               INSERT INTO tb_data_error
                           (short_name, rid, table_name, err_id,
                            field_name
                           )
                    VALUES (p_short_name, v.ROWID, 'TB_TK', NULL,
                            v_error_message
                           );
         END;*/

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong doanh thu du kien
         IF v.dthu_dkien < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'DTHU_DKIEN', 0
                        );
         END IF;

/*       -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong ti le thu nhap du kien
         IF v.tl_thnhap_dkien < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'TL_THNHAP_DKIEN', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong giam tru gia canh
         IF v.GTRU_GCANH < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'GTRU_GCANH', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong giam tru ban than
         IF v.BAN_THAN < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'BAN_THAN', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong giam tru cho nguoi phu thuoc
         IF v.PHU_THUOC < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'PHU_THUOC', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong thu nhap tinh thue du kien trong ky
         IF v.THNHAP_TTHUE_DKIEN < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'THNHAP_TTHUE_DKIEN', 0
                        );
         END IF;

         -- Modify by ManhTV3 on 15.06.2012
         -- Kiem tra truong thu nhap chiu thue phai nop du kien trong ky
         IF v.THNHAP_CTHUE_DKIEN < 0
         THEN
            INSERT INTO tb_data_error
                        (short_name, rid, table_name, err_id,
                         field_name, update_no
                        )
                 VALUES (p_short_name, v.ROWID, 'TB_TK', '044',
                         'THNHAP_CTHUE_DKIEN', 0
                        );
         END IF;*/
         COMMIT;
      END LOOP;
   END;
   
      -- Modify by ManhTV3 on 27/8/2012
   -- Content: kiem tra du lieu truoc chuyen doi
   PROCEDURE prc_ktra_truoc_cdoi_tk (p_short_name VARCHAR2)
   IS
      CURSOR c
      IS
         SELECT *
           FROM tb_tk
          WHERE short_name = p_short_name AND status IS NULL;
   BEGIN
      FOR v IN c
      LOOP
         IF (v.tncn <> (v.pb01 + v.pb02 + v.pb03 + v.pb04))
         THEN
            UPDATE tb_tk
               SET status = 'E'
             WHERE ID = v.ID;

            INSERT INTO tb_log_pscd
                        (tin, fieldname, msg_no, msg_type,
                         msg_des, ID, status,
                         process_step, short_name, type_data,
                         imp_date
                        )
                 VALUES (v.tin, 'TNCN', '086', NULL,
                         (SELECT a.err_name
                            FROM tb_lst_err a
                           WHERE a.err_id = '086'), v.ID, 'L?i',
                         'Preconvert', v.short_name, 'TK',
                         TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mm:ss')
                        );
         END IF;
      END LOOP;

      COMMIT;
   END;

   -- Modify by ManhTV3 on 11/03/2012
   -- Content: tach ma loi tu chuoi ma loi tu bang manhtv
   FUNCTION fnc_split (p_short_name VARCHAR2, p_table_name VARCHAR2)
      RETURN t_array
   IS
      v_err_code          VARCHAR (3);
      v_start             NUMBER;
      v_pos               NUMBER;
      v_count             NUMBER                  := 0;
      v_delimiter         VARCHAR2 (1)            := '-';
      data_errors_array   t_array;
      data_errors_row     tb_data_error%ROWTYPE;

      CURSOR c
      IS
         SELECT *
           FROM tb_unsplit_data_error
          WHERE short_name = p_short_name AND table_name = p_table_name;
   BEGIN
      FOR v IN c
      LOOP
         -- Modify by ManhTV3 on 5/4/2012
         -- Content: Bo sung theo yeu cau kiem tra MST trong PITMS
         IF (INSTR (v.err_string, '009', 1) != 0)
         THEN
            v.err_string := REPLACE (v.err_string, '-028', '');
            v.err_string := REPLACE (v.err_string, '-029', '');
            v.err_string := REPLACE (v.err_string, '-046', '');
            v.err_string := REPLACE (v.err_string, '-048', '');
         ELSE
            IF    (INSTR (v.err_string, '028', 1) != 0)
               OR (INSTR (v.err_string, '046', 1) != 0)
            THEN
               v.err_string := REPLACE (v.err_string, '-029', '');
               v.err_string := REPLACE (v.err_string, '-048', '');
            END IF;
         END IF;

         v_start := 1;
         v_pos := 1;

         LOOP
            v_start := v_pos + 1;
            v_err_code := SUBSTR (v.err_string, v_start, 3);
            v_count := v_count + 1;

            BEGIN
               data_errors_row.short_name := v.short_name;
               data_errors_row.rid := v.rid;
               data_errors_row.table_name := v.table_name;
               data_errors_row.err_id := v_err_code;
               data_errors_row.field_name := '';
               data_errors_row.update_no := 0;
               data_errors_array (v_count) := data_errors_row;
            END;

            v_pos := INSTR (v.err_string, v_delimiter, v_start);
            EXIT WHEN v_pos = 0;
         END LOOP;
      END LOOP;

      RETURN data_errors_array;
   END;

   -- Modify by ManhTV3 on 11/03/2012
   -- Content: insert noi dung cac loi da tach
   PROCEDURE prc_insert_splitted_err (
      p_short_name   VARCHAR2,
      p_table_name   VARCHAR2
   )
   IS
      data_errors_array   t_array;
      data_errors_row     tb_data_error%ROWTYPE;
   BEGIN
      data_errors_array := fnc_split (p_short_name, p_table_name);

      IF (data_errors_array.COUNT = 0)
      THEN
         RETURN;
      END IF;

      FOR i IN data_errors_array.FIRST .. data_errors_array.LAST
      LOOP
         data_errors_row := data_errors_array (i);

         BEGIN
            INSERT INTO tb_data_error
                 VALUES data_errors_row;
         END;
      END LOOP;

      COMMIT;
   END;

   /*************************************************************************** PCK_CHECK_DATA.Prc_Drop_DBlink
   MODIFY BY ThanhNH5 ON 21/03/2012
   Noi dung: Kiem tra du lieu co ky lap bo lon hon thoi diem chot du lieu
             chuyen doi
   ***************************************************************************/
   PROCEDURE prc_ktra_dlieu_kylb (p_short_name VARCHAR2)
   IS
      v_sql         VARCHAR2 (2000);
      v_ky_chot     VARCHAR2 (11);
      v_tax_model   VARCHAR2 (3);
      v_check       NUMBER (1);
   BEGIN
      DELETE FROM tb_dconvert_over
            WHERE short_name = p_short_name;

      SELECT TO_CHAR (ky_no_den, 'DD-MON-RRRR'), tax_model
        INTO v_ky_chot, v_tax_model
        FROM tb_lst_taxo
       WHERE short_name = p_short_name;

      EXECUTE IMMEDIATE    'INSERT INTO tb_dconvert_over(short_name, loai, ma_gdich, ten_gdich, so_luong)
        SELECT '''
                        || p_short_name
                        || ''' short_name, ''QLT'' loai, a.dgd_ma_gdich ma_gdich, b.ten ten_gdich, a.so_luong FROM 
        (
        SELECT dgd_ma_gdich, count(1) so_luong 
        FROM (
            SELECT dgd_ma_gdich FROM qlt_xltk_gdich@qlt_'
                        || p_short_name
                        || '
             WHERE (tmt_ma_muc=''1000'' OR tmt_ma_tmuc=''4268'') 
               AND kylb_tu_ngay>(SELECT rv_dat FROM tb_01_para WHERE rv_group=''KY_CHOT'') 
             GROUP BY dgd_ma_gdich, hdr_id, dtl_id having sum(SO_TIEN)<>0
            UNION ALL
            SELECT dgd_ma_gdich FROM qlt_ktt_gdich@qlt_'
                        || p_short_name
                        || '
             WHERE (tmt_ma_muc=''1000'' OR tmt_ma_tmuc=''4268'') 
               AND ngay_htoan>(SELECT rv_dat FROM tb_01_para WHERE rv_group=''KY_CHOT'') 
             GROUP BY dgd_ma_gdich, hdr_id, dtl_id having sum(SO_TIEN)<>0
         ) GROUP BY dgd_ma_gdich
         ) a, qlt_dm_gdich@qlt_'
                        || p_short_name
                        || ' b 
         WHERE a.dgd_ma_gdich=b.ma_gdich(+)';

      FOR v IN (SELECT 1
                  FROM tb_lst_taxo
                 WHERE short_name = p_short_name AND tax_model = 'QCT')
      LOOP
         EXECUTE IMMEDIATE    'INSERT INTO tb_dconvert_over(short_name, loai, ma_gdich, ten_gdich, so_luong)
            SELECT '''
                           || p_short_name
                           || ''' short_name, ''QCT'' loai, a.ma_gdich, b.ten ten_gdich, a.so_luong FROM 
            (
            SELECT ma_gdich, count(1) so_luong FROM qct_phai_nop@qlt_'
                           || p_short_name
                           || '
             WHERE (tmt_ma_muc=''1000'' OR tmt_ma_tmuc=''4268'') 
               AND kylb_tu_ngay>(SELECT rv_dat FROM tb_01_para WHERE rv_group=''KY_CHOT'') 
             GROUP BY ma_gdich
            UNION ALL
            SELECT ma_gdich, count(1) so_luong FROM qct_da_nop@qlt_'
                           || p_short_name
                           || '
             WHERE (tmt_ma_muc=''1000'' OR tmt_ma_tmuc=''4268'') 
               AND ngay_htoan>(SELECT rv_dat FROM tb_01_para WHERE rv_group=''KY_CHOT'') 
             GROUP BY ma_gdich 
             ) a, qct_dm_gdich@qlt_'
                           || p_short_name
                           || ' b 
             WHERE a.ma_gdich=b.ma_gdich(+)
               AND a.ma_gdich NOT IN (''86'',''87'',''96'',''97'')';
      END LOOP;

      FOR v IN (SELECT 1
                  FROM tb_dconvert_over
                 WHERE ROWNUM = 1 AND short_name = p_short_name)
      LOOP
         raise_application_error
            (-20001,
             'C? d? li?u l?n h?n k? ch?t chuy?n ??i, xem chi ti?t t?i b?ng TB_DCONVERT_OVER'
            );
      END LOOP;

      pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         pck_trace_log.prc_ins_log (p_short_name,
                                    pck_trace_log.fnc_whocalledme
                                   );
   END;

   /***************************************************************************
   PCK_CHECK_DATA.Prc_Dchieu_Vs_Master
   MODIFY BY ManhTV3 ON 31/05/2012
   Noi dung: Doi chieu du lieu phat sinh to khai 10/KK-TNCN voi bang hdr
   ***************************************************************************/
   PROCEDURE prc_dchieu_vs_master (p_short_name VARCHAR2)
   IS
      -- Du lieu phat sinh to khai 10
      CURSOR c_ps10
      IS
         SELECT tin_dtl, tong_dtl, ma_tkhai_dtl, ky_psinh_tu_dtl,
                ky_psinh_den_dtl, han_nop_dtl, ngay_nop_dtl, tin_hdr,
                tong_hdr, ma_tkhai_hdr, ky_psinh_tu_hdr, ky_psinh_den_hdr,
                han_nop_hdr, ngay_nop_hdr,
                (SELECT tax_code
                   FROM tb_lst_taxo
                  WHERE short_name = p_short_name) ma_cqt
           FROM (SELECT a.tin tin_dtl, NVL (a.so_tien, 0) tong_dtl,
                        a.ma_tkhai ma_tkhai_dtl,
                        a.ky_psinh_tu ky_psinh_tu_dtl,
                        a.ky_psinh_den ky_psinh_den_dtl,
                        a.han_nop han_nop_dtl, a.ngay_nop ngay_nop_dtl,
                        b.tin tin_hdr, NVL (b.so_tien, 0) tong_hdr,
                        b.ma_tkhai ma_tkhai_hdr,
                        b.ky_psinh_tu ky_psinh_tu_hdr,
                        b.ky_psinh_den ky_psinh_den_hdr,
                        b.han_nop han_nop_hdr, b.ngay_nop ngay_nop_hdr
                   FROM (SELECT *
                           FROM tb_ps
                          WHERE short_name = p_short_name
                            AND ma_tkhai = '10/KK-TNCN') a,
                        (SELECT *
                           FROM tb_ps_10pb
                          WHERE short_name = p_short_name) b
                  WHERE a.tin = b.tin(+)
                 UNION
                 SELECT a.tin tin_dtl, NVL (a.so_tien, 0) tong_dtl,
                        a.ma_tkhai ma_tkhai_dtl,
                        a.ky_psinh_tu ky_psinh_tu_dtl,
                        a.ky_psinh_den ky_psinh_den_dtl,
                        a.han_nop han_nop_dtl, a.ngay_nop ngay_nop_dtl,
                        b.tin tin_hdr, NVL (b.so_tien, 0) tong_hdr,
                        b.ma_tkhai ma_tkhai_hdr,
                        b.ky_psinh_tu ky_psinh_tu_hdr,
                        b.ky_psinh_den ky_psinh_den_hdr,
                        b.han_nop han_nop_hdr, b.ngay_nop ngay_nop_hdr
                   FROM (SELECT *
                           FROM tb_ps
                          WHERE short_name = p_short_name
                            AND ma_tkhai = '10/KK-TNCN') a,
                        (SELECT *
                           FROM tb_ps_10pb
                          WHERE short_name = p_short_name) b
                  WHERE a.tin(+) = b.tin)
          WHERE tong_dtl <> tong_hdr;

/*         SELECT tin_dtl, tong_dtl, tin_hdr, tong_hdr,
                (SELECT tax_code
                   FROM tb_lst_taxo
                  WHERE short_name = p_short_name) ma_cqt
           FROM (SELECT a.tin tin_dtl, NVL (a.so_tien, 0) tong_dtl,
                        b.tin tin_hdr, NVL (b.so_tien, 0) tong_hdr
                   FROM (SELECT *
                           FROM tb_ps
                          WHERE short_name = p_short_name
                            AND ma_tkhai = '10/KK-TNCN') a,
                        (SELECT *
                           FROM tb_master
                          WHERE short_name = p_short_name
                            AND TO_DATE (ky_psinh_tu, 'DD/MM/YYYY') >=
                                          TO_DATE ('01/01/2011', 'DD/MM/YYYY')
                            AND TO_DATE (ky_psinh_den, 'DD/MM/YYYY') <=
                                          TO_DATE ('31/12/2011', 'DD/MM/YYYY')) b
                  WHERE a.tin = b.tin(+)
                 UNION
                 SELECT a.tin tin_dtl, NVL (a.so_tien, 0) tong_dtl,
                        b.tin tin_hdr, NVL (b.so_tien, 0) tong_hdr
                   FROM (SELECT *
                           FROM tb_ps
                          WHERE short_name = p_short_name
                            AND ma_tkhai = '10/KK-TNCN') a,
                        (SELECT *
                           FROM tb_master
                          WHERE short_name = p_short_name
                            AND TO_DATE (ky_psinh_tu, 'DD/MM/YYYY') >=
                                          TO_DATE ('01/01/2011', 'DD/MM/YYYY')
                            AND TO_DATE (ky_psinh_den, 'DD/MM/YYYY') <=
                                          TO_DATE ('31/12/2011', 'DD/MM/YYYY')) b
                  WHERE a.tin(+) = b.tin)
          WHERE tong_dtl <> tong_hdr;*/

      -- Chi tiet to khai 10
      CURSOR c_tk10
      IS
         SELECT tin_dtl, tong_dtl, ma_tkhai_dtl, ky_psinh_tu_dtl,
                ky_psinh_den_dtl, tin_hdr, tong_hdr, ma_tkhai_hdr,
                ky_psinh_tu_hdr, ky_psinh_den_hdr,
                (SELECT tax_code
                   FROM tb_lst_taxo
                  WHERE short_name = p_short_name) ma_cqt
           FROM (SELECT a.tin tin_dtl, NVL (a.tncn, 0) tong_dtl,
                        '10/KK-TNCN' ma_tkhai_dtl,
                        a.kykk_tu_ngay ky_psinh_tu_dtl,
                        a.kykk_den_ngay ky_psinh_den_dtl, b.tin tin_hdr,
                        NVL (b.so_tien, 0) tong_hdr,
                        '10/KK-TNCN' ma_tkhai_hdr,
                        b.ky_psinh_tu ky_psinh_tu_hdr,
                        b.ky_psinh_den ky_psinh_den_hdr
                   FROM (SELECT *
                           FROM tb_tk
                          WHERE short_name = p_short_name and TAX_MODEL = 'VAT_APP') a,
                        (SELECT *
                           FROM tb_master
                          WHERE short_name = p_short_name
                            AND TO_DATE (ky_psinh_tu, 'DD/MM/YYYY') >=
                                          TO_DATE ('01/01/2012', 'DD/MM/YYYY')) b
                  WHERE a.tin = b.tin(+)
                 UNION
                 SELECT a.tin tin_dtl, NVL (a.tncn, 0) tong_dtl,
                        '10/KK-TNCN' ma_tkhai_dtl,
                        a.kykk_tu_ngay ky_psinh_tu_dtl,
                        a.kykk_den_ngay ky_psinh_den_dtl, b.tin tin_hdr,
                        NVL (b.so_tien, 0) tong_hdr,
                        '10/KK-TNCN' ma_tkhai_hdr,
                        b.ky_psinh_tu ky_psinh_tu_hdr,
                        b.ky_psinh_den ky_psinh_den_hdr
                   FROM (SELECT *
                           FROM tb_tk
                          WHERE short_name = p_short_name and TAX_MODEL = 'VAT_APP') a ,
                        (SELECT *
                           FROM tb_master
                          WHERE short_name = p_short_name
                            AND TO_DATE (ky_psinh_tu, 'DD/MM/YYYY') >=
                                          TO_DATE ('01/01/2012', 'DD/MM/YYYY')) b
                  WHERE a.tin(+) = b.tin)
          WHERE tong_dtl <> tong_hdr;
   BEGIN
      -- Phat sinh to khai 10/KK-TNCN
      FOR v IN c_ps10
      LOOP
         IF v.tin_dtl IS NULL
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_hdr, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_PS', v.ma_tkhai_hdr,
                         v.ky_psinh_tu_hdr, v.ky_psinh_den_hdr,
                         v.han_nop_hdr, v.ngay_nop_hdr);
         ELSIF v.tin_hdr IS NULL
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_dtl, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_PS', v.ma_tkhai_dtl,
                         v.ky_psinh_tu_dtl, v.ky_psinh_den_dtl,
                         v.han_nop_dtl, v.ngay_nop_dtl);
         ELSIF v.tong_dtl <> v.tong_hdr
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_dtl, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_PS', v.ma_tkhai_dtl,
                         v.ky_psinh_tu_dtl, v.ky_psinh_den_dtl,
                         v.han_nop_dtl, v.ngay_nop_dtl);
         END IF;
      END LOOP;

      -- Chi tiet to khai 10/KK-TNCN
      FOR v IN c_tk10
      LOOP
         IF v.tin_dtl IS NULL
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_hdr, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_TK', v.ma_tkhai_hdr,
                         v.ky_psinh_tu_hdr, v.ky_psinh_den_hdr, NULL, NULL);
         ELSIF v.tin_hdr IS NULL
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_dtl, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_TK', v.ma_tkhai_dtl,
                         v.ky_psinh_tu_dtl, v.ky_psinh_den_dtl, NULL, NULL);
         ELSIF v.tong_dtl <> v.tong_hdr
         THEN
            INSERT INTO tb_master_sl
                 VALUES (p_short_name, v.tin_dtl, v.ma_cqt, v.tong_hdr,
                         v.tong_dtl,
                         'T?ng s? thu? trong k? kh?c t?ng s? thu? ph?n b?',
                         seq_id_csv.NEXTVAL, 0, 'TB_TK', v.ma_tkhai_dtl,
                         v.ky_psinh_tu_dtl, v.ky_psinh_den_dtl, NULL, NULL);
         END IF;
      END LOOP;
   END;

   /***************************************************************************
   PCK_CHECK_DATA.Prc_Tang_Gtri_Update_No
   MODIFY BY ManhTV3 ON 31/05/2012
   Noi dung: Cap nhat truong update_no
   ***************************************************************************/
   PROCEDURE prc_tang_gtri_update_no (p_short_name VARCHAR2)
   IS
   BEGIN
      UPDATE tb_master_sl
         SET update_no = (SELECT MAX (update_no) + 1
                            FROM tb_master_sl
                           WHERE short_name = p_short_name)
       WHERE update_no = 0 AND short_name = p_short_name;
   END;

   /***************************************************************************
   PCK_CHECK_DATA.prc_htro_dchieu
   MODIFY BY ThanhNH5 ON 14/06/2012
   Noi dung: Cap nhat truong update_no
   ***************************************************************************/
   PROCEDURE prc_htro_dchieu (p_short_name VARCHAR2)
   IS
      v_chot   VARCHAR2 (20);
      v_pck    VARCHAR2 (1);
   BEGIN
      pck_moi_truong.prc_set_glview (p_short_name);

      EXECUTE IMMEDIATE 'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';

      EXECUTE IMMEDIATE 'ALTER SESSION SET nls_date_format=''DD-MON-RRRR''';

      SELECT DECODE (tax_model, 'QLT', '7', 'QCT', '8') pck,
             TO_CHAR (ky_no_den, 'DD-MON-RRRR') ky_no_den
        INTO v_pck,
             v_chot
        FROM tb_lst_taxo
       WHERE short_name = p_short_name;

      EXECUTE IMMEDIATE    '
    BEGIN
    EXT_PCK_CONTROL_'
                        || v_pck
                        || '.Prc_DoiChieu@qlt_'
                        || p_short_name
                        || '(to_date('''
                        || v_chot
                        || ''',''DD-MON-RRRR''));
    END;
    ';

      DELETE FROM tb_temp_dchieu
            WHERE short_name = p_short_name;

      EXECUTE IMMEDIATE    '
        INSERT INTO tb_temp_dchieu(short_name, mau, v_char1, v_char2, v_char3, loai)
        SELECT '''
                        || p_short_name
                        || ''' short_name, mau, v_char1, v_char2, v_char3, loai
        FROM ext_temp_dchieu@qlt_'
                        || p_short_name
                        || '   
    ';

      DELETE FROM tb_temp_htdc_ps
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_ps
                  (a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                   b_sotien, sl_sotien, short_name)
         SELECT a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                b_sotien, sl_sotien, p_short_name
           FROM vw_htro_dchieu_ps;

      DELETE FROM tb_temp_htdc_no
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_no
                  (a_tax_model, a_ma_tmuc, b_tax_model, b_ma_tmuc, a_so_no,
                   b_so_no, sl_so_no, a_so_thua, b_so_thua, sl_so_thua,
                   short_name)
         SELECT a_tax_model, a_ma_tmuc, b_tax_model, b_ma_tmuc, a_so_no,
                b_so_no, sl_so_no, a_so_thua, b_so_thua, sl_so_thua,
                p_short_name
           FROM vw_htro_dchieu_no;

      DELETE FROM tb_temp_htdc_tk
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_tk
                  (a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                   b_sotien, sl_sotien, short_name)
         SELECT a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                b_sotien, sl_sotien, p_short_name
           FROM vw_htro_dchieu_tk;

      pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         pck_trace_log.prc_ins_log (p_short_name,
                                    pck_trace_log.fnc_whocalledme
                                   );
   END;

   /***************************************************************************
   PCK_CHECK_DATA.prc_htro_dchieu_vat
   MODIFY BY ManhTV3 ON 17/07/2012
   Noi dung: Ho tro doi chieu VAT
   ***************************************************************************/
   PROCEDURE prc_htro_dchieu_vat (p_short_name VARCHAR2)
   IS
      v_chot   VARCHAR2 (20);
      v_pck    VARCHAR2 (1);
   BEGIN
      pck_moi_truong.prc_set_glview (p_short_name);

      UPDATE tb_temp_dchieu a
         SET v_char2 =
                TRIM (TO_CHAR ((  TO_NUMBER (v_char2, '999,999,999,999')
                                + TO_NUMBER (NVL ((SELECT SUM (  b.thuepbo
                                                               - b.thuetky
                                                              )
                                                     FROM tb_master_sl b
                                                    WHERE b.short_name =
                                                                  a.short_name
                                                      AND update_no = 0
                                                      AND table_name = 'TB_TK'),
                                                  0
                                                 )
                                            )
                               ),
                               '999,999,999,999'
                              )
                     ),
             a.v_char3 = 'Y'
       WHERE a.short_name = USERENV ('client_info')
         AND a.loai = 'TK'
         AND a.v_char3 IS NULL;

      DELETE FROM tb_temp_htdc_ps
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_ps
                  (a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                   b_sotien, sl_sotien, short_name)
         SELECT a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                b_sotien, sl_sotien, p_short_name
           FROM vw_htro_dchieu_ps;

      DELETE FROM tb_temp_htdc_no
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_no
                  (a_tax_model, a_ma_tmuc, b_tax_model, b_ma_tmuc, a_so_no,
                   b_so_no, sl_so_no, a_so_thua, b_so_thua, sl_so_thua,
                   short_name)
         SELECT a_tax_model, a_ma_tmuc, b_tax_model, b_ma_tmuc, a_so_no,
                b_so_no, sl_so_no, a_so_thua, b_so_thua, sl_so_thua,
                p_short_name
           FROM vw_htro_dchieu_no;

      DELETE FROM tb_temp_htdc_tk
            WHERE short_name = p_short_name;

      INSERT INTO tb_temp_htdc_tk
                  (a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                   b_sotien, sl_sotien, short_name)
         SELECT a_tax_model, a_to_khai, b_tax_model, b_to_khai, a_sotien,
                b_sotien, sl_sotien, p_short_name
           FROM vw_htro_dchieu_tk;

      pck_trace_log.prc_ins_log (p_short_name, pck_trace_log.fnc_whocalledme);
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         pck_trace_log.prc_ins_log (p_short_name,
                                    pck_trace_log.fnc_whocalledme
                                   );
   END;

   /***************************************************************************
   PCK_CHECK_DATA.Prc_Jobs_Htdc
   MODIFY BY ThanhNH5 ON 18/06/2012
   Noi dung: Cap nhat truong update_no
   ***************************************************************************/
   PROCEDURE prc_jobs_htdc (p_short_name VARCHAR2)
   IS
   BEGIN
      DBMS_SCHEDULER.create_job
         (job_name        => DBMS_SCHEDULER.generate_job_name (   'DCHIEU_'
                                                               || p_short_name
                                                               || '_'
                                                              ),
          job_type        => 'PLSQL_BLOCK',
          job_action      =>    'begin 
                        PCK_CHECK_DATA.prc_htro_dchieu('''
                             || p_short_name
                             || '''); 
                        end;',
          enabled         => TRUE,
          auto_drop       => TRUE
         );
      pck_trace_log.prc_ins_log (p_short_name, 'PRC_HTRO_DCHIEU', 'P');
   END;

   /***************************************************************************
   PCK_CHECK_DATA.Prc_Jobs_Htdc
   MODIFY BY ThanhNH5 ON 18/06/2012
   Noi dung: Cap nhat truong update_no
   ***************************************************************************/
   PROCEDURE prc_check_dblink (p_short_name VARCHAR2)
   IS
      v_check   VARCHAR2 (1);
   BEGIN
      EXECUTE IMMEDIATE 'SELECT 1 FROM dual@qlt_' || p_short_name
                   INTO v_check;

      UPDATE tb_lst_taxo
         SET dblink = 'OK'
       WHERE short_name = p_short_name;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         UPDATE tb_lst_taxo
            SET dblink = '*'
          WHERE short_name = p_short_name;

         COMMIT;
   END;
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_CHECK_DATA

-- Start of DDL Script for Package Body TKTQ.PCK_CHUYENDOI_VAT
-- Generated 15-Jan-2013 13:17:05 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_chuyendoi_vat
IS
--
-- To modify this template, edit file PKGBODY.TXT in TEMPLATE 
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the package body
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------      
   -- Enter procedure, function bodies as shown below

  /* Formatted on 2012/02/08 18:07 (Formatter Plus v4.8.7) */
PROCEDURE prc_tong_dulieuphatsinh (p_short_name VARCHAR2)
    IS
    CURSOR c_sotien
    IS
      SELECT   tin, ky_psinh_tu, ky_psinh_den, to_char(min(to_date(ngay_nop,'dd/mm/yyyy')))  AS ngay_nop,
               SUM (so_tien) AS sotien, ma_tkhai,ma_tmuc
          FROM tb_ps
         WHERE tax_model = 'VAT_APP'
         AND   short_name = p_short_name
        HAVING COUNT (tin) > 1
      GROUP BY tin, ky_psinh_tu, ky_psinh_den, ma_tkhai,ma_tmuc
      ORDER BY tin;
   
    Cursor c_delete_duplicate_rows is      
      SELECT   min(rowid) as row_id,tin,ky_psinh_tu, ky_psinh_den, 
                ngay_nop, ma_tkhai,ma_tmuc
          FROM tb_ps
         WHERE tax_model = 'VAT_APP'
         AND   short_name = p_short_name
        HAVING COUNT (tin) > 1
      GROUP BY tin, ky_psinh_tu, ky_psinh_den,  ngay_nop,
               ma_tkhai,ma_tmuc ;      
    BEGIN
     FOR vc_sotien IN c_sotien
       LOOP
       UPDATE tb_ps
         SET so_tien = vc_sotien.sotien
       WHERE tax_model = 'VAT_APP'
         AND short_name = p_short_name
         AND tin = vc_sotien.tin
         AND ky_psinh_tu = vc_sotien.ky_psinh_tu        
         AND to_date(ngay_nop,'dd/mm/yyyy') = vc_sotien.ngay_nop
         AND ma_tmuc = vc_sotien.ma_tmuc
         AND ma_tkhai = vc_sotien.ma_tkhai;
    
      DELETE FROM tb_ps
            WHERE tax_model = 'VAT_APP'
              AND tin = vc_sotien.tin
              AND short_name = p_short_name
              AND ky_psinh_tu = vc_sotien.ky_psinh_tu
              AND to_date(ngay_nop,'dd/mm/yyyy') <> vc_sotien.ngay_nop
              AND ma_tmuc = vc_sotien.ma_tmuc
              AND ma_tkhai = vc_sotien.ma_tkhai;
             
   END LOOP;

   FOR vc_delete_duplicate_rows IN c_delete_duplicate_rows LOOP

      DELETE FROM tb_ps
            WHERE ROWID > vc_delete_duplicate_rows.row_id
              AND tin = vc_delete_duplicate_rows.tin
              AND ky_psinh_tu = vc_delete_duplicate_rows.ky_psinh_tu
              AND ky_psinh_den = vc_delete_duplicate_rows.ky_psinh_den
              AND ngay_nop = vc_delete_duplicate_rows.ngay_nop
              AND ma_tkhai = vc_delete_duplicate_rows.ma_tkhai
              AND ma_tmuc = vc_delete_duplicate_rows.ma_tmuc
              AND tax_model = 'VAT_APP'
              AND short_name = p_short_name;              
   END LOOP;
  
   DELETE FROM tb_ps
         WHERE tax_model = 'VAT_APP'
           AND so_tien = 0;   

   COMMIT;
   END;

   FUNCTION Fnc_convert_font_data(P_instring VARCHAR2) RETURN VARCHAR2
   IS
      V_resultstring   VARCHAR2(32000);
      V_tempstring     VARCHAR2(32000);
      V_chr            VARCHAR2(3);
   BEGIN
      BEGIN     
          IF (INSTR(P_instring, ':') = 0) THEN
             RETURN NULL;
          ELSE
             V_tempstring := SUBSTR(P_instring, INSTR(P_instring, ':') + 1) || ',';
          END IF;
    
          WHILE INSTR(V_tempstring, ',') > 0 LOOP
             V_tempstring := SUBSTR(V_tempstring, 2);
             IF INSTR(V_tempstring, ',') > 0 THEN
                V_chr := SUBSTR(V_tempstring, 1, INSTR(V_tempstring, ',') - 1);
                V_tempstring := SUBSTR(V_tempstring, INSTR(V_tempstring, ','));
             ELSE
                EXIT;
             END IF;
    
--             V_resultstring := V_resultstring || CONVERT(CHR(TO_NUMBER(V_chr)), 'UTF8', 'VN8VN3');
             V_resultstring := V_resultstring || CONVERT(CHR(TO_NUMBER(V_chr)), 'VN8VN3', 'UTF8');
          END LOOP;
        
    --      RETURN V_resultstring;
          EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line('loi:'||SUBSTR(V_tempstring,1,4000)||'**CHUOI**'||V_chr);
            RETURN NULL;
        END;
        RETURN V_resultstring;        
   END;

   PROCEDURE Prc_reset_log(p_short_name VARCHAR2, kind VARCHAR2)
   IS
   /*   CURSOR c_sotien
   IS
      SELECT   tin, ky_psinh_tu, ky_psinh_den, to_char(min(to_date(ngay_nop,'dd/mm/yyyy')))  AS ngay_nop,
               SUM (so_tien) AS sotien, ma_tkhai,ma_tmuc
          FROM tb_ps
         WHERE tax_model = 'VAT_APP'
           AND short_name = p_short_name
        HAVING COUNT (tin) > 1
      GROUP BY tin, ky_psinh_tu, ky_psinh_den, ma_tkhai,ma_tmuc
      ORDER BY tin;*/
    BEGIN
  
    If kind = 'PS_COPY' Then
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_PS_THANG');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_PS_QUY');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_P10');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_P10A');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_SDPS');        
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_QDAD');        
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_BH'); 
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_XS');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_PS');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_CAP_NHAT_DANH_MUC'); 
        COMMIT;              
    End If;    
    
    If kind = 'NO_COPY' Then
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_NO');
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_NO');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_CAP_NHAT_DANH_MUC'); 
        COMMIT;              
    End If;    

    If kind ='TK_COPY' Then
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'FNC_DOC_FILE_TK10');            
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_TK');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_CAP_NHAT_DANH_MUC'); 
        COMMIT;              
    End If;    

    If kind = 'PS_READ' Then            
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_PS');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        COMMIT;              
    End If;    

    If kind ='NO_READ' Then            
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_NO');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        COMMIT;              
    End If;    

    If kind = 'TK_READ' Then            
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KTRA_TK');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_SLECH');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_CTIET');               
        PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, 'PRC_KXUAT_BBAN'); 
        COMMIT;              
    End If;    

    
    END;   

   PROCEDURE Prc_Capnhatdanhmuc (p_short_name VARCHAR2)
   IS
   CURSOR c_danhmuc
   IS
      SELECT   madtnt, mabpql,macaptren,tenbophanquanly, tencaptrenquanly, short_name
          FROM tb_dtnt
         WHERE short_name = p_short_name
      ORDER BY madtnt;
   
   BEGIN
   FOR vc_danhmuc IN c_danhmuc
   LOOP
       UPDATE tb_ps 
          SET ma_cbo     = vc_danhmuc.mabpql,
              ma_pban    = vc_danhmuc.macaptren,
              ten_cbo    = vc_danhmuc.tenbophanquanly,
              ten_pban   = vc_danhmuc.tencaptrenquanly
        WHERE tin        = vc_danhmuc.madtnt
          AND short_name = vc_danhmuc.short_name;
                 
       UPDATE tb_no 
          SET ma_cbo     = vc_danhmuc.mabpql,
              ma_pban    = vc_danhmuc.macaptren,
              ten_cbo    = vc_danhmuc.tenbophanquanly,
              ten_pban   = vc_danhmuc.tencaptrenquanly    
        WHERE tin        = vc_danhmuc.madtnt
          AND short_name = vc_danhmuc.short_name;

       UPDATE tb_tk 
          SET ma_cbo     = vc_danhmuc.mabpql,
              ma_pban    = vc_danhmuc.macaptren,
              ten_cbo    = vc_danhmuc.tenbophanquanly,
              ten_pban   = vc_danhmuc.tencaptrenquanly,              
              flag       = '12'              
        WHERE tin        = vc_danhmuc.madtnt
          AND short_name = vc_danhmuc.short_name;
             
   END LOOP;  
   COMMIT;
   END;

   PROCEDURE Prc_ChitietTK10(p_short_name VARCHAR2)
   IS
   CURSOR c_delete
   IS
      SELECT tin, short_name, to_char(max(to_date(ngaynop,'dd/mm/yyyy')))  AS ngay_nop
      FROM tb_pt a
      WHERE a.short_name = p_short_name
      GROUP BY tin, short_name;   
   
   BEGIN
   FOR vc_delete IN c_delete
   LOOP
        
      DELETE FROM tb_pt
            WHERE 
                  tin = vc_delete.tin
              AND short_name = p_short_name
              AND to_date(ngaynop,'dd/mm/yyyy') < vc_delete.ngay_nop;
             
   END LOOP;
   COMMIT;
   END;
 
   FUNCTION Fnc_ChitietTK10(p_short_name VARCHAR2) RETURN NUMBER
   IS
   CURSOR c_delete
   IS
   SELECT tin, short_name, to_char(max(to_date(ngaynop,'dd/mm/yyyy')))  AS ngay_nop
     FROM tb_pt a
    WHERE a.short_name = p_short_name
    GROUP BY tin, short_name;   
   v_count number:=0;
   BEGIN
   FOR vc_delete IN c_delete
   LOOP
        
      DELETE FROM tb_pt
            WHERE 
                  tin = vc_delete.tin
              AND short_name = p_short_name
              AND to_date(ngaynop,'dd/mm/yyyy') < vc_delete.ngay_nop;
             
   END LOOP;
   COMMIT;
   SELECT Count(1)  into v_count from tb_pt where short_name = p_short_name;
   RETURN v_count;
   END;     
        
   -- Enter further code below as specified in the Package spec.
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_CHUYENDOI_VAT

-- Start of DDL Script for Package Body TKTQ.PCK_CUTOVER
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_cutover
IS   
    /*************************************************************************** PCK_CUTOVER.Prc_Chan_Chuc_Nang(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Chan_Chuc_Nang(p_short_name VARCHAR2) IS
        v_check VARCHAR2(1) :=NULL;
    BEGIN
        -- Truong hop QLT 
        BEGIN
        EXECUTE IMMEDIATE
            'SELECT gia_tri FROM qlt_tham_so@QLT_'||p_short_name||' WHERE ten=''PIT''' 
            INTO v_check;
        EXCEPTION WHEN OTHERS THEN
            NULL;
        END;
    
        IF (v_check IS NULL) THEN
            EXECUTE IMMEDIATE 
                'INSERT INTO qlt_tham_so@QLT_'||p_short_name||'
                 (ten,gia_tri,ghi_chu,update_allowed,visibled)
                    VALUES(''PIT'',''Y'',''Trien khai PIT'',''N'',''N'')';
        ELSE
            IF (v_check='Y') THEN
                v_check:='N';
            ELSE
                v_check:='Y';
            END IF;
            
            EXECUTE IMMEDIATE 
                'UPDATE qlt_tham_so@QLT_'||p_short_name||' 
                    SET gia_tri='''||v_check||''' WHERE ten=''PIT''';
        END IF;
        
        -- Truong hop QCT 
        FOR v IN (SELECT 1 FROM tb_lst_taxo 
                    WHERE short_name=p_short_name
                      AND tax_model='QCT') LOOP
            v_check:=NULL;
            
            BEGIN
            EXECUTE IMMEDIATE
                'SELECT gia_tri FROM qct_tham_so@QLT_'||p_short_name||' WHERE ten=''PIT''' 
                INTO v_check;
            EXCEPTION WHEN OTHERS THEN
                NULL;
            END;
            
            IF (v_check IS NULL) THEN
                EXECUTE IMMEDIATE 
                    'INSERT INTO qct_tham_so@QLT_'||p_short_name||'
                     (id, ten, gia_tri, ghi_chu, cap_nhat, hien_thi)
                     Select Max(Id) + 1 Id,
                            Max(''PIT''),
                            Max(''Y''),
                            Max(''Tham s? x?c ??nh tri?n khai PIT''),
                            Max(''N''),
                            Max(''N'') FROM qct_tham_so@QLT_'||p_short_name;
            ELSE
                IF (v_check='Y') THEN
                    v_check:='N';
                ELSE
                    v_check:='Y';
                END IF;
                
                EXECUTE IMMEDIATE 
                    'UPDATE qct_tham_so@QLT_'||p_short_name||' 
                        SET gia_tri='''||v_check||''' WHERE ten=''PIT''';
            END IF;
                    
        END LOOP;
        
        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        IF (v_check='N') THEN 
            PCK_TRACE_LOG.Prc_Upd_Log_Max(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        END IF;
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    END;
    /***************************************************************************
    PCK_CUTOVER.Prc_Tat_Toan(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Tat_Toan(p_short_name VARCHAR2) IS
        v_chot DATE;        
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
        
        SELECT trunc(ky_no_den,'MONTH') INTO v_chot FROM tb_lst_taxo
            WHERE short_name=p_short_name;
                            
        EXECUTE IMMEDIATE '
        BEGIN
            ext_pck_control_5.Prc_Ttoan_Qlt@qlt_'||p_short_name||'('''||v_chot||''');
        END;';
        
        FOR v IN (SELECT 1 FROM tb_lst_taxo WHERE short_name=p_short_name) LOOP
        EXECUTE IMMEDIATE '
        BEGIN
            ext_pck_control_6.Prc_Ttoan_Qct@qlt_'||p_short_name||'('''||v_chot||''');
        END;';            
        END LOOP;
        
        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);        
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);        
    END;
    /***************************************************************************
    PCK_CUTOVER.Prc_Tat_Toan(p_short_name)
    ***************************************************************************/
    PROCEDURE Prc_Dmuc_Hluc(p_short_name VARCHAR2) IS
        v_chot DATE;        
    BEGIN
        EXECUTE IMMEDIATE 
            'ALTER SESSION SET remote_dependencies_mode = SIGNATURE';
        
        SELECT ky_no_den INTO v_chot FROM tb_lst_taxo
            WHERE short_name=p_short_name;
                            
        EXECUTE IMMEDIATE '
        BEGIN
            ext_pck_control_5.Prc_Dmuc_Hluc@qlt_'||p_short_name||'('''||v_chot||''');
        END;';
        
        FOR v IN (SELECT 1 FROM tb_lst_taxo WHERE short_name=p_short_name) LOOP
        EXECUTE IMMEDIATE '
        BEGIN
            ext_pck_control_6.Prc_Dmuc_Hluc@qlt_'||p_short_name||'('''||v_chot||''');
        END;';            
        END LOOP;
        
        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);        
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);        
    END;    
END pck_cutover;
/


-- End of DDL Script for Package Body TKTQ.PCK_CUTOVER

-- Start of DDL Script for Package Body TKTQ.PCK_JAVA_WIN
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_java_win IS
    PROCEDURE Prc_Host(p_command IN Varchar2)
        AS LANGUAGE JAVA
            NAME 'Host.executeCommand(java.lang.String)';
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_JAVA_WIN

-- Start of DDL Script for Package Body TKTQ.PCK_MOI_TRUONG
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_moi_truong
IS
    /*************************************************************************** PCK_MOI_TRUONG.Prc_Cre_DBlink(p_pay_taxo_id)
    Noi dung: Dua ra danh sach chenh lech
    ***************************************************************************/
    PROCEDURE Prc_Cre_DBlink(p_short_name VARCHAR2) IS
        v_user_qlt VARCHAR2(20);
        v_pass_qlt VARCHAR2(20);
        v_ses      NUMBER(2);
    BEGIN
        FOR v IN (SELECT  qlt_user, qlt_pass FROM tb_lst_taxo WHERE short_name = p_short_name) 
        LOOP
            IF ((v.qlt_user IS NOT NULL) AND (v.qlt_pass IS NOT NULL)) THEN
                Prc_Drop_DBlink('QLT');                
                EXECUTE IMMEDIATE
                    'CREATE DATABASE LINK QLT '||
                        'CONNECT TO '||v.qlt_user||' IDENTIFIED BY '||v.qlt_pass||'
                         USING ''QLT_'||p_short_name||''''; 
            END IF;                   
        END LOOP;        
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name,
                                      pck_trace_log.Fnc_WhoCalledMe);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Close_DBlink
    Noi dung: Dong phien lam viec DBLINK
    ***************************************************************************/
    PROCEDURE Prc_Close_DBlink(p_link VARCHAR2) IS
    BEGIN
        COMMIT;
        FOR v IN (SELECT db_link FROM v$dblink WHERE db_link=p_link) LOOP
            DBMS_SESSION.CLOSE_DATABASE_LINK(v.db_link);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(userenv('client_info'),
                                      pck_trace_log.Fnc_WhoCalledMe);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Drop_DBlink
    Noi dung: Xoa DATABASE LINK
    ***************************************************************************/
    PROCEDURE Prc_Drop_DBlink(p_link VARCHAR2) IS
    BEGIN
        Prc_Close_DBlink(p_link);
        FOR v IN (SELECT db_link FROM all_db_links WHERE db_link=p_link) LOOP
            EXECUTE IMMEDIATE 'DROP DATABASE LINK '||v.db_link;
        END LOOP;
    END;

    /***************************************************************************
    pck_trace_log.Fnc_WhoCalledMe: Xac dinh noi PROCEDURE goi trong PCK
    ***************************************************************************/
    PROCEDURE Prc_Remote_Sql(p_sql IN VARCHAR2 ) AS
        exec_cursor     INTEGER DEFAULT dbms_sql.open_cursor@qlt;
        rows_processed  NUMBER  DEFAULT 0;
    BEGIN
        dbms_sql.parse@qlt(exec_cursor, p_sql, dbms_sql.native);
        rows_processed := dbms_sql.EXECUTE@qlt(exec_cursor);
        dbms_sql.close_cursor@qlt(exec_cursor);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Seq
    Noi dung: Khoi tao SEQUENCE
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_Seq IS
        v_str VARCHAR2(5000);
    BEGIN
        Prc_Ddep_Seq;
        prc_remote_sql('CREATE SEQUENCE ext_seq
                        INCREMENT BY 1
                        START WITH 1
                        MINVALUE 1
                        MAXVALUE 999999999999999999999999999
                        NOCYCLE
                        ORDER
                        CACHE 20');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDep_Seq
    Noi dung: Don dep SEQUENCE
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_Seq IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_SEQ';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'SEQUENCE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP SEQUENCE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_ps
    Noi dung: Khoi tao bang ext_qlt_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_qlt_ps IS
    BEGIN
        Prc_Ddep_tb_ext_qlt_ps;

        prc_remote_sql('CREATE TABLE ext_qlt_ps(id  NUMBER(10,0) NOT NULL,
                tin                         VARCHAR2(14),
                ma_chuong                   VARCHAR2(3),
                ma_khoan                    VARCHAR2(3),
                ma_tmuc                     VARCHAR2(4),
                so_tien                     NUMBER(20,2),
                ghi_chu                     VARCHAR2(100),
                ket_xuat                    NUMBER(1,0) DEFAULT 0,
                ngay_nop                    DATE,
                ma_tkhai                    VARCHAR2(2),
                ky_psinh_tu                 DATE,
                ky_psinh_den                DATE,
                loai_dlieu                  VARCHAR2(2),
                han_nop                     DATE,
                ngay_htoan                  DATE,
                ma_cbo                      VARCHAR2(15),
                ten_cbo                     VARCHAR2(150),
                ma_pban                     VARCHAR2(15),
                ten_pban                    VARCHAR2(250))');
        prc_remote_sql('ALTER TABLE ext_qlt_ps
                        ADD CONSTRAINT ext_qpd_pk PRIMARY KEY (id)
                        USING INDEX');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_ps
    Noi dung: Don dep bang ext_qlt_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_qlt_ps IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_QLT_PS';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_no
    Noi dung: Khoi tao bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_qlt_no IS
    BEGIN
        Prc_Ddep_tb_ext_qlt_no;

        prc_remote_sql('CREATE TABLE ext_qlt_no
                (
                id                             NUMBER(10,0) NOT NULL,
                kyno_tu_ngay                   DATE NOT NULL,
                kyno_den_ngay                  DATE NOT NULL,
                hdr_id                         NUMBER(10,0) NOT NULL,
                dtl_id                         NUMBER(10,0) NOT NULL,
                dgd_ma_gdich                   VARCHAR2(3) NOT NULL,
                dgd_kieu_gdich                 VARCHAR2(2) NOT NULL,
                tkhoan                         VARCHAR2(20),
                kylb_tu_ngay                   DATE NOT NULL,
                kylb_den_ngay                  DATE NOT NULL,
                kykk_tu_ngay                   DATE,
                kykk_den_ngay                  DATE,
                tin                            VARCHAR2(14) NOT NULL,
                ma_cqt                         VARCHAR2(5) NOT NULL,
                ma_phong                       VARCHAR2(7),
                ma_canbo                       VARCHAR2(10),
                tmt_ma_muc                     VARCHAR2(4) NOT NULL,
                tmt_ma_tmuc                    VARCHAR2(4) NOT NULL,
                tmt_ma_thue                    VARCHAR2(2),
                no_dau_ky                      NUMBER(20,0),
                no_cuoi_ky                     NUMBER(20,0),
                han_nop                        DATE,
                nguon_goc                      VARCHAR2(200),
                ghi_chu                        VARCHAR2(100),
                kytt_tu_ngay                   DATE,
                kytt_den_ngay                  DATE,
                check_kno                      VARCHAR2(1),
                qdinh_id                       NUMBER(20,0),
                loai_qdinh                     VARCHAR2(2),
                status                         VARCHAR2(1) DEFAULT 2,
                ma_chuong                      VARCHAR2(3),
                ma_khoan                       VARCHAR2(3),
                so_tien                        NUMBER(20,0),
                ket_xuat                       NUMBER(1,0) DEFAULT 0,
                ma_cap                         VARCHAR2(1),
                ma_loai                        VARCHAR2(3),
                ma_tinh                        VARCHAR2(3),
                ma_huyen                       VARCHAR2(5),
                ten_dtnt                       VARCHAR2(100),
                dia_chi                        VARCHAR2(100),
                ma_cbo                         VARCHAR2(15),
                ten_cbo                        VARCHAR2(150),
                ma_pban                        VARCHAR2(15),
                ten_pban                       VARCHAR2(250)
                )');

        prc_remote_sql('ALTER TABLE ext_qlt_no
                        ADD CONSTRAINT ext_qlt_no_pk PRIMARY KEY (kyno_tu_ngay, id)
                        USING INDEX');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_DDon_tb_ext_qlt_no
    Noi dung: Don dep bang ext_qlt_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_qlt_no IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_QLT_NO';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_pck_qlt
    Noi dung: Khoi tao EXT_PCK_CONTROL cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_Pck_Qlt IS
    BEGIN
        --Prc_Ddep_Pck_Qlt;
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_2 IS      
    PROCEDURE Prc_Qlt_No(p_ky_no Date);
END;');

prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_2
IS
    PROCEDURE Prc_Qlt_No(p_ky_no DATE) IS
        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;
        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma 
        PROCEDURE Prc_THop_No_Thue_Tncn(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , DTNT.MA_CQT               MA_CQT
                        , DTNT.MA_PHONG             MA_PHONG
                        , DTNT.MA_CANBO             MA_CANBO
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                        , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                        , KYLB_TU_NGAY              KYLB_TU_NGAY
                        , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                        , KYKK_TU_NGAY              KYKK_TU_NGAY
                        , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                        , MA_MUC                    MA_MUC
                        , MA_TMUC                   MA_TMUC
                        , MA_THUE                   MA_THUE
                        , TKHOAN                    TKHOAN
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
                                AND (Tmt_Ma_Muc = ''1000'' OR Tmt_Ma_Tmuc = ''4268'')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.kykk_tu_ngay,st.kykk_den_ngay,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.dgd_ma_gdich,st.dgd_kieu_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop                                            
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;
    
            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT  Ten
                FROM    QLT_DM_GDICH DM
                WHERE   DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),''NULL'')    =   ''XLTK_GDICH''
                UNION ALL
                SELECT  trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM    Dual
                WHERE   NVL(trim(pc_Ten_GDich),''NULL'')    <>  ''XLTK_GDICH'';
         
            CURSOR c_Map_Gd IS
                SELECT Loai_Qdinh,Gdich_Dnop,Gdich_Pnop
                FROM Qlt_Map_Gdich_Ttoan
                ORDER BY Gdich_Dnop;
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
                    INSERT INTO EXT_QLT_NO (ID
                                               ,TIN
                                                   ,hdr_id
                                                   ,dtl_id
                                                   ,DGD_MA_GDICH
                                                   ,DGD_KIEU_GDICH
                                                   ,MA_CQT
                                                   ,MA_PHONG
                                                   ,MA_CANBO
                                                   ,KYNO_TU_NGAY
                                                   ,KYNO_DEN_NGAY
                                                   ,KYLB_TU_NGAY
                                                   ,KYLB_DEN_NGAY
                                                   ,KYKK_TU_NGAY
                                                   ,KYKK_DEN_NGAY
                                                   ,TMT_MA_MUC
                                                   ,TMT_MA_TMUC
                                                   ,TMT_MA_THUE
                                                   ,TKHOAN
                                                   ,NO_DAU_KY
                                                   ,NO_CUOI_KY
                                                   ,HAN_NOP
                                                   ,NGUON_GOC
                                                   ,KYTT_TU_NGAY
                                                   ,KYTT_DEN_NGAY
                                                   ,CHECK_KNO
                                                   ,Qdinh_Id
                                                   ,Loai_Qdinh
                                                )
                                        VALUES  (QLT_SNO_SEQ.NEXTVAL
                                                ,vt_PN(i).TIN
                                                ,vt_PN(i).hdr_id
                                                ,vt_PN(i).dtl_id
                                                ,vt_PN(i).ma_gdich
                                                ,vt_PN(i).kieu_gdich
                                                ,vt_PN(i).MA_CQT
                                                ,vt_PN(i).MA_PHONG
                                                ,vt_PN(i).MA_CANBO
                                                ,trunc(p_den_ky,''Month'')
                                                ,last_day(p_den_ky)
                                                ,vt_PN(i).KYLB_TU_NGAY
                                                ,vt_PN(i).KYLB_DEN_NGAY
                                                ,vt_PN(i).KYKK_TU_NGAY
                                                ,vt_PN(i).KYKK_DEN_NGAY
                                                ,vt_PN(i).MA_MUC
                                                ,vt_PN(i).MA_TMUC
                                                ,vt_PN(i).MA_THUE
                                                ,vt_PN(i).TKHOAN
                                                ,Decode(vt_PN(i).PHAI_NOP,Abs(vt_PN(i).PHAI_NOP),vt_PN(i).NO_DAU_KY,0)
                                                ,vt_PN(i).PHAI_NOP
                                                ,vt_PN(i).HAN_NOP
                                                , v_Nguon_Goc
                                                ,vt_PN(i).Ky_Ttoan_Tu_ngay
                                                ,vt_PN(i).Ky_Ttoan_Den_ngay
                                                ,''1''
                                                ,vt_Pn(i).Qdinh_Id
                                                ,vt_Pn(i).Loai_Qdinh);            
                END LOOP;
            END;--End Prc_Thanh_Toan
        BEGIN
            FOR vc_Map_Gd IN c_Map_Gd LOOP
                v_Idx_Gd := v_Idx_Gd + 1;
                arr_Gdich(v_Idx_Gd) := vc_Map_Gd;
            END LOOP;
            -- Xoa du lieu neu da chot no thang nay
            DELETE FROM EXT_QLT_NO SNO
            WHERE   Kyno_Tu_Ngay = Trunc(p_den_ky, ''MONTH'')
                    AND (SNO.TIN = v_Tin OR v_Tin IS NULL);     
    
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
        Prc_THop_No_Thue_Tncn(trunc(p_ky_no,''MONTH''));
    END;
END;
');

        prc_remote_sql('
CREATE OR REPLACE
PACKAGE ext_pck_control IS
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE);
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE);
    PROCEDURE Prc_Job_Qlt_Slech_No;    
    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);

    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2);    
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
END;');
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control
IS
    
    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE) IS

    v_Alert_button NUMBER;
    c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_PS'';

    CURSOR cLoop IS
    /* TO KHAI PHAT SINH */
    SELECT tkha.tin tin, tkha.dtk_ma_loai_tkhai dtk_ma, nnt.ma_chuong ma_chuong,
               nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc tmt_ma_tmuc,
               tkha.kykk_tu_ngay kykk_tu_ngay, tkha.kykk_den_ngay kykk_den_ngay,
               psin.thue_psinh so_tien, ''2'' trang_thai, tkha.ngay_nop ngay_nop,
               tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc=''1000'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >= p_tu)        
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai IN (''29'',''30'',''21'',''60'',''19''))
        AND (psin.thue_psinh<>0)
        UNION ALL
        /* Nghiep vu cho 01/KK-XS */
        SELECT tkha.tin, ''99'' dtk_ma, nnt.ma_chuong, nnt.ma_khoan, psin.tmt_ma_tmuc,
               tkha.kykk_tu_ngay, tkha.kykk_den_ngay, psin.thue_psinh so_tien,
               ''2'' trang_thai, tkha.ngay_nop ngay_nop, tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc=''1000'')
        AND (psin.tmt_ma_tmuc=''1003'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay>=p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai=''12'')
        AND (nnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
        AND (nnt.ma_loai=''550'')
        AND (nnt.ma_khoan=''558'')
        AND (psin.thue_psinh<>0)
        UNION ALL
        /* Nghiep vu cho 01/KK-BH */
        SELECT tkha.tin, ''98'' dtk_ma, nnt.ma_chuong, nnt.ma_khoan, psin.tmt_ma_tmuc,
               tkha.kykk_tu_ngay, tkha.kykk_den_ngay, psin.thue_psinh so_tien,
               ''2'' trang_thai, tkha.ngay_nop ngay_nop, tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc = ''1000'')
        AND (psin.tmt_ma_tmuc = ''1003'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >=p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai=''12'')
        AND (nnt.ma_chuong IN (''038'', ''173''))
        AND (psin.thue_psinh<>0)
        UNION ALL
    /* AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
               hdr.kykk_tu_ngay, hdr.kykk_den_ngay, dtl.so_thue,
               ''AN_DINH'' trang_thai, to_date(NULL) ngay_nop, to_date(NULL) han_nop, hdr.KYLB_TU_NGAY
        FROM qlt_ds_an_dinh_hdr hdr,
             qlt_ds_an_dinh_dtl dtl,
             qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.adh_id
        AND (nnt.tin=hdr.tin)
        AND (hdr.ly_do IN (''02'',''03''))
        AND (dtl.tmt_ma_muc=''1000'')
        AND (hdr.kykk_tu_ngay >= p_tu)
        AND (hdr.kylb_tu_ngay <= p_den)
        AND (hdr.dtk_ma IN (''29'',''30'',''21'',''60'',''19''))
        UNION ALL
    /* BAI BO AN DINH TO KHAI */
            SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
                   hdr.kykk_tu_ngay, hdr.kykk_den_ngay, (-1)*dtl.so_thue,
                   ''BAI_BO_AN_DINH'' trang_thai, to_date(NULL) ngay_nop, to_date(NULL) han_nop, hdr.KYLB_TU_NGAY
            FROM qlt_qd_bbo_ad_hdr hdr,
                 qlt_qd_bbo_ad_dtl dtl,
                 qlt_nsd_dtnt nnt
            WHERE hdr.id=dtl.qba_id
            AND (nnt.tin=hdr.tin)
            AND (dtl.tmt_ma_muc=''1000'')
            AND (hdr.kykk_tu_ngay >= p_tu)
        AND (hdr.kylb_tu_ngay <= p_den)
        AND (hdr.dtk_ma IN (''29'',''30'',''21'',''60'',''19''));
    /* XU LY KHIEU NAI */
        CURSOR cADI IS
        SELECT hdr.id, hdr.so_qd_goc, adi.dtk_ma, adi.kykk_tu_ngay, adi.kykk_den_ngay,
               adi.tin, nnt.ma_chuong, nnt.ma_khoan, ''KHIEU_NAI_AN_DINH'' trang_thai, adi.KYLB_TU_NGAY
        FROM qlt_ds_an_dinh_hdr adi,
               qlt_ds_an_dinh_dtl dtl,
             qlt_qd_xlkn_hdr hdr,
             qlt_nsd_dtnt nnt
        WHERE adi.so_qd=hdr.so_qd_goc
        AND (adi.id=dtl.adh_id)
        AND (adi.tin=nnt.tin)
        AND (adi.ly_do IN (''03''))
        AND (dtl.tmt_ma_muc=''1000'')
        AND (adi.kykk_tu_ngay >= p_tu)
        AND (adi.kylb_tu_ngay <= p_den)
        AND (adi.dtk_ma IN (''29'',''30'',''21'',''60'',''19''));

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

        DELETE FROM ext_qlt_ps dtl WHERE dtl.loai_dlieu<>''1'';

        /* day du lieu phat sinh to khai, an dinh, bai bo */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                          ghi_chu, ngay_nop, ma_tkhai, ky_psinh_tu,
                                          ky_psinh_den, loai_dlieu, han_nop, ngay_htoan)
                VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ma_chuong, vLoop.ma_khoan,
                       vLoop.tmt_ma_tmuc, vLoop.so_tien, NULL, vLoop.ngay_nop,
                       vLoop.dtk_ma, vLoop.kykk_tu_ngay, vLoop.kykk_den_ngay, ''2'',
                       vLoop.han_nop, vLoop.KYLB_TU_NGAY);
        END LOOP;

        /* day du lieu khieu nai */
        FOR vADI IN cADI LOOP
            FOR vKHN IN cKHN(vADI.so_qd_goc) LOOP
                INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc,
                                              so_tien, ghi_chu, ma_tkhai, ky_psinh_tu,
                                              ky_psinh_den, loai_dlieu, ngay_htoan)
                    VALUES(ext_seq.NEXTVAL, vADI.tin, vADI.ma_chuong, vADI.ma_khoan,
                           vKHN.tmt_ma_tmuc, vKHN.so_tien, NULL,
                           vADI.dtk_ma, vADI.kykk_tu_ngay, vADI.kykk_den_ngay,
                           ''2'', vADI.KYLB_TU_NGAY);
            END LOOP;
        END LOOP;
        UPDATE ext_qlt_ps a
           SET a.ma_khoan=''000'',
               a.ma_chuong=(SELECT DECODE(substr(GIA_TRI,-2),''00'',''557'',''757'') chuong
                              FROM qlt_tham_so
                             WHERE ten=''MA_CQT'');
        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_ps'');     
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;

        Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN Prc_Finnal(c_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qlt_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_NO'';
        
        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qlt_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));        
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        
        DELETE FROM ext_qlt_no WHERE status<>''1'';
        
        EXT_PCK_CONTROL_2.prc_qlt_no(p_chot);
        
        /* cap nhat lai chuong khoan */
        UPDATE ext_qlt_no a
           SET a.ma_khoan=''000'',
               a.ma_chuong=(SELECT DECODE(substr(GIA_TRI,-2),
                                          ''00'',
                                          DECODE(a.tmt_ma_tmuc,
                                                 ''1001'',''557'',
                                                 ''1003'',''557'',
                                                 ''1004'',''557'',
                                                 ''1005'',''557'',
                                                 ''757''),
                                          ''757'') chuong
                              FROM qlt_tham_so
                             WHERE ten=''MA_CQT'');

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qlt_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, ''MONTH''),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, ''MONTH''))
            WHERE id=vUp_Ky.id;
        END LOOP;
        
        UPDATE ext_qlt_no SET KYKK_TU_NGAY=to_date(''1-jan-2005'',''DD/MM/RRRR''),
                              KYKK_DEN_NGAY=to_date(''31-jan-2005'',''DD/MM/RRRR'')
                        WHERE KYKK_TU_NGAY<to_date(''1-jan-2005'',''DD/MM/RRRR''); 
                                
        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_no'');
        COMMIT;
        
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN Prc_Finnal(c_pro_name);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_tu DATE, p_den DATE) IS      
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_PS'');
        COMMIT;    
        Prc_Create_Job(''BEGIN
                            EXT_PCK_CONTROL.Prc_Qlt_Thop_Ps(''''''||p_tu||'''''', ''''''||p_den||'''''');
                        END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_NO'');
        COMMIT;    
        Prc_Create_Job(''BEGIN
                            EXT_PCK_CONTROL.Prc_Qlt_Thop_No(''''''||p_chot||'''''');
                        END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Slech_No
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Slech_No IS  
    BEGIN
        Prc_Del_Log(''PRC_QLT_SLECH_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL_4.Prc_Qlt_Slech_No; END;'');
    END;
    
    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Remove_Job
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
    EXT_PCK_CONTROL.Prc_Create_Job
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
    EXT_PCK_CONTROL.Prc_Ins_Log
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
    EXT_PCK_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Del_Log
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
    ext_pck_control.Prc_Update_Pbcb
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
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin)'';    
    END;    
END;');

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_4 IS
    PROCEDURE Prc_Qlt_Slech_No;
    PROCEDURE Prc_Dchinh_No_Qlt;
    v_gl_cqt VARCHAR2(5);
END;
');
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_4
IS
    /**************************************************************************/
    PROCEDURE Prc_Qlt_Slech_No IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_SLECH_NO'';
        v_max_upd NUMBER(3);
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        SELECT NVL(max(update_no),0) INTO v_max_upd FROM ext_slech_no;
        SELECT gia_tri INTO v_gl_cqt FROM qlt_tham_so WHERE ten=''MA_CQT'';         
        UPDATE ext_slech_no SET update_no = v_max_upd+1 
         WHERE loai=''QLT'' AND update_no=0;                

        INSERT INTO ext_slech_no (loai, ky_thue, tin, 
                                  ten_dtnt, tai_khoan, muc, tieumuc, mathue,
                                  sothue_no_cky, sono_no_cky, clech_no_cky, 
                                  update_no, ma_slech, ma_gdich, ten_gdich, ma_cqt)
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               ''TK_TAM_GIU'' tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               par.no_cky SOTHUE_NO_CKY, 
               to_number(NULL) SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 5 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt
          FROM qlt_so_tdtn_tkhoan_tgiu par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin(+)
           AND par.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
           AND par.no_cky<>0
        UNION ALL
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 2 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)         
           AND par.tkhoan=''TK_TAM_GIU'' 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 3 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt               
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)         
           AND par.han_nop IS NULL 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QLT'' loai, 
               par.ky_thue,         
               par.tin, 
               max(nnt.TEN_DTNT) TEN_DTNT, 
               par.tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue MATHUE,  
               ROUND(sum(par.ST_NO_CKY),0) SOTHUE_NO_CKY, 
               sum(par.SN_NO_CKY) SONO_NO_CKY,  
               (ROUND(sum (par.ST_NO_CKY),0)-sum(par.SN_NO_CKY)) CLECH_NO_CKY,
               0 update_no, 1 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt               
        FROM
        (
        SELECT ''TK_NGAN_SACH'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_thue t
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''TK_TAM_GIU'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tgiu t 
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL 
        SELECT ''TK_TH_HOAN'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_thhoan t
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''TK_TAM_THU'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tthu t 
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL 
        SELECT tkhoan, 
               tin,  
               tmt_ma_muc, 
               tmt_ma_tmuc,
               tmt_ma_thue, 
               kyno_tu_ngay AS kythue, 
               0 AS ST_no_cky, 
               no_cky AS SN_no_cky 
          FROM (SELECT a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc,
                       a.tmt_ma_thue, kyno_tu_ngay, SUM (no_cuoi_ky) AS no_cky
                  FROM qlt_so_no a
                 WHERE kyno_tu_ngay =(SELECT max(kyno_tu_ngay) FROM  qlt_so_no)
                   AND (a.tmt_ma_muc=''1000'' or a.tmt_ma_tmuc = ''4268'')
                 GROUP BY a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc, 
                          a.tmt_ma_thue, a.kyno_tu_ngay)
        ) par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin
         GROUP BY par.tai_khoan, par.tin, par.tmt_ma_muc, par.tmt_ma_tmuc, 
                  par.tmt_ma_thue, par.ky_thue
        HAVING ROUND(sum(par.ST_NO_CKY),0)<>sum(par.SN_NO_CKY);

        ext_pck_control.Prc_Update_Pbcb(''ext_slech_no'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);            
    END;
    /**************************************************************************/    
    PROCEDURE Prc_Dchinh_No_Qlt IS
        CURSOR c_dc IS
        SELECT * FROM ext_slech_no 
         WHERE loai = ''QLT'' AND update_no=0 AND ma_slech=1 AND da_dchinh IS NULL ;
        v_nguon_goc VARCHAR2(100) := ''?i?u ch?nh N? theo Thu n?p ?? tri?n khai ?ng d?ng QLT_TNCN'';
        v_ghi_chu VARCHAR2(100) := ''?i?u ch?nh d? li?u khi tri?n khai ?ng d?ng QLT_TNCN'';
    BEGIN
        FOR vc_dc IN c_dc LOOP
            INSERT INTO qlt_so_no
                        (ID,KYNO_TU_NGAY,KYNO_DEN_NGAY,HDR_ID,DTL_ID,DGD_MA_GDICH,
                         DGD_KIEU_GDICH,TKHOAN,KYLB_TU_NGAY,KYLB_DEN_NGAY,KYKK_TU_NGAY,
                         KYKK_DEN_NGAY,TIN,MA_CQT,MA_PHONG,MA_CANBO,TMT_MA_MUC,
                         TMT_MA_TMUC,TMT_MA_THUE,NO_DAU_KY,NO_CUOI_KY,HAN_NOP,
                         NGUON_GOC,GHI_CHU,CHECK_KNO)
            VALUES(qlt_sno_seq.NEXTVAL,
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    0,
                    0,
                    ''**'',
                    ''**'',
                    vc_dc.tai_khoan,
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    vc_dc.tin,
                    vc_dc.ma_cqt,
                    vc_dc.ma_pban,
                    vc_dc.ma_cbo,
                    vc_dc.muc,
                    vc_dc.tieumuc,
                    vc_dc.mathue,
                    vc_dc.clech_no_cky,
                    vc_dc.clech_no_cky,
                    last_day(add_months(vc_dc.ky_thue,1)),
                    v_nguon_goc,
                    v_ghi_chu,
                    0);
            UPDATE ext_slech_no SET da_dchinh = ''Y''
            WHERE loai = vc_dc.loai 
                AND tin = vc_dc.tin 
                AND muc = vc_dc.muc 
                AND tieumuc = vc_dc.tieumuc
                AND mathue = vc_dc.mathue
                AND update_no=0;
            COMMIT;                                                
        END LOOP;     
    END;               
END;');

    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_5 IS
    PROCEDURE Prc_Ttoan_Qlt(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Run_Qlt(p_chot DATE);
END;');

    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_5
IS
    PROCEDURE Prc_Ttoan_Qlt(p_Ky_Dchinh DATE) IS
        CURSOR  c_Sno IS
        SELECT dtnt.tin, dtnt.ten_dtnt, dtnt.dia_chi, dtnt.ma_tinh, dtnt.ma_huyen,
               dtnt.ma_cqt, dtnt.ma_phong, dtnt.ma_canbo, dtnt.ma_cap, dtnt.ma_chuong,
               dtnt.ma_loai, dtnt.ma_khoan,
               NVL (kykk_tu_ngay, kylb_tu_ngay) kykk_tu_ngay,
               NVL (kykk_den_ngay, kylb_den_ngay) kykk_den_ngay, han_nop,
               DECODE (tkhoan, ''TK_NGAN_SACH'', ''1'', ''TK_TAM_GIU'', ''3'', ''4'') tkhoan,
               tmt_ma_muc, tmt_ma_tmuc, tmt_ma_thue, no_cuoi_ky
          FROM qlt_so_no sn, qlt_nsd_dtnt dtnt
         WHERE sn.tin = dtnt.tin
           AND kyno_tu_ngay = p_ky_dchinh
           AND (tmt_ma_muc = ''1000'' OR tmt_ma_tmuc = ''4268'')
           AND no_cuoi_ky <> 0;
        
        CURSOR c_ky_tkhai IS  
        SELECT Add_Months(Trunc(p_Ky_Dchinh,''MONTH''),1) FROM dual;
                    
        v_Id                NUMBER;    
        v_Ky_Dchinh         DATE ; 
        -- Thong tin header cua phieu dieu chinh :
        v_So_Qdinh          VARCHAR2(20)  := NULL;
        v_Ly_Do             VARCHAR2(200) := ''T?t to?n thu? TNCN'';    
        v_Ndung_Dchinh      VARCHAR2(200) := ''?i?u ch?nh thu? TNCN'';  
        v_Anh_Huong         VARCHAR2(200) := NULL; 
        v_Nguoi_Cap_Nhat    VARCHAR2(60) := ''Pit_Converter'';
        v_Nguoi_Lap         VARCHAR2(60)  := ''Pit_Converter''; 
        v_Nguoi_Duyet       VARCHAR2(60)  := ''Pit_Converter''; 
        v_Cq_Ra_Qdinh       VARCHAR2(60)  := NULL;   
        v_Ngay_Dnghi        DATE := Trunc(Sysdate,''Month'');    
    BEGIN
        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_Ky_Dchinh;
        CLOSE c_ky_tkhai;
        
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        FOR vc_Sno  IN  c_Sno LOOP
            -- Gan tham so
            IF vc_Sno.Tkhoan = ''1'' THEN
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''1'',''DC'');
            ELSIF vc_Sno.Tkhoan = ''3'' THEN
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''5'',''DC'');
            ELSE
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''6'',''DC'');
            END IF;
            Qlt_Pck_Control.Prc_Gan_Tin(vc_Sno.Tin);
            -- Insert header
            SELECT Qlt_Xltk_Hdr_Seq.NEXTVAL INTO v_Id FROM Dual;
            INSERT INTO qlt_ds_ttin_khac_hdr
                        (ID, loai_ttin, tin, ten_dtnt, cqt_ma_cqt,
                         hun_ma_tinh, hun_ma_huyen, dia_chi,
                         ma_canbo, ma_phong, so_qd, ngay_qd,
                         cq_ra_qd, kylb_den_ngay, kylb_tu_ngay,
                         kykk_tu_ngay, kykk_den_ngay, ly_do, ngay_cap_nhat,
                         nguoi_cap_nhat, tkhoan, ndung_dchinh, anh_huong,
                         ngay_dnghi, nguoi_lap, nguoi_duyet, ma_ldo)
                 VALUES (v_id, ''4'', vc_sno.tin, vc_sno.ten_dtnt, vc_sno.ma_cqt,
                         vc_sno.ma_tinh, vc_sno.ma_huyen, vc_sno.dia_chi,
                         vc_sno.ma_canbo, vc_sno.ma_phong, v_so_qdinh, vc_sno.han_nop,
                         v_cq_ra_qdinh, LAST_DAY (v_ky_dchinh), v_ky_dchinh,
                         vc_sno.kykk_tu_ngay, vc_sno.kykk_den_ngay, v_ly_do, SYSDATE,
                         v_nguoi_cap_nhat, vc_sno.tkhoan, v_ndung_dchinh, v_anh_huong,
                         v_ngay_dnghi, v_nguoi_lap, v_nguoi_duyet, ''99'');
                        -- Insert Detail
            INSERT INTO qlt_ds_ttin_khac_dtl
                        (ID, tkr_id, ccg_ma_cap, ccg_ma_chuong,
                         lkn_ma_loai, lkn_ma_khoan, tmt_ma_muc,
                         tmt_ma_tmuc, tmt_ma_thue,
                         so_tien, ngay_nhap)
                 VALUES (qlt_xltk_dtl_seq.NEXTVAL, v_id, vc_sno.ma_cap, vc_sno.ma_chuong,
                         vc_sno.ma_loai, vc_sno.ma_khoan, vc_sno.tmt_ma_muc,
                         vc_sno.tmt_ma_tmuc, vc_sno.tmt_ma_thue,
                         (-1) * vc_sno.no_cuoi_ky, SYSDATE);
            Qlt_Pck_Control.Prc_Reset_Log_Id;                                        
        END LOOP;
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;        
    END;
    /**************************************************************************/
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE) IS
        CURSOR c_ky_tkhai IS
        SELECT Last_Day(Add_Months(p_Ky_Dchinh,-1)) FROM dual;
        v_ky_tkhai DATE;    
    BEGIN
        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_ky_tkhai;
        CLOSE c_ky_tkhai;    
        
        UPDATE qlt_dm_tkhai_hluc
           SET hluc_den_ngay = LAST_DAY (p_ky_dchinh)
         WHERE dtk_ma IN
                  (''19'', ''20'', ''21'', ''29'', ''30'', ''54'', ''55'', ''56'', ''57'', ''58'', ''60'',''65'')
           AND hluc_den_ngay IS NULL;
        
        UPDATE qlt_dm_qtoan_hluc
           SET hluc_den_ngay = LAST_DAY (p_ky_dchinh)
         WHERE dqt_ma IN (''06'', ''07'', ''12'', ''13'', ''14'', ''15'', ''16'')
           AND hluc_den_ngay IS NULL;
        
        UPDATE qlt_mucthu
           SET ngay_hl_den = LAST_DAY (p_ky_dchinh)
         WHERE (ma_muc = ''1000'' OR ma_tmuc = ''4268'')
           AND (ngay_hl_den IS NULL OR ngay_hl_den >= LAST_DAY (p_ky_dchinh));
        
        UPDATE qlt_thue_mthu
           SET ngay_hl_den = v_ky_tkhai
         WHERE (ma_muc = ''1000'' OR ma_tmuc = ''4268'')
           AND (ngay_hl_den IS NULL OR ngay_hl_den >= LAST_DAY (p_ky_dchinh));
                        
    END;
    /**************************************************************************/
    PROCEDURE Prc_Run_Qlt(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_RUN_QLT'';        
    BEGIN
        Prc_Ttoan_Qlt(p_chot);
        Prc_Dmuc_Hluc(p_chot);
        EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);
        COMMIT;        
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);    
    END;        
END;');
    prc_remote_sql('CREATE OR REPLACE 
PACKAGE ext_pck_control_7 IS
    PROCEDURE Prc_DoiChieu(p_chot DATE);
END;');
    
    prc_remote_sql('CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_7
IS
    /**************************************************************************/
    PROCEDURE Prc_DoiChieu(p_chot DATE) IS
        v_nsd number(5);
    BEGIN
    -- cac tham so thay doi
    -- *************************************************************************
    select ma_nsd into v_nsd from bmt_nsd where TEN_NSD=''DCPIT'';
    -- *************************************************************************
        
    qlt_pck_control.prc_load_tin(v_nsd,true,true);
    qlt_pck_control.prc_load_tin(v_nsd,false,true);
    
    --NO_QLT -----------------------------------------------------------------------
    qlt_pck_in_so_v158.prc_danhsach_no_thop(last_day(p_chot)
                                                    , To_Date(''31/12/9999'',''DD/MM/RRRR'')
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , ''1000''
                                                    , null
                                                    , null
                                                    , null
                                                    , null     
                                                    , null
                                                    , null
                                                    , null
                                                    , null);
    qlt_pck_in_so_v158.prc_danhsach_no_thop(last_day(p_chot)
                                                    , To_Date(''31/12/9999'',''DD/MM/RRRR'')
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , ''4268''
                                                    , null
                                                    , null
                                                    , null     
                                                    , null
                                                    , null
                                                    , null
                                                    , null);    
    DELETE FROM EXT_TEMP_DCHIEU;
    
    INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, v_char3, loai)
    SELECT mau, ma_tmuc, so_no, so_thua, ''NO'' loai
        FROM
        (
        SELECT ALL ''QLT-APP'' mau
            , MA_TMUC
            , trim(to_char(Sum(Decode(Abs(SO_NO) , SO_NO ,ROUND(SO_NO),-SO_NO ,0)),''999,999,999,999,999'')) SO_NO  
            , ''-''||trim(to_char(Sum(Decode(Abs(SO_NO) ,-SO_NO ,ROUND(-SO_NO), SO_NO ,0)),''999,999,999,999,999'')) SO_THUA
        FROM QLT_DANHSACH_NO
        WHERE  Round(Abs(SO_NO))>=1 and tkhoan=(select gia_tri from qlt_tham_so where ten=''TK_NGAN_SACH'')
        GROUP BY MA_MUC, MA_TMUC
        );
    INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, loai)
    select mau, loai_tkhai, so_tien, ''PS'' loai
        from
        (
        select ''QLT-APP'' Mau, loai_tkhai, trim(to_char(sum(thue),''999,999,999,999,999'')) so_tien
        from (
        select  tkh.id
                , decode(tkh.dtk_ma_loai_tkhai, ''29'', ''02T/KK-TNCN''
                                              , ''30'', ''02Q/KK-TNCN''
                                              , ''21'', ''03T/KK-TNCN''
                                              , ''60'', ''03Q/KK-TNCN''
                                              , ''19'', ''07/KK-TNCN'') loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt 
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai in(''29'',''30'', ''21'', ''60'',''19''))
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''               
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                       where a.id=tkh.id 
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)        
        union all                                                
        select  tkh.id
                , ''01/KK-XS'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt 
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
                AND (dtnt.ma_loai=''550'')
                AND (dtnt.ma_khoan=''558'')                       
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                       where a.id=tkh.id 
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)                                                 
        union all                                                
        select  tkh.id
                , ''01/KK-BH'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt 
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''038'', ''173''))                      
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                       where a.id=tkh.id 
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)                                                                                                  
        union all                                                
        select  tkh.id
                , ''08/KK-TNCN'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt 
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''557'', ''757'', ''857''))                       
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                       where a.id=tkh.id 
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)                                                 
        ) group by loai_tkhai
        );
    COMMIT;
    END;    
END;');
    /* END PRC_KTAO_PCK_QLT*/
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Pck_Qlt
    Noi dung: Don dep EXT_PCK_CONTROL cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_Pck_Qlt IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_PCK_CONTROL';
        CURSOR c IS
        SELECT object_name FROM user_objects@qlt
                          WHERE object_type = 'PACKAGE'
                            AND object_name IN ('EXT_PCK_CONTROL',
                                                'EXT_PCK_CONTROL_1',
                                                'EXT_PCK_CONTROL_2',
                                                'EXT_PCK_CONTROL_4');
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP PACKAGE '||v.object_name);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Pck_Qct
    Noi dung: Khoi tao EXT_PCK_CONTROL cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_Pck_Qct IS
    BEGIN
        --Prc_Ddep_Pck_Qct;
        /*Khoi tao Spec cho PACKAGE*/
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_3 IS      
    PROCEDURE Prc_Qct_No(p_ky_no Date);
END;
');
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_3
IS    
    PROCEDURE Prc_Qct_No(p_ky_no DATE) IS
        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2),Priority NUMBER);
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;
        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Priority  NUMBER := 0;
        v_Ky_MoSo   DATE;
        PROCEDURE Prc_THop_No_Thue_Tncn(p_den_ky    DATE)IS
            CURSOR   c_Phai_Nop IS
            SELECT   PNop.TIN                       TIN
                    ,PNop.HDR_ID                    HDR_ID
                    ,PNop.DTL_ID                    DTL_ID
                    ,PNop.MA_GDICH                  MA_GDICH
                    ,Max(PNop.BTM_MA)               BTM_MA
                    ,Sum(PNop.SO_THE)               So_The
                    ,PNop.KY_THUE_TU_NGAY           KY_THUE_TU_NGAY
                    ,PNop.KY_THUE_DEN_NGAY          KY_THUE_DEN_NGAY
                    ,Max(PNop.KY_TTOAN_TU_NGAY)     KY_TTOAN_TU_NGAY
                    ,Max(PNop.KY_TTOAN_DEN_NGAY)    KY_TTOAN_DEN_NGAY
                    ,Max(PNop.KYLB_TU_NGAY)         KYLB_TU_NGAY
                    ,Max(PNop.KYLB_DEN_NGAY)        KYLB_DEN_NGAY
                    ,PNop.MA_MUC                    MA_MUC
                    ,PNop.MA_TMUC                   MA_TMUC
                    ,Max(PNop.MA_THUE)              MA_THUE
                    ,Sum(Pnop.PHAI_NOP)             PHAI_NOP
                    ,PNop.HAN_NOP                   HAN_NOP
                    ,Max(PNop.KY_TP_TU_NGAY)        KY_TP_TU_NGAY
                    ,PNop.TKHOAN                    TKHOAN
                    ,Max(CHK_KNO)                   CHK_KNO
                    ,Max(Qdinh_Id)                  Qdinh_Id
                    ,Max(Loai_Qdinh)                Loai_Qdinh
            FROM(SELECT    SNO.Tin                                     TIN
                            , SNO.hdr_id                                 HDR_ID
                            , SNO.Dtl_id                                 DTL_ID
                            , SNO.MA_GDICH                               MA_GDICH
                            , SNO.BTM_MA                                      BTM_MA
                            , SNO.SO_THE                                 SO_THE
                            , SNO.KY_THUE_TU_NGAY                        KY_THUE_TU_NGAY
                            , SNO.KY_THUE_DEN_NGAY                       KY_THUE_DEN_NGAY
                            , SNO.KY_TTOAN_TU_NGAY                       KY_TTOAN_TU_NGAY
                            , SNO.KY_TTOAN_DEN_NGAY                      KY_TTOAN_DEN_NGAY
                            , SNO.KYLB_TU_NGAY                           KYLB_TU_NGAY
                            , SNO.KYLB_DEN_NGAY                          KYLB_DEN_NGAY
                            , SNO.TMT_MA_MUC                             MA_MUC
                            , SNO.TMT_MA_TMUC                            MA_TMUC
                            , SNO.TMT_MA_THUE                            MA_THUE
                            , SNO.NO_CUOI_KY                             PHAI_NOP
                            , SNO.Han_nop                                HAN_NOP
                            , Decode(CHECK_KNO,''1'', Trunc(p_den_ky,''Month'')-1,SNO.HAN_NOP)      KY_TP_TU_NGAY
                            , NVL(SNO.TKHOAN,''TK_NGAN_SACH'')             TKHOAN
                            , Nvl(CHECK_KNO,''0'') CHK_KNO
                            , Qdinh_Id                                                 Qdinh_Id
                            , Loai_Qdinh                                               Loai_Qdinh
                    FROM    QCT_SO_NO           SNO
                    WHERE  SNO.KYNO_TU_NGAY    =   Trunc(p_den_ky,''Month'')
                      AND  SNO.no_cuoi_ky<>0
                      AND  (Sno.tmt_ma_muc = ''1000'' OR Sno.tmt_ma_tmuc = ''4268'')
                    ) PNop, QLT_NSD_DTNT DTNT, QCT_DTNT DB
                WHERE PNop.TIN=DTNT.TIN AND DTNT.TIN=DB.TIN
                GROUP BY Pnop.Tin,
                         Pnop.Hdr_Id,
                         Pnop.Dtl_Id,
                         Pnop.Ma_Gdich,
                         Pnop.Ky_Thue_Tu_Ngay,
                         Pnop.Ky_Thue_Den_Ngay,
                         Pnop.Tkhoan,
                         Pnop.Ma_Muc,
                         Pnop.Ma_Tmuc,
                         Pnop.Han_Nop
                ORDER BY PNop.Tin
                        ,PNop.Tkhoan
                        ,PNop.ma_muc
                        ,PNop.ma_tmuc
                        ,decode(Sum(PNop.phai_nop)+abs(Sum(PNop.phai_nop)),0,-1,1)
                        ,PNop.HAN_NOP
                        ,NVL(BTM_MA,99);
            CURSOR c_Map_Gd IS
                SELECT Loai_Qdinh,Gdich_Dnop,Gdich_Pnop,Priority
                FROM Qct_Map_Gdich_Ttoan
                ORDER BY Priority;
            TYPE tab_phai_nop IS TABLE OF c_phai_nop%ROWTYPE INDEX BY BINARY_INTEGER;
            vt_PN tab_PHAI_NOP;
            i NUMBER;
            --j number;
            k NUMBER;
            l NUMBER;
            v_kno_num           NUMBER;
            v_kno_first_index   NUMBER;
            v_kno_index         NUMBER;
            v_last_tin VARCHAR2(14):=''HHHHHHHHHHHHHH'';
            v_last_muc      VARCHAR2(4):=''HHH'';
            v_last_tmuc     VARCHAR2(4):=''HH'';
            v_last_tkhoan   VARCHAR2(30):=''HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'';
            v_Temp  VARCHAR2(10);
            v_Ckn   VARCHAR2(1);
    
            PROCEDURE PRC_THANH_TOAN IS
                v_No_Dky NUMBER;
            BEGIN
                v_kno_num:=k;-- So luong phan tu mang vt_PN
                --Lay chi so cua khoan no dau tien(co so phai nop>0)
                v_kno_first_index:=v_kno_num+1;
                i:=1;
                WHILE (i<=v_kno_num) LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN
                        v_kno_first_index:=i;
                        EXIT;
                    END IF;
                    i:=i+1;
                END LOOP;--End lay chi so cua khoan no dau tien
    
                --Neu co khoan no, thuc hien thanh toan
                IF(v_kno_first_index<=v_kno_num)THEN
                    -- Duyet cac che do uu tien
                    FOR p IN 1..v_Priority LOOP
                        i:=1;
                        v_kno_index:=v_kno_first_index;
                        WHILE (i<v_kno_first_index)LOOP
                            l := v_kno_index;
                            WHILE (vt_PN(i).Phai_nop<0)AND(l<=v_kno_num) LOOP
                                IF  Qct_Pck_Chot_So.Fnc_Ttoan(vt_PN(i).Ma_Gdich,vt_Pn(l).Ma_Gdich,vt_Pn(i).Loai_Qdinh,p)
                                    AND vt_PN(l).phai_nop > 0
                                    AND (p <> 2 OR vt_PN(i).Qdinh_Id = vt_PN(l).Hdr_Id)
                                    AND (p <> 1 OR (vt_PN(i).ky_ttoan_tu_ngay = vt_PN(l).ky_ttoan_tu_ngay
                                        AND vt_PN(i).ky_ttoan_den_ngay = vt_PN(l).ky_ttoan_den_ngay))  THEN
                                        IF vt_PN(i).Han_Nop>vt_PN(l).Han_Nop THEN
                                                 vt_PN(l).KY_TP_TU_NGAY:= vt_PN(i).Han_nop;
                                                 vt_PN(l).CHK_KNO:=''1'';
                                        END IF;
                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
                                    ELSE
                                       vt_PN(i).phai_nop:=vt_PN(i).phai_nop+vt_PN(l).phai_nop;
                                       vt_PN(l).phai_nop:=0;
                                       l:=l+1;
                                    END IF;
                                ELSE
                                    l:=l+1;
                                END IF;
                            END LOOP;
                            i := i + 1;
                        END LOOP;
                    END LOOP;
                    -- End uu tien
                    i:=1;
                    v_kno_index:=v_kno_first_index;
                    WHILE (i<v_kno_first_index)LOOP
                        --Thanh toan theo ky
                        IF(vt_PN(i).Ky_ttoan_tu_ngay IS NOT NULL) THEN                       
                            -- chi thanh toan voi khoan phai nop co ky
                            l:=v_kno_index;
                            WHILE (vt_PN(i).Phai_nop<0)AND(l<=v_kno_num) LOOP
                                IF (vt_PN(l).phai_nop>0)
                                    AND (vt_PN(l).ky_ttoan_tu_ngay IS NOT NULL)
                                    AND ( vt_PN(i).ky_ttoan_tu_ngay   >=  vt_PN(l).ky_ttoan_tu_ngay
                                          AND vt_PN(i).ky_ttoan_den_ngay  <=  vt_PN(l).ky_ttoan_den_ngay)
                                THEN
                                    --Neu khoan phai nop duoc thanh toan qua han==>tinh phat ncham
                                    IF vt_PN(i).Han_Nop>vt_PN(l).Han_Nop THEN                                   
                                        vt_PN(l).KY_TP_TU_NGAY:= vt_PN(i).Han_nop;
                                        vt_PN(l).CHK_KNO:=''1''  ;
                                    END IF;
                                    IF vt_PN(l).phai_nop>abs(vt_PN(i).phai_nop) THEN
                                       vt_PN(l).phai_nop:=vt_PN(l).phai_nop+vt_PN(i).phai_nop;
                                       vt_PN(i).phai_nop:=0;
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
                        --End thanh toan theo ky                   
                        --Thuc hien ttoan doi voi khoan da nop vt_PN(i) theo thu tu han nop
                        WHILE (vt_PN(i).Phai_nop<0) LOOP
                            --Duyet cac khoan phai nop: (Bat dau tu khoan con phai nop dau tien)
                            --Neu khoan phai nop van chua ttoan het
                            IF  (vt_PN(v_kno_index).Phai_nop>0)THEN
                                IF(vt_PN(i).Han_Nop>vt_PN(v_kno_index).Han_nop)AND(vt_PN(i).Han_Nop>=p_Den_Ky)THEN                                
                                                 vt_PN(v_kno_index).KY_TP_TU_NGAY:= vt_PN(i).Han_nop;
                                                 vt_PN(v_kno_index).CHK_KNO:=''1'';
                                END IF;--End tinh phat ncham
                                --Thanh toan
                                IF abs(vt_PN(i).phai_nop)>=vt_pn(v_kno_index).phai_nop THEN
                                    vt_PN(i).phai_nop   :=vt_PN(i).phai_nop+vt_PN(v_kno_index).phai_nop;
                                    vt_PN(v_kno_index).phai_nop   :=0;
                                    --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                    v_kno_index         :=v_kno_index+1;
                                ELSE
                                    vt_PN(v_kno_index).phai_nop   :=vt_PN(v_kno_index).phai_nop+vt_PN(i).phai_nop;
                                    vt_PN(i).phai_nop   :=0;
                                END IF;--End Thanh toan
                            ELSE
                                --Neu khoan no da thanh toan het, tang chi so khoan con phai no len 1
                                v_kno_index:=v_kno_index+1;
                            END IF;--End duyet khoan phai nop
                            --Dung ttoan khi da het con phai nop
                            EXIT WHEN (v_kno_index>v_kno_num);
                        END LOOP;--End qua trinh ttoan doi voi khoan da nop vt_PN(i)
                        EXIT WHEN (v_kno_index>v_kno_num);
                        i:=i+1;
                    END LOOP;-- i<v_kno_first_index
                END IF;--End Co khoan no
    
                -- Thanh toan xong
                FOR i IN 1 .. v_kno_num LOOP
                    IF  (vt_PN(i).phai_nop>0)THEN                    
                        vt_PN(i).CHK_KNO:=''1'';
                        v_Ckn :=''1'';
                    ELSIF  (vt_PN(i).phai_nop = 0) THEN
                        v_Ckn :=''1'';
                    ELSE
                        v_Ckn :=''0'';
                    END IF;
                    INSERT INTO EXT_QCT_NO (ID
                                            ,TIN
                                            ,KYNO_TU_NGAY
                                            ,KYNO_DEN_NGAY
                                            ,HDR_ID
                                            ,DTL_ID
                                            ,MA_GDICH
                                            ,BTM_MA
                                            ,SO_THE
                                            ,KY_THUE_TU_NGAY
                                            ,KY_THUE_DEN_NGAY
                                            ,KYLB_TU_NGAY
                                            ,KYLB_DEN_NGAY
                                            ,KY_TTOAN_TU_NGAY
                                            ,KY_TTOAN_DEN_NGAY
                                            ,TMT_MA_MUC
                                            ,TMT_MA_TMUC
                                            ,TMT_MA_THUE
                                            ,NO_CUOI_KY
                                            ,HAN_NOP
                                            ,TKHOAN
                                            ,CHECK_KNO
                                            ,Qdinh_Id
                                            ,Loai_Qdinh
                                           )
                                        VALUES
                                          ( QCT_SNO_SEQ.NEXTVAL
                                            ,vt_PN(i).TIN
                                            ,Trunc(p_den_ky,''Month'')
                                            ,Last_Day(p_den_ky)
                                            ,vt_PN(i).HDR_ID
                                            ,vt_PN(i).DTL_ID
                                            ,vt_PN(i).MA_GDICH
                                            ,NULL
                                            ,vt_PN(i).SO_THE
                                            ,vt_PN(i).KY_THUE_TU_NGAY
                                            ,vt_PN(i).KY_THUE_DEN_NGAY
                                            ,vt_PN(i).KYLB_TU_NGAY
                                            ,vt_PN(i).KYLB_DEN_NGAY
                                            ,vt_PN(i).KY_TTOAN_TU_NGAY
                                            ,vt_PN(i).KY_TTOAN_DEN_NGAY
                                            ,vt_PN(i).MA_MUC
                                            ,vt_PN(i).MA_TMUC
                                            ,vt_PN(i).MA_THUE
                                            ,vt_PN(i).PHAI_NOP
                                            ,vt_PN(i).HAN_NOP
                                            ,vt_PN(i).TKHOAN
                                            ,v_Ckn
                                            ,vt_Pn(i).Qdinh_Id
                                            ,vt_Pn(i).Loai_Qdinh);
    
                END LOOP;
            END;--End Prc_Thanh_Toan
        BEGIN
            FOR vc_Map_Gd IN c_Map_Gd LOOP
                v_Idx_Gd := v_Idx_Gd + 1;
                arr_Gdich(v_Idx_Gd) := vc_Map_Gd;
                v_Priority := arr_Gdich(v_Idx_Gd).Priority;
            END LOOP;
            -- Xoa du lieu neu da chot no thang nay
            DELETE
            FROM    EXT_QCT_NO
            WHERE   Kyno_Tu_Ngay    =   Trunc(p_den_ky,''Month'');
           
            --Khoi tao gia tri bien dem so luong phan tu mang vt_PN(i)
            k:=0;
            FOR v_dtnt IN c_PHAI_NOP LOOP
                --Neu gap tap du lieu moi, thuc hien thanh toan tren tap du lieu da cap nhat vao mang
                IF    (v_last_tin<>''HHHHHHHHHHHHHH'')
                    AND (k > 0)
                    AND ((v_dtnt.tin     <>  v_last_tin)
                           OR  (v_dtnt.tkhoan  <>  v_last_tkhoan)
                           OR  (v_dtnt.ma_muc  <>  v_last_muc)
                           OR  (v_dtnt.ma_tmuc <>  v_last_tmuc))THEN
                    --Thuc hien ttoan,tinh phat ncham, cap nhat du lieu so no
                    PRC_THANH_TOAN;
                    --Cap nhat so luong phan tu cua mang vt_PN(i)
                    k:=0;
                END IF;
                -- Gan vao mang
                k:=k+1;
                vt_PN(k):=v_dtnt;            
                -- Cap nhat cac gia tri kiem tra v_last_TIN, v_Last_Ma_Muc,...
                v_last_tin     :=  v_dtnt.tin;
                v_last_tkhoan  :=  v_dtnt.tkhoan;
                v_last_muc     :=  v_dtnt.ma_muc;
                v_last_tmuc    :=  v_dtnt.ma_tmuc;
            END LOOP; -- danop
            --Thuc hien thanh toan tren tap du lieu cuoi cung trong con tro c_Phai_Nop
            PRC_THANH_TOAN;
        END;-- end prc_chot_no
    BEGIN        
        prc_thop_no_thue_tncn(trunc(p_ky_no,''MONTH''));
    END;
END;
');

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_2 IS      
    PROCEDURE Prc_Qlt_No(p_ky_no Date);
END;
');

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_2
IS
    PROCEDURE Prc_Qlt_No(p_ky_no DATE) IS
        TYPE rec_Gdich IS RECORD(Loai_Qdinh VARCHAR2(2),Gdich_Dnop VARCHAR2(2),Gdich_Pnop VARCHAR2(2));
        TYPE tab_Gdich IS TABLE OF rec_Gdich INDEX BY BINARY_INTEGER;
        arr_Gdich tab_Gdich;
        v_Idx_Gd    NUMBER := 0;
        v_Tin   VARCHAR2(14):= NULL;-- Test voi tung ma Tin
        PROCEDURE Prc_THop_No_Thue_Tncn(p_den_ky    DATE)IS
            v_Thang_TKhai   DATE;
            v_Nguon_Goc     VARCHAR2(100);
            --Con tro tong hop du lieu
           CURSOR c_Phai_nop IS
                SELECT  PNOP.TIN                    TIN
                        , DTNT.MA_CQT               MA_CQT
                        , DTNT.MA_PHONG             MA_PHONG
                        , DTNT.MA_CANBO             MA_CANBO
                        , HDR_ID                    HDR_ID
                        , DTL_ID                    DTL_ID
                        , KY_TTOAN_TU_NGAY          KY_TTOAN_TU_NGAY
                        , KY_TTOAN_DEN_NGAY         KY_TTOAN_DEN_NGAY
                        , KYLB_TU_NGAY              KYLB_TU_NGAY
                        , KYLB_DEN_NGAY             KYLB_DEN_NGAY
                        , KYKK_TU_NGAY              KYKK_TU_NGAY
                        , KYKK_DEN_NGAY             KYKK_DEN_NGAY
                        , MA_MUC                    MA_MUC
                        , MA_TMUC                   MA_TMUC
                        , MA_THUE                   MA_THUE
                        , TKHOAN                    TKHOAN
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
                                AND (Tmt_Ma_Muc = ''1000'' OR Tmt_Ma_Tmuc = ''4268'')
                                AND Nvl(ST.NO_CUOI_KY,0) <> 0
                        GROUP BY St.Tin,St.hdr_id,St.dtl_id,st.kykk_tu_ngay,st.kykk_den_ngay,
                                St.tmt_ma_muc,st.tmt_ma_tmuc,st.dgd_ma_gdich,st.dgd_kieu_gdich,
                                st.tmt_ma_thue,st.tkhoan,st.han_nop                                            
                    ) PNOP
                    , QLT_NSD_DTNT DTNT
            WHERE   PNOP.TIN = DTNT.TIN
                    AND (PNOP.TIN = v_Tin OR v_Tin IS NULL)
            ORDER BY PNOP.TIN, TKHOAN, MA_MUC, MA_TMUC
                    , Decode(PHAI_NOP + Abs(PHAI_NOP),0,-1,1)
                    , HAN_NOP
                    , KY_TTOAN_DEN_NGAY  ASC
                    , KY_TTOAN_TU_NGAY   DESC;
    
            CURSOR c_DM_GDich(pc_MA_GDICH  VARCHAR2,pc_Kieu_GDich VARCHAR2,pc_Ten_GDich VARCHAR2)IS
                SELECT  Ten
                FROM    QLT_DM_GDICH DM
                WHERE   DM.ma_gdich     =   pc_MA_GDICH
                    AND DM.kieu_gdich   =   pc_Kieu_GDich
                    AND NVL(trim(pc_Ten_GDich),''NULL'')    =   ''XLTK_GDICH''
                UNION ALL
                SELECT  trim(Substr(pc_Ten_GDich,1,100))    Ten
                FROM    Dual
                WHERE   NVL(trim(pc_Ten_GDich),''NULL'')    <>  ''XLTK_GDICH'';
         
            CURSOR c_Map_Gd IS
                SELECT Loai_Qdinh,Gdich_Dnop,Gdich_Pnop
                FROM Qlt_Map_Gdich_Ttoan
                ORDER BY Gdich_Dnop;
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
                    INSERT INTO EXT_QLT_NO (ID
                                               ,TIN
                                                   ,hdr_id
                                                   ,dtl_id
                                                   ,DGD_MA_GDICH
                                                   ,DGD_KIEU_GDICH
                                                   ,MA_CQT
                                                   ,MA_PHONG
                                                   ,MA_CANBO
                                                   ,KYNO_TU_NGAY
                                                   ,KYNO_DEN_NGAY
                                                   ,KYLB_TU_NGAY
                                                   ,KYLB_DEN_NGAY
                                                   ,KYKK_TU_NGAY
                                                   ,KYKK_DEN_NGAY
                                                   ,TMT_MA_MUC
                                                   ,TMT_MA_TMUC
                                                   ,TMT_MA_THUE
                                                   ,TKHOAN
                                                   ,NO_DAU_KY
                                                   ,NO_CUOI_KY
                                                   ,HAN_NOP
                                                   ,NGUON_GOC
                                                   ,KYTT_TU_NGAY
                                                   ,KYTT_DEN_NGAY
                                                   ,CHECK_KNO
                                                   ,Qdinh_Id
                                                   ,Loai_Qdinh
                                                )
                                        VALUES  (QLT_SNO_SEQ.NEXTVAL
                                                ,vt_PN(i).TIN
                                                ,vt_PN(i).hdr_id
                                                ,vt_PN(i).dtl_id
                                                ,vt_PN(i).ma_gdich
                                                ,vt_PN(i).kieu_gdich
                                                ,vt_PN(i).MA_CQT
                                                ,vt_PN(i).MA_PHONG
                                                ,vt_PN(i).MA_CANBO
                                                ,trunc(p_den_ky,''Month'')
                                                ,last_day(p_den_ky)
                                                ,vt_PN(i).KYLB_TU_NGAY
                                                ,vt_PN(i).KYLB_DEN_NGAY
                                                ,vt_PN(i).KYKK_TU_NGAY
                                                ,vt_PN(i).KYKK_DEN_NGAY
                                                ,vt_PN(i).MA_MUC
                                                ,vt_PN(i).MA_TMUC
                                                ,vt_PN(i).MA_THUE
                                                ,vt_PN(i).TKHOAN
                                                ,Decode(vt_PN(i).PHAI_NOP,Abs(vt_PN(i).PHAI_NOP),vt_PN(i).NO_DAU_KY,0)
                                                ,vt_PN(i).PHAI_NOP
                                                ,vt_PN(i).HAN_NOP
                                                , v_Nguon_Goc
                                                ,vt_PN(i).Ky_Ttoan_Tu_ngay
                                                ,vt_PN(i).Ky_Ttoan_Den_ngay
                                                ,''1''
                                                ,vt_Pn(i).Qdinh_Id
                                                ,vt_Pn(i).Loai_Qdinh);            
                END LOOP;
            END;--End Prc_Thanh_Toan
        BEGIN
            FOR vc_Map_Gd IN c_Map_Gd LOOP
                v_Idx_Gd := v_Idx_Gd + 1;
                arr_Gdich(v_Idx_Gd) := vc_Map_Gd;
            END LOOP;
            -- Xoa du lieu neu da chot no thang nay
            DELETE FROM EXT_QLT_NO SNO
            WHERE   Kyno_Tu_Ngay = Trunc(p_den_ky, ''MONTH'')
                    AND (SNO.TIN = v_Tin OR v_Tin IS NULL);     
    
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
        Prc_THop_No_Thue_Tncn(trunc(p_ky_no,''MONTH''));
    END;
END;
');
        prc_remote_sql('
CREATE OR REPLACE
PACKAGE ext_pck_control IS
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE);

    PROCEDURE Prc_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE);
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE);
    PROCEDURE Prc_Qct_Thop_Tk(p_tu DATE, p_den DATE);
    
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE);

    PROCEDURE Prc_Job_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE);
    PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE);
    PROCEDURE Prc_Job_Qct_Thop_Tk(p_tu DATE, p_den DATE);

    PROCEDURE Prc_Job_Qlt_Slech_No;
    PROCEDURE Prc_Job_Qct_Slech_No;

    PROCEDURE Prc_Remove_Job(p_pro_name VARCHAR2);
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2);
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2);
    PROCEDURE Prc_Del_Log(p_pck VARCHAR2);    
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2);
END;');

        prc_remote_sql('CREATE OR REPLACE
PACKAGE ext_pck_control_1 IS
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE);

    PROCEDURE Prc_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE);
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE);
    PROCEDURE Prc_Qct_Thop_Tk(p_tu DATE, p_den DATE);
    PROCEDURE Prc_Update_Pbcb(p_table_name VARCHAR2);
END;');

        /*Khoi tao Spec cho BODY cho PACKAGE*/
        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control
IS
    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qlt_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE) IS
    BEGIN
        EXT_PCK_CONTROL_1.Prc_Qlt_Thop_Ps(p_tu, p_den);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qlt_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE) IS
    BEGIN
        EXT_PCK_CONTROL_1.Prc_Qlt_Thop_No(p_chot);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qct_Thop_Ps
    ***************************************************************************/
    PROCEDURE Prc_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE) IS
    BEGIN
        EXT_PCK_CONTROL_1.Prc_Qct_Thop_Ps(p_tu, p_den, p_ps10);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qct_Thop_No
    ***************************************************************************/
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE) IS
    BEGIN
        EXT_PCK_CONTROL_1.Prc_Qct_Thop_No(p_chot);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Qct_Thop_Tk
    ***************************************************************************/
    PROCEDURE Prc_Qct_Thop_Tk(p_tu DATE, p_den DATE) IS
    BEGIN
        EXT_PCK_CONTROL_1.Prc_Qct_Thop_Tk(p_tu, p_den);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_Ps(p_tu DATE, p_den DATE)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_Ps(p_tu DATE, p_den DATE) IS  
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_PS'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL.Prc_Qlt_Thop_Ps(''''''||p_tu||'''''', ''''''||p_den||''''''); END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Thop_No(p_chot DATE)
    IS      
    BEGIN
        Prc_Del_Log(''PRC_QLT_THOP_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL.Prc_Qlt_Thop_No(''''''||p_chot||''''''); END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE) IS    
    BEGIN
        Prc_Del_Log(''PRC_QCT_THOP_PS'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL.Prc_Qct_Thop_Ps(''''''||p_tu||'''''', ''''''||p_den||'''''', ''''''||p_ps10||''''''); END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qct_Thop_No(p_chot)
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_No(p_chot DATE) IS  
    BEGIN
        Prc_Del_Log(''PRC_QCT_THOP_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL.Prc_Qct_Thop_No(''''''||p_chot||''''''); END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qct_Thop_Tk
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Thop_Tk(p_tu DATE, p_den DATE) IS
    BEGIN
        Prc_Del_Log(''PRC_QCT_THOP_TK'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL.Prc_Qct_Thop_Tk(''''''||p_tu||'''''', ''''''||p_den||'''''');END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qlt_Slech_No
    ***************************************************************************/
    PROCEDURE Prc_Job_Qlt_Slech_No IS  
    BEGIN
        Prc_Del_Log(''PRC_QLT_SLECH_NO'');
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL_4.Prc_Qlt_Slech_No; END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Job_Qct_Thop_Tk
    ***************************************************************************/
    PROCEDURE Prc_Job_Qct_Slech_No IS
    BEGIN
        Prc_Del_Log(''PRC_QCT_SLECH_NO'');    
        COMMIT;
        Prc_Create_Job(''BEGIN EXT_PCK_CONTROL_4.Prc_Qct_Slech_No; END;'');
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Remove_Job
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
    EXT_PCK_CONTROL.Prc_Remove_Job
    ***************************************************************************/
    PROCEDURE Prc_Create_Job(p_name_exe VARCHAR2)
    IS
        JobNo user_jobs.job%TYPE;
    BEGIN
        dbms_job.submit(JobNo,p_name_exe,SYSDATE + 10/86400,''SYSDATE + 365'');
        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        Prc_Ins_Log(''Create_Job_''||p_name_exe);
    END;

    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Ins_Log
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_pck VARCHAR2) IS
        v_status VARCHAR2(1);
        v_ltd NUMBER(4);
    BEGIN
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM ext_errors WHERE pck=p_pck;
        UPDATE ext_errors SET ltd=v_ltd WHERE ltd=0 AND pck=p_pck;
        -- Cap nhat trang thai cua thu tuc
        IF DBMS_UTILITY.FORMAT_ERROR_STACK IS NULL THEN v_status:=''Y'';
        ELSE v_status:=''N'';
        END IF;

        -- Insert log
        INSERT INTO ext_errors(seq_number, error_stack, call_stack, timestamp,pck, status)
             VALUES(ext_seq.NEXTVAL, DBMS_UTILITY.FORMAT_ERROR_STACK, DBMS_UTILITY.FORMAT_CALL_STACK, SYSDATE, p_pck, v_status);
        COMMIT;
    END;
    /***************************************************************************
    EXT_PCK_CONTROL.Prc_Del_Log
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
    EXT_PCK_CONTROL.Prc_Finnal
    ***************************************************************************/
    PROCEDURE Prc_Finnal(p_fnc_name VARCHAR2) IS
    BEGIN
        Prc_Remove_Job(p_fnc_name);
        Prc_Ins_Log(p_fnc_name);
    END;
END;');

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_1
IS
    /**************************************************************************/
    PROCEDURE Prc_Qlt_Thop_Ps(p_tu DATE, p_den DATE) IS
    c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_PS'';
    v_Alert_button NUMBER;
    CURSOR cLoop IS
    /* TO KHAI PHAT SINH */
    SELECT tkha.tin tin, tkha.dtk_ma_loai_tkhai dtk_ma, nnt.ma_chuong ma_chuong,
               nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc tmt_ma_tmuc,
               tkha.kykk_tu_ngay kykk_tu_ngay, tkha.kykk_den_ngay kykk_den_ngay,
               psin.thue_psinh so_tien, ''2'' trang_thai, tkha.ngay_nop ngay_nop,
               tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc=''1000'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >= p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai IN (''29'',''30'',''21'',''60'',''19''))
        AND (psin.thue_psinh<>0)
        UNION ALL
        /* Nghiep vu cho 01/KK-XS */
        SELECT tkha.tin, ''99'' dtk_ma, nnt.ma_chuong, nnt.ma_khoan, psin.tmt_ma_tmuc,
               tkha.kykk_tu_ngay, tkha.kykk_den_ngay, psin.thue_psinh so_tien,
               ''2'' trang_thai, tkha.ngay_nop ngay_nop, tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc=''1000'')
        AND (psin.tmt_ma_tmuc=''1003'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay>=p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai=''12'')
        AND (nnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
        AND (nnt.ma_loai=''550'')
        AND (nnt.ma_khoan=''558'')
        AND (psin.thue_psinh<>0)
        UNION ALL
        /* Nghiep vu cho 01/KK-BH */
        SELECT tkha.tin, ''98'' dtk_ma, nnt.ma_chuong, nnt.ma_khoan, psin.tmt_ma_tmuc,
               tkha.kykk_tu_ngay, tkha.kykk_den_ngay, psin.thue_psinh so_tien,
               ''2'' trang_thai, tkha.ngay_nop ngay_nop, tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc = ''1000'')
        AND (psin.tmt_ma_tmuc = ''1003'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >=p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai=''12'')
        AND (nnt.ma_chuong IN (''038'', ''173''))
        AND (psin.thue_psinh<>0)
        UNION ALL
        /* Nghiep vu cho 08/KK-TNCN */
        SELECT tkha.tin, ''24'' dtk_ma, nnt.ma_chuong, nnt.ma_khoan, psin.tmt_ma_tmuc,
               tkha.kykk_tu_ngay, tkha.kykk_den_ngay, psin.thue_psinh so_tien,
               ''2'' trang_thai, tkha.ngay_nop ngay_nop, tkha.han_nop, tkha.KYLB_TU_NGAY
        FROM qlt_tkhai_hdr tkha,
             qlt_psinh_tkhai psin,
             qlt_nsd_dtnt nnt
        WHERE tkha.id=psin.tkh_id
        AND (nnt.tin=tkha.tin)
        AND (psin.tmt_ma_muc = ''1000'')
        AND (psin.tmt_ma_tmuc = ''1003'')
        AND (tkha.ltd=0)
        AND (tkha.ltd = psin.tkh_ltd)
        AND (tkha.kykk_tu_ngay >=p_tu)
        AND (tkha.kylb_tu_ngay <= p_den)
        AND (tkha.dtk_ma_loai_tkhai=''12'')
        AND (nnt.ma_chuong IN (''557'', ''757'', ''857''))
        AND (psin.thue_psinh<>0)
        UNION ALL
    /* AN DINH TO KHAI */
        SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
               hdr.kykk_tu_ngay, hdr.kykk_den_ngay, dtl.so_thue,
               ''AN_DINH'' trang_thai, to_date(NULL) ngay_nop, to_date(NULL) han_nop, hdr.KYLB_TU_NGAY
        FROM qlt_ds_an_dinh_hdr hdr,
             qlt_ds_an_dinh_dtl dtl,
             qlt_nsd_dtnt nnt
        WHERE hdr.id=dtl.adh_id
        AND (nnt.tin=hdr.tin)
        AND (hdr.ly_do IN (''02'',''03''))
        AND (dtl.tmt_ma_muc=''1000'')
        AND (hdr.kykk_tu_ngay >= p_tu)
        AND (hdr.kylb_tu_ngay <= p_den)
        AND (hdr.dtk_ma IN (''29'',''30'',''21'',''60'',''19''))
        UNION ALL
    /* BAI BO AN DINH TO KHAI */
            SELECT hdr.tin, hdr.dtk_ma, nnt.ma_chuong, nnt.ma_khoan, dtl.tmt_ma_tmuc,
                   hdr.kykk_tu_ngay, hdr.kykk_den_ngay, (-1)*dtl.so_thue,
                   ''BAI_BO_AN_DINH'' trang_thai, to_date(NULL) ngay_nop, to_date(NULL) han_nop, hdr.KYLB_TU_NGAY
            FROM qlt_qd_bbo_ad_hdr hdr,
                 qlt_qd_bbo_ad_dtl dtl,
                 qlt_nsd_dtnt nnt
            WHERE hdr.id=dtl.qba_id
            AND (nnt.tin=hdr.tin)
            AND (dtl.tmt_ma_muc=''1000'')
            AND (hdr.kykk_tu_ngay >= p_tu)
            AND (hdr.kylb_tu_ngay <= p_den)
            AND (hdr.dtk_ma IN (''29'',''30'',''21'',''60'',''19''));
    /* XU LY KHIEU NAI */
        CURSOR cADI IS
        SELECT hdr.id, hdr.so_qd_goc, adi.dtk_ma, adi.kykk_tu_ngay, adi.kykk_den_ngay,
               adi.tin, nnt.ma_chuong, nnt.ma_khoan, ''KHIEU_NAI_AN_DINH'' trang_thai, adi.KYLB_TU_NGAY
        FROM qlt_ds_an_dinh_hdr adi,
               qlt_ds_an_dinh_dtl dtl,
             qlt_qd_xlkn_hdr hdr,
             qlt_nsd_dtnt nnt
        WHERE adi.so_qd=hdr.so_qd_goc
        AND (adi.id=dtl.adh_id)
        AND (adi.tin=nnt.tin)
        AND (adi.ly_do IN (''03''))
        AND (dtl.tmt_ma_muc=''1000'')
        AND (adi.kykk_tu_ngay >= p_tu)
        AND (adi.kylb_tu_ngay <= p_den)
        AND (adi.dtk_ma IN (''29'',''30'',''21'',''60'',''19''));

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

        DELETE FROM ext_qlt_ps dtl WHERE dtl.loai_dlieu<>''1'';
        /* day du lieu phat sinh to khai, an dinh, bai bo */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                          ghi_chu, ngay_nop, ma_tkhai, ky_psinh_tu,
                                          ky_psinh_den, loai_dlieu, han_nop, ngay_htoan)
                VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ma_chuong, vLoop.ma_khoan,
                       vLoop.tmt_ma_tmuc, vLoop.so_tien, NULL, vLoop.ngay_nop,
                       vLoop.dtk_ma, vLoop.kykk_tu_ngay, vLoop.kykk_den_ngay, ''2'',
                       vLoop.han_nop, vLoop.kylb_tu_ngay);
        END LOOP;
        /* day du lieu khieu nai */
        FOR vADI IN cADI LOOP
            FOR vKHN IN cKHN(vADI.so_qd_goc) LOOP
                INSERT INTO ext_qlt_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc,
                                              so_tien, ghi_chu, ma_tkhai, ky_psinh_tu,
                                              ky_psinh_den, loai_dlieu, ngay_htoan)
                    VALUES(ext_seq.NEXTVAL, vADI.tin, vADI.ma_chuong, vADI.ma_khoan,
                           vKHN.tmt_ma_tmuc, vKHN.so_tien, NULL,
                           vADI.dtk_ma, vADI.kykk_tu_ngay, vADI.kykk_den_ngay,
                           ''2'', vADI.KYLB_TU_NGAY);
            END LOOP;
        END LOOP;
        /* cap nhat lai chuong khoan */
        UPDATE ext_qlt_ps a
           SET a.ma_khoan=''000'',
               a.ma_chuong=(SELECT DECODE(substr(GIA_TRI,-2),''00'',''557'',''757'') chuong
                              FROM qlt_tham_so
                             WHERE ten=''MA_CQT'');
        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_ps'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
    END;
    /**************************************************************************/
    PROCEDURE Prc_Qlt_Thop_No(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_THOP_NO'';
        
        CURSOR cUp_Ky IS
        SELECT id FROM  ext_qlt_no
        WHERE NOT (kykk_den_ngay=last_day(kykk_tu_ngay) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),2) OR
                   kykk_den_ngay=add_months(last_day(kykk_tu_ngay),11));        
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        
        DELETE FROM ext_qlt_no WHERE status<>''1'';
        
        EXT_PCK_CONTROL_2.prc_qlt_no(p_chot);
        
        /* cap nhat lai chuong khoan */
        UPDATE ext_qlt_no a
           SET a.ma_khoan=''000'',
               a.ma_chuong=(SELECT DECODE(substr(GIA_TRI,-2),
                                          ''00'',
                                          DECODE(a.tmt_ma_tmuc,
                                                 ''1001'',''557'',
                                                 ''1003'',''557'',
                                                 ''1004'',''557'',
                                                 ''1005'',''557'',
                                                 ''757''),
                                          ''757'') chuong
                              FROM qlt_tham_so
                             WHERE ten=''MA_CQT'');

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qlt_no
                SET kykk_tu_ngay=trunc(kykk_tu_ngay, ''MONTH''),
                      kykk_den_ngay=last_day(trunc(kykk_tu_ngay, ''MONTH''))
            WHERE id=vUp_Ky.id;
        END LOOP;
        
        UPDATE ext_qlt_no SET KYKK_TU_NGAY=to_date(''1-jan-2005'',''DD/MM/RRRR''),
                              KYKK_DEN_NGAY=to_date(''31-jan-2005'',''DD/MM/RRRR'')
                        WHERE KYKK_TU_NGAY<to_date(''1-jan-2005'',''DD/MM/RRRR'');        
        
        /* cap nhat phong ban can bo */
        Prc_Update_Pbcb(''ext_qlt_no'');
        COMMIT;
        
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;

        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
    END;
    /**************************************************************************/
    PROCEDURE Prc_Qct_Thop_Ps(p_tu DATE, p_den DATE, p_ps10 DATE) IS
    c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QCT_THOP_PS'';
        CURSOR cLoop IS
    /* TO KHAI PHAT SINH */
            SELECT Decode(tkha.dcc_ma, ''25'', psin.tin
                                     , ''27'', psin.tin
                                     , ''31'', psin.tin
                                     , tkha.tin) tin,
                          decode(tkha.dcc_ma, ''30'', ''24'', ''31'', ''25'', tkha.dcc_ma) dcc_ma,
                          nnt.ma_chuong ma_chuong, nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc ma_tmuc,
                          tkha.kykk_tu_ngay kykk_tu_ngay,
                          Decode(tkha.dcc_ma, ''30'', last_day(tkha.kykk_tu_ngay)
                                            , ''31'', last_day(tkha.kykk_tu_ngay)
                                            , last_day(tkha.kykk_den_ngay)) kykk_den_ngay,                          
                          psin.thue_psinh so_tien, ''2'' trang_thai, tkha.ngay_nop ngay_nop,
                          tkha.han_nop, tkha.kylb_tu_ngay
            FROM qct_cctt_hdr tkha,
                 qct_cctt_psinh psin,
                 qlt_nsd_dtnt nnt,
                 qct_dtnt db
            WHERE tkha.id=psin.hdr_id
            AND (nnt.tin=Decode(tkha.dcc_ma, ''25'', psin.tin
                                           , ''27'', psin.tin
                                           , ''31'', psin.tin
                                           , tkha.tin))
            AND (nnt.tin=db.tin)
            AND (psin.tmt_ma_muc=''1000'')
            AND (tkha.kykk_tu_ngay>=p_tu)
            AND (tkha.kylb_tu_ngay<=p_den)
            AND (tkha.dcc_ma IN (''24'',''25'')
                OR (tkha.dcc_ma IN (''30'', ''31'')
                    AND (qtoan_het_nam_dau=''Y''
                        OR (qtoan_het_nam_dau is NULL AND qtoan_tung_nam is null)
                        OR (qtoan_tung_nam=''Y''
                            AND to_char(tkha.kykk_tu_ngay,''YYYY'')=to_char(tkha.kykk_den_ngay,''YYYY'')))))
            AND (psin.thue_psinh<>0)
            UNION ALL
            SELECT tkha.tin, tkha.dcc_ma dcc_ma,
                   nnt.ma_chuong ma_chuong, nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc ma_tmuc,
                   tkha.kykk_tu_ngay kykk_tu_ngay, tkha.kykk_den_ngay kykk_den_ngay,
                   psin.thue_psinh so_tien, ''2'' trang_thai, tkha.ngay_nop ngay_nop,
                   tkha.han_nop, tkha.kylb_tu_ngay
            FROM qct_cctt_hdr tkha,
                 qct_cctt_psinh psin,
                 qlt_nsd_dtnt nnt,
                 qct_dtnt db
            WHERE tkha.id=psin.hdr_id
            AND (nnt.tin=tkha.tin)
            AND (nnt.tin=db.tin)
            AND (psin.tmt_ma_muc=''1000'')
            AND (tkha.kykk_tu_ngay>=p_tu)
            AND (psin.kylb_tu_ngay<=p_ps10)
            AND (tkha.dcc_ma IN (''26'',''27''))
            AND (psin.thue_psinh<>0)
            UNION ALL
    /* AN DINH TO KHAI */
            SELECT hdr.tin tin, hdr.dcc_ma dcc_ma, nnt.ma_chuong ma_chuong,
                   nnt.ma_khoan ma_khoan, dtl.tmt_ma_tmuc ma_tmuc, hdr.kykk_tu_ngay kykk_tu_ngay,
                   hdr.kykk_den_ngay kykk_den_ngay, dtl.so_thue so_tien, ''2'' trang_thai,
                   to_date(NULL) ngay_nop, to_date(NULL) han_nop, hdr.kylb_tu_ngay
            FROM qct_ds_adinh_hdr hdr,
                 qct_ds_adinh_dtl dtl,
                 qlt_nsd_dtnt nnt,
                 qct_dtnt db
            WHERE hdr.id=dtl.hdr_id
            AND (nnt.tin=hdr.tin)
            AND (nnt.tin=db.tin)
            AND (hdr.ly_do IN (''02'',''03''))
            AND (dtl.tmt_ma_muc=''1000'')
            AND (hdr.kykk_tu_ngay>=p_tu)
            AND (hdr.kylb_tu_ngay<=p_den)
            AND ((hdr.dcc_ma IN (''24'',''25'')) OR
                ((hdr.dcc_ma IN (''26'',''27'')) AND (hdr.kykk_tu_ngay<=p_ps10)))
            UNION ALL
    /* BAI BO AN DINH TO KHAI */
            SELECT hdr.tin tin, hdr.dcc_ma dcc_ma, nnt.ma_chuong ma_chuong,
                   nnt.ma_khoan ma_khoan, dtl.tmt_ma_tmuc ma_tmuc,
                   hdr.kykk_tu_ngay kykk_tu_ngay, hdr.kykk_den_ngay kykk_den_ngay,
                   (-1)*dtl.so_thue so_tien, ''2'' trang_thai, to_date(NULL) ngay_nop,
                   to_date(NULL) han_nop, hdr.kylb_tu_ngay
            FROM qct_bbo_adinh_hdr hdr,
                 qct_bbo_adinh_dtl dtl,
                 qlt_nsd_dtnt nnt,
                 qct_dtnt db
            WHERE hdr.id=dtl.hdr_id
            AND (nnt.tin=hdr.tin)
            AND (nnt.tin=db.tin)
            AND (dtl.tmt_ma_muc=''1000'')
            AND (hdr.kykk_tu_ngay>=p_tu)
            AND (hdr.kylb_tu_ngay<=p_den)
            AND ((hdr.dcc_ma IN (''24'',''25'')) OR
                ((hdr.dcc_ma IN (''26'',''27'')) AND (hdr.kykk_tu_ngay<=p_ps10)));

    /* XU LY KHIEU NAI */
        CURSOR cADI IS
        SELECT hdr.id id, hdr.so_qd so_qd, adi.dcc_ma dcc_ma, adi.kykk_tu_ngay kykk_tu_ngay,
               adi.kykk_den_ngay kykk_den_ngay, adi.tin tin, nnt.ma_chuong ma_chuong,
               nnt.ma_khoan ma_khoan, ''KHIEU_NAI_AN_DINH'' trang_thai, adi.kylb_tu_ngay
            FROM qct_ds_adinh_hdr adi,
                     qct_ds_adinh_dtl dtl,
                 qct_qd_knai_hdr hdr,
                 qlt_nsd_dtnt nnt,
                 qct_dtnt db
            WHERE adi.so_qd=hdr.so_qd
            AND (adi.id=dtl.hdr_id)
            AND (adi.tin=nnt.tin)
            AND (nnt.tin=db.tin)
            AND (adi.ly_do IN (''03''))
            AND (dtl.tmt_ma_muc=''1000'')
            AND (adi.kykk_tu_ngay>=p_tu)
            AND (adi.kylb_tu_ngay<=p_den)
            AND ((adi.dcc_ma IN (''24'',''25'')) OR
                ((adi.dcc_ma IN (''26'',''27'')) AND (adi.kykk_tu_ngay<=p_ps10)));

        CURSOR cKHN(p_so_qd_goc VARCHAR2) IS
            SELECT dtl.tmt_ma_tmuc ma_tmuc, dtl.so_tien_cl so_tien
            FROM qct_qd_knai_hdr hdr,
                 qct_qd_knai_dtl dtl
            WHERE hdr.id=dtl.hdr_id
            AND EXISTS (SELECT 1
                        FROM qct_qd_knai_hdr subhdr
                        WHERE subhdr.id=hdr.id
                        START WITH subhdr.so_qd = p_so_qd_goc
                        CONNECT BY PRIOR subhdr.so_qd_knai = subhdr.so_qd);

        vId NUMBER;

        /*Khai bao tong hop cho to thue nha*/
        CURSOR c IS
        SELECT Decode(tkha.dcc_ma, ''31'', psin.tin, tkha.tin) tin,
               decode(tkha.dcc_ma, ''30'', ''24'', ''25'') dcc_ma,
               nnt.ma_chuong ma_chuong, nnt.ma_khoan ma_khoan, psin.tmt_ma_tmuc ma_tmuc,
               tkha.kykk_tu_ngay kykk_tu_ngay, last_day(tkha.kykk_den_ngay) kykk_den_ngay,
               psin.thue_psinh so_tien, ''2'' trang_thai, tkha.ngay_nop ngay_nop,
               tkha.han_nop, tkha.kylb_tu_ngay,
               (to_number(to_char(tkha.KYKK_DEN_NGAY, ''YYYY''))-to_number(to_char(tkha.KYKK_TU_NGAY, ''YYYY'')))+1 bt_rows,
               TRUNC(MONTHS_BETWEEN(tkha.kykk_den_ngay, tkha.kykk_tu_ngay))+1 bt_mon               
        FROM qct_cctt_hdr tkha,
             qct_cctt_psinh psin,
             qlt_nsd_dtnt nnt,
             qct_dtnt db
        WHERE tkha.id=psin.hdr_id
        AND (nnt.tin=Decode(tkha.dcc_ma, ''31'', psin.tin, tkha.tin))
        AND (nnt.tin=db.tin)
        AND (psin.tmt_ma_muc=''1000'')
        AND (tkha.kykk_tu_ngay>=p_tu)
        AND (tkha.kylb_tu_ngay<=p_den)
        AND (tkha.dcc_ma IN (''30'',''31''))
        AND (qtoan_tung_nam=''Y'')
        AND (to_char(tkha.kykk_tu_ngay,''YYYY'')<>to_char(tkha.kykk_den_ngay,''YYYY''))
        AND (psin.thue_psinh<>0);
        v_date_loop DATE;
        v_date_cond DATE;
        v_count_date NUMBER;
        v_ins_kykk_tu_ngay DATE;
        v_ins_kykk_den_ngay DATE;
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
    /* Don du lieu */
        DELETE FROM ext_qct_ps dtl WHERE dtl.LOAI_DLIEU <>''1'';

    /* day du lieu phat sinh to khai, an dinh, bai bo */
        FOR vLoop IN cLoop LOOP
            INSERT INTO ext_qct_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                   ngay_nop, ma_tkhai, ky_psinh_tu, ky_psinh_den,
                                   loai_dlieu, han_nop, ngay_htoan)
            VALUES(ext_seq.NEXTVAL, vLoop.tin, vLoop.ma_chuong, vLoop.ma_khoan,
                   vLoop.ma_tmuc, vLoop.so_tien, vLoop.ngay_nop, vLoop.dcc_ma,
                   vLoop.kykk_tu_ngay, vLoop.kykk_den_ngay, ''2'',
                   vLoop.han_nop, vLoop.kylb_tu_ngay);
        END LOOP;

    /* day du lieu khieu nai */
        FOR vADI IN cADI LOOP
            FOR vKHN IN cKHN(vADI.so_qd) LOOP
                INSERT INTO ext_qct_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                       ma_tkhai, ky_psinh_tu, ky_psinh_den, loai_dlieu, ngay_htoan)
                VALUES(ext_seq.NEXTVAL, vADI.tin, vADI.ma_chuong, vADI.ma_khoan, vKHN.ma_tmuc,
                       vKHN.so_tien, vADI.dcc_ma, vADI.kykk_tu_ngay, vADI.kykk_den_ngay, ''2'',
                       vADI.kylb_tu_ngay);
            END LOOP;
        END LOOP;
       /* TONG HOP CHO TO THUE NHA */
        FOR v IN c LOOP
            v_date_loop := v.kykk_tu_ngay;
            FOR i IN 1..v.bt_rows LOOP
                v_count_date:=0;
                v_date_cond := add_months(trunc(v_date_loop, ''YEAR''),11);
                LOOP
                    v_date_loop := add_months(v_date_loop,1);
                    v_count_date := v_count_date + 1;
                    EXIT WHEN (trunc(v_date_loop, ''MONTH'')>v_date_cond OR trunc(v_date_loop, ''MONTH'')>trunc(v.kykk_den_ngay, ''MONTH''));
                END LOOP;
                IF i=1 THEN
                    v_ins_kykk_tu_ngay:=trunc(v.kykk_tu_ngay, ''MONTH'');
                    v_ins_kykk_den_ngay:=last_day(trunc(v.kykk_tu_ngay, ''MONTH''));
                ELSIF i = v.bt_rows THEN
                    v_ins_kykk_tu_ngay:=trunc(v_date_cond, ''YEAR'');
                    v_ins_kykk_den_ngay:=last_day(trunc(v_date_cond, ''YEAR''));
                ELSE
                    v_ins_kykk_tu_ngay:=trunc(v_date_cond, ''YEAR'');
                    v_ins_kykk_den_ngay:=last_day(trunc(v_date_cond, ''YEAR''));
                END IF;
                INSERT INTO ext_qct_ps(id, tin, ma_chuong, ma_khoan, ma_tmuc, so_tien,
                                       ngay_nop, ma_tkhai, ky_psinh_tu, ky_psinh_den,
                                       loai_dlieu, han_nop, ngay_htoan)
                VALUES(ext_seq.NEXTVAL, v.tin, v.ma_chuong, v.ma_khoan, v.ma_tmuc,
                       round((v.so_tien/v.bt_mon)*v_count_date,0), 
                       v.ngay_nop, v.dcc_ma, v_ins_kykk_tu_ngay,
                       v_ins_kykk_den_ngay, ''2'', v.han_nop, v.kylb_tu_ngay);            
            END LOOP;        
        END LOOP;
        /* cap nhat lai chuong khoan */
        UPDATE ext_qct_ps a
           SET a.ma_khoan=''000'',
               a.ma_chuong=(SELECT DECODE(substr(GIA_TRI,-2),''00'',''557'',''757'') chuong
                              FROM qlt_tham_so
                             WHERE ten=''MA_CQT'');
        Prc_Update_Pbcb(''ext_qct_ps'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
    END;
    /**************************************************************************/
    PROCEDURE Prc_Qct_Thop_No(p_chot DATE) IS
    c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QCT_THOP_NO'';

    CURSOR cUp_Ky IS
    SELECT id FROM  ext_qct_no
    WHERE NOT (KY_THUE_DEN_NGAY=last_day(KY_THUE_TU_NGAY) OR
               KY_THUE_DEN_NGAY=add_months(last_day(KY_THUE_TU_NGAY),2) OR
               KY_THUE_DEN_NGAY=add_months(last_day(KY_THUE_TU_NGAY),11));

    BEGIN
        qct_pck_chot_so.prc_load_dsach_dtnt;
        
        EXT_PCK_CONTROL_3.prc_qct_no(p_chot);
        
        UPDATE ext_qct_no SET KY_THUE_TU_NGAY=kylb_tu_ngay, KY_THUE_DEN_NGAY=kylb_den_ngay
            WHERE KY_THUE_TU_NGAY IS NULL;

        UPDATE ext_qct_no SET KY_THUE_TU_NGAY=to_date(''1-jan-2005'',''DD/MM/RRRR''),
                             KY_THUE_DEN_NGAY=to_date(''31-jan-2005'',''DD/MM/RRRR'')
            WHERE KY_THUE_TU_NGAY<to_date(''1-jan-2005'',''DD/MM/RRRR'');

        /* cap nhat lai chuong khoan */
        UPDATE ext_qct_no a
           SET a.ma_khoan=''000'',
               a.ma_chuong=''757'';

        FOR vUp_Ky IN cUp_Ky LOOP
            UPDATE ext_qct_no
                SET KY_THUE_TU_NGAY=trunc(KY_THUE_TU_NGAY, ''MONTH''),
                      KY_THUE_DEN_NGAY=last_day(trunc(KY_THUE_TU_NGAY, ''MONTH''))
            WHERE id=vUp_Ky.id;
        END LOOP;
        
        Prc_Update_Pbcb(''ext_qct_no'');
        
        qct_pck_chot_so.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
    END;
    /**************************************************************************/
    PROCEDURE Prc_Qct_Thop_Tk(p_tu DATE, p_den DATE) IS
    c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QCT_THOP_TK'';
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        DELETE FROM ext_qct_tk;
        INSERT INTO ext_qct_tk(
               tin, kykk_tu_ngay, kykk_den_ngay, kylb_tu_ngay, dthu_dkien,
               tl_thnhap_dkien, thnhap_cthue_dkien, gtru_gcanh, ban_than,
               phu_thuoc, thnhap_tthue_dkien, tncn, ma_dlt, ngay_hdong_dlt, pb01,
               kytt01, ht01, hn01, pb02, kytt02, ht02, hn02,
               pb03, kytt03, ht03, hn03, pb04, kytt04, ht04,
               hn04, hdr_id)
        SELECT SUB01.TIN
                        , SUB01.KYKK_TU_NGAY
                        , SUB01.KYKK_DEN_NGAY
                        , SUB01.KYLB_TU_NGAY
                        , SUB01.DTHU_DKIEN
                        , SUB01.TL_THNHAP_DKIEN
                        , SUB01.THNHAP_CTHUE_DKIEN
                        , SUB01.GTRU_GCANH
                        , SUB01.BAN_THAN
                        , SUB01.PHU_THUOC
                        , SUB01.THNHAP_TTHUE_DKIEN
                        , SUB01.TNCN
                        , SUB01.MA_DLT
                        , SUB01.NGAY_HDONG_DLT
                        , SUB02.PB01
                        , SUB02.KYTT01
                        , SUB02.HT01
                        , SUB02.HN01
                        , SUB02.PB02
                        , SUB02.KYTT02
                        , SUB02.HT02
                        , SUB02.HN02
                        , SUB02.PB03
                        , SUB02.KYTT03
                        , SUB02.HT03
                        , SUB02.HN03
                        , SUB02.PB04
                        , SUB02.KYTT04
                        , SUB02.HT04
                        , SUB02.HN04
                        , SUB01.HDR_ID
        FROM
        (
                SELECT    min(HDR.id) HDR_ID  
                        , HDR.TIN TIN
                        , HDR.KYKK_TU_NGAY
                        , HDR.KYKK_DEN_NGAY
                        , MAX(HDR.MA_DLT) MA_DLT
                        , MAX(HDR.NGAY_HDONG_DLT) NGAY_HDONG_DLT
                        , MIN(HDR.KYLB_TU_NGAY) KYLB_TU_NGAY
                , NVL(SUM(DECODE(CTK_ID, 210, DTL.SO_CQT)),0) DTHU_DKIEN
                , NVL(SUM(DECODE(CTK_ID, 211, DTL.SO_CQT)),0) TL_THNHAP_DKIEN
                , NVL(SUM(DECODE(CTK_ID, 212, DTL.SO_CQT)),0) THNHAP_CTHUE_DKIEN
                , NVL(SUM(DECODE(CTK_ID, 213, DTL.SO_CQT)),0) GTRU_GCANH
                , NVL(SUM(DECODE(CTK_ID, 214, DTL.SO_CQT)),0) BAN_THAN
                , NVL(SUM(DECODE(CTK_ID, 215, DTL.SO_CQT)),0) PHU_THUOC
                , NVL(SUM(DECODE(CTK_ID, 216, DTL.SO_CQT)),0) THNHAP_TTHUE_DKIEN
                , NVL(SUM(DECODE(CTK_ID, 217, DTL.SO_CQT)),0) TNCN
                 FROM QCT_CCTT_HDR HDR, QCT_TKHAI_TNCN DTL
                WHERE HDR.ID=DTL.HDR_ID
                  AND HDR.DCC_MA=''26'' AND HDR.KYKK_TU_NGAY>=p_tu
                  AND HDR.kylb_tu_ngay<= p_den
                GROUP BY HDR.TIN
                        , HDR.KYKK_TU_NGAY
                        , HDR.KYKK_DEN_NGAY
        ) SUB01,
        (
                SELECT HDR.Tin
                        , NVL(SUM(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/01'', PSI.THUE_PSINH)), 0) PB01
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/01'', TO_CHAR(PSI.KYLB_TU_NGAY,''YY'')||''Q1'')) KYTT01
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/01'', PSI.KYLB_TU_NGAY)) HT01
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/01'', PSI.HAN_NOP)) HN01
                        , NVL(SUM(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/04'', PSI.THUE_PSINH)), 0) PB02
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/04'', TO_CHAR(PSI.KYLB_TU_NGAY,''YY'')||''Q2'')) KYTT02
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/04'', PSI.KYLB_TU_NGAY)) HT02
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/04'', PSI.HAN_NOP)) HN02
                        , NVL(SUM(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/07'', PSI.THUE_PSINH)), 0) PB03
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/07'', TO_CHAR(PSI.KYLB_TU_NGAY,''YY'')||''Q3'')) KYTT03
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/07'', PSI.KYLB_TU_NGAY)) HT03
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/07'', PSI.HAN_NOP)) HN03
                        , NVL(SUM(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/10'', PSI.THUE_PSINH)), 0) PB04
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/10'', TO_CHAR(PSI.KYLB_TU_NGAY,''YY'')||''Q4'')) KYTT04
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/10'', PSI.KYLB_TU_NGAY)) HT04
                        , MIN(DECODE(TO_CHAR(TRUNC(TO_DATE(PSI.KYLB_TU_NGAY), ''Q''), ''DD/MM''), ''01/10'', PSI.HAN_NOP)) HN04
                 FROM QCT_CCTT_HDR HDR, QCT_CCTT_PSINH PSI
                WHERE HDR.ID=PSI.HDR_ID
                  AND HDR.DCC_MA=''26''
              AND HDR.KYKK_TU_NGAY>=p_tu
                  AND HDR.kylb_tu_ngay<= p_den
                GROUP BY HDR.Tin, HDR.KYKK_TU_NGAY, HDR.KYKK_DEN_NGAY
        ) SUB02, QLT_NSD_DTNT DTNT, QCT_DTNT DB
        WHERE SUB01.TIN=SUB02.TIN AND SUB01.TIN = DTNT.TIN AND SUB01.TIN = DB.TIN;
        UPDATE ext_qct_tk a 
           SET tl_thnhap_dkien=(SELECT b.SO_CQT FROM qct_tkhai_tncn b WHERE ctk_id=211 AND hdr_id=a.hdr_id)
         WHERE EXISTS (SELECT 1 FROM qct_tkhai_tncn b WHERE ctk_id=211 AND hdr_id=a.hdr_id);              
        Prc_Update_Pbcb(''ext_qct_tk'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
    END;   
    /**************************************************************************/
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
                  FROM qlt_nsd_dtnt b WHERE a.tin=b.tin)'';    
    END;    
END;'
);

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_4 IS
    PROCEDURE Prc_Qlt_Slech_No;
    PROCEDURE Prc_Qct_Slech_No;
    PROCEDURE Prc_Dchinh_No_Qlt;
    PROCEDURE Prc_Dchinh_No_Qct;    
    v_gl_cqt VARCHAR2(5);    
END;
');

        prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_4
IS
    /**************************************************************************/
    PROCEDURE Prc_Qlt_Slech_No IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QLT_SLECH_NO'';
        v_max_upd NUMBER(3);
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        SELECT NVL(max(update_no),0) INTO v_max_upd FROM ext_slech_no;
        SELECT gia_tri INTO v_gl_cqt FROM qlt_tham_so WHERE ten=''MA_CQT'';                         
        UPDATE ext_slech_no SET update_no = v_max_upd+1 
         WHERE loai=''QLT'' AND update_no=0;                

        INSERT INTO ext_slech_no (loai, ky_thue, tin, 
                                  ten_dtnt, tai_khoan, muc, tieumuc, mathue,
                                  sothue_no_cky, sono_no_cky, clech_no_cky, 
                                  update_no, ma_slech, ma_gdich, ten_gdich, ma_cqt)
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               ''TK_TAM_GIU'' tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               par.no_cky SOTHUE_NO_CKY, 
               to_number(NULL) SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 5 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt
          FROM qlt_so_tdtn_tkhoan_tgiu par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin(+)
           AND par.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
           AND par.no_cky<>0
        UNION ALL        
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 2 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)         
           AND par.tkhoan=''TK_TAM_GIU'' 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QLT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 3 ma_slech,
               par.dgd_ma_gdich,
               gd.ten,
               v_gl_cqt               
          FROM qlt_so_no par, qlt_nsd_dtnt nnt, qlt_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.dgd_ma_gdich=gd.ma_gdich(+)         
           AND par.han_nop IS NULL 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QLT'' loai, 
               par.ky_thue,         
               par.tin, 
               max(nnt.TEN_DTNT) TEN_DTNT, 
               par.tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue MATHUE,  
               ROUND(sum(par.ST_NO_CKY),0) SOTHUE_NO_CKY, 
               sum(par.SN_NO_CKY) SONO_NO_CKY,  
               (ROUND(sum (par.ST_NO_CKY),0)-sum(par.SN_NO_CKY)) CLECH_NO_CKY,
               0 update_no, 1 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt               
        FROM
        (
        SELECT ''TK_NGAN_SACH'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_thue t
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''TK_TAM_GIU'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tgiu t 
         WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL 
        SELECT ''TK_TH_HOAN'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_thhoan t
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''TK_TAM_THU'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               t.no_cky AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qlt_so_tdtn_tkhoan_tthu t 
          WHERE t.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
            AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
        UNION ALL 
        SELECT tkhoan, 
               tin,  
               tmt_ma_muc, 
               tmt_ma_tmuc,
               tmt_ma_thue, 
               kyno_tu_ngay AS kythue, 
               0 AS ST_no_cky, 
               no_cky AS SN_no_cky 
          FROM (SELECT a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc,
                       a.tmt_ma_thue, kyno_tu_ngay, SUM (no_cuoi_ky) AS no_cky
                  FROM qlt_so_no a
                 WHERE kyno_tu_ngay =(SELECT max(kyno_tu_ngay) FROM  qlt_so_no)
                   AND (a.tmt_ma_muc=''1000'' or a.tmt_ma_tmuc = ''4268'')
                 GROUP BY a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc, 
                          a.tmt_ma_thue, a.kyno_tu_ngay)
        ) par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin
         GROUP BY par.tai_khoan, par.tin, par.tmt_ma_muc, par.tmt_ma_tmuc, 
                  par.tmt_ma_thue, par.ky_thue
        HAVING ROUND(sum(par.ST_NO_CKY),0)<>sum(par.SN_NO_CKY);

        ext_pck_control_1.Prc_Update_Pbcb(''ext_slech_no'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);            
    END;
    /**************************************************************************/
    PROCEDURE Prc_Qct_Slech_No IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_QCT_SLECH_NO'';
        v_max_upd NUMBER(3);
        v_cqt VARCHAR2(5);
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;
        SELECT NVL(max(update_no),0) INTO v_max_upd FROM ext_slech_no;
        SELECT gia_tri INTO v_gl_cqt FROM qlt_tham_so WHERE ten=''MA_CQT'';        
        UPDATE ext_slech_no SET update_no = v_max_upd+1 
         WHERE loai=''QCT'' AND update_no=0;        
        INSERT INTO ext_slech_no (loai, ky_thue, tin, ten_dtnt, tai_khoan, muc, 
                                  tieumuc, mathue, sothue_no_cky, sono_no_cky, 
                                  clech_no_cky, update_no, ma_slech, 
                                  ma_gdich, ten_gdich, ma_cqt)
        SELECT ''QCT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               ''TK_TAM_GIU'' tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               (par.con_pnop_psinh + par.con_pnop_no) SOTHUE_NO_CKY, 
               to_number(NULL) SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 5 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt
          FROM qct_so_tdtn_tkhoan_tgiu par, qlt_nsd_dtnt nnt
         WHERE par.tin=nnt.tin(+)
           AND par.kylb_tu_ngay =(SELECT max(kyno_tu_ngay) FROM qlt_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
           AND (par.con_pnop_psinh + par.con_pnop_no)<>0
        UNION ALL         
        SELECT ''QCT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 2 ma_slech,
               par.ma_gdich,
               gd.ten,
               v_gl_cqt
          FROM qct_so_no par, qlt_nsd_dtnt nnt, qct_dm_gdich gd
         WHERE par.tin=nnt.tin(+)
           AND par.ma_gdich=gd.ma_gdich(+)         
           AND par.tkhoan=''TK_TAM_GIU'' 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qct_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QCT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 3 ma_slech,
               par.ma_gdich,
               gd.ten,
               v_gl_cqt               
          FROM qct_so_no par, qlt_nsd_dtnt nnt, qct_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.ma_gdich=gd.ma_gdich(+)         
           AND par.han_nop IS NULL 
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qct_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')
        UNION ALL
        SELECT ''QCT'' loai, 
               par.kylb_tu_ngay ky_thue,         
               par.tin, 
               nnt.TEN_DTNT, 
               par.tkhoan tai_khoan,       
               par.tmt_ma_muc, 
               par.tmt_ma_tmuc, 
               par.tmt_ma_thue,  
               to_number(NULL) SOTHUE_NO_CKY, 
               par.no_cuoi_ky SONO_NO_CKY,  
               to_number(NULL) CLECH_NO_CKY,
               0 update_no, 4 ma_slech,
               par.ma_gdich,
               gd.ten,
               v_gl_cqt                
          FROM qct_so_no par, qlt_nsd_dtnt nnt, qct_dm_gdich gd 
         WHERE par.tin=nnt.tin(+)
           AND par.ma_gdich=gd.ma_gdich(+)         
           AND par.kyno_tu_ngay = (SELECT max(kyno_tu_ngay) FROM qct_so_no)
           AND (par.tmt_ma_muc=''1000'' or par.tmt_ma_tmuc = ''4268'')           
           AND NOT EXISTS (SELECT 1 FROM qct_dtnt b WHERE par.tin=b.tin)
        UNION ALL                  
        SELECT ''QCT'' loai, 
               par.ky_thue,                 
               par.tin,
               max(nnt.TEN_DTNT) TEN_DTNT,
               par.tai_khoan, 
               par.tmt_ma_muc AS MUC, 
               par.tmt_ma_tmuc AS TIEUMUC, 
               par.tmt_ma_thue AS MATHUE,  
               ROUND(sum(par.ST_NO_CKY),0) AS SOTHUE_NO_CKY, 
               sum(par.SN_NO_CKY) AS SONO_NO_CKY,  
               ROUND(sum(par.ST_NO_CKY),0)- sum(SN_NO_CKY) AS CLECH_NO_CKY,
               0 update_no, 1 ma_slech,
               NULL ma_gdich,
               NULL ten_gdich,
               v_gl_cqt                                
        FROM
        (
        SELECT ''TK_NGAN_SACH'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               (t.con_pnop_psinh + t.con_pnop_no) AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qct_so_thue t
         WHERE t.kylb_tu_ngay=(SELECT max(kyno_tu_ngay) FROM qct_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
         UNION ALL
        SELECT ''TK_TAM_GIU'' AS tai_khoan, 
               t.tin, 
               t.tmt_ma_muc, 
               t.tmt_ma_tmuc,
               t.tmt_ma_thue, 
               t.kylb_tu_ngay AS ky_thue, 
               (t.con_pnop_psinh + t.con_pnop_no) AS ST_no_cky,  
               0 AS SN_no_cky
          FROM qct_so_tdtn_tkhoan_tgiu t 
         WHERE t.kylb_tu_ngay=(SELECT max(kyno_tu_ngay) FROM qct_so_no)
           AND (t.tmt_ma_muc=''1000'' or t.tmt_ma_tmuc = ''4268'')
         UNION ALL
        SELECT tkhoan, 
               tin,
               tmt_ma_muc,
               tmt_ma_tmuc,
               tmt_ma_thue, 
               kyno_tu_ngay AS kythue, 
               0 AS ST_no_cky, 
               no_cky AS SN_no_cky 
          FROM (SELECT a.tkhoan, a.tin, a.tmt_ma_muc, a.tmt_ma_tmuc,
                       a.tmt_ma_thue, kyno_tu_ngay, SUM (no_cuoi_ky) AS no_cky
                  FROM qct_so_no a
                 WHERE kyno_tu_ngay=(SELECT max(kyno_tu_ngay) FROM qct_so_no)
                   AND (a.tmt_ma_muc=''1000'' or a.tmt_ma_tmuc = ''4268'')
              GROUP BY a.tkhoan,a.tin,a.tmt_ma_muc,a.tmt_ma_tmuc,
                       a.tmt_ma_thue,a.kyno_tu_ngay)
        ) par, qlt_nsd_dtnt nnt
        WHERE par.tin=nnt.tin
        GROUP BY par.tai_khoan, par.tin, par.tmt_ma_muc, par.tmt_ma_tmuc, par.tmt_ma_thue, par.ky_thue
        HAVING sum (par.ST_NO_CKY)<> sum(par.SN_NO_CKY);
        ext_pck_control_1.Prc_Update_Pbcb(''ext_slech_no'');
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;        
        COMMIT;
        EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Finnal(c_pro_name);          
    END;           
    /**************************************************************************/    
    PROCEDURE Prc_Dchinh_No_Qlt IS
        CURSOR c_dc IS
        SELECT * FROM ext_slech_no 
         WHERE loai = ''QLT'' AND update_no=0 AND ma_slech=1 AND da_dchinh IS NULL ;
        v_nguon_goc VARCHAR2(100) := ''?i?u ch?nh N? theo Thu n?p ?? tri?n khai ?ng d?ng QLT_TNCN'';
        v_ghi_chu VARCHAR2(100) := ''?i?u ch?nh d? li?u khi tri?n khai ?ng d?ng QLT_TNCN'';
    BEGIN
        FOR vc_dc IN c_dc LOOP
            INSERT INTO qlt_so_no
                        (ID,KYNO_TU_NGAY,KYNO_DEN_NGAY,HDR_ID,DTL_ID,DGD_MA_GDICH,
                         DGD_KIEU_GDICH,TKHOAN,KYLB_TU_NGAY,KYLB_DEN_NGAY,KYKK_TU_NGAY,
                         KYKK_DEN_NGAY,TIN,MA_CQT,MA_PHONG,MA_CANBO,TMT_MA_MUC,
                         TMT_MA_TMUC,TMT_MA_THUE,NO_DAU_KY,NO_CUOI_KY,HAN_NOP,
                         NGUON_GOC,GHI_CHU,CHECK_KNO)
            VALUES(qlt_sno_seq.NEXTVAL,
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    0,
                    0,
                    ''**'',
                    ''**'',
                    vc_dc.tai_khoan,
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    trunc(vc_dc.ky_thue,''MONTH''),
                    last_day(vc_dc.ky_thue),
                    vc_dc.tin,
                    vc_dc.ma_cqt,
                    vc_dc.ma_pban,
                    vc_dc.ma_cbo,
                    vc_dc.muc,
                    vc_dc.tieumuc,
                    vc_dc.mathue,
                    vc_dc.clech_no_cky,
                    vc_dc.clech_no_cky,
                    last_day(add_months(vc_dc.ky_thue,1)),
                    v_nguon_goc,
                    v_ghi_chu,
                    0);
            UPDATE ext_slech_no SET da_dchinh = ''Y''
            WHERE loai = vc_dc.loai 
                AND tin = vc_dc.tin 
                AND muc = vc_dc.muc 
                AND tieumuc = vc_dc.tieumuc
                AND mathue = vc_dc.mathue
                AND update_no=0;
            COMMIT;                                                
        END LOOP;     
    END;            
    /**************************************************************************/ 
    PROCEDURE Prc_Dchinh_No_Qct IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_DCHINH_NO_QCT'';
        CURSOR c_dc IS
        SELECT * FROM ext_slech_no 
         WHERE loai = ''QCT'' AND update_no=0 AND ma_slech=1 AND da_dchinh IS NULL;
        v_nguon_goc VARCHAR2(100) := ''?i?u ch?nh N? theo Thu n?p ?? tri?n khai ?ng d?ng QLT_TNCN'';
        v_ghi_chu VARCHAR2(100) := ''?i?u ch?nh d? li?u khi tri?n khai ?ng d?ng QLT_TNCN'';
    BEGIN
        FOR vc_dc IN c_dc LOOP
            INSERT INTO qct_so_no
                        (ID,KYNO_TU_NGAY,KYNO_DEN_NGAY,HDR_ID,DTL_ID,MA_GDICH,
                         TKHOAN,KYLB_TU_NGAY,KYLB_DEN_NGAY,KY_THUE_TU_NGAY,
                         KY_THUE_DEN_NGAY,TIN,TMT_MA_MUC,TMT_MA_TMUC,TMT_MA_THUE,
                         NO_CUOI_KY,HAN_NOP,NGUON_GOC,GHI_CHU,CHECK_KNO)
            VALUES(qlt_sno_seq.NEXTVAL,
                   vc_dc.ky_thue,
                   last_day(vc_dc.ky_thue),
                   0,
                   0,
                   ''**'',
                   vc_dc.tai_khoan,
                   trunc(vc_dc.ky_thue,''MONTH''),
                   last_day(vc_dc.ky_thue),
                   trunc(vc_dc.ky_thue,''MONTH''),
                   last_day(vc_dc.ky_thue),
                   vc_dc.tin,
                   vc_dc.muc,
                   vc_dc.tieumuc,
                   vc_dc.mathue,
                   vc_dc.clech_no_cky,
                   last_day(add_months(vc_dc.ky_thue,1)),
                   v_nguon_goc,
                   v_ghi_chu,
                   0);
            UPDATE ext_slech_no SET da_dchinh = ''Y''
            WHERE loai = vc_dc.loai 
                AND tin = vc_dc.tin 
                AND muc = vc_dc.muc 
                AND tieumuc = vc_dc.tieumuc
                AND mathue = vc_dc.mathue
                AND update_no=0;    
            COMMIT;                                            
        END LOOP;      
    END;     
END;');

    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_5 IS
    PROCEDURE Prc_Ttoan_Qlt(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Run_Qlt(p_chot DATE);
END;');

    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_5
IS
    PROCEDURE Prc_Ttoan_Qlt(p_Ky_Dchinh DATE) IS
        CURSOR  c_Sno IS
        SELECT dtnt.tin, dtnt.ten_dtnt, dtnt.dia_chi, dtnt.ma_tinh, dtnt.ma_huyen,
               dtnt.ma_cqt, dtnt.ma_phong, dtnt.ma_canbo, dtnt.ma_cap, dtnt.ma_chuong,
               dtnt.ma_loai, dtnt.ma_khoan,
               NVL (kykk_tu_ngay, kylb_tu_ngay) kykk_tu_ngay,
               NVL (kykk_den_ngay, kylb_den_ngay) kykk_den_ngay, han_nop,
               DECODE (tkhoan, ''TK_NGAN_SACH'', ''1'', ''TK_TAM_GIU'', ''3'', ''4'') tkhoan,
               tmt_ma_muc, tmt_ma_tmuc, tmt_ma_thue, no_cuoi_ky
          FROM qlt_so_no sn, qlt_nsd_dtnt dtnt
         WHERE sn.tin = dtnt.tin
           AND kyno_tu_ngay = p_ky_dchinh
           AND (tmt_ma_muc = ''1000'' OR tmt_ma_tmuc = ''4268'')
           AND no_cuoi_ky <> 0;
        
        CURSOR c_ky_tkhai IS  
        SELECT Add_Months(Trunc(p_Ky_Dchinh,''MONTH''),1) FROM dual;
                    
        v_Id                NUMBER;    
        v_Ky_Dchinh         DATE ; 
        -- Thong tin header cua phieu dieu chinh :
        v_So_Qdinh          VARCHAR2(20)  := NULL;
        v_Ly_Do             VARCHAR2(200) := ''T?t to?n thu? TNCN'';    
        v_Ndung_Dchinh      VARCHAR2(200) := ''?i?u ch?nh thu? TNCN'';  
        v_Anh_Huong         VARCHAR2(200) := NULL; 
        v_Nguoi_Cap_Nhat    VARCHAR2(60) := ''Pit_Converter'';
        v_Nguoi_Lap         VARCHAR2(60)  := ''Pit_Converter''; 
        v_Nguoi_Duyet       VARCHAR2(60)  := ''Pit_Converter''; 
        v_Cq_Ra_Qdinh       VARCHAR2(60)  := NULL;   
        v_Ngay_Dnghi        DATE := Trunc(Sysdate,''Month'');    
    BEGIN
        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_Ky_Dchinh;
        CLOSE c_ky_tkhai;
        
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        FOR vc_Sno  IN  c_Sno LOOP
            -- Gan tham so
            IF vc_Sno.Tkhoan = ''1'' THEN
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''1'',''DC'');
            ELSIF vc_Sno.Tkhoan = ''3'' THEN
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''5'',''DC'');
            ELSE
                Qlt_Pck_Gdich.Prc_Lay_Thamso_Khac(''6'',''DC'');
            END IF;
            Qlt_Pck_Control.Prc_Gan_Tin(vc_Sno.Tin);
            -- Insert header
            SELECT Qlt_Xltk_Hdr_Seq.NEXTVAL INTO v_Id FROM Dual;
            INSERT INTO qlt_ds_ttin_khac_hdr
                        (ID, loai_ttin, tin, ten_dtnt, cqt_ma_cqt,
                         hun_ma_tinh, hun_ma_huyen, dia_chi,
                         ma_canbo, ma_phong, so_qd, ngay_qd,
                         cq_ra_qd, kylb_den_ngay, kylb_tu_ngay,
                         kykk_tu_ngay, kykk_den_ngay, ly_do, ngay_cap_nhat,
                         nguoi_cap_nhat, tkhoan, ndung_dchinh, anh_huong,
                         ngay_dnghi, nguoi_lap, nguoi_duyet, ma_ldo)
                 VALUES (v_id, ''4'', vc_sno.tin, vc_sno.ten_dtnt, vc_sno.ma_cqt,
                         vc_sno.ma_tinh, vc_sno.ma_huyen, vc_sno.dia_chi,
                         vc_sno.ma_canbo, vc_sno.ma_phong, v_so_qdinh, vc_sno.han_nop,
                         v_cq_ra_qdinh, LAST_DAY (v_ky_dchinh), v_ky_dchinh,
                         vc_sno.kykk_tu_ngay, vc_sno.kykk_den_ngay, v_ly_do, SYSDATE,
                         v_nguoi_cap_nhat, vc_sno.tkhoan, v_ndung_dchinh, v_anh_huong,
                         v_ngay_dnghi, v_nguoi_lap, v_nguoi_duyet, ''99'');
                        -- Insert Detail
            INSERT INTO qlt_ds_ttin_khac_dtl
                        (ID, tkr_id, ccg_ma_cap, ccg_ma_chuong,
                         lkn_ma_loai, lkn_ma_khoan, tmt_ma_muc,
                         tmt_ma_tmuc, tmt_ma_thue,
                         so_tien, ngay_nhap)
                 VALUES (qlt_xltk_dtl_seq.NEXTVAL, v_id, vc_sno.ma_cap, vc_sno.ma_chuong,
                         vc_sno.ma_loai, vc_sno.ma_khoan, vc_sno.tmt_ma_muc,
                         vc_sno.tmt_ma_tmuc, vc_sno.tmt_ma_thue,
                         (-1) * vc_sno.no_cuoi_ky, SYSDATE);
            Qlt_Pck_Control.Prc_Reset_Log_Id;                                        
        END LOOP;
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;        
    END;
    /**************************************************************************/
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE) IS
        CURSOR c_ky_tkhai IS
        SELECT Last_Day(Add_Months(p_Ky_Dchinh,-1)) FROM dual;
        v_ky_tkhai DATE;    
    BEGIN
        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_ky_tkhai;
        CLOSE c_ky_tkhai;    
        
        UPDATE qlt_dm_tkhai_hluc
           SET hluc_den_ngay = LAST_DAY (p_ky_dchinh)
         WHERE dtk_ma IN
                  (''19'', ''20'', ''21'', ''29'', ''30'', ''54'', ''55'', ''56'', ''57'', ''58'', ''60'',''65'')
           AND hluc_den_ngay IS NULL;
        
        UPDATE qlt_dm_qtoan_hluc
           SET hluc_den_ngay = LAST_DAY (p_ky_dchinh)
         WHERE dqt_ma IN (''06'', ''07'', ''12'', ''13'', ''14'', ''15'', ''16'')
           AND hluc_den_ngay IS NULL;
        
        UPDATE qlt_mucthu
           SET ngay_hl_den = LAST_DAY (p_ky_dchinh)
         WHERE (ma_muc = ''1000'' OR ma_tmuc = ''4268'')
           AND (ngay_hl_den IS NULL OR ngay_hl_den >= LAST_DAY (p_ky_dchinh));
        
        UPDATE qlt_thue_mthu
           SET ngay_hl_den = v_ky_tkhai
         WHERE (ma_muc = ''1000'' OR ma_tmuc = ''4268'')
           AND (ngay_hl_den IS NULL OR ngay_hl_den >= LAST_DAY (p_ky_dchinh));
                        
    END;
    /**************************************************************************/
    PROCEDURE Prc_Run_Qlt(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_RUN_QLT'';        
    BEGIN
        Prc_Ttoan_Qlt(p_chot);
        Prc_Dmuc_Hluc(p_chot);
        EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);
        COMMIT;        
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);    
    END;        
END;');
    
    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE ext_pck_control_6 IS
    PROCEDURE Prc_Ttoan_Qct(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE);
    PROCEDURE Prc_Run_Qct(p_chot DATE);
END;    
    ');        

    prc_remote_sql('
CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_6
IS
    PROCEDURE Prc_Ttoan_Qct(p_Ky_Dchinh DATE) IS
        CURSOR  c_Sno IS
        SELECT db.tin, dtnt.ten_dtnt, dtnt.dia_chi, dtnt.ma_canbo ma_can_bo,
               dtnt.ma_phong, db.ddb_ma,
               NVL (sn.ky_thue_tu_ngay, sn.kylb_tu_ngay) kykk_tu_ngay,
               NVL (sn.ky_thue_den_ngay, sn.kylb_den_ngay) kykk_den_ngay, dtnt.ma_cap,
               dtnt.ma_chuong, dtnt.ma_loai, dtnt.ma_khoan, sn.tmt_ma_muc,
               sn.tmt_ma_tmuc, sn.tmt_ma_thue,
               DECODE (sn.tkhoan, ''TK_NGAN_SACH'', ''01'', ''02'') tkhoan, sn.han_nop,
               sn.no_cuoi_ky
          FROM qct_so_no sn, qct_dtnt db, qlt_nsd_dtnt dtnt
         WHERE sn.tin = db.tin
           AND dtnt.tin = db.tin
           AND sn.kyno_tu_ngay = p_ky_dchinh
           AND (sn.tmt_ma_muc = ''1000'' OR sn.tmt_ma_tmuc = ''4268'')
           AND sn.no_cuoi_ky <> 0;
                
        CURSOR c_ky_tkhai IS  
        SELECT Add_Months(Trunc(p_Ky_Dchinh,''MONTH''),1) FROM dual;

        v_Hdr_Id        NUMBER;        
        v_Cq_Ra_Qd      VARCHAR2(60);
        v_Ky_Dchinh     DATE ;
        v_Ly_Do         VARCHAR2(200) := ''T?t to?n thu? TNCN'';
        v_Nguoi_Nhap    VARCHAR2(60) := ''Pit_Converter'';
        v_Ndung_Dchinh  VARCHAR2(200) := ''?i?u ch?nh thu? TNCN'';
        v_Anh_Huong     VARCHAR2(300);
        v_Ngay_Dnghi    DATE;
        v_Nguoi_Lap     VARCHAR2(60) := ''Pit_Converter'';
        v_Nguoi_Duyet   VARCHAR2(60) := ''Pit_Converter'';          
    BEGIN
        qlt_pck_thop_no_thue.prc_load_dsach_dtnt;

        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_Ky_Dchinh;
        CLOSE c_ky_tkhai;
         
        FOR vc_Sno IN c_Sno LOOP
            Qlt_Pck_Control.Prc_Gan_Tin(vc_Sno.Tin);
            SELECT Qct_Cctt_Hdr_Seq.NEXTVAL INTO v_Hdr_Id FROM Dual;
            IF vc_Sno.Tkhoan = ''02'' THEN
                Qct_Pck_GDich.Prc_Gan_GDich(v_Hdr_Id,''DCHINH'',''02'');    
            ELSE
                Qct_Pck_GDich.Prc_Gan_GDich(v_Hdr_Id,''DCHINH'',''01'');    
            END IF;
            -- Insert dieu chinh
            INSERT INTO qct_ds_dchinh_hdr
                        (ID, tin, ten_dtnt, dia_chi,
                         ma_canbo, ma_phong, cq_ra_qd, kylb_tu_ngay,
                         kylb_den_ngay, ly_do, ngay_nhap, nguoi_nhap,
                         ndung_dchinh, anh_huong, ngay_dnghi, nguoi_lap,
                         nguoi_duyet, kykk_tu_ngay, kykk_den_ngay,
                         ddb_ma, han_nop, ma_ldo, tkhoan)
                 VALUES (v_hdr_id, vc_sno.tin, vc_sno.ten_dtnt, vc_sno.dia_chi,
                         vc_sno.ma_can_bo, vc_sno.ma_phong, v_cq_ra_qd, v_ky_dchinh,
                         LAST_DAY (v_ky_dchinh), v_ly_do, SYSDATE, v_nguoi_nhap,
                         v_ndung_dchinh, v_anh_huong, v_ngay_dnghi, v_nguoi_lap,
                         v_nguoi_duyet, vc_sno.kykk_tu_ngay, vc_sno.kykk_den_ngay,
                         vc_sno.ddb_ma, vc_sno.han_nop, ''99'', vc_sno.tkhoan);
            
            INSERT INTO qct_ds_dchinh_dtl
                        (ID, hdr_id, ccg_ma_cap,
                         ccg_ma_chuong, lkn_ma_loai, lkn_ma_khoan,
                         tmt_ma_muc, tmt_ma_tmuc, tmt_ma_thue,
                         so_tien, ngay_nhap)
                 VALUES (qct_cctt_dtl_seq.NEXTVAL, v_hdr_id, vc_sno.ma_cap,
                         vc_sno.ma_chuong, vc_sno.ma_loai, vc_sno.ma_khoan,
                         vc_sno.tmt_ma_muc, vc_sno.tmt_ma_tmuc, vc_sno.tmt_ma_thue,
                         (-1) * vc_sno.no_cuoi_ky, SYSDATE);                                                                              
            Qct_Pck_GDich.Prc_Tao_GDich;
            Qct_Pck_GDich.Prc_Reset_GDich;
        END LOOP;        
        qlt_pck_thop_no_thue.prc_unload_dsach_dtnt;    
    END;
    /**************************************************************************/
    PROCEDURE Prc_Dmuc_Hluc(p_Ky_Dchinh DATE) IS
        CURSOR c_ky_tkhai IS
        SELECT Last_Day(Add_Months(p_Ky_Dchinh,-1)) 
        FROM dual;
        v_ky_tkhai DATE;
    BEGIN
        OPEN c_ky_tkhai;
        FETCH c_ky_tkhai INTO v_ky_tkhai;
        CLOSE c_ky_tkhai;
         
        UPDATE qct_dtnt_tkhai_pnop
        SET ky_kthuc =v_ky_tkhai
        WHERE dcc_ma IN (''24'',''25'',''26'',''27'',''28'')
        AND (ky_kthuc IS NULL OR ky_kthuc >v_ky_tkhai);                           
    END;
    /**************************************************************************/
    PROCEDURE Prc_Run_Qct(p_chot DATE) IS
        c_pro_name CONSTANT VARCHAR2(30) := ''PRC_RUN_QCT'';        
    BEGIN
        Prc_Ttoan_Qct(p_chot);
        Prc_Dmuc_Hluc(p_chot);
        EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);
        COMMIT;        
        EXCEPTION WHEN others THEN EXT_PCK_CONTROL.Prc_Ins_Log(c_pro_name);    
    END;        
END;');
    
    prc_remote_sql('CREATE OR REPLACE 
PACKAGE ext_pck_control_8 IS
    PROCEDURE Prc_DoiChieu(p_chot DATE);
END;');
    
    prc_remote_sql('CREATE OR REPLACE 
PACKAGE BODY ext_pck_control_8
IS
    /**************************************************************************/
    PROCEDURE Prc_DoiChieu(p_chot DATE) IS
        v_nsd number(5);
    BEGIN
    -- cac tham so thay doi
    -- *************************************************************************
    select ma_nsd into v_nsd from bmt_nsd where TEN_NSD=''DCPIT'';
    -- *************************************************************************

    qlt_pck_control.prc_load_tin(v_nsd,true,true);
    qlt_pck_control.prc_load_tin(v_nsd,false,true);

    --NO_QLT -----------------------------------------------------------------------
    qlt_pck_in_so_v158.prc_danhsach_no_thop(last_day(p_chot)
                                                    , To_Date(''31/12/9999'',''DD/MM/RRRR'')
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , ''1000''
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null);
    qlt_pck_in_so_v158.prc_danhsach_no_thop(last_day(p_chot)
                                                    , To_Date(''31/12/9999'',''DD/MM/RRRR'')
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , ''4268''
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null
                                                    , null);
    --PS_QCT -----------------------------------------------------------------------
        delete from EXT_TEMP_PARA;
        insert into EXT_TEMP_PARA(id, name, val_date) values(1,''KYKK_TU'', ''1-jan-2011'');
        --insert into EXT_TEMP_PARA(id, name, val_date) values(1,''KYKK_DEN'', last_day(p_chot));
        insert into EXT_TEMP_PARA(id, name, val_date) values(1,''KYLB_DEN'', last_day(p_chot));
    --NO_QCT -----------------------------------------------------------------------
    QCT_PCK_IN_SO_V106.PRC_SO_NO_THOP (trunc(p_chot,''MONTH''), --:P_KYLB_TU_NGAY
                                    To_Date(''31/12/9999'',''DD/MM/RRRR''),    --:P_NO_DEN_HET_NGAY
                                    null,  --:P_TIN,
                                    null,  --:P_MA_PHONG,
                                    null,  --:P_MA_CANBO,
                                    null,  --:P_MA_DBAN,
                                    null,  --:P_MA_NGANH,
                                    null,  --:P_CTIEU1,
                                    null,  --:P_CTIEU2,
                                    null,  --:P_CTIEU3,
                                    null,  --:P_CTIEU4,
                                    null,  --:P_CTIEU5,
                                    ''1000'',--:P_MUC,
                                    null,  --:P_TMUC,
                                    null); --:P_TKHOAN
    QCT_PCK_IN_SO_V106.PRC_SO_NO_THOP(trunc(p_chot,''MONTH''),   --:P_KYLB_TU_NGAY
                                    To_Date(''31/12/9999'',''DD/MM/RRRR''),     --:P_NO_DEN_HET_NGAY
                                    null,  --:P_TIN,
                                    null,  --:P_MA_PHONG,
                                    null,  --:P_MA_CANBO,
                                    null,  --:P_MA_DBAN,
                                    null,  --:P_MA_NGANH,
                                    null,  --:P_CTIEU1,
                                    null,  --:P_CTIEU2,
                                    null,  --:P_CTIEU3,
                                    null,  --:P_CTIEU4,
                                    null,  --:P_CTIEU5,
                                    null,  --:P_MUC,
                                    ''4268'',--:P_TMUC,
                                    null); --:P_TKHOAN
    DELETE FROM EXT_TEMP_DCHIEU;

    INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, v_char3, loai)
    SELECT mau, ma_tmuc, so_no, so_thua, ''NO'' loai
        FROM
        (
        SELECT ALL ''QLT-APP'' mau
            , MA_TMUC
            , trim(to_char(Sum(Decode(Abs(SO_NO) , SO_NO ,ROUND(SO_NO),-SO_NO ,0)),''999,999,999,999,999'')) SO_NO
            , ''-''||trim(to_char(Sum(Decode(Abs(SO_NO) ,-SO_NO ,ROUND(-SO_NO), SO_NO ,0)),''999,999,999,999,999'')) SO_THUA
        FROM QLT_DANHSACH_NO
        WHERE  Round(Abs(SO_NO))>=1 and tkhoan=(select gia_tri from qlt_tham_so where ten=''TK_NGAN_SACH'')
        GROUP BY MA_MUC, MA_TMUC
        union all
        Select ALL ''QCT-APP'' mau, MA_TMUC  MA_TMUC
            , trim(to_char(Sum(Decode (Abs (so_no), so_no, Round (so_no), -so_no, Null)),''999,999,999,999,999'')) so_no
         ,''-''||trim(to_char(Sum(Decode (Abs (so_no), -so_no, Round (-so_no), so_no, Null)),''999,999,999,999,999'')) so_thua
        From qct_so_no_thop
        where TKHOAN=''TK_NGAN_SACH''
        Group By TKHOAN,MA_MUC, MA_TMUC
        );
    INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, loai)
    select mau, loai_tkhai, so_tien, ''PS'' loai
        from
        (
        select ''QLT-APP'' Mau, loai_tkhai, trim(to_char(sum(thue),''999,999,999,999,999'')) so_tien
        from (
        select  tkh.id
                , decode(tkh.dtk_ma_loai_tkhai, ''29'', ''02T/KK-TNCN''
                                              , ''30'', ''02Q/KK-TNCN''
                                              , ''21'', ''03T/KK-TNCN''
                                              , ''60'', ''03Q/KK-TNCN''
                                              , ''19'', ''07/KK-TNCN'') loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai in(''29'',''30'', ''21'', ''60'',''19''))
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'')
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a
                                                       where a.id=tkh.id
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)
        union all
        select  tkh.id
                , ''01/KK-XS'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'')
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
                AND (dtnt.ma_loai=''550'')
                AND (dtnt.ma_khoan=''558'')
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a
                                                       where a.id=tkh.id
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)
        union all
        select  tkh.id
                , ''01/KK-BH'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'')
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''038'', ''173''))
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a
                                                       where a.id=tkh.id
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)
        union all
        select  tkh.id
                , ''08/KK-TNCN'' loai_tkhai
                , tkh.tin
                , tkh.kylb_tu_ngay
                , tkh.kylb_den_ngay
                , tkh.kykk_tu_ngay
                , tkh.kykk_den_ngay
                , pst.tmt_ma_muc
                , pst.tmt_ma_tmuc
                , nvl(pst.thue_psinh,0) thue
        from    qlt_tkhai_hdr tkh
              , qlt_psinh_tkhai pst
              , qlt_nsd_dtnt dtnt
              , qlt_dm_tkhai_hluc hluc
        where   (pst.tkh_id (+) = tkh.id)
                and tkh.tin = dtnt.tin
                and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                and (pst.tkh_ltd (+) = tkh.ltd)
                and (tkh.dtk_ma_loai_tkhai =''12'')
                and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'')
                and tkh.kylb_den_ngay<=last_day(p_chot)
                and pst.tmt_ma_muc=''1000''
                and pst.tmt_ma_tmuc=''1003''
                AND (dtnt.ma_chuong IN (''557'', ''757'', ''857''))
                and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a
                                                       where a.id=tkh.id
                                                         and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                         and a.kykk_den_ngay=tkh.kykk_den_ngay
                                                         and a.kylb_den_ngay<=last_day(p_chot) group by a.id)
        ) group by loai_tkhai
        union all
        select ''QCT-APP'' Mau, decode(ma_tkhai, ''24'', ''08/KK-TNCN''
                              , ''25'', ''08A/KK-TNCN''
                              , ''30'', ''08/KK-TNCNPS''
                              , ''31'', ''08A/KK-TNCNPS''
                              , ''ZZ'') loai_tkhai,
                so_tien
        from (
        select ma_tkhai, trim(to_char(sum(thue_psinh),''999,999,999,999,999'')) so_tien
          from ext_v_dchieu_qct_q where ma_tkhai not in (''26'',''27'') group by ma_tkhai
        )
        );
        
        INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, loai)
        select ''QCT-APP'' mau, decode(ma_tkhai, ''26'', ''10/KK-TNCN''
                              , ''27'', ''10A/KK-TNCN''
                              , ''ZZ'') loai_tkhai, so_tien, ''PS'' loai
        from (
        select ma_tkhai, trim(to_char(sum(thue_psinh),''999,999,999,999,999'')) so_tien
          from ext_v_dchieu_qct_q where ma_tkhai in (''26'',''27'') and KYKK_DEN_NGAY<=''31-dec-2011'' group by ma_tkhai        
        );
        
        INSERT INTO EXT_TEMP_DCHIEU(mau, v_char1, v_char2, loai)
        select ''QCT-APP'' mau, ''10/KK-TNCN'' loai_tkhai, so_tien, ''TK'' loai
        from (
        select ma_tkhai, trim(to_char(sum(thue_psinh),''999,999,999,999,999'')) so_tien
          from ext_v_dchieu_qct_q where ma_tkhai=''26'' and KYKK_TU_NGAY>=''1-jan-2012'' group by ma_tkhai        
        );
        
    COMMIT;
    END;
END;');    
    /* END PRC_KTAO_PCK_QCT*/    
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Pck_Qct
    Noi dung: Don dep EXT_PCK_CONTROL cho QCT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_Pck_Qct IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_PCK_CONTROL';
        CURSOR c IS
        SELECT object_name FROM user_objects@qlt WHERE object_type = 'PACKAGE'
                                         AND object_name IN ('EXT_PCK_CONTROL_3',
                                                             'EXT_PCK_CONTROL',
                                                             'EXT_PCK_CONTROL_1',
                                                             'EXT_PCK_CONTROL_2',
                                                             'EXT_PCK_CONTROL_4');
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP PACKAGE '||v.object_name);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_errors
    Noi dung: Don dep bang ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_errors IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_ERRORS';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_errors
    Noi dung: Don dep ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_errors IS
    BEGIN
        Prc_Ddep_tb_ext_errors;

        prc_remote_sql(
        'CREATE TABLE ext_errors (
        seq_number   NUMBER,
        timestamp    DATE,
        error_stack  VARCHAR2(2000),
        pck          VARCHAR2(50),
        status       VARCHAR2(1),
        ltd          NUMBER(5,0) DEFAULT 0,
        call_stack   VARCHAR2(2000)
        )');

        prc_remote_sql(
        'ALTER TABLE ext_errors
        ADD CONSTRAINT ext_pk_errors
        PRIMARY KEY (seq_number)
        USING INDEX');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Qlt
    Noi dung: Khoi tao moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_Qlt(p_short_name VARCHAR2) IS
    BEGIN
        PCK_MOI_TRUONG.prc_Ktao_seq;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_ps;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_no;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_ps;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_no;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_tk;        
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_slech_no;
        PCK_MOI_TRUONG.prc_ktao_tb_ext_errors;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_temp_dchieu;        
        PCK_MOI_TRUONG.Prc_Ktao_vw_qlt_dchieu_ps;
        PCK_MOI_TRUONG.Prc_Ktao_vw_qlt_dchieu_no;
        PCK_MOI_TRUONG.Prc_Ktao_Pck_Qlt;

    END;

    /***************************************************************************
    PCK_MOI_TRUONG.PRC_KTAO
    Noi dung: Khoi tao moi truong
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 23/11/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao(p_short_name VARCHAR2) IS
        CURSOR c IS
        SELECT tax_model FROM tb_lst_taxo WHERE short_name=p_short_name;
    BEGIN

        EXECUTE IMMEDIATE
            'ALTER SESSION SET remote_dependencies_mode = ''SIGNATURE''';

        -- Chay thu tuc khoi tao moi truong
        FOR v IN c LOOP
            EXECUTE IMMEDIATE
            'CALL PCK_MOI_TRUONG.Prc_Ktao_'||v.tax_model||'('''||userenv('client_info')||''')';
        END LOOP;

        -- Cap nhat trang thai CQT
        UPDATE tb_lst_taxo SET status=1 WHERE short_name=p_short_name;

        -- Xac nhan cap nhat
        COMMIT;

        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Qlt
    Noi dung: Don dep moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_Qlt(p_short_name VARCHAR2) IS
    BEGIN
        PCK_MOI_TRUONG.Prc_Ddep_Pck_Qlt;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qlt_ps;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qlt_no;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_ps;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_no;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_tk;
        PCK_MOI_TRUONG.prc_Ddep_tb_ext_errors;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_slech_no;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_temp_dchieu;
        PCK_MOI_TRUONG.prc_Ddep_seq;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep
    Noi dung: Don dep moi truong
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 23/11/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep(p_short_name VARCHAR2) IS
        CURSOR c IS
        SELECT tax_model FROM tb_lst_taxo WHERE short_name=p_short_name;
    BEGIN
        EXECUTE IMMEDIATE
            'ALTER SESSION SET remote_dependencies_mode = ''SIGNATURE''';

        -- Cap nhat trang thai CQT
        UPDATE tb_lst_taxo SET status=99 
         WHERE short_name=p_short_name AND tax_model <> 'VAT';

        -- Chay thu tuc don dep moi truong
        FOR v IN c LOOP
            IF v.tax_model<>'VAT' THEN
                EXECUTE IMMEDIATE
                'BEGIN 
                    PCK_MOI_TRUONG.Prc_Ddep_'||v.tax_model||'('''||userenv('client_info')||''');
                 END;';
            END IF;
        END LOOP;         
                  
        -- Xoa log
        DELETE FROM tb_log_pck WHERE short_name=p_short_name;
        DELETE FROM tb_errors WHERE short_name=p_short_name;
        DELETE FROM tb_data_error WHERE short_name=p_short_name;

        -- Xac nhan cap nhat
        COMMIT;

        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    END;
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_Qct
    Noi dung: Khoi tao moi truong cho QCT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_Qct(p_short_name VARCHAR2) IS
    BEGIN
        PCK_MOI_TRUONG.prc_Ktao_seq;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_ps;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qlt_no;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_ps;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_no;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_tk;        
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_slech_no;
        PCK_MOI_TRUONG.prc_ktao_tb_ext_errors;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_temp_dchieu;
        PCK_MOI_TRUONG.Prc_Ktao_vw_qct_dchieu_ps;
        PCK_MOI_TRUONG.Prc_Ktao_vw_qct_dchieu_no;        
        PCK_MOI_TRUONG.Prc_Ktao_Pck_Qct;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_Qct
    Noi dung: Don dep moi truong cho QLT
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 29/09/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_Qct(p_short_name VARCHAR2) IS
    BEGIN
        PCK_MOI_TRUONG.Prc_Ddep_Pck_Qlt;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qlt_ps;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qlt_no;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_ps;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_no;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_tk;
        PCK_MOI_TRUONG.prc_ddep_tb_ext_errors;
        PCK_MOI_TRUONG.Prc_Ddep_tb_ext_slech_no;
        PCK_MOI_TRUONG.Prc_Ktao_tb_ext_temp_dchieu;        
        PCK_MOI_TRUONG.prc_Ddep_seq;        
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Set_glView(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 15/09/2011
    Noi dung: SET short_name toan cuc cho phien lam viec
    ***************************************************************************/
    PROCEDURE Prc_Set_glView(p_short_name VARCHAR2) IS
        v_temp VARCHAR2(3);
    BEGIN
        dbms_application_info.set_client_info(p_short_name);
        -- Ghi log
        --PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Get_Errors(p_short_name)
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 30/09/2011
    Noi dung: lay thong tin tu TABLE ext_errors
    ***************************************************************************/
    PROCEDURE Prc_Get_Errors(p_short_name VARCHAR2) IS
    BEGIN
        DELETE FROM tb_errors WHERE short_name=p_short_name;
        EXECUTE IMMEDIATE '
        INSERT INTO tb_errors(seq_number, short_name, timestamp,
                                  error_stack, call_stack, pck, status)
        SELECT SEQ_ID_LOG_PCK.NEXTVAL, '''||p_short_name||''', timestamp, error_stack, call_stack,
               pck, status
          FROM ext_errors@QLT_'||p_short_name||'
         WHERE ltd=0';
        COMMIT;

        -- Ghi log
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_no
    Noi dung: Khoi tao bang ext_qct_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_qct_no IS
    BEGIN
        Prc_Ddep_tb_ext_qct_no;

        prc_remote_sql('CREATE TABLE ext_qct_no
                        (
                        id                             NUMBER(10,0),
                        kyno_tu_ngay                   DATE,
                        kyno_den_ngay                  DATE,
                        hdr_id                         NUMBER(10,0),
                        dtl_id                         NUMBER(10,0),
                        ma_gdich                       VARCHAR2(3),
                        btm_ma                         VARCHAR2(2),
                        so_the                         NUMBER(3,0),
                        kylb_tu_ngay                   DATE,
                        kylb_den_ngay                  DATE,
                        ky_thue_tu_ngay                DATE,
                        ky_thue_den_ngay               DATE,
                        ky_ttoan_tu_ngay               DATE,
                        ky_ttoan_den_ngay              DATE,
                        tin                            VARCHAR2(14),
                        tmt_ma_muc                     VARCHAR2(4),
                        tmt_ma_tmuc                    VARCHAR2(4),
                        tmt_ma_thue                    VARCHAR2(2),
                        no_cuoi_ky                     NUMBER(20,0),
                        han_nop                        DATE,
                        nguon_goc                      VARCHAR2(200),
                        ghi_chu                        VARCHAR2(100),
                        tkhoan                         VARCHAR2(30),
                        check_kno                      VARCHAR2(1),
                        qdinh_id                       NUMBER(20,0),
                        loai_qdinh                     VARCHAR2(2),
                        status                         VARCHAR2(25) DEFAULT 2,
                        ma_chuong                      VARCHAR2(3),
                        ma_khoan                       VARCHAR2(3),
                        ket_xuat                       NUMBER(1,0) DEFAULT 0,
                        ma_cap                         VARCHAR2(1),
                        ma_loai                        VARCHAR2(3),
                        ma_tinh                        VARCHAR2(3),
                        ma_huyen                       VARCHAR2(5),
                        ten_dtnt                       VARCHAR2(100),
                        dia_chi                        VARCHAR2(100),
                        ma_cbo                         VARCHAR2(15),
                        ten_cbo                        VARCHAR2(150),
                        ma_pban                        VARCHAR2(15),
                        ten_pban                       VARCHAR2(250))');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_no
    Noi dung: Don dep bang ext_qct_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_qct_no IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_QCT_NO';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_ps
    Noi dung: Khoi tao bang ext_qct_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_qct_ps IS
    BEGIN
        Prc_Ddep_tb_ext_qct_ps;

        prc_remote_sql('CREATE TABLE ext_qct_ps
                        (id                            NUMBER(10,0) NOT NULL,
                        tin                            VARCHAR2(14),
                        ma_chuong                      VARCHAR2(3),
                        ma_khoan                       VARCHAR2(3),
                        ma_tmuc                        VARCHAR2(4),
                        so_tien                        NUMBER(20,2),
                        ghi_chu                        VARCHAR2(100),
                        ket_xuat                       NUMBER(1,0) DEFAULT 0,
                        ngay_nop                       DATE,
                        ma_tkhai                       VARCHAR2(2),
                        ky_psinh_tu                    DATE,
                        ky_psinh_den                   DATE,
                        loai_dlieu                     VARCHAR2(1),
                        han_nop                        DATE,
                        ngay_htoan                     DATE,
                        ma_cbo                         VARCHAR2(15),
                        ten_cbo                        VARCHAR2(150),
                        ma_pban                        VARCHAR2(15),
                        ten_pban                       VARCHAR2(250))');
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_ps
    Noi dung: Don dep bang ext_qct_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_qct_ps IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_QCT_PS';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_qct_tk
    Noi dung: Khoi tao bang ext_qct_tk
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_qct_tk IS
    BEGIN
        Prc_Ddep_tb_ext_qct_tk;

        prc_remote_sql('CREATE TABLE ext_qct_tk
                        (tin                           VARCHAR2(14) NOT NULL,
                        kykk_tu_ngay                   DATE NOT NULL,
                        kykk_den_ngay                  DATE NOT NULL,
                        kylb_tu_ngay                   DATE,
                        dthu_dkien                     NUMBER(15,0),
                        tl_thnhap_dkien                NUMBER(15,0),
                        thnhap_cthue_dkien             NUMBER(15,0),
                        gtru_gcanh                     NUMBER(15,0),
                        ban_than                       NUMBER(15,0),
                        phu_thuoc                      NUMBER(15,0),
                        thnhap_tthue_dkien             NUMBER(15,0),
                        tncn                           NUMBER(15,0),
                        ma_dlt                         VARCHAR2(14),
                        ngay_hdong_dlt                 DATE,
                        pb01                           NUMBER(15,0),
                        kytt01                         VARCHAR2(4),
                        ht01                           DATE,
                        hn01                           DATE,
                        pb02                           NUMBER(15,0),
                        kytt02                         VARCHAR2(4),
                        ht02                           DATE,
                        hn02                           DATE,
                        pb03                           NUMBER(15,0),
                        kytt03                         VARCHAR2(4),
                        ht03                           DATE,
                        hn03                           DATE,
                        pb04                           NUMBER(15,0),
                        kytt04                         VARCHAR2(4),
                        ht04                           DATE,
                        hn04                           DATE,
                        ma_cbo                         VARCHAR2(15),
                        ten_cbo                        VARCHAR2(150),
                        ma_pban                        VARCHAR2(15),
                        ten_pban                       VARCHAR2(250),
                        hdr_id                         NUMBER(10,0))');
        
        prc_remote_sql('CREATE UNIQUE INDEX ind_ext_tk_hid ON ext_qct_tk (hdr_id ASC)');
        
    END;

    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_qct_tk
    Noi dung: Don dep bang ext_qct_tk
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 01/10/2011
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_qct_tk IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_QCT_TK';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            PCK_TRACE_LOG.prc_ins_log(userenv('client_info'),
                                      pck_trace_log.Fnc_WhoCalledMe);
    END;
    
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Chot_Dlieu
    ***************************************************************************/
    PROCEDURE Prc_Chot_Dlieu(p_short_name varchar2) IS
    BEGIN
        UPDATE tb_lst_taxo SET status=98 WHERE short_name=p_short_name;
        PCK_TRACE_LOG.prc_ins_log(p_short_name, pck_trace_log.Fnc_WhoCalledMe);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        PCK_TRACE_LOG.prc_ins_log(p_short_name,pck_trace_log.Fnc_WhoCalledMe);
    END;
    
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_slech_no
    Noi dung: Don dep ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 06/03/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_slech_no IS
    BEGIN
        Prc_Ddep_tb_ext_errors;

        prc_remote_sql(
        'CREATE TABLE ext_slech_no
        (
        loai                           CHAR(3),
        ky_thue                        DATE,
        tin                            VARCHAR2(14),
        ten_dtnt                       VARCHAR2(250),
        tai_khoan                      VARCHAR2(50),
        muc                            VARCHAR2(4),
        tieumuc                        VARCHAR2(4),
        mathue                         VARCHAR2(2),
        sothue_no_cky                  NUMBER(15,0),
        sono_no_cky                    NUMBER(15,0),
        clech_no_cky                   NUMBER(15,0),
        update_no                      NUMBER(3,0),
        ma_cbo                         VARCHAR2(15),
        ten_cbo                        VARCHAR2(150),
        ma_pban                        VARCHAR2(15),
        ten_pban                       VARCHAR2(250),
        ma_slech                       NUMBER(2,0),
        ma_gdich                       VARCHAR2(3),
        ten_gdich                      VARCHAR2(100),
        da_dchinh                      VARCHAR2(1),
        ma_cqt                         VARCHAR2(5))');

        prc_remote_sql('CREATE INDEX ext_slno_udn ON ext_slech_no(update_no ASC)');
    END;
       
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_errors
    Noi dung: Don dep bang ext_errors
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 06/03/2012
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_slech_no IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_SLECH_NO';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;
    
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_tb_ext_temp_dchieu
    Noi dung: Don dep ext_temp_dchieu
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_tb_ext_temp_dchieu IS
    BEGIN
        Prc_Ddep_tb_ext_temp_dchieu;

        prc_remote_sql(
        'CREATE TABLE ext_temp_dchieu
            (mau                            VARCHAR2(10),
            v_char1                        VARCHAR2(20),
            v_char2                        VARCHAR2(50),
            v_char3                        VARCHAR2(50),
            loai                           VARCHAR2(2))
            PCTFREE     10
            PCTUSED     40
            INITRANS    1
            MAXTRANS    255
            TABLESPACE  qlt_dmuc
            STORAGE   (
            INITIAL     65536
            MINEXTENTS  1
            MAXEXTENTS  2147483645
          )');

    END;
    
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ddep_tb_ext_temp_dchieu
    Noi dung: Don dep bang ext_temp_dchieu
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ddep_tb_ext_temp_dchieu IS
        c_name_drop CONSTANT VARCHAR2(20) :='EXT_TEMP_DCHIEU';
        CURSOR c IS
        SELECT 1 FROM user_objects@qlt WHERE object_type = 'TABLE'
                                         AND object_name=c_name_drop;
    BEGIN
        FOR v IN c LOOP
            prc_remote_sql('DROP TABLE '||c_name_drop);
        END LOOP;
    END;
    
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_vw_qlt_dchieu_ps
    Noi dung: Don dep vw_qlt_dchieu_ps
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_vw_qlt_dchieu_ps IS
    BEGIN
        prc_remote_sql(
        'CREATE OR REPLACE VIEW vw_dchieu_ps (
               mau,
               loai_tkhai,
               so_tien )
            AS
            select mau, loai_tkhai, so_tien
            from
            (
            select ''QLT-APP'' Mau, loai_tkhai, trim(to_char(sum(thue),''999,999,999,999,999'')) so_tien
            from (
            select  tkh.id
                    , decode(tkh.dtk_ma_loai_tkhai, ''29'', ''02T/KK-TNCN''
                                                  , ''30'', ''02Q/KK-TNCN''
                                                  , ''21'', ''03T/KK-TNCN''
                                                  , ''60'', ''03Q/KK-TNCN''
                                                  , ''19'', ''07/KK-TNCN'') loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai in(''29'',''30'', ''21'', ''60'',''19''))
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''               
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)        
            union all                                                
            select  tkh.id
                    , ''01/KK-XS'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
                    AND (dtnt.ma_loai=''550'')
                    AND (dtnt.ma_khoan=''558'')                       
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                 
            union all                                                
            select  tkh.id
                    , ''01/KK-BH'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''038'', ''173''))                      
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                                                                  
            union all                                                
            select  tkh.id
                    , ''08/KK-TNCN'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''557'', ''757'', ''857''))                       
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                 
            ) group by loai_tkhai
            ) order by mau desc, loai_tkhai');
    END;                              
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_vw_qlt_dchieu_no
    Noi dung: Don dep vw_qlt_dchieu_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_vw_qlt_dchieu_no IS
    BEGIN
        prc_remote_sql(
        'CREATE OR REPLACE VIEW vw_dchieu_no (
               mau,
               ma_tmuc,
               so_no,
               so_thua )
            AS
            SELECT mau, ma_tmuc, so_no, so_thua
            FROM
            (
            SELECT ALL ''QLT-APP'' mau
                , MA_TMUC
                , trim(to_char(Sum(Decode(Abs(SO_NO) , SO_NO ,ROUND(SO_NO),-SO_NO ,0)),''999,999,999,999,999'')) SO_NO  
                , ''-''||trim(to_char(Sum(Decode(Abs(SO_NO) ,-SO_NO ,ROUND(-SO_NO), SO_NO ,0)),''999,999,999,999,999'')) SO_THUA
            FROM QLT_DANHSACH_NO
            WHERE  Round(Abs(SO_NO))>=1 and tkhoan=''741''
            GROUP BY MA_MUC, MA_TMUC
            ) order by mau desc, ma_tmuc');
    END;
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_vw_qct_dchieu_no
    Noi dung: Don dep vw_qct_dchieu_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_vw_qct_dchieu_ps IS
    BEGIN
        prc_remote_sql(
        'CREATE OR REPLACE VIEW vw_dchieu_ps (
               mau,
               loai_tkhai,
               so_tien )
            AS
            select mau, loai_tkhai, so_tien
            from
            (
            select ''QLT-APP'' Mau, loai_tkhai, trim(to_char(sum(thue),''999,999,999,999,999'')) so_tien
            from (
            select  tkh.id
                    , decode(tkh.dtk_ma_loai_tkhai, ''29'', ''02T/KK-TNCN''
                                                  , ''30'', ''02Q/KK-TNCN''
                                                  , ''21'', ''03T/KK-TNCN''
                                                  , ''60'', ''03Q/KK-TNCN''
                                                  , ''19'', ''07/KK-TNCN'') loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai in(''29'',''30'', ''21'', ''60'',''19''))
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''               
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)        
            union all                                                
            select  tkh.id
                    , ''01/KK-XS'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''018'', ''418'', ''618'', ''818'', ''176'', ''564''))
                    AND (dtnt.ma_loai=''550'')
                    AND (dtnt.ma_khoan=''558'')                       
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                 
            union all                                                
            select  tkh.id
                    , ''01/KK-BH'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''038'', ''173''))                      
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                                                                  
            union all                                                
            select  tkh.id
                    , ''08/KK-TNCN'' loai_tkhai
                    , tkh.tin
                    , tkh.kylb_tu_ngay
                    , tkh.kylb_den_ngay
                    , tkh.kykk_tu_ngay
                    , tkh.kykk_den_ngay
                    , pst.tmt_ma_muc
                    , pst.tmt_ma_tmuc
                    , nvl(pst.thue_psinh,0) thue
            from    qlt_tkhai_hdr tkh
                  , qlt_psinh_tkhai pst
                  , qlt_nsd_dtnt dtnt 
                  , qlt_dm_tkhai_hluc hluc
            where   (pst.tkh_id (+) = tkh.id)
                    and tkh.tin = dtnt.tin
                    and tkh.dtk_ma_loai_tkhai = hluc.dtk_ma
                    and nvl(tkh.khieu_pban,qlt_pck_control.fnc_get_pban_hluc(tkh.kylb_tu_ngay,tkh.dtk_ma_loai_tkhai,''TKHAI'')) = hluc.khieu_pban
                    and (pst.tkh_ltd (+) = tkh.ltd)
                    and (tkh.dtk_ma_loai_tkhai =''12'')
                    and tkh.kykk_tu_ngay>=to_date(''01/01/2011'', ''DD/MM/RRRR'') 
                    and tkh.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR''))
                    and pst.tmt_ma_muc=''1000''
                    and pst.tmt_ma_tmuc=''1003''
                    AND (dtnt.ma_chuong IN (''557'', ''757'', ''857''))                       
                    and decode(tkh.ltd,0,3000,tkh.ltd) = (select max(a.ltd_max) from qlt_v_tkhai_tc a 
                                                           where a.id=tkh.id 
                                                             and a.kykk_tu_ngay=tkh.kykk_tu_ngay
                                                             and a.kykk_den_ngay=tkh.kykk_den_ngay 
                                                             and a.kylb_den_ngay<=last_day(to_date(userenv(''client_info''), ''DD/MM/RRRR'')) group by a.id)                                                 
            ) group by loai_tkhai
            union all
            select ''QCT-APP'' Mau, decode(ma_tkhai, ''24'', ''08/KK-TNCN''
                                  , ''25'', ''08A/KK-TNCN''
                                  , ''26'', ''10/KK-TNCN''
                                  , ''27'', ''10A/KK-TNCN'') loai_tkhai, 
                    so_tien
            from (
            select ma_tkhai, trim(to_char(sum(thue_psinh),''999,999,999,999,999'')) so_tien 
              from ext_v_dchieu_qct_q group by ma_tkhai
            )
            ) order by mau desc, loai_tkhai');
    END;
    /***************************************************************************
    PCK_MOI_TRUONG.Prc_Ktao_vw_qct_dchieu_no
    Noi dung: Don dep vw_qct_dchieu_no
    Nguoi thuc hien: ThanhNH5
    Ngay thuc hien: 25/06/2012
    ***************************************************************************/
    PROCEDURE Prc_Ktao_vw_qct_dchieu_no IS
    BEGIN
        prc_remote_sql(
        'CREATE OR REPLACE VIEW vw_dchieu_no (
               mau,
               ma_tmuc,
               so_no,
               so_thua )
            AS
            SELECT mau, ma_tmuc, so_no, so_thua
            FROM
            (
            SELECT ALL ''QLT-APP'' mau
                , MA_TMUC
                , trim(to_char(Sum(Decode(Abs(SO_NO) , SO_NO ,ROUND(SO_NO),-SO_NO ,0)),''999,999,999,999,999'')) SO_NO  
                , ''-''||trim(to_char(Sum(Decode(Abs(SO_NO) ,-SO_NO ,ROUND(-SO_NO), SO_NO ,0)),''999,999,999,999,999'')) SO_THUA
            FROM QLT_DANHSACH_NO
            WHERE  Round(Abs(SO_NO))>=1 and tkhoan=''741''
            GROUP BY MA_MUC, MA_TMUC
            union all
            Select ALL ''QCT-APP'' mau, MA_TMUC  MA_TMUC
                , trim(to_char(Sum(Decode (Abs (so_no), so_no, Round (so_no), -so_no, Null)),''999,999,999,999,999'')) so_no
             ,''-''||trim(to_char(Sum(Decode (Abs (so_no), -so_no, Round (-so_no), so_no, Null)),''999,999,999,999,999'')) so_thua
            From qct_so_no_thop
            where TKHOAN=''TK_NGAN_SACH''
            Group By TKHOAN,MA_MUC, MA_TMUC  
            ) order by mau desc, ma_tmuc');
    END;            
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_MOI_TRUONG

-- Start of DDL Script for Package Body TKTQ.PCK_QCT_SLECH_MST
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_qct_slech_mst
IS

END;
/


-- End of DDL Script for Package Body TKTQ.PCK_QCT_SLECH_MST

-- Start of DDL Script for Package Body TKTQ.PCK_QLT_SLECH_MST
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

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
      dbms_output.put_line('BEGIN
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
      END;');
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


-- End of DDL Script for Package Body TKTQ.PCK_QLT_SLECH_MST

-- Start of DDL Script for Package Body TKTQ.PCK_TRACE_LOG
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_trace_log
IS
   FUNCTION info (backtrace_in IN VARCHAR2)
      RETURN error_rt
   IS

      l_at_loc           PLS_INTEGER;
      l_dot_loc          PLS_INTEGER;
      l_name_start_loc   PLS_INTEGER;
      l_name_end_loc     PLS_INTEGER;
      l_line_loc         PLS_INTEGER;
      l_eol_loc          PLS_INTEGER;

      retval             error_rt;

      PROCEDURE initialize_values
      IS
      BEGIN
         l_name_start_loc := INSTR (backtrace_in, c_name_delim, 1, 1);
         l_dot_loc := INSTR (backtrace_in, c_dot_delim);
         l_name_end_loc := INSTR (backtrace_in, c_name_delim, 1, 2);
         l_line_loc := INSTR (backtrace_in, c_line_delim);
         l_eol_loc := INSTR (backtrace_in, c_eol_delim);
      END initialize_values;
   BEGIN

      /* Khoi tao gia tri */
      initialize_values;

      retval.program_owner :=
         SUBSTR (backtrace_in
                , l_name_start_loc  + 1
                , l_dot_loc - l_name_start_loc - 1
                );

      retval.program_name :=
          SUBSTR (backtrace_in, l_dot_loc + 1, l_name_end_loc - l_dot_loc - 1);

      retval.line_number :=
             SUBSTR (backtrace_in, l_line_loc + 5, l_eol_loc - l_line_loc - 5);
      RETURN retval;
   END info;

/*******************************************************************************
  Xem tien trinh xu ly cua PROCEDURE nhu THE nao
*******************************************************************************/
   PROCEDURE Prc_dbms_app_info(p_pck_name IN VARCHAR2, p_target_desc IN VARCHAR2) IS
   BEGIN
        dbms_application_info.set_session_longops (
            rindex,
            slno,
            p_pck_name,
            target,
            CONTEXT,
            sofar,
            totalwork,
            p_target_desc,
            units);
   END;

    /***************************************************************************
    pck_trace_log.PRC_INS_LOG: Ghi lai loi khi co error
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log(p_short_name VARCHAR2,
                          p_pck VARCHAR2,
                          p_status VARCHAR2 DEFAULT NULL) IS
        v_error_message VARCHAR2(500);
        v_trace pck_trace_log.error_rt;
        
        v_ltd number(4);
        v_status varchar2(1);
    BEGIN
        -- Lay exception
        v_error_message:=SQLERRM;
        v_trace:=pck_trace_log.info(DBMS_UTILITY.format_error_backtrace);
        
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM tb_log_pck  
                                      WHERE short_name=p_short_name 
                                        AND pck=p_pck;
        UPDATE tb_log_pck SET ltd=v_ltd 
                                      WHERE ltd=0 
                                        AND short_name=p_short_name 
                                        AND pck=p_pck;
        
        -- Cap nhat trang thai cua thu tuc
        IF v_trace.program_name IS NULL THEN
            v_status:='Y';
        ELSE
            v_status:='N'; 
        END IF;
        
        IF p_status IS NOT NULL THEN
            v_status:=p_status;
        END IF;
        
        -- Insert log
        INSERT INTO TB_LOG_PCK
                  (id, short_name, time_exec, pck, status, 
                   where_log, 
                   err_code)
            VALUES(SEQ_ID_LOG_PCK.NEXTVAL, p_short_name, SYSDATE, p_pck, v_status,
                   decode(v_trace.program_name, 
                          NULL, 
                          NULL, 
                          v_trace.program_name||' at line: '||v_trace.line_number),
                   v_error_message);
        COMMIT;        
    END;

/***************************************************************************
    pck_trace_log.PRC_INS_LOG: Ghi lai loi khi co error
    ***************************************************************************/
    PROCEDURE Prc_Ins_Log_Vs(p_short_name VARCHAR2,
                             p_pck VARCHAR2,
                             p_status VARCHAR2,
                             p_mesg VARCHAR2) IS       
        v_ltd number(4);
    BEGIN 
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM tb_log_pck  
                                      WHERE short_name=p_short_name 
                                        AND pck=p_pck;
        UPDATE tb_log_pck SET ltd=v_ltd 
                                      WHERE ltd=0 
                                        AND short_name=p_short_name 
                                        AND pck=p_pck;       
        -- Insert log
        INSERT INTO TB_LOG_PCK
                  (id, short_name, time_exec, pck, status, 
                   where_log, 
                   err_code)
            VALUES(SEQ_ID_LOG_PCK.NEXTVAL, p_short_name, SYSDATE, p_pck, p_status,
                   NULL,
                   p_mesg);
        COMMIT;        
    END;

    /***************************************************************************
    pck_trace_log.PRC_INS_LOG: Ghi lai loi khi co error
    ***************************************************************************/
    PROCEDURE Prc_Upd_Log(p_id NUMBER,
                          p_status VARCHAR2,
                          p_error_message VARCHAR2 DEFAULT NULL) IS
        v_error_message VARCHAR2(255);
        v_trace pck_trace_log.error_rt;
    BEGIN
        v_error_message:=SQLERRM;
        v_trace := pck_trace_log.info(DBMS_UTILITY.format_error_backtrace);
        UPDATE TB_LOG_PCK SET status = p_status,
                              where_log = decode(v_trace.program_name, NULL, NULL, v_trace.program_name||' at line: '||v_trace.line_number),
                              err_code = NVL(p_error_message,v_error_message)
            WHERE id = p_id;
        COMMIT;
    END;

    /***************************************************************************
    pck_trace_log.Prc_Upd_Log_Max
    Ghi lai loi khi co error
    ***************************************************************************/
    PROCEDURE Prc_Upd_Log_Max(p_short_name VARCHAR2,
                              p_pck VARCHAR2) IS       
        v_ltd number(4);
        v_status varchar2(1);
    BEGIN       
        -- Cap nhat lan thay doi LTD
        SELECT nvl(max(ltd),0)+1 INTO v_ltd FROM tb_log_pck  
                                      WHERE short_name=p_short_name 
                                        AND pck=p_pck;
        UPDATE tb_log_pck SET ltd=v_ltd 
                                      WHERE ltd=0 
                                        AND short_name=p_short_name 
                                        AND pck=p_pck;                
        COMMIT;        
    END;

    /***************************************************************************
    pck_trace_log.Prc_Out_Log: Hien thi ERROR
    ***************************************************************************/
    PROCEDURE Prc_Out_Log IS
        v_error_message VARCHAR2(255);
        v_trace pck_trace_log.error_rt;
    BEGIN
        dbms_output.put_line('Xu ly thanh cong');
        --v_error_message:=SQLERRM;
        --v_trace := pck_trace_log.info(DBMS_UTILITY.format_error_backtrace);
        --dbms_output.put_line(v_trace.program_name||' at line: '||v_trace.line_number);
        --dbms_output.put_line(v_error_message);
    END;

    /***************************************************************************
    pck_trace_log.Prc_WhoCalledMe: Xac dinh noi PROCEDURE goi trong PCK
    ***************************************************************************/
    PROCEDURE Prc_WhoCalledMe(p_owner   OUT VARCHAR2,
                              p_type    OUT VARCHAR2,
                              p_name    OUT VARCHAR2,
                              p_lineNo  OUT PLS_INTEGER) IS

        c_callStack     CONSTANT VARCHAR2(4096) := DBMS_UTILITY.FORMAT_CALL_STACK;
        l_start         PLS_INTEGER;
        l_end           PLS_INTEGER := 0;
        l_line          VARCHAR2(255);
    BEGIN

        LOOP

            l_start := l_end + 1;
            l_end   := NVL(INSTR(c_callStack,CHR(10),l_start),0);

            EXIT WHEN l_end = 0;

            IF SUBSTR(c_callStack,l_start,l_end-l_start+1) LIKE '%handle%number%name%'
                THEN

                l_start := INSTR(c_callStack,CHR(10),l_start,3)+1;
                l_end   := NVL(INSTR(c_callStack,CHR(10),l_start),0);

                EXIT WHEN l_end = 0;

                l_line   := SUBSTR(c_callStack,l_start,l_end-l_start);
                p_lineNo := TO_NUMBER(SUBSTR(l_line,13,6));
                l_line   := SUBSTR(l_line,21);

                IF l_line LIKE 'procedure%' THEN
                    l_start := 10;
                    ELSIF l_line LIKE 'function%' THEN
                    l_start := 9;
                    ELSIF l_line LIKE 'package body%' THEN
                    l_start := 13;
                    ELSIF l_line LIKE 'package%' THEN
                    l_start := 8;
                    ELSIF l_line LIKE 'anonymous%' THEN
                    l_start := 16;
                    ELSE
                    l_start := NULL;
                END IF;

                IF l_start IS NOT NULL THEN
                    p_type := UPPER(LTRIM(RTRIM(SUBSTR(l_line,1,l_start-1))));
                    l_line := SUBSTR(l_line,l_start);
                    ELSE
                    p_type := 'TRIGGER';
                END IF;

                l_start := INSTR(l_line,'.');

                p_owner := LTRIM(RTRIM(SUBSTR(l_line,1,l_start-1)));
                p_name  := LTRIM(RTRIM(SUBSTR(l_line,l_start+1)));
            END IF;

        END LOOP;

    END;

    /***************************************************************************
    pck_trace_log.Fnc_WhoCalledMe: Xac dinh noi PROCEDURE goi trong PCK
    ***************************************************************************/
    FUNCTION Fnc_WhoCalledMe RETURN VARCHAR2 IS

      l_owner         VARCHAR2(30);
      l_type          VARCHAR2(30);
      l_name          VARCHAR2(30);
      l_lineNo        PLS_INTEGER;
      l_return        VARCHAR2(100) DEFAULT 'UNKNOW';

    CURSOR c IS
        SELECT trim(REPLACE(
                            UPPER(
                                  substr(text, 
                                         1, 
                                         Decode(instr(text, '('),0,instr(text, ' IS'),
                                         instr(text, '('))-1
                                         )
                                 ), 'PROCEDURE'
                           )
                    ) txt
          FROM all_source
         WHERE owner=l_owner AND NAME=l_name AND TYPE=l_type
           AND line=(
                    SELECT MAX(line) FROM all_source
                     WHERE owner=l_owner AND NAME=l_name AND TYPE=l_type
                       AND UPPER(text) LIKE '%PROCEDURE%' AND line < l_lineNo
                    );

    BEGIN
        Prc_WhoCalledMe(l_owner, l_type, l_name, l_lineNo);
        FOR v IN c LOOP
        l_return:=v.txt;
        END LOOP;
        RETURN(l_return);
    END;
/******************************************************************************/
    PROCEDURE rs_start IS
    BEGIN
        DELETE FROM run_stats;

        INSERT INTO run_stats
        SELECT 'before', stats.* FROM stats;

        g_start := dbms_utility.get_time;
    END;

    PROCEDURE rs_middle IS
    BEGIN
        g_run1 := (dbms_utility.get_time-g_start);

        INSERT INTO run_stats
        SELECT 'after 1', stats.* FROM stats;
        g_start := dbms_utility.get_time;

    END;

    PROCEDURE rs_stop(p_difference_threshold IN NUMBER DEFAULT 0)
    IS
    BEGIN
        g_run2 := (dbms_utility.get_time-g_start);

        dbms_output.put_line
        ( 'Run1 ran in ' || g_run1 || ' hsecs' );
        dbms_output.put_line
        ( 'Run2 ran in ' || g_run2 || ' hsecs' );
        IF ( g_run2 <> 0 )
        THEN
        dbms_output.put_line
        ( 'run 1 ran in ' || round(g_run1/g_run2*100,2) ||
          '% of the time' );
        END IF;
        dbms_output.put_line( chr(9) );

        INSERT INTO run_stats
        SELECT 'after 2', stats.* FROM stats;

        dbms_output.put_line
        ( rpad( 'Name', 30 ) || lpad( 'Run1', 12 ) ||
          lpad( 'Run2', 12 ) || lpad( 'Diff', 12 ) );

        FOR x IN
        ( SELECT rpad( a.NAME, 30 ) ||
                 to_char( b.value-a.value, '999,999,999' ) ||
                 to_char( c.value-b.value, '999,999,999' ) ||
                 to_char( ( (c.value-b.value)-(b.value-a.value)), '999,999,999' ) DATA
            FROM run_stats a, run_stats b, run_stats c
           WHERE a.NAME = b.NAME
             AND b.NAME = c.NAME
             AND a.runid = 'before'
             AND b.runid = 'after 1'
             AND c.runid = 'after 2'
             -- and (c.value-a.value) > 0
             AND abs( (c.value-b.value) - (b.value-a.value) )
                   > p_difference_threshold
           ORDER BY abs( (c.value-b.value)-(b.value-a.value))
        ) LOOP
            dbms_output.put_line( x.DATA );
        END LOOP;

        dbms_output.put_line( chr(9) );
        dbms_output.put_line
        ( 'Run1 latches total versus runs -- difference and pct' );
        dbms_output.put_line
        ( lpad( 'Run1', 12 ) || lpad( 'Run2', 12 ) ||
          lpad( 'Diff', 12 ) || lpad( 'Pct', 10 ) );

        FOR x IN
        ( SELECT to_char( run1, '999,999,999' ) ||
                 to_char( run2, '999,999,999' ) ||
                 to_char( diff, '999,999,999' ) ||
                 to_char( round( run1/decode( run2, 0, to_number(0), run2) *100,2 ), '99,999.99' ) || '%' DATA
            FROM ( SELECT SUM(b.value-a.value) run1, SUM(c.value-b.value) run2,
                          SUM( (c.value-b.value)-(b.value-a.value)) diff
                     FROM run_stats a, run_stats b, run_stats c
                    WHERE a.NAME = b.NAME
                      AND b.NAME = c.NAME
                      AND a.runid = 'before'
                      AND b.runid = 'after 1'
                      AND c.runid = 'after 2'
                      AND a.NAME LIKE 'LATCH%'
                    )
        ) LOOP
            dbms_output.put_line( x.DATA );
        END LOOP;
    END;   
END pck_trace_log;
/


-- End of DDL Script for Package Body TKTQ.PCK_TRACE_LOG

-- Start of DDL Script for Package Body TKTQ.PCK_ULT
-- Generated 15-Jan-2013 13:17:06 from TKTQ@DPPIT

CREATE OR REPLACE 
PACKAGE BODY pck_ult
IS 
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
END;
/


-- End of DDL Script for Package Body TKTQ.PCK_ULT

