FORM cd_call_material.
  IF   ( upd_dgesv NE space )
    OR ( upd_dmaex NE space )
    OR ( upd_dmakt NE space )
    OR ( upd_dmape NE space )
    OR ( upd_dmarm NE space )
    OR ( upd_dmean NE space )
    OR ( upd_dmkal NE space )
    OR ( upd_dmlan NE space )
    OR ( upd_dprow NE space )
    OR ( upd_dqmat NE space )
    OR ( upd_dungv NE space )
    OR ( upd_mara NE space )
    OR ( upd_marc NE space )
    OR ( upd_marc_mass NE space )
    OR ( upd_mard NE space )
    OR ( upd_mard_mass NE space )
    OR ( upd_mbew NE space )
    OR ( upd_mbew_mass NE space )
    OR ( upd_mfhm NE space )
    OR ( upd_mfhm_mass NE space )
    OR ( upd_mlgn NE space )
    OR ( upd_mlgn_mass NE space )
    OR ( upd_mlgt NE space )
    OR ( upd_mlgt_mass NE space )
    OR ( upd_mpgd NE space )
    OR ( upd_mpgd_mass NE space )
    OR ( upd_mpop NE space )
    OR ( upd_mpop_mass NE space )
    OR ( upd_mvke NE space )
    OR ( upd_mvke_mass NE space )
    OR ( upd_icdtxt_material NE space )
  .
    CALL FUNCTION 'SWE_REQUESTER_TO_UPDATE'.
    CALL FUNCTION 'MATERIAL_WRITE_DOCUMENT' " IN UPDATE TASK
      EXPORTING
        objectid                = objectid
        tcode                   = tcode
        utime                   = utime
        udate                   = udate
        username                = username
        planned_change_number   = planned_change_number
        object_change_indicator = cdoc_upd_object
        planned_or_real_changes = cdoc_planned_or_real
        no_change_pointers      = cdoc_no_change_pointers
* updateflag of DGESV
        upd_dgesv               = upd_dgesv
* updateflag of DMAEX
        upd_dmaex               = upd_dmaex
* updateflag of DMAKT
        upd_dmakt               = upd_dmakt
* updateflag of DMAPE
        upd_dmape               = upd_dmape
* updateflag of DMARM
        upd_dmarm               = upd_dmarm
* updateflag of DMEAN
        upd_dmean               = upd_dmean
* updateflag of DMKAL
        upd_dmkal               = upd_dmkal
* updateflag of DMLAN
        upd_dmlan               = upd_dmlan
* updateflag of DPROW
        upd_dprow               = upd_dprow
* updateflag of DQMAT
        upd_dqmat               = upd_dqmat
* updateflag of DUNGV
        upd_dungv               = upd_dungv
* workarea_old of MARA
        o_mara                  = *mara
* workarea_new of MARA
        n_mara                  = mara
* updateflag of MARA
        upd_mara                = upd_mara
* workarea_old of MARC
        o_marc                  = *marc
* workarea_new of MARC
        n_marc                  = marc
* refarea_old of MARE
        o_mare                  = *mare
* refarea_new of MARE
        n_mare                  = mare
* updateflag of MARC
        upd_marc                = upd_marc
* updateflag of MARC_MASS
        upd_marc_mass           = upd_marc_mass
* workarea_old of MARD
        o_mard                  = *mard
* workarea_new of MARD
        n_mard                  = mard
* updateflag of MARD
        upd_mard                = upd_mard
* updateflag of MARD_MASS
        upd_mard_mass           = upd_mard_mass
* workarea_old of MBEW
        o_mbew                  = *mbew
* workarea_new of MBEW
        n_mbew                  = mbew
* updateflag of MBEW
        upd_mbew                = upd_mbew
* updateflag of MBEW_MASS
        upd_mbew_mass           = upd_mbew_mass
* workarea_old of MFHM
        o_mfhm                  = *mfhm
* workarea_new of MFHM
        n_mfhm                  = mfhm
* updateflag of MFHM
        upd_mfhm                = upd_mfhm
* updateflag of MFHM_MASS
        upd_mfhm_mass           = upd_mfhm_mass
* workarea_old of MLGN
        o_mlgn                  = *mlgn
* workarea_new of MLGN
        n_mlgn                  = mlgn
* updateflag of MLGN
        upd_mlgn                = upd_mlgn
* updateflag of MLGN_MASS
        upd_mlgn_mass           = upd_mlgn_mass
* workarea_old of MLGT
        o_mlgt                  = *mlgt
* workarea_new of MLGT
        n_mlgt                  = mlgt
* updateflag of MLGT
        upd_mlgt                = upd_mlgt
* updateflag of MLGT_MASS
        upd_mlgt_mass           = upd_mlgt_mass
* workarea_old of MPGD
        o_mpgd                  = *mpgd
* workarea_new of MPGD
        n_mpgd                  = mpgd
* updateflag of MPGD
        upd_mpgd                = upd_mpgd
* updateflag of MPGD_MASS
        upd_mpgd_mass           = upd_mpgd_mass
* workarea_old of MPOP
        o_mpop                  = *mpop
* workarea_new of MPOP
        n_mpop                  = mpop
* updateflag of MPOP
        upd_mpop                = upd_mpop
* updateflag of MPOP_MASS
        upd_mpop_mass           = upd_mpop_mass
* workarea_old of MVKE
        o_mvke                  = *mvke
* workarea_new of MVKE
        n_mvke                  = mvke
* updateflag of MVKE
        upd_mvke                = upd_mvke
* updateflag of MVKE_MASS
        upd_mvke_mass           = upd_mvke_mass
        upd_icdtxt_material     = upd_icdtxt_material
      TABLES
        icdtxt_material         = icdtxt_material
        xdgesv                  = xdgesv
        ydgesv                  = ydgesv
        xdmaex                  = xdmaex
        ydmaex                  = ydmaex
        xdmakt                  = xdmakt
        ydmakt                  = ydmakt
        xdmape                  = xdmape
        ydmape                  = ydmape
        xdmarm                  = xdmarm
        ydmarm                  = ydmarm
        xdmean                  = xdmean
        ydmean                  = ydmean
        xdmkal                  = xdmkal
        ydmkal                  = ydmkal
        xdmlan                  = xdmlan
        ydmlan                  = ydmlan
        xdprow                  = xdprow
        ydprow                  = ydprow
        xdqmat                  = xdqmat
        ydqmat                  = ydqmat
        xdungv                  = xdungv
        ydungv                  = ydungv
        xmarc_mass              = xmarc_mass
        ymarc_mass              = ymarc_mass
        xmard_mass              = xmard_mass
        ymard_mass              = ymard_mass
        xmbew_mass              = xmbew_mass
        ymbew_mass              = ymbew_mass
        xmfhm_mass              = xmfhm_mass
        ymfhm_mass              = ymfhm_mass
        xmlgn_mass              = xmlgn_mass
        ymlgn_mass              = ymlgn_mass
        xmlgt_mass              = xmlgt_mass
        ymlgt_mass              = ymlgt_mass
        xmpgd_mass              = xmpgd_mass
        ympgd_mass              = ympgd_mass
        xmpop_mass              = xmpop_mass
        ympop_mass              = ympop_mass
        xmvke_mass              = xmvke_mass
        ymvke_mass              = ymvke_mass.
  ENDIF.
  CLEAR planned_change_number.
ENDFORM.
