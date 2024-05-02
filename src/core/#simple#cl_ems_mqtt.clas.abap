CLASS /simple/cl_ems_mqtt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*    DATA: mo_mqtt_client TYPE REF TO if_mqtt_client.
*    INTERFACES if_mqtt_event_handler .
*    INTERFACES if_oo_adt_classrun.
    INTERFACES if_mqtt_event_handler .

    CLASS-DATA mo_out TYPE REF TO if_oo_adt_classrun_out .
    CLASS-DATA go_mqtt_client TYPE REF TO if_mqtt_client .
    CLASS-DATA go_request TYPE REF TO if_apc_wsp_client_initial_req .

    METHODS constructor .
    METHODS send_request
      IMPORTING
        !is_log          TYPE /simple/api_log OPTIONAL
        !iv_topic_name   TYPE string OPTIONAL
        !iv_auth_profile TYPE oa2c_profile OPTIONAL
        !iv_destination  TYPE string OPTIONAL
      RETURNING
        VALUE(is_code)   TYPE /simple/api_log .
    METHODS publish
      IMPORTING
        VALUE(iv_qos)     TYPE c DEFAULT '1'
        VALUE(iv_message) TYPE string
        VALUE(iv_topic)   TYPE string .
    METHODS subscribe
      IMPORTING
        VALUE(iv_topic) TYPE string .
    METHODS terminate .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS convert_abap_to_json
      IMPORTING
        !is_log        TYPE /simple/api_log
      RETURNING
        VALUE(rv_text) TYPE string .
    METHODS set_oauth_token
      IMPORTING
        !iv_auth_profile TYPE oa2c_profile .
    METHODS create_by_destination
      IMPORTING
        !iv_des_name TYPE string .
    METHODS connect .
ENDCLASS.



CLASS /simple/cl_ems_mqtt IMPLEMENTATION.


  METHOD connect.

    IF go_mqtt_client IS NOT BOUND.
      DATA: ls_apc_connect_options TYPE apc_connect_options.
      " APC connect options
*      ls_apc_connect_options = VALUE #(
*            timeout                    = '1'
*            vscan_profile_incoming_msg = '/SAPC_RUNTIME/APC_WS_MESSAGE_GET'
*            vscan_profile_outgoing_msg = '/SAPC_RUNTIME/APC_WS_MESSAGE_SET' ).
      TRY.
          " establish the connection
          go_mqtt_client->connect(
            i_apc_options = ls_apc_connect_options ). " Structure APC connect options

        CATCH cx_apc_error INTO DATA(lx_apc_error).
          DATA(lv_error_text) = lx_apc_error->get_text( ).
          RETURN.
      ENDTRY.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.

  ENDMETHOD.


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
    DATA: lv_version       TYPE i VALUE 4,
          lv_event_handler TYPE REF TO /simple/cl_ems_mqtt.
    TRY.
** Create RFC connect
        cl_mqtt_client_manager=>create_by_destination(
          EXPORTING
            i_destination      = iv_des_name
            i_protocol_version = lv_version
            i_event_handler    = me
          RECEIVING
            r_client           = go_mqtt_client ). " MQTT Client ).

        go_request = go_mqtt_client->get_context( )->get_initial_request( ).
*        lo_request->set_path_and_query( i_relative_uri = pquery ).
      CATCH cx_apc_error INTO DATA(lx_apc_error).
        DATA(lv_error_text) = lx_apc_error->get_text( ).
        RETURN.
    ENDTRY.
  ENDMETHOD.


  METHOD if_mqtt_event_handler~on_connect ##NEEDED.
    "tbd
  ENDMETHOD.


  METHOD if_mqtt_event_handler~on_disconnect ##NEEDED.
    "tbd
  ENDMETHOD.


  METHOD if_mqtt_event_handler~on_message.
    TRY.
        " Concatenate strings to form message for console output
        DATA(lv_message) = 'Received message "' && i_message->get_text( ) && '" in topic "' && i_topic_name && '"'.
        " output message
        mo_out->write( lv_message ).
      CATCH cx_ac_message_type_pcp_error cx_mqtt_error.
        " to do: error handling, e.g. write error log!
    ENDTRY.
  ENDMETHOD.


  METHOD send_request.
* Instantiate HTTP Client using rfc destination name
    create_by_destination( iv_des_name = iv_destination ).

* convert abap to json
    DATA(lv_text) = me->convert_abap_to_json( is_log = is_log ).
* Set Authentication token (oAuth token ) to the connection
    set_oauth_token( iv_auth_profile = iv_auth_profile ).

    connect(  ).

    publish( iv_message = lv_text
             iv_topic   = iv_topic_name ).

  ENDMETHOD.


  METHOD publish.
    DATA: ly_qos        TYPE if_mqtt_types=>ty_mqtt_qos.

    CASE iv_qos.
      WHEN '1'.
        ly_qos = if_mqtt_types=>qos-at_least_once.
      WHEN '0'.
        ly_qos = if_mqtt_types=>qos-at_most_once.
    ENDCASE.
    TRY.
        IF go_mqtt_client IS INITIAL.
          MESSAGE 'MQTT connection is not etsablished !' TYPE 'E'  ##NO_TEXT.
        ELSE.
          " create message with specific quality of service (QoS)
          DATA(lo_mqtt_message) = cl_mqtt_message=>create( ).

*          go_texteditor4pubmsg->get_textstream( IMPORTING text = lv_publish_text ).

          lo_mqtt_message->set_qos( if_mqtt_types=>qos-at_least_once ).
          lo_mqtt_message->set_text( iv_message ).
          " publish message to topic
          go_mqtt_client->publish(
            EXPORTING
              i_topic_name = iv_topic
              i_message    = lo_mqtt_message
            IMPORTING
              e_envelope   = DATA(lo_envelope_publish) ).
        ENDIF.
      CATCH cx_mqtt_error INTO DATA(lx_mqtt_error).
        DATA(lv_error_text) = lx_mqtt_error->get_text( ).
        MESSAGE lv_error_text TYPE 'E'.

    ENDTRY.
  ENDMETHOD.


  METHOD set_oauth_token.

    DATA: lo_oa2c_client TYPE REF TO if_oauth2_client,
          lv_error       TYPE string.

** Set token for authorization Oauth 2.0
    TRY .
        cl_oauth2_client=>create( EXPORTING i_profile        = CONV #( iv_auth_profile )
*                                  i_configuration
                                  RECEIVING ro_oauth2_client = lo_oa2c_client ).
        CALL METHOD lo_oa2c_client->execute_cc_flow.
        go_request = go_mqtt_client->get_context( )->get_initial_request( ).
        go_request->set_oauth2_client_token( i_oauth2_client = lo_oa2c_client ).
      CATCH cx_oa2c INTO DATA(lx_oa2c).
    ENDTRY.

  ENDMETHOD.


  METHOD subscribe.
    TRY.
        " subscribe to topic filter with QoS
        DATA(lt_mqtt_topic_filter_qos) =
              VALUE if_mqtt_types=>tt_mqtt_topic_filter_qos(
                            ( topic_filter = iv_topic
                             qos          = if_mqtt_types=>qos-at_least_once ) ).

        go_mqtt_client->subscribe(
          EXPORTING
            i_topic_filter_qos = lt_mqtt_topic_filter_qos ).
      CATCH cx_mqtt_error.
        " to do: error handling, e.g. write error log!
    ENDTRY.
  ENDMETHOD.


  METHOD terminate.
    TRY.
        " unsubscribe from all topics using the wildcard '#'
        DATA(lt_mqtt_topic_filter) = VALUE if_mqtt_types=>tt_mqtt_topic_filter(
                                            ( topic_filter =  '#' ) ).

        go_mqtt_client->unsubscribe(
          EXPORTING
            i_topic_filter = lt_mqtt_topic_filter ).
        " disconnect from broker
        go_mqtt_client->disconnect( ).
      CATCH cx_mqtt_error.
        " to do: error handling, e.g. write error log!
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
