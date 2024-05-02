*&---------------------------------------------------------------------*
*& Include          /SIMPLE/CONFIG_EVENTMESH_CL
*&---------------------------------------------------------------------*
CLASS lcl_check_config_eventmesh DEFINITION.
  PUBLIC SECTION.

    DATA msg TYPE string.
ENDCLASS.

CLASS lcl_check_config_eventmesh IMPLEMENTATION.

ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA:
      check_destination   TYPE abap_bool,
      check_oauth_token   TYPE abap_bool,
      check_authorization TYPE abap_bool,
      send_message        TYPE abap_bool.
    CLASS-DATA:
      out        TYPE REF TO if_demo_output,
      gv_message TYPE string.
    CLASS-METHODS:
      get_input,
      write_log IMPORTING msg TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: lt_tcode             TYPE TABLE OF string WITH EMPTY KEY,
          lv_des               TYPE char100,
          lv_auth_profile      TYPE oa2c_profile,
          lv_name              TYPE sy-uname,
          lv_check_destination TYPE char1,
          lv_radom_string      TYPE string,
          ls_errorlog          TYPE /simple/errorlog.

    lv_des          = pa_des.
    lv_name         = pc_uname.
    lv_auth_profile = pa_auth.

    IF sy-batch = abap_true.

      SELECT SINGLE destination
        FROM /simple/tarsys
        WHERE activate = @abap_true
        INTO @lv_des.
      IF lv_des IS INITIAL.
        lv_des = 'ZSIMPLE_EVENT_MESH'.
      ENDIF.

      lv_check_destination = abap_true.
      PERFORM check_destination USING lv_des
                                      lv_check_destination .

      IF gv_error_text IS NOT INITIAL.
* alphabets random
        CALL FUNCTION 'GENERAL_GET_RANDOM_STRING'
          EXPORTING
            number_chars  = 15
          IMPORTING
            random_string = lv_radom_string.

        ls_errorlog = VALUE #( mdglogid   = lv_radom_string
                               changedat  = sy-datum
                               changetim  = sy-uzeit
                               log        = gv_error_text    ).
        MODIFY /simple/errorlog FROM ls_errorlog.
        EXIT.
      ENDIF.
    ENDIF.
    get_input( ).
    out = cl_demo_output=>new( ).

    out->next_section( 'Check config Event Mesh' ).

    CASE abap_true.

      WHEN check_destination.
        lv_check_destination = abap_true.
        PERFORM check_destination USING lv_des
                                        lv_check_destination .
        IF gv_error_text IS INITIAL.
          write_log( `Success` ).
        ELSE.
          write_log( gv_error_text ).
        ENDIF.


      WHEN check_oauth_token.
        lv_check_destination = abap_false.
        PERFORM check_destination USING lv_des
                                        lv_check_destination .
        PERFORM check_oauth_token USING lv_auth_profile.
        IF gv_oa2c IS INITIAL.
          write_log( `Success` ).
        ELSE.
          write_log( gv_oa2c ).
        ENDIF.

      WHEN check_authorization.

        PERFORM check_authorization USING lv_name.
        IF gv_message IS INITIAL.
          write_log( `Success` ).
        ELSE.
          write_log( gv_message ).
        ENDIF.

      WHEN send_message.

        PERFORM send_message.
        IF gv_error_text IS INITIAL.
          write_log( `Success` ).
        ELSE.
          write_log( gv_error_text ).
        ENDIF.
    ENDCASE.

    out->display( ).
  ENDMETHOD.

  METHOD get_input.
    cl_demo_input=>new(
     )->add_field( EXPORTING as_checkbox = abap_true
                   CHANGING  field = check_destination
     )->add_field( EXPORTING as_checkbox = abap_true
                   CHANGING  field = check_oauth_token
     )->add_field( EXPORTING as_checkbox = abap_true
                   CHANGING  field = check_authorization
     )->add_field( EXPORTING as_checkbox = abap_true
                   CHANGING  field = send_message
     )->request( ).

    IF check_destination       &&
       check_oauth_token       &&
       send_message            &&
       check_authorization     <> abap_true.
      cl_demo_output=>display( `Check exactly one box` ).
      LEAVE PROGRAM.
    ENDIF.
  ENDMETHOD.

  METHOD write_log.
    DATA ts TYPE timestampl.
    GET TIME STAMP FIELD ts.
    out->write( |{ ts TIMESTAMP = ISO }: { msg }| ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_mqtt_event_handler DEFINITION CREATE PUBLIC FINAL.

  PUBLIC SECTION.
    INTERFACES: if_mqtt_event_handler.

    TYPES: BEGIN OF ty_dy_message,
             dy_topic_name_message TYPE string,
             dy_qos_message        TYPE i,
             dy_reatin_message     TYPE c LENGTH 1,
             dy_received_message   TYPE string,
             dy_message_message_nr TYPE int8,
           END OF ty_dy_message,
           tt_dy_message TYPE STANDARD TABLE OF ty_dy_message WITH KEY dy_message_message_nr.

    CLASS-DATA:
      go_client            TYPE REF TO if_mqtt_client,
      go_message           TYPE REF TO if_mqtt_message,
      gt_dy_message        TYPE tt_dy_message,
      go_disconnect_reason TYPE string.

ENDCLASS.

CLASS lcl_mqtt_event_handler IMPLEMENTATION.


ENDCLASS.
