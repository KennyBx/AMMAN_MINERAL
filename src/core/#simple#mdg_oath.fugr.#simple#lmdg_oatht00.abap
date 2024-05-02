*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /SIMPLE/MDG_OATH................................*
DATA:  BEGIN OF STATUS_/SIMPLE/MDG_OATH              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/SIMPLE/MDG_OATH              .
CONTROLS: TCTRL_/SIMPLE/MDG_OATH
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */SIMPLE/MDG_OATH              .
TABLES: /SIMPLE/MDG_OATH               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
