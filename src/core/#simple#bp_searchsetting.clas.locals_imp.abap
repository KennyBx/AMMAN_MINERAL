CLASS lcl_service_provider DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS get_instance RETURNING VALUE(ro_object) TYPE REF TO /simple/cl_search.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA go_object TYPE REF TO /simple/cl_search.
ENDCLASS.

CLASS lcl_service_provider IMPLEMENTATION.
  METHOD get_instance.
    IF go_object IS INITIAL.
      go_object = NEW #( ).
    ENDIF.
    ro_object = go_object.
  ENDMETHOD.
ENDCLASS.

CLASS lhc_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS modify FOR MODIFY
      IMPORTING it_search FOR CREATE searchsetting
                it_field  FOR CREATE searchsetting\_searchfields
                it_value  FOR CREATE searchfield\_searchvalues
                it_result FOR CREATE searchsetting\_searchresults.

    METHODS read FOR READ
      IMPORTING it_search FOR READ searchsetting RESULT et_search
                it_field  FOR READ searchsetting\_searchfields FULL field_requested RESULT et_field LINK field_links
                it_result FOR READ searchsetting\_searchresults FULL result_requested RESULT et_result LINK result_links.

ENDCLASS.

CLASS lhc_handler IMPLEMENTATION.
  METHOD modify.
    DATA:
      ls_data       TYPE /simple/cl_search=>gty_search,
      ls_data_field TYPE /simple/cl_search=>gty_searchfield.

    " Search Setting
    TRY.
        DATA(ls_search) = it_search[ 1 ].
        DATA(lt_field) = it_field[ %cid_ref = ls_search-%cid ]-%target.
      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.
    ls_data = CORRESPONDING #( ls_search ).

    " Search Fields
    LOOP AT lt_field INTO DATA(ls_field).
      " Search Values
      TRY.
          DATA(ls_value) = it_value[ %cid_ref = ls_field-%cid ].
        CATCH cx_sy_itab_line_not_found.
          CONTINUE.
      ENDTRY.

      ls_data_field = CORRESPONDING #( ls_field ).
      ls_data_field-to_searchvalues = CORRESPONDING #( ls_value-%target ).

      APPEND ls_data_field TO ls_data-to_searchfields.
    ENDLOOP.

    lcl_service_provider=>get_instance( )->set_search_criteria( is_data = ls_data ).
  ENDMETHOD.

  METHOD read.
    IF it_search IS NOT INITIAL.
      et_search = CORRESPONDING #( it_search ).
    ELSEIF result_requested IS NOT INITIAL.
      et_result = CORRESPONDING #( lcl_service_provider=>get_instance( )->get_search_result( ) ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lsc_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS check_before_save REDEFINITION.
    METHODS finalize          REDEFINITION.
    METHODS save              REDEFINITION.
ENDCLASS.

CLASS lsc_saver IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

ENDCLASS.
