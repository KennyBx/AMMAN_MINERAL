*&---------------------------------------------------------------------*
*& Report /SIMPLE/RETRY_MESSAGE_FAIL_URL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /SIMPLE/RETRY_MESSAGE_FAIL_URL.

TYPES:
  BEGIN OF gty_api_log.
    INCLUDE TYPE /simple/api_log.
TYPES:
    status_call TYPE string,
  END OF gty_api_log .

DATA: gt_api_log      TYPE TABLE OF gty_api_log,
      lo_ems          TYPE REF TO /simple/cl_ems_provider,
      lo_ems_url      TYPE REF TO /simple/cl_ems_url,
      lv_topic_name   TYPE string,
      lv_auth_profile TYPE oa2c_profile,
      lv_destination  TYPE char100,
*        lv_topic_url    TYPE string,
      lv_status       TYPE string,
      lv_mes          TYPE abap_bool VALUE abap_false,
      ls_code         TYPE /simple/api_log,
      ls_log          TYPE /simple/api_log,
      lv_daemon       TYPE string,
      lv_connect      TYPE string,
      lo_class        TYPE seoclsname,
      lv_i            TYPE i.

* Get config table
SELECT * FROM /simple/tarsys
 WHERE activate  = @abap_true
  INTO TABLE @DATA(lt_connect).

SELECT * FROM /simple/api_log
  WHERE status_log <> 'S'
*   and CR_NUMBER = 'CR0000005547'
   INTO CORRESPONDING FIELDS OF TABLE @gt_api_log
   UP TO 5 ROWS.

      CREATE OBJECT lo_ems_url.
IF gt_api_log IS NOT INITIAL.

  LOOP AT gt_api_log ASSIGNING FIELD-SYMBOL(<fs_api_log>).
    LOOP AT lt_connect INTO DATA(ls_connect).

      IF <fs_api_log>-messaging_core IS INITIAL.
        <fs_api_log>-messaging_core = ls_connect-text.
      ENDIF.
      IF ls_connect-text  <> <fs_api_log>-messaging_core.
        CONTINUE.
      ENDIF.

      lv_auth_profile = ls_connect-auth_profile.
      lv_destination  = ls_connect-destination.
      lv_daemon       = ls_connect-daemon_name.
      lv_connect      = ls_connect-connect_option.
    ENDLOOP.

    lv_status = COND #(  WHEN ( <fs_api_log>-step = 'S' )                       AND <fs_api_log>-status = 'F' THEN  'SAPActivateFailed'
                         WHEN ( <fs_api_log>-step = 'V' OR <fs_api_log>-step = 'BV' ) AND <fs_api_log>-status = 'S' THEN  'SAPTestRunPassed'
                         WHEN ( <fs_api_log>-step = 'V' OR <fs_api_log>-step = 'BV' ) AND <fs_api_log>-status = 'F' THEN  'SAPTestRunFailed'
                         WHEN ( <fs_api_log>-step = 'B' OR <fs_api_log>-step = 'A'  ) AND <fs_api_log>-status = 'F' THEN  'SAPActivateFailed'
                         WHEN ( <fs_api_log>-step = 'B' OR <fs_api_log>-step = 'A'  ) AND <fs_api_log>-status = 'S' THEN  'SAPActivated') .

    lo_class = COND #(  WHEN <fs_api_log>-messaging_core = 'messaging_core_2' THEN '/SIMPLE/CL_EMS_DAEMON_CORE2'
                        WHEN <fs_api_log>-messaging_core = 'messaging_core_3' THEN '/SIMPLE/CL_EMS_DAEMON_CORE3'
                        WHEN <fs_api_log>-messaging_core = 'messaging_core_4' THEN '/SIMPLE/CL_EMS_DAEMON_CORE4'
                        WHEN <fs_api_log>-messaging_core = 'messaging_core_5' THEN '/SIMPLE/CL_EMS_DAEMON_CORE5'
                        WHEN <fs_api_log>-messaging_core = 'messaging_core_6' THEN '/SIMPLE/CL_EMS_DAEMON_CORE6'
                        ELSE '/SIMPLE/CL_EMS_DAEMON_CORE1' ).

    lv_topic_name   = COND #( WHEN lv_connect CS 'MQTT' THEN |{ ls_connect-topic }/{ lv_status }|
                                ELSE cl_http_utility=>if_http_utility~escape_url( |{ ls_connect-topic }/{ lv_status }| )  ).

    TRY.
        DATA(lv_message) = /simple/cl_json_utility=>convert_stuct_to_json(
          im_s_data = <fs_api_log>
          im_v_case = /simple/cl_json_utility=>co_ftype_lowercase ).
      CATCH /simple/cx_json_conversion_err.    " Error during JSON Conversion
    ENDTRY.

*    TRY.
*        CALL METHOD (lo_class)=>send
*          EXPORTING
*            iv_log            = lv_message
*            iv_connect_option = lv_connect
*            iv_daemon_name    = lv_daemon
*            iv_publish_topic  = lv_topic_name.
*      CATCH cx_abap_daemon_error.
*      CATCH cx_ac_message_type_pcp_error.
*    ENDTRY.
    MOVE-CORRESPONDING <fs_api_log> TO ls_log.

            ls_code = lo_ems_url->ems_url( is_log          = ls_log
                                           iv_name         = ls_log-messaging_core
                                           iv_status       = lv_status ).

    ls_log = VALUE #( BASE ls_log status_log   = COND #( WHEN ls_code-status_code = 204
                                  OR ls_code-status_code = 200
                                  OR ls_code-status_code = 201 THEN 'S' ELSE 'F' )
                                          status_code  = ls_code-status_code
                                          reson_log    = 'P:' && ls_code-reson_log   ) .
    /simple/cl_mdg_gw_core_dpc_ext=>update_log_table( is_log = ls_log ).
    COMMIT WORK AND WAIT.

  ENDLOOP.
ENDIF.
