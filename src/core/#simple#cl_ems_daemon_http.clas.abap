CLASS /simple/cl_ems_daemon_http DEFINITION
  PUBLIC
  INHERITING FROM cl_abap_daemon_ext_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_client,
             daemon_name TYPE /simple/tarsys-daemon_name,
*             userconnect TYPE  /simple/tarsys-userconnect,
             topic_name  TYPE /simple/tarsys-topic,
*             mqtt_client  TYPE REF TO if_mqtt_client,
             http_client TYPE REF TO if_http_client,
             request     TYPE REF TO if_apc_wsp_client_initial_req,
           END OF ty_client.

    CONSTANTS daemon_log TYPE abap_daemon_name VALUE 'DaemonLog' ##NO_TEXT.

    INTERFACES if_abap_timer_handler.


    METHODS: if_abap_daemon_extension~on_error REDEFINITION,
      if_abap_daemon_extension~on_message REDEFINITION,
      if_abap_daemon_extension~on_restart REDEFINITION,
      if_abap_daemon_extension~on_server_shutdown REDEFINITION,
      if_abap_daemon_extension~on_accept REDEFINITION,
      if_abap_daemon_extension~on_start REDEFINITION,
      if_abap_daemon_extension~on_stop REDEFINITION,
      if_abap_daemon_extension~on_system_shutdown REDEFINITION,
      if_abap_daemon_extension~on_before_restart_by_system REDEFINITION.

    CLASS-METHODS start
      IMPORTING
        iv_daemon_name TYPE string OPTIONAL
        iv_connect     TYPE string DEFAULT 'HTTP'
      RAISING
        cx_abap_daemon_error
        cx_ac_message_type_pcp_error.

    CLASS-METHODS send
      IMPORTING
        iv_connect_option TYPE string OPTIONAL
        iv_daemon_name    TYPE string DEFAULT 'simplemdg_daemon'
        iv_userconnect    TYPE string OPTIONAL
        iv_publish_topic  TYPE string OPTIONAL
        iv_log            TYPE string OPTIONAL
        iv_step           TYPE string OPTIONAL
      RAISING
        cx_abap_daemon_error
        cx_ac_message_type_pcp_error.

    CLASS-METHODS stop
      IMPORTING
        iv_daemon_name TYPE string
      RAISING
        cx_abap_daemon_error.


    CLASS-METHODS create_by_destination
      IMPORTING
        !iv_des_name   TYPE char100
      CHANGING
        iv_http_client TYPE REF TO if_http_client OPTIONAL  .


    CLASS-METHODS convert_abap_to_json
      IMPORTING
        !is_log        TYPE /simple/api_log
      RETURNING
        VALUE(rv_text) TYPE string .

    CLASS-METHODS set_oauth_token
      IMPORTING
        !iv_auth_profile TYPE oa2c_profile
      CHANGING
        iv_http_client   TYPE REF TO if_http_client OPTIONAL .

    CLASS-METHODS set_http_client
      IMPORTING
        iv_daemon_name TYPE string .

    CLASS-METHODS send_request
      IMPORTING
        !is_log        TYPE string
        !iv_name       TYPE string
      CHANGING
        iv_http_client TYPE REF TO if_http_client OPTIONAL
      RETURNING
        VALUE(is_code) TYPE /simple/api_log .

    CLASS-DATA gt_client TYPE TABLE OF  ty_client.

    DATA daemon_context TYPE REF TO if_abap_daemon_context .
    DATA gv_message TYPE string.
    CLASS-DATA gv_error_text TYPE string.
  PROTECTED SECTION.


  PRIVATE SECTION.

ENDCLASS.



CLASS /SIMPLE/CL_EMS_DAEMON_HTTP IMPLEMENTATION.


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
*    TRY.

** Create RFC connect
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

*      CATCH /simple/cx_http_dest_provider INTO DATA(lx_error).
*    ENDTRY.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_accept.
    TRY.
        DATA lv_program_name TYPE program.
        lv_program_name = cl_oo_classname_service=>get_classpool_name( '/SIMPLE/CL_EMS_DAEMON_HTTP' ).

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


  METHOD if_abap_daemon_extension~on_before_restart_by_system.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_error.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_message.

    DATA: lv_name         TYPE string,
          gv_error_text   TYPE string,
          is_code         TYPE /simple/api_log,
          ls_log          TYPE /simple/api_log,
          lv_userconnect  TYPE string,
          lv_daemon_name  TYPE string,
          lv_destination  TYPE char100,
          lv_auth_profile TYPE oa2c_profile,
          lv_topic_name   TYPE string,
          lv_http_header  TYPE string.

    TRY.
        lv_userconnect    = i_message->get_field( EXPORTING i_name = 'userconnect'  ).
        lv_daemon_name    = i_message->get_field( i_name = 'daemon_name'   ).
        lv_http_header    = i_message->get_field( i_name = 'http_header'  ).

        IF gt_client IS INITIAL.
          /simple/cl_ems_daemon_http=>stop( iv_daemon_name  = lv_daemon_name ).

          /simple/cl_ems_daemon_http=>start( iv_daemon_name = lv_daemon_name ).

          set_http_client( iv_daemon_name = lv_daemon_name ).
        ENDIF.

        LOOP AT gt_client INTO DATA(ls_client). "userconnect = lv_userconnect.

          lv_daemon_name = ls_client-daemon_name.
          " get text from PCP message
          DATA(lv_log) = i_message->get_text( ).
          lv_name = i_message->get_field( i_name = 'pub_topic' ).
* Setting up of Request Parameters to Remote call
          is_code = send_request( EXPORTING is_log  = lv_log
                                            iv_name = lv_name
                                  CHANGING iv_http_client = ls_client-http_client ).

          IF is_code-status_code  <> 200
          AND is_code-status_code <> 201
          AND is_code-status_code <> 204.

            ls_client-http_client->close(    " Close the HTTP client
              EXCEPTIONS
                http_invalid_state = 1
                OTHERS             = 2
            ).
            FREE gt_client.
            /simple/cl_ems_daemon_http=>stop( iv_daemon_name  = lv_daemon_name ).

            /simple/cl_ems_daemon_http=>start( iv_daemon_name = lv_daemon_name ).

            set_http_client(  iv_daemon_name = lv_daemon_name ).
* Setting up of Request Parameters to Remote call
            is_code = send_request( EXPORTING is_log  = lv_log
                                              iv_name = lv_name
                                    CHANGING iv_http_client = ls_client-http_client ).
          ENDIF.

          IF sy-subrc IS INITIAL.
            /ui2/cl_json=>deserialize(     " Deserialize the JSON object
              EXPORTING
                json        = lv_log       " The JSON object to deserialize
                pretty_name = /ui2/cl_json=>pretty_mode-camel_case
              CHANGING
                data = ls_log
            ).

            ls_log = VALUE #(              " Populate the fields of the ls_log structure
              BASE ls_log
              status_log   = COND #( WHEN is_code-status_code = 204 OR is_code-status_code = 200 THEN 'S' ELSE 'F' )
              status_code  = is_code-status_code
              reson_log    = COND #( WHEN is_code-reson_log IS NOT INITIAL THEN is_code-reson_log
                                                                     ELSE gv_error_text )
              changedat    = sy-datum
              changetim    = sy-uzeit
              time_run     = /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop / 1000000  ) .

            /simple/cl_mdg_gw_core_dpc_ext=>update_log_table(  is_log = ls_log   ).
          ENDIF.
        ENDLOOP.
      CATCH cx_ac_message_type_pcp_error INTO DATA(lx_pcp_error).
        " to do: error handling, e.g. write error log!
        gv_error_text = lx_pcp_error->get_text( ).
      CATCH cx_abap_daemon_error INTO DATA(lx_daemon_error).
        " to do: error handling, e.g. write error log!
        gv_error_text = lx_daemon_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_restart.

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


  METHOD if_abap_daemon_extension~on_start.

    DATA: lv_daemon  TYPE string,
          lv_connect TYPE string.

    TRY.
        " retrieve PCP parameters from start parameters
        DATA(i_message)       = i_context->get_start_parameter( ).
        lv_daemon       = i_message->get_field( 'daemon_name' ).
        lv_connect      = i_message->get_field( 'connect' ).

*-----------------------------------------------------------------------*
* http client Connect
*-----------------------------------------------------------------------*
        set_http_client( iv_daemon_name = lv_daemon ).

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


  METHOD if_abap_daemon_extension~on_stop.

  ENDMETHOD.


  METHOD if_abap_daemon_extension~on_system_shutdown.

  ENDMETHOD.


  METHOD if_abap_timer_handler~on_timeout.

  ENDMETHOD.


  METHOD send.
    DATA:ls_log         TYPE /simple/api_log,
         lv_daemon_name TYPE string,
         ls_code        TYPE /simple/api_log.
    " retrieve the list of ABAP Daemon instances
    DATA(lt_ad_info) = cl_abap_daemon_client_manager=>get_daemon_info( i_class_name = '/SIMPLE/CL_EMS_DAEMON_HTTP').

    " create PCP message with text
    DATA(lo_pcp) = cl_ac_message_type_pcp=>create( ).

    lo_pcp->set_text( iv_log ).
    lo_pcp->set_field( i_name = 'pub_topic'        i_value  = iv_publish_topic   ).
    lo_pcp->set_field( i_name = 'userconnect'      i_value  = iv_userconnect     ).
    lo_pcp->set_field( i_name = 'connect_option'   i_value  = iv_connect_option  ).
    lo_pcp->set_field( i_name = 'daemon_name'      i_value  = iv_daemon_name     ).
*    lo_pcp->set_field( i_name = 'http_header'      i_value  = iv_http_header     ).

    IF lt_ad_info IS NOT INITIAL.
      " for each running daemon instance of this class
      LOOP AT lt_ad_info ASSIGNING FIELD-SYMBOL(<ls_info>).
        " send a message if the names match
        IF iv_daemon_name = <ls_info>-name.
          cl_abap_daemon_client_manager=>attach( <ls_info>-instance_id )->send( lo_pcp ).
        ENDIF.

      ENDLOOP.
    ELSE.


      set_http_client( iv_daemon_name = iv_daemon_name ).

      LOOP AT gt_client INTO DATA(ls_client)." WHERE userconnect = iv_userconnect.

        lv_daemon_name = ls_client-daemon_name.
* Setting up of Request Parameters to Remote call
        ls_code = send_request( EXPORTING is_log  = iv_log
                                          iv_name = iv_publish_topic
                                CHANGING  iv_http_client = ls_client-http_client ).

        IF sy-subrc IS INITIAL.
          /ui2/cl_json=>deserialize(     " Deserialize the JSON object
            EXPORTING
              json        = iv_log       " The JSON object to deserialize
              pretty_name = /ui2/cl_json=>pretty_mode-camel_case
            CHANGING
              data = ls_log
          ).

          ls_log = VALUE #(              " Populate the fields of the ls_log structure
            BASE ls_log
            status_log   = COND #( WHEN ls_code-status_code = 204 OR ls_code-status_code = 200 THEN 'S' ELSE 'F' )
            status_code  = ls_code-status_code
            reson_log    = COND #( WHEN ls_code-reson_log IS NOT INITIAL THEN ls_code-reson_log
                                                                   ELSE gv_error_text )
            changedat    = sy-datum
            changetim    = sy-uzeit
            time_run     = /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop / 1000000  ) .

          /simple/cl_mdg_gw_core_dpc_ext=>update_log_table(  is_log = ls_log   ).
        ENDIF.
      ENDLOOP.


      start( iv_daemon_name = iv_daemon_name  ).
    ENDIF.
  ENDMETHOD.


  METHOD send_request.
    DATA: lv_url     TYPE string,
          lv_reason  TYPE string,
          lt_headers TYPE tihttpnvp.

* Setting up of Request Parameters to Remote call

** Set URL
    lv_url = '/messagingrest/v1/topics/' && iv_name && '/messages'.
    cl_http_utility=>set_request_uri( EXPORTING request = iv_http_client->request
                                                uri     = lv_url ).
    iv_http_client->refresh_cookie( ).

    CALL METHOD iv_http_client->request->set_cdata( data = is_log ).
    CLEAR: lv_url.

    " Send
    iv_http_client->send(
*      EXPORTING
*        timeout                    = 9999
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
               INTO lv_reason.
    ENDIF.

    iv_http_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
               INTO lv_reason.
    ENDIF.

    CALL METHOD iv_http_client->response->get_header_fields( CHANGING fields = lt_headers ).

    iv_http_client->response->get_status( IMPORTING code   = DATA(lv_code)
                                                    reason = lv_reason ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
               INTO lv_reason.
    ENDIF.

    is_code = VALUE #( status_code = lv_code
                       reson_log   = lv_reason   ).

    CLEAR: lv_code, lv_reason.

*    gs_client-http_client->close(    " Close the HTTP client
*      EXCEPTIONS
*        http_invalid_state = 1
*        OTHERS             = 2
*    ).

  ENDMETHOD.


  METHOD set_http_client .

    DATA: lv_destination  TYPE char100,
          lv_auth_profile TYPE oa2c_profile,
          lv_client       TYPE ty_client.
    TRY.

        IF iv_daemon_name IS INITIAL.
* Get config table
          SELECT * FROM /simple/tarsys
           WHERE activate = @abap_true
             AND connect_option LIKE '%HTTP%'
             AND text IS INITIAL
            INTO TABLE @DATA(lt_tarsys).
        ELSE.
          SELECT * FROM /simple/tarsys
           WHERE activate    = @abap_true
             AND daemon_name = @iv_daemon_name
             AND connect_option LIKE '%HTTP%'
             AND text IS INITIAL
            INTO TABLE @lt_tarsys.
        ENDIF.

        DATA(lt_request_headers) = VALUE tihttpnvp( ( name  = 'x-qos'
                                                      value = '1' )
                                                     ( name = 'Content-Type'
                                                      value = 'application/json' ) ).
        LOOP AT  lt_tarsys INTO DATA(ls_tarsys).
          lv_client-daemon_name  = ls_tarsys-daemon_name.
*          lv_client-userconnect  = ls_tarsys-userconnect.
          lv_destination = ls_tarsys-destination.
          create_by_destination( EXPORTING  iv_des_name    = lv_destination
                                  CHANGING  iv_http_client = lv_client-http_client ).

* Set Authentication token (oAuth token ) to the connection
          lv_auth_profile = ls_tarsys-auth_profile.
          set_oauth_token( EXPORTING iv_auth_profile  = lv_auth_profile
                           CHANGING  iv_http_client   = lv_client-http_client ).

          LOOP AT lt_request_headers ASSIGNING FIELD-SYMBOL(<ls_headers>).
            lv_client-http_client->request->set_header_field( EXPORTING name  = <ls_headers>-name
                                                                        value = <ls_headers>-value ).
          ENDLOOP.

          lv_client-http_client->request->set_method( method = 'POST' ).

          APPEND lv_client TO gt_client.

          CLEAR: lv_destination,
                 lv_auth_profile,
                 lv_client.
        ENDLOOP.
      CATCH cx_http_csp_api INTO DATA(lx_mqtt_error).
        gv_error_text = lx_mqtt_error->get_text( ).
        MESSAGE gv_error_text TYPE 'E'.
    ENDTRY.
  ENDMETHOD.


  METHOD set_oauth_token.


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


  METHOD start.

    DATA: lv_daemon_name  TYPE string.
*    " set ABAP Daemon start parameters
    DATA(lo_pcp) = cl_ac_message_type_pcp=>create( ).

    lv_daemon_name  = COND #( WHEN iv_daemon_name IS INITIAL THEN 'simplemdg_daemon'
                             ELSE iv_daemon_name ).
    DATA(lv_connect)     = iv_connect.

    lo_pcp->set_field( i_name = 'daemon_name' i_value = lv_daemon_name ).
    lo_pcp->set_field( i_name = 'connect'     i_value = lv_connect     ).
    " start the daemon application using the ABAP Daemon Manager
    cl_abap_daemon_client_manager=>start(
        i_class_name = '/SIMPLE/CL_EMS_DAEMON_HTTP'
        i_name       = CONV #( lv_daemon_name )
        i_priority   = cl_abap_daemon_client_manager=>co_session_priority_low
        i_parameter  = lo_pcp ).

  ENDMETHOD.


  METHOD stop.
    " retrieve the list of ABAP Daemon instances
    DATA(lt_ad_info) = cl_abap_daemon_client_manager=>get_daemon_info( i_class_name = '/SIMPLE/CL_EMS_DAEMON_HTTP').

    " for each running daemon instance of this class
    LOOP AT lt_ad_info ASSIGNING FIELD-SYMBOL(<ls_info>).
      " stop the daemon if the names match
      IF iv_daemon_name = <ls_info>-name.
        cl_abap_daemon_client_manager=>stop( i_instance_id = <ls_info>-instance_id ).
      ENDIF.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
