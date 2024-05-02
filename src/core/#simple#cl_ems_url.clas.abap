class /SIMPLE/CL_EMS_URL definition
  public
  final
  create public .

public section.

  methods EMS_CENTRAL_URL
    importing
      !IS_LOG type /SIMPLE/API_LOG optional
      !IV_STATUS type STRING optional
      !IV_NAME type STRING optional
      !IV_HOST type STRING optional
    returning
      value(IV_RESPONSE) type /SIMPLE/API_LOG .
  methods EMS_URL
    importing
      !IS_LOG type /SIMPLE/API_LOG optional
      !IV_STATUS type STRING optional
      !IV_NAME type STRING optional
      !IV_HOST type STRING optional
    returning
      value(IV_RESPONSE) type /SIMPLE/API_LOG .
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
  methods SEND_REQUEST
    importing
      !IV_URL type STRING
      !IV_TOKEN type STRING
      !IV_MESSAGE type STRING
    returning
      value(IS_RESPONSE) type /SIMPLE/API_LOG .
  PROTECTED SECTION.
private section.

  data GO_HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  data GO_AUTH_CLIENT type ref to IF_OAUTH2_CLIENT .
  data ACCESS_TOKEN type STRING .
  data GV_STATUS type STRING .
ENDCLASS.



CLASS /SIMPLE/CL_EMS_URL IMPLEMENTATION.


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


  METHOD ems_url.
    DATA: lv_token_endpoint   TYPE string,
          lv_client_id        TYPE string,
          lv_client_secret    TYPE string,
          lv_message_endpoint TYPE string,
          lv_queue            TYPE string.

    SELECT SINGLE * FROM /simple/mdg_oath INTO @DATA(ls_ems)
      WHERE activate = @abap_true
        AND name     = @iv_name
        and host     = @iv_host.

    lv_token_endpoint = ls_ems-token_endpoint.
    lv_client_id      = ls_ems-client_id.
    lv_client_secret  = ls_ems-client_pw.
    lv_queue          = ls_ems-name_space && '/' && iv_status.

    lv_queue = cl_http_utility=>if_http_utility~escape_url( lv_queue ).
** Set URL
    lv_message_endpoint = ls_ems-message_endpoint && '/messagingrest/v1/topics/' &&  lv_queue && '/messages'.
** Set Authentication token (oAuth token ) to the connection
    DATA(lo_access_token) = get_access_token(  iv_url      = lv_token_endpoint
                                               iv_user     = lv_client_id
                                               iv_password = lv_client_secret ).
* convert abap to json
    DATA(lv_text) = me->convert_abap_to_json( is_log = is_log   ).

** Setting up of Request Parameters to Remote call
    iv_response = me->send_request(  iv_url     = lv_message_endpoint
                                     iv_token   = lo_access_token
                                     iv_message = lv_text ).
*    ENDIF.
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
      lv_utf8content  TYPE xstring,
      lv_string       TYPE string,
      lv_utf8length   TYPE i,
      lv_subrc        TYPE sysubrc,
      lv_code         TYPE i,
      lv_reason       TYPE string,
      ls_access_token TYPE lty_access_token.


    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url    = iv_url
      IMPORTING
        client = go_http_client.

    CALL METHOD go_http_client->request->set_authorization(
        username  = iv_user
        password  = iv_password
        auth_type = 1 ).

    go_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

    CALL METHOD go_http_client->request->set_method( method = 'POST' ).

    CALL METHOD go_http_client->send
      EXPORTING
        timeout                    = 5000
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.
    IF sy-subrc <> 0.
      CALL METHOD go_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = lv_reason.
      go_http_client->close( ).
    ENDIF.

    CALL METHOD go_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3.
    IF sy-subrc <> 0.
      CALL METHOD go_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = lv_reason.
      go_http_client->close( ).
    ENDIF.

    CALL METHOD go_http_client->response->get_status
      IMPORTING
        code   = lv_code
        reason = lv_reason.


    lv_utf8content = go_http_client->response->get_data( ).
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = lv_utf8content
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = lv_string.

    IF lv_code < 200 OR lv_code >= 300.
      CALL METHOD go_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = lv_reason.
      go_http_client->close( ).
    ENDIF.

    IF go_http_client IS NOT INITIAL.
      go_http_client->close( ).
    ENDIF.


    /ui2/cl_json=>deserialize(
      EXPORTING
        json = lv_string
      CHANGING
        data = ls_access_token
    ).
    CONCATENATE ls_access_token-token_type ls_access_token-access_token INTO rv_access_token SEPARATED BY space.

  ENDMETHOD.


  METHOD send_request.

    DATA:
*      go_http_client TYPE REF TO if_http_client,
      lv_utf8content TYPE xstring,
      lv_utf8length  TYPE i,
      lv_subrc       TYPE string.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url    = iv_url
      IMPORTING
        client = go_http_client.
    go_http_client->refresh_cookie( ).
*    go_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

    CALL METHOD go_http_client->request->set_method( method = 'POST' ).
    CALL METHOD go_http_client->request->set_header_field(
        name  = 'x-qos'
        value = '1' ).

    CALL METHOD go_http_client->request->set_header_field(
        name  = 'Content-Type'
        value = 'application/json' ).

    CALL METHOD go_http_client->request->set_header_field(
        name  = 'authorization'
        value = iv_token ).

    CALL METHOD go_http_client->request->set_cdata( data = iv_message ).

    CALL METHOD go_http_client->send
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
      go_http_client->close( ).
      EXIT.
    ENDIF.

    CALL METHOD go_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3.
    IF sy-subrc <> 0.
      lv_subrc = sy-subrc.
*      gv_status = 'HTTP communication failure'.
*      go_http_client->close( ).
*      EXIT.
    ENDIF.

    CALL METHOD go_http_client->response->get_status
      IMPORTING
        code   = DATA(lv_code)
        reason = DATA(lv_reason).

    DATA(lv_payload) = go_http_client->response->get_cdata( ).

    is_response = VALUE #( status_code = lv_code
                            reson_log   = COND #( WHEN lv_payload IS NOT INITIAL THEN 'URL:' && lv_payload
                                              ELSE  'URL:' && lv_reason  ) ).

    go_http_client->close( ).

  ENDMETHOD.


  METHOD EMS_CENTRAL_URL.
    DATA: lv_token_endpoint   TYPE string,
          lv_client_id        TYPE string,
          lv_client_secret    TYPE string,
          lv_message_endpoint TYPE string,
          lv_queue            TYPE string.

    SELECT SINGLE * FROM /simple/mdg_oath INTO @DATA(ls_ems)
      WHERE activate = @abap_true
        AND name     = @iv_name
        and host     = @iv_host.

    check sy-subrc = 0.
    lv_token_endpoint = ls_ems-token_endpoint.
    lv_client_id      = ls_ems-client_id.
    lv_client_secret  = ls_ems-client_pw.
    lv_queue          = ls_ems-name_space && '/CPIACTIVATE'. "SIMON 16112023

    lv_queue = cl_http_utility=>if_http_utility~escape_url( lv_queue ).
** Set URL
    lv_message_endpoint = ls_ems-message_endpoint && '/messagingrest/v1/queues/' && lv_queue && '/messages'. "SIMON 16112023
** Set Authentication token (oAuth token ) to the connection
    DATA(lo_access_token) = get_access_token(  iv_url      = lv_token_endpoint
                                               iv_user     = lv_client_id
                                               iv_password = lv_client_secret ).
* convert abap to json
    DATA(lv_text) = me->convert_abap_to_json( is_log = is_log ).

** Setting up of Request Parameters to Remote call
    iv_response = me->send_request(  iv_url    = lv_message_endpoint
                                     iv_token   = lo_access_token
                                     iv_message = lv_text ).

  ENDMETHOD.
ENDCLASS.
