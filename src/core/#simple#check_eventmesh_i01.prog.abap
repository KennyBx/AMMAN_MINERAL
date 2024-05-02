*&---------------------------------------------------------------------*
*& Include          /SIMPLE/CONFIG_EVENTMESH_I01
*&---------------------------------------------------------------------*

  FORM check_destination USING iv_des_name TYPE char100
                               iv_check_destination TYPE char1.
    DATA: lv_version       TYPE i VALUE 4,
          lv_event_handler TYPE REF TO  lcl_mqtt_event_handler,
          subrc            TYPE sysubrc,
          dummy            TYPE string.
    TRY.
** Create RFC connect
        cl_http_client=>create_by_destination(
          EXPORTING
            destination              = iv_des_name
          IMPORTING
            client                   = go_http_client
          EXCEPTIONS
            argument_not_found       = 1
            destination_not_found    = 2
            destination_no_authority = 3
            plugin_not_active        = 4
            internal_error           = 5
            OTHERS                   = 6 ).
        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              gv_error_text = 'Create failed: Argument not found'. "#EC NOTEXT
            WHEN 2.
              gv_error_text =  'Create failed: destination not found'. "#EC NOTEXT
            WHEN 3.
              gv_error_text =  'Create failed: destination no authority'. "#EC NOTEXT
            WHEN 4.
              gv_error_text = 'Create failed: plugin not active'. "#EC NOTEXT
            WHEN 5.
              gv_error_text =  'Create failed: internal error'. "#EC NOTEXT
            WHEN OTHERS.
              gv_error_text =  'Create failed'.             "#EC NOTEXT
          ENDCASE.
          go_http_client->close( ).
          RETURN.
        ENDIF.

        go_http_client->propertytype_logon_popup = if_http_client=>co_disabled.
      CATCH cx_oa2c INTO DATA(lx_oa2c).
        gv_error_text = lx_oa2c->get_text( ).
    ENDTRY.

    IF iv_check_destination = abap_true.
      CALL METHOD go_http_client->request->set_header_field
        EXPORTING
          name  = '~request_method'
          value = 'GET'.

      cl_http_utility=>set_request_uri( request = go_http_client->request
                                        uri     = dummy ).

      CALL METHOD go_http_client->send
        EXCEPTIONS
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          OTHERS                     = 4.
      IF sy-subrc <> 0.
        CALL METHOD go_http_client->get_last_error
          IMPORTING
            code    = subrc
            message = gv_error_text.

        go_http_client->close( ).
        RETURN.
      ENDIF.

      CALL METHOD go_http_client->receive
        EXCEPTIONS
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          OTHERS                     = 4.
      IF sy-subrc <> 0.
        CALL METHOD go_http_client->get_last_error
          IMPORTING
            code    = subrc
            message = gv_error_text.
        go_http_client->close( ).
        RETURN.
      ENDIF.

      DATA: l_status TYPE i.
      CALL METHOD go_http_client->response->get_status(
        IMPORTING
          code = l_status ).
      IF l_status <> 200 AND  l_status <> 204 AND gv_error_text IS INITIAL.
        gv_error_text =  'Create failed'.                   "#EC NOTEXT
        RETURN.
      ENDIF.

    ENDIF.
  ENDFORM.


  FORM check_oauth_token USING iv_auth_profile TYPE oa2c_profile.

    DATA: lo_oa2c_client TYPE REF TO if_oauth2_client,
          lv_param_kind  TYPE string VALUE 'H'.

** Set token for authorization Oauth 2.0
    TRY .
        cl_oauth2_client=>create( EXPORTING i_profile        = CONV #( iv_auth_profile )
                                  RECEIVING ro_oauth2_client = lo_oa2c_client ).
      CATCH cx_oa2c INTO DATA(exc1).
        gv_oa2c = exc1->get_text( ).
        RETURN.
    ENDTRY.

    TRY .
        IF lo_oa2c_client IS NOT INITIAL.
          lo_oa2c_client->set_token( EXPORTING io_http_client = go_http_client
                                               i_param_kind   = lv_param_kind ).
        ENDIF.

      CATCH cx_oa2c INTO DATA(exc2).
        TRY .
            CALL METHOD lo_oa2c_client->execute_cc_flow.

          CATCH cx_oa2c INTO DATA(exc3).
            gv_oa2c = exc3->get_text( ).
        ENDTRY.
        TRY .
            lo_oa2c_client->set_token( EXPORTING io_http_client = go_http_client ).
          CATCH cx_oa2c INTO DATA(exc4).
            gv_oa2c = exc4->get_text( ).
        ENDTRY.
    ENDTRY.

  ENDFORM.


  FORM check_authorization USING iv_uname TYPE sy-uname.
    DATA: lt_tcode TYPE TABLE OF string WITH EMPTY KEY.
    READ TABLE gt_data ASSIGNING FIELD-SYMBOL(<fs_data>) INDEX 5.
    AUTHORITY-CHECK OBJECT 'S_RFC' FOR USER iv_uname
    ID 'RFC_TYPE' DUMMY
    ID 'RFC_NAME' DUMMY
    ID 'ACTVT' DUMMY .
    IF sy-subrc <> 0.
      CONCATENATE gv_message 'No authorization for object S_RFC' INTO gv_message SEPARATED BY cl_abap_char_utilities=>cr_lf.
    ENDIF .

    AUTHORITY-CHECK OBJECT 'S_SERVICE' FOR USER iv_uname
    ID 'SRV_NAME' DUMMY
    ID 'SRV_NAME' DUMMY
    ID 'ACTVT' DUMMY .
    IF sy-subrc <> 0.
      CONCATENATE gv_message  'No authorization for object S_SERVICE' INTO gv_message SEPARATED BY  cl_abap_char_utilities=>cr_lf .
    ENDIF .

    AUTHORITY-CHECK OBJECT 'S_OA2C_USE' FOR USER iv_uname
    ID 'OA2C_PROF' DUMMY
    ID 'ACTVT' DUMMY .
    IF sy-subrc <> 0.
      CONCATENATE gv_message 'No authorization for object S_OA2C_USE' INTO gv_message SEPARATED BY  cl_abap_char_utilities=>cr_lf.
    ENDIF .

    AUTHORITY-CHECK OBJECT 'S_SCOPE' FOR USER iv_uname
    ID 'OA2_CLIENT' DUMMY
    ID 'OA2_SCOPE' DUMMY.
    IF sy-subrc <> 0.
      CONCATENATE gv_message 'No authorization for object S_SCOPE' INTO gv_message SEPARATED BY  cl_abap_char_utilities=>cr_lf.
    ENDIF .
    " Check authorization for Tcodes:
    lt_tcode = VALUE #( BASE lt_tcode
              ( CONV string( 'SEGW'         ) )
              ( CONV string( 'OA2C_CONFIG'  ) )
              ( CONV string( 'SNRO'         ) )
              ( CONV string( 'SM59'         ) )
              ( CONV string( 'SBGRFCCONF'   ) )
              ( CONV string( 'SBGRFCMON'    ) )
    ).
    LOOP AT lt_tcode INTO DATA(ls_tcode).
      DATA: lv_tcode TYPE c LENGTH 30.
      lv_tcode = ls_tcode.
      AUTHORITY-CHECK OBJECT 'S_TCODE'
      ID 'TCD' FIELD lv_tcode  .  "Authorization group ABAP/4 program
      IF sy-subrc <> 0.
        CONCATENATE 'No authorization for Tcode' ls_tcode INTO gv_message SEPARATED BY cl_abap_char_utilities=>cr_lf.
      ENDIF.
    ENDLOOP.
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SEND_MESSAGE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM send_message .

    DATA: lo_ems          TYPE REF TO /simple/cl_ems_provider,
          lv_status       TYPE string,
          lv_log_handle   TYPE balloghndl,
          ls_api_log      TYPE /simple/api_log,
          ls_api_log_out  TYPE /simple/api_log,
          lv_radom_string TYPE string.


* alphabets random
    CALL FUNCTION 'GENERAL_GET_RANDOM_STRING'
      EXPORTING
        number_chars  = 15
      IMPORTING
        random_string = lv_radom_string.

    ls_api_log-step             = 'V'.
    ls_api_log-status           = 'F'.
    ls_api_log-cr_number        = 'TEST_EVENT_MESH'.
    ls_api_log-mdglogid         = lv_radom_string.


    CALL FUNCTION '/SIMPLE/FM_LOG_SAVE'
      EXPORTING
        is_log        = ls_api_log
        iv_log_handle = lv_log_handle
      IMPORTING
        es_log        = ls_api_log_out.

    WAIT UP TO  5 SECONDS.
    SELECT SINGLE * FROM /simple/api_log
       WHERE mdglogid  = @ls_api_log_out-mdglogid
        INTO @DATA(ls_api_log_after).

    IF ls_api_log_after-status_code <> '204'.
      gv_error_text = 'Send Fail'.
    ENDIF.
  ENDFORM.
