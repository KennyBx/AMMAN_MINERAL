CLASS /simple/mpoi_service_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES /simple/if_mdg_srv_provider .

    TYPES gty_mp_mapping TYPE /simple/mpoi_api .
    TYPES:
*    types:
*      begin of gty_mp_mapping,
*        equipment                      type  equnr,
*        functional_location            type  tplnr,
*        measurement_point_type         type  imrc_mptyp,
*        secondary_index                type  imrc_psort,
*        short_text                     type  imrc_pttxt,
*        characteristic_name            type  atnam,
*        code_group                     type  imrc_codgr,
*        valuation_code_sufficient      type  imrc_cdsuf,
*        point_will_be_counter          type  imrc_indct,
*        counter_runs_backwards         type  imrc_indrv,
*        additional_counter_data_unit   type  msehi,
*        annual_estimate                type  rimr0-pyeac,
*        counter_overflow               type  rimr0-cjumc,
*        measurement_range_unit         type  imrc_mrngu,
*        upper_measurement_range_limit  type  rimr0-mrmac,
*        lower_measurement_range_limit  type  rimr0-mrmic,
*        additional_short_text          type  imrc_dstxt,
*        target_value_unit              type  msehi,
*        target_value                   type  rimr0-desic,
*        number_decimal_places          type  imrc_decim,
*        power_of_ten_exponent          type  imrc_expon,
*        assembly                       type  imrc_locas,
*        authorization_group            type  iautg,
*        measurement_transfer_supported type  imrc_indtr,
*        counter_reading_transfer_mode  type  imrc_modtr,
*        trans_within_same_mpobj        type  imrc_trans,
*        trans_date_from                type  imrc_datlo,
*        trans_time_from                type  imrc_timlo,
*        user_data                      type  imptt_usr,
*      end of gty_mp_mapping.
      BEGIN OF gty_measuringpoint .
        INCLUDE TYPE /simple/c_measuringpoint.
    TYPES:
        cid TYPE string,
      END OF gty_measuringpoint .

    TYPES:
      BEGIN OF gty_mpoi_key_log ,
        measuring_point TYPE /simple/c_measuringpoint-measuringpoint,
      END OF gty_mpoi_key_log .

    TYPES:
      BEGIN OF gty_mpoi_key ,
        measuring_point TYPE /simple/c_measuringpoint-measuringpoint,
      END OF gty_mpoi_key.

    TYPES:   "Mapped late
      gty_mapped_late TYPE TABLE FOR MAPPED LATE /SIMPLE/C_MeasuringPoint .
    CLASS-DATA gv_mdg TYPE c .

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_object) TYPE REF TO /simple/mpoi_service_provider .
    METHODS create_appl_log .
    METHODS get_action
      RETURNING
        VALUE(ev_action) TYPE /simple/c_measuringpoint-action .
    "Flynn start insert++ - 20240313
    METHODS get_action_mode
      RETURNING
        VALUE(ev_action_mode) TYPE /simple/c_measuringpoint-actionMode.
    METHODS get_raw_data
      RETURNING
        VALUE(rv_raw_data) TYPE string .
    METHODS get_object_key
      EXPORTING
        ev_cid TYPE string
        es_key TYPE gty_mpoi_key .
    "Flynn end insert++ - 20240313
    METHODS get_data
      RETURNING
        VALUE(rs_data) TYPE gty_measuringpoint .
    METHODS set_data
      IMPORTING
        !is_data TYPE gty_measuringpoint .
    METHODS update_log_table
      IMPORTING
        !iv_save   TYPE c OPTIONAL
        !iv_status TYPE /simple/api_log-status
        !iv_step   TYPE /simple/api_log-step .
    CLASS-METHODS convert_f2p
      IMPORTING
        VALUE(iv_fltps)    TYPE imrc_mrmin OPTIONAL
        VALUE(iv_decimals) TYPE imrc_decim OPTIONAL
      EXPORTING
        VALUE(ev_packnum)  TYPE any .
    METHODS adjust_number
      EXPORTING
        !eo_deep_entity TYPE data .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA go_object TYPE REF TO /simple/mpoi_service_provider .
    DATA gs_class TYPE sethier-setclass .
    DATA gs_data TYPE gty_measuringpoint .
    DATA gs_inputmeasuringpoint TYPE gty_mp_mapping .
    DATA gs_log TYPE /simple/api_log .
    DATA gs_update TYPE imptt .
    DATA gt_message TYPE bapiret2_t .
    DATA gt_return TYPE bapiret2_t .
    DATA gv_external_log_no TYPE balhdri-extnumber .
    DATA gv_log_handle TYPE balloghndl .
    DATA gv_testrun TYPE abap_bool .
    DATA gv_raw_data TYPE string .  "Flynn insert++ - 20240313
    METHODS _change_mpoi .
    METHODS _create_mpoi .
    METHODS _delete_mpoi .
    METHODS _init .
    METHODS _map_respone
      IMPORTING
        !is_data TYPE any
      CHANGING
        !cr_data TYPE data .
    METHODS _save_log .
ENDCLASS.



CLASS /SIMPLE/MPOI_SERVICE_PROVIDER IMPLEMENTATION.


  METHOD /simple/if_mdg_srv_provider~change.
* Testrun check
    _init( ).

    /simple/if_mdg_srv_provider~validate_change(  ).

    IF gt_message IS INITIAL.

      /simple/if_mdg_srv_provider~do_mapping_change(  ).

      _change_mpoi(  ).

    ENDIF.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~clean_up.
    CLEAR: go_object.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~create.
* Testrun check
    me->_init( ).

    /simple/if_mdg_srv_provider~validate_create( ).

    IF gt_message IS INITIAL.

      /simple/if_mdg_srv_provider~do_mapping_create( ).

      _create_mpoi( ).

    ENDIF.

    et_message = gt_message.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~delete.
* Testrun check
    me->_init( ).

    /simple/if_mdg_srv_provider~validate_delete( ).

    IF gt_message IS INITIAL.

      /simple/if_mdg_srv_provider~do_mapping_change( ).

      _delete_mpoi( ).

    ENDIF.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_change.

    DATA:
      ls_markforchange TYPE string,
      lt_markforchange TYPE TABLE OF string.

    CLEAR gs_update.
    SELECT SINGLE *
      FROM imptt
      INTO gs_update
      WHERE point = gs_data-measuringpoint.

    IF gs_data-mdgmarkforchange IS INITIAL. RETURN. ENDIF.
    DATA(lv_changes) = gs_data-mdgmarkforchange.
    CONDENSE lv_changes NO-GAPS.
    SPLIT lv_changes AT ',' INTO TABLE lt_markforchange.
    LOOP AT lt_markforchange INTO ls_markforchange.
      CASE to_upper( ls_markforchange ).
        WHEN 'MEASURINGPOINTOBJECTIDENTIFIER'.
          gs_update-mpobj  = gs_data-measuringpointobjectidentifier.
        WHEN 'MEASURINGPOINTPOSITIONNUMBER'.
          gs_update-psort  = gs_data-measuringpointpositionnumber.
        WHEN 'AUTHORIZATIONGROUP'.
          gs_update-begru  = gs_data-authorizationgroup.
        WHEN 'MEASURINGPOINTISINACTIVE'.
          gs_update-inact  = gs_data-measuringpointisinactive.
        WHEN 'MEASURINGPOINTISCOUNTER'.
          gs_update-indct  = gs_data-measuringpointiscounter.
        WHEN 'MULTILEVELDELETIONLOGICSTATUS'.
          gs_update-lvorm  = gs_data-multileveldeletionlogicstatus.
        WHEN 'ASSEMBLY'.
          gs_update-locas  = gs_data-assembly.
        WHEN 'REFERENCEMEASURINGPOINT'.
          gs_update-refmp  = gs_data-referencemeasuringpoint.
        WHEN 'MEASURINGPOINTEXPONENT'.
          gs_update-expon  = gs_data-measuringpointexponent.
        WHEN 'MEASURINGPOINTDECIMALPLACES'.
          gs_update-decim  = gs_data-measuringpointdecimalplaces.
        WHEN 'MEASURINGPOINTMINIMUMTHRESHOLD'.
          gs_update-mrmin  = gs_data-measuringpointminimumthreshold.
        WHEN 'MEASURINGPOINTMAXIMUMTHRESHOLD'.
          gs_update-mrmax  = gs_data-measuringpointmaximumthreshold.
        WHEN 'MEASUREMENTRANGEUNIT'.
          gs_update-mrngu  = gs_data-measurementrangeunit.
        WHEN 'MSRGPTISCOUNTINGBACKWARDS'.
          gs_update-indrv  = gs_data-msrgptiscountingbackwards.
        WHEN 'MSMTRDNGSOURCEMEASURINGPOINT'.
          gs_update-trans  = gs_data-msmtrdngsourcemeasuringpoint.
        WHEN 'COUNTEROVERFLOWRDNGTHRESHOLD'.
          gs_update-cjump  = gs_data-counteroverflowrdngthreshold.
        WHEN 'MEASURINGPOINTANNUALESTIMATE'.
          gs_update-pyear  = gs_data-measuringpointannualestimate.
        WHEN 'MEASURINGPOINTCATALOGTYPE'.
          gs_update-codct  = gs_data-measuringpointcatalogtype.
        WHEN 'MEASURINGPOINTCODEGROUP'.
          gs_update-codgr  = gs_data-measuringpointcodegroup.
        WHEN 'VALUATIONCODEISSUFFICIENT'.
          gs_update-cdsuf  = gs_data-valuationcodeissufficient.
        WHEN 'LANGUAGE'.
          gs_update-mlang  = gs_data-language.
        WHEN 'MEASURINGPOINTDESCRIPTION'.
          gs_update-pttxt  = gs_data-measuringpointdescription.
        WHEN 'MEASURINGPOINTSHORTTEXT'.
          gs_update-dstxt  = gs_data-measuringpointshorttext.
        WHEN 'MEASURINGPOINTISREFERENCE'.
          gs_update-irfmp  = gs_data-measuringpointisreference.
        WHEN 'MEASUREMENTTRANSFERISSUPPORTED'.
          gs_update-indtr  = gs_data-measurementtransferissupported.
        WHEN 'MODEOFCOUNTERREADINGTRANSFER'.
          gs_update-modtr  = gs_data-modeofcounterreadingtransfer.
        WHEN 'MEASURINGPOINTHASLONGTEXT'.
          gs_update-kzltx  = gs_data-measuringpointhaslongtext.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_create.

    gs_inputmeasuringpoint-equipment                      = gs_data-equipment.
    gs_inputmeasuringpoint-functional_location            = gs_data-functionallocation.
    gs_inputmeasuringpoint-secondary_index                = gs_data-measuringpointpositionnumber.
    gs_inputmeasuringpoint-short_text                     = gs_data-measuringpointdescription.
    gs_inputmeasuringpoint-characteristic_name            = gs_data-characteristic.
    gs_inputmeasuringpoint-code_group                     = gs_data-measuringpointcodegroup.
    gs_inputmeasuringpoint-valuation_code_sufficient      = gs_data-valuationcodeissufficient.
    gs_inputmeasuringpoint-point_will_be_counter          = gs_data-measuringpointiscounter.
    gs_inputmeasuringpoint-counter_runs_backwards         = gs_data-msrgptiscountingbackwards.

    gs_inputmeasuringpoint-annual_estimate = COND #( WHEN gs_data-measuringpointannualestimate IS NOT INITIAL
                                                          THEN gs_data-measuringpointannualestimate
                                                          ELSE '' ).
    IF gs_inputmeasuringpoint-annual_estimate IS NOT INITIAL.
      /simple/mpoi_service_provider=>convert_f2p( EXPORTING iv_fltps    = gs_data-measuringpointannualestimate
                                                            iv_decimals = gs_data-measuringpointdecimalplaces
                                                  IMPORTING ev_packnum  = gs_inputmeasuringpoint-annual_estimate ).
    ENDIF.

    gs_inputmeasuringpoint-measurement_range_unit         = gs_data-measurementrangeunit.

    /simple/mpoi_service_provider=>convert_f2p( EXPORTING iv_fltps    = gs_data-measuringpointmaximumthreshold
                                                          iv_decimals = gs_data-measuringpointdecimalplaces
                                                IMPORTING ev_packnum  = gs_inputmeasuringpoint-upper_measurement_range_limit ).
    /simple/mpoi_service_provider=>convert_f2p( EXPORTING iv_fltps    = gs_data-measuringpointminimumthreshold
                                                          iv_decimals = gs_data-measuringpointdecimalplaces
                                                IMPORTING ev_packnum  = gs_inputmeasuringpoint-lower_measurement_range_limit ).

    gs_inputmeasuringpoint-additional_short_text          = gs_data-measuringpointshorttext.
    /simple/mpoi_service_provider=>convert_f2p( EXPORTING iv_fltps    = gs_data-measuringpointtargetvalue
                                                          iv_decimals = gs_data-measuringpointdecimalplaces
                                                IMPORTING ev_packnum  = gs_inputmeasuringpoint-target_value ).

    gs_inputmeasuringpoint-number_decimal_places          = gs_data-measuringpointdecimalplaces.
    gs_inputmeasuringpoint-power_of_ten_exponent          = gs_data-measuringpointexponent.
    gs_inputmeasuringpoint-assembly                       = gs_data-assembly.
    gs_inputmeasuringpoint-authorization_group            = gs_data-authorizationgroup.
    gs_inputmeasuringpoint-measurement_transfer_supported = gs_data-measurementtransferissupported.
    gs_inputmeasuringpoint-counter_reading_transfer_mode  = gs_data-modeofcounterreadingtransfer.
    gs_inputmeasuringpoint-trans_within_same_mpobj        = gs_data-msmtrdngsourcemeasuringpoint.
    IF gs_inputmeasuringpoint-point_will_be_counter = abap_on.
      CLEAR gs_inputmeasuringpoint-target_value.
      CLEAR gs_data-measuringpointminimumthreshold.
      CLEAR gs_data-measuringpointmaximumthreshold.
    ELSE.
      CLEAR gs_data-counteroverflowrdngthreshold.
      CLEAR gs_data-measuringpointannualestimate.
    ENDIF.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_delete.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_change.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_create.

    DATA: lv_target TYPE /simple/mpoi_api-target_value.
* TODO
    IF NOT gs_data-equipment IS INITIAL AND
       NOT gs_data-functionallocation IS INITIAL.
*    message x750(ir) with 'EQUIPMENT' 'FUNCTIONAL_LOCATION'.
      gt_message = VALUE #( BASE gt_message
                                  ( type       = 'E'
                                    id         = 'IR'
                                    number     = '750'
                                    message_v1 = 'EQUIPMENT'
                                    message_v2 = 'FUNCTIONAL_LOCATION'
                                     ) ).
    ENDIF.

** Counter specific checks
    IF gs_data-measuringpointiscounter = abap_on.
*   Counter specific checks
      IF  gs_data-characteristic IS INITIAL.
        gt_message = VALUE #( BASE gt_message
                                    ( type       = 'E'
                                      id         = 'IR'
                                      number     = '750'
                                      message_v1 = 'POINT_WILL_BE_COUNTER'
                                      message_v2 = 'CHARACTERISTIC_NAME'
                                       ) ).
      ENDIF.

      IF NOT gs_data-measuringpointtargetvalue IS INITIAL.
        gt_message = VALUE #( BASE gt_message
                                    ( type       = 'E'
                                      id         = 'IR'
                                      number     = '750'
                                      message_v1 = 'POINT_WILL_BE_COUNTER'
                                      message_v2 = 'TARGET_VALUE'
                                       ) ).
*      endif.
      ENDIF.
    ELSE.
*   Non-Counter specific checks
      IF gs_data-characteristic IS INITIAL AND
          gs_data-measuringpointcodegroup IS INITIAL.
        gt_message = VALUE #( BASE gt_message
                                    ( type       = 'E'
                                      id         = 'IR'
                                      number     = '750'
                                      message_v1 = 'CODE_GROUP'
                                      message_v2 = 'CHARACTERISTIC_NAME'
                                       ) ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_delete.
  ENDMETHOD.


  METHOD adjust_number.
    _map_respone( EXPORTING is_data = gs_data
                   CHANGING cr_data = eo_deep_entity  ).
  ENDMETHOD.


  METHOD convert_f2p.
* Conversion floating point to packed decimal

    DATA:
      lv_char    TYPE char20,
      lv_packed  TYPE REF TO data,
      ls_default TYPE bapidefaul,
      lt_return  TYPE STANDARD TABLE OF bapiret2.
    FIELD-SYMBOLS:
      <fs_packed>     TYPE any.

    CREATE DATA lv_packed TYPE p LENGTH 16 DECIMALS iv_decimals.
    ASSIGN lv_packed->* TO <fs_packed>.

    <fs_packed> = iv_fltps.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = sy-uname
      IMPORTING
        defaults = ls_default
      TABLES
        return   = lt_return.

    IF ls_default-dcpfm = 'Y' OR ls_default-dcpfm IS INITIAL.
      lv_char = <fs_packed>.
      CONDENSE lv_char NO-GAPS.
      REPLACE ALL OCCURRENCES OF '.' IN lv_char WITH ','.
      ev_packnum = lv_char.
    ELSE.
      ev_packnum = <fs_packed>.
    ENDIF.

  ENDMETHOD.


  METHOD create_appl_log.
    IF gv_external_log_no IS INITIAL.
      gv_external_log_no = COND #( WHEN gs_data-activateid IS INITIAL
      THEN ''
      ELSE gs_data-activateid && gs_data-activateitemid ).
    ENDIF.

    IF gv_external_log_no IS NOT INITIAL.
      gv_log_handle = /simple/cl_mdg_gw_core_dpc_ext=>create_appl_log(
                      iv_extnumber  = gv_external_log_no
                      iv_object     = /simple/cl_mdg_gw_core_dpc_ext=>gc_log_obj
                      iv_subobject  = 'MPOI' ).
    ENDIF.
  ENDMETHOD.


  METHOD get_action.
    ev_action = gs_data-action .
  ENDMETHOD.


  METHOD get_action_mode.
    ev_action_mode = gs_data-actionmode.
  ENDMETHOD.


  METHOD get_raw_data.
    rv_raw_data = gv_raw_data.
  ENDMETHOD.


  METHOD get_object_key.
    ev_cid = gs_data-cid.
  ENDMETHOD.


  METHOD get_data.
    rs_data = me->gs_data.
  ENDMETHOD.


  METHOD get_instance.
    IF go_object IS INITIAL.
      go_object = NEW #( ).
    ENDIF.
    ro_object = go_object.
  ENDMETHOD.


  METHOD set_data.
    IF is_data IS NOT INITIAL.
      gs_data = is_data.
    ENDIF.
  ENDMETHOD.


  METHOD update_log_table.

    IF gs_log IS INITIAL.
      gs_log-activate_id      = gs_data-activateid.
      gs_log-activate_item_id = gs_data-activateitemid.

      gs_log-cr_number        = gs_log-activate_id.
      gs_log-cr_item          = gs_log-activate_item_id.
      gs_log-obj_type         = 'MPOI'.

      gs_log-mdg_key          = gs_data-measuringpoint.
    ENDIF.

    gs_log-status = iv_status.
    gs_log-step   = iv_step.

    IF iv_save IS NOT INITIAL.
      LOOP AT gt_message INTO DATA(ls_msg).
        IF ls_msg-type CA 'EAX'.
          MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
          WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
          INTO DATA(lv_msg).

          IF gs_log-message_log IS INITIAL.
            gs_log-message_log = condense( lv_msg ).
          ELSE.
            gs_log-message_log = gs_log-message_log && |,| && condense( lv_msg ).
          ENDIF.
        ENDIF.


        IF gv_log_handle IS NOT INITIAL.
          /simple/cl_mdg_gw_core_dpc_ext=>add_message_to_log(
              iv_log_handle = gv_log_handle
              is_message    = VALUE bal_s_msg(
                                          msgty = ls_msg-type
                                          msgid = ls_msg-id
                                          msgno = ls_msg-number
                                          msgv1 = ls_msg-message_v1
                                          msgv2 = ls_msg-message_v2
                                          msgv3 = ls_msg-message_v3
                                          msgv4 = ls_msg-message_v4 )
          ).
        ENDIF.
      ENDLOOP.
*---SAVE LOG TABLE
      _save_log( ).
    ENDIF.
  ENDMETHOD.


  METHOD _change_mpoi.
    DATA:
      lt_imptt TYPE STANDARD TABLE OF imptt.

    IF gs_update IS NOT INITIAL.
      APPEND gs_update TO lt_imptt.
    ENDIF.

    CALL FUNCTION '/SIMPLE/FM_MPOI_UPDATE'
      EXPORTING
        iv_mode  = 'U'
      TABLES
        it_imptt = lt_imptt.

  ENDMETHOD.


  METHOD _create_mpoi.

    DATA:
      lv_measuringpoint TYPE imrc_point.
    CLEAR: gt_return[].
    IF to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION' OR
       "to_upper( gs_data-actionmode ) = 'BACKGROUND'.  "Flynn dim code
       to_upper( gs_data-actionmode ) = 'VALIDATION'.   "Flynn insert++
      CALL FUNCTION '/SIMPLE/FM_MPOI_CREATE' IN BACKGROUND TASK
        EXPORTING
          is_mpoi_mapping      = gs_inputmeasuringpoint
          iv_background        = 'X'
          iv_mdglogid          = gs_data-mdglogid
          iv_testrun           = gv_testrun
        IMPORTING
          ev_measurement_point = lv_measuringpoint
          et_return            = gt_return.
    ELSE.

      CALL FUNCTION '/SIMPLE/FM_MPOI_CREATE'
        EXPORTING
          is_mpoi_mapping      = gs_inputmeasuringpoint
          iv_background        = ' '
          iv_mdglogid          = gs_data-mdglogid
          iv_testrun           = gv_testrun
        IMPORTING
          ev_measurement_point = lv_measuringpoint
          et_return            = gt_return.
    ENDIF.

    IF gt_return IS NOT INITIAL.
      APPEND LINES OF gt_return TO gt_message.
    ENDIF.

    IF gv_testrun IS INITIAL AND
      line_exists( gt_message[ type = 'S' ] ).
      gs_data-measuringpoint = lv_measuringpoint.

    ENDIF.


  ENDMETHOD.


  METHOD _delete_mpoi.

    DATA:
      lt_imptt TYPE STANDARD TABLE OF imptt.
    IF gs_update IS NOT INITIAL.
      APPEND gs_update TO lt_imptt.
    ENDIF.

    CALL FUNCTION '/SIMPLE/FM_MPOI_UPDATE'
      EXPORTING
        iv_mode  = 'Ð'
      TABLES
        it_imptt = lt_imptt.


  ENDMETHOD.


  METHOD _init.
    gv_mdg = abap_on.
    IF to_upper( gs_data-actionmode ) = 'VALIDATION' OR
       to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION'.
      gv_testrun = 'X'.
    ENDIF.
  ENDMETHOD.


  METHOD _map_respone.
    FIELD-SYMBOLS:
          <ls_data> TYPE any.

    CREATE DATA cr_data LIKE is_data.
    ASSIGN cr_data->* TO <ls_data>.
    <ls_data> = is_data.

  ENDMETHOD.


  METHOD _save_log.
    CALL FUNCTION '/SIMPLE/FM_LOG_SAVE'
      EXPORTING
        is_log        = gs_log
        iv_log_handle = gv_log_handle.
  ENDMETHOD.
ENDCLASS.
