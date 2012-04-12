/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.convert;

import com.pit.datatype.DataNPT;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class DataCVNPT {

    //Người phụ thuộc
    ArrayList<DataNPT> arrdtNPT = new ArrayList<DataNPT>();

    public DataCVNPT(ArrayList<DataNPT> arrNPT) {

        for (int i = 0; i < arrNPT.size(); i++) {
            this.arrdtNPT.add(arrNPT.get(i));
        }

    }
}
