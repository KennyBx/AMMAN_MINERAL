CLASS /simple/cl_ems_daemon_core6 DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_daemon_ext_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_timer_handler .

    TYPES:
      BEGIN OF ty_client,
        daemon_name TYPE /simple/tarsys-daemon_name,
        topic_name  TYPE /simple/tarsys-topic,
        http_client TYPE REF TO if_http_client,
        request     TYPE REF TO if_apc_wsp_client_initial_req,
      END OF ty_client .

    CONSTANTS: cv_daemon_name TYPE abap_daemon_name VALUE 'mcore_6',
               cv_classname   TYPE abap_daemon_class_name VALUE '/SIMPLE/CL_EMS_DAEMON_CORE6',
               cv_core        TYPE string VALUE 'mcore_6'.

  class-data:
    gt_client TYPE TABLE OF  ty_client .
  data DAEMON_CONTEXT type ref to IF_ABAP_DAEMON_CONTEXT .
  data GV_MESSAGE type STRING .
  class-data GV_ERROR_TEXT type STRING .

  class-methods START
    importing
      !IV_DAEMON_NAME type STRING optional
      !IV_CONNECT type STRING optional
      !IV_HOST type STRING optional
    raising
      CX_ABAP_DAEMON_ERROR
      CX_AC_MESSAGE_TYPE_PCP_ERROR .
  class-methods SEND
    importing
      !IV_CONNECT_OPTION type STRING
      !IV_DAEMON_NAME type STRING default CV_CORE
      !IV_PUBLISH_TOPIC type STRING optional
      !IV_LOG type STRING optional
      !IV_STEP type STRING optional
      !IV_HOST type STRING optional
    raising
      CX_ABAP_DAEMON_ERROR
      CX_AC_MESSAGE_TYPE_PCP_ERROR .
  class-methods STOP
    importing
      !IV_DAEMON_NAME type STRING
    raising
      CX_ABAP_DAEMON_ERROR .
  class-methods CREATE_BY_DESTINATION_HTTP
    importing
      !IV_DES_NAME type CHAR100
    changing
      !IV_HTTP_CLIENT type ref to IF_HTTP_CLIENT optional .
  class-methods CREATE_BY_URL_HTTP
    importing
      !IV_URL type STRING
    changing
      !IV_HTTP_CLIENT type ref to IF_HTTP_CLIENT optional .
  class-methods CONVERT_ABAP_TO_JSON
    importing
      !IS_LOG type /SIMPLE/API_LOG
    returning
      value(RV_TEXT) type STRING .
  class-methods SET_OAUTH_TOKEN_HTTP_DES
    importing
      !IV_AUTH_PROFILE type OA2C_PROFILE
    changing
      !IV_HTTP_CLIENT type ref to IF_HTTP_CLIENT optional .
  class-methods SET_ACCESS_TOKEN_HTTP_URL
    importing
      !IV_URL type STRING optional
      !IV_USER type STRING optional
      !IV_PASSWORD type STRING optional
    changing
      !IV_HTTP_CLIENT type ref to IF_HTTP_CLIENT optional
      !CV_ACCESS_TOKEN type STRING optional .
  class-methods SET_HTTP_CLIENT_DES
    importing
      !IV_DAEMON_NAME type STRING
      !IV_HOST type STRING optional .
  class-methods SET_HTTP_CLIENT_URL
    importing
      !IV_DAEMON_NAME type STRING
      !IV_HOST type STRING optional .
  class-methods SEND_RETRY_HTTP
    importing
      !IV_DAEMON_NAME type STRING optional
      !IV_PUBLISH_TOPIC type STRING optional
      !IV_LOG type STRING optional
      !IV_CONNECT_OPTION type STRING
      !IV_HOST type STRING optional .
  class-methods SEND_REQUEST_HTTP
    importing
      !IS_LOG type STRING optional
      !IV_NAME type STRING optional
      !IV_CONNECT_OPTION type STRING optional
    changing
      !IV_HTTP_CLIENT type ref to IF_HTTP_CLIENT optional
    returning
      value(IS_CODE) type /SIMPLE/API_LOG .

  methods IF_ABAP_DAEMON_EXTENSION~ON_ACCEPT
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_BEFORE_RESTART_BY_SYSTEM
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_ERROR
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_MESSAGE
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_RESTART
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_SERVER_SHUTDOWN
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_START
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_STOP
    redefinition .
  methods IF_ABAP_DAEMON_EXTENSION~ON_SYSTEM_SHUTDOWN
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /SIMPLE/CL_EMS_DAEMON_CORE6 IMPLEMENTATION.


  METHOD stop.
    " retrieve the list of ABAP Daemon instances
    DATA(lt_ad_info) = cl_abap_daemon_client_manager=>get_daemon_info( i_class_name = cv_classname ).

    " for each running daemon instance of this class
    LOOP AT lt_ad_info ASSIGNING FIELD-SYMBOL(<ls_info>).
      " stop the daemon if the names match
      IF iv_daemon_name = <ls_info>-name.
        cl_abap_daemon_client_manager=>stop( i_instance_id = <ls_info>-instance_id ).
      ENDIF.

    ENDLOOP.
  ENDMETHOD.


  METHOD start.

    DATA: lv_daemon_name  TYPE string.
*    " set ABAP Daemon start parameters
    DATA(lo_pcp) = cl_ac_message_type_pcp=>create( ).

    lv_daemon_name  = COND #( WHEN iv_daemon_name IS INITIAL THEN cv_core
                                  ELSE iv_daemon_name ).
    DATA(lv_connect)     = iv_connect.
    DATA(lv_host)        = iv_host.

    lo_pcp->set_field( i_name = 'daemon_name' i_value = lv_daemon_name ).
    lo_pcp->set_field( i_name = 'connect'     i_value = lv_connect     ).
    lo_pcp->set_field( i_name = 'host'        i_value = lv_host        ).
    " start the daemon application using the ABAP Daemon Manager
    cl_abap_daemon_client_manager=>start(
        i_class_name = cv_classname
        i_name       = CONV #( lv_daemon_name )
        i_priority   = cl_abap_daemon_client_manager=>co_session_priority_low
        i_parameter  = lo_pcp ).

  ENDMETHOD.


  METHOD set_oauth_token_http_des.

    DATA: lo_oa2c_client TYPE REF TO if_oauth2_client,
          lv_param_kind  TYPE string VALUE 'H'.
** Set token for authorization Oauth 2.0
    TRY .
        cl_oauth2_client=>create( EXPORTING i_profile        = CONV #( iv_auth_profile )
                                  RECEIVING ro_oauth2_client = lo_oa2c_client ).
      CATCH cx_oa2c INTO DATA(exc1).
        gv_error_text = exc1->get_text( ).
    ENDTRY.

    TRY .
        IF lo_oa2c_client IS NOT INITIAL.
          lo_oa2c_client->set_token( EXPORTING io_http_client = iv_http_client
                                                i_param_kind  = lv_param_kind   ).
        ENDIF.

      CATCH cx_oa2c INTO DATA(exc2).
        TRY .
            CALL METHOD lo_oa2c_client->execute_cc_flow.

          CATCH cx_oa2c INTO DATA(exc3).
            gv_error_text = exc2->get_text( ).
        ENDTRY.
        TRY .
            lo_oa2c_client->set_token( EXPORTING io_http_client = iv_http_client ).
          CATCH cx_oa2c INTO DATA(exc4).
            gv_error_text = exc3->get_text( ).
        ENDTRY.
    ENDTRY.

  ENDMETHOD.


  METHOD set_http_client_url .

    DATA: ls_client           TYPE ty_client,
          lv_url              TYPE string,
          lv_token_endpoint   TYPE string,
          lv_client_id        TYPE string,
          lv_client_secret    TYPE string,
          lv_message_endpoint TYPE string,
          lv_queue            TYPE string,
          lv_access_token     TYPE string.
    TRY.

        IF iv_daemon_name IS INITIAL.
* Get config table
          SELECT * FROM /simple/tarsys
           WHERE activate = @abap_true
             AND connect_option LIKE 'DHU'
             AND host = @iv_host
            INTO TABLE @DATA(lt_tarsys).
        ELSE.
          SELECT * FROM /simple/tarsys
           WHERE activate    = @abap_true
             AND daemon_name = @iv_daemon_name
             AND connect_option LIKE 'DHU'
             AND host = @iv_host
            INTO TABLE @lt_tarsys.
        ENDIF.
* Get config url table
        SELECT SINGLE * FROM /simple/mdg_oath INTO @DATA(ls_ems)
          WHERE activate = @abap_true
            AND host     = @iv_host
            AND name     = @iv_daemon_name.

        lv_token_endpoint = ls_ems-token_endpoint.
        lv_client_id      = ls_ems-client_id.
        lv_client_secret  = ls_ems-client_pw.

        LOOP AT  lt_tarsys INTO DATA(ls_tarsys).
          ls_client-daemon_name  = ls_tarsys-daemon_name.
          lv_url = ls_ems-message_endpoint.
* Set Authentication token to the connection
          set_access_token_http_url( EXPORTING iv_password     = lv_client_secret
                                               iv_url          = lv_token_endpoint
                                               iv_user         = lv_client_id
                                     CHANGING  cv_access_token = lv_access_token ).

          create_by_url_http( EXPORTING iv_url         = lv_url
                              CHANGING  iv_http_client = ls_client-http_client ).

          CALL METHOD ls_client-http_client->request->set_header_field(
              name  = 'authorization'
              value = lv_access_token ).

          CALL METHOD ls_client-http_client->request->set_header_field(
              name  = 'x-qos'
              value = '1' ).

          CALL METHOD ls_client-http_client->request->set_header_field(
              name  = 'Content-Type'
              value = 'application/json' ).

          ls_client-http_client->request->set_method( method = 'POST' ).

          APPEND ls_client TO gt_client.

        ENDLOOP.
      CATCH cx_http_csp_api INTO DATA(lx_mqtt_error).
        gv_error_text = lx_mqtt_error->get_text( ).
        MESSAGE gv_error_text TYPE 'E'.
    ENDTRY.
  ENDMETHOD.


  METHOD set_http_client_des .

    DATA: lv_destination  TYPE char100,
          lv_auth_profile TYPE oa2c_profile,
          ls_client       TYPE ty_client.
    TRY.

        IF iv_daemon_name IS INITIAL.
* Get config table
          SELECT * FROM /simple/tarsys
           WHERE activate = @abap_true
             AND connect_option LIKE 'DHD'
             AND host = @iv_host
            INTO TABLE @DATA(lt_tarsys).
        ELSE.
          SELECT * FROM /simple/tarsys
           WHERE activate    = @abap_true
             AND daemon_name = @iv_daemon_name
             AND connect_option LIKE 'DHD'
             AND host = @iv_host
            INTO TABLE @lt_tarsys.
        ENDIF.

        DATA(lt_request_headers) = VALUE tihttpnvp( ( name  = 'x-qos'
                                                      value = '1' )
                                                     ( name = 'Content-Type'
                                                      value = 'application/json' ) ).
        LOOP AT  lt_tarsys INTO DATA(ls_tarsys).
          ls_client-daemon_name  = ls_tarsys-daemon_name.
          lv_destination = ls_tarsys-destination.
          create_by_destination_http( EXPORTING iv_des_name    = lv_destination
                                      CHANGING  iv_http_client = ls_client-http_client ).

* Set Authentication token (oAuth token ) to the connection
          lv_auth_profile = ls_tarsys-auth_profile.
          set_oauth_token_http_des( EXPORTING iv_auth_profile = lv_auth_profile
                                    CHANGING  iv_http_client  = ls_client-http_client ).

          LOOP AT lt_request_headers ASSIGNING FIELD-SYMBOL(<ls_headers>).
            ls_client-http_client->request->set_header_field( EXPORTING name  = <ls_headers>-name
                                                                        value = <ls_headers>-value ).
          ENDLOOP .

          ls_client-http_client->request->set_method( method = 'POST' ).

          APPEND ls_client TO gt_client.

          CLEAR: lv_destination,
                 lv_auth_profile,
                 ls_client.
        ENDLOOP.
      CATCH cx_http_csp_api INTO DATA(lx_mqtt_error).
        gv_error_text = lx_mqtt_error->get_text( ).
        MESSAGE gv_error_text TYPE 'E'.
    ENDTRY.
  ENDMETHOD.


  METHOD set_access_token_http_url .

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
        client = iv_http_client.

    iv_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

    CALL METHOD iv_http_client->request->set_method( method = 'POST' ).
    CALL METHOD iv_http_client->request->set_authorization(
        username  = iv_user
        password  = iv_password
        auth_type = 1 ).

    CALL METHOD iv_http_client->send
      EXPORTING
        timeout                    = 5000
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5.
    IF sy-subrc <> 0.
      CALL METHOD iv_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = gv_error_text.
      iv_http_client->close( ).
    ENDIF.

    CALL METHOD iv_http_client->receive
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3.
    IF sy-subrc <> 0.
      CALL METHOD iv_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = gv_error_text.
      iv_http_client->close( ).
    ENDIF.

    CALL METHOD iv_http_client->response->get_status
      IMPORTING
        code   = lv_code
        reason = lv_reason.


    lv_utf8content = iv_http_client->response->get_data( ).
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = lv_utf8content
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = lv_string.

    IF iv_http_client IS NOT INITIAL.
      iv_http_client->close( ).
    ENDIF.

    /ui2/cl_json=>deserialize(
      EXPORTING
      json = lv_string
      CHANGING
      data = ls_access_token
      ).
    CONCATENATE ls_access_token-token_type ls_access_token-access_token INTO cv_access_token SEPARATED BY space.

  ENDMETHOD.


  METHOD send_retry_http.

    DATA:ls_code TYPE /simple/api_log,
         ls_log  TYPE /simple/api_log,
         lv_i    TYPE i.

    /ui2/cl_json=>deserialize(     " Deserialize the JSON object
      EXPORTING
        json        = iv_log       " The JSON object to deserialize
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      CHANGING
        data        = ls_log
    ).

    SELECT * FROM /simple/api_log
       WHERE mdglogid  = @ls_log-mdglogid
         AND ( status_log <> 'S' )
        INTO TABLE @DATA(lt_api_log).

    IF lt_api_log IS NOT INITIAL.

      TRY.
          DO.
            READ TABLE gt_client INTO DATA(ls_client) INDEX 1.
* Setting up of Request Parameters to Remote call
            ls_code = send_request_http( EXPORTING is_log         = iv_log
                                                   iv_name        = iv_publish_topic
                                         CHANGING  iv_http_client = ls_client-http_client ).
            lv_i = lv_i + 1.
            IF    ls_code-status_code = 200
               OR ls_code-status_code = 201
               OR ls_code-status_code = 204
               OR lv_i = 5.              EXIT.

              CLEAR: lv_i.
            ELSE.
              ls_client-http_client->close(    " Close the HTTP client
                EXCEPTIONS
                  http_invalid_state = 1
                  OTHERS             = 2 ).
              stop( iv_daemon_name = iv_daemon_name ).
              start( iv_connect     = iv_connect_option
                     iv_host        = iv_host
                     iv_daemon_name = iv_daemon_name ).
              REFRESH : gt_client.
              CLEAR: ls_client.
              CASE iv_connect_option.
                WHEN 'DHD' .
                  set_http_client_des( iv_daemon_name = iv_daemon_name iv_host = iv_host ). "http destination client Connect
                WHEN 'DHU' .
                  set_http_client_url( iv_daemon_name = iv_daemon_name iv_host = iv_host ). "http URL client Connect
              ENDCASE.
            ENDIF.
          ENDDO.

          ls_log = VALUE #(    BASE ls_log
            status_log   = COND #( WHEN ls_code-status_code = 204
                                     OR ls_code-status_code = 201
                                     OR ls_code-status_code = 200  THEN 'S' ELSE 'F' )
            status_code  = ls_code-status_code
            reson_log    = COND #( WHEN ls_code-reson_log IS NOT INITIAL THEN 'D:' && ls_code-reson_log  ELSE 'D:' && gv_error_text ) ) .

          /simple/cl_mdg_gw_core_dpc_ext=>update_log_table( is_log = ls_log ).

        CATCH cx_ac_message_type_pcp_error INTO DATA(lx_pcp_error).
          " to do: error handling, e.g. write error log!
          gv_error_text = lx_pcp_error->get_text( ).
        CATCH cx_abap_daemon_error INTO DATA(lx_daemon_error).
          " to do: error handling, e.g. write error log!
          gv_error_text = lx_daemon_error->get_text( ).
      ENDTRY.

    ENDIF.
  ENDMETHOD.


  METHOD send_request_http.
    DATA: lv_url          TYPE string,
          lt_headers      TYPE tihttpnvp,
          lv_subrc        TYPE sysubrc,
          lv_access_token TYPE string.

* Setting up of Request Parameters to Remote call
** Set URL
    lv_url = '/messagingrest/v1/topics/' && iv_name && '/messages'.
    cl_http_utility=>set_request_uri( EXPORTING request = iv_http_client->request
                                                uri     = lv_url ).

    CALL METHOD iv_http_client->request->set_cdata( data = is_log ).
    CLEAR: lv_url.

    " Send
    iv_http_client->send(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5
    ).
    IF sy-subrc <> 0.
      CALL METHOD iv_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = gv_error_text.
      iv_http_client->close( ).
    ENDIF.

    iv_http_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4
    ).
    IF sy-subrc <> 0.
      CALL METHOD iv_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = gv_error_text.
      iv_http_client->close( ).
    ENDIF.

    CALL METHOD iv_http_client->response->get_header_fields( CHANGING fields = lt_headers ).

    iv_http_client->response->get_status( IMPORTING code   = DATA(lv_code)
                                                    reason = gv_error_text ).

    DATA(lv_payload) = iv_http_client->response->get_cdata(  ).

    IF sy-subrc <> 0.
      CALL METHOD iv_http_client->get_last_error
        IMPORTING
          code    = lv_subrc
          message = gv_error_text.
      iv_http_client->close( ).
    ENDIF.

    is_code = VALUE #( status_code = lv_code
                       reson_log   = COND #( WHEN lv_payload IS NOT INITIAL THEN lv_payload
                                              ELSE  gv_error_text ) ).
    CLEAR: lv_code.

  ENDMETHOD.


  METHOD send.
    DATA:ls_log         TYPE /simple/api_log,
         lv_daemon_name TYPE string,
         ls_code        TYPE /simple/api_log,
         lv_i           TYPE i.
    " retrieve the list of ABAP Daemon instances
    DATA(lt_ad_info) = cl_abap_daemon_client_manager=>get_daemon_info( i_class_name = cv_classname ).

    " create PCP message with text
    DATA(lo_pcp) = cl_ac_message_type_pcp=>create( ).

    lo_pcp->set_text( iv_log ).
    lo_pcp->set_field( i_name = 'pub_topic' i_value = iv_publish_topic ).
    lo_pcp->set_field( i_name = 'connect' i_value = iv_connect_option ).
    lo_pcp->set_field( i_name = 'daemon_name' i_value = iv_daemon_name ).
    lo_pcp->set_field( i_name = 'host' i_value = iv_host ).

    IF lt_ad_info IS NOT INITIAL.
      " for each running daemon instance of this class
      LOOP AT lt_ad_info ASSIGNING FIELD-SYMBOL(<ls_info>).
        " send a message if the names match
        IF iv_daemon_name = <ls_info>-name.
          cl_abap_daemon_client_manager=>attach( <ls_info>-instance_id )->send( lo_pcp ).
        ENDIF.

      ENDLOOP.
    ELSE.

      CASE iv_connect_option.
        WHEN 'DHD' .
          set_http_client_des( iv_daemon_name = iv_daemon_name iv_host = iv_host ). "http destination client Connect
        WHEN 'DHU' .
          set_http_client_url( iv_daemon_name = iv_daemon_name iv_host = iv_host ). "http URL client Connect
      ENDCASE.

      send_retry_http( iv_daemon_name    = lv_daemon_name
                       iv_log            = iv_log
                       iv_host           = iv_host
                       iv_publish_topic  = iv_publish_topic
                       iv_connect_option = iv_connect_option ).

      start( iv_connect     = iv_connect_option
             iv_host        = iv_host
             iv_daemon_name = iv_daemon_name ).
    ENDIF.
  ENDMETHOD.


  METHOD if_abap_timer_handler~on_timeout.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_system_shutdown.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_stop.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_start.

    DATA: lv_daemon  TYPE string,
          lv_connect TYPE string,
          lv_host    TYPE string.

    TRY.
        " retrieve PCP parameters from start parameters
        DATA(i_message)       = i_context->get_start_parameter( ).
        lv_daemon       = i_message->get_field( 'daemon_name' ).
        lv_connect      = i_message->get_field( 'connect' ).
        lv_host         = i_message->get_field( 'host' ).
        CASE lv_connect.
          WHEN 'DHD' .
            set_http_client_des( iv_daemon_name = lv_daemon iv_host = lv_host ). "http destination client Connect
          WHEN 'DHU' .
            set_http_client_url( iv_daemon_name = lv_daemon iv_host = lv_host ). "http URL client Connect
        ENDCASE.
      CATCH cx_abap_daemon_error INTO DATA(lx_ad_error).
        " todo: error handling , e.g. write error log !
        gv_error_text = lx_ad_error->get_text( ).
      CATCH cx_abap_timer_error INTO DATA(lx_timer_error).
        " todo: error handling , e.g. write error log !
        gv_error_text = lx_timer_error->get_text( ).

      CATCH cx_ac_message_type_pcp_error INTO DATA(lx_pcp_error).
        " todo: error handling , e.g. write error log !
        gv_error_text = lx_pcp_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_server_shutdown.
    TRY.
        " ON_SERVER_SHUTDOWN possible option:
        " relocate ABAP Daemon instace to another active server
        " remove ABAP Daemon context information saved in share area, e.g. database, shared objects or …
        " ...

      CATCH cx_abap_daemon_error INTO DATA(lx_ad_error).
        "todo: error handling , e.g. write error log !
        gv_error_text = lx_ad_error->get_text( ).

      CATCH cx_abap_timer_error INTO DATA(lx_timer_error).
        " todo: error handling , e.g. write error log !
        gv_error_text = lx_timer_error->get_text( ).

      CATCH cx_ac_message_type_pcp_error INTO DATA(lx_pcp_error).
        " todo: error handling , e.g. write error log !
        gv_error_text = lx_pcp_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_restart.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_message.

    DATA: lv_name         TYPE string,
          gv_error_text   TYPE string,
          is_code         TYPE /simple/api_log,
          ls_log          TYPE /simple/api_log,
          lv_daemon_name  TYPE string,
          lv_host         TYPE string,
          lv_CONNECT      TYPE string,
          lv_destination  TYPE char100,
          lv_auth_profile TYPE oa2c_profile,
          lv_topic_name   TYPE string,
          lv_i            TYPE i.
    TRY.
        " get text from PCP message
        DATA(lv_log) = i_message->get_text( ).
        lv_name           = i_message->get_field( i_name = 'pub_topic' ).
        lv_daemon_name    = i_message->get_field( i_name = 'daemon_name'  ).
        lv_connect        = i_message->get_field( i_name = 'connect'  ).
        lv_host           = i_message->get_field( i_name = 'host'  ).
        IF gt_client IS INITIAL.
          stop( iv_daemon_name  = lv_daemon_name ).
         start(  iv_connect     = lv_connect
                 iv_host        = lv_host
                 iv_daemon_name = lv_daemon_name ).
          CASE lv_CONNECT.
            WHEN 'DHD'.
              set_http_client_des( iv_daemon_name = lv_daemon_name iv_host = lv_host ).
            WHEN 'DHU'.
              set_http_client_URL( iv_daemon_name = lv_daemon_name iv_host = lv_host ).
          ENDCASE.
        ENDIF.

        send_retry_http( iv_daemon_name    = lv_daemon_name
                         iv_log            = lv_log
                         iv_publish_topic  = lv_name
                         iv_connect_option = lv_connect  ).

      CATCH cx_ac_message_type_pcp_error INTO DATA(lx_pcp_error).
        " to do: error handling, e.g. write error log!
        gv_error_text = lx_pcp_error->get_text( ).
      CATCH cx_abap_daemon_error INTO DATA(lx_daemon_error).
        " to do: error handling, e.g. write error log!
        gv_error_text = lx_daemon_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_error.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_before_restart_by_system.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_accept.
    TRY.
        DATA lv_program_name TYPE program.
        lv_program_name = cl_oo_classname_service=>get_classpool_name( cv_classname ).

        IF i_context_base->get_start_caller_info( )-program = lv_program_name.
          e_setup_mode = co_setup_mode-accept.
        ELSE.
          e_setup_mode = co_setup_mode-reject.
        ENDIF.
      CATCH cx_abap_daemon_error.
        " to do: error handling, e.g. write error log!
        e_setup_mode = co_setup_mode-reject.
    ENDTRY.
  ENDMETHOD.


  METHOD create_by_url_http.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url                        = iv_url
      IMPORTING
        client                     = iv_http_client
      EXCEPTIONS
        argument_not_found         = 1
        plugin_not_active          = 2
        internal_error             = 3
        pse_not_found              = 4
        pse_not_distrib            = 5
        pse_errors                 = 6.

  ENDMETHOD.


  METHOD create_by_destination_http.

    cl_http_client=>create_by_destination(
                                EXPORTING  destination = iv_des_name
                                IMPORTING  client                   = iv_http_client
                                EXCEPTIONS argument_not_found       = 1
                                           destination_not_found    = 2
                                           destination_no_authority = 3
                                           plugin_not_active        = 4
                                           internal_error           = 5
                                           OTHERS                   = 6 ).
    iv_http_client->propertytype_logon_popup = if_http_client=>co_disabled.

  ENDMETHOD.


  METHOD convert_abap_to_json.

    TRY.
        /simple/cl_json_utility=>convert_stuct_to_json(
        EXPORTING
          im_s_data = is_log
          im_v_case = /simple/cl_json_utility=>co_ftype_lowercase
        RECEIVING
          rt_v_json = rv_text ).

      CATCH /simple/cx_json_conversion_err.    " Error during JSON Conversion
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
