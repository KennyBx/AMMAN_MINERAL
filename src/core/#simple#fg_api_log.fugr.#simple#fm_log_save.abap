FUNCTION /simple/fm_log_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_LOG) TYPE  /SIMPLE/API_LOG
*"     VALUE(IV_LOG_HANDLE) TYPE  BALLOGHNDL OPTIONAL
*"  EXPORTING
*"     VALUE(ES_LOG) TYPE  /SIMPLE/API_LOG
*"----------------------------------------------------------------------
* BLE Start Add event mesh 11212022
  DATA: lo_ems          TYPE REF TO /simple/cl_ems_provider,
        lo_ems_url      TYPE REF TO /simple/cl_ems_url,
        lv_topic_name   TYPE string,
        lv_auth_profile TYPE oa2c_profile,
        lv_destination  TYPE char100,
*        lv_topic_url    TYPE string,
        lv_status       TYPE string,
        lv_mes          TYPE abap_bool VALUE abap_false,
        ls_code         TYPE /simple/api_log,
        lv_daemon       TYPE string,
        lv_connect      TYPE string,
        lv_host         TYPE string,
        lo_class        TYPE seoclsname,
        lv_i            TYPE i.

* BLE Start Add event mesh 04172023
  GET RUN TIME FIELD /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop.

*Get option connect
  lv_status = COND #(  WHEN ( is_log-step = 'S' )                       AND is_log-status = 'F' THEN  'SAPActivateFailed'
                       WHEN ( is_log-step = 'V' OR is_log-step = 'BV' ) AND is_log-status = 'S' THEN  'SAPTestRunPassed'
                       WHEN ( is_log-step = 'V' OR is_log-step = 'BV' ) AND is_log-status = 'F' THEN  'SAPTestRunFailed'
                       WHEN ( is_log-step = 'B' OR is_log-step = 'A'  ) AND is_log-status = 'F' THEN  'SAPActivateFailed'
                       WHEN ( is_log-step = 'B' OR is_log-step = 'A'  ) AND is_log-status = 'S' THEN  'SAPActivated') .

  is_log = VALUE #( BASE is_log changedat      = sy-datum
                                changetim      = sy-uzeit
                                time_run       = /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop / 1000000  ) .
  es_log = is_log.
  /simple/cl_mdg_gw_core_dpc_ext=>update_log_table( is_log = es_log ).
  COMMIT WORK AND WAIT.

  TRY.
      DATA(lv_message) = /simple/cl_json_utility=>convert_stuct_to_json(
        im_s_data = is_log
        im_v_case = /simple/cl_json_utility=>co_ftype_lowercase ).
    CATCH /simple/cx_json_conversion_err.    " Error during JSON Conversion
  ENDTRY.

* Get config table
* SPHAM Start Add Central Logic 16112023
  SELECT SINGLE * FROM /simple/mdg_host
  WHERE activate  = @abap_true
    AND uname = @sy-uname
  INTO @DATA(ls_central_host).
  IF sy-subrc <> 0.
    SELECT SINGLE /simple/mdg_host~* FROM /simple/mdg_conf LEFT JOIN /simple/mdg_host ON /simple/mdg_conf~fieldname = 'UNAME' AND /simple/mdg_host~uname = /simple/mdg_conf~fieldvalue
    WHERE /simple/mdg_host~activate  = @abap_true
    INTO @ls_central_host.
  ENDIF.


  DATA(lv_central_flag) = COND #( WHEN ls_central_host-host_type = /simple/cl_mdg_gw_core_dpc_ext=>gc_multiple_host_type THEN abap_true ELSE abap_false ).

  SELECT *  FROM /simple/tarsys
   WHERE activate = @abap_true
     AND host = @ls_central_host-host
    INTO TABLE @DATA(lt_connect).
* SPHAM End Add Central Logic 16112023

  IF lv_status IS NOT INITIAL AND ( is_log-cr_number IS NOT INITIAL OR is_log-mdglogid  IS NOT INITIAL ).

*    lv_daemon = COND #(   WHEN is_log-messaging_core = 'messaging_core_2' THEN 'mcore_2'
*                          WHEN is_log-messaging_core = 'messaging_core_3' THEN 'mcore_3'
*                          WHEN is_log-messaging_core = 'messaging_core_4' THEN 'mcore_4'
*                          WHEN is_log-messaging_core = 'messaging_core_5' THEN 'mcore_5'
*                          WHEN is_log-messaging_core = 'messaging_core_6' THEN 'mcore_6'
*                          ELSE 'mcore_1'  ).
    lv_daemon = VALUE #( lt_connect[ text = is_log-messaging_core ]-daemon_name OPTIONAL ).
    LOOP AT lt_connect INTO DATA(ls_connect).

      IF is_log-messaging_core IS INITIAL.
        is_log-messaging_core = ls_connect-text.
        lv_daemon = VALUE #( lt_connect[ text = is_log-messaging_core ]-daemon_name OPTIONAL ).
      ELSEIF ls_connect-daemon_name <> lv_daemon.
        CONTINUE.
      ENDIF.
      lv_auth_profile = ls_connect-auth_profile.
      lv_destination  = ls_connect-destination.
      lv_connect      = ls_connect-connect_option.
      lv_host         = ls_connect-host.

      lv_topic_name   = COND #( WHEN lv_central_flag IS NOT INITIAL THEN cl_http_utility=>if_http_utility~escape_url( |{ ls_connect-topic }/CPIACTIVATE| )
                                WHEN lv_connect CS 'MQTT' THEN |{ ls_connect-topic }/{ lv_status }|
                                ELSE cl_http_utility=>if_http_utility~escape_url( |{ ls_connect-topic }/{ lv_status }| )  ).

      IF ls_connect-connect_option = 'DHD' OR ls_connect-connect_option = 'DHU'.

        lo_class = COND #(  WHEN is_log-messaging_core = 'messaging_core_2' THEN '/SIMPLE/CL_EMS_DAEMON_CORE2'
                            WHEN is_log-messaging_core = 'messaging_core_3' THEN '/SIMPLE/CL_EMS_DAEMON_CORE3'
                            WHEN is_log-messaging_core = 'messaging_core_4' THEN '/SIMPLE/CL_EMS_DAEMON_CORE4'
                            WHEN is_log-messaging_core = 'messaging_core_5' THEN '/SIMPLE/CL_EMS_DAEMON_CORE5'
                            WHEN is_log-messaging_core = 'messaging_core_6' THEN '/SIMPLE/CL_EMS_DAEMON_CORE6'
                            ELSE '/SIMPLE/CL_EMS_DAEMON_CORE1' ).
        TRY.
            CALL METHOD (lo_class)=>send
              EXPORTING
                iv_log            = lv_message
                iv_connect_option = lv_connect
                iv_daemon_name    = lv_daemon
                iv_host           = lv_host
                iv_publish_topic  = lv_topic_name.
            WAIT UP TO 2 SECONDS.
          CATCH cx_abap_daemon_error.
          CATCH cx_ac_message_type_pcp_error.
        ENDTRY.

      ENDIF.


      CREATE OBJECT lo_ems.
      CREATE OBJECT lo_ems_url.
      DO 5 TIMES.
* Retry send message
        lv_i = lv_i + 1.
        SELECT * FROM /simple/api_log
           WHERE mdglogid  = @is_log-mdglogid
             AND ( status_log <> 'S' )
            INTO TABLE @DATA(lt_api_log).

        IF lt_api_log IS NOT INITIAL.
* BLE Start Add event mesh 11212022
          IF ls_connect-connect_option  CS 'HD'. "OR lt_api_log IS NOT INITIAL.
            IF lv_central_flag IS NOT INITIAL.
              lv_topic_name   = COND #( WHEN lv_central_flag IS NOT INITIAL THEN cl_http_utility=>if_http_utility~escape_url( |{ ls_connect-topic }/CPIACTIVATE| )
                                        WHEN lv_connect CS 'MQTT' THEN |{ ls_connect-topic }/{ lv_status }|
                                        ELSE cl_http_utility=>if_http_utility~escape_url( |{ ls_connect-topic }/CPIACTIVATE| )  ).
            ENDIF.
            ls_code = lo_ems->management_ems_api( is_log          = is_log
                                                  iv_topic_name   = lv_topic_name
                                                  iv_auth_profile = lv_auth_profile
                                                  iv_destination  = lv_destination
                                                  ).

          ELSEIF ls_connect-connect_option  CS 'HU'." AND lt_api_log IS NOT INITIAL.
            IF lv_central_flag IS INITIAL.
              ls_code = lo_ems_url->ems_url( is_log    = is_log
                                             iv_name   = lv_daemon
                                             iv_host   = lv_host
                                             iv_status = lv_status
                                             ).
            ELSE.
* Trigger event to Central Hub - MultipleERPs
              ls_code = lo_ems_url->ems_central_url( is_log    = is_log
                                                     iv_name   = lv_daemon
                                                     iv_status = lv_status
                                                     iv_host   = lv_host ).
            ENDIF.
          ENDIF.
* BLE End Add event mesh 11212022

* Update table Log
          es_log = VALUE #( BASE es_log status_log   = COND #( WHEN ls_code-status_code = 204
                                        OR ls_code-status_code = 200
                                        OR ls_code-status_code = 201 THEN 'S' ELSE 'F' )
                                                status_code  = ls_code-status_code
                                                reson_log    = ls_code-reson_log  ) .
          /simple/cl_mdg_gw_core_dpc_ext=>update_log_table( is_log = es_log ).
          COMMIT WORK AND WAIT.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.

    ENDLOOP.
  ENDIF.

* Trigger event using AMQP - Websocket - SPHAM - 19/12/2023
  CALL METHOD /simple/bp_c_event_mesh=>_send_event EXPORTING is_log = es_log iv_status = lv_status.
* Trigger event using AMQP - Websocket - SPHAM - 19/12/2023

ENDFUNCTION.
