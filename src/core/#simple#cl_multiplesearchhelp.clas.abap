CLASS /simple/cl_multiplesearchhelp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ts_multiplesearchhelptype,
        multiplekey TYPE c LENGTH 20,
        languagekey TYPE string,
      END OF ts_multiplesearchhelptype .

  types:
    t_DynamicF4Set_mapped_late TYPE TABLE FOR MAPPED LATE /SIMPLE/DynamicF4Set .
    TYPES:
    tt_multiplesearchhelptype TYPE STANDARD TABLE OF ts_multiplesearchhelptype .
    TYPES:
      BEGIN OF ts_text_element,
        artifact_name        TYPE c LENGTH 40,       " technical name
        artifact_type        TYPE c LENGTH 4,
        parent_artifact_name TYPE c LENGTH 40, " technical name
        parent_artifact_type TYPE c LENGTH 4,
        text_symbol          TYPE textpoolky,
      END OF ts_text_element .
    TYPES:
        tt_text_elements TYPE STANDARD TABLE OF ts_text_element WITH KEY text_symbol .
    TYPES:
      BEGIN OF ts_searchhelpfieldtype,
        multiplekey        TYPE c LENGTH 20,
        requestkey         TYPE c LENGTH 20,
        dummykey           TYPE c LENGTH 20,
        tablename          TYPE string,
        technicalfieldname TYPE string,
        fieldname          TYPE string,
        fieldtype          TYPE string,
      END OF ts_searchhelpfieldtype .
    TYPES:
        tt_searchhelpfieldtype TYPE STANDARD TABLE OF ts_searchhelpfieldtype .
    TYPES:
      BEGIN OF ts_searchhelprequesttype,
        multiplekey TYPE c LENGTH 20,
        requestkey  TYPE c LENGTH 20,
        mdtablename TYPE string,
        type        TYPE string,
      END OF ts_searchhelprequesttype .
    TYPES:
        tt_searchhelprequesttype TYPE STANDARD TABLE OF ts_searchhelprequesttype .
    TYPES:
      BEGIN OF ts_searchhelpresulttype,
        multiplekey TYPE c LENGTH 20,
        requestkey  TYPE c LENGTH 20,
        value       TYPE string,
      END OF ts_searchhelpresulttype .
    TYPES:
  tt_searchhelpresulttype TYPE STANDARD TABLE OF ts_searchhelpresulttype .
    TYPES:
      BEGIN OF ts_searchhelptype,
        multiplekey  TYPE c LENGTH 20,
        requestkey   TYPE c LENGTH 20,
        dummykey     TYPE c LENGTH 20,
        top          TYPE string,
        skip         TYPE string,
        fromjoin     TYPE string,
        whereclause  TYPE string,
        selectfields TYPE string,
        mdtablename  TYPE string,
      END OF ts_searchhelptype .
    TYPES:
  tt_searchhelptype TYPE STANDARD TABLE OF ts_searchhelptype .
    TYPES:
      BEGIN OF ts_mdarticleconfigcharc,
        variantnumber    TYPE matnr,
        variantid        TYPE n LENGTH 4,
        class            TYPE klasse_d,
        classtype        TYPE klassenart,
        characteristic_1 TYPE atnam,
        value_1          TYPE atwrt,
        characteristic_2 TYPE atnam,
        value_2          TYPE atwrt,
        characteristic_3 TYPE atnam,
        value_3          TYPE atwrt,
      END OF ts_mdarticleconfigcharc .
    TYPES:
  tt_mdarticleconfigcharc TYPE STANDARD TABLE OF ts_mdarticleconfigcharc .
*   LD-0113 - 20231110 - Danh Tran - Start - Del
*    TYPES:
*      BEGIN OF ts_dynamicf4,
*        tablename TYPE c LENGTH 30,
*        fieldname TYPE c LENGTH 30,
*        filter    TYPE string,
*        top       TYPE int8,
*        skip      TYPE int8,
*      END OF ts_dynamicf4 .
*    TYPES:
*  tt_dynamicf4 TYPE STANDARD TABLE OF ts_dynamicf4 .
*    TYPES:
*      BEGIN OF ts_mddynamic,
*        tablename   TYPE c LENGTH 30,
*        fieldname   TYPE c LENGTH 30,
*        filter      TYPE string,
*        language    TYPE c LENGTH 2,
*        value       TYPE string,
*        description TYPE string,
*      END OF ts_mddynamic .
*    TYPES:
*  tt_mddynamic TYPE STANDARD TABLE OF ts_mddynamic .
*   LD-0113 - 20231110 - Danh Tran - End - Del
    TYPES tt_mddynamic TYPE STANDARD TABLE OF /SIMPLE/MDDYNAMICSET .   "LD-0113 - 20231110 - Danh Tran - Ins

    TYPES:
      BEGIN OF gty_searchhelp.
        INCLUDE TYPE /simple/i_searchhelp.
    TYPES  to_searchhelpfield TYPE STANDARD TABLE OF /simple/i_searchhelpfield WITH DEFAULT KEY.
    TYPES END OF gty_searchhelp .
    TYPES:
      BEGIN OF gty_searchhelprequest.
        INCLUDE TYPE ts_searchhelprequesttype. " /simple/i_searchhelprequest
    TYPES  to_searchhelp TYPE STANDARD TABLE OF gty_searchhelp WITH DEFAULT KEY.
    TYPES  to_searchresult TYPE STANDARD TABLE OF  ts_searchhelpresulttype WITH DEFAULT KEY. " /simple/i_searchhelpresult
    TYPES END OF gty_searchhelprequest .
    TYPES:
      BEGIN OF gty_multiplesearchhelp.
        INCLUDE TYPE /simple/i_multiplesearchhelp.
    TYPES  to_searchhelprequest TYPE STANDARD TABLE OF gty_searchhelprequest WITH DEFAULT KEY.
    TYPES END OF gty_multiplesearchhelp .

*   LD-0113 - 20231110 - Danh Tran - Start - Del
*    TYPES:
*      BEGIN OF gty_dynamicf4.
*        INCLUDE TYPE ts_dynamicf4.
*    TYPES  to_mddynamic TYPE STANDARD TABLE OF  ts_mddynamic WITH DEFAULT KEY.
*    TYPES END OF gty_dynamicf4 .
*   LD-0113 - 20231110 - Danh Tran - End - Del


*   LD-0113 - 20231110 - Danh Tran - Start - Ins
    TYPES:
      BEGIN OF gty_dynamicf4,
        CID                    type STRING.
        INCLUDE TYPE /SIMPLE/DynamicF4Set.
    TYPES  to_mddynamic TYPE STANDARD TABLE OF  /SIMPLE/MDDYNAMICSET WITH DEFAULT KEY.
    TYPES END OF gty_dynamicf4 .
*   LD-0113 - 20231110 - Danh Tran - End - Ins
    TYPES:
      BEGIN OF gty_searchhelpresult.
        INCLUDE TYPE ts_searchhelpresulttype. " /simple/i_searchhelpresult
  TYPES END OF gty_searchhelpresult .
    TYPES:
      gty_searchhelpresult_tab TYPE STANDARD TABLE OF gty_searchhelpresult WITH DEFAULT KEY .
    TYPES:
      gty_multiplesearchhelp_tab TYPE STANDARD TABLE OF gty_multiplesearchhelp WITH DEFAULT KEY .
    TYPES:
      gty_searchhelprequest_tab TYPE STANDARD TABLE OF gty_searchhelprequest WITH DEFAULT KEY .

    METHODS set_multiple_search_help
      IMPORTING
        !it_multiplesearch TYPE gty_multiplesearchhelp .
    METHODS get_multiple_data
      RETURNING
        VALUE(rt_multiple) TYPE gty_multiplesearchhelp_tab .
    METHODS get_request_data
      RETURNING
        VALUE(rt_request) TYPE gty_searchhelprequest_tab .
    METHODS get_multiple_search_help
      EXPORTING
        !es_data         TYPE gty_multiplesearchhelp
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mdpaymentmethod
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mdrelationship
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mdrelationshiptype
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mddeliverypriority
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mdusrfldcombinat
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_f4_mdclasstextid
      IMPORTING
        !is_request      TYPE gty_searchhelprequest
      RETURNING
        VALUE(rt_result) TYPE gty_searchhelpresult_tab .
    METHODS get_dynamicf4
      CHANGING
        VALUE(cs_data) TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4 .
    METHODS dynamic_filter
      IMPORTING
        !iv_filter    TYPE any
        !it_dfies_tab TYPE dfies_tab
      EXPORTING
        !ev_condition TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA gs_data TYPE gty_multiplesearchhelp .

    METHODS get_dynamicf4_multiple_sh
      IMPORTING
        !ct_shlp_tab     TYPE shlp_desct
        !cv_tabname_text TYPE dd03l-tabname
        !cv_condition_ad TYPE string
      CHANGING
        !cs_data         TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4 .
    METHODS dynamic_merge_data
      IMPORTING
        !it_data          TYPE STANDARD TABLE
        !it_dfies_tab     TYPE dfies_tab
        !is_data          TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4
        !iv_domname_input TYPE domname
      EXPORTING
        !et_mddynamic     TYPE  tt_mddynamic .
ENDCLASS.



CLASS /SIMPLE/CL_MULTIPLESEARCHHELP IMPLEMENTATION.


  METHOD dynamic_filter.
    DATA:
      lv_value   TYPE string,
      lv_string  TYPE string,
      lo_data    TYPE REF TO data,
      lv_routine TYPE convexit
      .
    IF iv_filter IS NOT INITIAL.
      LOOP AT it_dfies_tab INTO DATA(ls_dfies_tab_text). " WHERE FIELDNAME <> CS_DATA-FIELDNAME.

        "LD-0118 - 20231115 - Danh Tran - Start - Ins
        "Skip checking for domain field
        IF  ls_dfies_tab_text-tabname   = 'DD07V'
        AND ( ls_dfies_tab_text-fieldname <> 'DOMVALUE_L'
        AND ls_dfies_tab_text-fieldname <> 'DDLANGUAGE'
        AND ls_dfies_tab_text-fieldname <> 'DDTEXT' )
        .
          CONTINUE.
        ENDIF.
        "LD-0118 - 20231115 - Danh Tran - End - Ins

        "Convert data to external
        lv_value = iv_filter.
*      lv_value = LS_FILTER-LOW.

        lv_string = |{ ls_dfies_tab_text-tabname }-{ ls_dfies_tab_text-fieldname }|.
        CREATE DATA lo_data TYPE (lv_string).
        ASSIGN lo_data->* TO FIELD-SYMBOL(<lfs_fielddata>).
        DESCRIBE FIELD <lfs_fielddata> .
        DESCRIBE FIELD <lfs_fielddata> TYPE DATA(lv_type) EDIT MASK DATA(lv_mask) OUTPUT-LENGTH DATA(lv_maxlength_out) LENGTH DATA(lv_length) IN CHARACTER MODE.
        "check date
        IF lv_type = 'D'.
          DATA lv_date TYPE sy-datum.
          CLEAR lv_date.
          TRY .
              lv_date = lv_value.
            CATCH cx_root.

          ENDTRY.

          CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
            EXPORTING
              date                      = lv_date
            EXCEPTIONS
              plausibility_check_failed = 1.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.
        ENDIF.

        "convert to internal
        IF lv_mask IS NOT INITIAL
        AND strlen( lv_value ) <= lv_maxlength_out.
          SHIFT lv_mask LEFT BY 2 PLACES.
          lv_routine = lv_mask.
          TRY .
              /simple/cl_search=>call_conversion_routine(
                EXPORTING
                  iv_routine  = lv_routine
                  iv_is_input = abap_true
                CHANGING
                  cv_value    = lv_value ).


              IF lv_value IS INITIAL. CONTINUE. ENDIF.  "LD-0118 - 20231115 - Danh Tran - Ins
            CATCH cx_root INTO DATA(lo_root).

          ENDTRY.
        ENDIF.

        IF strlen( lv_value ) <= lv_maxlength_out
        AND strlen( lv_value ) <= lv_length.
          IF lv_type = 'C'.
            IF ev_condition IS  INITIAL.
              ev_condition = |UPPER( { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } ) = '{ lv_value CASE = UPPER }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR UPPER( { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } ) = '{ lv_value CASE = UPPER }'|.
            ENDIF.

          ELSEIF lv_type <> 'N' OR ( lv_type = 'N' AND lv_value CO '0123456789' ).  "LD-0118 - 20231115 - Danh Tran - Mod

            IF ev_condition IS  INITIAL.
              ev_condition = |{ ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } = '{ lv_value }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } = '{ lv_value }'|.
            ENDIF.
          ENDIF.

        ENDIF.
        lv_value = |%{ lv_value }%|.
        IF strlen( lv_value ) <= lv_maxlength_out
        AND strlen( lv_value ) <= lv_length.
          IF lv_type = 'C'.
            IF ev_condition IS  INITIAL.
              ev_condition = |UPPER( { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } ) LIKE '{ lv_value CASE = UPPER }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR UPPER( { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } ) LIKE '{ lv_value CASE = UPPER }'|.
            ENDIF.

            "LD-0118 - 20231115 - Danh Tran - Start - Ins
          ELSEIF ( lv_type = 'N' AND lv_value CO '0123456789' ).
            IF ev_condition IS  INITIAL.
              ev_condition = |{ ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname } LIKE '{ lv_value }'|.
            ELSE.
              ev_condition = |{ ev_condition } OR { ls_dfies_tab_text-tabname }~{ ls_dfies_tab_text-fieldname }  LIKE '{ lv_value }'|.
            ENDIF.
            "LD-0118 - 20231115 - Danh Tran - End - Ins
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

      APPEND ls_mddynamic TO et_mddynamic[].
    ENDLOOP.

    SORT et_mddynamic[].
    DELETE ADJACENT DUPLICATES FROM et_mddynamic[] COMPARING tablename fieldname filter language value.
  ENDMETHOD.


  METHOD get_dynamicf4.
    DATA ls_result_df LIKE LINE OF cs_data-to_mddynamic[].
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

    FREE cs_data-to_mddynamic[].
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

      "LD-0118 - 20231115 - Danh Tran - Start - Ins
      IF ls_shlp-SHLPTYPE = 'FV'.
        cs_data-fieldname = 'DOMVALUE_L'.
        ls_shlp_tab-intdescr-texttab = 'DD07V'.
        LS_SHLP_TAB-FIELDPROP[] = VALUE #(
        ( fieldname = 'DOMVALUE_L' shlpinput = 'X' shlpoutput = 'X' shlplispos = '1'  )
        ( fieldname = 'DDLANGUAGE' shlplispos = '2'   )
        ( fieldname = 'DDTEXT' shlplispos = '3'   )
         ).
        LS_SHLP_TAB-FIELDDESCR[] = VALUE #(
        ( tabname = ls_shlp_tab-intdescr-texttab fieldname = 'DOMVALUE_L' )
        ( tabname = ls_shlp_tab-intdescr-texttab fieldname = 'DDLANGUAGE' )
        ( tabname = ls_shlp_tab-intdescr-texttab fieldname = 'DDTEXT' )
         ).
      ENDIF.
      "LD-0118 - 20231115 - Danh Tran - End - Ins

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
    "LD-0118 - 20231115 - Danh Tran - Start - Ins
    IF ls_shlp-SHLPTYPE = 'FV'.
      IF lv_condition IS INITIAL.
        lv_condition = |DD07V~DOMNAME = { ls_shlp-shlpname }|.
      ELSE.

        lv_condition = |( { lv_condition } ) AND DD07V~DOMNAME = '{ ls_shlp-shlpname }'|.
      ENDIF.
    ENDIF.
    "LD-0118 - 20231115 - Danh Tran - End - Ins

    TRY .
        DATA lv_skip TYPE i.
        DATA lv_top TYPE i.
        lv_top = cs_data-top.
        lv_skip = cs_data-skip.
        IF lv_top IS INITIAL.
          lv_top = 5000.
          lv_skip = 1.
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
        et_mddynamic     = cs_data-to_mddynamic[]
    ).
  ENDMETHOD.


  METHOD get_dynamicf4_multiple_sh.
  ENDMETHOD.


  METHOD get_f4_mdclasstextid.
    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.
    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

*--------------------------------------------------------------------*
    DATA(lt_fieldname) = VALUE ty_fieldname( ( `ClassType` )
                                             ( `IDTextType` )
                                             ( `Locale` )
                                             ( `Description` ) ).
*--------------------------------------------------------------------*
    SELECT
      klart AS classtype,
      spras AS locale,
      txidb AS idtexttype, txida,
*      concat( txidb, txida ) AS idtexttype,
      txart AS description
      FROM tclxt
      WHERE klart = '026'
      INTO TABLE @DATA(lt_data).

*--------------------------------------------------------------------*
    LOOP AT lt_data INTO DATA(ls_data).
      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_data TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
          IF to_upper( ls_fieldname ) = 'LOCALE'.
            CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
              EXPORTING
                input  = lv_string
              IMPORTING
                output = lv_string.
          ELSEIF to_upper( ls_fieldname ) = 'IDTEXTTYPE'.
            CONCATENATE ls_data-idtexttype ls_data-txida INTO lv_string.
          ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.

      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mddeliverypriority.
    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `DeliveryPriority` )
                                             ( `InternalValue` )
                                             ( `OrderPriority` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    SELECT tprio~lprio AS deliverypriority,
           ltrim( tprio~lprio, '0' ) AS internalvalue,
           spras                  AS locale,
           aprio                  AS orderpriority,
           bezei                  AS description
      FROM tprio
      LEFT OUTER JOIN tprit ON tprio~lprio = tprit~lprio
      INTO TABLE @DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data).
      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_data TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
          IF ls_fieldname = 'Locale'.
            CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
              EXPORTING
                input  = lv_string
              IMPORTING
                output = lv_string.
          ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.

      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mdpaymentmethod.

    TYPES:
      BEGIN OF ty_entity,
        countrykey          TYPE string,
        companycode         TYPE string,
        paymentmethod       TYPE string,
        paymentmethodin     TYPE string,
        incomingpaymentname TYPE string,
        paymentmethodout    TYPE string,
        outgoingpaymentname TYPE string,
      END OF ty_entity.

    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      ls_entity TYPE ty_entity,
      lt_entity TYPE TABLE OF ty_entity.

    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `CountryKey` )
                                             ( `CompanyCode` )
                                             ( `PaymentMethod` )
                                             ( `PaymentMethodIn` )
                                             ( `IncomingPaymentName` )
                                             ( `PaymentMethodOut` )
                                             ( `OutgoingPaymentName` ) ).

    SELECT t042z_in~land1  AS countrykey,
           t042e~zbukr     AS companycode,
           t042z_in~zlsch  AS paymentmethod,
           t042z_in~text1  AS description
      FROM t042z AS t042z_in
      INNER JOIN t042e AS t042e ON t042z_in~zlsch = t042e~zlsch
      INTO TABLE @DATA(lt_payment_in)
      WHERE t042z_in~xeinz = 'X'.

    SELECT t042z_in~land1  AS countrykey,
           t042e~zbukr     AS companycode,
           t042z_in~zlsch  AS paymentmethod,
           t042z_in~text1  AS description
      FROM t042z AS t042z_in
      INNER JOIN t042e AS t042e ON t042z_in~zlsch = t042e~zlsch
      INTO TABLE @DATA(lt_payment_out)
      WHERE t042z_in~xeinz = ''.

    SORT lt_payment_in BY countrykey companycode.
    SORT lt_payment_out BY countrykey companycode.

    LOOP AT lt_payment_in INTO DATA(ls_payment_in).
      LOOP AT lt_payment_out INTO DATA(ls_payment_out) WHERE countrykey = ls_payment_in-countrykey
                                                         AND companycode = ls_payment_in-companycode.
        ls_entity-countrykey          = ls_payment_in-countrykey.
        ls_entity-companycode         = ls_payment_in-companycode.
        ls_entity-paymentmethod       = ls_payment_in-paymentmethod && ls_payment_out-paymentmethod.
        ls_entity-paymentmethodin     = ls_payment_in-paymentmethod.
        ls_entity-incomingpaymentname = ls_payment_in-description.
        ls_entity-paymentmethodout    = ls_payment_out-paymentmethod.
        ls_entity-outgoingpaymentname = ls_payment_out-description.
        APPEND ls_entity TO lt_entity.
        CLEAR ls_entity.
      ENDLOOP.
    ENDLOOP.

    LOOP AT lt_payment_in INTO ls_payment_in.
      ls_entity-countrykey          = ls_payment_in-countrykey.
      ls_entity-companycode         = ls_payment_in-companycode.
      ls_entity-paymentmethod       = ls_payment_in-paymentmethod.
      ls_entity-paymentmethodin     = ls_payment_in-paymentmethod.
      ls_entity-incomingpaymentname = ls_payment_in-description.
*    ls_entity-PaymentMethodOut    = ls_payment_out-paymentmethod.
*    ls_entity-OutgoingPaymentName = ls_payment_out-description.
      APPEND ls_entity TO lt_entity.
      CLEAR ls_entity.
    ENDLOOP.

    LOOP AT lt_payment_out INTO ls_payment_out.
      ls_entity-countrykey          = ls_payment_out-countrykey.
      ls_entity-companycode         = ls_payment_out-companycode.
      ls_entity-paymentmethod       = ls_payment_out-paymentmethod.
*    ls_entity-PaymentMethodIn     = ls_payment_in-paymentmethod.
*    ls_entity-IncomingPaymentName = ls_payment_in-description.
      ls_entity-paymentmethodout    = ls_payment_out-paymentmethod.
      ls_entity-outgoingpaymentname = ls_payment_out-description.
      APPEND ls_entity TO lt_entity.
      CLEAR ls_entity.
    ENDLOOP.

    LOOP AT lt_entity INTO ls_entity.
      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_entity TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
          IF ls_fieldname = 'Locale'.
            CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
              EXPORTING
                input  = lv_string
              IMPORTING
                output = lv_string.
          ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.
      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mdrelationship.

    TYPES:
      BEGIN OF ty_description,
        reltyp  TYPE bu_reltyp,
        bez50   TYPE bu_bez50,
        bez50_2 TYPE bu_bez50,
        laiso   TYPE laiso,
      END OF ty_description.
    TYPES:
      BEGIN OF ts_xsimplexmdrelationshiptype,
        businesspartnercategory TYPE string,
        relationshipcategory    TYPE string,
        differentiationtype     TYPE string,
        locale                  TYPE string,
        description             TYPE string,
      END OF ts_xsimplexmdrelationshiptype .

    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      lt_description   TYPE STANDARD TABLE OF ty_description,
      lv_from          TYPE bu_boolean,
      lv_to            TYPE bu_boolean,
      ls_directed_type TYPE burs_relationship-directed_type,
      ls_reltyp_data   TYPE bus_reltyp_data,
      ls_reltyp_data2  TYPE bus_reltyp_data,
      lt_reltyp_data   TYPE STANDARD TABLE OF bus_reltyp_data,
      lt_reltyp_data2  TYPE STANDARD TABLE OF bus_reltyp_data,
      lt_tbz0a         TYPE TABLE OF tbz0a,
      ls_tbz0a         TYPE tbz0a,
      lt_tb920         TYPE TABLE OF tb920.

    DATA gc_no_xrf TYPE bu_xrf VALUE space.
*    DATA ls_reltyp_data TYPE bus_reltyp_data.

    DATA:
      ls_entityset TYPE ts_xsimplexmdrelationshiptype,
      lt_entityset TYPE TABLE OF ts_xsimplexmdrelationshiptype.

    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `BusinessPartnerCategory` )
                                             ( `RelationshipCategory` )
                                             ( `DifferentiationType` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    "-- Get relation ship category description
    SELECT t1~reltyp,
           t1~bez50,
           t1~bez50_2,
           t2~laiso
      FROM tbz9a AS t1
     INNER JOIN t002 AS t2
        ON t1~spras = t2~spras
      INTO TABLE @lt_description.

    TRY.
        CALL FUNCTION 'BUS_RELTYP_GET_MULTIPLE'
          EXPORTING
            i_xrf         = gc_no_xrf
          TABLES
            t_reltyp_data = lt_reltyp_data
            t_roles       = lt_tb920.

        DELETE lt_reltyp_data WHERE xsuppress = 'X'.

        CALL FUNCTION 'BDT_TBZ0A_GET'
          EXPORTING
            iv_objap             = 'BUPR'
          TABLES
            et_tbz0a             = lt_tbz0a
          EXCEPTIONS
            not_found_with_objap = 1
            OTHERS               = 2.
        IF sy-subrc <> 0.
        ENDIF.

        LOOP  AT lt_reltyp_data   INTO  ls_reltyp_data .
          READ  TABLE   lt_tbz0a  INTO  ls_tbz0a
                        WITH KEY  appli  =   ls_reltyp_data-appli_tab.
          IF   sy-subrc        = 0
          AND  ls_tbz0a-xaktv  IS  INITIAL.
            DELETE  lt_reltyp_data .
          ENDIF.
        ENDLOOP.

        "   Sort table by position number (the filled ones first)
        ls_reltyp_data-posnr = ls_reltyp_data-posnr_2 = '999'.
        MODIFY lt_reltyp_data FROM ls_reltyp_data TRANSPORTING posnr
               WHERE posnr IS INITIAL.
        MODIFY lt_reltyp_data FROM ls_reltyp_data TRANSPORTING posnr_2
               WHERE posnr_2 IS INITIAL.

* For directed types we need two entries, both having their data
* (sort number and description) in the same fields for both directions
* (POSNR and BEZ50). This is to allow sorting both directions
* correctly.

        LOOP AT lt_reltyp_data INTO ls_reltyp_data WHERE xdirection = 'X'.
          ls_reltyp_data2 = ls_reltyp_data.
          ls_reltyp_data2-posnr = ls_reltyp_data2-posnr_2.
          ls_reltyp_data2-bez50 = ls_reltyp_data2-bez50_2.
          CLEAR: ls_reltyp_data2-xorga_p1, ls_reltyp_data2-xpers_p1,
                 ls_reltyp_data2-xgrou_p1.
          APPEND ls_reltyp_data2 TO lt_reltyp_data2.
          CLEAR: ls_reltyp_data-xorga_p2, ls_reltyp_data-xpers_p2,
                 ls_reltyp_data-xgrou_p2.
          MODIFY lt_reltyp_data FROM ls_reltyp_data.
        ENDLOOP.

        CLEAR ls_reltyp_data2.

        APPEND LINES OF lt_reltyp_data2 TO lt_reltyp_data.

        SORT lt_reltyp_data BY posnr bez50 AS TEXT.

        SORT lt_reltyp_data BY reltyp.

        LOOP AT lt_reltyp_data INTO ls_reltyp_data.
          ls_entityset-differentiationtype = ls_reltyp_data-dftyp.
          IF ls_reltyp_data-xdirection IS INITIAL.
            IF ls_reltyp_data-xpers_p1 = 'X'.
              ls_entityset-businesspartnercategory = '1'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              CONCATENATE 'N' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory. "Ins by Danh Tran 04.07.2022
              LOOP AT lt_description INTO DATA(ls_description)
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xorga_p1 = 'X'.
              ls_entityset-businesspartnercategory = '2'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              CONCATENATE 'N' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory. "Ins by Danh Tran 04.07.2022
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xgrou_p1 = 'X'.
              ls_entityset-businesspartnercategory = '3'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              CONCATENATE 'N' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory. "Ins by Danh Tran 04.07.2022
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.

          ELSE.
            IF ls_reltyp_data-xpers_p1 = 'X'.
              ls_entityset-businesspartnercategory = '1'.
              CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xpers_p2 = 'X'.
              ls_entityset-businesspartnercategory = '1'.
              CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50_2.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xorga_p1 = 'X'.
              ls_entityset-businesspartnercategory = '2'.
              CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xorga_p2 = 'X'.
              ls_entityset-businesspartnercategory = '2'.
              CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50_2.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xgrou_p1 = 'X'.
              ls_entityset-businesspartnercategory = '3'.
              CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xgrou_p2 = 'X'.
              ls_entityset-businesspartnercategory = '3'.
              CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50_2.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO lt_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.
    ENDTRY.

    SORT lt_entityset BY businesspartnercategory relationshipcategory locale.
    DELETE ADJACENT DUPLICATES FROM lt_entityset COMPARING businesspartnercategory relationshipcategory locale.

    LOOP AT lt_entityset INTO ls_entityset.
      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_entityset TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
*        IF ls_fieldname = 'Locale'.
*          CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
*            EXPORTING
*              input  = lv_string
*            IMPORTING
*              output = lv_string.
*        ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.
      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_f4_mdrelationshiptype.
    TYPES:
      BEGIN OF ty_description,
        reltyp  TYPE bu_reltyp,
        relkind TYPE bu_relkind,
        text30  TYPE bu_bez30,
        laiso   TYPE laiso,
      END OF ty_description.
    TYPES:
      BEGIN OF ts_xsimplexmdrelationshiptypet,
        relationshipcategory TYPE string,
        relationshiptype     TYPE string,
        locale               TYPE string,
        description          TYPE string,
      END OF ts_xsimplexmdrelationshiptypet.

    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      lt_description   TYPE STANDARD TABLE OF ty_description,
      lv_from          TYPE bu_boolean,
      lv_to            TYPE bu_boolean,
      ls_directed_type TYPE burs_relationship-directed_type,
      ls_reltyp_data   TYPE bus_reltyp_data,
      ls_reltyp_data2  TYPE bus_reltyp_data,
      lt_temp          TYPE STANDARD TABLE OF bus_reltyp_data,
      lt_reltyp_data   TYPE STANDARD TABLE OF bus_reltyp_data,
      lt_reltyp_data2  TYPE STANDARD TABLE OF bus_reltyp_data,
      lt_tbz0a         TYPE TABLE OF tbz0a,
      ls_tbz0a         TYPE tbz0a,
      lt_tb920         TYPE TABLE OF tb920.

    DATA gc_no_xrf TYPE bu_xrf VALUE space.
*    DATA ls_reltyp_data TYPE bus_reltyp_data.

    DATA:
      ls_entityset TYPE ts_xsimplexmdrelationshiptypet,
      lt_entityset TYPE TABLE OF ts_xsimplexmdrelationshiptypet.

    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `RelationshipCategory` )
                                             ( `RelationshipType` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    "-- Get relation ship category description
    SELECT t1~reltyp,
           t1~relkind,
           t2~text30,
           t3~laiso
      FROM tb905 AS t1
     INNER JOIN tb905t AS t2
        ON t1~relkind = t2~relkind
     INNER JOIN t002 AS t3
        ON t2~spras = t3~spras
      INTO TABLE @lt_description.

    TRY.
        CALL FUNCTION 'BUS_RELTYP_GET_MULTIPLE'
          EXPORTING
            i_xrf         = gc_no_xrf
          TABLES
            t_reltyp_data = lt_reltyp_data
            t_roles       = lt_tb920.

        DELETE lt_reltyp_data WHERE xsuppress = 'X'.

        CALL FUNCTION 'BDT_TBZ0A_GET'
          EXPORTING
            iv_objap             = 'BUPR'
          TABLES
            et_tbz0a             = lt_tbz0a
          EXCEPTIONS
            not_found_with_objap = 1
            OTHERS               = 2.
        IF sy-subrc <> 0.
        ENDIF.

        LOOP  AT lt_reltyp_data   INTO  ls_reltyp_data .
          READ  TABLE   lt_tbz0a  INTO  ls_tbz0a
                        WITH KEY  appli  =   ls_reltyp_data-appli_tab.
          IF   sy-subrc        = 0
          AND  ls_tbz0a-xaktv  IS  INITIAL.
            DELETE  lt_reltyp_data .
          ENDIF.
        ENDLOOP.

        "   Sort table by position number (the filled ones first)
        ls_reltyp_data-posnr = ls_reltyp_data-posnr_2 = '999'.
        MODIFY lt_reltyp_data FROM ls_reltyp_data TRANSPORTING posnr
               WHERE posnr IS INITIAL.
        MODIFY lt_reltyp_data FROM ls_reltyp_data TRANSPORTING posnr_2
               WHERE posnr_2 IS INITIAL.

*   For directed types we need two entries, both having their data
*   (sort number and description) in the same fields for both directions
*   (POSNR and BEZ50). This is to allow sorting both directions
*   correctly.

        LOOP AT lt_reltyp_data INTO ls_reltyp_data WHERE xdirection = 'X'.
          ls_reltyp_data2 = ls_reltyp_data.
          ls_reltyp_data2-posnr = ls_reltyp_data2-posnr_2.
          ls_reltyp_data2-bez50 = ls_reltyp_data2-bez50_2.
          CLEAR: ls_reltyp_data2-xorga_p1, ls_reltyp_data2-xpers_p1,
                 ls_reltyp_data2-xgrou_p1.
          APPEND ls_reltyp_data2 TO lt_reltyp_data2.
          CLEAR: ls_reltyp_data-xorga_p2, ls_reltyp_data-xpers_p2,
                 ls_reltyp_data-xgrou_p2.
          MODIFY lt_reltyp_data FROM ls_reltyp_data.
        ENDLOOP.

        CLEAR ls_reltyp_data2.

        APPEND LINES OF lt_reltyp_data2 TO lt_reltyp_data.

        SORT lt_reltyp_data BY posnr bez50 AS TEXT.

        SORT lt_reltyp_data BY reltyp.

        LOOP AT lt_description INTO DATA(ls_description).
          READ TABLE lt_reltyp_data INTO ls_reltyp_data
            WITH KEY reltyp = ls_description-reltyp.

          IF sy-subrc = 0.
            MOVE-CORRESPONDING lt_reltyp_data TO lt_temp.
            DELETE lt_temp INDEX sy-tabix.
            ls_entityset-relationshiptype = ls_description-relkind.
            ls_entityset-description = ls_description-text30.
            ls_entityset-locale = ls_description-laiso.

            IF ls_reltyp_data-xdirection IS INITIAL.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              APPEND ls_entityset TO lt_entityset.
              CLEAR ls_entityset-relationshipcategory.
            ELSE.
              IF ls_reltyp_data-xpers_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xpers_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xorga_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xorga_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xgrou_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xgrou_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
            ENDIF.

            CLEAR: ls_reltyp_data,
                   ls_entityset.

            READ TABLE lt_temp INTO ls_reltyp_data
              WITH KEY reltyp = ls_description-reltyp.

            IF sy-subrc = 0.
              DELETE lt_temp INDEX sy-tabix.
              ls_entityset-relationshiptype = ls_description-relkind.
              ls_entityset-description = ls_description-text30.
              ls_entityset-locale = ls_description-laiso.

              IF ls_reltyp_data-xdirection IS INITIAL.
                ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
                APPEND ls_entityset TO lt_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ELSE.
                IF ls_reltyp_data-xpers_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xpers_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xorga_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xorga_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xgrou_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xgrou_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO lt_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
              ENDIF.

              CLEAR: ls_reltyp_data,
                     ls_entityset.
            ENDIF.
          ENDIF.
          CLEAR lt_temp.
        ENDLOOP.

    ENDTRY.

    SORT lt_entityset BY relationshipcategory relationshiptype locale.
    DELETE ADJACENT DUPLICATES FROM lt_entityset COMPARING relationshipcategory relationshiptype locale.

    LOOP AT lt_entityset INTO ls_entityset.
      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_entityset TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
*        IF ls_fieldname = 'Locale'.
*          CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
*            EXPORTING
*              input  = lv_string
*            IMPORTING
*              output = lv_string.
*        ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.

      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mdusrfldcombinat.
    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      ls_search_help_result TYPE ts_searchhelpresulttype,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `FieldCombinat` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    SELECT tq79~slwbez    AS fieldcombinat,
           tq79t~sprache  AS locale,
           tq79t~kurztext AS description
      FROM tq79 LEFT JOIN tq79t ON tq79~slwbez = tq79t~slwbez
      INTO TABLE @DATA(lt_data).

    LOOP AT lt_data INTO DATA(ls_data).

      CALL FUNCTION 'QAFD_IP_SLWBEZ_CHECK'
        EXPORTING
          i_slwbez         = ls_data-fieldcombinat
          i_steuerkz       = '7'
        EXCEPTIONS
          x_ip_not_found   = 1
          x_ip_not_allowed = 2
          OTHERS           = 3.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      LOOP AT lt_fieldname INTO DATA(ls_fieldname).
        ASSIGN COMPONENT ls_fieldname OF STRUCTURE ls_data TO FIELD-SYMBOL(<lf_data>).
        IF sy-subrc = 0.
          CLEAR lv_string.
          lv_string = <lf_data>.
          IF ls_fieldname = 'Locale'.
            CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
              EXPORTING
                input  = lv_string
              IMPORTING
                output = lv_string.
          ENDIF.

          "Handle " for output
          IF lv_string CA '"'.
            REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
          ENDIF.

          IF lv_value_string IS INITIAL.
            lv_value_string = '"' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ELSE.
            lv_value_string = lv_value_string && ', "' && ls_fieldname && '": ' && '"' && lv_string && '"'.
          ENDIF.
        ENDIF.
      ENDLOOP.

      lv_value_string = '{' && lv_value_string && '}'.
      "--Handle # for output
      REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.

      ls_search_help_result-multiplekey = is_request-multiplekey.
      ls_search_help_result-requestkey = is_request-requestkey.
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO rt_result.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_multiple_data.
    DATA:
      ls_multiple_request TYPE gty_multiplesearchhelp.
    ls_multiple_request = CORRESPONDING #( gs_data ).
    APPEND ls_multiple_request TO rt_multiple.
  ENDMETHOD.


  METHOD get_multiple_search_help.

    DATA:
      ls_search_help         TYPE gty_searchhelp,
      ls_search_help_request TYPE gty_searchhelprequest,
      ls_search_help_result  TYPE /simple/i_searchhelpresult.

    DATA:
      lv_int          TYPE i VALUE 0,
      lv_value_string TYPE string,
      ld_table        TYPE REF TO data,
      ld_table_line   TYPE REF TO data,
      lt_where_tab    TYPE TABLE OF string.

    DATA:
      ls_sel             TYPE string,
      lt_sel_list        TYPE TABLE OF string,
      ls_type            TYPE REF TO cl_abap_typedescr,
      ls_component       TYPE abap_componentdescr,
      lt_components      TYPE abap_component_tab,
      lo_sdescr          TYPE REF TO cl_abap_structdescr,
      lo_tdescr          TYPE REF TO cl_abap_tabledescr,
      lv_fieldname       TYPE string,
      lv_langu           TYPE langu,
      lv_data_element    TYPE fieldname,
      lv_language_string TYPE string,
      lt_language_string TYPE TABLE OF string,
      ls_language        TYPE ehprcs_range_langu,
      lt_language        TYPE TABLE OF ehprcs_range_langu,
      lv_string          TYPE string,
      lt_result          TYPE gty_searchhelpresult_tab.

    FIELD-SYMBOLS:
      <line>    TYPE any,
      <lt_line> TYPE ANY TABLE.

    lv_language_string = gs_data-languagekey.
    TRANSLATE lv_language_string TO UPPER CASE.
    SPLIT lv_language_string AT ',' INTO TABLE lt_language_string.

    LOOP AT lt_language_string INTO DATA(ls_string).
      CALL FUNCTION 'CONVERSION_EXIT_ISOLA_INPUT'
        EXPORTING
          input            = ls_string
        IMPORTING
          output           = ls_language-low
        EXCEPTIONS
          unknown_language = 1
          OTHERS           = 2.
      IF sy-subrc <> 0.
        "Implement suitable error handling here
      ENDIF.
      ls_language-sign = 'I'.
      ls_language-option = 'EQ'.
      APPEND ls_language TO lt_language.
      CLEAR ls_language.
    ENDLOOP.

    LOOP AT gs_data-to_searchhelprequest INTO ls_search_help_request.
      IF ls_search_help_request-mdtablename = 'MDPaymentMethod'.
        lt_result = get_f4_mdpaymentmethod( is_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDRelationship'.
        lt_result = get_f4_mdrelationship( is_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDRelationshipType'.
        lt_result = get_f4_mdrelationshiptype( is_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDDeliveryPriority'.
        lt_result = get_f4_mddeliverypriority( is_request = ls_search_help_request ).
*      ELSEIF ls_search_help_request-mdtablename = 'MDCostCenterGroup'.
*      get_f4_mdcostcentergroup( CHANGING lc_search_help_request = ls_search_help_request ).
*      ELSEIF ls_search_help_request-mdtablename = 'MDBOMClassType'.
*      get_f4_mdbomclasstype( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDClassTextID'.
        lt_result = get_f4_mdclasstextid( is_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDUsrFldCombinat'.
        lt_result = get_f4_mdusrfldcombinat( is_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtablename = 'MDClassificationStatus'.
*        lt_result = get_f4_mdclassificationstatus( is_request = ls_search_help_request
*                                                   it_language = lt_language ).
      ELSE.
        LOOP AT ls_search_help_request-to_searchhelp INTO ls_search_help.
          "Initialize
          CLEAR: lt_sel_list, lt_where_tab, lt_components.

          "Build structure and select fields list
          LOOP AT ls_search_help-to_searchhelpfield INTO DATA(ls_select_field).
            DATA(lv_index) = sy-tabix.
            IF ls_select_field-fieldtype IS INITIAL.
              lv_fieldname = ls_select_field-tablename && '-' &&
                             ls_select_field-technicalfieldname.

              IF lv_index = lines( ls_search_help-to_searchhelpfield ).
                ls_sel = ls_select_field-tablename && '~' &&
                         ls_select_field-technicalfieldname && ` AS ` &&
                         ls_select_field-fieldname.
                APPEND ls_sel TO lt_sel_list.
              ELSE.
                ls_sel = ls_select_field-tablename && '~' &&
                         ls_select_field-technicalfieldname && ` AS ` &&
                         ls_select_field-fieldname && ','.
                APPEND ls_sel TO lt_sel_list.
              ENDIF.
            ELSEIF ls_select_field-fieldtype = 'Function'.
              lv_fieldname = 'T087J-TXT50'.

              IF lv_index = lines( ls_search_help-to_searchhelpfield ).
                ls_sel = ls_select_field-technicalfieldname && ` AS ` &&
                         ls_select_field-fieldname.
                APPEND ls_sel TO lt_sel_list.
              ELSE.
                ls_sel = ls_select_field-technicalfieldname && ` AS ` &&
                         ls_select_field-fieldname && ','.
                APPEND ls_sel TO lt_sel_list.
              ENDIF.
            ENDIF.

            "Build Components
            IF ls_search_help_request-mdtablename = 'MDRecordTypeGroup' "Danhlt change type for work center
            AND lv_fieldname = 'DD07V-VALPOS'.
              READ TABLE lt_sel_list[] ASSIGNING FIELD-SYMBOL(<lfs_sel_list>) INDEX lv_index.
              IF sy-subrc = 0.
                REPLACE ALL OCCURRENCES OF 'DD07V~VALPOS' IN <lfs_sel_list> WITH 'CAST( CAST( DD07V~VALPOS AS INT2 ) AS CHAR )'.
              ENDIF.
              cl_abap_datadescr=>describe_by_name(
                EXPORTING
                  p_name         = 'CHAR6' "lv_fieldname
                RECEIVING
                  p_descr_ref    = ls_type
                EXCEPTIONS
                  type_not_found = 1
                  OTHERS         = 2
              ).
            ELSE.
              cl_abap_datadescr=>describe_by_name(
                EXPORTING
                  p_name         = lv_fieldname
                RECEIVING
                  p_descr_ref    = ls_type
                EXCEPTIONS
                  type_not_found = 1
                  OTHERS         = 2
              ).
            ENDIF.
            IF sy-subrc <> 0.
*             MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
            ENDIF.
*            ls_component-type ?= cl_abap_datadescr=>describe_by_name( lv_fieldname ).
            ls_component-type ?= ls_type.

            ls_component-name  = ls_select_field-fieldname.
            IF ls_component-type IS NOT INITIAL.
              APPEND ls_component TO lt_components.
            ENDIF.
            CLEAR: ls_sel, lv_fieldname, ls_component.
          ENDLOOP.

          IF lt_components IS NOT INITIAL.
            lo_sdescr = cl_abap_structdescr=>create( lt_components ).
            lo_tdescr = cl_abap_tabledescr=>create( lo_sdescr ).
            CREATE DATA ld_table TYPE HANDLE lo_tdescr.
            ASSIGN ld_table->* TO <lt_line>.

            CREATE DATA ld_table_line LIKE LINE OF <lt_line>.
            ASSIGN ld_table_line->* TO <line>.

            IF ls_search_help-whereclause IS NOT INITIAL.
              APPEND ls_search_help-whereclause TO lt_where_tab.
            ENDIF.

            READ TABLE ls_search_help-to_searchhelpfield INTO ls_select_field
                                                         WITH KEY fieldname = 'Locale'.
            IF sy-subrc = 0.
              IF lt_where_tab IS NOT INITIAL.
                lv_string = `AND ( ` && ls_select_field-tablename && '~' &&
                            ls_select_field-technicalfieldname && ` IN @lt_language OR ` &&
                            ls_select_field-tablename && '~' &&
                            ls_select_field-technicalfieldname && ` IS NULL ) `.
              ELSE.
                lv_string = `( ` && ls_select_field-tablename && '~' &&
                            ls_select_field-technicalfieldname && ` IN @lt_language OR ` &&
                            ls_select_field-tablename && '~' &&
                            ls_select_field-technicalfieldname && ` IS NULL ) `.
              ENDIF.
              APPEND lv_string TO lt_where_tab.
              CLEAR lv_string.
            ENDIF.

            TRY.
                SELECT (lt_sel_list)
                  INTO CORRESPONDING FIELDS OF TABLE @<lt_line>
                  FROM (ls_search_help-fromjoin)
                 WHERE (lt_where_tab).
              CATCH cx_root INTO DATA(lo_catch).
                DATA(lv_message) = lo_catch->get_text( ).
            ENDTRY.
          ENDIF.

          "Build Return Value
          IF <lt_line> IS ASSIGNED.
            LOOP AT <lt_line> INTO <line>.
              LOOP AT ls_search_help-to_searchhelpfield INTO DATA(ls_selectfield_1).
                ASSIGN COMPONENT ls_selectfield_1-fieldname OF STRUCTURE <line> TO FIELD-SYMBOL(<lf_data>).
                IF sy-subrc = 0.
                  CLEAR lv_string.
                  lv_string = <lf_data>.

                  lv_data_element = ls_selectfield_1-technicalfieldname.
                  TRANSLATE lv_data_element TO UPPER CASE.
**                  IF to_upper( ls_selectfield_1-fieldname ) = 'LOCALE'.
**                    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
**                      EXPORTING
**                        input  = lv_string
**                      IMPORTING
**                        output = lv_string.
**                  ENDIF.
**                  "Convert external value for UoM
**                  IF lv_data_element = 'MSEHI'.
**                    ASSIGN COMPONENT 'Locale' OF STRUCTURE <line> TO FIELD-SYMBOL(<lf_langu>).
**                    IF sy-subrc = 0.
**                      lv_langu = <lf_langu>.
**                    ENDIF.
**                    CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
**                      EXPORTING
**                        input          = lv_string
**                        language       = lv_langu
**                      IMPORTING
**                        output         = lv_string
**                      EXCEPTIONS
**                        unit_not_found = 1
**                        OTHERS         = 2.
**                    IF sy-subrc <> 0.
**                      "Implement suitable error handling here
**                    ENDIF.
**
**                  ENDIF.
**
**                  "Conversion routine PARVW
**                  IF lv_data_element = 'PARVW'.
**                    CALL FUNCTION 'CONVERSION_EXIT_PARVW_OUTPUT'
**                      EXPORTING
**                        input  = lv_string
**                      IMPORTING
**                        output = lv_string.
**                  ENDIF.
**
**                  "Conversion routine DOKNR
**                  IF lv_data_element = 'DOKNR'.
**                    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
**                      EXPORTING
**                        input  = lv_string
**                      IMPORTING
**                        output = lv_string.
**                    CONDENSE lv_string NO-GAPS.
**                  ENDIF.
**
**                  "Conversion Cost Element Category
**                  IF ls_search_help_request-mdtablename = 'MDCostElementCategory' AND
**                     lv_data_element = 'DOMVALUE_L'.
**                    SHIFT lv_string LEFT DELETING LEADING '0'.
**                  ENDIF.
                  "Convert external value for UoM
                  IF lv_data_element = 'LOCALE'.
                    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.
                  ELSEIF lv_data_element = 'MSEHI'.
                    ASSIGN COMPONENT 'Locale' OF STRUCTURE <line> TO FIELD-SYMBOL(<lf_langu>).
                    IF sy-subrc = 0.
                      lv_langu = <lf_langu>.
                    ENDIF.
                    CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
                      EXPORTING
                        input          = lv_string
                        language       = lv_langu
                      IMPORTING
                        output         = lv_string
                      EXCEPTIONS
                        unit_not_found = 1
                        OTHERS         = 2.
                    IF sy-subrc <> 0.
                      "Implement suitable error handling here
                    ENDIF.

                    "Conversion routine PARVW
                  ELSEIF lv_data_element = 'PARVW'.
                    CALL FUNCTION 'CONVERSION_EXIT_PARVW_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.

                    "Conversion routine DOKNR
                  ELSEIF lv_data_element = 'DOKNR'.
                    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.
                    CONDENSE lv_string NO-GAPS.
                    "Conversion Cost Element Category
                  ELSEIF ls_search_help_request-mdtablename = 'MDCostElementCategory' AND
                     lv_data_element = 'DOMVALUE_L'.
                    SHIFT lv_string LEFT DELETING LEADING '0'.

                  ELSE.
                    DATA lv_routine TYPE convexit.
                    DESCRIBE FIELD <lf_data> EDIT MASK DATA(lv_mask).
                    IF lv_mask IS NOT INITIAL.
                      SHIFT lv_mask LEFT BY 2 PLACES.
                      lv_routine = lv_mask.

                      /simple/cl_search=>call_conversion_routine(
                        EXPORTING
                          iv_routine  = lv_routine
                          iv_is_input = abap_false
                        CHANGING
                          cv_value    = lv_string ).

                      SHIFT lv_string RIGHT DELETING TRAILING space.
                      CONDENSE lv_string.
                      CLEAR lv_mask.
                    ENDIF.
                  ENDIF.

                  "Handle " for output
                  IF lv_string CA '\'.
                    REPLACE ALL OCCURRENCES OF '\' IN lv_string WITH '\\\\'.
                  ENDIF.

                  IF lv_string CA '"'.
                    REPLACE ALL OCCURRENCES OF '"' IN lv_string WITH '\"'.
                  ENDIF.

                  IF lv_value_string IS INITIAL.
                    lv_value_string = '"' && ls_selectfield_1-fieldname && '": ' && '"' && lv_string && '"'.
                  ELSE.
                    lv_value_string = lv_value_string && ', "' && ls_selectfield_1-fieldname && '": ' && '"' && lv_string && '"'.
                  ENDIF.
                ENDIF.
              ENDLOOP.

              lv_value_string = '{' && lv_value_string && '}'.
              "--Handle # for output
              REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.
              ls_search_help_result-multiplekey = ls_search_help_request-multiplekey.
              ls_search_help_result-requestkey = ls_search_help_request-requestkey.
              ls_search_help_result-value = lv_value_string.
*              APPEND ls_search_help_result TO ls_search_help_request-to_searchhelpresult.
              APPEND ls_search_help_result TO lt_result.
              CLEAR: ls_search_help_result, lv_value_string, lv_data_element.
            ENDLOOP.
          ENDIF.
        ENDLOOP.
      ENDIF.

      APPEND LINES OF lt_result TO rt_result.
      CLEAR lt_result.
      MODIFY gs_data-to_searchhelprequest FROM ls_search_help_request.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_request_data.
    DATA:
      ls_search_help_request TYPE gty_searchhelprequest.
    LOOP AT gs_data-to_searchhelprequest INTO ls_search_help_request.
    ENDLOOP.
    rt_request = CORRESPONDING #( gs_data-to_searchhelprequest ).
  ENDMETHOD.


  METHOD set_multiple_search_help.
    gs_data = it_multiplesearch.
  ENDMETHOD.
ENDCLASS.
