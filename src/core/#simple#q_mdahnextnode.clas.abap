CLASS /simple/q_mdahnextnode DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /SIMPLE/Q_MDAHNEXTNODE IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA:
      lt_data       TYPE STANDARD TABLE OF /simple/mdahnextnode,
      l_next_number TYPE wrf_struc_node.

*calls for io-request
    DATA(lt_sorting) = io_request->get_sort_elements( ).
    DATA(lo_paging) = io_request->get_paging( ).
    DATA(lo_filter) = io_request->get_filter( ).
*Handle paging
    DATA(lv_offset) = lo_paging->get_offset( ).
    DATA(lv_page_size) = lo_paging->get_page_size( ).
    DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited THEN 0
    ELSE lv_page_size ).
*Handle aggregations
    DATA(lt_req_elements) = io_request->get_requested_elements( ).
    DATA(lt_aggr_elements) = io_request->get_aggregation( )->get_aggregated_elements( ).
    IF lt_aggr_elements IS NOT INITIAL.
      LOOP AT lt_aggr_elements ASSIGNING FIELD-SYMBOL(<fs>).
        DELETE lt_req_elements WHERE table_line = <fs>-result_element.
        DATA(lv_aggregation) = |{ <fs>-aggregation_method }( { <fs>-input_element } ) as { <fs>-result_element }|.
        APPEND lv_aggregation TO lt_req_elements.
      ENDLOOP.
    ENDIF.
    DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements sep = ',' ).
    DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
    DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element sep = ',' ).
*Handle sorting
    DATA(sort_elements) = io_request->get_sort_elements( ).
    DATA(lt_sort_criteria) = VALUE string_table( FOR sort_element IN sort_elements
                                                    ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                        THEN 'descending'
                                                        ELSE 'ascending' )
                                                    )
                                                ).
    DATA(lv_sort_string) = COND #( WHEN lt_sort_criteria IS INITIAL THEN concat_lines_of( table = io_request->get_requested_elements( ) sep = ',' )
    ELSE concat_lines_of( table = lt_sort_criteria sep = ',' ) ).
    DATA(lv_where) = cl_abap_dyn_prg=>escape_quotes_str( lo_filter->get_as_sql_string( ) ).

    TRY.
        DATA(lv_need_call) = abap_true.
        DATA(lt_ranges) = lo_filter->get_as_ranges( ).
        IF lt_ranges IS NOT INITIAL.
          DATA(lt_range) = lt_ranges[ 1 ]-range.
          DATA(lv_nextNode) = lt_range[ 1 ]-low.
          IF lv_nextNode IS NOT INITIAL.
            lv_need_call = abap_false.
            l_next_number = lv_nextNode.
            lt_data = VALUE #( BASE lt_data ( nextNode = l_next_number ) ).
            TRY.
                io_response->set_data( it_data = lt_data ).
                IF io_request->is_total_numb_of_rec_requested( ).
                  io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_data ) ).
                ENDIF.
              CATCH cx_rap_query_response_set_twic.
            ENDTRY.
          ENDIF.
        ENDIF.

        IF lv_need_call IS NOT INITIAL.
          CALL FUNCTION 'NUMBER_GET_NEXT'
            EXPORTING
              nr_range_nr             = '01'
              object                  = 'WMATGRP_NC'
            IMPORTING
              number                  = l_next_number
            EXCEPTIONS
              interval_not_found      = 1
              number_range_not_intern = 2
              object_not_found        = 3
              quantity_is_0           = 4
              quantity_is_not_1       = 5
              interval_overflow       = 6
              buffer_overflow         = 7
              OTHERS                  = 8.
          IF sy-subrc = 0.
            SHIFT l_next_number LEFT DELETING LEADING '0'.
            lt_data = VALUE #( BASE lt_data ( nextNode = l_next_number ) ).
            TRY.
                io_response->set_data( it_data = lt_data ).
                IF io_request->is_total_numb_of_rec_requested( ).
                  io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_data ) ).
                ENDIF.
              CATCH cx_rap_query_response_set_twic.
            ENDTRY.
          ENDIF.
        ENDIF.
      CATCH cx_rap_query_filter_no_range.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
