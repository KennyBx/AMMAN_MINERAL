*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /SIMPLE/MDG_CONF................................*
DATA:  BEGIN OF STATUS_/SIMPLE/MDG_CONF              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/SIMPLE/MDG_CONF              .
CONTROLS: TCTRL_/SIMPLE/MDG_CONF
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */SIMPLE/MDG_CONF              .
TABLES: /SIMPLE/MDG_CONF               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
