-- Start of DDL Script for Package TEST.PCK_GLB_VARIABLES
-- Generated 23/09/2013 10:25:40 AM from TEST@DCNC

CREATE OR REPLACE 
PACKAGE pck_glb_variables
IS
    --SHORT_NAME
    PROCEDURE set_short_name (in_short_name VARCHAR2);

    FUNCTION get_short_name
        RETURN VARCHAR2;

    --KY_CHOT
    PROCEDURE set_ky_chot (in_ky_chot VARCHAR2);

    FUNCTION get_ky_chot
        RETURN VARCHAR2;

END;
