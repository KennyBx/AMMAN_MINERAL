class /SIMPLE/CL_EMS_PROVIDER definition
  public
  final
  create public .

public section.

  methods MANAGEMENT_EMS_API
    importing
      !IS_LOG type /SIMPLE/API_LOG optional
      !IV_TOPIC_NAME type STRING optional
      !IV_AUTH_PROFILE type OA2C_PROFILE optional
      !IV_DESTINATION type CHAR100 optional
      !IV_HOST type STRING optional
    returning
      value(IS_CODE) type /SIMPLE/API_LOG .
*    exporting
*      !EV_STATUS type STRING .
  PROTECTED SECTION.
private section.

  data GO_HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  data GO_AUTH_CLIENT type ref to IF_OAUTH2_CLIENT .
  data ACCESS_TOKEN type STRING .
  data GV_STATUS type STRING .

  methods CREATE_BY_DESTINATION
    importing
      !IV_DES_NAME type CHAR100 .
  methods SET_OAUTH_TOKEN
    importing
      !IV_AUTH_PROFILE type OA2C_PROFILE .
  methods EXECUTE_EMS_REQUEST
    importing
      !IS_LOG type STRING
      !IV_NAME type STRING
    returning
      value(IS_CODE) type /SIMPLE/API_LOG .
  methods GET_ACCESS_TOKEN
    importing
      !IV_URL type STRING
      !IV_USER type STRING
      !IV_PASSWORD type STRING
    returning
      value(RV_ACCESS_TOKEN) type STRING .
  methods CONVERT_ABAP_TO_JSON
    importing
      !IS_LOG type /SIMPLE/API_LOG
    returning
      value(RV_TEXT) type STRING .
  methods DEST_PROVIDER
    importing
      !IV_URL type STRING
      !IV_TOKEN type STRING
      !IV_MESSAGE type STRING .
ENDCLASS.



CLASS /SIMPLE/CL_EMS_PROVIDER IMPLEMENTATION.


  METHOD convert_abap_to_json.

    TRY.
        /simple/cl_json_utility=>convert_stuct_to_json(
        EXPORTING
          im_s_data = is_log
          im_v_case = /simple/cl_json_utility=>co_ftype_lowercase
        RECEIVING
          rt_v_json = rv_text
      ).

      CATCH /simple/cx_json_conversion_err.    " Error during JSON Conversion
    ENDTRY.
  ENDMETHOD.


  METHOD create_by_destination.

    TRY.
** Create RFC connect
        cl_http_client=>create_by_destination(
                                    EXPORTING  destination = iv_des_name
                                    IMPORTING  client                   = go_http_client
                                    EXCEPTIONS argument_not_found       = 1
                                               destination_not_found    = 2
                                               destination_no_authority = 3
                                               plugin_not_active        = 4
                                               internal_error           = 5
                                               OTHERS                   = 6 ).
      CATCH cx_root INTO DATA(lx_exception).
    ENDTRY.

    go_http_client->propertytype_logon_popup = if_http_client=>co_disabled.
  ENDMETHOD.


  METHOD dest_provider.

    DATA:
      lo_http_client TYPE REF TO if_http_client,
      lv_utf8content TYPE xstring,
      lv_response    TYPE string,
      lv_utf8length  TYPE i,
      lv_subrc       TYPE string,
      lv_code        TYPE i,
      lv_reason      TYPE string.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url    = iv_url
      IMPORTING
        client = lo_http_client.

    lo_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

    CALL METHOD lo_http_client->request->set_method( method = 'POST' ).
    CALL METHOD lo_http_client->request->set_header_field(
        name  = 'x-qos'
        value = '1' ).
    CALL METHOD lo_http_client->request->set_header_field(
        name  = 'authorization'
        value = iv_token ).

    CALL METHOD lo_http_client->request->set_cdata( data = iv_message ).

    CALL METHOD lo_http_client->send
      EXPORTING
        timeout                    = 5000
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.
    IF sy-subrc <> 0.
      lv_subrc = sy-subrc.
*      gv_status = 'HTTP communication failure'.
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    CALL METHOD lo_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3.
    IF sy-subrc <> 0.
      lv_subrc = sy-subrc.
*      gv_status = 'HTTP communication failure'.
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    CALL METHOD lo_http_client->response->get_status
      IMPORTING
        code   = lv_code
        reason = lv_reason.

    lv_utf8content = lo_http_client->response->get_data( ).
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = lv_utf8content
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = lv_response.

    IF lv_code < 200 OR lv_code >= 300.
      lv_subrc = lv_code.
*      gv_status = 'HTTP communication failure'.
      lv_utf8content = lo_http_client->response->get_data( ).
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    lo_http_client->close( ).
  ENDMETHOD.


  METHOD execute_ems_request.
*    TRY.
    DATA: lv_url    TYPE string,
          lv_reason TYPE string,
          ls_msg    TYPE symsg,
          lv_msg    TYPE string.
    DATA(lt_request_headers) = VALUE tihttpnvp( ( name  = 'x-qos'
                                                  value = '1' )
                                                 ( name  = 'Content-Type'
                                                  value = 'application/json' ) ).
* Setting up of Request Parameters to Remote call

** Set URL
    lv_url = '/messagingrest/v1/topics/' && iv_name && '/messages'.
    cl_http_utility=>set_request_uri( EXPORTING request = go_http_client->request
                                                uri     = lv_url ).

    LOOP AT lt_request_headers ASSIGNING FIELD-SYMBOL(<ls_headers>).
      go_http_client->request->set_header_field( EXPORTING name  = <ls_headers>-name
                                                           value = <ls_headers>-value ).
    ENDLOOP.

    go_http_client->refresh_cookie( ).
    go_http_client->request->set_method( method = 'POST' ).

    CALL METHOD go_http_client->request->set_cdata( data = is_log ).

    " Send / Receive request
    go_http_client->send(
      EXPORTING
        timeout                    = 9999
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
             INTO lv_msg.

    ENDIF.


    go_http_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
             INTO lv_msg.
    ENDIF.

    DATA: lt_headers TYPE tihttpnvp.

    CALL METHOD go_http_client->response->get_header_fields( CHANGING fields = lt_headers ).

    go_http_client->response->get_status( IMPORTING code   = DATA(lv_code)
                                                    reason = lv_reason ).

    DATA(lv_payload) = go_http_client->response->get_cdata(  ).
    " Close
    go_http_client->close(
      EXCEPTIONS
        http_invalid_state = 1
        OTHERS             = 2
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
             INTO lv_msg.
    ENDIF.

    is_code = VALUE #( status_code = lv_code
                       reson_log   = COND #( WHEN lv_payload IS NOT INITIAL THEN lv_payload
                                             WHEN lv_reason IS NOT INITIAL THEN lv_reason
                                             ELSE  lv_msg ) ).
    CLEAR: lv_code, lv_reason.
  ENDMETHOD.


  METHOD get_access_token.

    TYPES:
      BEGIN OF lty_access_token,
        access_token TYPE string,
        token_type   TYPE string,
        expires_in   TYPE string,
        scope        TYPE string,
        jti          TYPE string,
      END OF lty_access_token.

    DATA:
      lo_http_client  TYPE REF TO if_http_client,
      lv_utf8content  TYPE xstring,
      lv_string       TYPE string,
      lv_utf8length   TYPE i,
      lv_subrc        TYPE string,
      lv_code         TYPE i,
      lv_reason       TYPE string,
      ls_access_token TYPE lty_access_token.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url    = iv_url
      IMPORTING
        client = lo_http_client.

    lo_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

    CALL METHOD lo_http_client->request->set_method( method = 'POST' ).
    CALL METHOD lo_http_client->request->set_authorization(
        username  = iv_user
        password  = iv_password
        auth_type = 1 ).

    CALL METHOD lo_http_client->send
      EXPORTING
        timeout                    = 5000
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.
    IF sy-subrc <> 0.
      lv_subrc = sy-subrc.
*      gv_status = 'HTTP communication failure'.
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    CALL METHOD lo_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3.
    IF sy-subrc <> 0.
      lv_subrc = sy-subrc.
*      gv_status = 'HTTP communication failure'.
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    CALL METHOD lo_http_client->response->get_status
      IMPORTING
        code   = lv_code
        reason = lv_reason.

    lv_utf8content = lo_http_client->response->get_data( ).
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = lv_utf8content
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = lv_string.

    IF lv_code < 200 OR lv_code >= 300.
      lv_subrc = lv_code.
      gv_status = 'HTTP communication failure'.
      lv_utf8content = lo_http_client->response->get_data( ).
      lo_http_client->close( ).
      EXIT.
    ENDIF.

    lo_http_client->close( ).

    /ui2/cl_json=>deserialize(
      EXPORTING
      json = lv_string
      CHANGING
      data = ls_access_token
      ).
    CONCATENATE ls_access_token-token_type ls_access_token-access_token INTO rv_access_token SEPARATED BY space.
  ENDMETHOD.


  METHOD management_ems_api.

    FREE go_http_client.
* Instantiate HTTP Client using rfc destination name
    create_by_destination( iv_des_name = iv_destination ).

* convert abap to json
    DATA(lv_text) = me->convert_abap_to_json( is_log = is_log ).
* Set Authentication token (oAuth token ) to the connection
    set_oauth_token( iv_auth_profile = iv_auth_profile ).

* Setting up of Request Parameters to Remote call
    is_code = execute_ems_request( is_log  = lv_text
                                   iv_name = iv_topic_name ).
  ENDMETHOD.


  METHOD set_oauth_token.

    DATA: lo_oa2c_client TYPE REF TO if_oauth2_client,
          lv_error       TYPE string,
          lv_param_kind  TYPE string VALUE 'H'.
** Set token for authorization Oauth 2.0
    TRY .
        cl_oauth2_client=>create( EXPORTING i_profile        = CONV #( iv_auth_profile )
                                  RECEIVING ro_oauth2_client = lo_oa2c_client ).
      CATCH cx_oa2c INTO DATA(exc1).
        lv_error = 'error calling CREATE'.
    ENDTRY.

    TRY .
        IF lo_oa2c_client IS NOT INITIAL.
          lo_oa2c_client->set_token( EXPORTING io_http_client = go_http_client
                                                i_param_kind  = lv_param_kind   ).
        ENDIF.

      CATCH cx_oa2c INTO DATA(exc2).
        TRY .
            CALL METHOD lo_oa2c_client->execute_cc_flow.

          CATCH cx_oa2c INTO DATA(exc3).
            lv_error = 'error calling EXECUTE_CC_GLOW'.
        ENDTRY.
        TRY .
            lo_oa2c_client->set_token( EXPORTING io_http_client = go_http_client ).
          CATCH cx_oa2c INTO DATA(exc4).
            lv_error = 'error calling SET_TOKEN'.
        ENDTRY.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
