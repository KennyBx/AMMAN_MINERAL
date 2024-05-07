FUNCTION /simple/fm_product_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_MAT) TYPE  CMD_BS_MAT_S_MAT_DATA
*"     VALUE(IV_MRP_OPERATION) TYPE  CHAR1
*"     VALUE(IV_MDGLOGID) TYPE  CHAR36
*"     VALUE(IV_ACTIVATEID) TYPE  CHAR20 OPTIONAL
*"     VALUE(IV_ACTIVATEITEMID) TYPE  CHAR20 OPTIONAL
*"     VALUE(IV_CRNUMBER) TYPE  CHAR100 OPTIONAL
*"     VALUE(IV_CRITEM) TYPE  CHAR100 OPTIONAL
*"     VALUE(IV_BACKGROUND) TYPE  CHAR1
*"     VALUE(IV_TEST_MODE) TYPE  XFELD OPTIONAL
*"     VALUE(IT_QMAT_INS) TYPE  CMD_BS_MAT_T_QMAT OPTIONAL
*"     VALUE(IT_QMAT_UPD) TYPE  CMD_BS_MAT_T_QMAT OPTIONAL
*"     VALUE(IT_QMAT_DEL) TYPE  CMD_BS_MAT_T_QMAT OPTIONAL
*"     VALUE(IT_QMAT_X) TYPE  CMD_BS_MAT_T_QMAT_X OPTIONAL
*"     VALUE(IT_VALUATION) TYPE  /SIMPLE/PRD_VAL_T OPTIONAL
*"     VALUE(IT_CLASSIFICATION) TYPE  /SIMPLE/CLFN_T OPTIONAL
*"  EXPORTING
*"     VALUE(EV_PRODUCT) TYPE  MATNR
*"     VALUE(EV_STATUS) TYPE  /SIMPLE/API_LOG-STATUS
*"     VALUE(EV_STEP) TYPE  /SIMPLE/API_LOG-STEP
*"  TABLES
*"      ET_MESSAGE STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
  DATA:
    ls_headdata    TYPE bapimathead,
    ls_clientdata  TYPE bapi_mara,
    ls_clientdatax TYPE bapi_marax,
    ls_return      TYPE bapiret2,
    lt_ret         TYPE TABLE OF bapi_matreturn2,

    lt_valuation   TYPE /simple/prd_service_provider=>gty_deep_data-to_valuation.
  DATA lv_msgerr TYPE char255.
  DATA lv_product TYPE matnr.

  DATA:
    lv_log        TYPE /simple/api_log,
    lv_log_handle TYPE balloghndl.

  IF iv_background = 'X'.
    /simple/prd_service_provider=>gv_mdg = 'X'.
  ENDIF.
  DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).
  IF iv_mrp_operation <> 'D'.
    lt_valuation = CORRESPONDING #( DEEP it_valuation ).

    lo_object->execute_api_rfc(
    EXPORTING
      is_mat           = is_mat
      iv_mrp_operation = iv_mrp_operation
      iv_test_mode     = iv_test_mode
      it_qmat_ins      = it_qmat_ins
      it_qmat_upd      = it_qmat_upd
      it_qmat_del      = it_qmat_del
      it_qmat_x        = it_qmat_x
      it_valuation     = lt_valuation
    IMPORTING
      ev_product       = ev_product
      et_message       = et_message[] ).

    LOOP AT et_message TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
      DATA(lv_error) = abap_true.
      EXIT.
    ENDLOOP.
    IF ev_product IS INITIAL.
      ev_product = is_mat-mara_tab[ 1 ]-matnr.
    ENDIF.



    IF iv_test_mode IS INITIAL. "Activate
      IF iv_background IS INITIAL. "Foreground mode
        CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
          EXPORTING
            input  = ev_product
          IMPORTING
            output = lv_product.
        IF sy-subrc <> 0.
        ENDIF.
        "Check activate success or fail.
        IF lv_error = abap_true. "Failed - Foreground
          ROLLBACK WORK.
          IF line_exists( et_message[ type = 'E' ] )
          OR line_exists( et_message[ type = 'A' ] )
          OR line_exists( et_message[ type = 'X' ] ).
            lv_log-step             = 'A'.
          ENDIF.

        ELSE. "Success - Foreground
          lv_log-step             = 'A'.
          IF iv_mrp_operation = 'I'.
            COMMIT WORK.
          ELSE.
            "check classification
            "not commit work
          ENDIF.

*          "Update log - commit work material number and log api
*          CALL FUNCTION '/SIMPLE/FM_LOG_SAVE' " DESTINATION 'NONE'
*            EXPORTING
*              is_log        = lv_log
*              iv_log_handle = lv_log_handle.

          " Classification
          /simple/cl_classification=>save(
            EXPORTING
              iv_object         = ev_product
              iv_operation      = iv_mrp_operation
              it_classification = it_classification
            IMPORTING
              et_message        = et_message[] ).

          LOOP AT et_message TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
            lv_error = abap_true.
            EXIT.
          ENDLOOP.

          IF lv_error <> abap_true. "Modify class - success
            COMMIT WORK AND WAIT.
            "Update log - commit work material number and log api
            IF iv_mrp_operation = 'U'.
            ENDIF.
          ELSE.
            ROLLBACK WORK.
            lv_log-step             = 'A'.
          ENDIF.
        ENDIF.
      ELSE. "Background Mode
        CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
          EXPORTING
            input  = ev_product
          IMPORTING
            output = lv_product.
        IF sy-subrc <> 0.
        ENDIF.

        "Check activate success or fail.
        IF lv_error = abap_true. "Failed - Background
          ROLLBACK WORK.
          IF line_exists( et_message[ type = 'E' ] )
          OR line_exists( et_message[ type = 'A' ] )
          OR line_exists( et_message[ type = 'X' ] ).
            lv_log-step             = 'B'.
          ENDIF.

        ELSE.    "Success - Background
          IF iv_mrp_operation = 'I'.
            COMMIT WORK AND WAIT.
          ENDIF.
          lv_log-status             = 'S'.
          lv_log-step               = 'B'.

          " Classification
          /simple/cl_classification=>save(
            EXPORTING
              iv_object         = ev_product
              iv_operation      = iv_mrp_operation
              it_classification = it_classification
            IMPORTING
              et_message        = et_message[] ).

          LOOP AT et_message TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
            lv_error = abap_true.
            EXIT.
          ENDLOOP.

          IF lv_error <> abap_true. "Modify class - success
            COMMIT WORK AND WAIT.

          ELSE.
            ROLLBACK WORK.
            lv_log-status           = 'S'.
            lv_log-step             = 'B'.
          ENDIF.
        ENDIF.
      ENDIF.

    ELSE. "Test run
*      IF iv_background IS INITIAL. "Foreground mode
      CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
        EXPORTING
          input  = ev_product
        IMPORTING
          output = lv_product.
      IF sy-subrc <> 0.
      ENDIF.

      "Check test run success or fail.
      IF lv_error = abap_true. "Failed
        ROLLBACK WORK.

      ELSE. "Success
        ROLLBACK WORK.
        lv_log-status   = 'S'.
      ENDIF.
    ENDIF.

  ELSE.
    ls_headdata-material    = ev_product.
    ls_headdata-basic_view  = 'X'.
    ls_clientdata-del_flag  = 'X'.
    ls_clientdatax-del_flag = 'X'.

    CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
      EXPORTING
        headdata       = ls_headdata
        clientdata     = ls_clientdata
        clientdatax    = ls_clientdatax
      IMPORTING
        return         = ls_return
      TABLES
        returnmessages = lt_ret.
*
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.
  ENDIF.
  LOOP AT et_message TRANSPORTING NO FIELDS WHERE type CA 'EAX'.
    lv_error = abap_true.
    EXIT.
  ENDLOOP.
  IF lv_error IS INITIAL.
    CLEAR et_message[].
  ENDIF.

  ev_status = lv_log-status. "BEN
  ev_step   = lv_log-step.   "BEN
ENDFUNCTION.
