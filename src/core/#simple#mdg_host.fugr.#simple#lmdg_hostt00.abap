*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /SIMPLE/MDG_HOST................................*
DATA:  BEGIN OF STATUS_/SIMPLE/MDG_HOST              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/SIMPLE/MDG_HOST              .
CONTROLS: TCTRL_/SIMPLE/MDG_HOST
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */SIMPLE/MDG_HOST              .
TABLES: /SIMPLE/MDG_HOST               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
