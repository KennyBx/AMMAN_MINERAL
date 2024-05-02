*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /SIMPLE/DYNAMICF................................*
DATA:  BEGIN OF STATUS_/SIMPLE/DYNAMICF              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/SIMPLE/DYNAMICF              .
CONTROLS: TCTRL_/SIMPLE/DYNAMICF
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: */SIMPLE/DYNAMICF              .
TABLES: /SIMPLE/DYNAMICF               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
