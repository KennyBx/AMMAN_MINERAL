REPORT /simple/read_serverkey_ems.
*-------------------------------------------------------------------------------------------------------
* Begining of selection screen design
*-------------------------------------------------------------------------------------------------------
PARAMETERS:
  path TYPE string LOWER CASE OBLIGATORY,
  list TYPE c AS LISTBOX VISIBLE LENGTH 20 LOWER CASE OBLIGATORY.
*-------------------------------------------------------------------------------------------------------
* End of selection screen design
*-------------------------------------------------------------------------------------------------------

*-------------------------------------------------------------------------------------------------------
* Start of type declaration for JSON document structure
*-------------------------------------------------------------------------------------------------------
TYPES:
  BEGIN OF user_info,
    clientid      TYPE string,
    clientsecret  TYPE string,
    tokenendpoint TYPE string,
    namespace     TYPE string,
    uri           TYPE string,
  END OF user_info.
*-------------------------------------------------------------------------------------------------------
* End of type declaration for JSON document structure
*-------------------------------------------------------------------------------------------------------

*-------------------------------------------------------------------------------------------------------
* Start of rest of the declaration for JSON document structure
*-------------------------------------------------------------------------------------------------------
TYPES:
  BEGIN OF file_data,
    line TYPE string,
  END OF file_data.

TYPES:
  file_datas TYPE TABLE OF file_data INITIAL SIZE 0.

DATA: gt_list               TYPE vrm_values,
      gt_values             TYPE TABLE OF dynpread,
      gwa_values            TYPE dynpread,
      gv_selected_value(10) TYPE c,
      ls_data               TYPE user_info,
      ls_oath               TYPE /simple/mdg_oath,
      lv_clientid           TYPE string,
      lv_clientsecret       TYPE string,
      lv_tokenendpoint      TYPE string,
      lv_namespace          TYPE string,
      lv_uri                TYPE string,
      file_datas            TYPE file_datas,
      file_data             TYPE file_data,
      filepaths             TYPE filetable,
      return_code           TYPE i,
      json                  TYPE string.
*-------------------------------------------------------------------------------------------------------
* End of rest of the declaration for JSON document structure
*-------------------------------------------------------------------------------------------------------

AT SELECTION-SCREEN ON VALUE-REQUEST FOR path.

  cl_gui_frontend_services=>file_open_dialog(
    EXPORTING
      multiselection          = abap_false
    CHANGING
      file_table              = filepaths     " Table Holding Selected Files
      rc                      = return_code   " Return Code, Number of Files or -1 If Error Occurred
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5
  ).

  IF filepaths IS NOT INITIAL.
    path = filepaths[ 1 ]-filename.
  ENDIF.

*--------------------------------------------------------------*
*At Selection Screen
*--------------------------------------------------------------*
AT SELECTION-SCREEN ON list.
  CLEAR: gwa_values, gt_values.
  REFRESH gt_values.
  gwa_values-fieldname = 'LIST'.
  APPEND gwa_values TO gt_values.
  CALL FUNCTION 'DYNP_VALUES_READ'
    EXPORTING
      dyname             = sy-cprog
      dynumb             = sy-dynnr
      translate_to_upper = 'X'
    TABLES
      dynpfields         = gt_values.

  READ TABLE gt_values INDEX 1 INTO gwa_values.
  IF sy-subrc = 0 AND gwa_values-fieldvalue IS NOT INITIAL.
    READ TABLE gt_list INTO DATA(ls_list)
                      WITH KEY key = gwa_values-fieldvalue.
    IF sy-subrc = 0.
      gv_selected_value = ls_list-text.
    ENDIF.
  ENDIF.
*--------------------------------------------------------------*
*Initialization
*--------------------------------------------------------------*
INITIALIZATION.

  gt_list = VALUE #( BASE gt_list ( key = '1' text = 'messaging_core_1'  )
                                  ( key = '2' text = 'messaging_core_2'  )
                                  ( key = '3' text = 'messaging_core_3'  )
                                  ( key = '4' text = 'messaging_core_4'  )
                                  ( key = '5' text = 'messaging_core_5'  )
                                  ( key = '6' text = 'messaging_core_6'  )   ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'LIST'
      values          = gt_list
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

START-OF-SELECTION.

  cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename                = path               " Name of file
      filetype                = 'ASC'              " File Type (ASCII, Binary)
    CHANGING
      data_tab                = file_datas         " Transfer table for file contents
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      not_supported_by_gui    = 17
      error_no_gui            = 18
      OTHERS                  = 19 ).

  LOOP AT file_datas INTO file_data.

    CONDENSE file_data-line NO-GAPS.

    ls_data = VALUE #( BASE ls_data  clientid      = COND #( WHEN file_data-line CS 'clientid'      THEN file_data-line ELSE ls_data-clientid )
                                     clientsecret  = COND #( WHEN file_data-line CS 'clientsecret'  THEN file_data-line ELSE ls_data-clientsecret )
                                     tokenendpoint = COND #( WHEN file_data-line CS 'tokenendpoint' THEN file_data-line ELSE ls_data-tokenendpoint )
                                     namespace     = COND #( WHEN file_data-line CS 'namespace'     THEN file_data-line ELSE ls_data-namespace )
                                     uri           = COND #( WHEN file_data-line CS 'uri'           THEN file_data-line ELSE ls_data-uri ) ).
  ENDLOOP.


  "Danh Tran - 20240220 - Mod - Start
  json = | { ls_data-clientid } { ls_data-clientsecret } { ls_data-tokenendpoint } { ls_data-namespace } { ls_data-uri } |.
*  TRY .
*    DATA LV_INT TYPE I.
*
*    LV_INT = STRLEN( ls_data-clientid ) - 1.
*    IF ls_data-clientid+LV_INT(1) = ','. ls_data-clientid = ls_data-clientid+0(LV_INT). ENDIF.
*
*    LV_INT = STRLEN( ls_data-clientsecret ) - 1.
*    IF ls_data-clientsecret+LV_INT(1) = ','. ls_data-clientsecret = ls_data-clientsecret+0(LV_INT). ENDIF.
*
*    LV_INT = STRLEN( ls_data-tokenendpoint ) - 1.
*    IF ls_data-tokenendpoint+LV_INT(1) = ','. ls_data-tokenendpoint = ls_data-tokenendpoint+0(LV_INT). ENDIF.
*
*    LV_INT = STRLEN( ls_data-namespace ) - 1.
*    IF ls_data-namespace+LV_INT(1) = ','. ls_data-namespace = ls_data-namespace+0(LV_INT). ENDIF.
*
*    LV_INT = STRLEN( ls_data-uri ) - 1.
*    IF ls_data-uri+LV_INT(1) = ','. ls_data-uri = ls_data-uri+0(LV_INT). ENDIF.
*
*    json = | { ls_data-clientid }, { ls_data-clientsecret }, { ls_data-tokenendpoint }, { ls_data-namespace }, { ls_data-uri } |.
*  CATCH cx_root.
*    return.
*  ENDTRY.

  "Danh Tran - 20240220 - Mod - End

  CONCATENATE '{  ' json '  }' INTO json.

  /ui2/cl_json=>deserialize( EXPORTING json        = json
                                       pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                              CHANGING data = ls_data ).
  ls_oath = VALUE #( BASE ls_oath client_id        = ls_data-clientid
                                  client_pw        = ls_data-clientsecret
                                  message_endpoint = ls_data-uri
                                  token_endpoint   = ls_data-tokenendpoint && '?grant_type=client_credentials&response_type=token'
                                  activate         = ABAP_TRUE
                                  name_space       = ls_data-namespace
                                  name             = COND #( WHEN list = 1 then 'mcore_1'
                                                             WHEN list = 2 then 'mcore_2'
                                                             WHEN list = 3 then 'mcore_3'
                                                             WHEN list = 4 then 'mcore_4'
                                                             WHEN list = 5 then 'mcore_5'
                                                             WHEN list = 6 then 'mcore_6'  ) ).

  MODIFY /simple/mdg_oath  FROM ls_oath.
