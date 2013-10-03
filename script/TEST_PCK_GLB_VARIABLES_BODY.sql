-- Start of DDL Script for Package Body TEST.PCK_GLB_VARIABLES
-- Generated 03/10/2013 11:11:21 AM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE BODY pck_glb_variables
/**
 * Thuc hien set vs get value su dung trong view, select ...
 *@author Administrator
 *@date 19/06/2013
 */
IS
    gn$short_name   VARCHAR2 (10);
    gn$ma_cqt       VARCHAR2 (5);
    gn$ky_chot      VARCHAR2 (15);

    /**
     * Thuc hien set short_name
     *@author Administrator
     *@date 19/06/2013
     *@param in_short_name
     */
    PROCEDURE set_short_name (in_short_name VARCHAR2)
    IS
    BEGIN
        gn$short_name := in_short_name;
    END;

    /**
     * Thuc hien get short_name
     *@author Administrator
     *@date 19/06/2013
     *@return short_name
     */
    FUNCTION get_short_name
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN gn$short_name;
    END;

    /**
     * Thuc hien set ma co quan thue
     *@author Administrator
     *@date 19/06/2013
     *@param in_short_name
     */
    PROCEDURE set_ma_cqt (in_ma_cqt VARCHAR2)
    IS
    BEGIN
        gn$ma_cqt := in_ma_cqt;
    END;

    /**
     * Thuc hien get ma co quan thue
     *@author Administrator
     *@date 19/06/2013
     *@return short_name
     */
    FUNCTION get_ma_cqt
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN gn$ma_cqt;
    END;

    /**
     * Thuc hien set ky_chot
     *@author Administrator
     *@date 19/06/2013
     *@param ky_chot
     */
    PROCEDURE set_ky_chot (in_ky_chot VARCHAR2)
    IS
    BEGIN
        gn$ky_chot := in_ky_chot;
    END;

    /**
     * Thuc hien Get ky_chot
     *@author Administrator
     *@date 19/06/2013
     *@return ky_chot
     */
    FUNCTION get_ky_chot
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN gn$ky_chot;
    END;
END;
/


-- End of DDL Script for Package Body TEST.PCK_GLB_VARIABLES

