/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pit.convert;

import java.util.ArrayList;
import com.pit.datatype.*;

/**
 *
 * @author HAIBV
 */
public class DataCVPSCD {

    //Nợ & phát sinh
    ArrayList <DataPSCD> arrPSCD = new ArrayList <DataPSCD>();
    //Tờ khai
    ArrayList <DataTK>   arrTK   = new ArrayList <DataTK>();

    public DataCVPSCD(ArrayList <DataPSCD> arrPSCD,ArrayList <DataTK> arrTK) {
        
        for (int i = 0; i < arrPSCD.size();i++)
        this.arrPSCD.add(arrPSCD.get(i)); 
 
        for (int i=0; i<arrTK.size();i++)
        this.arrTK.add(arrTK.get(i));  
        
    }

    
    public ArrayList <DataPSCD> getArrPSCD() {
        return arrPSCD;
    }

    public void setArrPSCD(ArrayList <DataPSCD> arrPSCD) {
        this.arrPSCD = arrPSCD;
    }

    public ArrayList <DataTK> getArrTK() {
        return arrTK;
    }

    public void setArrTK(ArrayList <DataTK> arrTK) {
        this.arrTK = arrTK;
    }
       
}
