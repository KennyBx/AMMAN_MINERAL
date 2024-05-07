FORM CD_CALL_MATERIAL_N_LM.
  IF   ( UPD_DGESV NE SPACE )
    OR ( UPD_DMAEX NE SPACE )
    OR ( UPD_DMAKT NE SPACE )
    OR ( UPD_DMARM NE SPACE )
    OR ( UPD_DMEAN NE SPACE )
    OR ( UPD_DMKAL NE SPACE )
    OR ( UPD_DMLAN NE SPACE )
    OR ( UPD_DPROW NE SPACE )
    OR ( UPD_DUNGV NE SPACE )
    OR ( UPD_MARA NE SPACE )
    OR ( UPD_MARC NE SPACE )
    OR ( UPD_MARD NE SPACE )
    OR ( UPD_MBEW NE SPACE )
    OR ( UPD_MFHM NE SPACE )
    OR ( UPD_MLGN NE SPACE )
    OR ( UPD_MLGT NE SPACE )
    OR ( UPD_MPGD NE SPACE )
    OR ( UPD_MPOP NE SPACE )
    OR ( UPD_MVKE NE SPACE )
    OR ( UPD_ICDTXT_MATERIAL_N_LM NE SPACE )
  .
    CALL FUNCTION 'SWE_REQUESTER_TO_UPDATE'.
    CALL FUNCTION 'MATERIAL_N_LM_WRITE_DOCUMENT' " IN UPDATE TASK
        EXPORTING
          OBJECTID                = OBJECTID
          TCODE                   = TCODE
          UTIME                   = UTIME
          UDATE                   = UDATE
          USERNAME                = USERNAME
          PLANNED_CHANGE_NUMBER   = PLANNED_CHANGE_NUMBER
          OBJECT_CHANGE_INDICATOR = CDOC_UPD_OBJECT
          PLANNED_OR_REAL_CHANGES = CDOC_PLANNED_OR_REAL
          NO_CHANGE_POINTERS      = CDOC_NO_CHANGE_POINTERS
* updateflag of DGESV
          UPD_DGESV
                      = UPD_DGESV
* updateflag of DMAEX
          UPD_DMAEX
                      = UPD_DMAEX
* updateflag of DMAKT
          UPD_DMAKT
                      = UPD_DMAKT
* updateflag of DMARM
          UPD_DMARM
                      = UPD_DMARM
* updateflag of DMEAN
          UPD_DMEAN
                      = UPD_DMEAN
* updateflag of DMKAL
          UPD_DMKAL
                      = UPD_DMKAL
* updateflag of DMLAN
          UPD_DMLAN
                      = UPD_DMLAN
* updateflag of DPROW
          UPD_DPROW
                      = UPD_DPROW
* updateflag of DUNGV
          UPD_DUNGV
                      = UPD_DUNGV
* workarea_old of MARA
          O_MARA
                      = *MARA
* workarea_new of MARA
          N_MARA
                      = MARA
* updateflag of MARA
          UPD_MARA
                      = UPD_MARA
* workarea_old of MARC
          O_MARC
                      = *MARC
* workarea_new of MARC
          N_MARC
                      = MARC
* refarea_old of MARE
          O_MARE
                      = *MARE
* refarea_new of MARE
          N_MARE
                      = MARE
* updateflag of MARC
          UPD_MARC
                      = UPD_MARC
* workarea_old of MARD
          O_MARD
                      = *MARD
* workarea_new of MARD
          N_MARD
                      = MARD
* updateflag of MARD
          UPD_MARD
                      = UPD_MARD
* workarea_old of MBEW
          O_MBEW
                      = *MBEW
* workarea_new of MBEW
          N_MBEW
                      = MBEW
* updateflag of MBEW
          UPD_MBEW
                      = UPD_MBEW
* workarea_old of MFHM
          O_MFHM
                      = *MFHM
* workarea_new of MFHM
          N_MFHM
                      = MFHM
* updateflag of MFHM
          UPD_MFHM
                      = UPD_MFHM
* workarea_old of MLGN
          O_MLGN
                      = *MLGN
* workarea_new of MLGN
          N_MLGN
                      = MLGN
* updateflag of MLGN
          UPD_MLGN
                      = UPD_MLGN
* workarea_old of MLGT
          O_MLGT
                      = *MLGT
* workarea_new of MLGT
          N_MLGT
                      = MLGT
* updateflag of MLGT
          UPD_MLGT
                      = UPD_MLGT
* workarea_old of MPGD
          O_MPGD
                      = *MPGD
* workarea_new of MPGD
          N_MPGD
                      = MPGD
* updateflag of MPGD
          UPD_MPGD
                      = UPD_MPGD
* workarea_old of MPOP
          O_MPOP
                      = *MPOP
* workarea_new of MPOP
          N_MPOP
                      = MPOP
* updateflag of MPOP
          UPD_MPOP
                      = UPD_MPOP
* workarea_old of MVKE
          O_MVKE
                      = *MVKE
* workarea_new of MVKE
          N_MVKE
                      = MVKE
* updateflag of MVKE
          UPD_MVKE
                      = UPD_MVKE
          UPD_ICDTXT_MATERIAL_N_LM
                      = UPD_ICDTXT_MATERIAL_N_LM
        TABLES
          ICDTXT_MATERIAL_N_LM
                      = ICDTXT_MATERIAL_N_LM
          XDGESV
                      = XDGESV
          YDGESV
                      = YDGESV
          XDMAEX
                      = XDMAEX
          YDMAEX
                      = YDMAEX
          XDMAKT
                      = XDMAKT
          YDMAKT
                      = YDMAKT
          XDMARM
                      = XDMARM
          YDMARM
                      = YDMARM
          XDMEAN
                      = XDMEAN
          YDMEAN
                      = YDMEAN
          XDMKAL
                      = XDMKAL
          YDMKAL
                      = YDMKAL
          XDMLAN
                      = XDMLAN
          YDMLAN
                      = YDMLAN
          XDPROW
                      = XDPROW
          YDPROW
                      = YDPROW
          XDUNGV
                      = XDUNGV
          YDUNGV
                      = YDUNGV
    .
  ENDIF.
  CLEAR PLANNED_CHANGE_NUMBER.
ENDFORM.
