CLASS /simple/cl_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF gty_searchvalue,
        dummykey    TYPE c LENGTH 20,
        fuzzysearch TYPE flag,
        name        TYPE string,
        value       TYPE string,
        isdisplay   TYPE flag,
        type        TYPE string,
      END OF gty_searchvalue .
    TYPES:
      BEGIN OF gty_searchresult,
        dummykey TYPE c LENGTH 20,
        value    TYPE string,
      END OF gty_searchresult .
    TYPES:
      gty_result_tab TYPE STANDARD TABLE OF gty_searchresult WITH DEFAULT KEY .
    TYPES:
      BEGIN OF gty_searchfield,
        dummykey        TYPE c LENGTH 20,
        navpath         TYPE string,
        to_searchvalues TYPE STANDARD TABLE OF gty_searchvalue WITH DEFAULT KEY.
    TYPES END OF gty_searchfield .
    TYPES:
      BEGIN OF gty_search,
        dummykey         TYPE c LENGTH 20,
        maxhit           TYPE /iwbep/sb_odata_ty_int2,
        iscontainssearch TYPE flag,
        objecttype       TYPE string,
        fuzzyvalues      TYPE string,
        fuzzysearch      TYPE flag,
        to_searchfields  TYPE STANDARD TABLE OF gty_searchfield WITH DEFAULT KEY,
        to_searchresults TYPE STANDARD TABLE OF gty_searchresult WITH DEFAULT KEY,
      END OF gty_search .
    TYPES:
      BEGIN OF gty_fz_where,
        field     TYPE c LENGTH 40,
        value     TYPE string,
        isfuzzy   TYPE abap_bool,
        iscontain TYPE abap_bool,
      END OF gty_fz_where .

    CLASS-METHODS check_data_is_string
      IMPORTING
        !iv_cds       TYPE string
        !iv_field     TYPE abap_compname
        !iv_value     TYPE any OPTIONAL
      EXPORTING
        !ev_is_string TYPE abap_bool
        !ev_routine   TYPE convexit
        !ev_lengtherr TYPE char1 .
    CLASS-METHODS call_conversion_routine
      IMPORTING
        !iv_routine  TYPE convexit
        !iv_is_input TYPE abap_bool DEFAULT abap_true
      CHANGING
        !cv_value    TYPE any .      " string.
    METHODS set_search_criteria
      IMPORTING
        !is_data TYPE gty_search .
    METHODS get_search_result
      RETURNING
        VALUE(rt_result) TYPE gty_result_tab .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: gs_data TYPE gty_search.
    METHODS:
      _get_implemented_class_name RETURNING VALUE(rv_class_name) TYPE tmdir-classname.
ENDCLASS.



CLASS /SIMPLE/CL_SEARCH IMPLEMENTATION.


  METHOD call_conversion_routine.
    DATA: lv_func_name TYPE tfdir-funcname.

    IF cv_value IS INITIAL OR iv_routine IS INITIAL. RETURN. ENDIF.

    IF iv_is_input = abap_true.
      lv_func_name = 'CONVERSION_EXIT_' && iv_routine && '_INPUT'.
    ELSE.
      lv_func_name = 'CONVERSION_EXIT_' && iv_routine && '_OUTPUT'.
    ENDIF.

    TRANSLATE lv_func_name TO UPPER CASE.
    CONDENSE lv_func_name NO-GAPS.


    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = lv_func_name
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    "LD-0118 - 20231115 - Danh Tran - Start - Mod
    TRY .
        CLEAR sy-subrc.
        CALL FUNCTION lv_func_name
          EXPORTING
            input         = cv_value
          IMPORTING
            output        = cv_value
          EXCEPTIONS
            error_message = 1
            OTHERS        = 2.
        IF sy-subrc <> 0.
          CLEAR cv_value.
        ENDIF.
      CATCH cx_root.
        CLEAR cv_value.
    ENDTRY.
    "LD-0118 - 20231115 - Danh Tran - End - Mod
    CONDENSE cv_value NO-GAPS. "Flynn insert++ - 20240313
  ENDMETHOD.


  METHOD check_data_is_string.
    DATA: lv_any TYPE REF TO data.
    IF iv_cds IS INITIAL OR iv_field IS INITIAL. RETURN. ENDIF.
    CLEAR: ev_is_string.

    TRY.
        CREATE DATA lv_any TYPE (iv_cds).
        ASSIGN lv_any->* TO FIELD-SYMBOL(<ls_struct>).
        IF <ls_struct> IS ASSIGNED.
          ASSIGN COMPONENT iv_field OF STRUCTURE <ls_struct> TO FIELD-SYMBOL(<fs_field>).
          IF <fs_field> IS ASSIGNED.
            DESCRIBE FIELD <fs_field> TYPE DATA(lv_type) EDIT MASK DATA(lv_mask) OUTPUT-LENGTH DATA(lv_output_length). "Mod by Danh Tran 11.07.2022
            IF lv_type = 'C'.
              ev_is_string = abap_true.
            ENDIF.

            SHIFT lv_mask LEFT BY 2 PLACES.
            ev_routine = lv_mask.

*           Begin of Ins by Danh Tran 11.07.2022
            CASE lv_type.
              WHEN 'D'.
                lv_output_length = 8.
                IF iv_value CN '0123456789'
                OR  strlen( iv_value ) > lv_output_length .
                  ev_lengtherr = 'X'.
                ENDIF.
              WHEN 'I'.
                lv_output_length = 10.
                IF iv_value CN '0123456789'
                OR  strlen( iv_value ) > lv_output_length .
                  ev_lengtherr = 'X'.
                ENDIF.

              WHEN 'P'.
                TRY .
                    DATA lv_maxplength      TYPE p LENGTH 16 DECIMALS 3  .
                    DATA lt_dfies_tab       TYPE STANDARD TABLE OF dfies.
                    DATA lv_tabname_input   TYPE ddobjname.
                    DATA lv_fieldname_input TYPE dfies-fieldname.
                    DATA lt_tbstring        TYPE STANDARD TABLE OF string.

                    "validation decimal
                    lv_maxplength = iv_value.



                    "Attribute
                    FREE lt_dfies_tab[].
                    CALL FUNCTION 'DDIF_FIELDINFO_GET'
                      EXPORTING
                        tabname        = lv_tabname_input     "CS_DATA-TABLENAME
                        fieldname      = lv_fieldname_input   "CS_DATA-FIELDNAME
                      TABLES
                        dfies_tab      = lt_dfies_tab
*                       FIXED_VALUES   = FIXED_VALUES
                      EXCEPTIONS
                        not_found      = 1
                        internal_error = 2.
                    READ TABLE lt_dfies_tab INTO DATA(ls_dfies_tab_input) INDEX 1.

                    "number
                    SPLIT iv_value AT '.' INTO TABLE lt_tbstring.
                    READ TABLE lt_tbstring INTO DATA(lv_tbstring) INDEX 1.

                    IF strlen( lv_tbstring ) > ( ls_dfies_tab_input-leng - ls_dfies_tab_input-decimals ).
                      ev_lengtherr = 'X'.
                    ENDIF.

                  CATCH cx_root.
                    ev_lengtherr = 'X'.
                ENDTRY.

              WHEN OTHERS.
                IF strlen( iv_value ) > lv_output_length.
                  ev_lengtherr = 'X'.
                ENDIF.

            ENDCASE.
*           End of Ins by Danh Tran 11.07.2022
          ENDIF.
        ENDIF.
      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.
  ENDMETHOD.


  METHOD get_search_result.
    CONSTANTS:
      lc_method TYPE tmdir-methodname VALUE 'SEARCH_MASTER_DATA'.
    DATA:
      lo_object TYPE REF TO object.
    DATA(lv_class) = _get_implemented_class_name( ).
    IF lv_class IS INITIAL.
      RETURN.
    ENDIF.

    TRY.
        CREATE OBJECT lo_object TYPE (lv_class).
        CALL METHOD lo_object->(lc_method)
          CHANGING
            cs_data = gs_data.
      CATCH cx_root INTO DATA(lx_root).
        RETURN.
    ENDTRY.

    rt_result = gs_data-to_searchresults.
  ENDMETHOD.


  METHOD set_search_criteria.
    gs_data = is_data.
  ENDMETHOD.


  METHOD _get_implemented_class_name.
    CLEAR: rv_class_name.
    CASE gs_data-objecttype.
      WHEN 'MerchCategory'.
        rv_class_name = '/SIMPLE/CL_SEARCH_MC'.
      WHEN 'MCHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_MCH'.
      WHEN 'Product' OR 'Material'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PRD'.
      WHEN 'CostCenter'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CC'.
      WHEN 'BillOfMaterial'.
        rv_class_name = '/SIMPLE/CL_SEARCH_BOM'.
      WHEN 'GLAccountInChartOfAccounts'.
        rv_class_name = '/SIMPLE/CL_SEARCH_GL'.
      WHEN 'Routing'.
        rv_class_name = '/SIMPLE/CL_SEARCH_RT'.
      WHEN 'WorkCenter'.
        rv_class_name = '/SIMPLE/CL_SEARCH_WC'.
      WHEN 'SourceList'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SL'.
      WHEN 'InfoRecord'.
        rv_class_name = '/SIMPLE/CL_SEARCH_IR'.
      WHEN 'ProfitCenter'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PC'.
      WHEN 'CostCenterHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CCH'.
      WHEN 'ActivityType'.
        rv_class_name = '/SIMPLE/CL_SEARCH_AT'.
      WHEN 'ProfitCenterHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PCH'.
      WHEN 'Article'.
        rv_class_name = '/SIMPLE/CL_SEARCH_ART'.
      WHEN 'BusinessPartner' OR 'Customer' OR 'Vendor'.
        rv_class_name = '/SIMPLE/CL_SEARCH_BP'.
      WHEN 'StatisticalKeyFigure'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SKF'.
      WHEN 'ArticleHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_AH'.
      WHEN 'BankMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_BM'.
      WHEN 'AssetMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_AM'.
      WHEN 'ActivityRate'.
        rv_class_name = '/SIMPLE/CL_SEARCH_AR'.
      WHEN 'SamplingScheme'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SC'.
      WHEN 'ProductionVersion'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PV'.
      WHEN 'CustomerMaterialInfoRecord'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CMI'.
      WHEN 'SamplingProcedure'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SP'.
*     Begin of Ins by Danh Tran 25.02.2022
      WHEN 'PricingCondition'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PRI'.
      WHEN 'PricingConditionRecord'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PCR'.
*     End of Ins by Danh Tran 25.02.2022
      WHEN 'CatalogueCodeGroup'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CCG'.
        " Insert - Kent: FICO Set 03/03/2022 - START
      WHEN 'FICOSet'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SET'.
        " Insert - Kent: FICO Set 03/03/2022 - END
      WHEN 'InternalOrder'.
        rv_class_name = '/SIMPLE/CL_SEARCH_IO'.
      WHEN 'MixedCosting'.
        rv_class_name = '/SIMPLE/CL_SEARCH_MIX'.
      WHEN 'MasterInspectionCharacteristic'.
        rv_class_name = '/SIMPLE/CL_SEARCH_MIC'.
      WHEN 'SelectedSetCode'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SSC'.
      WHEN 'PackingInstruction'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PI'.
      WHEN 'InspectionMethod'.
        rv_class_name = '/SIMPLE/CL_SEARCH_IM'.
      WHEN 'TaskList'.
        rv_class_name = '/SIMPLE/CL_SEARCH_TL'.
      WHEN 'CostElementGroup'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CEG'.    " Insert - Jamie    14/7/2022
      WHEN 'OrderGroup'.
        rv_class_name = '/SIMPLE/CL_SEARCH_OG'.     " Insert - Martin   18/7/2022
      WHEN 'CostCenterGroup'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CCGR'.
        " Insert - Jamie 07/06/2022 - start
      WHEN 'Class'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CL'.
      WHEN 'Characteristics'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CHA'.
      WHEN 'Equipment'.
        rv_class_name = '/SIMPLE/CL_SEARCH_EQUI'.
      WHEN 'FunctionalLocation'.
        rv_class_name = '/SIMPLE/CL_SEARCH_FLOC'.
      WHEN 'MaintenancePlan'.
        rv_class_name = '/SIMPLE/CL_SEARCH_MPLN'.
      WHEN 'ChemicalApplicationTracking'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CAT'.    " Insert - Simon     14/11/2022
      WHEN 'AttributeGroup'.
        rv_class_name = '/SIMPLE/CL_SEARCH_ZATG'.   " Insert - Danh Tran 28/11/2022
      WHEN 'AttributesMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_ZATT'.   " Insert - Danh Tran 28/11/2022
      WHEN 'EngineeringChangeMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_ECM'.   " Insert - Danh Tran 28/11/2022
      WHEN 'BinMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_BIN'.   " Insert - Danh Tran 28/11/2022
      WHEN 'PurchasingInfoRecord'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PIR'.   " Insert - Danh Tran 28/11/2022
      WHEN 'SupplierHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_SH'.     " Insert - Fle 26/12/2023
      WHEN 'CustomerHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_CH'.     "Insert - Alex 17/1/2024
      WHEN 'ArticleMaster'.
        rv_class_name = '/SIMPLE/CL_SEARCH_ARTM'.     "Insert - Kenny 22/1/2024
      WHEN 'PurchasingDocument'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PDOC'.   "Insert - Flynn 07/02/2024
      WHEN 'ProductHierarchy'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PRDH'.   "Insert - Kenny 25/03/2024
      WHEN 'PurchaseRequisition'.
        rv_class_name = '/SIMPLE/CL_SEARCH_PR'.   "Insert - Draco 08/04/2024
      WHEN 'VendorInvoicePO'.
        rv_class_name = '/SIMPLE/CL_SEARCH_VIPO'.
      WHEN 'FunctionalArea'.
        rv_class_name = '/SIMPLE/CL_SEARCH_FA'.  "Insert - Draco 16/04/2024
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
