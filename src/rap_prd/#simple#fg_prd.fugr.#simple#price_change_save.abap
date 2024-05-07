FUNCTION /simple/price_change_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_VALUATION) TYPE  /SIMPLE/PRD_VAL_T
*"     VALUE(IV_MDGLOGID) TYPE  CHAR36
*"     VALUE(IV_ACTIVATEID) TYPE  CHAR20
*"     VALUE(IV_ACTIVATEITEMID) TYPE  CHAR20
*"     VALUE(IV_CRNUMBER) TYPE  CHAR20
*"     VALUE(IV_CRITEM) TYPE  CHAR20
*"     VALUE(IV_ACTIONMODE) TYPE  CHAR20
*"     VALUE(IV_PRODUCT) TYPE  MATNR
*"  EXPORTING
*"     VALUE(ET_MESSAGE) TYPE  BAPIRET2_T
*"----------------------------------------------------------------------

  DATA:
    ls_response TYPE /simple/cl_mdg_gw_core_dpc_ext=>ts_response_me,
    ls_log      TYPE /simple/api_log,
    lv_handle   TYPE balloghndl.
  DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).
  lo_object->execute_price_change(
    EXPORTING
      it_valuatuon = it_valuation
      iv_actionmode = iv_actionmode
    IMPORTING
      et_message   = et_message

  ).
  IF to_upper( iv_actionmode ) CS 'VALIDATION'.
    ROLLBACK WORK.
  ELSE.
    IF line_exists( et_message[ type = 'A' ] )
    OR line_exists( et_message[ type = 'E' ] )
    OR line_exists( et_message[ type = 'X' ] ).
      ROLLBACK WORK.
    ELSE.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDIF.

****  ls_response-mdglogid       = iv_mdglogid.
****  ls_response-actionmode     = iv_actionmode.
****  ls_response-activateid     = iv_activateid.
****  ls_response-activateitemid = iv_activateitemid.
****  ls_response-crnumber       = iv_crnumber.
****  ls_response-critem         = iv_critem.
****  ls_response-mdkey          = iv_product.
****
*****  lv_log-mdg_key          = iv_product.
*****  lv_log-activate_id      = iv_activateid.
*****  lv_log-activate_item_id = iv_activateitemid.
*****  lv_log-cr_number        = iv_crnumber.
*****  lv_log-cr_item          = iv_critem.
*****  lv_log-obj_type         = 'Product'.
*****  lv_log-mdglogid         = iv_mdglogid.
*****
*****  IF line_exists( et_message[ type = 'E' ] )
*****  OR line_exists( et_message[ type = 'A' ] )
*****  OR line_exists( et_message[ type = 'X' ] ).
*****    lv_log-status           = 'F'.
*****  ELSE.
*****    lv_log-status           = 'S'.
*****  ENDIF.
*****  IF to_upper( iv_actionmode ) CS 'VALIDATION'.
*****    lv_log-step = COND #( WHEN  to_upper( iv_actionmode ) CS 'BACKGROUND' THEN 'BV'  ELSE 'V'  ). " Validation check?
*****  ELSE.
*****    lv_log-step = COND #( WHEN  to_upper( iv_actionmode ) CS 'BACKGROUND' THEN 'B'   ELSE 'A'  ). " Not validation check?
*****  ENDIF.
*****
*****  CALL FUNCTION '/SIMPLE/FM_LOG_SAVE'
*****    EXPORTING
*****      is_log        = lv_log
*****      iv_log_handle = lv_handle.                 " API LOG
****
****  ls_response-mdkey =  /simple/cl_json_utility=>convert_stuct_to_json(
****                          EXPORTING im_s_data = VALUE /simple/prd_service_provider=>gty_prd_key_log(
****                                                        product = iv_product )
****                                    im_v_case = /simple/cl_json_utility=>co_ftype_camelcase ).
****  ls_log = /simple/cl_mdg_gw_core_dpc_ext=>handle_appl_log(  is_response  = ls_response
****                                                    it_message   = et_message
****                                                    iv_subobject = 'Product' ).

ENDFUNCTION.
