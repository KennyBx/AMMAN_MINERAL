FUNCTION /simple/fm_prd_execute.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_RAW) TYPE  STRING OPTIONAL
*"     VALUE(IT_HEADER) TYPE  /SIMPLE/T_CORE_HTTP_HEADER OPTIONAL
*"  EXPORTING
*"     VALUE(EV_STATUS) TYPE  CHAR1
*"     VALUE(EV_PRODUCT) TYPE  MATNR
*"     VALUE(ET_MESSAGE) TYPE  BAPIRET2_T
*"----------------------------------------------------------------------
  DATA: ls_data       TYPE /simple/prd_service_provider=>gty_deep_data,
*        ls_log        TYPE /simple/api_log,
        lv_log_handle TYPE balloghndl,
        lv_msgerr     TYPE char255,
        ls_response   TYPE /simple/cl_mdg_gw_core_dpc_ext=>ts_response_me.
*Start of Insert BEN 25052023
  GET RUN TIME FIELD /simple/cl_mdg_gw_core_dpc_ext=>gv_tstart.
  LOOP AT it_header INTO DATA(ls_header).
    IF ls_header-name CS 'messaging_core'.
      /simple/cl_mdg_gw_core_dpc_ext=>gv_messaging_core        = ls_header-value .
    ELSEIF ls_header-name CS 'messaging_object_type'.
      /simple/cl_mdg_gw_core_dpc_ext=>gv_messaging_object_type = ls_header-value .
    ENDIF.
  ENDLOOP.
*End of Insert BEN 25052023
  TRY.
      /ui2/cl_json=>deserialize( EXPORTING json = iv_raw pretty_name = /ui2/cl_json=>pretty_mode-camel_case CHANGING data = ls_data ).

      "Get instance object
      DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).

      "Set data to instance object
      lo_object->set_data( is_data = ls_data ).

      DATA lt_message TYPE bapiret2_t.

      CALL FUNCTION '/SIMPLE/FM_PRD_EXECUTE2'
        IMPORTING
          et_message    = lt_message
        EXCEPTIONS
          error_message = 1.
      IF sy-subrc <> 0.
        lt_message = VALUE #( BASE lt_message (
            type       = sy-msgty
            id         = sy-msgid
            number     = sy-msgno
            message_v1 = sy-msgv1
            message_v2 = sy-msgv2
            message_v3 = sy-msgv3
            message_v4 = sy-msgv4  ) ).
      ENDIF.

    CATCH cx_root INTO DATA(lo_exception).
      lt_message = VALUE #( BASE lt_message ( type = 'E' message = lo_exception->get_text( ) ) ).
  ENDTRY.

  " Update product number
  IF NOT to_upper( ls_data-actionmode ) CS 'VALIDATION'
    AND ls_data-product IS INITIAL.
    lo_object->get_object_key( IMPORTING ev_product = DATA(lv_product) ).
    ls_data-product = lv_product.
  ENDIF.

  DATA(ls_data_response) = ls_data.

  IF ls_data_response IS INITIAL.
    MOVE-CORRESPONDING ls_data TO ls_data_response.
  ENDIF.
  CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
    EXPORTING
      input  = ls_data_response-product
    IMPORTING
      output = ls_data_response-product.
  IF sy-subrc <> 0.
  ENDIF.
  et_message = lt_message.
  ev_status  = /simple/prd_service_provider=>gv_status.
  ev_product = ls_data_response-product.

* Start of Insert BLE 20230216
  MOVE-CORRESPONDING ls_data TO ls_response.

  ls_response-mdkey =  /simple/cl_json_utility=>convert_stuct_to_json(
                          EXPORTING im_s_data = VALUE /simple/prd_service_provider=>gty_prd_key_log(
                                                     product = ls_data_response-product )
                                    im_v_case = /simple/cl_json_utility=>co_ftype_camelcase ).
  GET RUN TIME FIELD /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop.
  /simple/cl_mdg_gw_core_dpc_ext=>handle_appl_log( EXPORTING is_response  = ls_response
                                                             it_message   = lt_message
                                                             it_message2  = lt_message
                                                             iv_status    = /simple/prd_service_provider=>gv_status
                                                             iv_step      = /simple/prd_service_provider=>gv_step
                                                             iv_subobject = /simple/cl_mdg_gw_core_dpc_ext=>gc_log_product ).
* End of Insert BLE 20230216
ENDFUNCTION.
