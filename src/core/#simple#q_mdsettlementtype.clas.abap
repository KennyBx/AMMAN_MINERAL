CLASS /simple/q_mdsettlementtype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF gty_settlementtype,
        perbz TYPE cobrb-perbz,
      END OF gty_settlementtype,
      gty_settlementtype_tab TYPE STANDARD TABLE OF gty_settlementtype WITH DEFAULT KEY.

    METHODS _get_allowed_settlementtype
      IMPORTING is_plan_settlement TYPE abap_bool DEFAULT abap_false
                iv_invma           TYPE taprf-invma
      EXPORTING et_allowed_value   TYPE gty_settlementtype_tab.
ENDCLASS.



CLASS /SIMPLE/Q_MDSETTLEMENTTYPE IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    TYPES: BEGIN OF lty_sett_type.
             INCLUDE TYPE tkb8a.
    TYPES:   description TYPE dd07v-ddtext,
           END OF lty_sett_type.

    DATA:
      lt_data      TYPE STANDARD TABLE OF /simple/mdsettlementtype,
      lt_sett_type TYPE STANDARD TABLE OF lty_sett_type.

    DATA: lv_domvalue TYPE dd07v-domvalue_l.

    DATA(lv_entity_id) = io_request->get_entity_id( ).
    DATA(lo_filter) = io_request->get_filter( ).

    TRY.
        DATA(lt_ranges) = lo_filter->get_as_ranges( ).
        DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
        DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

**********************************************************************
        SELECT * FROM tkb8a
        INTO TABLE @lt_sett_type
        WHERE perbz <> 'EPA'
          AND perbz <> 'JHR'
          AND perbz <> 'AUT'
        ORDER BY PRIMARY KEY.
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.

        SELECT ivpro, invma FROM taprf
        INTO TABLE @DATA(lt_inv_profile).

        LOOP AT lt_sett_type ASSIGNING FIELD-SYMBOL(<fs_sett_type>).
          lv_domvalue = <fs_sett_type>-perbz.
          CALL FUNCTION 'GET_TEXT_DOMVALUE'
            EXPORTING
              domname  = 'PERBZ'
              domvalue = lv_domvalue
              langu    = <fs_sett_type>-spras
            IMPORTING
              txt      = <fs_sett_type>-description.
        ENDLOOP.

        APPEND INITIAL LINE TO lt_inv_profile.
        SORT lt_inv_profile BY invma ivpro.
        LOOP AT lt_inv_profile INTO DATA(ls_inv_profile) GROUP BY ls_inv_profile-invma REFERENCE INTO DATA(invma_grp).
          _get_allowed_settlementtype(
            EXPORTING
              iv_invma           = ls_inv_profile-invma
            IMPORTING
              et_allowed_value   = DATA(lt_allowed_value) ).
          LOOP AT GROUP invma_grp INTO DATA(ls_invma_mem).
            IF lt_allowed_value IS INITIAL.
              lt_data = VALUE #( BASE lt_data
              FOR ls_sett IN lt_sett_type
              ( investmentmeasureprofile = ls_invma_mem-ivpro
                settlementtype           = ls_sett-perbz_ld
                locale                   = ls_sett-spras
                description              = ls_sett-description ) ).

            ELSE.
              lt_data = VALUE #( BASE lt_data
              FOR ls_sett IN lt_sett_type
              FOR ls_allowed_value IN lt_allowed_value WHERE ( perbz = ls_sett-perbz )
              ( investmentmeasureprofile = ls_invma_mem-ivpro
                settlementtype           = ls_sett-perbz_ld
                locale                   = ls_sett-spras
                description              = ls_sett-description ) ).
            ENDIF.
          ENDLOOP.
        ENDLOOP.
**********************************************************************
        DATA(lv_dyn_clause) =  io_request->get_filter( )->get_as_sql_string( ).

        IF lv_top > 0 AND lv_skip >= 0.
          SELECT *
          FROM @lt_data AS data
          WHERE (lv_dyn_clause)
          ORDER BY investmentmeasureprofile, settlementtype, locale
          INTO TABLE @DATA(lt_result)
          UP TO @lv_top ROWS OFFSET @lv_skip.

        ELSE.
          SELECT *
          FROM @lt_data AS data
          WHERE (lv_dyn_clause)
          ORDER BY investmentmeasureprofile, settlementtype, locale
          INTO TABLE @lt_result.
        ENDIF.

        io_response->set_total_number_of_records( lines( lt_result ) ).
        io_response->set_data( it_data = lt_result ).
      CATCH cx_static_check INTO DATA(lx_exception).
*        raise exception new lx_query_user_default( previous = lx_exception ).
    ENDTRY.
  ENDMETHOD.


  METHOD _get_allowed_settlementtype.
    IF is_plan_settlement = abap_true.
      APPEND VALUE #( perbz = 'PER' ) TO et_allowed_value.
      IF NOT iv_invma IS INITIAL.
        APPEND VALUE #( perbz = 'VOR' ) TO et_allowed_value.
      ENDIF.

    ELSE.
      IF iv_invma IS INITIAL.
        APPEND VALUE #( perbz = 'PER' ) TO et_allowed_value.
      ELSE.
        et_allowed_value = VALUE #( BASE et_allowed_value
        ( perbz = 'VOR' )
        ( perbz = 'EPA' )
        ( perbz = 'JHR' ) ).
      ENDIF.
      et_allowed_value = VALUE #( BASE et_allowed_value
      ( perbz = 'GES' )
      ( perbz = 'EPA' ) ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
