*&---------------------------------------------------------------------*
*& Report /SIMPLE/DAEMON_START
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /simple/daemon_start.

TABLES sscrfields.

DATA: ls_tarsys      TYPE /simple/tarsys,
      lt_tarsys      TYPE STANDARD TABLE OF /simple/tarsys,
      lv_daemon_name TYPE string,
      lo_class       TYPE seoclsname.

SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN FUNCTION KEY 2.
SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-010.
*PARAMETERS: p_daemon TYPE string LOWER CASE DEFAULT 'simplemdg_daemon' .
  SELECTION-SCREEN SKIP 1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN PUSHBUTTON 15(32) but2 USER-COMMAND stop.
    SELECTION-SCREEN COMMENT 55(60) g_text.
  SELECTION-SCREEN END OF LINE.
*SELECTION-SCREEN PUSHBUTTON 29(12) but3 USER-COMMAND send.

SELECTION-SCREEN END OF BLOCK b1.
*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.
*  but1 = 'Start Daemon'.
  but2 = 'Click for fun!'.


AT SELECTION-SCREEN OUTPUT.
  sscrfields-functxt_01 = 'Start Daemon'.
  sscrfields-functxt_02 = 'Stop Daemon'.



AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC01'.
      SELECT * FROM /simple/tarsys
         WHERE activate = @abap_true
         INTO TABLE @lt_tarsys .

      LOOP AT lt_tarsys INTO ls_tarsys.
        lv_daemon_name = ls_tarsys-daemon_name.
        lo_class = COND #( WHEN ls_tarsys-daemon_name CS '_1' THEN '/SIMPLE/CL_EMS_DAEMON_CORE1'
                           WHEN ls_tarsys-daemon_name CS '_2' THEN '/SIMPLE/CL_EMS_DAEMON_CORE2'
                           WHEN ls_tarsys-daemon_name CS '_3' THEN '/SIMPLE/CL_EMS_DAEMON_CORE3'
                           WHEN ls_tarsys-daemon_name CS '_4' THEN '/SIMPLE/CL_EMS_DAEMON_CORE4'
                           WHEN ls_tarsys-daemon_name CS '_5' THEN '/SIMPLE/CL_EMS_DAEMON_CORE5'
                           WHEN ls_tarsys-daemon_name CS '_6' THEN '/SIMPLE/CL_EMS_DAEMON_CORE6' ).
        TRY.
            CALL METHOD (lo_class)=>start
              EXPORTING
                iv_daemon_name = lv_daemon_name.
          CATCH cx_abap_daemon_error.
          CATCH cx_ac_message_type_pcp_error.

        ENDTRY.
      ENDLOOP.
    WHEN 'FC02'.
      SELECT * FROM /simple/tarsys
         WHERE activate = @abap_true
         INTO TABLE @lt_tarsys .

      LOOP AT lt_tarsys INTO ls_tarsys.
        lv_daemon_name = ls_tarsys-daemon_name.
        lo_class = COND #( WHEN ls_tarsys-daemon_name CS '_1' THEN '/SIMPLE/CL_EMS_DAEMON_CORE1'
                           WHEN ls_tarsys-daemon_name CS '_2' THEN '/SIMPLE/CL_EMS_DAEMON_CORE2'
                           WHEN ls_tarsys-daemon_name CS '_3' THEN '/SIMPLE/CL_EMS_DAEMON_CORE3'
                           WHEN ls_tarsys-daemon_name CS '_4' THEN '/SIMPLE/CL_EMS_DAEMON_CORE4'
                           WHEN ls_tarsys-daemon_name CS '_5' THEN '/SIMPLE/CL_EMS_DAEMON_CORE5'
                           WHEN ls_tarsys-daemon_name CS '_6' THEN '/SIMPLE/CL_EMS_DAEMON_CORE6' ).
        TRY.
            CALL METHOD (lo_class)=>stop
              EXPORTING
                iv_daemon_name = lv_daemon_name.
          CATCH cx_abap_daemon_error.
          CATCH cx_ac_message_type_pcp_error.

        ENDTRY.
      ENDLOOP.
    WHEN 'STOP'.
      g_text = 'Martin Here :)'.
  ENDCASE.

START-OF-SELECTION.

*  SELECT * FROM /simple/tarsys
*     WHERE activate = @abap_true
*     INTO TABLE @DATA(lt_tarsys) .
*
*  DATA: lv_daemon_name TYPE string,
*        lo_class       TYPE seoclsname.
*
*  LOOP AT lt_tarsys INTO DATA(ls_tarsys).
*    lv_daemon_name = ls_tarsys-daemon_name.
*    lo_class = COND #( WHEN ls_tarsys-daemon_name = 'mcore_1' THEN '/SIMPLE/CL_EMS_DAEMON_CORE1'
*                       WHEN ls_tarsys-daemon_name = 'mcore_2' THEN '/SIMPLE/CL_EMS_DAEMON_CORE2'
*                       WHEN ls_tarsys-daemon_name = 'mcore_3' THEN '/SIMPLE/CL_EMS_DAEMON_CORE3'
*                       WHEN ls_tarsys-daemon_name = 'mcore_4' THEN '/SIMPLE/CL_EMS_DAEMON_CORE4'
*                       WHEN ls_tarsys-daemon_name = 'mcore_5' THEN '/SIMPLE/CL_EMS_DAEMON_CORE5'
*                       WHEN ls_tarsys-daemon_name = 'mcore_6' THEN '/SIMPLE/CL_EMS_DAEMON_CORE6' ).
*    TRY.
*        IF sscrfields = 'START' OR sscrfields IS INITIAL.
*          CALL METHOD (lo_class)=>start
*            EXPORTING
*              iv_daemon_name = lv_daemon_name.
*        ELSEIF sscrfields = 'STOP'.
*          CALL METHOD (lo_class)=>stop
*            EXPORTING
*              iv_daemon_name = lv_daemon_name.
*        ENDIF.
*
*      CATCH cx_abap_daemon_error.
*      CATCH cx_ac_message_type_pcp_error.
*
*    ENDTRY.
*  ENDLOOP.
