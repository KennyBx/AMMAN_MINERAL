CLASS /simple/q_mdgfailunitdelet DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
              lt_entity_data   TYPE STANDARD TABLE OF /simple/mdgfailunitdelet.
ENDCLASS.



CLASS /SIMPLE/Q_MDGFAILUNITDELET IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).

    TRY.
        SELECT
          t1~unit_id AS unitid
          message AS message
          message_id AS messageid
          message_number  AS  messagenumber
          message_v1      AS  messagev1
          message_v2      AS  messagev2
          message_v3      AS  messagev3
          message_v4      AS  messagev4
          queue_name      AS  queuename
          cprog AS  programname
         INTO CORRESPONDING FIELDS OF TABLE lt_entity_data
         FROM qrfc_i_err_state AS t1
         INNER JOIN qrfc_i_qin AS t2  ON t1~unit_id = t2~unit_id
         INNER JOIN  qrfc_i_unit AS t3 ON t1~unit_id = t3~unit_id
         WHERE t2~dest_name = 'BGRFC_SUPERVISOR' AND t2~queue_name LIKE 'SIMPLEMDG_BGRFC%'.

*        MOVE-CORRESPONDING lt_entity_data TO et_entityset.
        LOOP AT lt_entity_data ASSIGNING FIELD-SYMBOL(<lf_entityset>).

          TRY.
              <lf_entityset>-systemid = sy-sysid.

              cl_qrfc_client_inbound=>if_bgrfc_client~delete_failed_unit( unit_id = <lf_entityset>-unitid ).
              <lf_entityset>-status = 'Deleted'.
*              <lf_entityset>-mdglogid = lv_mdglogid.
            CATCH cx_bgrfc_invalid_unit cx_root. " Invalid Unit of Background RFC
              <lf_entityset>-status = 'Delete fail due to internal error'.
          ENDTRY.
        ENDLOOP.
        COMMIT WORK AND WAIT.

        io_response->set_total_number_of_records( lines( lt_entity_data ) ).
        io_response->set_data( lt_entity_data ).

      CATCH /iwbep/cx_mgw_busi_exception. " Business Exception

      CATCH /iwbep/cx_mgw_tech_exception. " Technical Exception.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
