CLASS lhc_mdattachment DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE mdattachment.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE mdattachment.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE mdattachment.

    METHODS read FOR READ
      IMPORTING keys FOR READ mdattachment RESULT result.

ENDCLASS.

CLASS lhc_mdattachment IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.

    DATA:
      lc_class_name  TYPE string VALUE '/SIMPLE/DIR_ATTACHMENT_READ',
      lc_method_name TYPE string VALUE 'READ_ATTACH_MENT',
      lv_uuid        TYPE string,
      ls_result      LIKE LINE OF result,
      lv_output      TYPE string,
      lv_mine_type   TYPE string,
      lv_file_name   TYPE string.

    LOOP AT keys INTO DATA(ls_data_key).
      lv_uuid = ls_data_key-uuid.
    ENDLOOP.

    FIELD-SYMBOLS: <lv_output> TYPE any.

    IF keys IS NOT INITIAL.
      TRY.
          CALL METHOD (lc_class_name)=>(lc_method_name)
            EXPORTING
              iv_input    = lv_uuid
            IMPORTING
              ev_output   = lv_output
              ev_minetype = lv_mine_type
              ev_filename = lv_file_name.
        CATCH cx_root INTO DATA(lo_exception).
      ENDTRY.
    ENDIF.
    ls_result-uuid =  lv_uuid.
    ls_result-value = lv_output.
    ls_result-mimetype = lv_mine_type.
    ls_result-filename = lv_file_name.
    APPEND ls_result TO result.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_c_mdattachment DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_c_mdattachment IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
