CLASS /simple/cl_search_prd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS: search_master_data CHANGING cs_data TYPE /simple/cl_search=>gty_search.
  PROTECTED SECTION.
private section.

  methods _MAP_TABLE_ALIAS
    importing
      !IV_NAVPATH type /SIMPLE/CL_SEARCH=>GTY_SEARCHFIELD-NAVPATH
    exporting
      !EV_ALIAS type STRING
      !EV_CDS type STRING .
  methods _INIT_BOOLEAN_FIELD
    exporting
      !ET_TAB type ABAP_COMPDESCR_TAB .
  methods _CONVERT_FIELDNAME
    changing
      !CV_FIELDNAME type CHAR30 .
  methods _CONCAT_SEARCH_RESULT
    importing
      !IV_FNAME type CHAR30
      !IV_VALUE type ANY
      !IT_BOOL_TAB type ABAP_COMPDESCR_TAB optional
    changing
      !CV_RESULT type STRING .
  methods _MAP_TABLE_ALIAS_FUZZY
    importing
      !IV_NAVPATH type /SIMPLE/CL_SEARCH=>GTY_SEARCHFIELD-NAVPATH
    exporting
      !EV_ALIAS type STRING
      !EV_CDS type STRING .
ENDCLASS.



CLASS /SIMPLE/CL_SEARCH_PRD IMPLEMENTATION.


  METHOD search_master_data.
    TYPES:
      BEGIN OF lty_sql_result,
        score   TYPE p LENGTH 5 DECIMALS 2,
        product TYPE /simple/c_product-product,
      END OF lty_sql_result.

    DATA:
      lv_cond        TYPE string,
      lv_cond_single TYPE string,
      lv_row         TYPE int8,
      lv_sql         TYPE string,
      lr_result      TYPE REF TO data,
      lt_result      TYPE STANDARD TABLE OF lty_sql_result,
      lt_fz_where    TYPE STANDARD TABLE OF /simple/cl_search=>gty_fz_where.

    DATA:
      lv_select_count   TYPE i,
      lt_sql_select     TYPE STANDARD TABLE OF string,
      lt_sql_from       TYPE STANDARD TABLE OF string,
      lt_sql_select_out TYPE STANDARD TABLE OF string,
      lv_select_alias   TYPE string,
      lv_sql_from       TYPE string,
      lv_sql_select_out TYPE char30,
      lt_sql_from_fuzzy TYPE STANDARD TABLE OF string,
      lv_sql_from_fuzzy TYPE string,
      ld_table          TYPE REF TO data,
      ls_type           TYPE REF TO cl_abap_typedescr,
      lo_sdescr         TYPE REF TO cl_abap_structdescr,
      lo_tdescr         TYPE REF TO cl_abap_tabledescr,
      ls_component      TYPE abap_componentdescr,
      lt_components     TYPE abap_component_tab.

    FIELD-SYMBOLS: <fs_sql_select> TYPE string.

    DATA lo_exception TYPE REF TO cx_no_check.

    APPEND '/SIMPLE/C_PRODUCT AS T1' TO lt_sql_from.
    APPEND '"/SIMPLE/CPRD" AS T1' TO lt_sql_from_fuzzy.

    SORT cs_data-to_searchfields ASCENDING.
    LOOP AT cs_data-to_searchfields INTO DATA(ls_searchfield).
      _map_table_alias( EXPORTING iv_navpath = ls_searchfield-navpath IMPORTING ev_alias = DATA(lv_t_number) ev_cds = DATA(lv_cds) ).
      IF lv_t_number IS INITIAL.
        CONTINUE.
      ENDIF.

      IF lv_t_number <> 't1'.
        _map_table_alias_fuzzy( EXPORTING iv_navpath = ls_searchfield-navpath IMPORTING ev_alias = DATA(lv_t_number_fuzzy) ev_cds = DATA(lv_cds_fuzzy) ).

        IF lv_t_number EQ 't20'.
          APPEND |LEFT JOIN { lv_cds } AS { lv_t_number } ON t1~product = { lv_t_number }~objek| TO lt_sql_from.
          APPEND |LEFT JOIN "{ lv_cds_fuzzy }" AS { lv_t_number_fuzzy } ON t1~product = { lv_t_number }~objek| TO lt_sql_from_fuzzy.
        ELSE.
          APPEND |LEFT JOIN { lv_cds } AS { lv_t_number } ON t1~product = { lv_t_number }~product| TO lt_sql_from.
          APPEND |LEFT JOIN "{ lv_cds_fuzzy }" AS { lv_t_number_fuzzy } ON t1~product = { lv_t_number }~product| TO lt_sql_from_fuzzy.
        ENDIF.
      ENDIF.

      LOOP AT ls_searchfield-to_searchvalues INTO DATA(ls_field).
        CLEAR:
          lv_select_alias,
          ls_component,
          ls_type.
        IF ls_field-isdisplay IS NOT INITIAL.
          cl_abap_datadescr=>describe_by_name(
              EXPORTING
                p_name         = |{ lv_cds }-{ ls_field-name }|
              RECEIVING
                p_descr_ref    = ls_type
              EXCEPTIONS
                type_not_found = 1
                OTHERS         = 2
            ).
          IF sy-subrc <> 0.
*             MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.

          ls_component-type ?= ls_type.
          ls_component-name  = ls_field-name.
          IF ls_component-type IS NOT INITIAL.

            READ TABLE lt_components WITH KEY name = ls_component-name
            TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              lv_select_alias = |{ lv_t_number }~{ ls_field-name },|.

              APPEND ls_component TO lt_components.
              APPEND lv_select_alias TO lt_sql_select.
              APPEND ls_field-name TO lt_sql_select_out.
            ENDIF.
          ENDIF.

        ENDIF.
        IF ls_field-value IS NOT INITIAL.
          REPLACE ALL OCCURRENCES OF `'` IN ls_field-value WITH `''`.
          /simple/cl_search=>check_data_is_string(
            EXPORTING
              iv_cds       = lv_cds
              iv_field     = CONV abap_compname( ls_field-name )
              iv_value     = ls_field-value "Ins by Bruce Nguyen 07/13/2022
            IMPORTING
              ev_is_string = DATA(lv_flag_str)
              ev_routine   = DATA(lv_routine)
************Begin of Ins by Bruce Nguyen 07/13/2022*************
*           Check length of value
              ev_lengtherr = DATA(lv_lengtherr) ).

          IF lv_lengtherr IS NOT INITIAL.
            CONTINUE.
          ENDIF.
************End of Ins by Bruce Nguyen 07/13/2022*************

          IF lv_routine IS NOT INITIAL AND
            ( to_upper( ls_field-name ) = 'LANGUAGE' OR to_upper( ls_field-name ) = 'PRODUCT'  ) .
            /simple/cl_search=>call_conversion_routine(
              EXPORTING
                iv_routine  = lv_routine
                iv_is_input = abap_true
              CHANGING
                cv_value    = ls_field-value ).
          ENDIF.
          DATA lt_all TYPE RANGE OF string.
*          CONDENSE ls_field-value.
          SHIFT  ls_field-value RIGHT DELETING TRAILING space.
          IF  ls_field-value = '*'.

            lv_cond_single = |{ lv_t_number }~{ ls_field-name } IN @LT_ALL|.

            IF lv_cond IS INITIAL.
              lv_cond = lv_cond_single.
            ELSE.
              lv_cond = |{ lv_cond } AND { lv_cond_single }|.
            ENDIF.

            lt_fz_where = VALUE #( BASE lt_fz_where ( field = |{ lv_t_number }.{ ls_field-name }|
            value = ls_field-value isfuzzy = ls_field-fuzzysearch iscontain = abap_false ) ).
          ELSEIF cs_data-iscontainssearch = 'X'.
            IF ls_field-name = 'Language' OR ls_field-name = 'IsMarkedForDeletion'.
              IF lv_flag_str = abap_true.
*                  lv_cond_single = |UPPER( { lv_t_number }~{ ls_field-name } ) = '{ ls_field-value CASE = UPPER }'|.
                lv_cond_single = |{ lv_t_number }~{ ls_field-name } = '{ ls_field-value }'|.
              ELSE.
                lv_cond_single = |{ lv_t_number }~{ ls_field-name } = '{ ls_field-value }'|.
              ENDIF.

              IF lv_cond IS INITIAL.
                lv_cond = lv_cond_single.
              ELSE.
                lv_cond = |{ lv_cond } AND { lv_cond_single }|.
              ENDIF.

              lt_fz_where = VALUE #( BASE lt_fz_where ( field = |{ lv_t_number }.{ ls_field-name }|
                                                        value = ls_field-value isfuzzy = ls_field-fuzzysearch iscontain = abap_true ) ).

            ELSE.

              IF lv_flag_str = abap_true.
*                  lv_cond_single = |UPPER( { lv_t_number }~{ ls_field-name } ) LIKE '%{ ls_field-value CASE = UPPER }%'|.
                lv_cond_single = |{ lv_t_number }~{ ls_field-name } LIKE '%{ ls_field-value }%'|.
              ELSE.
                lv_cond_single = |{ lv_t_number }~{ ls_field-name } LIKE '%{ ls_field-value }%'|.
              ENDIF.

              IF lv_cond IS INITIAL.
                lv_cond = lv_cond_single.
              ELSE.
                lv_cond = |{ lv_cond } AND { lv_cond_single }|.
              ENDIF.

              lt_fz_where = VALUE #( BASE lt_fz_where ( field = |{ lv_t_number }.{ ls_field-name }|
              value = ls_field-value isfuzzy = ls_field-fuzzysearch iscontain = abap_true ) ).

            ENDIF.

          ELSE.
            IF lv_flag_str = abap_true.
*                lv_cond_single = |UPPER( { lv_t_number }~{ ls_field-name } ) = '{ ls_field-value CASE = UPPER }'|.
              lv_cond_single = |{ lv_t_number }~{ ls_field-name } = '{ ls_field-value }'|.
            ELSE.
              lv_cond_single = |{ lv_t_number }~{ ls_field-name } = '{ ls_field-value }'|.
            ENDIF.

            IF lv_cond IS INITIAL.
              lv_cond = lv_cond_single.
            ELSE.
              lv_cond = |{ lv_cond } AND { lv_cond_single }|.
            ENDIF.

            lt_fz_where = VALUE #( BASE lt_fz_where ( field = |{ lv_t_number }.{ ls_field-name }|
            value = ls_field-value isfuzzy = ls_field-fuzzysearch iscontain = abap_false ) ).
          ENDIF.
        ENDIF.

      ENDLOOP.

    ENDLOOP.
    lv_row = cs_data-maxhit.

    FIELD-SYMBOLS:
      <lt_line_temp> TYPE ANY TABLE,
      <fs_line>      TYPE any,
      <fs_field>     TYPE any.

    IF lt_components IS NOT INITIAL.

      DESCRIBE TABLE lt_sql_select LINES lv_select_count.
      READ TABLE lt_sql_select INDEX lv_select_count ASSIGNING <fs_sql_select>.
      REPLACE ALL OCCURRENCES OF SUBSTRING ',' IN <fs_sql_select> WITH ''.

    ENDIF.

    IF cs_data-fuzzysearch IS INITIAL " Fuzzy search
      OR cl_db_sys=>is_in_memory_db <> abap_true   " HANA DB
      OR NOT line_exists( lt_fz_where[ isfuzzy = abap_true ] ).

*     Create structure
      lo_sdescr = cl_abap_structdescr=>create( lt_components ).
      lo_tdescr = cl_abap_tabledescr=>create( lo_sdescr ).
      CREATE DATA ld_table TYPE HANDLE lo_tdescr.
      ASSIGN ld_table->* TO <lt_line_temp>.

      IF lv_cond IS NOT INITIAL.
        TRY.
            SELECT DISTINCT (lt_sql_select)
                  FROM (lt_sql_from)
              UP TO @lv_row ROWS
              INTO CORRESPONDING FIELDS OF TABLE @<lt_line_temp>
              WHERE (lv_cond).
          CATCH cx_root INTO DATA(lo_catch).

        ENDTRY.
      ENDIF. " exact and contain search
    ELSE.

*     Create structure with additional field name SCORE
      ls_component-name = 'SCORE'.

      cl_abap_datadescr=>describe_by_data(
              EXPORTING
                p_data         = '100.000'
              RECEIVING
                p_descr_ref    = ls_type
            ).
      IF sy-subrc <> 0.
*             MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      ls_component-type ?= ls_type.
      INSERT ls_component INTO lt_components INDEX 1.

      lo_sdescr = cl_abap_structdescr=>create( lt_components ).
      lo_tdescr = cl_abap_tabledescr=>create( lo_sdescr ).
      CREATE DATA ld_table TYPE HANDLE lo_tdescr.
      ASSIGN ld_table->* TO <lt_line_temp>.

      IF lt_fz_where IS NOT INITIAL.
        TRY .
            DATA(lo_sql) = NEW cl_sql_statement( ).            " Build SQL string

            lv_sql = |SELECT TOP | &&  lv_row && | DISTINCT TO_DECIMAL(SCORE(),3,2) AS SCORE, |.

            LOOP AT lt_sql_select INTO lv_select_alias.

              TRANSLATE lv_select_alias TO UPPER CASE.
              REPLACE ALL OCCURRENCES OF SUBSTRING '~' IN lv_select_alias WITH '.'.
              lv_sql = lv_sql && | | && lv_select_alias.
              CLEAR lv_select_alias.

            ENDLOOP.

            lv_sql = lv_sql && | FROM |.

            LOOP AT lt_sql_from_fuzzy INTO lv_sql_from_fuzzy.

              TRANSLATE lv_sql_from_fuzzy TO UPPER CASE.
              REPLACE ALL OCCURRENCES OF SUBSTRING '~' IN lv_sql_from_fuzzy WITH '.'.
              lv_sql = lv_sql && | | &&  lv_sql_from_fuzzy && | |.
              CLEAR lv_sql_from_fuzzy.

            ENDLOOP.

            CONDENSE lv_sql.
            LOOP AT lt_fz_where INTO DATA(ls_fz_where).
              IF sy-tabix = 1.
                lv_sql = |{ lv_sql } WHERE |.
              ELSE.
                lv_sql = |{ lv_sql } AND |.
              ENDIF.

              IF ls_fz_where-isfuzzy = abap_true.
                lv_sql = |{ lv_sql } CONTAINS( { ls_fz_where-field CASE = UPPER }, '{ ls_fz_where-value }', FUZZY({ cs_data-fuzzyvalues },'similarCalculationMode=search') )|.
              ELSEIF ls_fz_where-iscontain = abap_true.
                lv_sql = |{ lv_sql } { ls_fz_where-field CASE = UPPER } LIKE '%{ ls_fz_where-value }%'|.
              ELSE.
                lv_sql = |{ lv_sql } { ls_fz_where-field CASE = UPPER } = '{ ls_fz_where-value }'|.
              ENDIF.
            ENDLOOP.

            lv_sql = lv_sql && | AND T1.MANDT = SESSION_CONTEXT( 'CLIENT' ) |. "Ins by Kenny Bui 05.07.2022
            lv_sql = lv_sql && | ORDER BY SCORE DESC, T1.PRODUCT ASC |.

            " Execute SQL
            DATA(lo_result) = lo_sql->execute_query( statement = lv_sql ).
            GET REFERENCE OF  <lt_line_temp> INTO lr_result.
            lo_result->set_param_table( itab_ref = lr_result ).
            lo_result->next_package( ).
            lo_result->close( ).

          CATCH cx_sql_exception INTO DATA(lx_sql).

          CATCH cx_parameter_invalid INTO DATA(lx_param).

        ENDTRY.

      ENDIF. " fuzzy
    ENDIF.

    DATA:
      lv_fieldname    TYPE char30,
      lv_value        TYPE c,
      lv_value_string TYPE string,
      ls_searchresult TYPE /simple/cl_search=>gty_searchresult.

    IF <lt_line_temp> IS ASSIGNED AND <lt_line_temp> IS NOT INITIAL.

      LOOP AT  <lt_line_temp> ASSIGNING <fs_line>.

        LOOP AT lt_sql_select_out INTO lv_sql_select_out.
          DATA(lv_uppercasefield) = lv_sql_select_out.

          TRANSLATE lv_uppercasefield TO UPPER CASE.
          ASSIGN COMPONENT lv_uppercasefield OF STRUCTURE <fs_line> TO <fs_field>.
          lv_value = <fs_field>.
          DESCRIBE FIELD <fs_field> EDIT MASK DATA(lv_mask).
          IF lv_mask IS NOT INITIAL.
            SHIFT lv_mask LEFT BY 2 PLACES.
            lv_routine = lv_mask.

            /simple/cl_search=>call_conversion_routine(
              EXPORTING
                iv_routine  = lv_routine
                iv_is_input = abap_false
              CHANGING
                cv_value    = <fs_field> ).
          ENDIF.

          _concat_search_result( EXPORTING iv_fname = lv_sql_select_out iv_value = <fs_field> CHANGING cv_result = lv_value_string ).
        ENDLOOP.

        lv_value_string = '{' && lv_value_string && '}'.
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>horizontal_tab IN lv_value_string WITH '#'.
        ls_searchresult-value = lv_value_string.
        APPEND ls_searchresult TO cs_data-to_searchresults.
        CLEAR ls_searchresult.
        CLEAR lv_value_string.

      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  METHOD _concat_search_result.
    DATA:
      lv_fname TYPE abap_compdescr-name,
      lv_value TYPE string.

    IF it_bool_tab IS SUPPLIED.
      lv_fname = |{ iv_fname CASE = UPPER }|.
      READ TABLE it_bool_tab TRANSPORTING NO FIELDS
        WITH KEY name = lv_fname BINARY SEARCH.
      IF sy-subrc = 0. " is boolean
        IF iv_value = 'X'.
          lv_value = 'true'.
        ELSE.
          lv_value = 'false'.
        ENDIF.
      ELSE.
        lv_value = iv_value.
        REPLACE ALL OCCURRENCES OF '"' IN lv_value WITH '\"'.
      ENDIF.

    ELSE.
      lv_value = iv_value.
      REPLACE ALL OCCURRENCES OF '"' IN lv_value WITH '\"'.
    ENDIF.

    IF cv_result IS INITIAL.
      cv_result = |"{ iv_fname }": "{ lv_value }"|.
    ELSE.
      cv_result = |{ cv_result }, "{ iv_fname }": "{ lv_value }"|.
    ENDIF.
  ENDMETHOD.


  METHOD _convert_fieldname.
    CASE cv_fieldname.
      WHEN  'PRODUCT'.                        cv_fieldname  =  'product'.
      WHEN  'PRODUCTTYPE'.                    cv_fieldname  =  'productType'.
      WHEN  'CROSSPLANTSTATUS'.               cv_fieldname  =  'crossPlantStatus'.
      WHEN  'CROSSPLANTSTATUSVALIDITYDATE'.   cv_fieldname  =  'crossPlantStatusValidityDate'.
      WHEN  'OBJECTMODEL'.                    cv_fieldname  =  'objectModel'.
      WHEN  'CREATIONDATE'.                   cv_fieldname  =  'creationDate'.
      WHEN  'OBJECTMODEL'.                    cv_fieldname  =  'objectModel'.
      WHEN  'CREATEDBYUSER'.                  cv_fieldname  =  'createdByUser'.
      WHEN  'OBJECTMODEL'.                    cv_fieldname  =  'objectModel'.
      WHEN  'LASTCHANGEDATE'.                 cv_fieldname  =  'lastChangeDate'.
      WHEN  'OBJECTMODEL'.                    cv_fieldname  =  'objectModel'.
      WHEN  'LASTCHANGEDBYUSER'.              cv_fieldname  =  'lastChangedByUser'.
      WHEN  'OBJECTMODEL'.                    cv_fieldname  =  'objectModel'.
      WHEN  'LASTCHANGEDATETIME'.             cv_fieldname  =  'lastChangeDateTime'.
      WHEN  'ISMARKEDFORDELETION'.            cv_fieldname  =  'isMarkedForDeletion'.
      WHEN  'PRODUCTOLDID'.                   cv_fieldname  =  'productOldID'.
      WHEN  'GROSSWEIGHT'.                    cv_fieldname  =  'grossWeight'.
      WHEN  'PURCHASEORDERQUANTITYUNIT'.      cv_fieldname  =  'purchaseOrderQuantityUnit'.
      WHEN  'SOURCEOFSUPPLY'.                 cv_fieldname  =  'sourceOfSupply'.
      WHEN  'WEIGHTUNIT'.                     cv_fieldname  =  'weightUnit'.
      WHEN  'NETWEIGHT'.                      cv_fieldname  =  'netWeight'.
      WHEN  'COUNTRYOFORIGIN'.                cv_fieldname  =  'countryOfOrigin'.
      WHEN  'COMPETITORID'.                   cv_fieldname  =  'competitorID'.
      WHEN  'PRODUCTGROUP'.                   cv_fieldname  =  'productGroup'.
      WHEN  'BASEUNIT'.                       cv_fieldname  =  'baseUnit'.
      WHEN  'ITEMCATEGORYGROUP'.              cv_fieldname  =  'itemCategoryGroup'.
      WHEN  'PRODUCTHIERARCHY'.               cv_fieldname  =  'productHierarchy'.
      WHEN  'DIVISION'.                       cv_fieldname  =  'division'.
      WHEN  'VARBLPURORDUNITISACTIVE'.        cv_fieldname  =  'varblPurOrdUnitIsActive'.
      WHEN  'VOLUMEUNIT'.                     cv_fieldname  =  'volumeUnit'.
      WHEN  'MATERIALVOLUME'.                 cv_fieldname  =  'materialVolume'.
      WHEN  'ANPCODE'.                        cv_fieldname  =  'anpCode'.
      WHEN  'BRAND'.                          cv_fieldname  =  'brand'.
      WHEN  'PROCUREMENTRULE'.                cv_fieldname  =  'procurementRule'.
      WHEN  'VALIDITYSTARTDATE'.              cv_fieldname  =  'validityStartDate'.
      WHEN  'LOWLEVELCODE'.                   cv_fieldname  =  'lowLevelCode'.
      WHEN  'PRODNOINGENPRODINPREPACKPROD'.   cv_fieldname  =  'prodNoInGenProdInPrepackProd'.
      WHEN  'SERIALIDENTIFIERASSGMTPROFILE'.  cv_fieldname  =  'serialIdentifierAssgmtProfile'.
      WHEN  'SIZEORDIMENSIONTEXT'.            cv_fieldname  =  'sizeOrDimensionText'.
      WHEN  'INDUSTRYSTANDARDNAME'.           cv_fieldname  =  'industryStandardName'.
      WHEN  'PRODUCTSTANDARDID'.              cv_fieldname  =  'productStandardID'.
      WHEN  'INTERNATIONALARTICLENUMBERCAT'.  cv_fieldname  =  'internationalArticleNumberCat'.
      WHEN  'PRODUCTISCONFIGURABLE'.          cv_fieldname  =  'productIsConfigurable'.
      WHEN  'ISBATCHMANAGEMENTREQUIRED'.      cv_fieldname  =  'isBatchManagementRequired'.
      WHEN  'EXTERNALPRODUCTGROUP'.           cv_fieldname  =  'externalProductGroup'.
      WHEN  'CROSSPLANTCONFIGURABLEPRODUCT'.  cv_fieldname  =  'crossPlantConfigurableProduct'.
      WHEN  'SERIALNOEXPLICITNESSLEVEL'.      cv_fieldname  =  'serialNoExplicitnessLevel'.
      WHEN  'PRODUCTMANUFACTURERNUMBER'.      cv_fieldname  =  'productManufacturerNumber'.
      WHEN  'MANUFACTURERNUMBER'.             cv_fieldname  =  'manufacturerNumber'.
      WHEN  'MANUFACTURERPARTPROFILE'.        cv_fieldname  =  'manufacturerPartProfile'.
      WHEN  'QLTYMGMTINPROCMTISACTIVE'.       cv_fieldname  =  'qltyMgmtInProcmtIsActive'.
      WHEN  'CHANGENUMBER'.                   cv_fieldname  =  'changeNumber'.
      WHEN  'MATERIALREVISIONLEVEL'.          cv_fieldname  =  'materialRevisionLevel'.
      WHEN  'HANDLINGINDICATOR'.              cv_fieldname  =  'handlingIndicator'.
      WHEN  'WAREHOUSEPRODUCTGROUP'.          cv_fieldname  =  'warehouseProductGroup'.
      WHEN  'WAREHOUSESTORAGECONDITION'.      cv_fieldname  =  'warehouseStorageCondition'.
      WHEN  'STANDARDHANDLINGUNITTYPE'.       cv_fieldname  =  'standardHandlingUnitType'.
      WHEN  'SERIALNUMBERPROFILE'.            cv_fieldname  =  'serialNumberProfile'.
      WHEN  'ADJUSTMENTPROFILE'.              cv_fieldname  =  'adjustmentProfile'.
      WHEN  'PREFERREDUNITOFMEASURE'.         cv_fieldname  =  'preferredUnitOfMeasure'.
      WHEN  'ISPILFERABLE'.                   cv_fieldname  =  'isPilferable'.
      WHEN  'ISRELEVANTFORHZDSSUBSTANCES'.    cv_fieldname  =  'isRelevantForHzdsSubstances'.
      WHEN  'QUARANTINEPERIOD'.               cv_fieldname  =  'quarantinePeriod'.
      WHEN  'TIMEUNITFORQUARANTINEPERIOD'.    cv_fieldname  =  'timeUnitForQuarantinePeriod'.
      WHEN  'QUALITYINSPECTIONGROUP'.         cv_fieldname  =  'qualityInspectionGroup'.
      WHEN  'AUTHORIZATIONGROUP'.             cv_fieldname  =  'authorizationGroup'.
      WHEN  'HANDLINGUNITTYPE'.               cv_fieldname  =  'handlingUnitType'.
      WHEN  'HASVARIABLETAREWEIGHT'.          cv_fieldname  =  'hasVariableTareWeight'.
      WHEN  'MAXIMUMPACKAGINGLENGTH'.         cv_fieldname  =  'maximumPackagingLength'.
      WHEN  'MAXIMUMPACKAGINGWIDTH'.          cv_fieldname  =  'maximumPackagingWidth'.
      WHEN  'MAXIMUMPACKAGINGHEIGHT'.         cv_fieldname  =  'maximumPackagingHeight'.
      WHEN  'UNITFORMAXPACKAGINGDIMENSIONS'.  cv_fieldname  =  'unitForMaxPackagingDimensions'.
      WHEN  'PRODUCTDESCRIPTION'.             cv_fieldname  =  'productDescription'.
      WHEN  'REGIONOFORIGIN'.                 cv_fieldname  =  'regionOfOrigin'.
      WHEN  'PRODUCTIONINVTRYMANAGEDLOC'.     cv_fieldname  =  'productionInvtryManagedLoc'.
      WHEN  'PROFILECODE'.                    cv_fieldname  =  'profileCode'.
      WHEN  'PROFILEVALIDITYSTARTDATE'.       cv_fieldname  =  'profileValidityStartDate'.
      WHEN  'AVAILABILITYCHECKTYPE'.          cv_fieldname  =  'availabilityCheckType'.
      WHEN  'FISCALYEARVARIANT'.              cv_fieldname  =  'fiscalYearVariant'.
      WHEN  'PERIODTYPE'.                     cv_fieldname  =  'periodType'.
      WHEN  'PROFITCENTER'.                   cv_fieldname  =  'profitCenter'.
      WHEN  'COMMODITY'.                      cv_fieldname  =  'commodity'.
      WHEN  'GOODSRECEIPTDURATION'.           cv_fieldname  =  'goodsReceiptDuration'.
      WHEN  'MAINTENANCESTATUSNAME'.          cv_fieldname  =  'maintenanceStatusName'.
      WHEN  'ISMARKEDFORDELETION'.            cv_fieldname  =  'isMarkedForDeletion'.
      WHEN  'MRPTYPE'.                        cv_fieldname  =  'mrpType'.
      WHEN  'MRPRESPONSIBLE'.                 cv_fieldname  =  'mrpResponsible'.
      WHEN  'ABCINDICATOR'.                   cv_fieldname  =  'abcIndicator'.
      WHEN  'MINIMUMLOTSIZEQUANTITY'.         cv_fieldname  =  'minimumLotSizeQuantity'.
      WHEN  'MAXIMUMLOTSIZEQUANTITY'.         cv_fieldname  =  'maximumLotSizeQuantity'.
      WHEN  'FIXEDLOTSIZEQUANTITY'.           cv_fieldname  =  'fixedLotSizeQuantity'.
      WHEN  'CONSUMPTIONTAXCTRLCODE'.         cv_fieldname  =  'consumptionTaxCtrlCode'.
      WHEN  'ISCOPRODUCT'.                    cv_fieldname  =  'isCoProduct'.
      WHEN  'PRODUCTISCONFIGURABLE'.          cv_fieldname  =  'productIsConfigurable'.
      WHEN  'STOCKDETERMINATIONGROUP'.        cv_fieldname  =  'stockDeterminationGroup'.
      WHEN  'STOCKINTRANSFERQUANTITY'.        cv_fieldname  =  'stockInTransferQuantity'.
      WHEN  'STOCKINTRANSITQUANTITY'.         cv_fieldname  =  'stockInTransitQuantity'.
      WHEN  'HASPOSTTOINSPECTIONSTOCK'.       cv_fieldname  =  'hasPostToInspectionStock'.
      WHEN  'ISBATCHMANAGEMENTREQUIRED'.      cv_fieldname  =  'isBatchManagementRequired'.
      WHEN  'SERIALNUMBERPROFILE'.            cv_fieldname  =  'serialNumberProfile'.
      WHEN  'ISNEGATIVESTOCKALLOWED'.         cv_fieldname  =  'isNegativeStockAllowed'.
      WHEN  'GOODSRECEIPTBLOCKEDSTOCKQTY'.    cv_fieldname  =  'goodsReceiptBlockedStockQty'.
      WHEN  'HASCONSIGNMENTCTRL'.             cv_fieldname  =  'hasConsignmentCtrl'.
      WHEN  'FISCALYEARCURRENTPERIOD'.        cv_fieldname  =  'fiscalYearCurrentPeriod'.
      WHEN  'FISCALMONTHCURRENTPERIOD'.       cv_fieldname  =  'fiscalMonthCurrentPeriod'.
      WHEN  'PROCUREMENTTYPE'.                cv_fieldname  =  'procurementType'.
      WHEN  'ISINTERNALBATCHMANAGED'.         cv_fieldname  =  'isInternalBatchManaged'.
      WHEN  'PRODUCTCFOPCATEGORY'.            cv_fieldname  =  'productCFOPCategory'.
      WHEN  'PRODUCTISEXCISETAXRELEVANT'.     cv_fieldname  =  'productIsExciseTaxRelevant'.
      WHEN  'MINIMUMORDERQUANTITY'.           cv_fieldname  =  'minimumOrderQuantity'.
      WHEN  'SUPPLYINGPLANT'.                 cv_fieldname  =  'supplyingPlant'.
      WHEN  'PRICESPECIFICATIONPRODUCTGROUP'. cv_fieldname  =  'priceSpecificationProductGroup'.
      WHEN  'ACCOUNTDETNPRODUCTGROUP'.        cv_fieldname  =  'accountDetnProductGroup'.
      WHEN  'DELIVERYNOTEPROCMINDELIVQTY'.    cv_fieldname  =  'deliveryNoteProcMinDelivQty'.
      WHEN  'ITEMCATEGORYGROUP'.              cv_fieldname  =  'itemCategoryGroup'.
      WHEN  'DELIVERYQUANTITYUNIT'.           cv_fieldname  =  'deliveryQuantityUnit'.
      WHEN  'DELIVERYQUANTITY'.               cv_fieldname  =  'deliveryQuantity'.
      WHEN  'PRODUCTSALESSTATUS'.             cv_fieldname  =  'productSalesStatus'.
      WHEN  'PRODUCTSALESSTATUSVALIDITYDATE'. cv_fieldname  =  'productSalesStatusValidityDate'.
      WHEN  'SALESMEASUREUNIT'.               cv_fieldname  =  'salesMeasureUnit'.
      WHEN  'ISMARKEDFORDELETION'.            cv_fieldname  =  'isMarkedForDeletion'.
      WHEN  'PRODUCTHIERARCHY'.               cv_fieldname  =  'productHierarchy'.
      WHEN  'FIRSTSALESSPECPRODUCTGROUP'.     cv_fieldname  =  'firstSalesSpecProductGroup'.
      WHEN  'SECONDSALESSPECPRODUCTGROUP'.    cv_fieldname  =  'secondSalesSpecProductGroup'.
      WHEN  'THIRDSALESSPECPRODUCTGROUP'.     cv_fieldname  =  'thirdSalesSpecProductGroup'.
      WHEN  'FOURTHSALESSPECPRODUCTGROUP'.    cv_fieldname  =  'fourthSalesSpecProductGroup'.
      WHEN  'FIFTHSALESSPECPRODUCTGROUP'.     cv_fieldname  =  'fifthSalesSpecProductGroup'.
      WHEN  'MINIMUMMAKETOORDERORDERQTY'.     cv_fieldname  =  'minimumMakeToOrderOrderQty'.
      WHEN  'PRODUCT'.                        cv_fieldname  =  'product'.
      WHEN  'COUNTRY'.                        cv_fieldname  =  'country'.
      WHEN  'TAXCATEGORY'.                    cv_fieldname  =  'taxCategory'.
      WHEN  'TAXCLASSIFICATION'.              cv_fieldname  =  'taxClassification'.
      WHEN  'SALESSTATUS'.                    cv_fieldname  =  'salesStatus'.
      WHEN  'SALESSTATUSVALIDITYDATE'.        cv_fieldname  =  'salesStatusValidityDate'.
      WHEN  'TRANSPORTATIONGROUP'.            cv_fieldname  =  'transportationGroup'.
      WHEN  'PURCHASEORDERQUANTITYUNIT'.      cv_fieldname  =  'purchaseOrderQuantityUnit'.
      WHEN  'VARBLPURORDUNITSTATUS'.          cv_fieldname  =  'varblPurOrdUnitStatus'.
      WHEN  'PURCHASINGACKNPROFILE'.          cv_fieldname  =  'purchasingAcknProfile'.
      WHEN  'LANGUAGE'.                       cv_fieldname  =  'language'.
      WHEN  'LONGTEXT'.                       cv_fieldname  =  'longText'.
      WHEN  'ALTERNATIVEUNIT'.                cv_fieldname  =  'alternativeUnit'.
      WHEN  'QUANTITYNUMERATOR'.              cv_fieldname  =  'quantityNumerator'.
      WHEN  'QUANTITYDENOMINATOR'.            cv_fieldname  =  'quantityDenominator'.
      WHEN  'MATERIALVOLUME'.                 cv_fieldname  =  'materialVolume'.
      WHEN  'VOLUMEUNIT'.                     cv_fieldname  =  'volumeUnit'.
      WHEN  'GROSSWEIGHT'.                    cv_fieldname  =  'grossWeight'.
      WHEN  'WEIGHTUNIT'.                     cv_fieldname  =  'weightUnit'.
      WHEN  'GLOBALTRADEITEMNUMBER'.          cv_fieldname  =  'globalTradeItemNumber'.
      WHEN  'GLOBALTRADEITEMNUMBERCATEGORY'.  cv_fieldname  =  'globalTradeItemNumberCategory'.
      WHEN  'UNITSPECIFICPRODUCTLENGTH'.      cv_fieldname  =  'unitSpecificProductLength'.
      WHEN  'UNITSPECIFICPRODUCTWIDTH'.       cv_fieldname  =  'unitSpecificProductWidth'.
      WHEN  'UNITSPECIFICPRODUCTHEIGHT'.      cv_fieldname  =  'unitSpecificProductHeight'.
      WHEN  'PRODUCTMEASUREMENTUNIT'.         cv_fieldname  =  'productMeasurementUnit'.
      WHEN  'LOWERLEVELPACKAGINGUNIT'.        cv_fieldname  =  'lowerLevelPackagingUnit'.
      WHEN  'REMAININGVOLUMEAFTERNESTING'.    cv_fieldname  =  'remainingVolumeAfterNesting'.
      WHEN  'MAXIMUMSTACKINGFACTOR'.          cv_fieldname  =  'maximumStackingFactor'.
      WHEN  'CAPACITYUSAGE'.                  cv_fieldname  =  'capacityUsage'.
      WHEN  'STORAGECONDITIONS'.              cv_fieldname  =  'storageConditions'.
      WHEN  'TEMPERATURECONDITIONIND'.        cv_fieldname  =  'temperatureConditionInd'.
      WHEN  'HAZARDOUSMATERIALNUMBER'.        cv_fieldname  =  'hazardousMaterialNumber'.
      WHEN  'NMBROFGRORGISLIPSTOPRINTQTY'.    cv_fieldname  =  'nmbrOfGROrGISlipsToPrintQty'.
      WHEN  'LABELTYPE'.                      cv_fieldname  =  'labelType'.
      WHEN  'LABELFORM'.                      cv_fieldname  =  'labelForm'.
      WHEN  'MINREMAININGSHELFLIFE'.          cv_fieldname  =  'minRemainingShelfLife'.
      WHEN  'EXPIRATIONDATE'.                 cv_fieldname  =  'expirationDate'.
      WHEN  'VALUATIONAREA'.                  cv_fieldname  =  'valuationArea'.
      WHEN  'VALUATIONTYPE'.                  cv_fieldname  =  'valuationType'.
      WHEN  'VALUATIONCLASS'.                 cv_fieldname  =  'valuationClass'.
      WHEN  'PRICEDETERMINATIONCONTROL'.      cv_fieldname  =  'priceDeterminationControl'.
      WHEN  'STANDARDPRICE'.                  cv_fieldname  =  'standardPrice'.
      WHEN  'PRICEUNITQTY'.                   cv_fieldname  =  'priceUnitQty'.
      WHEN  'INVENTORYVALUATIONPROCEDURE'.    cv_fieldname  =  'inventoryValuationProcedure'.
      WHEN  'MOVINGAVERAGEPRICE'.             cv_fieldname  =  'movingAveragePrice'.
      WHEN  'VALUATIONCATEGORY'.              cv_fieldname  =  'valuationCategory'.
      WHEN  'PRODUCTUSAGETYPE'.               cv_fieldname  =  'productUsageType'.
      WHEN  'PRODUCTORIGINTYPE'.              cv_fieldname  =  'productOriginType'.
      WHEN  'ISPRODUCEDINHOUSE'.              cv_fieldname  =  'isProducedInhouse'.
      WHEN  'PRODCOSTESTNUMBER'.              cv_fieldname  =  'prodCostEstNumber'.
      WHEN  'PROJECTSTOCKVALUATIONCLASS'.     cv_fieldname  =  'projectStockValuationClass'.
      WHEN  'VALUATIONCLASSSALESORDERSTOCK'.  cv_fieldname  =  'valuationClassSalesOrderStock'.
      WHEN  'PLANNEDPRICE1INCOCODECRCY'.      cv_fieldname  =  'plannedPrice1InCoCodeCrcy'.
      WHEN  'PLANNEDPRICE2INCOCODECRCY'.      cv_fieldname  =  'plannedPrice2InCoCodeCrcy'.
      WHEN  'PLANNEDPRICE3INCOCODECRCY'.      cv_fieldname  =  'plannedPrice3InCoCodeCrcy'.
      WHEN  'FUTUREPLNDPRICE1VALDTYDATE'.     cv_fieldname  =  'futurePlndPrice1ValdtyDate'.
      WHEN  'FUTUREPLNDPRICE2VALDTYDATE'.     cv_fieldname  =  'futurePlndPrice2ValdtyDate'.
      WHEN  'FUTUREPLNDPRICE3VALDTYDATE'.     cv_fieldname  =  'futurePlndPrice3ValdtyDate'.
      WHEN  'TAXBASEDPRICESPRICEUNITQTY'.     cv_fieldname  =  'taxBasedPricesPriceUnitQty'.
      WHEN  'PRICELASTCHANGEDATE'.            cv_fieldname  =  'priceLastChangeDate'.
      WHEN  'PLANNEDPRICE'.                   cv_fieldname  =  'plannedPrice'.
      WHEN  'PREVINVTRYPRICEINCOCODECRCY'.    cv_fieldname  =  'prevInvtryPriceInCoCodeCrcy'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD _init_boolean_field.
    et_tab = VALUE #(
              ( name = 'ISDELETED' )
              ( name = 'CLASSISSTANDARDCLASS' )
              ( name = 'BOMISRECURSIVE' )
              ( name = 'CLASSISUSABLEINBOM' )
              ( name = 'CLASSISLOCAL' )
              ( name = 'CHARCISPROPOSALRELEVANT' )
              ( name = 'CHARCISPRPTNORPRODUNITRELEVANT' )
              ( name = 'CHARCISINHERITED' )
    ).
    SORT et_tab BY name.
  ENDMETHOD.


  METHOD _map_table_alias.
    CASE iv_navpath.
      WHEN 'Product' OR 'Products'.
        ev_alias = 't1'.                                                     ev_cds = '/SIMPLE/C_PRODUCT'.
      WHEN 'ProductDescription' OR 'ProductDescriptions'.
        ev_alias = 't2'.                                                     ev_cds = '/SIMPLE/C_PRODUCTDESCRIPTION'.
      WHEN 'ProductPlant' OR 'ProductPlants'.
        ev_alias = 't3'.                                                     ev_cds = '/SIMPLE/C_PRODUCTPLANT'.
      WHEN 'ProductSalesDelivery' OR 'ProductSalesDeliveries'.
        ev_alias = 't4'.                                                     ev_cds = '/SIMPLE/C_PRODUCTSALESDELIVERY'.
      WHEN 'ProductSalesTax' OR 'ProductSalesTaxes'.
        ev_alias = 't5'.                                                     ev_cds = '/SIMPLE/C_PRODUCTSALESTAX'.
      WHEN 'ProductSales' OR 'ProductSaleses'.
        ev_alias = 't6'.                                                     ev_cds = '/SIMPLE/C_PRODUCTSALES'.
      WHEN 'ProductQualityMgmt' OR 'ProductQualityMgmts'.
        ev_alias = 't7'.                                                     ev_cds = '/SIMPLE/C_PRODUCTQUALITYMGMT'.
      WHEN 'ProductProcurement' OR 'ProductProcurements'.
        ev_alias = 't8'.                                                     ev_cds = '/SIMPLE/C_PRODUCTPROCUREMENT'.
      WHEN 'ProductBasicText' OR 'ProductBasicTexts'.
        ev_alias = 't9'.                                                     ev_cds = '/SIMPLE/C_PRODUCTBASICTEXT'.
      WHEN 'ProductUnitsOfMeasure' OR 'ProductUnitsOfMeasures'.
        ev_alias = 't10'.                                                    ev_cds = '/SIMPLE/C_PRDUNITSOFMEASURE'.
      WHEN 'ProductStorage' OR 'ProductStorages'.
        ev_alias = 't11'.                                                    ev_cds = '/SIMPLE/C_PRODUCTSTORAGE'.
      WHEN 'ProductInspectionText' OR 'ProductInspectionTexts'.
        ev_alias = 't12'.                                                    ev_cds = '/SIMPLE/C_PRDINSPECTIONTEXT'.
      WHEN 'ProductPurchaseText' OR 'ProductPurchaseTexts'.
        ev_alias = 't13'.                                                    ev_cds = '/SIMPLE/C_PRODUCTPURCHASETEXT'.
      WHEN 'ProductValuation' OR 'ProductValuations'.
        ev_alias = 't14'.                                                    ev_cds = '/SIMPLE/C_PRODUCTVALUATION'.
      WHEN 'ProductPlantProcurement' OR 'ProductPlantProcurements'.
        ev_alias = 't15'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTPROCUREMENT'.
      WHEN 'ProductStorageLocation' OR 'ProductStorageLocations'.
        ev_alias = 't16'.                                                    ev_cds = '/SIMPLE/C_PRDSTORAGELOCATION'.
      WHEN 'ProductWorkScheduling' OR 'ProductWorkSchedulings'.
        ev_alias = 't17'.                                                    ev_cds = '/SIMPLE/C_PRDWORKSCHEDULING'.
      WHEN 'ProductSupplyPlanning' OR 'ProductSupplyPlannings'.
        ev_alias = 't18'.                                                    ev_cds = '/SIMPLE/C_PRDSUPPLYPLANNING'.
      WHEN 'ProductPlantIntlTrd' OR 'ProductPlantIntlTrds'.
        ev_alias = 't19'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTINTLTRD'.
      WHEN 'ProductClassification' OR 'ProductClassifications'.
        ev_alias = 't20'.                                                    ev_cds = '/SIMPLE/CLASSIFICATION'.
      WHEN 'ProductPlantCosting' OR 'ProductPlantCostings'.
        ev_alias = 't21'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTCOSTING'.
      WHEN 'ProductPlantForecasting' OR 'ProductPlantForecastings'.
        ev_alias = 't22'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTFORECASTING'.
      WHEN 'ProductPlantQualityMgmt' OR 'ProductPlantQualityMgmts'.
        ev_alias = 't23'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTQUALITYMGMT'.
      WHEN 'ProductPlantSales' OR 'ProductPlantSaleses'.
        ev_alias = 't24'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTSALES'.
      WHEN 'ProductPlantStorage' OR 'ProductPlantStorages'.
        ev_alias = 't25'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTSTORAGE'.
      WHEN 'ProductPlantText' OR 'ProductPlantTexts'.
        ev_alias = 't26'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTTEXT'.
      WHEN 'ProductPlantMrpArea' OR 'ProductPlantMrpAreas'.
        ev_alias = 't27'.                                                    ev_cds = '/SIMPLE/C_PRDPLANTMRPAREA'.
      WHEN 'ProductSalesText' OR 'ProductSalesTexts'.
        ev_alias = 't28'.                                                    ev_cds = '/SIMPLE/C_PRODUCTSALESTEXT'.
      WHEN 'ProductUnitsOfMeasureEAN' OR 'ProductUnitsOfMeasureEANs'.
        ev_alias = 't29'.                                                    ev_cds = '/SIMPLE/C_PRDUNITSOFMEASUREEAN'.
      WHEN 'ProductValuationAccount' OR 'ProductValuationAccounts'.
        ev_alias = 't30'.                                                    ev_cds = '/SIMPLE/C_PRDVALUATIONACCOUNT'.
      WHEN 'ProductMLAccount' OR 'ProductMLAccounts'.
        ev_alias = 't31'.                                                    ev_cds = '/SIMPLE/C_PRODUCTMLACCOUNT'.
      WHEN 'ProductMLPrices' OR 'ProductMLPriceses'.
        ev_alias = 't32'.                                                    ev_cds = '/SIMPLE/C_PRODUCTMLPRICES'.
      WHEN 'ProdPlntFcstParam' OR 'ProdPlntFcstParams'.
        ev_alias = 't33'.                                                    ev_cds = '/SIMPLE/C_PRDPLNTFCSTPARAMS'.
      WHEN 'InspTypeSttng' OR 'InspTypeSttngs'.
        ev_alias = 't34'.                                                    ev_cds = '/SIMPLE/C_PRDINSPTYPESTTNG'.
      WHEN 'ProductWareHouse' OR 'ProductWareHouses'.
        ev_alias = 't35'.                                                    ev_cds = '/SIMPLE/C_PRODUCTWAREHOUSE'.
      WHEN 'ProductStorageType' OR 'ProductStorageTypes'.
        ev_alias = 't36'.                                                    ev_cds = '/SIMPLE/C_PRODUCTSTORAGETYPE'.
      WHEN OTHERS. CLEAR: ev_alias, ev_cds.
    ENDCASE.
  ENDMETHOD.


  METHOD _MAP_TABLE_ALIAS_FUZZY.
    CASE iv_navpath.
      WHEN 'Product' OR 'Products'.
        ev_alias = 't1'.                                                     ev_cds = '/SIMPLE/CPRD'.
      WHEN 'ProductDescription' OR 'ProductDescriptions'.
        ev_alias = 't2'.                                                     ev_cds = '/SIMPLE/CPRDD'.
      WHEN 'ProductPlant' OR 'ProductPlants'.
        ev_alias = 't3'.                                                     ev_cds = '/SIMPLE/CPRDP'.
      WHEN 'ProductSalesDelivery' OR 'ProductSalesDeliveries'.
        ev_alias = 't4'.                                                     ev_cds = '/SIMPLE/CPRDSD'.
      WHEN 'ProductSalesTax' OR 'ProductSalesTaxes'.
        ev_alias = 't5'.                                                     ev_cds = '/SIMPLE/CPRDST'.
      WHEN 'ProductSales' OR 'ProductSaleses'.
        ev_alias = 't6'.                                                     ev_cds = '/SIMPLE/C_PRODUCTSALES'.
      WHEN 'ProductQualityMgmt' OR 'ProductQualityMgmts'.
        ev_alias = 't7'.                                                     ev_cds = '/SIMPLE/CPRDS'.
      WHEN 'ProductProcurement' OR 'ProductProcurements'.
        ev_alias = 't8'.                                                     ev_cds = '/SIMPLE/CPRDPR'.
      WHEN 'ProductBasicText' OR 'ProductBasicTexts'.
        ev_alias = 't9'.                                                     ev_cds = '/SIMPLE/CPRDBT'.
      WHEN 'ProductUnitsOfMeasure' OR 'ProductUnitsOfMeasures'.
        ev_alias = 't10'.                                                    ev_cds = '/SIMPLE/CPRDUOM'.
      WHEN 'ProductStorage' OR 'ProductStorages'.
        ev_alias = 't11'.                                                    ev_cds = '/SIMPLE/CPRDSL'.
      WHEN 'ProductInspectionText' OR 'ProductInspectionTexts'.
        ev_alias = 't12'.                                                    ev_cds = '/SIMPLE/CPRDIT'.
      WHEN 'ProductPurchaseText' OR 'ProductPurchaseTexts'.
        ev_alias = 't13'.                                                    ev_cds = '/SIMPLE/CPRDPT'.
      WHEN 'ProductValuation' OR 'ProductValuations'.
        ev_alias = 't14'.                                                    ev_cds = '/SIMPLE/CPRDV'.
      WHEN 'ProductPlantProcurement' OR 'ProductPlantProcurements'.
        ev_alias = 't15'.                                                    ev_cds = '/SIMPLE/CPRDPPR'.
      WHEN 'ProductStorageLocation' OR 'ProductStorageLocations'.
        ev_alias = 't16'.                                                    ev_cds = '/SIMPLE/CPRDSL'.
      WHEN 'ProductWorkScheduling' OR 'ProductWorkSchedulings'.
        ev_alias = 't17'.                                                    ev_cds = '/SIMPLE/CPRDWS'.
      WHEN 'ProductSupplyPlanning' OR 'ProductSupplyPlannings'.
        ev_alias = 't18'.                                                    ev_cds = '/SIMPLE/CPRDSP'.
      WHEN 'ProductPlantIntlTrd' OR 'ProductPlantIntlTrds'.
        ev_alias = 't19'.                                                    ev_cds = '/SIMPLE/CPRDPIT'.
      WHEN 'ProductClassification' OR 'ProductClassifications'.
        ev_alias = 't20'.                                                    ev_cds = '/SIMPLE/CPRDC'.
      WHEN 'ProductPlantCosting' OR 'ProductPlantCostings'.
        ev_alias = 't21'.                                                    ev_cds = '/SIMPLE/CPRDPC'.
      WHEN 'ProductPlantForecasting' OR 'ProductPlantForecastings'.
        ev_alias = 't22'.                                                    ev_cds = '/SIMPLE/CPRDPF'.
      WHEN 'ProductPlantQualityMgmt' OR 'ProductPlantQualityMgmts'.
        ev_alias = 't23'.                                                    ev_cds = '/SIMPLE/CPRDPQM'.
      WHEN 'ProductPlantSales' OR 'ProductPlantSaleses'.
        ev_alias = 't24'.                                                    ev_cds = '/SIMPLE/CPRDPS'.
      WHEN 'ProductPlantStorage' OR 'ProductPlantStorages'.
        ev_alias = 't25'.                                                    ev_cds = '/SIMPLE/CPRDPSTR'.
      WHEN 'ProductPlantText' OR 'ProductPlantTexts'.
        ev_alias = 't26'.                                                    ev_cds = '/SIMPLE/CPRDPLT'.
      WHEN 'ProductPlantMrpArea' OR 'ProductPlantMrpAreas'.
        ev_alias = 't27'.                                                    ev_cds = '/SIMPLE/CPRDPMRP'.
      WHEN 'ProductSalesText' OR 'ProductSalesTexts'.
        ev_alias = 't28'.                                                    ev_cds = '/SIMPLE/CPRDST'.
      WHEN 'ProductUnitsOfMeasureEAN' OR 'ProductUnitsOfMeasureEANs'.
        ev_alias = 't29'.                                                    ev_cds = '/SIMPLE/CPRDEAN'.
      WHEN 'ProductValuationAccount' OR 'ProductValuationAccounts'.
        ev_alias = 't30'.                                                    ev_cds = '/SIMPLE/CPRDVA'.
      WHEN 'ProductMLAccount' OR 'ProductMLAccounts'.
        ev_alias = 't31'.                                                    ev_cds = '/SIMPLE/CPRDMLA'.
      WHEN 'ProductMLPrices' OR 'ProductMLPriceses'.
        ev_alias = 't32'.                                                    ev_cds = '/SIMPLE/CPRDMLP'.
      WHEN 'ProdPlntFcstParam' OR 'ProdPlntFcstParams'.
        ev_alias = 't33'.                                                    ev_cds = '/SIMPLE/CPRDPFP'.
      WHEN 'InspTypeSttng' OR 'InspTypeSttngs'.
        ev_alias = 't34'.                                                    ev_cds = '/SIMPLE/CPRDITS'.
      WHEN 'ProductWareHouse' OR 'ProductWareHouses'.
        ev_alias = 't35'.                                                    ev_cds = '/SIMPLE/CPRDWH'.
      WHEN 'ProductStorageType' OR 'ProductStorageTypes'.
        ev_alias = 't36'.                                                    ev_cds = '/SIMPLE/CPRDSTOT'.
      WHEN OTHERS. CLEAR: ev_alias, ev_cds.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
