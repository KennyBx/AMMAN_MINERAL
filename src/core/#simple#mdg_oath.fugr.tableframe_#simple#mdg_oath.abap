*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/SIMPLE/MDG_OATH
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/SIMPLE/MDG_OATH   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
