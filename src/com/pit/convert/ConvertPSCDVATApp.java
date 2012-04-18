package com.pit.convert;

import java.io.IOException;
import java.sql.SQLException;
import org.jdesktop.application.Application;
import org.jdesktop.application.SingleFrameApplication;

import com.pit.conn.ConnectDB;
import java.sql.Connection;
import javax.swing.JOptionPane;

/**
 * The main class of the application.
 * @author Administrator
 */
public class ConvertPSCDVATApp extends SingleFrameApplication {
    
    //Connection oracle
    public static Connection connORA = null;
    
    /**
     * At startup create and show the main frame of the application.
     */
    @Override protected void startup() {
        show(new ConvertPSCDVATView(this));
    }

    /**
     * This method is to initialize the specified window by injecting resources.
     * Windows shown in our application come fully initialized from the GUI
     * builder, so this additional configuration is not needed.
     */
    @Override protected void configureWindow(java.awt.Window root) {
    }

    /**
     * A convenient static getter for the application instance.
     * @return the instance of ConvertPSCDVATApp
     */
    public static ConvertPSCDVATApp getApplication() {
        return Application.getInstance(ConvertPSCDVATApp.class);
    }

    /**
     * Main method launching the application.
     */
    public static void main(String[] args) throws IOException {
        
        try {
            connORA = ConnectDB.getConnORA();
        } catch (SQLException ex) {            
            JOptionPane.showMessageDialog(null,ex.getMessage(),
                                    "Lỗi kết nối CSDL",
                                    JOptionPane.ERROR_MESSAGE);            
        }
        launch(ConvertPSCDVATApp.class, args);
    }
    
}
