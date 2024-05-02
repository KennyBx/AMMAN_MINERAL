*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /SIMPLE/TARSYS..................................*
DATA:  BEGIN OF STATUS_/SIMPLE/TARSYS                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/SIMPLE/TARSYS                .
CONTROLS: TCTRL_/SIMPLE/TARSYS
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: */SIMPLE/TARSYS                .
TABLES: /SIMPLE/TARSYS                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
