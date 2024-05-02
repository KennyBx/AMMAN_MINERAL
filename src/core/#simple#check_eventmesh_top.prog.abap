*&---------------------------------------------------------------------*
*& Include          /SIMPLE/CONFIG_EVENTMESH_TOP
*&---------------------------------------------------------------------*
    TYPES: BEGIN OF gty_status,
             step        TYPE char10,
             description TYPE char100,
             status      TYPE icon-id,
             error_log   TYPE icon-id,
           END OF gty_status.

    DATA: gt_data        TYPE STANDARD TABLE OF gty_status,
          gs_data        TYPE gty_status,
          gt_fcat        TYPE lvc_t_fcat,
          gs_fcat        LIKE LINE OF gt_fcat,
          gv_message     TYPE c LENGTH 400,
          go_HTTP_client TYPE REF TO IF_HTTP_CLIENT,
          go_request     TYPE REF TO if_apc_wsp_client_initial_req,
          gv_error_text  TYPE string,
          gv_oa2c        TYPE string.
