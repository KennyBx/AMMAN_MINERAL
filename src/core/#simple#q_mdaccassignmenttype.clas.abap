CLASS /simple/q_mdaccassignmenttype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      objektart_bp TYPE ionr-obart VALUE 'BP', "Geschaeftsprozess
      objektart_or TYPE ionr-obart VALUE 'OR', "Auftrag
      objektart_op TYPE ionr-obart VALUE 'OP', "Auftragsposition
      objektart_pr TYPE ionr-obart VALUE 'PR', "Projektstrukturelement
      objektart_eo TYPE ionr-obart VALUE 'EO', "Ergebnisobjekt
      objektart_np TYPE ionr-obart VALUE 'NP', "Netzplan
      objektart_nv TYPE ionr-obart VALUE 'NV', "Netzplanvorgang
      objektart_sk TYPE ionr-obart VALUE 'SK', "Sachkonto
      objektart_vb TYPE ionr-obart VALUE 'VB', "Verkaufsbelegposition
      objektart_an TYPE ionr-obart VALUE 'AN', "Anlage
      objektart_ma TYPE ionr-obart VALUE 'MA', "Material
      objektart_hp TYPE ionr-obart VALUE 'HP', "Hierarchie Prozessfert
      objektart_ia TYPE ionr-obart VALUE 'IA', "Abrechnungseinheit
      objektart_ib TYPE ionr-obart VALUE 'IB', "Gebaeude
      objektart_ic TYPE ionr-obart VALUE 'IC', "Verwaltungsvertrag
      objektart_ig TYPE ionr-obart VALUE 'IG', "Grundstueck
      objektart_is TYPE ionr-obart VALUE 'IS', "Allg. Immobilienvertrag
      objektart_iv TYPE ionr-obart VALUE 'IV', "Mietvertrag
      objektart_iw TYPE ionr-obart VALUE 'IW', "Wirtschaftseinheit
      objektart_i1 TYPE ionr-obart VALUE 'I1', "Abrechnungseinheit
      objektart_im TYPE ionr-obart VALUE 'IM', "Mieteinheit
      objektart_ks TYPE ionr-obart VALUE 'KS'. "Kostenstelle

    TYPES: BEGIN OF ty_allowed_konty,
             aprof TYPE tkb1a-aprof,
             konty TYPE cobrb-konty,
             must  TYPE c LENGTH 1,
           END OF ty_allowed_konty.
    TYPES: ty_t_allowed_kontys TYPE STANDARD TABLE OF ty_allowed_konty WITH DEFAULT KEY.

    METHODS _append_allowed_kontys
      IMPORTING
        VALUE(v_aprof)   TYPE tkb1a-aprof
        VALUE(v_konty)   TYPE cobrb-konty
        VALUE(v_abflg)   TYPE tkb1a-abauf
      CHANGING
        t_allowed_kontys TYPE ty_t_allowed_kontys.
ENDCLASS.



CLASS /SIMPLE/Q_MDACCASSIGNMENTTYPE IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA:
      lv_wclause     TYPE string,
      lr_auart       TYPE RANGE OF t003o-auart,
      lr_konty       TYPE RANGE OF cobrb-konty,
      lt_data        TYPE STANDARD TABLE OF /simple/mdaccassignmenttype,
      lt_allowed_val TYPE ty_t_allowed_kontys.

    DATA(lv_entity_id) = io_request->get_entity_id( ).
    DATA(lo_filter) = io_request->get_filter( ).

    TRY.
        DATA(lt_ranges) = lo_filter->get_as_ranges( ).
        DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
        DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

**********************************************************************
        " Get data
        READ TABLE lt_ranges INTO DATA(ls_filter) WITH KEY name = 'ORDERTYPE'.
        IF sy-subrc = 0.
          lr_auart = CORRESPONDING #( ls_filter-range ).
        ENDIF.

        " Get order type -> settlement type
        SELECT t003o~auart, t003o~aprof
        FROM t003o
        WHERE ( t003o~autyp = '01'
           OR t003o~autyp = '02'
           OR t003o~autyp = '03' )
           AND auart IN @lr_auart
        INTO TABLE @DATA(lt_auart).
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.

        SELECT
            tkb1a~aprof,
            tkb1a~abprz,
            tkb1a~abkst,
            tkb1a~abauf,
            tkb1a~abaup,
            tkb1a~abpro,
            tkb1a~abbob,
            tkb1a~abnvg,
            tkb1a~absak,
            tkb1a~abprc,
            tkb1a~abanl,
            tkb1a~abktr,
            tkb1a~abmat,
            tkb1a~abimm
        FROM tkb1a
        FOR ALL ENTRIES IN @lt_auart
        WHERE tkb1a~aprof = @lt_auart-aprof
        INTO TABLE @DATA(lt_sett_type).
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.

        LOOP AT lt_sett_type INTO DATA(ls_sett_type).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_bp v_abflg = ls_sett_type-abprz
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_ks v_abflg = ls_sett_type-abkst
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_or v_abflg = ls_sett_type-abauf
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_op v_abflg = ls_sett_type-abaup
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_pr v_abflg = ls_sett_type-abpro
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_eo v_abflg = ls_sett_type-abbob
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_np v_abflg = ls_sett_type-abnvg
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_nv v_abflg = ls_sett_type-abnvg
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_sk v_abflg = ls_sett_type-absak
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_vb v_abflg = ls_sett_type-abprc
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_an v_abflg = ls_sett_type-abanl
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_hp v_abflg = ls_sett_type-abktr
          CHANGING t_allowed_kontys = lt_allowed_val ).
          me->_append_allowed_kontys(
          EXPORTING v_aprof = ls_sett_type-aprof v_konty = objektart_ma v_abflg = ls_sett_type-abmat
          CHANGING t_allowed_kontys = lt_allowed_val ).

          IF ls_sett_type-abimm IS NOT INITIAL.
            " RE Classic
            INCLUDE ifre_begin_of_re_classic.
            lt_allowed_val = VALUE #( BASE lt_allowed_val
            ( aprof = ls_sett_type-aprof konty = objektart_ia )
            ( aprof = ls_sett_type-aprof konty = objektart_ib )
            ( aprof = ls_sett_type-aprof konty = objektart_ic )
            ( aprof = ls_sett_type-aprof konty = objektart_ig )
            ( aprof = ls_sett_type-aprof konty = objektart_iv )
            ( aprof = ls_sett_type-aprof konty = objektart_iw )
            ( aprof = ls_sett_type-aprof konty = objektart_im must = COND #( WHEN ls_sett_type-abimm = '2' THEN 'X' ELSE '' ) ) ).
            INCLUDE ifre_end_of_re_classic.

            " RE-FX
            INCLUDE ifre_begin_of_re_ea_fin.
            lt_allowed_val = VALUE #( BASE lt_allowed_val
            ( aprof = ls_sett_type-aprof konty = objektart_ia )
            ( aprof = ls_sett_type-aprof konty = objektart_ib )
            ( aprof = ls_sett_type-aprof konty = objektart_ig )
            ( aprof = ls_sett_type-aprof konty = objektart_is )
            ( aprof = ls_sett_type-aprof konty = objektart_iw )
            ( aprof = ls_sett_type-aprof konty = objektart_i1 )
            ( aprof = ls_sett_type-aprof konty = objektart_im must = COND #( WHEN ls_sett_type-abimm = '2' THEN 'X' ELSE '' ) ) ).
            INCLUDE ifre_end_of_re_ea_fin.
          ENDIF.
        ENDLOOP.


        " get object type description
        SORT lt_allowed_val  BY konty.
        SELECT tbo00~obart, tbo01~spras, tbo01~obart_ld, tbo01~txt60
        FROM tbo00
        LEFT JOIN tbo01 ON tbo00~obart = tbo01~obart
        FOR ALL ENTRIES IN @lt_allowed_val WHERE tbo00~obart = @lt_allowed_val-konty
          AND ( settrecv = 'X' )
        INTO TABLE @DATA(lt_obart).
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.

        SORT lt_allowed_val BY aprof konty.
        SORT lt_obart BY obart spras.
        lt_data  = VALUE #(
        FOR ls_auart IN lt_auart
        FOR ls_konty IN lt_allowed_val WHERE ( aprof = ls_auart-aprof )
        FOR ls_obart IN lt_obart WHERE ( obart = ls_konty-konty )
        ( ordertype = ls_auart-auart accountassignmenttype = ls_konty-konty
          locale = ls_obart-spras description = ls_obart-txt60 ) ).

        SORT lt_data BY ordertype accountassignmenttype locale.
**********************************************************************
        DATA(lv_dyn_clause) =  io_request->get_filter( )->get_as_sql_string( ).

        IF lv_top > 0 AND lv_skip >= 0.
          SELECT *
          FROM @lt_data AS data
          WHERE (lv_dyn_clause)
          ORDER BY ordertype, accountassignmenttype, locale
          INTO TABLE @DATA(lt_result)
          UP TO @lv_top ROWS OFFSET @lv_skip.

        ELSE.
          SELECT *
          FROM @lt_data AS data
          WHERE (lv_dyn_clause)
          ORDER BY ordertype, accountassignmenttype, locale
          INTO TABLE @lt_result.
        ENDIF.

        io_response->set_total_number_of_records( lines( lt_result ) ).
        io_response->set_data( it_data = lt_result ).
      CATCH cx_static_check INTO DATA(lx_exception).
*        raise exception new lx_query_user_default( previous = lx_exception ).
    ENDTRY.
  ENDMETHOD.


  METHOD _append_allowed_kontys.
    IF v_abflg IS INITIAL.
      RETURN.
    ENDIF.

    t_allowed_kontys = VALUE #( BASE t_allowed_kontys
                              ( aprof = v_aprof konty = v_konty must = COND #( WHEN v_abflg = '1' THEN '' ELSE 'X' ) ) ).
  ENDMETHOD.
ENDCLASS.
