CLASS /simple/cl_prdlongtext DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF lty_cluster,
             clustr TYPE stxl-clustr,
             clustd TYPE stxl-clustd,
           END OF lty_cluster.
    TYPES ltt_cluster TYPE STANDARD TABLE OF lty_cluster WITH DEFAULT KEY.
ENDCLASS.



CLASS /SIMPLE/CL_PRDLONGTEXT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_lines TYPE STANDARD TABLE OF tline.
    LOOP AT ct_calculated_data ASSIGNING FIELD-SYMBOL(<ls_calc_data>).
      ASSIGN it_original_data[ sy-tabix ] TO FIELD-SYMBOL(<fs_orig_data>).
      IF <fs_orig_data> IS ASSIGNED.

        ASSIGN COMPONENT 'CLUSTR' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_clustr>).
        ASSIGN COMPONENT 'CLUSTD' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_clustd>).
        IF <fs_clustr> IS NOT ASSIGNED OR <fs_clustd> IS NOT ASSIGNED.
          CONTINUE.
        ENDIF.

        DATA(lt_cluster) = VALUE ltt_cluster( ( clustd = <fs_clustd>
                                                clustr = <fs_clustr> ) ).

        IMPORT tline TO lt_lines FROM INTERNAL TABLE lt_cluster.
        DATA(lv_string) = REDUCE #( INIT text TYPE string
                                     FOR <ls_lines> IN lt_lines
                                    NEXT text = COND #( WHEN text IS INITIAL
                                                        THEN <ls_lines>-tdline
                                                        ELSE |{ text } { <ls_lines>-tdline }| ) ).

        ASSIGN COMPONENT 'LONGTEXT' OF STRUCTURE <ls_calc_data> TO FIELD-SYMBOL(<fs_long_text>).
        IF <fs_long_text> IS ASSIGNED.
          <fs_long_text> = lv_string.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    et_requested_orig_elements = VALUE #( ( CONV string( 'CLUSTR' ) )
                                          ( CONV string( 'CLUSTD' ) ) ) .
  ENDMETHOD.
ENDCLASS.
