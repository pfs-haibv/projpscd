package com.pit.convert;

import com.pit.conn.ConnectDB;
import com.sap.conn.jco.AbapException;
import com.sap.conn.jco.JCoException;
import javax.xml.parsers.ParserConfigurationException;

import org.jdesktop.application.Action;
import org.jdesktop.application.ResourceMap;
import org.jdesktop.application.SingleFrameApplication;
import org.jdesktop.application.FrameView;
import org.jdesktop.application.TaskMonitor;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

import javax.swing.Timer;
import javax.swing.Icon;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import com.pit.system.Constants;
import com.pit.utility.Utility;
import com.pit.exltoora.ImpExlToOra;
import java.util.ArrayList;
import com.pit.list.SortedListModel;
import com.sap.conn.jco.JCoRuntimeException;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

/**
 * The application's main frame.
 */
public class ConvertPSCDVATView extends FrameView {

    private String tax_code_[] = new String[759];
    private String short_name_[] = new String[759];
    public static String name_no = "", name_ps = "", name_tk = "";
    private String status = "";//Status lỗi dữ liệu trong file
    private ArrayList<String> cqt_convert = new ArrayList<String>();
    private ArrayList<String> cqt_convert_npt = new ArrayList<String>();

    public ConvertPSCDVATView(SingleFrameApplication app) {
        super(app);

        initComponents();
        //set default button
        this.getRootPane().setDefaultButton(btnConvert);

        try {
            //Initial commobox CQT           
            loadCQT();

            // Đặt listenner cho combobox CQT            
            cboCQT.addItemListener(new ItemListener() {

                /**
                 * Xử lý sự kiện khi item được chọn thay đổi
                 */
                @Override                
                public void itemStateChanged(ItemEvent e) {                    
                    getListCQT(cboCQT.getSelectedItem().toString());
                    // Xóa toàn bộ chi cục thuế convert
                    destListModel.clear();
                    lstCCT_CV.setModel(destListModel);
                    //throw new UnsupportedOperationException("Not supported yet.");
                }
            });


            //Initial list chi cục thuế
            getListCQT(cboCQT.getSelectedItem().toString());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        // status bar initialization - message timeout, idle icon and busy animation, etc
        ResourceMap resourceMap = getResourceMap();
        int messageTimeout = resourceMap.getInteger("StatusBar.messageTimeout");
        messageTimer = new Timer(messageTimeout, new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                statusMessageLabel.setText("");
            }
        });
        messageTimer.setRepeats(false);
        int busyAnimationRate = resourceMap.getInteger("StatusBar.busyAnimationRate");
        for (int i = 0; i < busyIcons.length; i++) {
            busyIcons[i] = resourceMap.getIcon("StatusBar.busyIcons[" + i + "]");
        }
        busyIconTimer = new Timer(busyAnimationRate, new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                busyIconIndex = (busyIconIndex + 1) % busyIcons.length;
                statusAnimationLabel.setIcon(busyIcons[busyIconIndex]);
            }
        });
        idleIcon = resourceMap.getIcon("StatusBar.idleIcon");
        statusAnimationLabel.setIcon(idleIcon);
        progressBar.setVisible(false);

        // connecting action tasks to status bar via TaskMonitor
        TaskMonitor taskMonitor = new TaskMonitor(getApplication().getContext());
        taskMonitor.addPropertyChangeListener(new java.beans.PropertyChangeListener() {

            public void propertyChange(java.beans.PropertyChangeEvent evt) {
                String propertyName = evt.getPropertyName();
                if ("started".equals(propertyName)) {
                    if (!busyIconTimer.isRunning()) {
                        statusAnimationLabel.setIcon(busyIcons[0]);
                        busyIconIndex = 0;
                        busyIconTimer.start();
                    }
                    progressBar.setVisible(true);
                    progressBar.setIndeterminate(true);
                } else if ("done".equals(propertyName)) {
                    busyIconTimer.stop();
                    statusAnimationLabel.setIcon(idleIcon);
                    progressBar.setVisible(false);
                    progressBar.setValue(0);
                } else if ("message".equals(propertyName)) {
                    String text = (String) (evt.getNewValue());
                    statusMessageLabel.setText((text == null) ? "" : text);
                    messageTimer.restart();
                } else if ("progress".equals(propertyName)) {
                    int value = (Integer) (evt.getNewValue());
                    progressBar.setVisible(true);
                    progressBar.setIndeterminate(false);
                    progressBar.setValue(value);
                }
            }
        });
    }

    /**
     * Load toàn bộ cục và chi cục thuế
     *
     * @throws SQLException
     */
    public void loadCQT() throws SQLException {

        //Initial commobox CQT
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery("SELECT a.tax_code, a.short_name FROM tb_lst_taxo a order by a.short_name");
            int i = 0;
            //Danh sách cqt nhập ngoài
            cboNhapNgoai.addItem("Tất cả");
            while (rset.next()) {
                //add combobox
                if (rset.getString("short_name").length() == 3) {
                    //Lấy nguyên CQT không lấy chi cục
                    cboCQT.addItem(rset.getString("short_name"));
                }
                cboCQTUtility.addItem(rset.getString("short_name"));
                cboNhapNgoai.addItem(rset.getString("short_name"));
                //add array
                tax_code_[i] = rset.getString("tax_code");
                short_name_[i] = rset.getString("short_name");

                i++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Lấy thông tin của tất cả các chi cục của CQT
     *
     * @param cqt
     */
    public void getListCQT(String cqt) {
        sourceListModel.clear();
        //Lấy danh sách CQT
        for (int i = 0; i < short_name_.length; i++) {
            if (short_name_[i].subSequence(0, 3).equals(cqt)) {
                sourceListModel.add(short_name_[i]);
            }
            lstCCT.setModel(sourceListModel);

        }


        for (int i = 0; i < lstCCT.getModel().getSize(); i++) {
            sourceListModel.add(lstCCT.getModel().getElementAt(i));
        }
        Object selected[] = lstCCT.getSelectedValues();
        addDestinationElements(selected);
        clearSourceSelected();
        lstCCT_CV.setModel(destListModel);
    }

    /**
     * Lấy dữ liệu NPT trước và sau khi chuyển đổi
     *
     * @param short_name
     * @throws SQLException
     */
    public void loadCQTConvertNPT(String short_name) throws SQLException {
        //Clear data NPT
        cqt_convert_npt.clear();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        String sql = "";
        try {
            conn = ConvertPSCDVATApp.connORA;
            sql = "SELECT   short_name, 'PT' AS data_type,status, COUNT (*) AS soluong,                                           "
                    + "(SELECT   COUNT (*) FROM   tb_pt  WHERE   short_name in (" + short_name + ")) AS total   "
                    + "FROM   tb_pt  WHERE   short_name in (" + short_name + ") GROUP BY   short_name, status";

            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);

            while (rset.next()) {
                cqt_convert_npt.add(rset.getString("short_name") + "," + rset.getString("data_type") + "," + rset.getString("status") + "," + rset.getString("soluong") + "/" + rset.getString("total"));
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//          conn.close();
        }

    }

    /**
     * Kiểm tra cqt đã chuyển đổi hay chưa Nếu chuyển đổi rồi đưa ra thông tin
     * chuyển đổi
     *
     * @param short_name
     * @throws SQLException
     */
    public void loadCQTConvertPSCD(String short_name, String[] type_cv) throws SQLException {

        //Clear 
        cqt_convert.clear();
        //Initial commobox CQT
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;

        String Flag_NO = "";
        String Flag_PS = "";

        try {
            conn = ConvertPSCDVATApp.connORA;
            StringBuffer sql = new StringBuffer();

            //Kiểm tra khi thực hiện convert với NO
            if (type_cv[0].equals(Constants.NO)) {
                sql.append("SELECT   short_name, status, COUNT (*) AS soluong, 'NO' AS data_type,"
                        + "  (SELECT   COUNT (*) FROM   tb_no  WHERE   short_name in (" + short_name + ")) AS total"
                        + "   FROM   tb_no  WHERE   short_name in (" + short_name + ") GROUP BY   short_name, status");
                Flag_NO = Constants.NO;
            }



            //Kiểm tra khi thực hiện convert với PS
            if (type_cv[1].equals(Constants.PS)) {
                //Khi có chọn cả NO
                if (Flag_NO.equals(Constants.NO)) {
                    sql.append(" UNION ");
                }
                sql.append("SELECT   short_name, status, COUNT (*) AS soluong, 'PS' AS data_type,                                 "
                        + "              (SELECT   COUNT (*) FROM   tb_ps  WHERE   short_name in (" + short_name + ")) AS total     "
                        + "       FROM   tb_ps  WHERE   short_name in (" + short_name + ") GROUP BY   short_name, status              ");

                Flag_PS = Constants.PS;
            }

            //Kiểm tra khi thực hiện convert với TK
            if (type_cv[2].equals(Constants.TK)) {
                if (Flag_NO.equals(Constants.NO) || Flag_PS.equals(Constants.PS)) {
                    sql.append(" UNION ");
                }
                sql.append("SELECT   short_name, status, COUNT (*) AS soluong, 'TK' AS data_type,                   "
                        + "(SELECT   COUNT (*) FROM   tb_tk  WHERE   short_name in (" + short_name + ")) AS total     "
                        + "FROM   tb_tk  WHERE   short_name in (" + short_name + ") GROUP BY   short_name, status");
            }

            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql.toString());

            while (rset.next()) {
                cqt_convert.add(rset.getString("short_name") + "," + rset.getString("data_type") + "," + rset.getString("status") + "," + rset.getString("soluong") + "/" + rset.getString("total"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
    }

    /**
     * Lấy ngày chốt dữ liệu
     * @param short_name
     * @return ngay_chot
     * @throws SQLException
     */
    public String loadNgayChotDL(String short_name) throws SQLException {
        //Ngày chốt
        String ngay_chot = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;
        try {
            conn = ConvertPSCDVATApp.connORA;
            stmt = conn.createStatement();
            rset = stmt.executeQuery("SELECT a.short_name, a.tax_code cqt, to_char(a.ky_no_den, 'YYYYMMDD') as ky_no_den FROM tb_lst_taxo a where a.short_name = '" + short_name + "'");
            while (rset.next()) {
                ngay_chot = rset.getString("ky_no_den") + "_" + rset.getString("cqt");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            rset.close();
            stmt.close();
//            conn.close();
        }
        return ngay_chot;
    }

    @Action
    public void showAboutBox() {
        if (aboutBox == null) {
            JFrame mainFrame = ConvertPSCDVATApp.getApplication().getMainFrame();
            aboutBox = new ConvertPSCDVATAboutBox(mainFrame);
            aboutBox.setLocationRelativeTo(mainFrame);
        }
        ConvertPSCDVATApp.getApplication().show(aboutBox);
    }

    /**
     * Hiển thị thông tin cqt và loại dữ liệu convert
     *
     * @param cqt_convert
     * @return message
     */
    public String MessCQTConvert(ArrayList<String> cqt_convert) {

        StringBuffer mess = new StringBuffer();

        mess.append("Cục thuế: " + cboCQT.getSelectedItem().toString().substring(0, 3));

        String short_mess[];
        for (int i = 0; i < cqt_convert.size(); i++) {
            short_mess = cqt_convert.get(i).split(",");
            mess.append("\nChi cục: " + short_mess[0] + " | Loại: " + short_mess[1] + " | Trạng thái: " + short_mess[2] + " | Số lượng: " + short_mess[3]);
        }

        return mess.toString();
    }

    /**
     * Thực hiện convert NPT
     *
     * @throws IOException
     * @throws SQLException
     * @throws ParserConfigurationException
     * @throws ExceptionInInitializerError
     * @throws JCoException
     */
    @Action
    public void ActionConvertNPT() throws IOException, SQLException, ParserConfigurationException, ExceptionInInitializerError, JCoException {
        try {
            int choose = 0;
            //Thời gian bắt đầu và kết thúc chuyển đổi chuyển đổi
            long s_convert = 0, f_convert = 0, result_time = 0;
            //thực hiện convert toàn bộ các chi cục
            String cct_cv = "";
            if (lstCCT_CV.getModel().getSize() > 0) {
                for (int i = 0; i < lstCCT_CV.getModel().getSize(); i++) {
                    cct_cv += "'" + lstCCT_CV.getModel().getElementAt(i) + "',";
                }
                cct_cv = cct_cv.substring(0, cct_cv.length() - 1);
            }

            /*
             * Thực hiện kiểm tra xem cqt đã thực hiện convert hay chưa
             */
            if (!(lstCCT_CV.getModel().getSize() > 0)) {
                lblDisplay.setText("Chọn chi cục để thực hiện chuyển đổi.");
            } else {
                loadCQTConvertNPT(cct_cv);
            }

            if (cqt_convert_npt.isEmpty() || !(lstCCT_CV.getModel().getSize() > 0)) {
                JOptionPane.showMessageDialog(btnConvert,
                        "Không tồn tại dữ liệu để chuyển đổi.",
                        "Thông báo",
                        JOptionPane.INFORMATION_MESSAGE);
                lblDisplay.setText("Chọn CQT để thực hiện chuyển đổi.");
            } else {
                //Thực hiện chuyển đổi NPT
                //Cờ đánh dầu cqt đã chuyển đổi
                String flag = "";
                StringBuffer mess = new StringBuffer();

                mess.append("Cục thuế: " + cboCQT.getSelectedItem().toString().substring(0, 3));

                String short_mess[];
                for (int i = 0; i < cqt_convert_npt.size(); i++) {
                    short_mess = cqt_convert_npt.get(i).split(",");
                    mess.append("\nChi cục: " + short_mess[0] + " | Loại: " + short_mess[1] + " | Trạng thái: " + short_mess[2] + " | Số lượng: " + short_mess[3]);
                    //Thực hiện chuyển đổi thì số lượng sẽ > 0                
                    if (!short_mess[2].substring(0, 1).equals("0")) {
                        flag = Constants.FLAG_VALUES_X;
                    }
                }

                //Hiển thị cảnh báo đã thực hiện chuyển đôi
                if (flag.equals(Constants.FLAG_VALUES_X)) {
                    choose = JOptionPane.showConfirmDialog(btnConvert,
                            mess.toString(),
                            "Thực hiện chuyển đổi dữ liệu",
                            JOptionPane.YES_NO_OPTION);
                    //Thực hiện chuyển đổi
                    if (choose == JOptionPane.YES_OPTION) {

                        //Thời gian bắt đầu thực hiện chuyển đổi dữ liệu
                        s_convert = System.currentTimeMillis();

                        //Gọi hàm thực hiện chuyển đổi
                        LoadData.readDataNPT(cct_cv);

                        //Thời gian kết thúc chuyển đổi dữ liệu
                        f_convert = System.currentTimeMillis();
                        //Thời gian hòan thành
                        result_time = (f_convert - s_convert) / 1000;
                        //Lấy lại thay đổi khi chuyển đổi hoàn thành
                        loadCQTConvertNPT(cct_cv);

                        lblDisplay.setText("Hoàn thành chuyển đổi dữ liệu trong " + result_time + " seconds, chọn CQT khác để chuyển đổi.");

                        //Hiển thị thông báo khi convert hoàn thành                    
                        JOptionPane.showMessageDialog(btnConvert,
                                MessCQTConvert(cqt_convert_npt),
                                "Đã hoàn thành chuyển đổi dữ liệu.",
                                JOptionPane.INFORMATION_MESSAGE);

                    } else {
                        lblDisplay.setText("Chọn CQT khác để chuyển đổi.");
                    }
                } else {
                    //Thời gian bắt đầu thực hiện chuyển đổi dữ liệu
                    s_convert = System.currentTimeMillis();

                    //Gọi hàm thực hiện chuyển đổi
                    LoadData.readDataNPT(cct_cv);

                    //Lấy lại thay đổi khi chuyển đổi hoàn thành
                    loadCQTConvertNPT(cct_cv);

                    //Thời gian kết thúc chuyển đổi dữ liệu
                    f_convert = System.currentTimeMillis();
                    //Thời gian hòan thành
                    result_time = (f_convert - s_convert) / 1000;

                    lblDisplay.setText("Hoàn thành chuyển đổi dữ liệu trong " + result_time + " seconds, chọn CQT khác để chuyển đổi.");

                    //Hiển thị thông báo khi convert hoàn thành
                    JOptionPane.showMessageDialog(btnConvert,
                            MessCQTConvert(cqt_convert_npt),
                            "Đã hoàn thành chuyển đổi dữ liệu.",
                            JOptionPane.INFORMATION_MESSAGE);
                }


            }

//        } catch (RuntimeException e) {
//            e.printStackTrace();
        } catch (JCoException jx) {
            JOptionPane.showMessageDialog(btnConvert,
                    jx.getMessage(),
                    "Lỗi kết nối đến server",
                    JOptionPane.ERROR_MESSAGE);
            jx.printStackTrace();
        } catch (JCoRuntimeException jr) {
            JOptionPane.showMessageDialog(btnConvert,
                    jr.getMessage(),
                    "Lỗi khi gọi hàm SAP",
                    JOptionPane.ERROR_MESSAGE);

            jr.printStackTrace();
        }

    }

    /**
     * Thực hiện lấy lại log trên PIT theo tên file
     */
    @Action
    public void getLogPIT() throws SQLException, AbapException {
        String file_name[] = txtLog.getText().split(",");
        String sql = "";
        //Write log file
        for (int i = 0; i < file_name.length; i++) {
            sql = "delete tb_log_pscd a where a.file_name = '" + file_name[i] + "'";
            //Thực hiện xóa log theo file
            ConnectDB.sqlDatabase(sql);
            //Ghi lại log
            ConvertPSCD.sqlDatabase(file_name[i], "");
        }
        //Hiển thị thông báo
        JOptionPane.showMessageDialog(btnGetLog,
                "Đã cập nhật lại log.",
                "Thông báo",
                JOptionPane.INFORMATION_MESSAGE);

    }

    /**
     * Check dữ liệu PSCD, TK
     * @throws IOException
     * @throws ExceptionInInitializerError
     * @throws JCoException
     * @throws ParserConfigurationException
     * @throws SQLException 
     */
    @Action
    public void ActionCheckPSCD() throws IOException, ExceptionInInitializerError, JCoException, ParserConfigurationException, SQLException {
        //Gọi hàm thực hiện chuyển đổi
        try {
            //Random file name
            randomFileName(loadNgayChotDL(cboCQT.getSelectedItem().toString()), cboCQT.getSelectedItem().toString());
            String f_name[] = new String[3];
            f_name[0] = name_no;
            f_name[1] = name_ps;
            f_name[2] = name_tk;
            lblDisplay.setText("PLEASE WAIT .... CHECKING.");
            //Read file and load data
            int thread_vat = 0;
            //thực hiện convert toàn bộ các chi cục
            String cct_cv = "";
            if (lstCCT_CV.getModel().getSize() > 0) {
                for (int i = 0; i < lstCCT_CV.getModel().getSize(); i++) {
                    cct_cv += "'" + lstCCT_CV.getModel().getElementAt(i) + "',";
                }
                cct_cv = cct_cv.substring(0, cct_cv.length() - 1);
            }

            //Thời gian bắt đầu và kết thúc chuyển đổi chuyển đổi
            long s_convert = 0, f_convert = 0, result_time = 0;
            String type_cv[] = new String[3];
            if (chkNO.isSelected()) {
                type_cv[0] = Constants.NO;
            } else {
                type_cv[0] = Constants.LK;
            }
            if (chkPS.isSelected()) {
                type_cv[1] = Constants.PS;
            } else {
                type_cv[1] = Constants.LK;
            }
            if (chkTK.isSelected()) {
                type_cv[2] = Constants.TK;
            } else {
                type_cv[2] = Constants.LK;
            }

            //Thời gian bắt đầu thực hiện chuyển đổi dữ liệu
            s_convert = System.currentTimeMillis();
            thread_vat = Integer.parseInt(txtThread.getText());
            //Gọi hàm thực hiện chuyển đổi
            String cct = "";
            for (int l = 0; l < lstCCT_CV.getModel().getSize(); l++) {
                //Random file name
                cct = lstCCT_CV.getModel().getElementAt(l).toString();
                LoadData.readDataPSCD(type_cv, thread_vat, f_name, cct, "X");
            }

            //Thời gian kết thúc chuyển đổi dữ liệu
            f_convert = System.currentTimeMillis();
            //Thời gian hòan thành
            result_time = (f_convert - s_convert) / 1000;

            lblDisplay.setText("Hoàn thành chuyển đổi dữ liệu trong " + result_time + " seconds, chọn CQT khác để chuyển đổi.");

            //Hiển thị thông báo khi convert hoàn thành
            JOptionPane.showMessageDialog(btnConvert,
                    "Đã hoàn thành chuyển đổi dữ liệu.",
                    "Thông báo",
                    JOptionPane.INFORMATION_MESSAGE);

        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (SQLException se) {
        } catch (JCoException jx) {
            JOptionPane.showMessageDialog(btnConvert,
                    jx.getMessage(),
                    "Lỗi kết nối đến server",
                    JOptionPane.ERROR_MESSAGE);
        } catch (JCoRuntimeException jr) {
            JOptionPane.showMessageDialog(btnConvert,
                    jr.getMessage(),
                    "Lỗi khi gọi hàm SAP",
                    JOptionPane.ERROR_MESSAGE);
        }


    }

    /**
     * Chuyển đổi dữ liệu qlt, qct, vat
     *
     * @throws IOException
     * @throws ExceptionInInitializerError
     * @throws JCoException
     * @throws ParserConfigurationException
     * @throws SQLException
     */
    @Action
    public void ActionConvertPSCD() throws IOException, ExceptionInInitializerError, JCoException, ParserConfigurationException, SQLException {

        try {
            lblDisplay.setText("PLEASE WAIT .... CONVERTING.");
            //Read file and load data
            int thread_vat = 0;
            //thực hiện convert toàn bộ các chi cục
            String cct_cv = "";
            String cct = "";
            if (lstCCT_CV.getModel().getSize() > 0) {
                for (int i = 0; i < lstCCT_CV.getModel().getSize(); i++) {
                    cct_cv += "'" + lstCCT_CV.getModel().getElementAt(i) + "',";
                }
                cct_cv = cct_cv.substring(0, cct_cv.length() - 1);
            }

            //Thời gian bắt đầu và kết thúc chuyển đổi chuyển đổi
            long s_convert = 0, f_convert = 0, result_time = 0;
            String type_cv[] = new String[3];
            if (chkNO.isSelected()) {
                type_cv[0] = Constants.NO;
            } else {
                type_cv[0] = Constants.LK;
            }
            if (chkPS.isSelected()) {
                type_cv[1] = Constants.PS;
            } else {
                type_cv[1] = Constants.LK;
            }
            if (chkTK.isSelected()) {
                type_cv[2] = Constants.TK;
            } else {
                type_cv[2] = Constants.LK;
            }

            int choose = 0;
            //không có dữ liệu -> hiển thị thông báo
            if (type_cv[0].equals(Constants.LK) && type_cv[1].equals(Constants.LK) && type_cv[2].equals(Constants.LK)) {
                JOptionPane.showMessageDialog(btnConvert, "Chọn loại dữ liệu để thực hiện chuyển đổi.", "Thông báo",
                        JOptionPane.INFORMATION_MESSAGE);
                lblDisplay.setText("Chọn loại dữ liệu để thực hiện chuyển đổi.");
            } else {
                /*
                 * Thực hiện kiểm tra xem cqt đã thực hiện convert hay chưa
                 */
                if (!(lstCCT_CV.getModel().getSize() > 0)) {
                    lblDisplay.setText("Chọn chi cục để thực hiện chuyển đổi.");
                } else {
                    loadCQTConvertPSCD(cct_cv, type_cv);
                }

                //Thực hiện kiểm tra xem cqt có dữ liệu để chuyển đổi hay không
                if (cqt_convert.isEmpty() || !(lstCCT_CV.getModel().getSize() > 0)) {
                    JOptionPane.showMessageDialog(btnConvert, "Không tồn tại dữ liệu để chuyển đổi.", "Thông báo",
                            JOptionPane.INFORMATION_MESSAGE);
                    lblDisplay.setText("Chọn CQT hoặc loại dữ liệu khác để thực hiện chuyển đổi.");
                } else {

                    //Cờ đánh dầu cqt đã chuyển đổi
                    String flag = "";
                    StringBuffer mess = new StringBuffer();

                    mess.append("Cục thuế: " + cboCQT.getSelectedItem().toString().substring(0, 3));

                    String short_mess[];
                    for (int i = 0; i < cqt_convert.size(); i++) {
                        short_mess = cqt_convert.get(i).split(",");
                        mess.append("\nChi cục: " + short_mess[0] + " Loại: " + short_mess[1] + " | Trạng thái: " + short_mess[2] + " | Số lượng: " + short_mess[3]);
                        //Thực hiện chuyển đổi thì số lượng sẽ > 0                
                        if (!short_mess[3].substring(0, 1).equals("0")) {
                            flag = Constants.FLAG_VALUES_X;
                        }
                    }

                    //Hiển thị cảnh báo đã thực hiện chuyển đôi
                    if (flag.equals(Constants.FLAG_VALUES_X)) {
                        choose = JOptionPane.showConfirmDialog(btnConvert,
                                mess.toString(),
                                "Thực hiện chuyển đổi dữ liệu",
                                JOptionPane.YES_NO_OPTION);
                        //Thực hiện chuyển đổi
                        if (choose == JOptionPane.YES_OPTION) {
                            thread_vat = Integer.parseInt(txtThread.getText());

                            //Thời gian bắt đầu thực hiện chuyển đổi dữ liệu
                            s_convert = System.currentTimeMillis();

                            //Gọi hàm thực hiện chuyển đổi, load từng cqt trong List                            
                            for (int l = 0; l < lstCCT_CV.getModel().getSize(); l++) {
                                //Random file name
                                cct = lstCCT_CV.getModel().getElementAt(l).toString();
                                randomFileName(loadNgayChotDL(cct), cct);
                                String f_name[] = new String[3];
                                f_name[0] = name_no;
                                f_name[1] = name_ps;
                                f_name[2] = name_tk;
                                LoadData.readDataPSCD(type_cv, thread_vat, f_name, cct, "");
                            }
                            //Thời gian kết thúc chuyển đổi dữ liệu
                            f_convert = System.currentTimeMillis();
                            //Thời gian hòan thành
                            result_time = (f_convert - s_convert) / 1000;
                            //Lấy lại thay đổi khi chuyển đổi hoàn thành
                            loadCQTConvertPSCD(cct_cv, type_cv);

                            lblDisplay.setText("Hoàn thành chuyển đổi dữ liệu trong " + result_time + " seconds, chọn CQT khác để chuyển đổi.");

                            //Hiển thị thông báo khi convert hoàn thành                    
                            JOptionPane.showMessageDialog(btnConvert,
                                    MessCQTConvert(cqt_convert),
                                    "Đã hoàn thành chuyển đổi dữ liệu.",
                                    JOptionPane.INFORMATION_MESSAGE);

                        } else {
                            lblDisplay.setText("Chọn CQT khác để chuyển đổi.");
                        }
                    } else {
                        //Thời gian bắt đầu thực hiện chuyển đổi dữ liệu
                        s_convert = System.currentTimeMillis();

                        thread_vat = Integer.parseInt(txtThread.getText());
                        //Gọi hàm thực hiện chuyển đổi, load từng cqt trong List
                        for (int l = 0; l < lstCCT_CV.getModel().getSize(); l++) {
                            //Random file name
                            cct = lstCCT_CV.getModel().getElementAt(l).toString();
                            System.out.println("cqt cv: " + cct);
                            randomFileName(loadNgayChotDL(cct), cct);
                            String f_name[] = new String[3];
                            f_name[0] = name_no;
                            f_name[1] = name_ps;
                            f_name[2] = name_tk;
                            LoadData.readDataPSCD(type_cv, thread_vat, f_name, cct, "");
                        }
                        //Lấy lại thay đổi khi chuyển đổi hoàn thành
                        loadCQTConvertPSCD(cct_cv, type_cv);

                        //Thời gian kết thúc chuyển đổi dữ liệu
                        f_convert = System.currentTimeMillis();
                        //Thời gian hòan thành
                        result_time = (f_convert - s_convert) / 1000;

                        lblDisplay.setText("Hoàn thành chuyển đổi dữ liệu trong " + result_time + " seconds, chọn CQT khác để chuyển đổi.");

                        //Hiển thị thông báo khi convert hoàn thành
                        JOptionPane.showMessageDialog(btnConvert,
                                MessCQTConvert(cqt_convert),
                                "Đã hoàn thành chuyển đổi dữ liệu.",
                                JOptionPane.INFORMATION_MESSAGE);
                    }
                }
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (JCoException jx) {
            JOptionPane.showMessageDialog(btnConvert, jx.getMessage(), "Lỗi kết nối đến server", JOptionPane.ERROR_MESSAGE);
        } catch (JCoRuntimeException jr) {
            JOptionPane.showMessageDialog(btnConvert, jr.getMessage(), "Lỗi khi gọi hàm SAP", JOptionPane.ERROR_MESSAGE);
        }

    }

    /**
     * Tìm tên của cqt
     * @param short_name
     * @return tax_code tên cqt
     */
    public String getTaxCode(String short_name) {
        String tax_code = "";
        //tìm kiếm trong mảng cơ quan thuế
        for (int i = 0; i < short_name_.length; i++) {
            if (short_name_[i].equals(cboCQT.getSelectedItem())) {
                tax_code = tax_code_[i];
                break;
            }
        }

        return tax_code;
    }

    /**
     * Sinh tên file khi chuyển đổi
     * @param ngay_chot
     * @param cqt 
     */
    @Action
    public void randomFileName(String ngay_chot, String cqt) {
        Random generator = new Random();
        int r_num = generator.nextInt(0123);
        //clear
        name_no = "";
        name_ps = "";
        name_tk = "";
        //random file name NO
        if (chkNO.isSelected()) {
            name_no = "NOQLT" + ngay_chot + "_" + r_num + ".CSV";
        }
        //random file name PS
        if (chkPS.isSelected()) {
            name_ps = "PSQLT" + ngay_chot + "_" + r_num + ".CSV";
        }
        //random file name TK
        if (chkTK.isSelected()) {
            name_tk = "TKQCT" + ngay_chot + "_" + r_num + ".CSV";
        }
    }

    @Action
    public void getConfigDefault() {
        Utility.getConfig(short_name_);
        lblStatus.setText("Đã khởi tạo tham số mặc định thành công.");
        btnKTao.setEnabled(false);
    }

    @Action
    public void PartBckFolder() {
        getDirectory('B');
    }

    @Action
    public void PartScandFolder() {
        getDirectory('C');
    }

    @Action
    public void PartErrFolder() {
        getDirectory('E');
    }

    /**
     * display file choose
     *
     * @param c
     */
    public void getDirectory(char c) {
        fc.showOpenDialog(btnImport);
        File file = fc.getCurrentDirectory();
        switch (c) {
            case 'C':
                txtSrcFolder.setText(file.getPath());
                break;
            case 'B':
                txtBckFolder.setText(file.getPath());
                break;
            case 'E':
                txtErrFolder.setText(file.getPath());
                break;
            default:
                break;
        }
    }

    /**
     * Cập nhật trạng thái cho các table TB_NO, TB_PS, TB_TK
     * @throws SQLException 
     */
    @Action
    public void updateStatus() throws SQLException {
        //Trạng thái các bảng
        String status = "";
        if (radStatusS.isSelected()) {
            status = "S";//Chọn trạng thái S
        } else if (radStatusE.isSelected()) {
            status = "E";//Chọn trạng thái E
        } else {
            status = "";//Trạng thái ban đầu
        }
        //Query các bảng
        String sql = "";

        //Chọn table để thực hiện update
        if (chkTB_NO.isSelected() || chkTB_PS.isSelected() || chkTB_TK.isSelected() || chkTB_PT.isSelected()) {

            //Cập nhật status TB_NO
            if (chkTB_NO.isSelected()) {
                //Trạng thái S -> Null
                if (status.equals("S")) {
                    sql = "update tb_no set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'S'";
                }

                //Trạng thái E -> Null
                if (status.equals("E")) {
                    sql = "update tb_no set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'E'";
                }

                //Trạng thái ban đầu
                if (status.isEmpty()) {
                    sql = "update tb_no set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "'";
                }
                //Thực hiện cập nhật database          
                ConnectDB.sqlDatabase(sql);

            }

            //Cập nhật status TB_PS
            if (chkTB_PS.isSelected()) {
                //Trạng thái S -> Null
                if (status.equals("S")) {
                    sql = "update tb_ps set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'S'";
                }

                //Trạng thái E -> Null
                if (status.equals("E")) {
                    sql = "update tb_ps set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'E'";
                }

                //Trạng thái ban đầu
                if (status.isEmpty()) {
                    sql = "update tb_ps set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "'";
                }
                //Thực hiện cập nhật database          
                ConnectDB.sqlDatabase(sql);
            }

            //Cập nhật status TB_TK
            if (chkTB_TK.isSelected()) {
                //Trạng thái S -> Null
                if (status.equals("S")) {
                    sql = "update tb_tk set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'S'";
                }

                //Trạng thái E -> Null
                if (status.equals("E")) {
                    sql = "update tb_tk set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "' and status = 'E'";
                }

                //Trạng thái ban đầu
                if (status.isEmpty()) {
                    sql = "update tb_tk set status = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "'";
                }
                //Thực hiện cập nhật database          
                ConnectDB.sqlDatabase(sql);

            }

            //Cập nhật status TB_PT
            if (chkTB_PT.isSelected()) {
                //Trạng thái ban đầu
                if (status.isEmpty()) {
                    sql = "update tb_pt set status = '', message = '' where short_name = '" + cboCQTUtility.getSelectedItem().toString() + "'";
                }
                //Thực hiện cập nhật database          
                ConnectDB.sqlDatabase(sql);
            }
            //Hiển thị thông báo
            JOptionPane.showMessageDialog(btnStatus,
                    "Đã cập nhật trạng thái.",
                    "Thông báo",
                    JOptionPane.INFORMATION_MESSAGE);

        } else {
            JOptionPane.showMessageDialog(btnStatus,
                    "Chọn bảng để thực hiện cập nhật dữ liệu.",
                    "Thông báo",
                    JOptionPane.WARNING_MESSAGE);
        }

    }

    /**
     * Import data from excel to oracle
     * @throws IOException
     * @throws SQLException 
     */
    @Action
    public void impExceltOra() throws IOException, SQLException {
        status = "";
        // Source files
        String srcFile = "";
        File dirFile = null;
        File crtForder = null;
        //Target files (create forder backup & Error)
        String tgrFld = "";
        String tgrErr = "";
        //Chuyển đổi lại
        String try_cqt = cboNhapNgoai.getSelectedItem().toString(); //CQT chuyển đổi lại

        String htcd = "";//Hình thức chuyển đôi

        if (radTryCV.isSelected()) {
            htcd = "I";//Xóa đi và cập nhật lại           
        } else {
            htcd = "U";//Update bổ sung            
        }

        try {
            lblStatus.setText("PLEASE WAIT ... IMPORT DATA EXCEL TO ORACLE.");
            // Forder file scand
            File dirForder = new File(txtSrcFolder.getText());

            /*
             * Thực hiện chuyển đổi khi chọn tất cả CQT
             */
            if (try_cqt.equals(Constants.ALL_CQT)) {
                //Scand list folder 
                for (File f : dirForder.listFiles()) {
                    //Clear file name
                    setDir_file("");
                    setFile_name("");

                    //Dir forder chứa file excel
                    dirFile = new File(txtSrcFolder.getText() + "\\" + f.getName());

                    //Scand list file on folder
                    for (File l : dirFile.listFiles()) {
                        //Create forder backup
                        tgrFld = txtBckFolder.getText() + "\\" + f.getName();
                        tgrErr = txtErrFolder.getText() + "\\" + f.getName();
                        crtForder = new File(tgrFld);
                        crtForder.mkdir();
                        // Source files
                        srcFile = dirFile + "\\" + l.getName();
                        //Xóa file trong thư mục Backup và Error
                        Utility.delFiles(new File(tgrFld + "\\" + l.getName())); //Xóa trong Backup
                        Utility.delFiles(new File(tgrErr + "\\" + l.getName())); //Xóa trong Error

                        // Set directory file 
                        setDir_file(srcFile);
                        // Set file name
                        setFile_name(l.getName());
                        // get file XML
                        int endIndex = l.getName().length();
                        int beginIndex = endIndex - 3;
                        //Lấy file có định dạng .XLS
                        if (l.getName().toUpperCase().substring(beginIndex, endIndex).equals("XLS")) {
                            //Thời gian bắt đầu thực hiện import data 
                            Long s_import_file = System.currentTimeMillis();
                            //import file excel
                            ImpExlToOra.ImpExlToOra(srcFile, getFile_name(), try_cqt, htcd, tgrErr);

                            //Hiển thị file đã import và thời gian thực hiện
                            lblStatus.setText("Completed file " + ConvertPSCDVATView.getFile_name() + " within " + (System.currentTimeMillis() - s_import_file) / 1000 + " seconds!!!");
                            // Move file to backup
                            Utility.moveFiles(srcFile, tgrFld);
                        }
                    }
                }
            } else {//Thực hiện cho từng loại cqt
                //Dir forder chứa file excel
                dirFile = new File(txtSrcFolder.getText() + "\\" + try_cqt);
                //Scand list file on folder
                for (File l : dirFile.listFiles()) {
                    //Create forder backup
                    tgrFld = txtBckFolder.getText() + "\\" + try_cqt;
                    crtForder = new File(tgrFld);
                    crtForder.mkdir();
                    // Source files
                    srcFile = dirFile + "\\" + l.getName();
                    //Xóa file trong thư mục Backup và Error
                    Utility.delFiles(new File(tgrFld + "\\" + l.getName())); //Xóa trong Backup
                    Utility.delFiles(new File(tgrErr + "\\" + l.getName())); //Xóa trong Error
                    // Set directory file 
                    setDir_file(srcFile);
                    // Set file nam xml
                    setFile_name(l.getName());
                    // get file XML
                    int endIndex = l.getName().length();
                    int beginIndex = endIndex - 3;
                    //Lấy file có định dạng .XLS
                    if (l.getName().toUpperCase().substring(beginIndex, endIndex).equals("XLS")) {
                        //Thời gian bắt đầu thực hiện import data 
                        Long s_import_file = System.currentTimeMillis();
                        //import file excel
                        ImpExlToOra.ImpExlToOra(srcFile, getFile_name(), try_cqt, htcd, tgrErr);

                        //Hiển thị file đã import và thời gian thực hiện
                        lblStatus.setText("Completed file " + ConvertPSCDVATView.getFile_name() + " within " + (System.currentTimeMillis() - s_import_file) / 1000 + " seconds!!!");
                        // Move file to backup
                        Utility.moveFiles(srcFile, tgrFld);
                    }
                }
            }


            if (status.equals("") && ImpExlToOra.getFlag().isEmpty()) {
                lblStatus.setText("DONE!!!");
            } else {
                if (!ImpExlToOra.getFlag().isEmpty()) {
                    lblStatus.setText("Có lỗi khi chuyển đổi dữ liệu ngoài, xin hãy kiểm tra lại trong log.");
                } else {
                    lblStatus.setText(status);
                }

                //Set lại status
                status = "";
            }


        } catch (RuntimeException ex) {

            ex.printStackTrace();

            //Hiển thị thông báo lỗi
            lblStatus.setText("Check " + ImpExlToOra.getGetlog());

            //Xóa dữ liệu file bị lỗi            
            ConnectDB.delExlData(ImpExlToOra.getShort_name(), ConvertPSCDVATView.getFile_name());

            JOptionPane.showMessageDialog(btnConvert,
                    "Lỗi dữ liệu không thể thực hiện tiếp: "
                    + ImpExlToOra.getGetlog(),
                    "Thông báo.",
                    JOptionPane.WARNING_MESSAGE);

            status = "Có lỗi khi chuyển đổi dữ liệu ngoài, xin hãy kiểm tra lại trong log.";
        }
    }

    /**
     * Xóa file excel
     * @throws SQLException 
     */
    @Action
    public void delExlData() throws SQLException {

        lblStatus.setText("PLEASE WAIT ... DELETING DATA.");
        // delete data excel
        ConnectDB.delExlData(txtFileImp.getText());

        lblStatus.setText("DELETE COMPLETED!");
    }

    /**
     * Add List
     * @see com.pit.list.SortedListModel
     */
    @Action
    public void getAdd() {
        Object selected[] = lstCCT.getSelectedValues();
        addDestinationElements(selected);
        clearSourceSelected();
        lstCCT_CV.setModel(destListModel);

    }

    /**
     * Remove List
     * @see com.pit.list.SortedListModel
     */
    @Action
    public void getRemove() {
        Object selected[] = lstCCT_CV.getSelectedValues();
        addSourceElements(selected);
        clearDestinationSelected();
        lstCCT.setModel(sourceListModel);
    }

    public void addDestinationElements(Object newValue[]) {
        fillListModel(destListModel, newValue);
    }

    public void addSourceElements(Object newValue[]) {
        fillListModel(sourceListModel, newValue);
    }

    private void fillListModel(SortedListModel model, Object newValues[]) {
        model.addAll(newValues);
    }

    private void clearSourceSelected() {
        Object selected[] = lstCCT.getSelectedValues();
        for (int i = selected.length - 1; i >= 0; --i) {
            sourceListModel.removeElement(selected[i]);
        }
        lstCCT.setModel(sourceListModel);
    }

    private void clearDestinationSelected() {
        Object selected[] = lstCCT_CV.getSelectedValues();
        for (int i = selected.length - 1; i >= 0; --i) {
            destListModel.removeElement(selected[i]);
        }
        lstCCT_CV.setModel(destListModel);
    }

    /**
     * Display file convert success
     *
     * @param file
     */
    public static void getSuccesFile(String file) {
        lblDisplay.setText(file);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        mainPanel = new javax.swing.JPanel();
        tabPSCD = new javax.swing.JTabbedPane();
        pnlPSCD = new javax.swing.JPanel();
        btnConvert = new javax.swing.JButton();
        cboCQT = new javax.swing.JComboBox();
        jLabel8 = new javax.swing.JLabel();
        lblDisplay = new java.awt.Label();
        btnClose = new javax.swing.JButton();
        pnlTypeCV = new javax.swing.JPanel();
        chkNO = new javax.swing.JCheckBox();
        chkPS = new javax.swing.JCheckBox();
        chkTK = new javax.swing.JCheckBox();
        jLabel7 = new javax.swing.JLabel();
        txtThread = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        lstCCT = new javax.swing.JList();
        btnAdd = new javax.swing.JButton();
        btnRemove = new javax.swing.JButton();
        jScrollPane2 = new javax.swing.JScrollPane();
        lstCCT_CV = new javax.swing.JList();
        jLabel5 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        btnCVNPT = new javax.swing.JButton();
        chkPSCD = new javax.swing.JButton();
        btnImpExl = new javax.swing.JPanel();
        btnImport = new javax.swing.JButton();
        btnClose1 = new javax.swing.JButton();
        btnDelete = new javax.swing.JButton();
        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        txtSrcFolder = new javax.swing.JTextField();
        btnSrcExl = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();
        txtBckFolder = new javax.swing.JTextField();
        btnBckFld = new javax.swing.JButton();
        jLabel6 = new javax.swing.JLabel();
        txtErrFolder = new javax.swing.JTextField();
        btnError = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();
        txtFileImp = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        radTryCV = new javax.swing.JRadioButton();
        radUpdate = new javax.swing.JRadioButton();
        chkConfig = new javax.swing.JCheckBox();
        lblStatus = new java.awt.Label();
        jLabel9 = new javax.swing.JLabel();
        cboNhapNgoai = new javax.swing.JComboBox();
        btnKTao = new javax.swing.JButton();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jLabel10 = new javax.swing.JLabel();
        cboCQTUtility = new javax.swing.JComboBox();
        radStatusS = new javax.swing.JRadioButton();
        radStatusE = new javax.swing.JRadioButton();
        radStatusALL = new javax.swing.JRadioButton();
        chkTB_NO = new javax.swing.JCheckBox();
        chkTB_PS = new javax.swing.JCheckBox();
        chkTB_TK = new javax.swing.JCheckBox();
        btnStatus = new javax.swing.JButton();
        chkTB_PT = new javax.swing.JCheckBox();
        jPanel5 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        btnGetLog = new javax.swing.JButton();
        jScrollPane3 = new javax.swing.JScrollPane();
        txtLog = new javax.swing.JTextArea();
        menuBar = new javax.swing.JMenuBar();
        javax.swing.JMenu fileMenu = new javax.swing.JMenu();
        javax.swing.JMenuItem exitMenuItem = new javax.swing.JMenuItem();
        javax.swing.JMenu helpMenu = new javax.swing.JMenu();
        javax.swing.JMenuItem aboutMenuItem = new javax.swing.JMenuItem();
        statusPanel = new javax.swing.JPanel();
        javax.swing.JSeparator statusPanelSeparator = new javax.swing.JSeparator();
        statusMessageLabel = new javax.swing.JLabel();
        statusAnimationLabel = new javax.swing.JLabel();
        progressBar = new javax.swing.JProgressBar();
        buttonGroup1 = new javax.swing.ButtonGroup();
        buttonGroup2 = new javax.swing.ButtonGroup();

        mainPanel.setName("mainPanel"); // NOI18N

        tabPSCD.setName("tabPSCD"); // NOI18N

        pnlPSCD.setName("pnlConvertPSCD"); // NOI18N

        javax.swing.ActionMap actionMap = org.jdesktop.application.Application.getInstance(com.pit.convert.ConvertPSCDVATApp.class).getContext().getActionMap(ConvertPSCDVATView.class, this);
        btnConvert.setAction(actionMap.get("ActionConvertPSCD")); // NOI18N
        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(com.pit.convert.ConvertPSCDVATApp.class).getContext().getResourceMap(ConvertPSCDVATView.class);
        btnConvert.setText(resourceMap.getString("btnConvert.text")); // NOI18N
        btnConvert.setToolTipText(resourceMap.getString("btnConvert.toolTipText")); // NOI18N
        btnConvert.setName("btnConvert"); // NOI18N

        cboCQT.setName("cboCQT"); // NOI18N
        cboCQT.addPropertyChangeListener(new java.beans.PropertyChangeListener() {
            public void propertyChange(java.beans.PropertyChangeEvent evt) {
                cboCQTPropertyChange(evt);
            }
        });
        cboCQT.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                cboCQTKeyPressed(evt);
            }
            public void keyReleased(java.awt.event.KeyEvent evt) {
                cboCQTKeyReleased(evt);
            }
        });

        jLabel8.setText(resourceMap.getString("jLabel8.text")); // NOI18N
        jLabel8.setName("jLabel8"); // NOI18N

        lblDisplay.setAlignment(java.awt.Label.CENTER);
        lblDisplay.setFont(resourceMap.getFont("lblDisplay.font")); // NOI18N
        lblDisplay.setForeground(resourceMap.getColor("lblDisplay.foreground")); // NOI18N
        lblDisplay.setName("lblDisplay"); // NOI18N

        btnClose.setAction(actionMap.get("quit")); // NOI18N
        btnClose.setText(resourceMap.getString("btnClose.text")); // NOI18N
        btnClose.setMaximumSize(new java.awt.Dimension(89, 23));
        btnClose.setMinimumSize(new java.awt.Dimension(89, 23));
        btnClose.setName("btnClose"); // NOI18N

        pnlTypeCV.setBorder(javax.swing.BorderFactory.createTitledBorder(resourceMap.getString("pnlTypeCV.border.title"))); // NOI18N
        pnlTypeCV.setName("pnlTypeCV"); // NOI18N

        chkNO.setSelected(true);
        chkNO.setText(resourceMap.getString("chkNO.text")); // NOI18N
        chkNO.setName("chkNO"); // NOI18N

        chkPS.setSelected(true);
        chkPS.setText(resourceMap.getString("chkPS.text")); // NOI18N
        chkPS.setName("chkPS"); // NOI18N

        chkTK.setSelected(true);
        chkTK.setText(resourceMap.getString("chkTK.text")); // NOI18N
        chkTK.setName("chkTK"); // NOI18N

        jLabel7.setText(resourceMap.getString("jLabel7.text")); // NOI18N
        jLabel7.setName("jLabel7"); // NOI18N

        txtThread.setText(resourceMap.getString("txtThread.text")); // NOI18N
        txtThread.setName("txtThread"); // NOI18N

        javax.swing.GroupLayout pnlTypeCVLayout = new javax.swing.GroupLayout(pnlTypeCV);
        pnlTypeCV.setLayout(pnlTypeCVLayout);
        pnlTypeCVLayout.setHorizontalGroup(
            pnlTypeCVLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlTypeCVLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlTypeCVLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(pnlTypeCVLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(chkNO, javax.swing.GroupLayout.DEFAULT_SIZE, 175, Short.MAX_VALUE)
                        .addComponent(chkPS, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(chkTK, javax.swing.GroupLayout.PREFERRED_SIZE, 288, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(pnlTypeCVLayout.createSequentialGroup()
                        .addComponent(jLabel7)
                        .addGap(34, 34, 34)
                        .addComponent(txtThread, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(97, Short.MAX_VALUE))
        );
        pnlTypeCVLayout.setVerticalGroup(
            pnlTypeCVLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlTypeCVLayout.createSequentialGroup()
                .addComponent(chkNO)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(chkPS)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(chkTK)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(pnlTypeCVLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(txtThread, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(11, Short.MAX_VALUE))
        );

        jScrollPane1.setName("jScrollPane1"); // NOI18N

        lstCCT.setName("lstCCT"); // NOI18N
        jScrollPane1.setViewportView(lstCCT);

        btnAdd.setAction(actionMap.get("getAdd")); // NOI18N
        btnAdd.setText(resourceMap.getString("btnAdd.text")); // NOI18N
        btnAdd.setName("btnAdd"); // NOI18N

        btnRemove.setAction(actionMap.get("getRemove")); // NOI18N
        btnRemove.setText(resourceMap.getString("btnRemove.text")); // NOI18N
        btnRemove.setName("btnRemove"); // NOI18N

        jScrollPane2.setName("jScrollPane2"); // NOI18N

        lstCCT_CV.setEnabled(false);
        lstCCT_CV.setName("lstCCT_CV"); // NOI18N
        jScrollPane2.setViewportView(lstCCT_CV);

        jLabel5.setText(resourceMap.getString("jLabel5.text")); // NOI18N
        jLabel5.setName("jLabel5"); // NOI18N

        jLabel11.setText(resourceMap.getString("jLabel11.text")); // NOI18N
        jLabel11.setName("jLabel11"); // NOI18N

        btnCVNPT.setAction(actionMap.get("ActionConvertNPT")); // NOI18N
        btnCVNPT.setText(resourceMap.getString("btnCVNPT.text")); // NOI18N
        btnCVNPT.setMaximumSize(new java.awt.Dimension(89, 23));
        btnCVNPT.setMinimumSize(new java.awt.Dimension(89, 23));
        btnCVNPT.setName("btnCVNPT"); // NOI18N

        chkPSCD.setAction(actionMap.get("ActionCheckPSCD")); // NOI18N
        chkPSCD.setText(resourceMap.getString("chkPSCD.text")); // NOI18N
        chkPSCD.setMaximumSize(new java.awt.Dimension(89, 23));
        chkPSCD.setMinimumSize(new java.awt.Dimension(89, 23));
        chkPSCD.setName("chkPSCD"); // NOI18N

        javax.swing.GroupLayout pnlPSCDLayout = new javax.swing.GroupLayout(pnlPSCD);
        pnlPSCD.setLayout(pnlPSCDLayout);
        pnlPSCDLayout.setHorizontalGroup(
            pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlPSCDLayout.createSequentialGroup()
                .addGap(124, 124, 124)
                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(lblDisplay, javax.swing.GroupLayout.PREFERRED_SIZE, 592, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(pnlPSCDLayout.createSequentialGroup()
                        .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 108, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(jLabel5))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(btnRemove, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(btnAdd))
                                .addGap(10, 10, 10)
                                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel11)
                                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addComponent(jLabel8)
                                .addGap(18, 18, 18)
                                .addComponent(cboCQT, javax.swing.GroupLayout.PREFERRED_SIZE, 123, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addGap(18, 18, 18)
                                .addComponent(pnlTypeCV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addGap(36, 36, 36)
                                .addComponent(chkPSCD, javax.swing.GroupLayout.PREFERRED_SIZE, 92, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(btnConvert)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(btnCVNPT, javax.swing.GroupLayout.PREFERRED_SIZE, 85, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(btnClose, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addGap(64, 64, 64))
        );
        pnlPSCDLayout.setVerticalGroup(
            pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlPSCDLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(pnlPSCDLayout.createSequentialGroup()
                        .addComponent(pnlTypeCV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.CENTER)
                            .addComponent(btnClose, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnCVNPT, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnConvert)
                            .addComponent(chkPSCD, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(pnlPSCDLayout.createSequentialGroup()
                        .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(cboCQT, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel8))
                        .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel5)
                                    .addComponent(jLabel11))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(pnlPSCDLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 186, Short.MAX_VALUE)
                                    .addComponent(jScrollPane2)))
                            .addGroup(pnlPSCDLayout.createSequentialGroup()
                                .addGap(82, 82, 82)
                                .addComponent(btnAdd)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(btnRemove)))))
                .addGap(46, 46, 46)
                .addComponent(lblDisplay, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(38, Short.MAX_VALUE))
        );

        tabPSCD.addTab(resourceMap.getString("pnlConvertPSCD.TabConstraints.tabTitle"), pnlPSCD); // NOI18N

        btnImpExl.setName("btnImpExl"); // NOI18N

        btnImport.setAction(actionMap.get("impExceltOra")); // NOI18N
        btnImport.setText(resourceMap.getString("btnImport.text")); // NOI18N
        btnImport.setToolTipText(resourceMap.getString("btnImport.toolTipText")); // NOI18N
        btnImport.setName("btnImport"); // NOI18N

        btnClose1.setAction(actionMap.get("quit")); // NOI18N
        btnClose1.setText(resourceMap.getString("btnClose1.text")); // NOI18N
        btnClose1.setName("btnClose1"); // NOI18N

        btnDelete.setAction(actionMap.get("delExlData")); // NOI18N
        btnDelete.setText(resourceMap.getString("btnDelete.text")); // NOI18N
        btnDelete.setName("btnDelete"); // NOI18N

        jPanel1.setName("jPanel1"); // NOI18N

        jLabel1.setText(resourceMap.getString("jLabel1.text")); // NOI18N
        jLabel1.setName("jLabel1"); // NOI18N

        txtSrcFolder.setText(resourceMap.getString("txtSrcFolder.text")); // NOI18N
        txtSrcFolder.setName("txtSrcFolder"); // NOI18N

        btnSrcExl.setAction(actionMap.get("PartScandFolder")); // NOI18N
        btnSrcExl.setText(resourceMap.getString("btnSrcExl.text")); // NOI18N
        btnSrcExl.setName("btnSrcExl"); // NOI18N

        jLabel3.setText(resourceMap.getString("jLabel3.text")); // NOI18N
        jLabel3.setName("jLabel3"); // NOI18N

        txtBckFolder.setText(resourceMap.getString("txtBckFolder.text")); // NOI18N
        txtBckFolder.setName("txtBckFolder"); // NOI18N

        btnBckFld.setAction(actionMap.get("PartBckFolder")); // NOI18N
        btnBckFld.setText(resourceMap.getString("btnBckFld.text")); // NOI18N
        btnBckFld.setName("btnBckFld"); // NOI18N

        jLabel6.setText(resourceMap.getString("jLabel6.text")); // NOI18N
        jLabel6.setName("jLabel6"); // NOI18N

        txtErrFolder.setText(resourceMap.getString("txtErrFolder.text")); // NOI18N
        txtErrFolder.setName("txtErrFolder"); // NOI18N

        btnError.setAction(actionMap.get("PartErrFolder")); // NOI18N
        btnError.setText(resourceMap.getString("btnError.text")); // NOI18N
        btnError.setName("btnError"); // NOI18N

        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        txtFileImp.setText(resourceMap.getString("txtFileImp.text")); // NOI18N
        txtFileImp.setName("txtFileImp"); // NOI18N
        txtFileImp.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                txtFileImpMouseClicked(evt);
            }
        });

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder(resourceMap.getString("jPanel2.border.title"))); // NOI18N
        jPanel2.setName("jPanel2"); // NOI18N

        buttonGroup1.add(radTryCV);
        radTryCV.setSelected(true);
        radTryCV.setText(resourceMap.getString("radTryCV.text")); // NOI18N
        radTryCV.setName("radTryCV"); // NOI18N

        buttonGroup1.add(radUpdate);
        radUpdate.setText(resourceMap.getString("radUpdate.text")); // NOI18N
        radUpdate.setName("radUpdate"); // NOI18N

        chkConfig.setText(resourceMap.getString("chkConfig.text")); // NOI18N
        chkConfig.setName("chkConfig"); // NOI18N
        chkConfig.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                chkConfigMouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addComponent(radTryCV)
                .addGap(49, 49, 49)
                .addComponent(radUpdate)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 43, Short.MAX_VALUE)
                .addComponent(chkConfig, javax.swing.GroupLayout.PREFERRED_SIZE, 166, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(15, 15, 15))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                .addComponent(radTryCV)
                .addComponent(radUpdate)
                .addComponent(chkConfig))
        );

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(79, 79, 79)
                .addComponent(txtSrcFolder, javax.swing.GroupLayout.PREFERRED_SIZE, 430, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(72, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(61, 61, 61))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap(11, Short.MAX_VALUE)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel3)
                            .addComponent(jLabel1)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel2)
                            .addComponent(jLabel6))))
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(txtBckFolder, javax.swing.GroupLayout.DEFAULT_SIZE, 431, Short.MAX_VALUE)
                    .addComponent(txtErrFolder, javax.swing.GroupLayout.DEFAULT_SIZE, 431, Short.MAX_VALUE)
                    .addComponent(txtFileImp, javax.swing.GroupLayout.DEFAULT_SIZE, 431, Short.MAX_VALUE))
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(btnSrcExl, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnBckFld, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap(38, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnError, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(39, 39, 39))))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(17, 17, 17)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtSrcFolder, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel1, javax.swing.GroupLayout.Alignment.TRAILING))
                        .addGap(14, 14, 14)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel3, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtBckFolder, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(btnSrcExl)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnBckFld)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel6, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(txtErrFolder, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnError, javax.swing.GroupLayout.Alignment.TRAILING))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(txtFileImp, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(46, Short.MAX_VALUE))
        );

        lblStatus.setAlignment(java.awt.Label.CENTER);
        lblStatus.setFont(resourceMap.getFont("lblStatus.font")); // NOI18N
        lblStatus.setForeground(resourceMap.getColor("lblStatus.foreground")); // NOI18N
        lblStatus.setName("lblStatus"); // NOI18N

        jLabel9.setText(resourceMap.getString("jLabel9.text")); // NOI18N
        jLabel9.setName("jLabel9"); // NOI18N

        cboNhapNgoai.setName("cboNhapNgoai"); // NOI18N

        btnKTao.setAction(actionMap.get("getConfigDefault")); // NOI18N
        btnKTao.setText(resourceMap.getString("btnKTao.text")); // NOI18N
        btnKTao.setToolTipText(resourceMap.getString("btnKTao.toolTipText")); // NOI18N
        btnKTao.setName("btnKTao"); // NOI18N

        javax.swing.GroupLayout btnImpExlLayout = new javax.swing.GroupLayout(btnImpExl);
        btnImpExl.setLayout(btnImpExlLayout);
        btnImpExlLayout.setHorizontalGroup(
            btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(btnImpExlLayout.createSequentialGroup()
                .addGroup(btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(btnImpExlLayout.createSequentialGroup()
                        .addGap(12, 12, 12)
                        .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cboNhapNgoai, javax.swing.GroupLayout.PREFERRED_SIZE, 145, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(btnImpExlLayout.createSequentialGroup()
                        .addGap(44, 44, 44)
                        .addComponent(lblStatus, javax.swing.GroupLayout.PREFERRED_SIZE, 726, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(btnImpExlLayout.createSequentialGroup()
                        .addGap(206, 206, 206)
                        .addComponent(btnImport, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnDelete, javax.swing.GroupLayout.PREFERRED_SIZE, 104, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnKTao, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnClose1, javax.swing.GroupLayout.PREFERRED_SIZE, 105, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(72, Short.MAX_VALUE))
        );
        btnImpExlLayout.setVerticalGroup(
            btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(btnImpExlLayout.createSequentialGroup()
                .addGroup(btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(btnImpExlLayout.createSequentialGroup()
                        .addGap(41, 41, 41)
                        .addGroup(btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(cboNhapNgoai, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel9)))
                    .addGroup(btnImpExlLayout.createSequentialGroup()
                        .addGap(31, 31, 31)
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblStatus, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(btnImpExlLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnImport, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnDelete)
                    .addComponent(btnKTao)
                    .addComponent(btnClose1, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        tabPSCD.addTab(resourceMap.getString("btnImpExl.TabConstraints.tabTitle"), btnImpExl); // NOI18N

        jPanel3.setName("jPanel3"); // NOI18N

        jPanel4.setBorder(javax.swing.BorderFactory.createTitledBorder(resourceMap.getString("jPanel4.border.title"))); // NOI18N
        jPanel4.setName("jPanel4"); // NOI18N

        jLabel10.setText(resourceMap.getString("jLabel10.text")); // NOI18N
        jLabel10.setName("jLabel10"); // NOI18N

        cboCQTUtility.setName("cboCQTUtility"); // NOI18N

        buttonGroup2.add(radStatusS);
        radStatusS.setText(resourceMap.getString("radStatusS.text")); // NOI18N
        radStatusS.setName("radStatusS"); // NOI18N

        buttonGroup2.add(radStatusE);
        radStatusE.setSelected(true);
        radStatusE.setText(resourceMap.getString("radStatusE.text")); // NOI18N
        radStatusE.setName("radStatusE"); // NOI18N

        buttonGroup2.add(radStatusALL);
        radStatusALL.setText(resourceMap.getString("radStatusALL.text")); // NOI18N
        radStatusALL.setName("radStatusALL"); // NOI18N

        chkTB_NO.setText(resourceMap.getString("chkTB_NO.text")); // NOI18N
        chkTB_NO.setName("chkTB_NO"); // NOI18N

        chkTB_PS.setText(resourceMap.getString("chkTB_PS.text")); // NOI18N
        chkTB_PS.setName("chkTB_PS"); // NOI18N

        chkTB_TK.setText(resourceMap.getString("chkTB_TK.text")); // NOI18N
        chkTB_TK.setName("chkTB_TK"); // NOI18N

        btnStatus.setAction(actionMap.get("updateStatus")); // NOI18N
        btnStatus.setText(resourceMap.getString("btnStatus.text")); // NOI18N
        btnStatus.setName("btnStatus"); // NOI18N

        chkTB_PT.setText(resourceMap.getString("chkTB_PT.text")); // NOI18N
        chkTB_PT.setName("chkTB_PT"); // NOI18N

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cboCQTUtility, javax.swing.GroupLayout.PREFERRED_SIZE, 145, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 7, Short.MAX_VALUE)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(radStatusALL)
                            .addComponent(radStatusE)
                            .addComponent(radStatusS, javax.swing.GroupLayout.PREFERRED_SIZE, 206, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(chkTB_NO)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(chkTB_PS)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(chkTB_TK)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(chkTB_PT))))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                        .addComponent(btnStatus)
                        .addGap(88, 88, 88)))
                .addContainerGap())
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cboCQTUtility, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel10)
                    .addComponent(chkTB_NO)
                    .addComponent(chkTB_PS)
                    .addComponent(chkTB_TK)
                    .addComponent(chkTB_PT))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(radStatusS)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(radStatusE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(radStatusALL)
                .addGap(7, 7, 7)
                .addComponent(btnStatus)
                .addContainerGap(29, Short.MAX_VALUE))
        );

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder(resourceMap.getString("jPanel5.border.title"))); // NOI18N
        jPanel5.setName("jPanel5"); // NOI18N

        jLabel4.setText(resourceMap.getString("jLabel4.text")); // NOI18N
        jLabel4.setName("jLabel4"); // NOI18N

        btnGetLog.setAction(actionMap.get("getLogPIT")); // NOI18N
        btnGetLog.setText(resourceMap.getString("btnGetLog.text")); // NOI18N
        btnGetLog.setName("btnGetLog"); // NOI18N

        jScrollPane3.setName("jScrollPane3"); // NOI18N

        txtLog.setColumns(20);
        txtLog.setRows(5);
        txtLog.setText(resourceMap.getString("txtLog.text")); // NOI18N
        txtLog.setName("txtLog"); // NOI18N
        txtLog.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                txtLogMouseClicked(evt);
            }
        });
        jScrollPane3.setViewportView(txtLog);

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jScrollPane3, javax.swing.GroupLayout.DEFAULT_SIZE, 255, Short.MAX_VALUE))
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addGap(142, 142, 142)
                        .addComponent(btnGetLog)))
                .addContainerGap())
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel4)
                    .addGroup(jPanel5Layout.createSequentialGroup()
                        .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(btnGetLog)))
                .addContainerGap(24, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(11, 11, 11)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(jPanel5, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel4, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(153, Short.MAX_VALUE))
        );

        tabPSCD.addTab(resourceMap.getString("jPanel3.TabConstraints.tabTitle"), jPanel3); // NOI18N

        javax.swing.GroupLayout mainPanelLayout = new javax.swing.GroupLayout(mainPanel);
        mainPanel.setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(tabPSCD, javax.swing.GroupLayout.DEFAULT_SIZE, 892, Short.MAX_VALUE)
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(tabPSCD, javax.swing.GroupLayout.DEFAULT_SIZE, 387, Short.MAX_VALUE)
        );

        tabPSCD.getAccessibleContext().setAccessibleName(resourceMap.getString("jTabbedPane1.AccessibleContext.accessibleName")); // NOI18N

        menuBar.setName("menuBar"); // NOI18N

        fileMenu.setText(resourceMap.getString("fileMenu.text")); // NOI18N
        fileMenu.setName("fileMenu"); // NOI18N

        exitMenuItem.setAction(actionMap.get("quit")); // NOI18N
        exitMenuItem.setName("exitMenuItem"); // NOI18N
        fileMenu.add(exitMenuItem);

        menuBar.add(fileMenu);

        helpMenu.setText(resourceMap.getString("helpMenu.text")); // NOI18N
        helpMenu.setName("helpMenu"); // NOI18N

        aboutMenuItem.setAction(actionMap.get("showAboutBox")); // NOI18N
        aboutMenuItem.setName("aboutMenuItem"); // NOI18N
        helpMenu.add(aboutMenuItem);

        menuBar.add(helpMenu);

        statusPanel.setName("statusPanel"); // NOI18N

        statusPanelSeparator.setName("statusPanelSeparator"); // NOI18N

        statusMessageLabel.setName("statusMessageLabel"); // NOI18N

        statusAnimationLabel.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        statusAnimationLabel.setName("statusAnimationLabel"); // NOI18N

        progressBar.setDebugGraphicsOptions(javax.swing.DebugGraphics.FLASH_OPTION);
        progressBar.setName("progressBar"); // NOI18N

        javax.swing.GroupLayout statusPanelLayout = new javax.swing.GroupLayout(statusPanel);
        statusPanel.setLayout(statusPanelLayout);
        statusPanelLayout.setHorizontalGroup(
            statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(statusPanelSeparator, javax.swing.GroupLayout.DEFAULT_SIZE, 892, Short.MAX_VALUE)
            .addGroup(statusPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(statusMessageLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 722, Short.MAX_VALUE)
                .addComponent(progressBar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(statusAnimationLabel)
                .addContainerGap())
        );
        statusPanelLayout.setVerticalGroup(
            statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(statusPanelLayout.createSequentialGroup()
                .addComponent(statusPanelSeparator, javax.swing.GroupLayout.PREFERRED_SIZE, 2, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(statusMessageLabel)
                    .addComponent(statusAnimationLabel)
                    .addComponent(progressBar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(3, 3, 3))
        );

        setComponent(mainPanel);
        setMenuBar(menuBar);
        setStatusBar(statusPanel);
    }// </editor-fold>//GEN-END:initComponents

    private void txtFileImpMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_txtFileImpMouseClicked
        txtFileImp.setText("");
    }//GEN-LAST:event_txtFileImpMouseClicked

    private void chkConfigMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_chkConfigMouseClicked
        if (chkConfig.isSelected()) {
            btnKTao.setEnabled(true);
        } else {
            btnKTao.setEnabled(false);
        }
    }//GEN-LAST:event_chkConfigMouseClicked

    private void cboCQTKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_cboCQTKeyPressed
//        JOptionPane.showMessageDialog(btnConvert, cboCQT.getSelectedItem().toString());
//        getListCQT(cboCQT.getSelectedItem().toString());
//        //Xóa toàn bộ chi cục thuế convert
//        destListModel.clear();
//        lstCCT_CV.setModel(destListModel);
    }//GEN-LAST:event_cboCQTKeyPressed

    private void cboCQTPropertyChange(java.beans.PropertyChangeEvent evt) {//GEN-FIRST:event_cboCQTPropertyChange
        getListCQT(cboCQT.getSelectedItem().toString());
        //Xóa toàn bộ chi cục thuế convert
        destListModel.clear();
        lstCCT_CV.setModel(destListModel);
    }//GEN-LAST:event_cboCQTPropertyChange

    private void txtLogMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_txtLogMouseClicked
        txtLog.setText("");
    }//GEN-LAST:event_txtLogMouseClicked

    private void cboCQTKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_cboCQTKeyReleased
        // TODO add your handling code here:        
        getListCQT(cboCQT.getSelectedItem().toString());
        //Xóa toàn bộ chi cục thuế convert
        destListModel.clear();
        lstCCT_CV.setModel(destListModel);
    }//GEN-LAST:event_cboCQTKeyReleased
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAdd;
    private javax.swing.JButton btnBckFld;
    private javax.swing.JButton btnCVNPT;
    private javax.swing.JButton btnClose;
    private javax.swing.JButton btnClose1;
    private javax.swing.JButton btnConvert;
    private javax.swing.JButton btnDelete;
    private javax.swing.JButton btnError;
    private javax.swing.JButton btnGetLog;
    private javax.swing.JPanel btnImpExl;
    private javax.swing.JButton btnImport;
    private javax.swing.JButton btnKTao;
    private javax.swing.JButton btnRemove;
    private javax.swing.JButton btnSrcExl;
    private javax.swing.JButton btnStatus;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.ButtonGroup buttonGroup2;
    private javax.swing.JComboBox cboCQT;
    private javax.swing.JComboBox cboCQTUtility;
    private javax.swing.JComboBox cboNhapNgoai;
    private javax.swing.JCheckBox chkConfig;
    private javax.swing.JCheckBox chkNO;
    private javax.swing.JCheckBox chkPS;
    private javax.swing.JButton chkPSCD;
    private javax.swing.JCheckBox chkTB_NO;
    private javax.swing.JCheckBox chkTB_PS;
    private javax.swing.JCheckBox chkTB_PT;
    private javax.swing.JCheckBox chkTB_TK;
    private javax.swing.JCheckBox chkTK;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private static java.awt.Label lblDisplay;
    private static java.awt.Label lblStatus;
    private javax.swing.JList lstCCT;
    private javax.swing.JList lstCCT_CV;
    private javax.swing.JPanel mainPanel;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JPanel pnlPSCD;
    private javax.swing.JPanel pnlTypeCV;
    private javax.swing.JProgressBar progressBar;
    private javax.swing.JRadioButton radStatusALL;
    private javax.swing.JRadioButton radStatusE;
    private javax.swing.JRadioButton radStatusS;
    private javax.swing.JRadioButton radTryCV;
    private javax.swing.JRadioButton radUpdate;
    private javax.swing.JLabel statusAnimationLabel;
    private javax.swing.JLabel statusMessageLabel;
    private javax.swing.JPanel statusPanel;
    private javax.swing.JTabbedPane tabPSCD;
    private javax.swing.JTextField txtBckFolder;
    private javax.swing.JTextField txtErrFolder;
    private javax.swing.JTextField txtFileImp;
    private javax.swing.JTextArea txtLog;
    private javax.swing.JTextField txtSrcFolder;
    private javax.swing.JTextField txtThread;
    // End of variables declaration//GEN-END:variables
    private final Timer messageTimer;
    private final Timer busyIconTimer;
    private final Icon idleIcon;
    private final Icon[] busyIcons = new Icon[15];
    private int busyIconIndex = 0;
    JFileChooser fc = new JFileChooser();
    private JDialog aboutBox;
    //Tên file đang quét
    private static String file_name;

    public static String getFile_name() {
        return file_name;
    }
    //list chi cục thuế khi chọn
    private SortedListModel destListModel = new SortedListModel();
    //list chi cục thuế
    private SortedListModel sourceListModel = new SortedListModel();

    public static void setFile_name(String file_name) {
        ConvertPSCDVATView.file_name = file_name;
    }
    //Đường dẫn và file đang quét
    private static String dir_file;

    public static String getDir_file() {
        return dir_file;
    }

    public static void setDir_file(String dir_file) {
        ConvertPSCDVATView.dir_file = dir_file;
    }
}
