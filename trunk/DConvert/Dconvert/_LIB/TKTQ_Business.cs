using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Data;
using System.Windows.Forms;
using Microsoft.Office.Interop.Word;
using DC.Utl;
using System.Data.OleDb;

namespace DC.Lib
{
    class TKTQ_PCK_ORA_QLT
    {
        public static void Prc_Jobs_Htdc(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHECK_DATA.Prc_Jobs_Htdc('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Check_Dblink(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHECK_DATA.Prc_Check_Dblink('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }        
        public static void Prc_Ktra_Kchot(string p_short_name)
        {
            string _query = null;
            DataTable _dt = null;
            string _tax_model = "QLT";

            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {                                
                _ora.TransStart();
                _query = @"SELECT tax_model FROM tb_lst_taxo WHERE short_name='&1'";
                _query = _query.Replace("&1", p_short_name);
                _dt = _ora.TransExecute_DataTable(_query);
                if (_dt.Rows.Count > 0)
                {
                    _tax_model = _dt.Rows[0]["tax_model"].ToString();
                }

                _dt.Reset();
                _query = @"SELECT
                           (SELECT NVL(TO_CHAR(KY_CHOT,'MM/RRRR'),'NULL') FROM tb_lst_taxo WHERE short_name='&1') KYCHOT_DC,
                           (SELECT TO_CHAR(MAX(kylb_den_ngay),'MM/RRRR') FROM qlt_sothue_lock@qlt_&1 WHERE loai_so='ST1B') KYKHOASO_CQT,
                           (SELECT TO_CHAR(MAX(kyno_tu_ngay),'MM/RRRR') FROM qlt_so_no@qlt_&1) KYNO_QLT,
                           (SELECT TO_CHAR(MAX(kyno_tu_ngay),'MM/RRRR') FROM &2_so_no@qlt_&1) KYNO_QCT
                           FROM dual";
                _query = _query.Replace("&1", p_short_name);
                _query = _query.Replace("&2", _tax_model);
                _dt = _ora.TransExecute_DataTable(_query);

                if (_dt.Rows.Count > 0)
                {
                    if (
                        _dt.Rows[0]["KYCHOT_DC"].ToString().Equals(_dt.Rows[0]["KYCHOT_DC"].ToString()) &
                        _dt.Rows[0]["KYCHOT_DC"].ToString().Equals(_dt.Rows[0]["KYKHOASO_CQT"].ToString()) &
                        _dt.Rows[0]["KYCHOT_DC"].ToString().Equals(_dt.Rows[0]["KYNO_QLT"].ToString()) &
                        _dt.Rows[0]["KYCHOT_DC"].ToString().Equals(_dt.Rows[0]["KYNO_QCT"].ToString())
                        )
                    { 
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('&1', 'PRC_KTRA_KCHOT', 'Y', null)";
                        _query = _query.Replace("&1", p_short_name);
                        _ora.TransExecute(_query);     
                    }
                    else
                    {
                        _query = null;
                        _query = "call PCK_TRACE_LOG.prc_ins_log_vs('&1', 'PRC_KTRA_KCHOT', 'N', '&2')";
                        _query = _query.Replace("&1", p_short_name);
                        _query = _query.Replace("&2", "KYCHOT_DC: " + _dt.Rows[0]["KYCHOT_DC"].ToString() + " " +
                                                      "KYKHOASO_CQT: " + _dt.Rows[0]["KYKHOASO_CQT"].ToString() + " " +
                                                      "KYNO_QLT: " + _dt.Rows[0]["KYNO_QLT"].ToString() + " " +
                                                      "KYNO_QCT(chỉ dành cho QCT): " + _dt.Rows[0]["KYNO_QCT"].ToString());
                        _ora.TransExecute(_query);
                    }                                                
                }                
                _ora.TransCommit();
            }
        }
        public static void Prc_Ktra_Dlieu_KyLB(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CHECK_DATA.Prc_Ktra_Dlieu_KyLB('" + p_short_name + "')";
                _ora.TransExecute(_query);                
                _ora.TransCommit();
            }
        }
        public static void Prc_Tat_Toan(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CUTOVER.Prc_Tat_Toan('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Dmuc_Hluc(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CUTOVER.Prc_Dmuc_Hluc('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Chan_Chuc_Nang(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CUTOVER.Prc_Chan_Chuc_Nang('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Dchinh_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Dchinh_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }         
        public static void Prc_QLTQCT_KhoiTao_MoiTruong(string p_short_name, DC.Forms.Frm_QLCD p_frm_qlcd)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();                
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + p_short_name + "')";                
                _ora.TransExecute(_query);
                _query = "call PCK_MOI_TRUONG.prc_cre_dblink(userenv('client_info'))";               
                _ora.TransExecute(_query);
                _query = "call PCK_MOI_TRUONG.prc_ktao(userenv('client_info'))";                
                _ora.TransExecute(_query);                
                _ora.TransCommit();                
            } 
        }
        public static void Prc_QLTQCT_DonDep_MoiTruong(string p_short_name, DC.Forms.Frm_QLCD p_frm_qlcd)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _query = "call PCK_MOI_TRUONG.prc_cre_dblink(userenv('client_info'))";
                _ora.TransExecute(_query);
                _query = "call PCK_MOI_TRUONG.prc_ddep(userenv('client_info'))";
                _ora.TransExecute(_query);
                _ora.TransCommit(); 
            }
        }
        public static void Prc_QLTQCT_GetLog(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.prc_get_errors('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        //Lấy dữ liệu QLT
        public static void Prc_QLT_QltPs(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();                                
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Qlt_Thop_Ps('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQltPs(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.prc_qlt_get_ps('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QltNo(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Qlt_Thop_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQltNo(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.prc_qlt_get_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _query = "call PCK_MAP_TMS.prc_map_tc_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QltCkt(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Qlt_Thop_Ckt('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQltCkt(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.prc_qlt_get_Ckt('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QltTKMB(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Qlt_Thop_TKTMB('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQltTKMB(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_TKTMB('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _query = "call PCK_MAP_TMS.Prc_Update_bac_mbai";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QltDKNTK(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Qlt_Thop_DKNTK_QT('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQltDKNTK(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Qlt_Get_DKNTK_QT('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        //Lấy dữ liệu QCT
        public static void Prc_QLT_QctNo(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Job_Qct_Thop_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQctNo(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.prc_qct_get_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QctTKMB(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Job_Qct_Thop_TKTMB('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQctTKMB(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_TKTMB('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QctDKNTK(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Job_Qct_Thop_Dkntk('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQctDKNTK(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_DKNTK('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void Prc_QLT_QctCCTT(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Job_Qct_Thop_CCTT_GTGT('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_QLT_GetQctCCTT(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_CCTT_GTGT('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        public static void prc_ktra_du_lieu_no(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ)) 
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _query = "call PCK_CHECK_DATA.prc_ktra_du_lieu_no(userenv('client_info'))";
                _ora.TransExecute(_query);
                _ora.TransCommit();                
            }
        }
        public static void prc_ktra_du_lieu_ps(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _query = "call PCK_CHECK_DATA.prc_ktra_du_lieu_ps(userenv('client_info'))";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }        
        }
        public static void Prc_Chot_Dlieu(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.Prc_Chot_Dlieu('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Qlt_Slech_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Job_Slech_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Qct_Slech_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Job_Slech_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Qlt_Get_Slech_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QLT.Prc_Get_Slech_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Qct_Get_Slech_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Get_Slech_No('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Qct_Get_Pt(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QCT.Prc_Qct_Get_Pt('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
    }
    
    class TKTQ_PCK_ORA_QTN
    {
        public static void Prc_Create_DB_Link(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QTN.prc_cre_dblink('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        // Kết chuyển dữ liệu QTN
        public static void Fnc_get_qtn_so_no(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QTN.prc_get_qtn_so_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        // Cap nhat tinh chat no
        public static void Fnc_update_tc_no(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QTN.prc_update_tc_no_vat('" + p_short_name + "')";
                _ora.TransExecute(_query);
                //Map t/c no tms
                _query = "call PCK_MAP_TMS.prc_map_tc_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }

        // Ket chuyen du lieu tinh phat
        public static void Fnc_get_tinh_phat(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_QTN.prc_get_qtn_tinh_phat('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
    }

    class TKTQ_PCK_ORA_NHAP_NGOAI
    {
        // Đọc dữ liệu nợ
        public static void Fnc_read_no(string p_short_name)
        {
            string _path = GlobalVar.gl_dirNhap_Ngoai;
            string file_name = _path + @"\" + p_short_name.Substring(0,3) + @"\" + p_short_name + @"\DLV_DC_NhapNgoaiUD.xls";

            string _strConn = GlobalVar.get_connExcel(file_name);
            string _query;

            OleDbConnection conn = new OleDbConnection(_strConn);
            OleDbCommand cmd = new OleDbCommand("SELECT * FROM [CD$]", conn);
            cmd.CommandType = CommandType.Text;

            DataTable _dtCD_Sheet = new DataTable("CD");
            new OleDbDataAdapter(cmd).Fill(_dtCD_Sheet);

            CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ);
            //Xóa dữ liệu cũ
            _query = "DELETE FROM TB_NO_NHAP_NGOAI a WHERE a.SHORT_NAME = '" + p_short_name + "'";
            _ora.exeUpdate(_query);
            
            int i = 0;
            foreach (DataRow _dr in _dtCD_Sheet.Rows)
            {
                // 3 dòng đầu là ghi chú
                if (i < 4)
                {
                    i++;
                    continue;
                }
                //Dòng thứ 4 là header
                if (i == 4)
                {
                    if (_dr[0].ToString().Trim().ToLower().Equals("mã số thuế"))
                        throw new System.ArgumentException("Sai tên cột mã số thuế");
                    if (_dr[1].ToString().Trim().ToLower().Equals("tiểu mục"))
                        throw new System.ArgumentException("Sai tên cột tiểu mục");
                    if (_dr[2].ToString().Trim().ToLower().Equals("kỳ lập bộ"))
                        throw new System.ArgumentException("Sai tên cột kỳ lập bộ");
                    if (_dr[3].ToString().Trim().ToLower().Equals("kỳ kê khai"))
                        throw new System.ArgumentException("Sai tên cột kỳ kê khai");
                    if (_dr[4].ToString().Trim().ToLower().Equals("hạn nộp"))
                        throw new System.ArgumentException("Sai tên cột hạn nộp");
                    if (_dr[5].ToString().Trim().ToLower().Equals("số tiền"))
                        throw new System.ArgumentException("Sai tên cột số tiền");
                    if (_dr[6].ToString().Trim().ToLower().Equals("tài khoản"))
                        throw new System.ArgumentException("Sai tên cột tài khoản");
                    i++;
                    continue;
                }
                //Dòng thứ 5 là mẫu
                if (i == 5)
                {
                    i++;
                    continue;
                }

                //Nếu trống cột mã số thuế thì không đọc tiếp
                if (_dr[0].ToString().Trim() == "")
                    break;

                //Bắt đầu đọc dữ liệu từ dòng thứ 6                
                _query = "INSERT INTO  TB_NO_NHAP_NGOAI (TIN, TMT_MA_TMUC, KY_LAP_BO, KY_KE_KHAI, HAN_NOP, SO_TIEN, TAI_KHOAN, SHORT_NAME) " +
                                "Values ('{0}','{1}','{2}','{3}','{4}',{5},'{6}','{7}')";

                _query = _query.Replace("{0}", _dr[0].ToString().Trim());
                _query = _query.Replace("{1}", _dr[1].ToString().Trim());
                _query = _query.Replace("{2}", _dr[2].ToString().Trim());
                _query = _query.Replace("{3}", _dr[3].ToString().Trim());
                _query = _query.Replace("{4}", _dr[4].ToString().Trim());
                _query = _query.Replace("{5}", _dr[5].ToString().Trim());
                _query = _query.Replace("{6}", _dr[6].ToString().Trim());
                _query = _query.Replace("{7}", p_short_name);

                _ora.exeUpdate(_query);                
            }            
        }
        // Tổng hợp dữ liệu vào bảng TB_NO
        public static void Fnc_tong_hop_no(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_CDOI_DLIEU_NHAP_NGOAI.prc_tong_hop_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
    }

    class TKTQ_PCK_ORA_PNN
    {   
        public static void Prc_KhoiTao_MoiTruong(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();     
                _query = "call PCK_MOI_TRUONG.prc_ktao_pnn('" + p_short_name + "')";                
                _ora.TransExecute(_query);                
                _ora.TransCommit();                
            } 
        }
        public static void Prc_DonDep_MoiTruong(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call PCK_MOI_TRUONG.prc_ddep_pnn('" + p_short_name + "')";                
                _ora.TransExecute(_query);
                _ora.TransCommit(); 
            }
        }
        
        //Lấy dữ liệu 
        public static void Prc_TH_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call pck_cdoi_dlieu_pnn.prc_job_pnn_thop_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Get_No(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call pck_cdoi_dlieu_pnn.prc_pnn_get_no('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Get_tk01(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call pck_cdoi_dlieu_pnn.prc_pnn_get_01tk_sddpnn('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }
        public static void Prc_Get_tk02(string p_short_name)
        {
            string _query = null;
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                _ora.TransStart();
                _query = "call pck_cdoi_dlieu_pnn.prc_pnn_get_02tk_sddpnn('" + p_short_name + "')";
                _ora.TransExecute(_query);
                _ora.TransCommit();
            }
        }        
    }

    class TKTQ_EXTRACT
    {
        // Gen biên bản đối chiếu dữ liệu lần 1
        public static void Prc_BienBan(string _pathFOpen,
                                       string _pathFSave,
                                       string _short_name,
                                       string _query_ps,
                                       string _query_no,
                                       string _query_tk,
                                       string _query_tk_bs
                                       )
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                Object _objNULL = System.Reflection.Missing.Value;
                Object _objTRUE = true;
                Object _objFALSE = false;
                String _query = null;
                DataTable _dt = null;

                string _txtField = null;

                // Đóng phiên làm việc Database
                _ora.TransStart();

                // Mở kết nối đến CQT trong các câu lệnh query
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + _short_name + "')";
                _ora.TransExecute(_query);

                // Tham số cho thứ tự của table trong WORD
                int _k;
                // Tham số cho thứ tự xóa table trong WORD
                int _z = 0;

                // Các index của table trong _Document cần xóa
                ArrayList _arr_delTable = new ArrayList();

                // Mở một instance cho MS Word
                Microsoft.Office.Interop.Word.ApplicationClass _wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
                _wordApp.Visible = false;

                // Sao chép mẫu biên bản theo _pathFOpen
                Object _strFile = _pathFOpen;
                _Document _doc = _wordApp.Documents.Add(ref _strFile,   //Template
                                                        ref _objNULL,   //NewTemplate 
                                                        ref _objNULL,   //DocumentType 
                                                        ref _objFALSE   //Visible
                                                        );
                                
                #region In bảng phát sinh
                _k = 4;
                _dt = _ora.TransExecute_DataTable(_query_ps);                
                Prc_fill_tbBienBan(_k, _doc, _dt, 3);
                
                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                _dt.Reset();
                #endregion
                                
                #region In bảng nợ
                _k = 5;
                _dt = _ora.TransExecute_DataTable(_query_no);
                 Prc_fill_tbBienBan(_k, _doc, _dt, 4);
                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                _dt.Reset();
                #endregion

                ////Tạo bảng chi tiết tờ khai 10/KK-TNCN
                //#region ADD ROW TO_KHAI
                //_dt = _ora.TransExecute_DataTable(_query_tk);
                //if (_dt.Rows.Count == 0)
                //{
                //    if (_times == 1)
                //        _query_tk = "SELECT 0 stt, 0 loai_ud, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                //    else
                //        _query_tk = "SELECT 0 stt, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                //    _dt = _ora.TransExecute_DataTable(_query_tk);
                //}
                //_k = 6;
                //// Điền giá trị tờ khai
                //Prc_fill_tbBienBan(_k, _doc, _dt, 4);

                //// Modify by ManhTV3 on 6/4/2012
                //// Tạo bảng nhập cho CQT
                //_dt = _ora.TransExecute_DataTable(_query_tk_bs);
                //if (_dt.Rows.Count == 0)
                //{
                //    if (_times == 1)
                //        _query_tk_bs = "SELECT 0 stt, 0 loai_ud, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                //    else
                //        _query_tk_bs = "SELECT 0 stt, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                //    _dt = _ora.TransExecute_DataTable(_query_tk_bs);
                //}
                //_k = 7;
                //Prc_fill_tbBienBan(_k, _doc, _dt, 4);
                //// Modify by ThanhNH5 on 07/04/2012
                //// Tạo bảng nhập sai lệch cho CQT
                //_k = 8;
                //Prc_fill_tbBienBan(_k, _doc, _dt, 4);

                //// Add các index của table cần xóa
                //if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                //_dt.Reset();
                //#endregion

                // Xóa table không cần thiết của _Document
                foreach (int i in _arr_delTable)
                {
                    _doc.Tables[i - _z].Delete();
                    _z++;
                }

                // Tính số trang của biên bản
                Microsoft.Office.Interop.Word.WdStatistic _stat = Microsoft.Office.Interop.Word.WdStatistic.wdStatisticPages;
                int _countPage = _doc.ComputeStatistics(_stat, ref _objNULL);


                // Điền các giá trị MERGE MAIL
                #region MERGE MAIL
                _query = @"SELECT * FROM vw_bban_01";
                _dt = _ora.TransExecute_DataTable(_query);
                foreach (Field _docField in _doc.Fields)
                {
                    Microsoft.Office.Interop.Word.Range _rngFieldCode = _docField.Code;
                    String _fieldText = _rngFieldCode.Text;
                    if (_fieldText.StartsWith(" MERGEFIELD"))
                    {
                        // Kết quả _rngFieldCode.Text có dạng
                        // MERGEFIELD  MyFieldName  \\* MERGEFORMAT                    
                        Int32 _endMerge = _fieldText.IndexOf("\\");
                        Int32 _fieldNameLength = _fieldText.Length - _endMerge;
                        String _fieldName = _fieldText.Substring(11, _endMerge - 11);

                        // thực hiện thay thế các Fields 
                        foreach (DataColumn _col in _dt.Columns)
                        {
                            if (_col.ColumnName.ToString().Trim().ToLower().Equals(_fieldName.Trim().ToLower()))
                            {
                                foreach (DataRow _row in _dt.Rows)
                                {
                                    _docField.Select();
                                    _txtField = _row[_col].ToString();
                                    //_txtField = _row[_col].ToString() + (_fieldName.Trim() == "fld_CQT1" ? " giữ 01 bản, " : "");
                                    if ((_fieldName.Trim().ToUpper() == "fld_tax_model".ToUpper()) & _row[_col].ToString().ToUpper().Equals("QCT"))
                                        _txtField = @"QLT\QCT";
                                    if (_fieldName.Trim().ToUpper() == "fld_CountPage".ToUpper())
                                        _txtField = _countPage.ToString();
                                    _wordApp.Selection.TypeText(CLS_FONT.Fnc_TCVN3ToUNICODE(_txtField));
                                }
                            }
                        }
                    }
                }
                _dt.Reset();
                #endregion

                // Save tài liệu
                Object _pathSaveFile = _pathFSave + "\\" + _short_name + "_BienBanDoiChieu_01.doc";
                _doc.SaveAs(ref _pathSaveFile,  //FileName
                            ref _objNULL,       //FileFormat 
                            ref _objNULL,       //LockComments 
                            ref _objNULL,       //Password
                            ref _objNULL,       //AddToRecentFiles 
                            ref _objNULL,       //WritePassword 
                            ref _objNULL,       //ReadOnlyRecommended 
                            ref _objNULL,       //EmbedTrueTypeFonts 
                            ref _objNULL,       //SaveNativePictureFormat
                            ref _objNULL,       //SaveFormsData 
                            ref _objNULL,       //SaveAsAOCELetter 
                            ref _objNULL,       //Encoding 
                            ref _objNULL,       //InsertLineBreaks 
                            ref _objNULL,       //AllowSubstitutions
                            ref _objNULL,       //LineEnding 
                            ref _objNULL        //AddBiDiMarks
                            );
                // Đóng tài liệu
                _doc.Close(ref _objFALSE, ref _objNULL, ref _objNULL);

                // Thoát WORD
                _wordApp.Quit(ref _objNULL, ref _objNULL, ref _objNULL);

                // Đóng phiên làm việc Database
                _ora.TransCommit();
            }
        }

        // Gen biên bản đối chiếu dữ liệu lần 2
        public static void Prc_BienBan2(string _pathFOpen,
                                        string _pathFSave,
                                        string _short_name,
                                        string _query_ps,
                                        string _query_no,
                                        string _query_tk,                                        
                                        string _query_tk_bs,
                                        string _query_pluc01,
                                        string _query_pluc02,
                                        string _query_pluc03,
                                        int _times)
        {
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                Object _objNULL = System.Reflection.Missing.Value;
                Object _objTRUE = true;
                Object _objFALSE = false;
                String _query = null;
                DataTable _dt = null;

                string _txtField = null;

                // Đóng phiên làm việc Database
                _ora.TransStart();

                // Mở kết nối đến CQT trong các câu lệnh query
                _query = "call PCK_MOI_TRUONG.prc_set_glview('" + _short_name + "')";
                _ora.TransExecute(_query);

                // Tham số cho thứ tự của table trong WORD
                int _k;
                // Tham số cho thứ tự xóa table trong WORD
                int _z = 0;

                // Các index của table trong _Document cần xóa
                ArrayList _arr_delTable = new ArrayList();

                // Mở một instance cho MS Word
                Microsoft.Office.Interop.Word.ApplicationClass _wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
                _wordApp.Visible = false;

                // Sao chép mẫu biên bản theo _pathFOpen
                Object _strFile = _pathFOpen;
                _Document _doc = _wordApp.Documents.Add(ref _strFile,   //Template
                                                        ref _objNULL,   //NewTemplate 
                                                        ref _objNULL,   //DocumentType 
                                                        ref _objFALSE   //Visible
                                                        );



                // Tạo bảng Phát sinh
                #region ADD ROW PHAT_SINH
                _k = 4;
                _dt = _ora.TransExecute_DataTable(_query_ps);
                if (_times == 1)
                {
                    Prc_fill_tbBienBan(_k, _doc, _dt, 3);
                }
                else if (_times == 2)
                {
                    Prc_fill_tbBienBan2_PS(_k, _doc, _dt, 3);
                }
                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                _dt.Reset();
                #endregion

                // Tạo bảng nợ
                #region ADD ROW NO
                _k = 5;
                _dt = _ora.TransExecute_DataTable(_query_no);
                if (_times == 1)
                {
                    Prc_fill_tbBienBan(_k, _doc, _dt, 4);
                }
                else if (_times == 2)
                {
                    Prc_fill_tbBienBan2_NO(_k, _doc, _dt, 4);
                }

                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                _dt.Reset();
                #endregion

                //Tạo bảng chi tiết tờ khai 10/KK-TNCN
                #region ADD ROW TO_KHAI
                _dt = _ora.TransExecute_DataTable(_query_tk);
                if (_dt.Rows.Count == 0)
                {
                    if (_times == 1)
                        _query_tk = "SELECT 0 stt, 0 loai_ud, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                    else
                        _query_tk = "SELECT 0 stt, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                    _dt = _ora.TransExecute_DataTable(_query_tk);
                }
                _k = 6;
                // Điền giá trị tờ khai
                Prc_fill_tbBienBan(_k, _doc, _dt, 4);

                // Modify by ManhTV3 on 6/4/2012
                // Tạo bảng nhập cho CQT
                _dt = _ora.TransExecute_DataTable(_query_tk_bs);
                if (_dt.Rows.Count == 0)
                {
                    if (_times == 1)
                        _query_tk_bs = "SELECT 0 stt, 0 loai_ud, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                    else
                        _query_tk_bs = "SELECT 0 stt, 0 so_luong, 0 pbq1, 0 pbq2, 0 pbq3, 0 pbq4, 0 tncn FROM dual";
                    _dt = _ora.TransExecute_DataTable(_query_tk_bs);
                }
                _k = 7;
                Prc_fill_tbBienBan(_k, _doc, _dt, 4);
                // Modify by ThanhNH5 on 07/04/2012
                // Tạo bảng nhập sai lệch cho CQT
                _k = 8;
                Prc_fill_tbBienBan(_k, _doc, _dt, 4);

                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0) _arr_delTable.Add(_k);
                _dt.Reset();
                #endregion                

                // Tạo bảng phụ lục 01
                #region ADD ROW PHU_LUC01                
                _k = 10;
                _dt = _ora.TransExecute_DataTable(_query_pluc01);                
                Prc_fill_tbBienBan(_k, _doc, _dt, 2);

                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0)
                {
                    _arr_delTable.Add(9);
                    _arr_delTable.Add(10);
                }
                _dt.Reset();
                #endregion

                // Tạo bảng phụ lục 02
                #region ADD ROW PHU_LUC02
                _k = 12;
                _dt = _ora.TransExecute_DataTable(_query_pluc02);

                Prc_fill_tbBienBan(_k, _doc, _dt, 2);

                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0)
                {
                    _arr_delTable.Add(11);
                    _arr_delTable.Add(12);
                }
                _dt.Reset();
                #endregion

                // Tạo bảng phụ lục 03
                #region ADD ROW PHU_LUC03
                _k = 14;
                _dt = _ora.TransExecute_DataTable(_query_pluc03);

                Prc_fill_tbBienBan(_k, _doc, _dt, 2);

                // Add các index của table cần xóa
                if (_dt.Rows.Count == 0)
                { 
                    _arr_delTable.Add(13);
                    _arr_delTable.Add(14);
                }
                _dt.Reset();
                #endregion

                // Xóa table không cần thiết của _Document
                foreach (int i in _arr_delTable)
                {
                    _doc.Tables[i - _z].Delete();
                    _z++;
                }

                // Tính số trang của biên bản
                Microsoft.Office.Interop.Word.WdStatistic _stat = Microsoft.Office.Interop.Word.WdStatistic.wdStatisticPages;
                int _countPage = _doc.ComputeStatistics(_stat, ref _objNULL);


                // Điền các giá trị MERGE MAIL
                #region MERGE MAIL
                _query = @"SELECT * FROM vw_bban_01";
                _dt = _ora.TransExecute_DataTable(_query);
                foreach (Field _docField in _doc.Fields)
                {
                    Microsoft.Office.Interop.Word.Range _rngFieldCode = _docField.Code;
                    String _fieldText = _rngFieldCode.Text;
                    if (_fieldText.StartsWith(" MERGEFIELD"))
                    {
                        // Kết quả _rngFieldCode.Text có dạng
                        // MERGEFIELD  MyFieldName  \\* MERGEFORMAT                    
                        Int32 _endMerge = _fieldText.IndexOf("\\");
                        Int32 _fieldNameLength = _fieldText.Length - _endMerge;
                        String _fieldName = _fieldText.Substring(11, _endMerge - 11);

                        // thực hiện thay thế các Fields 
                        foreach (DataColumn _col in _dt.Columns)
                        {
                            if (_col.ColumnName.ToString().Trim().ToLower().Equals(_fieldName.Trim().ToLower()))
                            {
                                foreach (DataRow _row in _dt.Rows)
                                {
                                    _docField.Select();
                                    _txtField = _row[_col].ToString();
                                    //_txtField = _row[_col].ToString() + (_fieldName.Trim() == "fld_CQT1" ? " giữ 01 bản, " : "");
                                    if ((_fieldName.Trim().ToUpper() == "fld_tax_model".ToUpper()) & _row[_col].ToString().ToUpper().Equals("QCT"))
                                        _txtField = @"QLT\QCT";
                                    if (_fieldName.Trim().ToUpper() == "fld_CountPage".ToUpper())
                                        _txtField = _countPage.ToString();
                                    _wordApp.Selection.TypeText(CLS_FONT.Fnc_TCVN3ToUNICODE(_txtField));
                                }
                            }
                        }
                    }
                }
                _dt.Reset();
                #endregion

                // Save tài liệu
                Object _pathSaveFile = _pathFSave + "\\" + _short_name + "_BienBanDoiChieu_0" + _times.ToString() + ".doc";
                _doc.SaveAs(ref _pathSaveFile,  //FileName
                            ref _objNULL,       //FileFormat 
                            ref _objNULL,       //LockComments 
                            ref _objNULL,       //Password
                            ref _objNULL,       //AddToRecentFiles 
                            ref _objNULL,       //WritePassword 
                            ref _objNULL,       //ReadOnlyRecommended 
                            ref _objNULL,       //EmbedTrueTypeFonts 
                            ref _objNULL,       //SaveNativePictureFormat
                            ref _objNULL,       //SaveFormsData 
                            ref _objNULL,       //SaveAsAOCELetter 
                            ref _objNULL,       //Encoding 
                            ref _objNULL,       //InsertLineBreaks 
                            ref _objNULL,       //AllowSubstitutions
                            ref _objNULL,       //LineEnding 
                            ref _objNULL        //AddBiDiMarks
                            );
                // Đóng tài liệu
                _doc.Close(ref _objFALSE, ref _objNULL, ref _objNULL);

                // Thoát WORD
                _wordApp.Quit(ref _objNULL, ref _objNULL, ref _objNULL);

                // Đóng phiên làm việc Database
                _ora.TransCommit();
            }
        }

        // procedure phục vụ cho kết xuất biên bản lần 2 của dữ liệu phát sinh
        private static void Prc_fill_tbBienBan2_PS(int _k, _Document _doc, System.Data.DataTable _dt, int _x)
        {            
            // Tạo row
            for (int i = 0; i < _dt.Rows.Count - 1; i++)
            {
                // copy thêm theo dòng thứ _x của table
                object _beforeRow = _doc.Tables[_k].Rows[_x];
                _doc.Tables[_k].Rows.Add(ref _beforeRow);
            }                                                       
            
            // Điền giá trị
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                for (int j = 1; j < _dt.Columns.Count; j++)
                {
                    // Nếu number thì sẽ format "{0:0,0}" ko thì giữ nguyên format
                    _doc.Tables[_k].Cell(i + _x, j).Range.Text = CLS_FONT.Fnc_TCVN3ToUNICODE(_dt.Rows[i].ItemArray[j].ToString());
                }
            }
            
            // Merge Cell
            const int cstMer1 = 5;
            const int cstMer2 = 6;
            int _imerge = 0;
            for (int i = 0; i < _dt.Rows.Count; i++) {
                if (Convert.ToInt16(_dt.Rows[i].ItemArray[0].ToString()) == 1) {
                    _imerge = i;
                }
                else {
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer1).Merge(_doc.Tables[_k].Cell(_x + i, cstMer1));
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer2).Merge(_doc.Tables[_k].Cell(_x + i, cstMer2));
                }                
            }
        }
        private static void Prc_fill_tbBienBan2_NO(int _k, _Document _doc, System.Data.DataTable _dt, int _x)
        {
            // Tạo row
            for (int i = 0; i < _dt.Rows.Count - 1; i++)
            {
                // copy thêm theo dòng thứ _x của table
                object _beforeRow = _doc.Tables[_k].Rows[_x];
                _doc.Tables[_k].Rows.Add(ref _beforeRow);
            }

            // Điền giá trị
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                for (int j = 1; j < _dt.Columns.Count; j++)
                {
                    // Nếu number thì sẽ format "{0:0,0}" ko thì giữ nguyên format
                    _doc.Tables[_k].Cell(i + _x, j).Range.Text = CLS_FONT.Fnc_TCVN3ToUNICODE(_dt.Rows[i].ItemArray[j].ToString());
                }
            }

            // Merge Cell
            const int cstMer1 = 6;
            const int cstMer2 = 7;
            const int cstMer3 = 8;
            const int cstMer4 = 9;
            int _imerge = 0;
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                if (Convert.ToInt16(_dt.Rows[i].ItemArray[0].ToString()) == 1)
                {
                    _imerge = i;
                }
                else
                {
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer1).Merge(_doc.Tables[_k].Cell(_x + i, cstMer1));
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer2).Merge(_doc.Tables[_k].Cell(_x + i, cstMer2));
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer3).Merge(_doc.Tables[_k].Cell(_x + i, cstMer3));
                    _doc.Tables[_k].Cell(_x + _imerge, cstMer4).Merge(_doc.Tables[_k].Cell(_x + i, cstMer4));
                }
            }
        }         

        // procedure phục vụ cho Prc_BienBan
        private static void Prc_fill_tbBienBan(int _k, _Document _doc, System.Data.DataTable _dt, int _x)
        {
            // hàng bắt đầu fill dữ liệu
            // int _x = 3;

            // Tạo row
            for (int i = 0; i < _dt.Rows.Count - 1; i++)
            {                
                // copy thêm theo dòng thứ _x của table
                object _beforeRow = _doc.Tables[_k].Rows[_x];
                _doc.Tables[_k].Rows.Add(ref _beforeRow);
            }
            // Đánh số thứ tự
            //for (int i = 0; i < _dt.Rows.Count; i++)
            //{
            //    _doc.Tables[_k].Cell(i + _x, 1).Range.Text = (i + 1).ToString();
            //}
            // Điền giá trị vào table tương ứng (i: hàng j: cột)
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                for (int j = 0; j < _dt.Columns.Count; j++)
                {
                    // Nếu number thì sẽ format "{0:0,0}" ko thì giữ nguyên format
                    _doc.Tables[_k].Cell(i + _x, j + 1).Range.Text = CLS_FONT.Fnc_TCVN3ToUNICODE(_dt.Rows[i].ItemArray[j].ToString());
                }
            }
        }
        /**
         * Thuc hien lay du lieu va ket xuat file sai lech 
         * @author Administrator
         * @date   September 09, 2013
         * @param  p_sourcePath
         * @param  p_destinPath
         * @param  p_short_name 
         * 
         */
        public static void Prc_SaiLech(string p_sourcePath,
                                       string p_destinPath,
                                       string p_short_name)
        {
            Microsoft.Office.Interop.Excel.Application _excelApp;
            _excelApp = new Microsoft.Office.Interop.Excel.Application();

            // Mở file mẫu excel
            Microsoft.Office.Interop.Excel.Workbook workBook =
                _excelApp.Workbooks.Open(p_sourcePath,  //Filename
                                         Type.Missing,  //UpdateLinks
                                         Type.Missing,  //ReadOnly 
                                         Type.Missing,  //Format
                                         Type.Missing,  //Password
                                         Type.Missing,  //WriteResPassword
                                         Type.Missing,  //IgnoreReadOnlyRecommended
                                         Type.Missing,  //Origin
                                         Type.Missing,  //Delimiter
                                         Type.Missing,  //Editable
                                         Type.Missing,  //Notify
                                         Type.Missing,  //Converter
                                         Type.Missing,  //AddToMru
                                         Type.Missing,  //Local
                                         Type.Missing); //CorruptLoad 
            // Lấy dữ liệu
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                System.Data.DataTable _dt = null;
                string _sql = null;
                try
                {
                    _ora.TransStart();
                    _ora.TransExecute("call PCK_MOI_TRUONG.Prc_Set_glView('" + p_short_name + "')");

                    // Kết xuất phát sinh
                    _sql = "SELECT * FROM vw_sl_ps";
                    _dt = _ora.TransExecute_DataTable(_sql);                    
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_PS", _dt);
                    _dt.Clear();

                    // Kết xuất số nợ
                    _sql = "SELECT * FROM vw_sl_no";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_NO", _dt);
                    _dt.Clear();

                    // Kết xuất đăng ký nộp tờ khai quyết toán
                    _sql = "SELECT * FROM vw_sl_dkntk";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_DKNTK", _dt);
                    _dt.Clear();

                    // Kết xuất tờ khai thuế môn bài
                    _sql = "SELECT * FROM vw_sl_tkmb";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_TKMB", _dt);
                    _dt.Clear();

                    // Kết xuất dữ liệu còn khấu trừ
                    _sql = "SELECT * FROM vw_sl_con_kt";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_CON_KT", _dt);
                    _dt.Clear();

                    // Kết xuất dữ liệu 01_thkh
                    _sql = "SELECT * FROM vw_sl_01_thkh";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_01_THKH", _dt);
                    _dt.Clear();

                    // Kết xuất dữ liệu 01/TK-SDDPNN
                    _sql = "SELECT * FROM vw_sl_TK_SDDPNN where rownum < 100";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_TK_SDDPNN", _dt);
                    _dt.Clear();

                    // Kết xuất dữ liệu tính phạt
                    _sql = "SELECT * FROM vw_sl_tinh_phat";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_TINH_PHAT", _dt);
                    _dt.Clear();
                    
                    // Kết xuất chi tiết sai lệch sổ nợ và sổ thu nộp
                    _sql = "SELECT * FROM vw_sl_tn";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "SaiLechNo", _dt);
                    _dt.Clear();

                    /*
                    // Kết xuất chi tiết sai lệch mã số thuế trạng thái lỗi hoặc chưa có ngày đăng ký nhưng có phát sinh thuế
                    _sql = "SELECT * FROM vw_sl_mst";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "SaiLechMST", _dt);
                    _dt.Clear();
                    */
                    workBook.SaveAs(p_destinPath,
                                        Microsoft.Office.Interop.Excel.XlFileFormat.xlWorkbookNormal,
                                        Type.Missing, Type.Missing, Type.Missing, Type.Missing,
                                        Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive,
                                        Type.Missing, Type.Missing, Type.Missing,
                                        Type.Missing, Type.Missing);                   
                    _ora.TransCommit();
                }
                finally
                {
                    // Đóng file mẫu excel
                    workBook.Close(false, p_sourcePath, null);
                    _excelApp.Quit();

                    CLS_EXCEL.Prc_releaseObject(workBook);
                    CLS_EXCEL.Prc_releaseObject(_excelApp);
                }
            }
        }

        /*
         * Modify by ManhTV3 on 27/04/2012
         * Kết xuất file excel báo cáo tiến độ chuẩn hóa
         * */
        public static void Prc_Bcao_Chuan_Hoa(string p_sourcePath, 
                                              string p_destinPath)
        {
            Microsoft.Office.Interop.Excel.Application _excelApp;
            _excelApp = new Microsoft.Office.Interop.Excel.Application();

            // Mở file mẫu excel
            Microsoft.Office.Interop.Excel.Workbook workBook =
                _excelApp.Workbooks.Open(p_sourcePath,  //Filename
                                         Type.Missing,  //UpdateLinks
                                         Type.Missing,  //ReadOnly 
                                         Type.Missing,  //Format
                                         Type.Missing,  //Password
                                         Type.Missing,  //WriteResPassword
                                         Type.Missing,  //IgnoreReadOnlyRecommended
                                         Type.Missing,  //Origin
                                         Type.Missing,  //Delimiter
                                         Type.Missing,  //Editable
                                         Type.Missing,  //Notify
                                         Type.Missing,  //Converter
                                         Type.Missing,  //AddToMru
                                         Type.Missing,  //Local
                                         Type.Missing); //CorruptLoad 
            // Lấy dữ liệu
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {                
                try
                {
                    _ora.TransStart();
                    // Kết xuất báo cáo tiến độ chuẩn hóa
                    string _sql = "SELECT * FROM vw_bc_ch;";
                    DataTable _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0)
                        CLS_EXCEL.Prc_Add_Sheets(workBook, "BaoCaoChuanHoa", _dt);
                    _dt.Clear();                    

                    workBook.SaveAs(p_destinPath,
                                        Microsoft.Office.Interop.Excel.XlFileFormat.xlWorkbookNormal,
                                        Type.Missing, Type.Missing, Type.Missing, Type.Missing,
                                        Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive,
                                        Type.Missing, Type.Missing, Type.Missing,
                                        Type.Missing, Type.Missing);
                    //_ora.TransCommit();
                }
                finally
                {
                    // Đóng file mẫu excel
                    workBook.Close(false, p_sourcePath, null);
                    _excelApp.Quit();

                    CLS_EXCEL.Prc_releaseObject(workBook);
                    CLS_EXCEL.Prc_releaseObject(_excelApp);
                }
            }
        }

        public static void Prc_ChiTiet(string p_sourcePath,
                                       string p_destinPath,
                                       string p_short_name)
        {
            Microsoft.Office.Interop.Excel.Application _excelApp;
            _excelApp = new Microsoft.Office.Interop.Excel.Application();

            // Mở file mẫu excel
            Microsoft.Office.Interop.Excel.Workbook workBook =
                _excelApp.Workbooks.Open(p_sourcePath,  //Filename
                                         Type.Missing,  //UpdateLinks
                                         Type.Missing,  //ReadOnly 
                                         Type.Missing,  //Format
                                         Type.Missing,  //Password
                                         Type.Missing,  //WriteResPassword
                                         Type.Missing,  //IgnoreReadOnlyRecommended
                                         Type.Missing,  //Origin
                                         Type.Missing,  //Delimiter
                                         Type.Missing,  //Editable
                                         Type.Missing,  //Notify
                                         Type.Missing,  //Converter
                                         Type.Missing,  //AddToMru
                                         Type.Missing,  //Local
                                         Type.Missing); //CorruptLoad 
            // Lấy dữ liệu
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                System.Data.DataTable _dt = null;
                string _sql = null;
                try
                {
                    _ora.TransStart();
                    _ora.TransExecute("call PCK_MOI_TRUONG.Prc_Set_glView('" + p_short_name + "')");

                    // Kết xuất phát sinh
                    _sql = "SELECT * FROM vw_ct_ps";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_PS", _dt);
                    _dt.Clear();

                    // Kết xuất số nợ
                    _sql = "SELECT * FROM vw_ct_no";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_NO", _dt);
                    _dt.Clear();

                    // Kết xuất chi tiết tờ khai 10KK
                    _sql = "SELECT * FROM vw_ct_tk";
                    _dt = _ora.TransExecute_DataTable(_sql);
                    if (_dt.Rows.Count > 0) CLS_EXCEL.Prc_Add_Sheets(workBook, "DuLieu_TK", _dt);
                    _dt.Clear();

                    workBook.SaveAs(p_destinPath,
                                        Microsoft.Office.Interop.Excel.XlFileFormat.xlWorkbookNormal,
                                        Type.Missing, Type.Missing, Type.Missing, Type.Missing,
                                        Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive,
                                        Type.Missing, Type.Missing, Type.Missing,
                                        Type.Missing, Type.Missing);
                    _ora.TransCommit();
                }
                finally
                {
                    // Đóng file mẫu excel
                    workBook.Close(false, p_sourcePath, null);
                    _excelApp.Quit();

                    CLS_EXCEL.Prc_releaseObject(workBook);
                    CLS_EXCEL.Prc_releaseObject(_excelApp);
                }
            }
        }
        //Prc_ChuyenDoiLoi
        public static void Prc_ChuyenDoiLoi(string p_sourcePath,
                                            string p_destinPath,
                                            string p_short_name,
                                            string p_query,
                                            string p_sheet_name)
        {
            Microsoft.Office.Interop.Excel.Application _excelApp;
            _excelApp = new Microsoft.Office.Interop.Excel.Application();

            // Mở file mẫu excel
            Microsoft.Office.Interop.Excel.Workbook workBook =
                _excelApp.Workbooks.Open(p_sourcePath,  //Filename
                                         Type.Missing,  //UpdateLinks
                                         Type.Missing,  //ReadOnly 
                                         Type.Missing,  //Format
                                         Type.Missing,  //Password
                                         Type.Missing,  //WriteResPassword
                                         Type.Missing,  //IgnoreReadOnlyRecommended
                                         Type.Missing,  //Origin
                                         Type.Missing,  //Delimiter
                                         Type.Missing,  //Editable
                                         Type.Missing,  //Notify
                                         Type.Missing,  //Converter
                                         Type.Missing,  //AddToMru
                                         Type.Missing,  //Local
                                         Type.Missing); //CorruptLoad 
            // Lấy dữ liệu
            using (CLS_DBASE.ORA _ora = new CLS_DBASE.ORA(GlobalVar.gl_connTKTQ))
            {
                System.Data.DataTable _dt = null;

                try
                {
                    _ora.TransStart();
                    _ora.TransExecute("call PCK_MOI_TRUONG.Prc_Set_glView('" + p_short_name + "')");

                    // Kết xuất phụ lục
                    _dt = _ora.TransExecute_DataTable(p_query);
                    if (_dt.Rows.Count > 0)
                    {
                        CLS_EXCEL.Prc_Add_Sheets(workBook, p_sheet_name, _dt);
                        workBook.SaveAs(p_destinPath,
                                            Microsoft.Office.Interop.Excel.XlFileFormat.xlWorkbookNormal,
                                            Type.Missing, Type.Missing, Type.Missing, Type.Missing,
                                            Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlExclusive,
                                            Type.Missing, Type.Missing, Type.Missing,
                                            Type.Missing, Type.Missing);                    
                    }

                    _dt.Clear();
                    _ora.TransCommit();
                }
                finally
                {
                    // Đóng file mẫu excel
                    workBook.Close(false, p_sourcePath, null);
                    _excelApp.Quit();

                    CLS_EXCEL.Prc_releaseObject(workBook);
                    CLS_EXCEL.Prc_releaseObject(_excelApp);
                }
            }
        }
    }
}
