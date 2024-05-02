CLASS /simple/q_dynamicset DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      gty_dynamicset TYPE STANDARD TABLE OF /simple/mddynamicset WITH DEFAULT KEY.

    TYPES:
      BEGIN OF ts_dynamicf4,
        tablename    TYPE c LENGTH 30,
        fieldname    TYPE c LENGTH 30,
        filter       TYPE c LENGTH 255,
        top          TYPE int8,
        skip         TYPE int8,
        to_mddynamic TYPE gty_dynamicset,
      END OF ts_dynamicf4 .

    METHODS get_dynamicf4
      CHANGING
        VALUE(cs_data) TYPE ts_dynamicf4.

    METHODS dynamic_filter
      IMPORTING
        !iv_filter    TYPE char255
        !it_dfies_tab TYPE dfies_tab
      EXPORTING
        !ev_condition TYPE string .

    METHODS dynamic_merge_data
      IMPORTING
        !it_data          TYPE STANDARD TABLE
        !it_dfies_tab     TYPE dfies_tab
        !is_data          TYPE ts_dynamicf4
        !iv_domname_input TYPE domname
      EXPORTING
        !et_mddynamic     TYPE gty_dynamicset .

ENDCLASS.



CLASS /SIMPLE/Q_DYNAMICSET IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
*
    DATA:
      lt_data         TYPE STANDARD TABLE OF /simple/mddynamicset.

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
          "get and add filter
          IF io_request->is_data_requested( ).
            DATA(lt_ranges) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).
          ENDIF.

        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).

      ENDTRY.

     DATA ls_dynamic_data TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4.
*
    TRY.
*        DATA(lt_ranges) = lo_filter->get_as_ranges( ).
        READ TABLE lt_ranges INTO DATA(ls_filter) WITH KEY name = 'TABLENAME'.
        IF sy-subrc = 0.
          ls_dynamic_data-tablename = ls_filter-range[ 1 ]-low.
        ELSE.

        ENDIF.

        READ TABLE lt_ranges INTO ls_filter WITH KEY name = 'FIELDNAME'.
        IF sy-subrc = 0.
          ls_dynamic_data-fieldname = ls_filter-range[ 1 ]-low.
        ELSE.

        ENDIF.

        READ TABLE lt_ranges INTO ls_filter WITH KEY name = 'FILTER'.
        IF sy-subrc = 0.
          ls_dynamic_data-filter = ls_filter-range[ 1 ]-low.
        ELSE.
        ENDIF.
        DATA lo_object TYPE REF TO /simple/cl_multiplesearchhelp.

        CREATE OBJECT lo_object.
        IF lo_object IS NOT INITIAL.
          ls_dynamic_data-fieldname = to_upper( ls_dynamic_data-fieldname  ).
          DATA(ls_dynamic_data_t) = ls_dynamic_data.
*   --------------------------------------------------------------------*
          "Search with table /SIMPLE/DYNAMICF
*   --------------------------------------------------------------------*
          SELECT *
            INTO TABLE @DATA(lt_dynamicf)
            FROM /simple/dynamicf
            WHERE tablename_input = @ls_dynamic_data-tablename
              AND fieldname_input = @ls_dynamic_data-fieldname.
          IF lt_dynamicf IS NOT INITIAL.
            LOOP AT lt_dynamicf[] INTO DATA(ls_dynamicf).
              ls_dynamic_data-tablename = ls_dynamicf-tablename_output.
              ls_dynamic_data-fieldname = ls_dynamicf-fieldname_output.

              lo_object->get_dynamicf4(
                CHANGING
                  cs_data = ls_dynamic_data
              ).
            ENDLOOP.

          ELSE.
            lo_object->get_dynamicf4(
              CHANGING
                cs_data = ls_dynamic_data
            ).
          ENDIF.

*   --------------------------------------------------------------------*
          "Search from table T682Z
*   --------------------------------------------------------------------*
          IF  ls_dynamic_data-to_mddynamic[]  IS INITIAL
          AND ls_dynamic_data-tablename       IS INITIAL.
            ls_dynamic_data-fieldname = to_upper( ls_dynamic_data-fieldname  ).
            SELECT DISTINCT t682z~qustr, t682z~qufna
              FROM t682z
              WHERE upper( t682z~zifna ) = @ls_dynamic_data-fieldname
                AND t682z~qustr <> ''
                AND t682z~qufna <> ''
              INTO TABLE @DATA(lt_t682z).
            LOOP AT lt_t682z INTO DATA(ls_t682z).
              ls_dynamic_data-tablename = ls_t682z-qustr.
              ls_dynamic_data-fieldname = ls_t682z-qufna.
              lo_object->get_dynamicf4(
                CHANGING
                  cs_data = ls_dynamic_data
              ).
              IF ls_dynamic_data-to_mddynamic[] IS NOT INITIAL.
                EXIT.
              ENDIF.
            ENDLOOP.
          ENDIF.

          LOOP AT ls_dynamic_data-to_mddynamic[] ASSIGNING FIELD-SYMBOL(<lfs_mddynamic>).
            <lfs_mddynamic>-tablename = ls_dynamic_data_t-tablename.
            <lfs_mddynamic>-fieldname = ls_dynamic_data_t-fieldname.
          ENDLOOP.
          ls_dynamic_data-tablename = ls_dynamic_data_t-tablename.
          ls_dynamic_data-fieldname = ls_dynamic_data_t-fieldname.
        ENDIF.


*        IF lv_page_size > 0 AND lv_offset >= 0 .
**
*          SELECT *
*          FROM @ls_dynamic_data-to_mddynamic AS data
*
*          ORDER BY tablename, fieldname
*          INTO TABLE @DATA(lt_result)
*          UP TO @lv_page_size ROWS OFFSET @lv_offset.
*
*        ELSE.
*          SELECT *
*          FROM @ls_dynamic_data-to_mddynamic AS data
*          ORDER BY tablename, fieldname
*          INTO TABLE @lt_result.
*        ENDIF.
*        .

        DATA LT_RESULT TYPE STANDARD TABLE OF /SIMPLE/DynamicF4Set.

        APPEND INITIAL LINE TO   LT_RESULT ASSIGNING FIELD-SYMBOL(<LFS_RESULT>).
        MOVE-CORRESPONDING ls_dynamic_data TO <LFS_RESULT>.

        io_response->set_data( it_data = lt_result ).
        io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_result ) ).

    CATCH cx_static_check INTO DATA(lx_exception).
    ENDTRY.


  ENDMETHOD.


  METHOD if_rap_query_provider~get_sort_elements.

  ENDMETHOD.


  METHOD get_dynamicf4.
    DATA ls_result_df TYPE /simple/mddynamicset.
    DATA lt_dfies_tab    TYPE STANDARD TABLE OF dfies.
    DATA lt_dfies_tab_text    TYPE STANDARD TABLE OF dfies.
    DATA:
      lv_tabname_text TYPE dd03l-tabname,
      lv_value        TYPE string,
      lv_string       TYPE string,
      lv_condition    TYPE string,
      lv_condition_ad TYPE string,
      lv_text         TYPE string,
      lv_fromtable    TYPE string,
      lv_domname_ip   TYPE domname,
      lo_data         TYPE REF TO data,
      lv_routine      TYPE convexit
      .

    DATA:
      ls_field_attr TYPE dfies,
      ls_shlp       TYPE shlp_descr_t,
      lt_shlp_tab   TYPE shlp_descr_tab_t
      .

    DATA lv_tabname_input TYPE ddobjname.
    DATA lv_fieldname_input TYPE dfies-fieldname.
    DATA  lv_selection_field  TYPE string.
*  DATA  LV_FROMTABLE  TYPE STRING.
    DATA  lt_comp TYPE abap_component_tab.
    DATA  ls_comp LIKE LINE OF lt_comp.
    DATA lo_result_ref TYPE REF TO data.
    FIELD-SYMBOLS <lft_table_rs> TYPE STANDARD TABLE.
    DATA: lr_type_struct TYPE REF TO cl_abap_structdescr,
          lr_type_table  TYPE REF TO cl_abap_tabledescr,
          lr_data_tab    TYPE REF TO data.
    FIELD-SYMBOLS <lft_data_input> TYPE STANDARD TABLE.

    FREE cs_data-to_mddynamic.
*  if cs_data-tablename is initial
*  or cs_data-fieldname is initial.
*    return.
*  endif.
    cs_data-fieldname = to_upper( cs_data-fieldname  ).

*  MOVE-CORRESPONDING CS_DATA TO LS_RESULT_DF.

*----------------------------------------------------------------------*
*   F4-Hilfe für CO-PA Merkmale innerhalb der Setpflege
*----------------------------------------------------------------------*
    IF cs_data-tablename(3) = 'CE7'
    AND ( cs_data-fieldname = 'PAPH2'
      OR cs_data-fieldname = 'PAPH3'
      OR cs_data-fieldname = 'PAPH4'
      OR cs_data-fieldname = 'PAPH6'
      OR cs_data-fieldname = 'PAPH8'
      )
      .
      DATA:
        lv_erkrs                     TYPE tkebb-erkrs,
        lv_ce0_name                  TYPE dd03p-tabname VALUE 'CE0XXXX',
        lv_patype                    TYPE tkebb-patype,
        lt_field_tab                 TYPE STANDARD TABLE OF cdifie,
        lt_fdep_tab                  TYPE STANDARD TABLE OF cdidep,
        ls_rkb1x                     TYPE rkb1x,
        lv_check_f4_handling_only(1),
        lv_stufe                     TYPE t023d-stufe,
        lv_stufe_n(2)                TYPE n,
        lv_level                     TYPE t179-stufe,
        lv_handled(1)
        .
*  .initialization
      lv_erkrs = cs_data-tablename+3(4).
      SELECT SINGLE *
        INTO @DATA(ls_tkebb) FROM tkebb
        WHERE erkrs = @lv_erkrs.
      lv_patype = ls_tkebb-patype.
      REPLACE 'XXXX' WITH lv_erkrs INTO lv_ce0_name.

      IF cs_data-tablename(3) = 'CE9'.
        lv_patype = '1'.
      ENDIF.
      IF lv_patype NA '123'.
        RETURN.
      ENDIF.

      ls_rkb1x-erkrs = lv_erkrs.
      ls_rkb1x-pa_type = lv_patype.
      CONCATENATE 'CE0' lv_erkrs INTO ls_rkb1x-tabname.

      CALL FUNCTION 'RKD_FIELD_TAB_FILL'
        EXPORTING
          applclass = 'KE' "c_applclass_ke
          i_rkb1x   = ls_rkb1x
        IMPORTING
          table     = ls_rkb1x-tabname
        TABLES
          field_tab = lt_field_tab
          fdep_tab  = lt_fdep_tab.

      SORT lt_field_tab BY fienm.
      SORT lt_fdep_tab BY fienm posit.

*----------------------------------------------------------------------*
*   Normales Merkmal in Applikation KE
*----------------------------------------------------------------------*
      READ TABLE lt_field_tab INTO DATA(ls_field)
                             WITH KEY fienm = cs_data-fieldname.

      IF ls_field-spctr(2) EQ '03'.
*   Warengruppenhierarchie
        lv_stufe_n = ls_field-spctr+2(1).
        lv_stufe = lv_stufe_n.
        IF lv_check_f4_handling_only IS INITIAL.
**        perform shandling_f4_mghierarchie using   i_display
**                                                  l_stufe
**                                         changing e_selected_value.
        ENDIF.
      ELSEIF ls_field-spctr(2) EQ '10' OR
             ls_field-spctr(2) EQ '11' OR
             ls_field-spctr(2) EQ '12'.
*   Produkthierarchie
        lv_level = ls_field-spctr+2(1).
        IF lv_check_f4_handling_only IS INITIAL.
*        perform shandling_f4_prodh using    i_display
*                                            l_level
*                                   changing e_selected_value.

          lv_tabname_input = 'T179T'.
          lv_fieldname_input = 'PRODH'.

          lv_condition_ad = |T179~STUFE = '{ lv_level }'|.
          lv_fromtable = | T179 LEFT JOIN T179T ON T179~PRODH = T179T~PRODH AND T179T~SPRAS = '{ sy-langu }'|.
          lv_tabname_text = 'T179T'.
          lv_selection_field = 'T179T~MANDT, T179T~SPRAS, T179T~PRODH, T179T~VTEXT'.
        ENDIF.
      ELSEIF ls_field-spctr = '050'  "rkea1_c_spctr-regkna
          OR ls_field-spctr = '051'.  "rkea1_c_spctr-reg01w.
        IF lv_check_f4_handling_only IS INITIAL.
          lv_tabname_input = 'T005U'.
          lv_fieldname_input = 'BLAND'.
**        perform shandling_f4_regio using    i_display
**                                   changing e_selected_value.
        ENDIF.
      ELSE.
        RETURN.
      ENDIF.
      "Attribute
      FREE lt_dfies_tab[].
      CALL FUNCTION 'DDIF_FIELDINFO_GET'
        EXPORTING
          tabname        = lv_tabname_input     "CS_DATA-TABLENAME
          fieldname      = lv_fieldname_input   "CS_DATA-FIELDNAME
        TABLES
          dfies_tab      = lt_dfies_tab
*         FIXED_VALUES   = FIXED_VALUES
        EXCEPTIONS
          not_found      = 1
          internal_error = 2.
      READ TABLE lt_dfies_tab INTO DATA(ls_dfies_tab_input) INDEX 1.
      lv_domname_ip = ls_dfies_tab_input-domname.
      IF lv_tabname_text IS INITIAL.
        lv_tabname_text = lv_tabname_input.
      ENDIF.


*  ELSEIF CS_DATA-TABLENAME =  'T001'.
*      LV_TABNAME_INPUT = 'T179T'.
*      LV_FIELDNAME_INPUT = 'PRODH'.
    ELSE.
*----------------------------------------------------------------------*
*   Try new search help first: get search help for field of RW-Table
*----------------------------------------------------------------------*
      lv_tabname_input   = cs_data-tablename.
      lv_fieldname_input = cs_data-fieldname.
      "Attribute
      FREE lt_dfies_tab[].
      CALL FUNCTION 'DDIF_FIELDINFO_GET'
        EXPORTING
          tabname        = lv_tabname_input     "CS_DATA-TABLENAME
          fieldname      = lv_fieldname_input   "CS_DATA-FIELDNAME
        TABLES
          dfies_tab      = lt_dfies_tab
*         FIXED_VALUES   = FIXED_VALUES
        EXCEPTIONS
          not_found      = 1
          internal_error = 2.
      READ TABLE lt_dfies_tab INTO ls_dfies_tab_input INDEX 1.
      lv_domname_ip = ls_dfies_tab_input-domname.

*   ----------------------------------------------------------------------*
*      Searchelp
*   ----------------------------------------------------------------------*
      CALL FUNCTION 'F4IF_DETERMINE_SEARCHHELP'
        EXPORTING
          tabname   = ls_dfies_tab_input-tabname
          fieldname = ls_dfies_tab_input-fieldname
        IMPORTING
          shlp      = ls_shlp
        EXCEPTIONS
          OTHERS    = 0.

      CALL FUNCTION 'DD_SHLP_EXPAND_HELPMETHOD'
        EXPORTING
          shlp_top = ls_shlp
        IMPORTING
          shlp_tab = lt_shlp_tab[]
        EXCEPTIONS
          OTHERS   = 1.
      LOOP AT lt_shlp_tab[] INTO DATA(ls_shlp_tab) WHERE intdescr-selmethod IS NOT INITIAL OR intdescr-texttab IS NOT INITIAL.
        EXIT.
      ENDLOOP.
      IF  ls_shlp_tab-intdescr-selmethod IS INITIAL
      AND ls_shlp_tab-intdescr-texttab IS INITIAL.
        DATA ls_dd01v_wa TYPE dd01v.
*   ----------------------------------------------------------------------*
*    The new help functions do no longer support help for entitytable
*    of domains.
*    Because the callers of HELP_VALUE_GET rely on this support,
*    it must be implemented separetely
*   ----------------------------------------------------------------------*
        IF ls_dfies_tab_input-domname IS INITIAL.
          ls_dfies_tab_input-domname = cs_data-fieldname.
        ENDIF.
        CALL FUNCTION 'DDIF_DOMA_GET'
          EXPORTING
            name     = ls_dfies_tab_input-domname
          IMPORTING
            dd01v_wa = ls_dd01v_wa
          EXCEPTIONS
            OTHERS   = 2.
        CHECK sy-subrc = 0 AND ls_dd01v_wa-entitytab <> space.
        CLEAR lt_dfies_tab[].
        CALL FUNCTION 'DDIF_FIELDINFO_GET'
          EXPORTING
            tabname   = ls_dd01v_wa-entitytab
          TABLES
            dfies_tab = lt_dfies_tab
          EXCEPTIONS
            OTHERS    = 0.
        READ TABLE lt_dfies_tab INTO ls_dfies_tab_input
             WITH KEY keyflag = 'X' domname = ls_dd01v_wa-domname.
        CHECK sy-subrc = 0.
        CALL FUNCTION 'DD_SHLP_GET_HELPMETHOD'
          EXPORTING
            tabname       = ls_dfies_tab_input-tabname
            fieldname     = ls_dfies_tab_input-fieldname
            get_entitytab = 'X'
          CHANGING
            shlp          = ls_shlp
          EXCEPTIONS
            OTHERS        = 3.
        ls_shlp_tab = ls_shlp.

      ENDIF.

      IF  ls_shlp_tab-intdescr-selmethod IS INITIAL
      AND ls_shlp_tab-intdescr-texttab IS INITIAL.

        CALL FUNCTION 'DD_SHLP_EXPAND_HELPMETHOD'
          EXPORTING
            shlp_top = ls_shlp
          IMPORTING
            shlp_tab = lt_shlp_tab[]
          EXCEPTIONS
            OTHERS   = 1.
        LOOP AT lt_shlp_tab[] INTO ls_shlp_tab WHERE intdescr-selmethod IS NOT INITIAL OR intdescr-texttab IS NOT INITIAL.
          EXIT.
        ENDLOOP.

        IF  ls_shlp_tab-intdescr-selmethod IS INITIAL
        AND ls_shlp_tab-intdescr-texttab IS INITIAL.
          RETURN.
        ENDIF.

      ENDIF.

      IF ls_shlp_tab-intdescr-texttab IS NOT INITIAL.
        lv_tabname_text = ls_shlp_tab-intdescr-texttab.

      ELSE.
        lv_tabname_text = ls_shlp_tab-intdescr-selmethod.
      ENDIF.
      IF  ls_shlp_tab-intdescr-selmethod IS NOT INITIAL
      AND ls_shlp_tab-intdescr-texttab IS NOT INITIAL.
        FREE lt_dfies_tab[].
        CALL FUNCTION 'DDIF_FIELDINFO_GET'
          EXPORTING
            tabname        = ls_shlp_tab-intdescr-selmethod
          TABLES
            dfies_tab      = lt_dfies_tab
          EXCEPTIONS
            not_found      = 1
            internal_error = 2.
        DELETE lt_dfies_tab WHERE fieldname CS '.' OR fieldname = 'MANDT'.
        SORT lt_dfies_tab_text BY position .

        LOOP AT lt_dfies_tab INTO DATA(ls_dfies_tab) WHERE keyflag = 'X'.
*          From , join table
          IF lv_fromtable IS INITIAL.
            lv_fromtable = |{ ls_shlp_tab-intdescr-texttab }~{ ls_dfies_tab-fieldname } = { ls_shlp_tab-intdescr-selmethod }~{ ls_dfies_tab-fieldname }|.

          ELSE.
            lv_fromtable = |{ lv_fromtable } AND { ls_shlp_tab-intdescr-texttab }~{ ls_dfies_tab-fieldname } = { ls_shlp_tab-intdescr-selmethod }~{ ls_dfies_tab-fieldname }|.
          ENDIF.
        ENDLOOP.
        lv_fromtable = ls_shlp_tab-intdescr-selmethod && | LEFT JOIN | && ls_shlp_tab-intdescr-texttab && | ON | && lv_fromtable.

      ENDIF.


    ENDIF.

*  ----------------------------------------------------------------------*
*     Query Fields
*  ----------------------------------------------------------------------*
    FREE lt_dfies_tab_text[].
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname        = lv_tabname_text
      TABLES
        dfies_tab      = lt_dfies_tab_text
      EXCEPTIONS
        not_found      = 1
        internal_error = 2.
    DELETE lt_dfies_tab_text WHERE fieldname CS '.' OR fieldname = 'MANDT'.
    SORT lt_dfies_tab_text BY position .

*  ----------------------------------------------------------------------*
*     filter
*  ----------------------------------------------------------------------*
    dynamic_filter(
      EXPORTING
        iv_filter    = cs_data-filter
        it_dfies_tab = lt_dfies_tab_text[] " Table Type for Structure DFIES
      IMPORTING
        ev_condition = lv_condition
    ).
    IF lv_condition_ad IS NOT INITIAL.
      IF lv_condition IS NOT INITIAL.
        lv_condition = |( { lv_condition } ) AND { lv_condition_ad } |.
      ELSE.
        lv_condition = lv_condition_ad.
      ENDIF.
    ENDIF.


*  ----------------------------------------------------------------------*
*     select fields name
*  ----------------------------------------------------------------------*
    DATA lv_cduplicates TYPE string.
    DATA lv_order TYPE string.

*   Search field data
    SORT ls_shlp_tab-fieldprop BY shlplispos.
    SORT ls_shlp_tab-fielddescr BY fieldname.
    CLEAR lv_order.
    LOOP AT ls_shlp_tab-fieldprop INTO DATA(ls_fieldprop) WHERE shlplispos <> 0.
      READ TABLE ls_shlp_tab-fielddescr INTO DATA(ls_fielddescr)
        WITH KEY  fieldname = ls_fieldprop-fieldname BINARY SEARCH.
      IF sy-subrc = 0.
        IF lv_order IS INITIAL.
          lv_order = |{ ls_fielddescr-tabname }~{ ls_fielddescr-fieldname }|.
        ENDIF.
        ls_comp-name = ls_fielddescr-fieldname.
        ls_comp-type ?= cl_abap_elemdescr=>describe_by_name(
                        |{ ls_fielddescr-tabname }-{ ls_fielddescr-fieldname }| ).
        APPEND ls_comp TO lt_comp.


        IF lv_selection_field IS INITIAL.
          lv_selection_field = |{ ls_fielddescr-tabname }~{ ls_fielddescr-fieldname }|.
*          LV_SELECTION_FIELD = |{ LS_FIELDDESCR-FIELDNAME }|.
        ELSE.
          lv_selection_field = lv_selection_field && |,| && |{ ls_fielddescr-tabname }~{ ls_fielddescr-fieldname }|.
*          LV_SELECTION_FIELD = LV_SELECTION_FIELD && |,| && |{ LS_FIELDDESCR-FIELDNAME }|.
        ENDIF.

*
*  *      From , join table
*        IF LV_FROMTABLE IS INITIAL.
*          LV_FROMTABLE = |{ LS_DD03L-TABNAME }~{ LS_FIELDDESCR-FIELDNAME } = { LV_TABNAME_TEXT }~{ LS_FIELDDESCR-FIELDNAME }|.
*
*        ELSE.
*          LV_FROMTABLE = |{ LV_FROMTABLE } AND { LS_DD03L-TABNAME }~{ LS_DD03L-FIELDNAME } = { LV_TABNAME_TEXT }~{ LS_DD03L-FIELDNAME }|.
*        ENDIF.
      ENDIF.
    ENDLOOP.

*  ----------------------------------------------------------------------*
*     Declare dynamic table
*  ----------------------------------------------------------------------*
    IF lv_fromtable IS INITIAL.
      lv_fromtable = lv_tabname_text.
    ENDIF.
    IF lv_selection_field IS INITIAL.
      lv_selection_field = '*'.
    ENDIF.

    IF <lft_table_rs> IS NOT ASSIGNED.
      IF lt_comp[] IS NOT INITIAL.
        TRY.
            lr_type_struct = cl_abap_structdescr=>create( p_components = lt_comp ).
            lr_type_table = cl_abap_tabledescr=>create( lr_type_struct ).
            CREATE DATA: lr_data_tab TYPE HANDLE lr_type_table.
            ASSIGN: lr_data_tab->* TO <lft_table_rs>.
          CATCH cx_root .
            RETURN.
        ENDTRY.

      ELSEIF lv_tabname_text IS NOT INITIAL.
        CREATE DATA lo_result_ref TYPE STANDARD TABLE OF (lv_tabname_text).
        ASSIGN lo_result_ref->* TO <lft_table_rs>.
      ENDIF.
    ENDIF.

    READ TABLE lt_dfies_tab_text[] INTO DATA(ls_tab_text)
      WITH KEY domname = 'SPRAS'.
    IF sy-subrc = 0.
      IF lv_condition IS INITIAL.
        lv_condition = |{ ls_tab_text-tabname }~{ ls_tab_text-fieldname } = 'E'|.
      ELSE.

        lv_condition = |( { lv_condition } ) AND { ls_tab_text-tabname }~{ ls_tab_text-fieldname } = 'E'|.
      ENDIF.
    ENDIF.

    TRY .
        DATA lv_skip TYPE i.
        DATA lv_top TYPE i.
        lv_top = cs_data-top.
        lv_skip = cs_data-skip.
        IF lv_top IS INITIAL.
          lv_top = 5000.
          lv_skip = 0.
        ENDIF.
*      SELECT *
        SELECT DISTINCT (lv_selection_field)
          FROM (lv_fromtable)
          WHERE (lv_condition)
          ORDER BY (lv_order)
          INTO TABLE @<lft_table_rs>
          OFFSET @lv_skip
          UP TO @lv_top ROWS.
      CATCH cx_root INTO DATA(lo_root).
        RETURN.
    ENDTRY.

*----------------------------------------------------------------------*
*   Merge data
*----------------------------------------------------------------------*
    dynamic_merge_data(
      EXPORTING
        it_data          = <lft_table_rs>
        it_dfies_tab     = lt_dfies_tab_text     " Table Type for Structure DFIES
        is_data          = cs_data
        iv_domname_input = lv_domname_ip " Domain name
      IMPORTING
        et_mddynamic     = cs_data-to_mddynamic
    ).

  ENDMETHOD.


  METHOD dynamic_filter.
    DATA:
      lv_value   TYPE string,
      lv_string  TYPE string,
      lo_data    TYPE REF TO data,
      lv_routine TYPE convexit
      .
    IF iv_filter IS NOT INITIAL.
      LOOP AT it_dfies_tab INTO DATA(lS_DFIES_TAB_TEXT). " WHERE FIELDNAME <> CS_DATA-FIELDNAME.

        "Convert data to external
        lv_value = iv_filter.
*      lv_value = LS_FILTER-LOW.

        lv_string = |{ lS_DFIES_TAB_TEXT-tabname }-{ lS_DFIES_TAB_TEXT-fieldname }|.
        CREATE DATA lo_data TYPE (lv_string).
        ASSIGN lo_data->* TO FIELD-SYMBOL(<lFS_FIELDDATA>).
        DESCRIBE FIELD <lFS_FIELDDATA> .
        DESCRIBE FIELD <lFS_FIELDDATA> TYPE DATA(lv_type) EDIT MASK DATA(lv_mask) OUTPUT-LENGTH DATA(lv_maxlength_OUT) LENGTH DATA(lv_length) IN CHARACTER MODE.
        "check date
        IF lv_type = 'D'.
          DATA lv_DATE TYPE sy-datum.
          CLEAR lv_DATE.
          TRY .
              lv_DATE = lv_value.
            CATCH cx_root.

          ENDTRY.

          CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
            EXPORTING
              date                      = lv_DATE
            EXCEPTIONS
              plausibility_check_failed = 1.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.
        ENDIF.

        "convert to internal
        IF lv_mask IS NOT INITIAL
        AND strlen( lv_value ) <= lv_maxlength_OUT.
          SHIFT lv_mask LEFT BY 2 PLACES.
          lv_routine = lv_mask.
          TRY .
              /simple/cl_search=>call_conversion_routine(
                EXPORTING
                  iv_routine  = lv_routine
                  iv_is_input = abap_true
                CHANGING
                  cv_value    = lv_value ).
            CATCH cx_root INTO DATA(lo_root).

          ENDTRY.
        ENDIF.

        IF strlen( lv_value ) <= lv_maxlength_OUT
        AND strlen( lv_value ) <= lv_length.
          IF lv_type = 'C'.
            IF ev_condition IS  INITIAL.
              ev_condition = |UPPER( { lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } ) = '{ lv_value CASE = UPPER }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR UPPER( { lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } ) = '{ lv_value CASE = UPPER }'|.
            ENDIF.

          ELSE.
            IF ev_condition IS  INITIAL.
              ev_condition = |{ lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } = '{ lv_value }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR { lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } = '{ lv_value }'|.
            ENDIF.
          ENDIF.

        ENDIF.
        lv_value = |%{ lv_value }%|.
        IF strlen( lv_value ) <= lv_maxlength_OUT
        AND strlen( lv_value ) <= lv_length.
          IF lv_type = 'C'.
            IF ev_condition IS  INITIAL.
              ev_condition = |UPPER( { lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } ) LIKE '{ lv_value CASE = UPPER }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR UPPER( { lS_DFIES_TAB_TEXT-tabname }~{ lS_DFIES_TAB_TEXT-fieldname } ) LIKE '{ lv_value CASE = UPPER }'|.
            ENDIF.

***        ELSE.
***          IF EV_CONDITION IS  INITIAL.
***            EV_CONDITION = |{ lS_DFIES_TAB_TEXT-TABNAME }~{ lS_DFIES_TAB_TEXT-FIELDNAME } LIKE '{ lv_value }'|.
***          ELSE.
***            EV_CONDITION = |{ EV_CONDITION } OR { lS_DFIES_TAB_TEXT-TABNAME }~{ lS_DFIES_TAB_TEXT-FIELDNAME } LIKE '{ lv_value }'|.
***          ENDIF.
          ENDIF.


        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD dynamic_merge_data.

    DATA ls_mddynamic LIKE LINE OF et_mddynamic[].
    DATA lv_value TYPE string.
    DATA lv_routine TYPE convexit.
    DATA lt_dfies_tab    TYPE STANDARD TABLE OF dfies.
    DATA ls_mddynamic_df    LIKE LINE OF is_data-to_mddynamic[].
    MOVE-CORRESPONDING is_data TO  ls_mddynamic_df.
    LOOP AT it_data ASSIGNING FIELD-SYMBOL(<lfs_data_input>).
      ls_mddynamic = ls_mddynamic_df.

      "merge text
      LOOP AT it_dfies_tab INTO DATA(ls_dfies_tab_text). " WHERE FIELDNAME <> CS_DATA-FIELDNAME.
        ASSIGN COMPONENT ls_dfies_tab_text-fieldname OF STRUCTURE <lfs_data_input>
          TO FIELD-SYMBOL(<lfs_field_value>).
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        "Convert data to external
        lv_value = <lfs_field_value>.
        DESCRIBE FIELD <lfs_field_value> EDIT MASK DATA(lv_mask).
        IF lv_mask IS NOT INITIAL.
          SHIFT lv_mask LEFT BY 2 PLACES.
          lv_routine = lv_mask.

          /simple/cl_search=>call_conversion_routine(
            EXPORTING
              iv_routine  = lv_routine
              iv_is_input = abap_false
            CHANGING
              cv_value    = lv_value ).
        ENDIF.

        CONDENSE lv_value.
        SHIFT lv_value RIGHT DELETING TRAILING space.

        "Language field
        FREE lt_dfies_tab[].
        CALL FUNCTION 'DDIF_FIELDINFO_GET'
          EXPORTING
            tabname        = ls_dfies_tab_text-tabname
            fieldname      = ls_dfies_tab_text-fieldname
          TABLES
            dfies_tab      = lt_dfies_tab
*           FIXED_VALUES   = FIXED_VALUES
          EXCEPTIONS
            not_found      = 1
            internal_error = 2.
        READ TABLE lt_dfies_tab INTO DATA(ls_dfies_tab) INDEX 1.
        IF sy-subrc = 0.
          "Get output key
          IF ls_mddynamic-value IS INITIAL
          AND ( ls_mddynamic_df-fieldname = ls_dfies_tab_text-fieldname
            OR iv_domname_input = ls_dfies_tab-domname ).
            ls_mddynamic-value  = lv_value.
            CONTINUE.

            "Language
          ELSEIF ls_dfies_tab-domname = 'SPRAS'
          AND ls_dfies_tab_text-keyflag = 'X'.
            ls_mddynamic-language = lv_value.
            CONTINUE.
          ENDIF.
        ENDIF.

*      IF lS_DFIES_TAB_TEXT-KEYFLAG = 'X'.
        IF ls_mddynamic-description IS INITIAL.
          ls_mddynamic-description = lv_value.
        ELSE.
          ls_mddynamic-description = ls_mddynamic-description && | - | && lv_value.
        ENDIF.

*      ELSEIF lv_TEXT IS INITIAL.
*          lv_TEXT = lv_value.
*      ENDIF.
      ENDLOOP.

*    IF lv_TEXT IS NOT INITIAL.
*      IF LS_MDDYNAMIC-DESCRIPTION IS INITIAL.
*        LS_MDDYNAMIC-DESCRIPTION = lv_TEXT.
*      ELSE.
*        LS_MDDYNAMIC-DESCRIPTION = LS_MDDYNAMIC-DESCRIPTION && | - | && lv_TEXT.
*      ENDIF.
*    ENDIF.

      APPEND ls_mddynamic TO et_mddynamic.
    ENDLOOP.

    SORT et_mddynamic[].
    DELETE ADJACENT DUPLICATES FROM et_mddynamic COMPARING tablename fieldname language value.
  ENDMETHOD.
ENDCLASS.
