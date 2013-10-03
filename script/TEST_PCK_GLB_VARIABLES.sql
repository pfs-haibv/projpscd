-- Start of DDL Script for Package TEST.PCK_GLB_VARIABLES
-- Generated 03/10/2013 11:11:55 AM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE pck_glb_variables
IS
    --SHORT_NAME
    PROCEDURE set_short_name (in_short_name VARCHAR2);

    FUNCTION get_short_name
        RETURN VARCHAR2;
    --MA_CQT
    PROCEDURE set_ma_cqt (in_ma_cqt VARCHAR2);

    FUNCTION get_ma_cqt
        RETURN VARCHAR2;

    --KY_CHOT
    PROCEDURE set_ky_chot (in_ky_chot VARCHAR2);

    FUNCTION get_ky_chot
        RETURN VARCHAR2;

END;
/


-- End of DDL Script for Package TEST.PCK_GLB_VARIABLES

