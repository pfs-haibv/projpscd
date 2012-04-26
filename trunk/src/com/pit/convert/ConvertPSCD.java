package com.pit.convert;

import UnicodeConverter.Tcvn3Converter;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Properties;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

import com.sap.conn.jco.AbapException;
import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoFunctionTemplate;
import com.sap.conn.jco.JCoRuntimeException;
import com.sap.conn.jco.JCoStructure;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.DestinationDataProvider;
import com.sap.conn.jco.ext.Environment;
import com.sap.conn.jco.ext.JCoSessionReference;
import com.sap.conn.jco.ext.SessionException;
import com.sap.conn.jco.ext.SessionReferenceProvider;

import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

import com.pit.system.Constants;
import com.pit.conn.ConnectDB;
import java.sql.SQLException;
import java.util.Date;
import javax.swing.JOptionPane;

/**
 * Chứa càc methods thực hiện chuyển đội dữ liệu
 *
 * @author Administrator
 */
public class ConvertPSCD {

    static String DESTINATION_NAME1 = "ABAP_AS_WITHOUT_PSCD_POOL";
    static String DESTINATION_NAME2 = "ABAP_AS_WITH_PSCD_POOL";

    static {
        Properties connectProperties = new Properties();
        /*
         * Connection type: Custom Application server
         */
//        connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST, "10.64.8.93");
//        connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR, "00");
//        connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, "500");
//        connectProperties.setProperty(DestinationDataProvider.JCO_USER, "dc_dev02");
//        connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, "1234567");
//        connectProperties.setProperty(DestinationDataProvider.JCO_LANG, "en");       
//        createDataFile(DESTINATION_NAME1, "jcoDestination", connectProperties);
//        connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, "70");
//        connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, "50");
//        createDataFile(DESTINATION_NAME2, "jcoDestination", connectProperties);
        /*
         * Connection type: Group/Server Selection
         */
        connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, "500");
        connectProperties.setProperty(DestinationDataProvider.JCO_MSHOST, "10.64.85.12");
        connectProperties.setProperty(DestinationDataProvider.JCO_R3NAME, "PE1");
        connectProperties.setProperty(DestinationDataProvider.JCO_GROUP, "PE1-GROUP");
        connectProperties.setProperty(DestinationDataProvider.JCO_USER, "dc_dev02");
        connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, "1234567");
        connectProperties.setProperty(DestinationDataProvider.JCO_LANG, "en");
        createDataFile(DESTINATION_NAME1, "jcoDestination", connectProperties);
        connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, "70");
        connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, "50");
        createDataFile(DESTINATION_NAME2, "jcoDestination", connectProperties);

    }
    private static BlockingQueue<MultiStepJob> queue = new LinkedBlockingQueue<MultiStepJob>();
    private static JCoFunctionTemplate convertDKTTemplate, convertNPT;
    //Danh sách NNT          
    public static ArrayList<DataCVPSCD> arrData = new ArrayList<DataCVPSCD>();
    public static ArrayList<DataCVNPT> arrNPT = new ArrayList<DataCVNPT>();
    // Log
    static LogManager lm = LogManager.getLogManager();
    static Logger logger;

    static void createDataFile(String name, String suffix, Properties properties) {
        File cfg = new File(name + "." + suffix);
        if (!cfg.exists()) {
            try {
                FileOutputStream fos = new FileOutputStream(cfg, false);
                properties.store(fos, "for tests only !");
                fos.close();
                DESTINATION_NAME1.startsWith("100");                
            } catch (Exception e) {
                logger.log(Level.WARNING, "Unable to create the destination file " + cfg.getName(), e);
            }
        }
    }

    static void createDestinationDataFile(String destinationName, Properties connectProperties) {
        File destCfg = new File(destinationName + ".jcoDestination");
        try {
            FileOutputStream fos = new FileOutputStream(destCfg, false);
            connectProperties.store(fos, "for tests only !");
            fos.close();
        } catch (Exception e) {
            throw new RuntimeException("Unable to create the destination files", e);
        }
    }

    interface MultiStepJob {

        boolean isFinished();

        public void runNextStep();

        String getName();

        public void cleanUp();
    }

    static class StatelessMultiStepExample implements MultiStepJob {

        static AtomicInteger JOB_COUNT = new AtomicInteger(0);
        int jobID = JOB_COUNT.addAndGet(1);
        int calls;
        JCoDestination destination;
        int executedCalls = 0;
        Exception ex = null;
        int remoteCounter;

        StatelessMultiStepExample(JCoDestination destination, int calls) {
            this.calls = calls;
            this.destination = destination;
        }

        public boolean isFinished() {
            return executedCalls >= calls || ex != null;
        }

        public String getName() {
            return "stateless Job-" + jobID;
        }

        public JCoDestination getDestionation() {
            return this.destination;
        }

        public void runNextStep() {
//              try
//              {
//                  JCoFunction incrementCounter = incrementCounterTemplate.getFunction();
//                  incrementCounter.execute(destination);
//                  JCoFunction getCounter = getCounterTemplate.getFunction();
//                  executedCalls++;
//
//                  if(isFinished())
//                  {
//                      getCounter.execute(destination);
//                      remoteCounter = getCounter.getExportParameterList().getInt("GET_VALUE");
//                  }
//              }
//              catch(JCoException je)
//              {
//                  ex = je;
//              }
//              catch(RuntimeException re)
//              {
//                  ex = re;
//              }
        }

        public void cleanUp() {
            StringBuilder sb = new StringBuilder("Task ").append(getName()).append(" is finished ");
            if (ex != null) {
                sb.append("with exception ").append(ex.toString());
            } else {
                sb.append("successful. Counter is ").append(remoteCounter);
            }
        }
    }

    /**
     * Thực hiện xử lý cho từng trường hợp chuyển đổi PSCD, check PSCD
     */
    static class StatefulMultiStepNNTExample extends StatelessMultiStepExample {

        DataCVPSCD nnt = null;
        // Loại dữ liệu convert Nợ, Phát sinh, Tờ khai (NO, PS, TK)
        String type = "";
        //tên ngắn của cơ quan thuế
        String short_name = "";
        String chk_pscd = "";

        StatefulMultiStepNNTExample(JCoDestination destination, int calls, String type, DataCVPSCD nnt, String short_name, String chk_pscd) {
            super(destination, calls);
            this.type = type;
            this.nnt = nnt;
            this.short_name = short_name;
            this.chk_pscd = chk_pscd;

        }

        @Override
        public String getName() {
            return "stateful Job-" + jobID;
        }

        @Override
        public synchronized void runNextStep() {
            JCoFunction fnConvert = convertDKTTemplate.getFunction();
            String type_ = type;
            //SQL -> update status = 'S' or 'E'
            String sql_status = "";
            //Import date
            String imp_date = "";
            /**
             * ------------------------------------------------------------------------*
             * 01. XỬ LÝ NỢ *
             * *------------------------------------------------------------------------
             */
            if (type_.equals(Constants.NO) && chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * A. THỰC HIỆN CONVERT *
                 * *--------------------------------------------------------------------
                 */
                try {

                    JCoContext.begin(destination);
                    //Structure Import I_DATA
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_DATA");

                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrPSCD.get(0).getID());                       //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("DOC_TYPE", nnt.arrPSCD.get(0).getDOC_TYPE());                //DOC_TYPE
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrPSCD.get(0).getTAX_OFFICE_CODE());  //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TIN", nnt.arrPSCD.get(0).getTIN());                          //TIN
                    JcoStrI_DATA.setValue("PROFIT_CENTER", nnt.arrPSCD.get(0).getPROFIT_CENTER());      //PROFIT_CENTER
                    JcoStrI_DATA.setValue("BUSINESS_AREA", nnt.arrPSCD.get(0).getBUSINESS_AREA());      //BUSINESS_AREA
                    JcoStrI_DATA.setValue("SEGMENT", nnt.arrPSCD.get(0).getSEGMENT());                  //SEGMENT
                    JcoStrI_DATA.setValue("PAY_GROUP", nnt.arrPSCD.get(0).getPAY_GROUP());              //PAY_GROUP
                    JcoStrI_DATA.setValue("POSTING_DATE", nnt.arrPSCD.get(0).getPOSTING_DATE());        //POSTING_DATE
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrPSCD.get(0).getSTART_PERIOD());        //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrPSCD.get(0).getEND_PERIOD());            //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrPSCD.get(0).getDUE_DATE());                //DUE_DATE
                    JcoStrI_DATA.setValue("RETURN_CODE", nnt.arrPSCD.get(0).getRETURN_CODE());          //RETURN_CODE
                    JcoStrI_DATA.setValue("AMOUNT", nnt.arrPSCD.get(0).getAMOUNT());                    //AMOUNT
                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*                        
                    // Structure I_FILE
                    fnConvert.getImportParameterList().setValue("I_FILE", ConvertPSCDVATView.name_no);
                    // Structure I_DATA
                    fnConvert.getImportParameterList().setValue("I_DATA", JcoStrI_DATA);

                    fnConvert.execute(destination);

                    //Structure  Export RETURN
                    JCoStructure JcoStrE_RETURN = fnConvert.getExportParameterList().getStructure("RETURN");

                    //System.out.println("TYPE: "+ JcoStrE_RETURN.getValue("TYPE"));

                    if (JcoStrE_RETURN.getValue("TYPE").equals("E")) {

                        //Get log những trường hợp bắn ra ngay
                        String sql_info = "select * from tb_no where id = " + nnt.arrPSCD.get(0).getID();
                        String add_info[];
                        String sort_name = "";
                        String id = "";
                        String tin = "";
                        imp_date = Constants.dateFormat.format(new Date());//import date
                        try {
                            add_info = ConnectDB.getInfoLog(sql_info).split(",");
                            sort_name = add_info[0];
                            id = add_info[1];
                            tin = add_info[2];
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                        String convFont = Tcvn3Converter.convertU(JcoStrE_RETURN.getValue("MESSAGE").toString()).replaceAll("'", "");

                        String SQL = "insert into tb_log_pscd (file_name, tin, msg_no,msg_des,ID,SHORT_NAME,TYPE_DATA,IMP_DATE)"
                                + "values ('" + ConvertPSCDVATView.name_no + "','" + tin + "',"
                                + "'" + JcoStrE_RETURN.getValue("NUMBER") + "','" + convFont.replaceAll("Oõ", "Õ") + "','" + id + "','" + sort_name + "','NO','" + imp_date + "')";
                        try {
                            //write log
                            ConnectDB.sqlDatabase(SQL);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }

                        //Update field Status = 'E' table TB_NO
                        sql_status = "update tb_no set status = 'E' where tin = '" + nnt.arrPSCD.get(0).getTIN() + "' and id = " + nnt.arrPSCD.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    } else {
                        //Update field Status = 'S' table TB_NO
                        sql_status = "update tb_no set status = 'S' where tin = '" + nnt.arrPSCD.get(0).getTIN() + "' and id = " + nnt.arrPSCD.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                    executedCalls++;
                    JCoContext.end(destination);

                } catch (JCoException je) {
                    ex = je;
                    ex.printStackTrace();
                } catch (RuntimeException re) {
                    ex = re;
                    ex.printStackTrace();
                } finally {
                    executedCalls++;
                }

            } else if (type_.equals(Constants.NO) && !chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * B. THỰC HIỆN KIỂM TRA *
                 * *--------------------------------------------------------------------
                 */
                try {

                    JCoContext.begin(destination);
                    //Structure Import I_DATA
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_SOURCE");

                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrPSCD.get(0).getID());                       //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("DOC_TYPE", nnt.arrPSCD.get(0).getDOC_TYPE());                //DOC_TYPE
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrPSCD.get(0).getTAX_OFFICE_CODE());  //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TIN", nnt.arrPSCD.get(0).getTIN());                          //TIN
                    JcoStrI_DATA.setValue("PROFIT_CENTER", nnt.arrPSCD.get(0).getPROFIT_CENTER());      //PROFIT_CENTER
                    JcoStrI_DATA.setValue("BUSINESS_AREA", nnt.arrPSCD.get(0).getBUSINESS_AREA());      //BUSINESS_AREA
                    JcoStrI_DATA.setValue("SEGMENT", nnt.arrPSCD.get(0).getSEGMENT());                  //SEGMENT
                    JcoStrI_DATA.setValue("PAY_GROUP", nnt.arrPSCD.get(0).getPAY_GROUP());              //PAY_GROUP
                    JcoStrI_DATA.setValue("POSTING_DATE", nnt.arrPSCD.get(0).getPOSTING_DATE());        //POSTING_DATE
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrPSCD.get(0).getSTART_PERIOD());        //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrPSCD.get(0).getEND_PERIOD());            //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrPSCD.get(0).getDUE_DATE());                //DUE_DATE
                    JcoStrI_DATA.setValue("RETURN_CODE", nnt.arrPSCD.get(0).getRETURN_CODE());          //RETURN_CODE
                    JcoStrI_DATA.setValue("AMOUNT", nnt.arrPSCD.get(0).getAMOUNT());                    //AMOUNT
                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*                    
                    // Structure I_SOURCE
                    fnConvert.getImportParameterList().setValue("I_SOURCE", JcoStrI_DATA);

                    fnConvert.execute(destination);


                    if (!fnConvert.getExportParameterList().getString("E_ERROR_CODE").isEmpty()) {
                        try {
                            // System.out.println("E_ERROR_CODE: " + fnChkPSCD.getExportParameterList().getString("E_ERROR_CODE"));
                            ConnectDB.insUnSplitErrCode(short_name,
                                    nnt.arrPSCD.get(0).getRID(),
                                    "TB_NO",
                                    fnConvert.getExportParameterList().getString("E_ERROR_CODE"));
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }

                    executedCalls++;
                    JCoContext.end(destination);
                } catch (JCoException je) {
                    try {
                        throw new JCoException(1, "", je.getMessage());
                    } catch (JCoException ex) {
                        ex.printStackTrace();
                    }
                } catch (JCoRuntimeException jr) {
                    throw new JCoRuntimeException(1, "", jr.getMessage());
                } catch (RuntimeException re) {
                    re.printStackTrace();
                } finally {
                    executedCalls++;
                }

            }


            /**
             * ------------------------------------------------------------------------*
             * 02. XỬ LÝ PHÁT SINH *
             * *------------------------------------------------------------------------
             */
            if (type_.equals(Constants.PS) && chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * A. THỰC HIỆN CONVERT *
                 * *--------------------------------------------------------------------
                 */
                try {
                    JCoContext.begin(destination);
                    //Structure I_DATA
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_DATA");
                    JCoStructure JcoStrE_RETURN = null;
                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrPSCD.get(0).getID());                       //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("DOC_TYPE", nnt.arrPSCD.get(0).getDOC_TYPE());                //DOC_TYPE
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrPSCD.get(0).getTAX_OFFICE_CODE());  //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TIN", nnt.arrPSCD.get(0).getTIN());                          //TIN
                    JcoStrI_DATA.setValue("PROFIT_CENTER", nnt.arrPSCD.get(0).getPROFIT_CENTER());      //PROFIT_CENTER
                    JcoStrI_DATA.setValue("BUSINESS_AREA", nnt.arrPSCD.get(0).getBUSINESS_AREA());      //BUSINESS_AREA
                    JcoStrI_DATA.setValue("SEGMENT", nnt.arrPSCD.get(0).getSEGMENT());                  //SEGMENT
                    JcoStrI_DATA.setValue("PAY_GROUP", nnt.arrPSCD.get(0).getPAY_GROUP());              //PAY_GROUP
                    JcoStrI_DATA.setValue("POSTING_DATE", nnt.arrPSCD.get(0).getPOSTING_DATE());        //POSTING_DATE
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrPSCD.get(0).getSTART_PERIOD());        //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrPSCD.get(0).getEND_PERIOD());            //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrPSCD.get(0).getDUE_DATE());                //DUE_DATE
                    JcoStrI_DATA.setValue("RETURN_CODE", nnt.arrPSCD.get(0).getRETURN_CODE());          //RETURN_CODE
                    JcoStrI_DATA.setValue("AMOUNT", nnt.arrPSCD.get(0).getAMOUNT());                    //AMOUNT
                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*
                    // Structure I_FILE
                    fnConvert.getImportParameterList().setValue("I_FILE", ConvertPSCDVATView.name_ps);
                    // Structure I_DATA
                    fnConvert.getImportParameterList().setValue("I_DATA", JcoStrI_DATA);

                    fnConvert.execute(destination);
                    //Structure  Export RETURN
                    JcoStrE_RETURN = fnConvert.getExportParameterList().getStructure("RETURN");
                    //Clear sql
                    sql_status = "";
                    if (JcoStrE_RETURN.getValue("TYPE").equals("E")) {
                        //Get log những trường hợp bắn ra ngay
                        String sql_info = "select * from tb_ps where id = '" + nnt.arrPSCD.get(0).getID().trim() + "'";
                        String add_info[];
                        String sort_name = "";
                        String id = "";
                        String tin = "";
                        //import date
                        imp_date = Constants.dateFormat.format(new Date());
                        try {
                            add_info = ConnectDB.getInfoLog(sql_info).split(",");
                            sort_name = add_info[0];
                            id = add_info[1];
                            tin = add_info[2];
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                        String convFont = Tcvn3Converter.convertU(JcoStrE_RETURN.getValue("MESSAGE").toString()).replaceAll("'", "");

                        String SQL = "insert into tb_log_pscd (file_name, tin, msg_no, msg_des,ID,SHORT_NAME,TYPE_DATA,IMP_DATE)"
                                + "values ('" + ConvertPSCDVATView.name_ps + "','" + tin + "',"
                                + "'" + JcoStrE_RETURN.getValue("NUMBER") + "','" + convFont.replaceAll("Oõ", "Õ") + "','" + id + "','" + sort_name + "','PS','" + imp_date + "')";
                        try {
                            //write log
                            ConnectDB.sqlDatabase(SQL);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }


                        //Update field Status = 'E' table TB_PS
                        sql_status = "update tb_ps set status = 'E' where tin = '" + nnt.arrPSCD.get(0).getTIN() + "' and id = " + nnt.arrPSCD.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    } else {
                        //Update field Status = 'S' table TB_PS
                        sql_status = "update tb_ps set status = 'S' where tin = '" + nnt.arrPSCD.get(0).getTIN() + "' and id = " + nnt.arrPSCD.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }

                    executedCalls++;
                    JCoContext.end(destination);

                } catch (JCoException je) {
                    ex = je;
                    ex.printStackTrace();
                } catch (RuntimeException re) {
                    ex = re;
                    ex.printStackTrace();
                } finally {
                    executedCalls++;
                }

            } else if (type_.equals(Constants.PS) && !chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * B. THỰC HIỆN KIỂM TRA *
                 * *--------------------------------------------------------------------
                 */
                try {
                    JCoContext.begin(destination);
                    //Structure I_SOURCE
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_SOURCE");
                    //JCoStructure JcoStrE_RETURN = null;
                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrPSCD.get(0).getID());                       //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("DOC_TYPE", nnt.arrPSCD.get(0).getDOC_TYPE());                //DOC_TYPE
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrPSCD.get(0).getTAX_OFFICE_CODE());  //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TIN", nnt.arrPSCD.get(0).getTIN());                          //TIN
                    JcoStrI_DATA.setValue("PROFIT_CENTER", nnt.arrPSCD.get(0).getPROFIT_CENTER());      //PROFIT_CENTER
                    JcoStrI_DATA.setValue("BUSINESS_AREA", nnt.arrPSCD.get(0).getBUSINESS_AREA());      //BUSINESS_AREA
                    JcoStrI_DATA.setValue("SEGMENT", nnt.arrPSCD.get(0).getSEGMENT());                  //SEGMENT
                    JcoStrI_DATA.setValue("PAY_GROUP", nnt.arrPSCD.get(0).getPAY_GROUP());              //PAY_GROUP
                    JcoStrI_DATA.setValue("POSTING_DATE", nnt.arrPSCD.get(0).getPOSTING_DATE());        //POSTING_DATE
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrPSCD.get(0).getSTART_PERIOD());        //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrPSCD.get(0).getEND_PERIOD());            //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrPSCD.get(0).getDUE_DATE());                //DUE_DATE
                    JcoStrI_DATA.setValue("RETURN_CODE", nnt.arrPSCD.get(0).getRETURN_CODE());          //RETURN_CODE
                    JcoStrI_DATA.setValue("AMOUNT", nnt.arrPSCD.get(0).getAMOUNT());                    //AMOUNT
                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*                    
                    // Structure I_SOURCE
                    fnConvert.getImportParameterList().setValue("I_SOURCE", JcoStrI_DATA);

                    fnConvert.execute(destination);

                    if (!fnConvert.getExportParameterList().getString("E_ERROR_CODE").isEmpty()) {
                        try {
                            ConnectDB.insUnSplitErrCode(short_name,
                                    nnt.arrPSCD.get(0).getRID(),
                                    "TB_PS",
                                    fnConvert.getExportParameterList().getString("E_ERROR_CODE"));
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }

                    executedCalls++;
                    JCoContext.end(destination);

                } catch (JCoException je) {
                    ex = je;
                    ex.printStackTrace();
                } catch (RuntimeException re) {
                    ex = re;
                    ex.printStackTrace();
                } finally {
                    executedCalls++;
                }
            }



            /**
             * ------------------------------------------------------------------------*
             * 03. XỬ LÝ TỜ KHAI *
             * *------------------------------------------------------------------------
             */
            if (type_.equals(Constants.TK) && chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * A. THỰC HIỆN CONVERT *
                 * *--------------------------------------------------------------------
                 */
                try {

                    JCoContext.begin(destination);
                    //Structure I_DATA
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_DATA");

                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrTK.get(0).getID());                                          //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrTK.get(0).getTAX_OFFICE_CODE());                     //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TAXPAYER_ID", nnt.arrTK.get(0).getTAXPAYER_ID());                             //TAXPAYER_ID
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrTK.get(0).getSTART_PERIOD());                           //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrTK.get(0).getEND_PERIOD());                               //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrTK.get(0).getDUE_DATE());                                   //DUE_DATE
                    JcoStrI_DATA.setValue("A_F08_DOANH_THU_DU_KIEN", nnt.arrTK.get(0).getA_F08_DOANH_THU_DU_KIEN());     //A_F08_DOANH_THU_DU_KIEN
                    JcoStrI_DATA.setValue("A_F09_TY_LE_TNCT_DU_KIEN", nnt.arrTK.get(0).getA_F09_TY_LE_TNCT_DU_KIEN());   //A_F09_TY_LE_TNCT_DU_KIEN
                    JcoStrI_DATA.setValue("C_F10_TNCT_DU_KIEN", nnt.arrTK.get(0).getC_F10_TNCT_DU_KIEN());               //C_F10_TNCT_DU_KIEN
                    JcoStrI_DATA.setValue("C_F11_GIAM_TRU_GC", nnt.arrTK.get(0).getC_F11_GIAM_TRU_GC());                 //C_F11_GIAM_TRU_GC
                    JcoStrI_DATA.setValue("A_F12_GIAM_TRU_BAN_THAN", nnt.arrTK.get(0).getA_F12_GIAM_TRU_BAN_THAN());     //A_F12_GIAM_TRU_BAN_THAN
                    JcoStrI_DATA.setValue("A_F13_GIAM_TRU_NPT", nnt.arrTK.get(0).getA_F13_GIAM_TRU_NPT());               //A_F13_GIAM_TRU_NPT
                    JcoStrI_DATA.setValue("C_F14_THU_NHAP_TINH_THUE", nnt.arrTK.get(0).getC_F14_THU_NHAP_TINH_THUE());   //C_F14_THU_NHAP_TINH_THUE
                    JcoStrI_DATA.setValue("C_F15_THUE_TNCN_DU_KIEN", nnt.arrTK.get(0).getC_F15_THUE_TNCN_DU_KIEN());     //C_F15_THUE_TNCN_DU_KIEN
                    JcoStrI_DATA.setValue("C_F16_THUE_PN_Q1", nnt.arrTK.get(0).getC_F16_THUE_PN_Q1());                   //C_F16_THUE_PN_Q1
                    JcoStrI_DATA.setValue("C_F16_KY_TINH_THUE_Q1", nnt.arrTK.get(0).getC_F16_KY_TINH_THUE_Q1());         //C_F16_KY_TINH_THUE_Q1
                    JcoStrI_DATA.setValue("C_F16_KY_HACH_TOAN_Q1", nnt.arrTK.get(0).getC_F16_KY_HACH_TOAN_Q1());         //C_F16_KY_HACH_TOAN_Q1
                    JcoStrI_DATA.setValue("C_F16_HAN_NOP_Q1", nnt.arrTK.get(0).getC_F16_HAN_NOP_Q1());                   //C_F16_HAN_NOP_Q1
                    JcoStrI_DATA.setValue("C_F17_THUE_PN_Q2", nnt.arrTK.get(0).getC_F17_THUE_PN_Q2());                   //C_F17_THUE_PN_Q2
                    JcoStrI_DATA.setValue("C_F17_KY_TINH_THUE_Q2", nnt.arrTK.get(0).getC_F17_KY_TINH_THUE_Q2());         //C_F17_KY_TINH_THUE_Q2
                    JcoStrI_DATA.setValue("C_F17_KY_HACH_TOAN_Q2", nnt.arrTK.get(0).getC_F17_KY_HACH_TOAN_Q2());         //C_F17_KY_HACH_TOAN_Q2
                    JcoStrI_DATA.setValue("C_F17_HAN_NOP_Q2", nnt.arrTK.get(0).getC_F17_HAN_NOP_Q2());                   //C_F17_HAN_NOP_Q2
                    JcoStrI_DATA.setValue("C_F18_THUE_PN_Q3", nnt.arrTK.get(0).getC_F18_THUE_PN_Q3());                   //C_F18_THUE_PN_Q3
                    JcoStrI_DATA.setValue("C_F18_KY_TINH_THUE_Q3", nnt.arrTK.get(0).getC_F18_KY_TINH_THUE_Q3());         //C_F18_KY_TINH_THUE_Q3
                    JcoStrI_DATA.setValue("C_F18_KY_HACH_TOAN_Q3", nnt.arrTK.get(0).getC_F18_KY_HACH_TOAN_Q3());         //C_F18_KY_HACH_TOAN_Q3
                    JcoStrI_DATA.setValue("C_F18_HAN_NOP_Q3", nnt.arrTK.get(0).getC_F18_HAN_NOP_Q3());                   //C_F18_HAN_NOP_Q3
                    JcoStrI_DATA.setValue("C_F19_THUE_PN_Q4", nnt.arrTK.get(0).getC_F19_THUE_PN_Q4());                   //C_F19_THUE_PN_Q4
                    JcoStrI_DATA.setValue("C_F19_KY_TINH_THUE_Q4", nnt.arrTK.get(0).getC_F19_KY_TINH_THUE_Q4());         //C_F19_KY_TINH_THUE_Q4
                    JcoStrI_DATA.setValue("C_F19_KY_HACH_TOAN_Q4", nnt.arrTK.get(0).getC_F19_KY_HACH_TOAN_Q4());         //C_F19_KY_HACH_TOAN_Q4
                    JcoStrI_DATA.setValue("C_F19_HAN_NOP_Q4", nnt.arrTK.get(0).getC_F19_HAN_NOP_Q4());                   //C_F19_HAN_NOP_Q4
                    JcoStrI_DATA.setValue("F13_MST_DLT", nnt.arrTK.get(0).getF13_MST_DLT());                             //F13_MST_DLT
                    JcoStrI_DATA.setValue("F20_HOP_DONG_DLT_SO", nnt.arrTK.get(0).getF20_HOP_DONG_DLT_SO());             //F20_HOP_DONG_DLT_SO
                    JcoStrI_DATA.setValue("F_HOP_DONG_DLT_NGAY", nnt.arrTK.get(0).getF_HOP_DONG_DLT_NGAY());             //F_HOP_DONG_DLT_NGAY
                    JcoStrI_DATA.setValue("REVERSE_AMOUNT", nnt.arrTK.get(0).getRV_SO_TIEN());                           //REVERSE_AMOUNT


                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*
                    fnConvert.getImportParameterList().setValue("I_FILE", ConvertPSCDVATView.name_tk);

                    fnConvert.getImportParameterList().setValue("I_DATA", JcoStrI_DATA);
                    fnConvert.execute(destination);
                    //Structure  Export RETURN
                    JCoStructure JcoStrE_RETURN = fnConvert.getExportParameterList().getStructure("RETURN");
                    //Clear sql
                    sql_status = "";
                    //Xử lý log tờ khai ghi log vào table tb_log_pscd chuyển trạng thái Status = 'S' or 'E'                     
                    if (JcoStrE_RETURN.getValue("TYPE").equals("E")) {
                        String sql_info = "select * from tb_tk where id = '" + nnt.arrTK.get(0).getID().trim() + "'";
                        String add_info[];
                        String sort_name = "";
                        String id = "";
                        String tin = "";
                        //import date
                        imp_date = Constants.dateFormat.format(new Date());
                        try {
                            add_info = ConnectDB.getInfoLog(sql_info).split(",");
                            sort_name = add_info[0];
                            id = add_info[1];
                            tin = add_info[2];
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }

                        String convFont = Tcvn3Converter.convertU(JcoStrE_RETURN.getValue("MESSAGE").toString()).replaceAll("'", "");

                        String SQL = "insert into tb_log_pscd (file_name, tin, msg_no, msg_des,ID,SHORT_NAME,TYPE_DATA,IMP_DATE)"
                                + "values ('" + ConvertPSCDVATView.name_tk + "','" + tin + "',"
                                + "'" + JcoStrE_RETURN.getValue("NUMBER") + "','" + convFont.replaceAll("Oõ", "Õ") + "','" + id + "','" + sort_name + "','TK','" + imp_date + "')";
                        try {
                            //write log
                            ConnectDB.sqlDatabase(SQL);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }

                        //Update field Status = 'E' table TB_TK
                        sql_status = "update tb_tk set status = 'E' where tin = '" + nnt.arrTK.get(0).getTAXPAYER_ID() + "' and id = " + nnt.arrTK.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    } else {
                        //Update field Status = 'S' table TB_TK
                        sql_status = "update tb_tk set status = 'S' where tin = '" + nnt.arrTK.get(0).getTAXPAYER_ID() + "' and id = " + nnt.arrTK.get(0).getID();
                        try {
                            ConnectDB.sqlDatabase(sql_status);
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                    executedCalls++;
                    JCoContext.end(destination);

                } catch (JCoException je) {
                    try {
                        throw new JCoException(1, "", je.getMessage());
                    } catch (JCoException ex) {
                        ex.printStackTrace();
                    }
                } catch (JCoRuntimeException jr) {
                    throw new JCoRuntimeException(1, "", jr.getMessage());
                } catch (RuntimeException re) {
                    re.printStackTrace();
                } finally {
                    executedCalls++;
                }
            } else if (type_.equals(Constants.TK) && !chk_pscd.isEmpty()) {
                /**
                 * --------------------------------------------------------------------*
                 * B. THỰC HIỆN KIỂM TRA *
                 * *--------------------------------------------------------------------
                 */
                try {

                    JCoContext.begin(destination);
                    //Structure I_DATA
                    JCoStructure JcoStrI_DATA = fnConvert.getImportParameterList().getStructure("I_DATA");

                    JcoStrI_DATA.setValue("ROW_NUM", nnt.arrTK.get(0).getID());                                          //ROW_NUM thay bằng ID vì ROW_NUM có thể trung nhau
                    JcoStrI_DATA.setValue("TAX_OFFICE_CODE", nnt.arrTK.get(0).getTAX_OFFICE_CODE());                     //TAX_OFFICE_CODE
                    JcoStrI_DATA.setValue("TAXPAYER_ID", nnt.arrTK.get(0).getTAXPAYER_ID());                             //TAXPAYER_ID
                    JcoStrI_DATA.setValue("START_PERIOD", nnt.arrTK.get(0).getSTART_PERIOD());                           //START_PERIOD
                    JcoStrI_DATA.setValue("END_PERIOD", nnt.arrTK.get(0).getEND_PERIOD());                               //END_PERIOD
                    JcoStrI_DATA.setValue("DUE_DATE", nnt.arrTK.get(0).getDUE_DATE());                                   //DUE_DATE
                    JcoStrI_DATA.setValue("A_F08_DOANH_THU_DU_KIEN", nnt.arrTK.get(0).getA_F08_DOANH_THU_DU_KIEN());     //A_F08_DOANH_THU_DU_KIEN
                    JcoStrI_DATA.setValue("A_F09_TY_LE_TNCT_DU_KIEN", nnt.arrTK.get(0).getA_F09_TY_LE_TNCT_DU_KIEN());   //A_F09_TY_LE_TNCT_DU_KIEN
                    JcoStrI_DATA.setValue("C_F10_TNCT_DU_KIEN", nnt.arrTK.get(0).getC_F10_TNCT_DU_KIEN());               //C_F10_TNCT_DU_KIEN
                    JcoStrI_DATA.setValue("C_F11_GIAM_TRU_GC", nnt.arrTK.get(0).getC_F11_GIAM_TRU_GC());                 //C_F11_GIAM_TRU_GC
                    JcoStrI_DATA.setValue("A_F12_GIAM_TRU_BAN_THAN", nnt.arrTK.get(0).getA_F12_GIAM_TRU_BAN_THAN());     //A_F12_GIAM_TRU_BAN_THAN
                    JcoStrI_DATA.setValue("A_F13_GIAM_TRU_NPT", nnt.arrTK.get(0).getA_F13_GIAM_TRU_NPT());               //A_F13_GIAM_TRU_NPT
                    JcoStrI_DATA.setValue("C_F14_THU_NHAP_TINH_THUE", nnt.arrTK.get(0).getC_F14_THU_NHAP_TINH_THUE());   //C_F14_THU_NHAP_TINH_THUE
                    JcoStrI_DATA.setValue("C_F15_THUE_TNCN_DU_KIEN", nnt.arrTK.get(0).getC_F15_THUE_TNCN_DU_KIEN());     //C_F15_THUE_TNCN_DU_KIEN
                    JcoStrI_DATA.setValue("C_F16_THUE_PN_Q1", nnt.arrTK.get(0).getC_F16_THUE_PN_Q1());                   //C_F16_THUE_PN_Q1
                    JcoStrI_DATA.setValue("C_F16_KY_TINH_THUE_Q1", nnt.arrTK.get(0).getC_F16_KY_TINH_THUE_Q1());         //C_F16_KY_TINH_THUE_Q1
                    JcoStrI_DATA.setValue("C_F16_KY_HACH_TOAN_Q1", nnt.arrTK.get(0).getC_F16_KY_HACH_TOAN_Q1());         //C_F16_KY_HACH_TOAN_Q1
                    JcoStrI_DATA.setValue("C_F16_HAN_NOP_Q1", nnt.arrTK.get(0).getC_F16_HAN_NOP_Q1());                   //C_F16_HAN_NOP_Q1
                    JcoStrI_DATA.setValue("C_F17_THUE_PN_Q2", nnt.arrTK.get(0).getC_F17_THUE_PN_Q2());                   //C_F17_THUE_PN_Q2
                    JcoStrI_DATA.setValue("C_F17_KY_TINH_THUE_Q2", nnt.arrTK.get(0).getC_F17_KY_TINH_THUE_Q2());         //C_F17_KY_TINH_THUE_Q2
                    JcoStrI_DATA.setValue("C_F17_KY_HACH_TOAN_Q2", nnt.arrTK.get(0).getC_F17_KY_HACH_TOAN_Q2());         //C_F17_KY_HACH_TOAN_Q2
                    JcoStrI_DATA.setValue("C_F17_HAN_NOP_Q2", nnt.arrTK.get(0).getC_F17_HAN_NOP_Q2());                   //C_F17_HAN_NOP_Q2
                    JcoStrI_DATA.setValue("C_F18_THUE_PN_Q3", nnt.arrTK.get(0).getC_F18_THUE_PN_Q3());                   //C_F18_THUE_PN_Q3
                    JcoStrI_DATA.setValue("C_F18_KY_TINH_THUE_Q3", nnt.arrTK.get(0).getC_F18_KY_TINH_THUE_Q3());         //C_F18_KY_TINH_THUE_Q3
                    JcoStrI_DATA.setValue("C_F18_KY_HACH_TOAN_Q3", nnt.arrTK.get(0).getC_F18_KY_HACH_TOAN_Q3());         //C_F18_KY_HACH_TOAN_Q3
                    JcoStrI_DATA.setValue("C_F18_HAN_NOP_Q3", nnt.arrTK.get(0).getC_F18_HAN_NOP_Q3());                   //C_F18_HAN_NOP_Q3
                    JcoStrI_DATA.setValue("C_F19_THUE_PN_Q4", nnt.arrTK.get(0).getC_F19_THUE_PN_Q4());                   //C_F19_THUE_PN_Q4
                    JcoStrI_DATA.setValue("C_F19_KY_TINH_THUE_Q4", nnt.arrTK.get(0).getC_F19_KY_TINH_THUE_Q4());         //C_F19_KY_TINH_THUE_Q4
                    JcoStrI_DATA.setValue("C_F19_KY_HACH_TOAN_Q4", nnt.arrTK.get(0).getC_F19_KY_HACH_TOAN_Q4());         //C_F19_KY_HACH_TOAN_Q4
                    JcoStrI_DATA.setValue("C_F19_HAN_NOP_Q4", nnt.arrTK.get(0).getC_F19_HAN_NOP_Q4());                   //C_F19_HAN_NOP_Q4
                    JcoStrI_DATA.setValue("F13_MST_DLT", nnt.arrTK.get(0).getF13_MST_DLT());                             //F13_MST_DLT
                    JcoStrI_DATA.setValue("F20_HOP_DONG_DLT_SO", nnt.arrTK.get(0).getF20_HOP_DONG_DLT_SO());             //F20_HOP_DONG_DLT_SO
                    JcoStrI_DATA.setValue("F_HOP_DONG_DLT_NGAY", nnt.arrTK.get(0).getF_HOP_DONG_DLT_NGAY());             //F_HOP_DONG_DLT_NGAY
                    JcoStrI_DATA.setValue("REVERSE_AMOUNT", nnt.arrTK.get(0).getRV_SO_TIEN());                           //REVERSE_AMOUNT


                    //**-----------------------------------------------------------------------*
                    //**Get value parameter and execute                                        *
                    //**-----------------------------------------------------------------------*

                    fnConvert.getImportParameterList().setValue("I_FILE", "TKQLT20100101_50901_1252.CSV");

                    fnConvert.getImportParameterList().setValue("I_DATA", JcoStrI_DATA);
                    fnConvert.execute(destination);

                    if (!fnConvert.getExportParameterList().getString("E_ERROR_CODE").isEmpty()) {
                        try {
                            ConnectDB.insUnSplitErrCode(short_name, nnt.arrTK.get(0).getRID(), "TB_TK",
                                    fnConvert.getExportParameterList().getString("E_ERROR_CODE"));
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }

                    executedCalls++;
                    JCoContext.end(destination);

                } catch (JCoException je) {
                    try {
                        throw new JCoException(1, "", je.getMessage());
                    } catch (JCoException ex) {
                        ex.printStackTrace();
                    }
                } catch (JCoRuntimeException jr) {
                    throw new JCoRuntimeException(1, "", jr.getMessage());
                } catch (RuntimeException re) {
                    re.printStackTrace();
                } finally {
                    executedCalls++;
                }
            }


        }

        @Override
        public void cleanUp() {
            try {
                JCoContext.end(destination);
            } catch (JCoException je) {
                ex = je;
                logger.log(Level.WARNING, "JCoException: ", je);
            }
            super.cleanUp();
        }
    }

    /**
     * Thực hiện chuyển đổi dữ liệu NPT
     *
     * @throws ParserConfigurationException
     * @throws IOException
     * @throws JCoException
     * @throws SQLException
     */
    static void convertNPT() throws ParserConfigurationException, IOException, JCoException, SQLException {
        try {
            JCoDestination destination = JCoDestinationManager.getDestination(DESTINATION_NAME1);          
            convertNPT = destination.getRepository().getFunctionTemplate("ZFM_IMP_APPENDIX_10");
            JCoFunction fn_imp_appendix_10 = convertNPT.getFunction();
            //import parameter
            JCoTable tblInGT_APPENDIX = fn_imp_appendix_10.getTableParameterList().getTable("GT_APPENDIX");
            //export parameter
            JCoTable tblExGT_APPENDIX = fn_imp_appendix_10.getTableParameterList().getTable("GT_APPENDIX");

            int NumberOfNPT = arrNPT.size(); 
            for (int i = 0; i < NumberOfNPT; i++) {

                for (int r = 0; r < arrNPT.get(i).arrdtNPT.size(); r++) {
                    tblInGT_APPENDIX.appendRow();
                    tblInGT_APPENDIX.setValue("ID", arrNPT.get(i).arrdtNPT.get(r).getID());
                    tblInGT_APPENDIX.setValue("TIN", arrNPT.get(i).arrdtNPT.get(r).getTIN());
                    tblInGT_APPENDIX.setValue("PERIOD_KEY", arrNPT.get(i).arrdtNPT.get(r).getPERIOD_KEY());
                    tblInGT_APPENDIX.setValue("FBTYP", arrNPT.get(i).arrdtNPT.get(r).getFBTYP());
                    tblInGT_APPENDIX.setValue("APPEN_ID", arrNPT.get(i).arrdtNPT.get(r).getAPPEN_ID());
                    tblInGT_APPENDIX.setValue("TAXPAYER_ID", arrNPT.get(i).arrdtNPT.get(r).getTAXPAYER_ID());
                    tblInGT_APPENDIX.setValue("TAXPAYER_NAME", Tcvn3Converter.convert(arrNPT.get(i).arrdtNPT.get(r).getTAXPAYER_NAME()));
                    tblInGT_APPENDIX.setValue("BIRTHDAY", arrNPT.get(i).arrdtNPT.get(r).getBIRTHDAY());
                    tblInGT_APPENDIX.setValue("IDENTIFY_NUM", arrNPT.get(i).arrdtNPT.get(r).getIDENTIFY_NUM());
                    tblInGT_APPENDIX.setValue("RELATIONSHIP", Tcvn3Converter.convert(arrNPT.get(i).arrdtNPT.get(r).getRELATIONSHIP()));
                    tblInGT_APPENDIX.setValue("NUM_OF_RELIEF", arrNPT.get(i).arrdtNPT.get(r).getNUM_OF_RELIEF());
                    tblInGT_APPENDIX.setValue("INCOME_RELIEF", arrNPT.get(i).arrdtNPT.get(r).getINCOME_RELIEF());
                    tblInGT_APPENDIX.setValue("RELATIONSHIP_WH", arrNPT.get(i).arrdtNPT.get(r).getRELATIONSHIP_WH());
                    tblInGT_APPENDIX.setValue("BUKRS", arrNPT.get(i).arrdtNPT.get(r).getBUKRS());
                    tblInGT_APPENDIX.setValue("MA_QLT", arrNPT.get(i).arrdtNPT.get(r).getMA_QLT());

                }

            }
            //Execute
            fn_imp_appendix_10.execute(destination);

            /**
             * Set Country name for Header
             */
            tblExGT_APPENDIX.firstRow();
            String sql = "";
            String mess = "";
            for (int i = 0; i < tblExGT_APPENDIX.getNumRows(); i++) {
                tblExGT_APPENDIX.setRow(i);

                //update lại thông tin Status và Message                
                mess = Tcvn3Converter.convertU(tblExGT_APPENDIX.getString("MESSAGE").replaceAll("'", ""));
                sql = "update tb_pt set status = '" + tblExGT_APPENDIX.getString("STATUS") + "',  message = '" + mess + "' where id = " + tblExGT_APPENDIX.getString("ID");

                //Update table TB_PT
                ConnectDB.sqlDatabase(sql);
            }            
        } catch (JCoException je) {
            throw new JCoException(1, "", je.getMessage());
        } catch (JCoRuntimeException jr) {
            throw new JCoRuntimeException(1, "", jr.getMessage());
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }

    static class MySessionReferenceProvider implements SessionReferenceProvider {

        public JCoSessionReference getCurrentSessionReference(String scopeType) {
            MySessionReference sesRef = WorkerThread.localSessionReference.get();
            if (sesRef != null) {
                return sesRef;
            }

            throw new RuntimeException("Unknown thread:" + Thread.currentThread().getId());
        }

        public boolean isSessionAlive(String sessionId) {
            Collection<MySessionReference> availableSessions = WorkerThread.sessions.values();
            for (MySessionReference ref : availableSessions) {
                if (ref.getID().equals(sessionId)) {
                    return true;
                }
            }
            return false;
        }

        public void jcoServerSessionContinued(String sessionID) throws SessionException {
        }

        public void jcoServerSessionFinished(String sessionID) {
        }

        public void jcoServerSessionPassivated(String sessionID) throws SessionException {
        }

        public JCoSessionReference jcoServerSessionStarted() throws SessionException {
            return null;
        }
    }

    static class MySessionReference implements JCoSessionReference {

        static AtomicInteger atomicInt = new AtomicInteger(0);
        private String id = "session-" + String.valueOf(atomicInt.addAndGet(1));

        ;

          public void contextFinished() {
        }

        public void contextStarted() {
        }

        public String getID() {
            return id;
        }
    }

    static class WorkerThread extends Thread {

        static Hashtable<MultiStepJob, MySessionReference> sessions = new Hashtable<MultiStepJob, MySessionReference>();
        static ThreadLocal<MySessionReference> localSessionReference = new ThreadLocal<MySessionReference>();
        private CountDownLatch doneSignal;

        WorkerThread(CountDownLatch doneSignal) {
            this.doneSignal = doneSignal;
        }

        @Override
        public void run() {
            try {
                for (;;) {
                    MultiStepJob job = queue.poll(1, TimeUnit.SECONDS);

                    //stop if nothing to do
                    if (job == null) {
                        return;
                    }
                    MySessionReference sesRef = sessions.get(job);
                    if (sesRef == null) {
                        sesRef = new MySessionReference();
                        sessions.put(job, sesRef);
                    }
                    localSessionReference.set(sesRef);

                    System.out.println("Task " + job.getName() + " is started.");
                    try {
                        job.runNextStep();
                    } catch (Throwable th) {
                    }
                    if (job.isFinished()) {
                        System.out.println("Task " + job.getName() + " is finished.");
                        sessions.remove(job);
                        job.cleanUp();
                    } else {
                        System.out.println("Task " + job.getName() + " is passivated.");
                        queue.add(job);
                    }
                    localSessionReference.set(null);
                }
            } catch (InterruptedException e) {
                //just leave
                logger.log(Level.WARNING, "InterruptException:", e);
            } finally {
                doneSignal.countDown();
            }
        }
    }

    /**
     * PSCD(NO, PS) mặc định là 1 thread vì khi xử lý trong SAP log table nên
     * không xử lý nhiều thread đc Tờ khai (TK) xử lý nhiều thread
     *
     * @param destination
     * @param callFunc
     * @param thread_vat
     * @param short_name
     */
    static void runJobs(JCoDestination destination, String callFunc, int thread_vat, String short_name, String chk_pscd) {
        for (int i = 0; i < arrData.size(); i++) {
            queue.add(new StatefulMultiStepNNTExample(destination, 1, callFunc, arrData.get(i), short_name, chk_pscd));
        }
        CountDownLatch doneSignal;
        if (callFunc.equals(Constants.TK)) {
            doneSignal = new CountDownLatch(thread_vat);
            for (int i = 0; i < thread_vat; i++) {
                new WorkerThread(doneSignal).start();
            }
        } else if (callFunc.equals(Constants.PS) && chk_pscd.equals("X")) {
            doneSignal = new CountDownLatch(thread_vat);
            for (int i = 0; i < thread_vat; i++) {
                new WorkerThread(doneSignal).start();
            }
        } else if (callFunc.equals(Constants.NO) && chk_pscd.equals("X")) {
            doneSignal = new CountDownLatch(thread_vat);
            for (int i = 0; i < thread_vat; i++) {
                new WorkerThread(doneSignal).start();
            }
        } else {
            doneSignal = new CountDownLatch(Constants.NUMBER_OF_PROCESS_PSCD);
            for (int i = 0; i < Constants.NUMBER_OF_PROCESS_PSCD; i++) {
                new WorkerThread(doneSignal).start();
            }
        }

        try {
            doneSignal.await();
        } catch (InterruptedException ie) {
            //just leave
            logger.log(Level.WARNING, "InterruptException:", ie);
        }
        //System.out.println(">>> Done");
        //******************* CLEAR ARRAY INFOR DATA IN FILE CSV *************
        //--------------------------------------------------------------------          
        arrData.clear();
        //Lấy file name đã convert 
        ConvertPSCDVATView.getSuccesFile(">>> DONE " + short_name + " DATA " + callFunc + " !!!");
    }

    // Load data PSCD sau khi lấy từng loại dữ liệu (NO, PS, TK) trong database
    static void loadQueue(DataCVPSCD nnt)// throws AbapException
    {
        try {
            arrData.add(nnt);
        } catch (JCoRuntimeException jrex) {
            //System.out.println(jrex.getMessage());
            logger.log(Level.WARNING, "JCoRuntimeException :", jrex);

        } catch (Exception ex) {
            //System.out.println(ex.getMessage());
            logger.log(Level.WARNING, "Exception:", ex);
        }
    }

    // Load data PSCD sau khi lấy từng loại dữ liệu (NO, PS, TK) trong database
    static void loadQueueNPT(DataCVNPT npt)// throws AbapException
    {
        try {
            arrNPT.add(npt);
        } catch (JCoRuntimeException jrex) {
            //System.out.println(jrex.getMessage());
            logger.log(Level.WARNING, "JCoRuntimeException :", jrex.getMessage());

        } catch (Exception ex) {
            //System.out.println(ex.getMessage());
            logger.log(Level.WARNING, "Exception:", ex.getMessage());
        }
    }

    /**
     * 
     * Thực hiện ghi log sau khi chuyển đôi
     * @param file
     * @param tax
     * @throws AbapException 
     */
    static void sqlDatabase(String file, String tax) throws AbapException {
        try {
            JCoDestination destination = JCoDestinationManager.getDestination(DESTINATION_NAME2);
            convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZFM_GET_LOG_PSCD");
            JCoFunction fnLog = convertDKTTemplate.getFunction();
            //Xác định loại log                  
            char log_type = file.charAt(0);
            //SQL add info (short_name, id)
            String sql_info = "";
            //type data
            String type_data = "";
            //import date
            String imp_date = "";

            switch (log_type) {

                case 'N':
                    fnLog.getImportParameterList().setValue("I_PROJECT", Constants.LOG_PROJECT);
                    fnLog.getImportParameterList().setValue("I_SUBPRO", Constants.LOG_SUB_PSCD_CD);
                    fnLog.getImportParameterList().setValue("I_OBJECT", destination.getUser().toUpperCase());
                    fnLog.getImportParameterList().setValue("I_FILE", file);
                    type_data = "NO";
                    break;

                case 'P':
                    fnLog.getImportParameterList().setValue("I_PROJECT", Constants.LOG_PROJECT);
                    fnLog.getImportParameterList().setValue("I_SUBPRO", Constants.LOG_SUB_PSCD_TK);
                    fnLog.getImportParameterList().setValue("I_OBJECT", destination.getUser().toUpperCase());
                    fnLog.getImportParameterList().setValue("I_FILE", file);
                    type_data = "PS";
                    break;

                case 'T':
                    fnLog.getImportParameterList().setValue("I_PROJECT", Constants.LOG_PRO_FORM_10);
                    fnLog.getImportParameterList().setValue("I_SUBPRO", Constants.LOG_SUB_FORM_10);
                    fnLog.getImportParameterList().setValue("I_OBJECT", destination.getUser().toUpperCase());
                    fnLog.getImportParameterList().setValue("I_FILE", file);
                    type_data = "TK";
                    break;

                default:
                    break;
            }
            //Execute
            fnLog.execute(destination);

            //Table TB_LOG_PSCD
            JCoTable t_pscd = fnLog.getTableParameterList().getTable("TB_LOG_PSCD");

            //Table TB_FORM_10_ERR
            JCoTable t_form_10 = fnLog.getTableParameterList().getTable("TB_FORM_10_ERR");

            //SQL -> write log to table tb_log_pscd
            String SQL = "";
            /*
             * WRITE LOG TỜ KHAI
             */
            if (log_type == 'T') {

                t_form_10.firstRow();

                int numRows = t_form_10.getNumRows();

                String short_name = "";//Tên ngắn cơ quan thuế
                String id = "";//key trong table NO, PS, TK  
                String tin = "";//mã tinh
                if (numRows > 0) {

                    for (int i = 0; i < numRows; i++) {
                        t_form_10.setRow(i);
                        //Add info short_name, id                    
                        sql_info = "select * from tb_tk where id = " + t_form_10.getString("ROW_NUM").trim();
                        String add_info[] = ConnectDB.getInfoLog(sql_info).split(",");
                        short_name = add_info[0];
                        id = add_info[1];
                        tin = add_info[2];
                        //import date
                        imp_date = Constants.dateFormat.format(new Date());
                        //Convert font
                        String convFont = Tcvn3Converter.convertU(t_form_10.getString("MESSAGE").replaceAll("'", ""));
                        SQL = "insert into tb_log_pscd (tin, FIELDNAME, MSG_NO, MSG_TYPE, msg_des, file_name,ID,SHORT_NAME,TYPE_DATA,IMP_DATE) "
                                + "values ('" + tin + "','" + t_form_10.getString("FIELDNAME")
                                + "','" + t_form_10.getString("MSGNUMBER") + "','" + t_form_10.getString("MSGTYPE") + "','" + convFont.replaceAll("Oõ", "Õ") + "','" + file
                                + "','" + id + "','" + short_name + "','" + type_data + "','" + imp_date + "')";

                        //action write log
                        ConnectDB.sqlDatabase(SQL);
                    }
                }

            } 
            /* WRITE LOG NỢ, PHÁT SINH */             
            else {
                t_pscd.firstRow();
                int numRows = t_pscd.getNumRows();
                //Add info short_name, id                
                sql_info = "";
                String sort_name = "";
                String id = "";
                if (numRows > 0) {

                    for (int i = 0; i < numRows; i++) {
                        t_pscd.setRow(i);
                        if (type_data.equals(Constants.NO)) {
                            // add short_name and id to table tb_log_pscd                        
                            sql_info = "select * from tb_no where id = " + t_pscd.getString("RECORD_NUM").trim();

                            String add_info[] = ConnectDB.getInfoLog(sql_info).split(",");
                            sort_name = add_info[0];
                            id = add_info[1];
                        } else {
                            sql_info = "select * from tb_ps where id = " + t_pscd.getString("RECORD_NUM").trim();                            
                            String add_info[] = ConnectDB.getInfoLog(sql_info).split(",");
                            sort_name = add_info[0];
                            id = add_info[1];
                        }

                        //import date
                        imp_date = Constants.dateFormat.format(new Date());
                        //Convert font
                        String convFont_ = Tcvn3Converter.convertU(t_pscd.getString("MSG_DES")).replaceAll("'", "");

                        SQL = "insert into tb_log_pscd (tin, msg_no, msg_des, process_step, status,FILE_NAME,ID,SHORT_NAME,TYPE_DATA,IMP_DATE) "
                                + "values ('" + t_pscd.getString("TIN") + "','" + t_pscd.getString("MSG_NO")
                                + "','" + convFont_.replaceAll("Oõ", "Õ") + "','" + t_pscd.getString("PROCESS_STEP") + "','" + Tcvn3Converter.convertU(t_pscd.getString("STATUS")) + "','" + file
                                + "','" + id + "','" + sort_name + "','" + type_data + "','" + imp_date + "'" + ")";
                        //action write log
                        ConnectDB.sqlDatabase(SQL);
                    }
                }
            }

        } catch (AbapException aex) {
            if (aex.getMessage().equals("NOT_FOUND")) {
                throw new AbapException(aex.getMessage());
            }
        } catch (JCoException jex) {
            logger.log(Level.WARNING, "JCoException:", jex);
        } catch (JCoRuntimeException jrex) {
            logger.log(Level.WARNING, "JCoRuntimeException :", jrex);

        } catch (Exception ex) {
            ex.printStackTrace();
            logger.log(Level.WARNING, "Exception:", ex);
        }

    }

    /**
     * Thực hiện chuyển đội và kiểm tra dữ liệu dữ liệu
     * @param type_cv
     * @param thread_vat
     * @param short_name
     * @param chk_pscd
     * @throws ParserConfigurationException
     * @throws IOException
     * @throws JCoException 
     */
    static void runConvert(String type_cv, int thread_vat, String short_name, String chk_pscd) throws ParserConfigurationException, IOException, JCoException {
        MySessionReferenceProvider mySessionRP = new MySessionReferenceProvider();
        Environment.registerSessionReferenceProvider(mySessionRP);
        try {
            //Get properties SAP, call function, and convert data to PIT
            JCoDestination destination = JCoDestinationManager.getDestination(DESTINATION_NAME2);

            // Xử lý Nợ
            if (type_cv.equals(Constants.NO) && chk_pscd.isEmpty()) {
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZBAPI_PSCD_CD_DC");
            }
            if (type_cv.equals(Constants.NO) && chk_pscd.equals("X")) { // Kiểm tra Nợ
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZFM_PSCD_MAPPING_DC");
            }
            //Xử lý Phát sinh
            if (type_cv.equals(Constants.PS) && chk_pscd.isEmpty()) {
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZBAPI_PSCD_TK_DC");
            }
            if (type_cv.equals(Constants.PS) && chk_pscd.equals("X")) { // Kiểm tra Phát sinh
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZFM_PSCD_MAPPING_TK_DC");
            }
            //Xử lý Tờ khai
            if (type_cv.equals(Constants.TK) && chk_pscd.isEmpty()) {
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZBAPI_DETAIL_10");
            }
            if (type_cv.equals(Constants.TK) && chk_pscd.equals("X")) { // Kiểm tra Tờ khai
                convertDKTTemplate = destination.getRepository().getFunctionTemplate("ZBAPI_DETAIL_10_CHECK");
            }

            if (convertDKTTemplate == null) {
                throw new RuntimeException("Service could not run due to lack of function");
            }

            runJobs(destination, type_cv, thread_vat, short_name, chk_pscd);

        } catch (JCoException je) {
            //je.printStackTrace();
            throw new JCoException(thread_vat, type_cv, je.getMessage());
//            logger.log(Level.WARNING, "JCoException: ", je.getMessage());
        } catch (RuntimeException e) {
//            logger.log(Level.WARNING, "Lỗi RuntimeExceptions: ", e.getMessage());
        }
        Environment.unregisterSessionReferenceProvider(mySessionRP);
    }
}
