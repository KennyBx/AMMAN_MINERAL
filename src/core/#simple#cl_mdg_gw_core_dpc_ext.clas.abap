class /SIMPLE/CL_MDG_GW_CORE_DPC_EXT definition
  public
  inheriting from /SIMPLE/CL_MDG_GW_CORE_DPC
  create public .

public section.

  types:
    BEGIN OF ty_clause,
        line(256) TYPE c,
      END OF ty_clause .
  types:
    tt_clause TYPE TABLE OF ty_clause .
  types:
    BEGIN OF ts_dynamic_where,
        field TYPE  string,
        opera TYPE  char2,
        low   TYPE  hrvalue,
        high  TYPE  hrvalue,
      END OF  ts_dynamic_where .
  types:
    tt_dynamic_where TYPE TABLE OF ts_dynamic_where .
  types:
    BEGIN OF ts_response_me,
*        action         TYPE  char10,
        mdglogid              TYPE  char36,
        actionmode            TYPE  char20,
        activateid            TYPE  char20,
        crnumber              TYPE  char20,
        critem                TYPE  char20,
        activateitemid        TYPE  char20,
        mdkey                 TYPE /simple/key,
*---BEN added 05182023
        messaging_core        TYPE string,
        messaging_object_type TYPE string,
*---BEN added 05182023
      END OF  ts_response_me .
  types:
    tt_response_me TYPE TABLE OF ts_response_me .

  class-data MV_BATCH type XFELD .
  constants GC_LOG_PRODUCT type /SIMPLE/OBJ_TP value 'Product' ##NO_TEXT.
  constants GC_LOG_PROFITCENTER type /SIMPLE/OBJ_TP value 'ProfitCenter' ##NO_TEXT.
  constants GC_LOG_COSTCENTER type /SIMPLE/OBJ_TP value 'CostCenter' ##NO_TEXT.
  constants GC_LOG_VIPO type /SIMPLE/OBJ_TP value 'VendorInvoice' ##NO_TEXT.
  constants GC_LOG_GLACCOUNT type /SIMPLE/OBJ_TP value 'GLAccount' ##NO_TEXT.
  constants GC_LOG_GL type /SIMPLE/OBJ_TP value 'GLAccountInChartOfAccounts' ##NO_TEXT.
  constants GC_LOG_BOM type /SIMPLE/OBJ_TP value 'BillOfMaterial' ##NO_TEXT.
  constants GC_LOG_PCH type /SIMPLE/OBJ_TP value 'ProfitCenterHierarchy' ##NO_TEXT.
  constants GC_LOG_BP type /SIMPLE/OBJ_TP value 'BusinessPartner' ##NO_TEXT.
  constants GC_LOG_OBJ type BALOBJ_D value '/SIMPLE/MDG' ##NO_TEXT.
  constants GC_LOG_ROUTING type /SIMPLE/OBJ_TP value 'Routing' ##NO_TEXT.
  constants GC_LOG_WORKCENTER type /SIMPLE/OBJ_TP value 'WorkCenter' ##NO_TEXT.
  constants GC_LOG_INTERNAL_ORDER type /SIMPLE/OBJ_TP value 'InternalOrder' ##NO_TEXT.
  constants GC_LOG_SAMPLINGSCHEME type /SIMPLE/OBJ_TP value 'SamplingScheme' ##NO_TEXT.
  constants GC_LOG_PV type /SIMPLE/OBJ_TP value 'ProductionVersion' ##NO_TEXT.
  constants GC_LOG_AH type /SIMPLE/OBJ_TP value 'Article Hierarchy' ##NO_TEXT.
  constants GC_LOG_AM type /SIMPLE/OBJ_TP value 'AssetMaster' ##NO_TEXT.
  constants GC_LOG_CCH type /SIMPLE/OBJ_TP value 'CostCenterHierachy' ##NO_TEXT.
  constants GC_LOG_CMI type /SIMPLE/OBJ_TP value 'CustomerMaterialInfoRecord' ##NO_TEXT.
  constants GC_LOG_CCG type /SIMPLE/OBJ_TP value 'CatalogueCodeGroup' ##NO_TEXT.
  constants GC_LOG_SL type /SIMPLE/OBJ_TP value 'SourceList' ##NO_TEXT.
  constants GC_LOG_BCL type /SIMPLE/OBJ_TP value 'BatchChangesConsumption' ##NO_TEXT.
  constants GC_LOG_BM type /SIMPLE/OBJ_TP value 'BankMaster' ##NO_TEXT.
  constants GC_LOG_IOG type /SIMPLE/OBJ_TP value 'InterrnalOrderGroup' ##NO_TEXT.
  constants GC_LOG_AT type /SIMPLE/OBJ_TP value 'ActivityType' ##NO_TEXT.
  constants GC_LOG_PRC type /SIMPLE/OBJ_TP value 'PricingCondition' ##NO_TEXT.
  constants GC_LOG_PRI type /SIMPLE/OBJ_TP value 'PricingCondition' ##NO_TEXT.
  constants GC_LOG_SKF type /SIMPLE/OBJ_TP value 'StatisticalKeyFigures' ##NO_TEXT.
  constants GC_LOG_PCR type /SIMPLE/OBJ_TP value 'PricingConditionRecord' ##NO_TEXT.
  constants GC_LOG_SAMPLINGPROCEDURE type /SIMPLE/OBJ_TP value 'SamplingProcedure' ##NO_TEXT.
  constants GC_LOG_QIR type /SIMPLE/OBJ_TP value 'QualityInfoRecord' ##NO_TEXT.
  constants GC_LOG_SET type /SIMPLE/OBJ_TP value 'FICOSet' ##NO_TEXT.
  constants GC_LOG_AR type /SIMPLE/OBJ_TP value 'ActivityRate' ##NO_TEXT.
  constants GC_LOG_SC type /SIMPLE/OBJ_TP value 'SamplingScheme' ##NO_TEXT.
  constants GC_LOG_PI type /SIMPLE/OBJ_TP value 'PackingInstruction' ##NO_TEXT.
  constants GC_LOG_SSC type /SIMPLE/OBJ_TP value 'SelectedSetCode' ##NO_TEXT.
  constants GC_LOG_MIX type /SIMPLE/OBJ_TP value 'MixedCosting' ##NO_TEXT.
  constants GC_LOG_PIR type /SIMPLE/OBJ_TP value 'PurchasingInfoRecord' ##NO_TEXT.
  constants GC_LOG_CEG type /SIMPLE/OBJ_TP value 'CostElementGroup' ##NO_TEXT.
  constants GC_LOG_MIC type /SIMPLE/OBJ_TP value 'MasterInspectionCharacteristic' ##NO_TEXT.
  constants GC_LOG_CL type /SIMPLE/OBJ_TP value 'Classification' ##NO_TEXT.
  constants GC_LOG_MPOI type /SIMPLE/OBJ_TP value 'PMMeasuringPoint' ##NO_TEXT.
  constants GC_LOG_OG type /SIMPLE/OBJ_TP value 'OrderGroup' ##NO_TEXT.
  constants GC_LOG_ZATT type /SIMPLE/OBJ_TP value 'AttributesMaster' ##NO_TEXT.
  constants GC_LOG_BIN type /SIMPLE/OBJ_TP value 'BinMaster' ##NO_TEXT.
  constants GC_LOG_IM type /SIMPLE/OBJ_TP value 'InspectionMethod' ##NO_TEXT.
  constants GC_LOG_ZATG type /SIMPLE/OBJ_TP value 'AttributeGroup' ##NO_TEXT.
  constants GC_LOG_ECM type /SIMPLE/OBJ_TP value 'ChangeMaster' ##NO_TEXT.
  constants GC_LOG_MC type /SIMPLE/OBJ_TP value 'MerchCategory' ##NO_TEXT.
  constants GC_LOG_MCH type /SIMPLE/OBJ_TP value 'MCHierarchy' ##NO_TEXT.
  constants GC_LOG_MD type /SIMPLE/OBJ_TP value 'MaterialDetermination' ##NO_TEXT.
  constants GC_LOG_CCGR type /SIMPLE/OBJ_TP value 'CostCenterGroup' ##NO_TEXT.
  constants GC_LOG_ART type /SIMPLE/OBJ_TP value 'ArticleMaster' ##NO_TEXT.
  constants GC_LOG_SERV type /SIMPLE/OBJ_TP value 'ServiceMaster' ##NO_TEXT.
  constants GC_NEW_PARAGRAPH type TDFORMAT value '*' ##NO_TEXT.
  constants GC_CONTINUATION type TDFORMAT value '=' ##NO_TEXT.
  constants GC_MESSAGE_NEWLINE type CHAR2 value '\n' ##NO_TEXT.
  class-data GV_TSTOP type TYPINT .
  class-data GV_TSTART type TYPINT .
  class-data GV_MESSAGING_CORE type STRING .
  class-data GV_MESSAGING_OBJECT_TYPE type STRING .
  constants GC_MULTIPLE_HOST_TYPE type /SIMPLE/HOST_TYPE value 'MULTIPLE' ##NO_TEXT.
  constants GC_SINGLE_HOST_TYPE type /SIMPLE/HOST_TYPE value 'SINGLE' ##NO_TEXT.

*---BLE start 02162023
  class-methods HANDLE_APPL_LOG
    importing
      !IS_RESPONSE type TS_RESPONSE_ME
      value(IT_MESSAGE) type BAPIRET2_T optional
      !IV_SUBOBJECT type /SIMPLE/OBJ_TP
      value(IV_STATUS) type /SIMPLE/STAT optional
      value(IV_STEP) type /SIMPLE/DE_LOG_STEP optional
      value(IT_MESSAGE2) type BAPIRET2_T optional
    changing
      value(CS_LOG) type /SIMPLE/API_LOG optional .
*---BLE End 02162023
*---BLE start 02212023
  class-methods HANDLE_QUEUE_RFC
    importing
      !IS_UNIT type ref to IF_QRFC_UNIT_INBOUND
      !IV_MASS_RUN type BOOLEAN optional
      !IV_QUEUE_ID type STRING optional
    exceptions
      EO_EXCEPTION .
*---BLE End 02212023
  class-methods CREATE_APPL_LOG
    importing
      !IV_EXTNUMBER type BALNREXT
      !IV_OBJECT type BALOBJ_D default '/SIMPLE/MDG'
      !IV_SUBOBJECT type /SIMPLE/OBJ_TP
    returning
      value(EV_LOG_HANDLE) type BALLOGHNDL .
  class-methods ADD_MESSAGE_TO_LOG
    importing
      !IS_MESSAGE type BAL_S_MSG
      !IV_LOG_HANDLE type BALLOGHNDL .
  class-methods SAVE_APPL_LOG
    importing
      !IV_LOG_HANDLE type BALLOGHNDL .
  class-methods UPDATE_LOG_TABLE
    importing
      !IS_LOG type /SIMPLE/API_LOG .
  class-methods BUILD_DYNAMIC_WHERE
    importing
      !IT_CONTAB type TT_DYNAMIC_WHERE
    exporting
      !ET_WHERE_CLAUSE type TT_CLAUSE
    exceptions
      EMPTY_CONDTAB
      NO_DB_FIELD
      UNKNOWN_DB
      WRONG_CONDITION .
  class-methods CONVERT_ITF_TO_STRING
    importing
      !IT_TEXT_AS_ITF type TLINETAB
    exporting
      !EV_TEXT_AS_STRING type STRING .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  PROTECTED SECTION.

    METHODS searchbusinesspa_get_entityset
        REDEFINITION .
*  methods XSIMPLEXMDCOST02_GET_ENTITYSET
*    redefinition .
*  methods XSIMPLEXMDPROF01_GET_ENTITYSET
*    redefinition .
*  methods XSIMPLEXMDCOST03_GET_ENTITYSET
*    redefinition .
    METHODS xsimplexmdrela01_get_entityset
        REDEFINITION .
    METHODS xsimplexmdrela02_get_entityset
        REDEFINITION .
    METHODS xsimplexmdtaxcat_get_entityset
        REDEFINITION .
  PRIVATE SECTION.

    CLASS-DATA gv_partner TYPE bu_partner .
    CLASS-DATA gv_partner_guid TYPE sysuuid_x16 .
    DATA:
      BEGIN OF customer_sales_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_customersalesareatype.
    DATA: to_salesareatax    TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_customersalesareataxtype,
        to_partnerfunction TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_custsalespartnerfunctype,
      END OF customer_sales_struc .
    DATA:
      BEGIN OF customer_company_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_customercompanytype.
    DATA: to_customerdunning TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_customerdunningtype,
        to_withholdingtax  TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_customerwithholdingtaxtyp,
      END OF customer_company_struc .
    DATA:
      BEGIN OF customer_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_customertype.
    DATA: to_customercompany   LIKE STANDARD TABLE OF customer_company_struc,
        to_customersalesarea LIKE STANDARD TABLE OF customer_sales_struc,
      END OF customer_struc .
    DATA:
      BEGIN OF supplier_company_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_suppliercompanytype.
    DATA: to_supplierdunning        TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_supplierdunningtype,
        to_supplierwithholdingtax TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_supplierwithholdingtaxtyp,
      END OF supplier_company_struc .
    DATA:
      BEGIN OF supplier_purchasing_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_supplierpurchasingorgtype.
    DATA: to_partnerfunction TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_supplierpartnerfunctype,
      END OF supplier_purchasing_struc .
    DATA:
      BEGIN OF supplier_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_suppliertype.
    DATA: to_suppliercompany       LIKE STANDARD TABLE OF supplier_company_struc,
        to_supplierpurchasingorg LIKE STANDARD TABLE OF supplier_purchasing_struc,
      END OF supplier_struc .
    DATA:
*  data:
*    BEGIN OF address_struc.
*        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_addresstype.
*    DATA: to_phonenumber       TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
*          to_mobilephonenumber TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
*          to_faxnumber         TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype,
*          to_emailaddress      TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressemailaddresstype,
*          to_urladdress        TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addresshomepageurltype,
*          END OF address_struc .
      BEGIN OF bupa_address_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_businesspartneraddresstyp.
    DATA: to_addressusage      TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_bupaaddressusagetype,
        to_phonenumber       TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
        to_mobilephonenumber TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
        to_faxnumber         TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype,
        to_emailaddress      TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressemailaddresstype,
        to_urladdress        TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addresshomepageurltype,
      END OF bupa_address_struc .
    DATA:
      BEGIN OF contact_addr_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttoaddresstype.
    DATA: to_phonenumber       TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
        to_mobilephonenumber TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
        to_faxnumber         TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype,
        to_emailaddress      TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addressemailaddresstype,
        to_urladdress        TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_addresshomepageurltype,
      END OF contact_addr_struc .
    DATA:
      BEGIN OF contact_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_businesspartnercontacttyp.
    DATA: to_contactaddress      LIKE STANDARD TABLE OF contact_addr_struc,
        to_contactrelationship TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttofuncanddepttyp,

      END OF contact_struc .
    DATA:
      BEGIN OF partner_struc.
        INCLUDE TYPE cl_api_business_partne_mpc=>ts_a_businesspartnertype.

    DATA: to_businesspartnerbank    TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_businesspartnerbanktype,
        to_bupaidentification     TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_bupaidentificationtype,
        to_businesspartnerrole    TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_businesspartnerroletype,
        to_businesspartnertax     TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_businesspartnertaxnumbert,
        to_businesspartneraddress LIKE STANDARD TABLE OF bupa_address_struc,
        to_businesspartnercontact LIKE STANDARD TABLE OF contact_struc,
        to_customer               LIKE  customer_struc,
        to_supplier               LIKE supplier_struc,
      END OF partner_struc .
    CLASS-DATA gs_data TYPE cvis_ei_extern .
    CLASS-DATA st_nriv TYPE nriv_tt .
    CLASS-DATA gv_bp_grouping TYPE bu_group .

    METHODS fill_deep_address
      IMPORTING
        !iv_task            TYPE char1
      EXPORTING
        !et_partner_address TYPE bus_ei_bupa_address_t
      CHANGING
        !ct_partner_address TYPE any .
    METHODS create_product_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_deep_customer_companycode
      IMPORTING
        !iv_task                      TYPE char1
        !it_customer_companycode_data TYPE any
      EXPORTING
        !et_customer_companycode_data TYPE cmds_ei_company_t .
    METHODS get_product_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_salesarea_tax_data
      IMPORTING
        !iv_task      TYPE char1
        !is_sales_tax TYPE cl_api_business_partne_mpc=>ts_a_customersalesareataxtype
      EXPORTING
        !es_sales_tax TYPE cmds_ei_tax_ind .
    METHODS change_bp_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS delete_product_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_deep_customer_salesarea
      IMPORTING
        !iv_task               TYPE char1
        !it_customer_salesarea TYPE any
        !iv_customer           TYPE kunnr OPTIONAL
      EXPORTING
        !et_customer_salesarea TYPE cmds_ei_sales_t .
    METHODS get_bp_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_deep_supplier_purchase
      IMPORTING
        !iv_task                   TYPE char1
        !it_supplier_purchase_data TYPE any
        !iv_supplier               TYPE lifnr OPTIONAL
      EXPORTING
        !et_supplier_purchase_data TYPE vmds_ei_purchasing_t .
    METHODS create_bp_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_deep_supplier_companycode
      IMPORTING
        !iv_task                      TYPE char1
        !it_supplier_companycode_data TYPE any
      EXPORTING
        !et_supplier_companycode_data TYPE vmds_ei_company_t .
    METHODS change_product_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS map_response
      IMPORTING
        !is_data TYPE any
      CHANGING
        !cr_data TYPE REF TO data .
    METHODS convert_timestamp_to_date_op
      CHANGING
        !ct_select_option TYPE /simple/cl_mdg_gw_core_mpc_ext=>tt_select_option .
    METHODS fill_deep_contact_data
      IMPORTING
        !iv_task             TYPE char1
        !it_partner_relation TYPE any
      EXPORTING
        !et_partner_relation TYPE burs_ei_extern_t .
    METHODS delete_bp_data
      IMPORTING
        !is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type
      CHANGING
        !er_deep_entity TYPE data
      RAISING
        /simple/cx_custom_error .
    METHODS fill_bp_identification_data
      IMPORTING
        !iv_task                   TYPE char1
        !is_partner_identification TYPE cl_api_business_partne_mpc=>ts_a_bupaidentificationtype
      EXPORTING
        !es_partner_identification TYPE bus_ei_bupa_identification .
    METHODS convert_timestamp_to_date
      IMPORTING
        VALUE(iv_timestamp) TYPE timestamp
      RETURNING
        VALUE(rv_date)      TYPE dats .
    METHODS fill_taxnumber_data
      IMPORTING
        !iv_task           TYPE char1
        !is_partner_taxnum TYPE cl_api_business_partne_mpc=>ts_a_businesspartnertaxnumbert
      EXPORTING
        !es_partner_taxnum TYPE bus_ei_bupa_taxnumber .
    METHODS fill_bp_data
      IMPORTING
        !iv_task         TYPE char1
        !is_partner_data TYPE cl_api_business_partne_mpc=>ts_a_businesspartnertype .
    METHODS fill_bp_role_data
      IMPORTING
        !iv_task         TYPE char1
        !is_partner_role TYPE cl_api_business_partne_mpc=>ts_a_businesspartnerroletype
      EXPORTING
        !es_partner_role TYPE bus_ei_bupa_roles .
    METHODS fill_bank_data
      IMPORTING
        !iv_task         TYPE char1
        !is_partner_bank TYPE cl_api_business_partne_mpc=>ts_a_businesspartnerbanktype
      EXPORTING
        !es_partner_bank TYPE bus_ei_bupa_bankdetail .
    METHODS fill_customer_general_data
      IMPORTING
        !iv_task          TYPE char1
        !is_customer_data TYPE cl_api_business_partne_mpc=>ts_a_customertype .
    METHODS fill_customer_companycode_data
      IMPORTING
        !iv_task         TYPE char1
        !is_company_data TYPE cl_api_business_partne_mpc=>ts_a_customercompanytype
      EXPORTING
        !es_company_data TYPE cmds_ei_company .
    METHODS fill_customer_salesarea_data
      IMPORTING
        !iv_task       TYPE char1
        !is_sales_data TYPE cl_api_business_partne_mpc=>ts_a_customersalesareatype
      EXPORTING
        !es_sales_data TYPE cmds_ei_sales .
    METHODS fill_supplier_general_data
      IMPORTING
        !iv_task          TYPE char1
        !is_supplier_data TYPE cl_api_business_partne_mpc=>ts_a_suppliertype .
    METHODS fill_supplier_companycode_data
      IMPORTING
        !iv_task         TYPE char1
        !is_company_data TYPE cl_api_business_partne_mpc=>ts_a_suppliercompanytype
      EXPORTING
        !es_company_data TYPE vmds_ei_company .
    METHODS fill_supplier_purchase_data
      IMPORTING
        !iv_task          TYPE char1
        !is_purchase_data TYPE cl_api_business_partne_mpc=>ts_a_supplierpurchasingorgtype
      EXPORTING
        !es_purchase_data TYPE vmds_ei_purchasing .
    METHODS fill_supplier_wtax_data
      IMPORTING
        !iv_task          TYPE char1
        !is_supplier_wtax TYPE cl_api_business_partne_mpc=>ts_a_supplierwithholdingtaxtyp
      EXPORTING
        !es_supplier_wtax TYPE vmds_ei_wtax_type .
    METHODS fill_supplier_partner_func
      IMPORTING
        !iv_task              TYPE char1
        !is_supplier_function TYPE cl_api_business_partne_mpc=>ts_a_supplierpartnerfunctype
        !iv_supplier          TYPE lifnr OPTIONAL
      EXPORTING
        !es_supplier_function TYPE vmds_ei_functions .
    METHODS fill_supplier_dunning_data
      IMPORTING
        !iv_task             TYPE char1
        !is_supplier_dunning TYPE cl_api_business_partne_mpc=>ts_a_supplierdunningtype
      EXPORTING
        !es_supplier_dunning TYPE vmds_ei_dunning .
    METHODS fill_customer_dunning_data
      IMPORTING
        !iv_task             TYPE char1
        !is_customer_dunning TYPE cl_api_business_partne_mpc=>ts_a_customerdunningtype
      EXPORTING
        !es_customer_dunning TYPE cmds_ei_dunning .
    METHODS fill_customer_partner_func
      IMPORTING
        !iv_task              TYPE char1
        !is_customer_function TYPE cl_api_business_partne_mpc=>ts_a_custsalespartnerfunctype
        !iv_customer          TYPE kunnr OPTIONAL
      EXPORTING
        !es_customer_function TYPE cmds_ei_functions .
    METHODS fill_customer_wtax_data
      IMPORTING
        !iv_task          TYPE char1
        !is_customer_wtax TYPE cl_api_business_partne_mpc=>ts_a_customerwithholdingtaxtyp
      EXPORTING
        !es_customer_wtax TYPE cmds_ei_wtax_type .
    METHODS fill_address_data
      IMPORTING
        !iv_task         TYPE char1
        !is_address_data TYPE cl_api_business_partne_mpc=>ts_a_businesspartneraddresstyp
      EXPORTING
        !es_address_data TYPE bus_ei_bupa_address .
    METHODS fill_address_usage_data
      IMPORTING
        !iv_task               TYPE char1
        !is_address_usage_data TYPE cl_api_business_partne_mpc=>ts_a_bupaaddressusagetype
      EXPORTING
        !es_address_usage_data TYPE bus_ei_bupa_addressusage .
    METHODS fill_contact_data
      IMPORTING
        !iv_task            TYPE char1
        !is_partner_contact TYPE cl_api_business_partne_mpc=>ts_a_businesspartnercontacttyp
      EXPORTING
        !es_partner_contact TYPE burs_ei_extern .
    METHODS changeset_add_bp_number
      CHANGING
        !cs_data TYPE any .
    METHODS get_target_entity
      IMPORTING
        !is_changeset_request TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request
      RETURNING
        VALUE(rv_result)      TYPE string .
    METHODS process_request
      IMPORTING
        !is_changeset_request TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request
      EXPORTING
        !er_entity            TYPE any
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS check_key_fields
      IMPORTING
        VALUE(iv_entity_name) TYPE string
        !is_entity_1          TYPE any
        !is_entity_2          TYPE any
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_bp_contact_function
      IMPORTING
        !iv_task                 TYPE char1
        !is_partner_contact_func TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttofuncanddepttyp
      EXPORTING
        !es_partner_contact_func TYPE burs_ei_rel_contact .
    METHODS export_messages
      IMPORTING
        VALUE(iv_error)       TYPE string
        VALUE(iv_entity_name) TYPE string
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_communication_data
      IMPORTING
        !iv_task              TYPE char1
        !is_data              TYPE any
        VALUE(iv_entity_name) TYPE string
        !iv_remarks_exists    TYPE boolean OPTIONAL
      EXPORTING
        !es_data              TYPE any .
    METHODS populate_key_fields
      IMPORTING
        VALUE(iv_entity_name) TYPE string
        !io_data_provider     TYPE REF TO /iwbep/if_mgw_entry_provider
      EXPORTING
        VALUE(et_keys)        TYPE /iwbep/t_mgw_tech_pairs
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_bp_industry_data
      IMPORTING
        !iv_task             TYPE char1
        !is_partner_industry TYPE cl_api_business_partne_mpc=>ts_a_bupaindustrytype
      EXPORTING
        !es_partner_industry TYPE bus_ei_bupa_industrysector .
    METHODS fill_address_comm_phone_data
      IMPORTING
        !iv_task              TYPE char1
        !is_data              TYPE any
        VALUE(iv_entity_name) TYPE string
        !iv_remarks_exists    TYPE boole_d OPTIONAL
      EXPORTING
        !es_data              TYPE any
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_address_comm_fax_data
      IMPORTING
        !iv_task              TYPE char1
        !is_data              TYPE any
        VALUE(iv_entity_name) TYPE string
        !iv_remarks_exists    TYPE boole_d OPTIONAL
      EXPORTING
        !es_data              TYPE any
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_address_comm_url_data
      IMPORTING
        !iv_task              TYPE char1
        !is_data              TYPE any
        VALUE(iv_entity_name) TYPE string
        !iv_remarks_exists    TYPE boole_d OPTIONAL
      EXPORTING
        !es_data              TYPE any
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS fill_address_comm_email_data
      IMPORTING
        !iv_task              TYPE char1
        !is_data              TYPE any
        VALUE(iv_entity_name) TYPE string
        !iv_remarks_exists    TYPE boole_d OPTIONAL
      EXPORTING
        !es_data              TYPE any
      RAISING
        /iwbep/cx_mgw_tech_exception
        /iwbep/cx_mgw_busi_exception .
    METHODS bp_validate
      IMPORTING
        !io_data_provider TYPE REF TO /iwbep/if_mgw_entry_provider
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS get_multiple_search_help_data
      CHANGING
        !lc_multiple_search_help TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_multiplesearchhelp .
    METHODS get_f4_mdpaymentmethod
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
    METHODS get_f4_mdrelationship
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
    METHODS get_f4_mdrelationshiptype
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
    METHODS get_f4_mddeliverypriority
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
    METHODS get_f4_mdcostcentergroup
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
    METHODS get_f4_mdbomclasstype
      CHANGING
        !lc_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest .
ENDCLASS.



CLASS /SIMPLE/CL_MDG_GW_CORE_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.
    "A_BUSINESSPARTNER DATA
*   DATA:
*      IO_API_BP TYPE REF TO CL_API_BUSINESS_PARTNEg_DPC_EXT.

    DATA:
      lv_flag         TYPE char1, "set when key fields in request URI and body differ
      lv_multiple     TYPE char1, "set when multiple business partners are processed in a single changeset
      lv_not_allowed  TYPE char1, "set when an unsupported operation is performed
      lv_no_bp        TYPE char1, "set when an entity is processed without a valid business partner
      lx_uuid_error   TYPE REF TO cx_uuid_error,
      ls_partner_deep LIKE partner_struc.

    DATA:
      ls_searchhelp         TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelp,
      ls_multiplesearchhelp TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_multiplesearchhelp,
      ls_deep_entity        TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type.

*   io_data_provider->read_entry_data( IMPORTING es_data = ls_deep_entity ).
    DATA(lo_message_container) = mo_context->get_message_container( ).

    TRY.
        CASE iv_entity_name.
          WHEN 'SearchHelp'.
            io_data_provider->read_entry_data( IMPORTING es_data = ls_searchhelp ).
*            get_search_help_data( CHANGING lc_multiple_search_help = ls_searchhelp ).
            copy_data_to_ref( EXPORTING is_data = ls_searchhelp
                               CHANGING cr_data = er_deep_entity ).
          WHEN 'MultipleSearchHelp'.
            io_data_provider->read_entry_data( IMPORTING es_data = ls_multiplesearchhelp ).
*            get_search_help_data( CHANGING lc_multiple_search_help = ls_multiplesearchhelp ).
            get_multiple_search_help_data( CHANGING lc_multiple_search_help = ls_multiplesearchhelp ).
            copy_data_to_ref( EXPORTING is_data = ls_multiplesearchhelp
                               CHANGING cr_data = er_deep_entity ).
          WHEN 'Product'.
            io_data_provider->read_entry_data( IMPORTING es_data = ls_deep_entity ).
            CASE ls_deep_entity-action.
              WHEN 'Create'.
                create_product_data( EXPORTING is_deep_type = ls_deep_entity
                                    CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'GetData'.
                get_product_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'ChangeTest'.
                change_product_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'Change'.
                change_product_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'DeleteTest'.
                delete_product_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'Delete'.
                delete_product_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
            ENDCASE.
          WHEN 'BusinessPartner'.
            io_data_provider->read_entry_data( IMPORTING es_data = ls_deep_entity ).
            CASE ls_deep_entity-action.
              WHEN 'Create'.
                create_bp_data( EXPORTING is_deep_type = ls_deep_entity
                                    CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'GetData'.
                get_bp_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'ChangeTest'.
                change_bp_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'Change'.
                change_bp_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'DeleteTest'.
                delete_bp_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
              WHEN 'Delete'.
                delete_bp_data( EXPORTING is_deep_type = ls_deep_entity
                        CHANGING er_deep_entity = er_deep_entity ).
            ENDCASE.
          WHEN 'A_BusinessPartnerType'.
            bp_validate( EXPORTING io_data_provider = io_data_provider ).

            CALL METHOD map_response
              EXPORTING
                is_data = ls_partner_deep
              CHANGING
                cr_data = er_deep_entity.

            changeset_add_bp_number( CHANGING cs_data = er_deep_entity ).

          WHEN OTHERS.
            lv_not_allowed = 'X'.
        ENDCASE.

      CATCH /simple/cx_custom_error INTO DATA(lx_so_error).
        lo_message_container->add_messages_from_bapi(
             iv_error_category   = 'E'
             it_bapi_messages    = lx_so_error->it_return
             iv_determine_leading_msg  = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).
    ENDTRY.



  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
**  EXPORTING
**    iv_action_name          =
**    it_parameter            =
**    io_tech_request_context =
**  IMPORTING
**    er_data                 =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
    DATA: lo_message_container TYPE REF TO /iwbep/if_message_container,
          lv_msg_v1            TYPE symsgv,
          lv_msg_v2            TYPE symsgv.

    lo_message_container = mo_context->get_message_container( ).


    BREAK-POINT.
    CASE iv_action_name.
      WHEN 'ProductClassification'.
        "to do
    ENDCASE.

    DATA(lt_msgs) = lo_message_container->get_messages( ).
    READ TABLE lt_msgs INTO DATA(ls_msgs) WITH KEY type = 'E'.
    IF sy-subrc EQ 0.
      CLEAR er_data.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_message_container
          http_status_code  = '500'.
    ENDIF.


  ENDMETHOD.


  METHOD add_message_to_log.
    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle  = iv_log_handle
        i_s_msg       = is_message
      EXCEPTIONS
        log_not_found = 0
        OTHERS        = 1.
  ENDMETHOD.


  METHOD bp_validate.
*    DATA:
*      lv_flag        TYPE char1, "set when key fields in request URI and body differ
*      lv_multiple    TYPE char1, "set when multiple business partners are processed in a single changeset
*      lv_not_allowed TYPE char1, "set when an unsupported operation is performed
*      lv_no_bp       TYPE char1, "set when an entity is processed without a valid business partner
*      lx_uuid_error  TYPE REF TO cx_uuid_error,
*      ls_partner_deep LIKE partner_struc.
*
*
*      io_data_provider->read_entry_data(
*        IMPORTING
*          es_data = ls_partner_deep
*      ).
*
*      IF gv_partner_guid IS INITIAL.
*        TRY.
*            gv_partner_guid = cl_system_uuid=>create_uuid_x16_static( ).
*          CATCH cx_uuid_error INTO lx_uuid_error .
*            gv_partner_guid = '0'.
*        ENDTRY.
*      ELSE.
*        lv_multiple = 'X'.
*      ENDIF.
*
*      DATA : ls_partner TYPE cl_api_business_partne_mpc=>ts_a_businesspartnertype.
*      MOVE-CORRESPONDING ls_partner_deep TO ls_partner.
*
*      fill_bp_data(
*        EXPORTING
*          iv_task         =     'I'
*          is_partner_data =     ls_partner ).
*
*      IF ls_partner_deep-to_businesspartnerrole IS NOT INITIAL.
*
*        LOOP AT ls_partner_deep-to_businesspartnerrole INTO DATA(ls_partner_role).
*          fill_bp_role_data(
*            EXPORTING
*              iv_task         =    'I'
*              is_partner_role =    ls_partner_role
*            IMPORTING
*              es_partner_role =    DATA(ls_cvi_role)
*          ).
*          APPEND ls_cvi_role TO gs_data-partner-central_data-role-roles.
*        ENDLOOP.
*        gs_data-partner-central_data-role-time_dependent = 'X'.
*
*      ENDIF.
*
*      IF ls_partner_deep-to_businesspartneraddress IS NOT INITIAL.
*
*        fill_deep_address(
*          EXPORTING
*            iv_task            = 'I'
*          IMPORTING
*            et_partner_address = DATA(et_partner_address)
*          CHANGING
*            ct_partner_address = ls_partner_deep-to_businesspartneraddress
*
*        ).
*        LOOP AT ls_partner_deep-to_businesspartneraddress ASSIGNING FIELD-SYMBOL(<ls_temp_address>).
*          IF <ls_temp_address>-validityenddate IS INITIAL.
*            <ls_temp_address>-validityenddate = '99991231235959'.
*          ENDIF.
*          LOOP AT <ls_temp_address>-to_addressusage ASSIGNING FIELD-SYMBOL(<ls_temp_usage>).
*            IF <ls_temp_usage>-validityenddate IS INITIAL.
*              <ls_temp_usage>-validityenddate = '99991231235959'.
*            ENDIF.
*          ENDLOOP.
*          LOOP AT <ls_temp_address>-to_urladdress ASSIGNING FIELD-SYMBOL(<ls_temp_url>).
*            IF <ls_temp_url>-validitystartdate IS INITIAL.
*              <ls_temp_url>-validitystartdate = '00010101'.
*            ENDIF.
*          ENDLOOP.
*        ENDLOOP.
*
*        gs_data-partner-central_data-address-addresses = et_partner_address.
*
*      ENDIF.
*
*      "fill taxnumber fields
*      IF ls_partner_deep-to_businesspartnertax IS NOT INITIAL.
*
*        LOOP AT ls_partner_deep-to_businesspartnertax INTO DATA(ls_partner_tax).
*          fill_taxnumber_data(
*            EXPORTING
*              iv_task           =     'I'
*              is_partner_taxnum =     ls_partner_tax
*            IMPORTING
*              es_partner_taxnum =     DATA(ls_cvi_tax)
*          ).
*          APPEND ls_cvi_tax TO gs_data-partner-central_data-taxnumber-taxnumbers.
*        ENDLOOP.
*
*      ENDIF.
*
*      "fill bp identification fields
*      IF ls_partner_deep-to_bupaidentification IS NOT INITIAL.
*
*        LOOP AT ls_partner_deep-to_bupaidentification INTO DATA(ls_partner_identification).
*          fill_bp_identification_data(
*            EXPORTING
*              iv_task                   =     'I'
*              is_partner_identification =     ls_partner_identification
*            IMPORTING
*              es_partner_identification =     DATA(ls_cvi_identification)
*          ).
*          APPEND ls_cvi_identification TO gs_data-partner-central_data-ident_number-ident_numbers.
*        ENDLOOP.
*
*      ENDIF.
*
*      "fill bank fields
*      IF ls_partner_deep-to_businesspartnerbank IS NOT INITIAL.
*
*        LOOP AT ls_partner_deep-to_businesspartnerbank INTO DATA(ls_partner_bank).
*          fill_bank_data(
*            EXPORTING
*              iv_task         =     'I'
*              is_partner_bank =     ls_partner_bank
*            IMPORTING
*              es_partner_bank =     DATA(ls_cvi_bank)
*          ).
*          APPEND ls_cvi_bank TO gs_data-partner-central_data-bankdetail-bankdetails.
*          gs_data-partner-central_data-bankdetail-time_dependent = 'X'.
*        ENDLOOP.
*
*      ENDIF.
*
*      "fill customer  fields
*      IF ls_partner_deep-to_customer IS NOT INITIAL.
*
*        DATA ls_customer TYPE cl_api_business_partne_mpc=>ts_a_customertype.
*        MOVE-CORRESPONDING ls_partner_deep-to_customer TO ls_customer.
*        fill_customer_general_data(
*          EXPORTING
*            iv_task          =  'I'
*            is_customer_data =  ls_customer
*        ).
*
*        IF ls_partner_deep-to_customer-to_customercompany IS NOT INITIAL.
*          "fill customer company code and withholding tax fields
*          fill_deep_customer_companycode(
*            EXPORTING
*              iv_task                      = 'I'
*              it_customer_companycode_data = ls_partner_deep-to_customer-to_customercompany
*            IMPORTING
*              et_customer_companycode_data = DATA(et_customer_company_data)
*          ).
*          gs_data-customer-company_data-company = et_customer_company_data.
*        ENDIF.
*
*        IF ls_partner_deep-to_customer-to_customersalesarea IS NOT INITIAL.
*          "fill customer salesarea and partner function fields
*          fill_deep_customer_salesarea( EXPORTING  iv_task                       = 'I'
*                                                   it_customer_salesarea         = ls_partner_deep-to_customer-to_customersalesarea
*                                        IMPORTING  et_customer_salesarea         = DATA(et_customer_salesarea) ).
*          gs_data-customer-sales_data-sales = et_customer_salesarea.
*
*          "fill customer salesarea tax fields
*          DATA(lt_sales_area) = ls_partner_deep-to_customer-to_customersalesarea.
*
*
*          LOOP AT lt_sales_area INTO DATA(ls_sales_area).
*            DATA(lt_sales_tax) = ls_sales_area-to_salesareatax.
*            LOOP AT lt_sales_tax INTO DATA(ls_sales_tax).
*              fill_salesarea_tax_data(
*                EXPORTING
*                  iv_task      =  'I'
*                  is_sales_tax =  ls_sales_tax
*                IMPORTING
*                  es_sales_tax =  DATA(ls_cvi_sales_tax)
*              ).
*              APPEND ls_cvi_sales_tax TO gs_data-customer-central_data-tax_ind-tax_ind.
*            ENDLOOP.
*          ENDLOOP.
*
*        ENDIF.
*
*      ENDIF.
*
*      "fill supplier fields
*      IF ls_partner_deep-to_supplier IS NOT INITIAL.
*
*        DATA ls_supplier TYPE cl_api_business_partne_mpc=>ts_a_suppliertype.
*        MOVE-CORRESPONDING ls_partner_deep-to_supplier TO ls_supplier.
*        fill_supplier_general_data(
*          EXPORTING
*            iv_task          = 'I'
*            is_supplier_data = ls_supplier
*        ).
*        IF ls_partner_deep-to_supplier-to_suppliercompany IS NOT INITIAL.
*          "fill supplier company code  and withholding tax fields
*          fill_deep_supplier_companycode(
*            EXPORTING
*              iv_task                      = 'I'
*              it_supplier_companycode_data =  ls_partner_deep-to_supplier-to_suppliercompany
*            IMPORTING
*              et_supplier_companycode_data = DATA(et_supplier_company_data)
*          ).
*          gs_data-vendor-company_data-company = et_supplier_company_data.
*        ENDIF.
*        IF ls_partner_deep-to_supplier-to_supplierpurchasingorg IS NOT INITIAL.
*          "fill supplier purchasing organization fields
*          fill_deep_supplier_purchase(
*            EXPORTING
*              iv_task                   = 'I'
*              it_supplier_purchase_data = ls_partner_deep-to_supplier-to_supplierpurchasingorg
*            IMPORTING
*              et_supplier_purchase_data =  DATA(et_supplier_purchase)
*          ).
*          gs_data-vendor-purchasing_data-purchasing = et_supplier_purchase.
*        ENDIF.
*
*      ENDIF.
*
*      IF ls_partner_deep-to_businesspartnercontact IS NOT INITIAL.
*
*        LOOP AT ls_partner_deep-to_businesspartnercontact ASSIGNING FIELD-SYMBOL(<ls_contact_temp>).
*          IF <ls_contact_temp>-validityenddate IS INITIAL.
*            <ls_contact_temp>-validityenddate = '99991231'.
*          ENDIF.
*
*          IF <ls_contact_temp>-to_contactrelationship-validityenddate IS INITIAL.
*            <ls_contact_temp>-to_contactrelationship-validityenddate = '99991231'.
*          ENDIF.
*
*          IF <ls_contact_temp>-relationshipcategory IS NOT INITIAL AND <ls_contact_temp>-relationshipcategory <> 'BUR001'.
*            lv_not_allowed = 'X'.
*          ENDIF.
*        ENDLOOP.
*        "fill contact data
*        fill_deep_contact_data(
*          EXPORTING
*            iv_task             =     'I'
*            it_partner_relation =     ls_partner_deep-to_businesspartnercontact
*         IMPORTING
*            et_partner_relation =     DATA(et_partner_relation) ).
*        gs_data-partner_relation = et_partner_relation.
*
*      ENDIF.
*
*      "api call
*        DATA : lt_data TYPE cvis_ei_extern_t.
*        DATA(lr_msg_container) = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).
*        DATA: lt_api_result TYPE bapiretm.
*        DATA: lt_return_msgs TYPE STANDARD TABLE OF bapiret2.
*        DATA: ls_return_msg  LIKE LINE OF lt_return_msgs.
*        APPEND gs_data TO lt_data.
*
*        cl_md_bp_maintain=>maintain(
*          EXPORTING i_data = lt_data
*                    I_TEST_RUN = abap_true
*          IMPORTING e_return = lt_api_result
*        ).
*
*        LOOP AT lt_api_result INTO DATA(ls_api_result).
*          LOOP AT ls_api_result-object_msg INTO DATA(ls_msg).
*            IF ls_msg-type <> 'W'.
*              ls_return_msg-message = ls_msg-message.
*              ls_return_msg-type = ls_msg-type.
*              ls_return_msg-id = ls_msg-id.
*              APPEND ls_return_msg TO lt_return_msgs.
*              CLEAR ls_return_msg.
*            ENDIF.
*          ENDLOOP.
*        ENDLOOP.
*
*        IF lt_return_msgs IS NOT INITIAL.
*          CALL METHOD lr_msg_container->add_messages_from_bapi(
*            EXPORTING
*              it_bapi_messages         = lt_return_msgs
*              iv_determine_leading_msg = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              http_status_code  = 200
*              message_container = lr_msg_container.
*        ENDIF.
*
*
*    DATA : ls_db TYPE cvis_ei_extern,
*           lv_dummy(1)    TYPE c.
*
*    LOOP AT lt_data INTO data(ls_update_data).
**      cl_md_bp_maintain=>validate_single_current_state(
**        EXPORTING
**          i_data    =     ls_update_data
**        IMPORTING
**          et_return =      DATA(lt_validation_result1)
**      ).
*
*      "Role based validation
*      DATA : lv_role_exists TYPE char1.
*      lv_role_exists = ' '.
*      IF ls_update_data-customer-sales_data-sales IS NOT INITIAL.
*        LOOP AT ls_update_data-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLCU01'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        LOOP AT ls_db-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLCU01'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        IF lv_role_exists IS INITIAL.
*          "Raise error
*          ls_return_msg-number = '002'.
*          ls_return_msg-message_v1 = 'FLCU01'.
*          ls_return_msg-message_v2 = TEXT-001.
*          ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
*          "ls_return_msg-message = 'The role FLCU01 must be assigned for Customer Sales Area'.
*          ls_return_msg-type = 'E'.
*          MESSAGE e002(CI_DRAFTBP_MESSAGE) WITH 'FLCU01' ls_return_msg-message_v2 INTO lv_dummy.
*          APPEND ls_return_msg TO lt_return_msgs.
*        ENDIF.
*      ENDIF.
*
*      lv_role_exists = ' '.
*      IF ls_update_data-customer-company_data-company IS NOT INITIAL.
*        LOOP AT ls_update_data-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLCU00'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        LOOP AT ls_db-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLCU00'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        IF lv_role_exists IS INITIAL.
*          "Raise error
*          ls_return_msg-number = '002'.
*          ls_return_msg-message_v1 = 'FLCU00'.
*          ls_return_msg-message_v2 = TEXT-002.
*          ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
*          "ls_return_msg-message = 'The role FLCU00 must be assigned for Customer Company Code'.
*          ls_return_msg-type = 'E'.
*          MESSAGE e002(CI_DRAFTBP_MESSAGE) WITH 'FLCU00' ls_return_msg-message_v2 INTO lv_dummy.
*          APPEND ls_return_msg TO lt_return_msgs.
*        ENDIF.
*      ENDIF.
*
*      lv_role_exists = ' '.
*      IF ls_update_data-vendor-purchasing_data-purchasing IS NOT INITIAL.
*        LOOP AT ls_update_data-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLVN01'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        LOOP AT ls_db-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLVN01'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        IF lv_role_exists IS INITIAL.
*          "Raise error
*          ls_return_msg-number = '002'.
*          ls_return_msg-message_v1 = 'FLVN01'.
*          ls_return_msg-message_v2 = TEXT-003.
*          ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
*          "ls_return_msg-message = 'The role FLVN01 must be assigned for Supplier Purchasing Organization'.
*          ls_return_msg-type = 'E'.
*          MESSAGE e002(CI_DRAFTBP_MESSAGE) WITH 'FLVN01' ls_return_msg-message_v2 INTO lv_dummy.
*          APPEND ls_return_msg TO lt_return_msgs.
*        ENDIF.
*      ENDIF.
*
*      lv_role_exists = ' '.
*      IF ls_update_data-vendor-company_data-company IS NOT INITIAL.
*        LOOP AT ls_update_data-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLVN00'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        LOOP AT ls_db-partner-central_data-role-roles TRANSPORTING NO FIELDS WHERE data-rolecategory = 'FLVN00'.
*          lv_role_exists = 'X'.
*        ENDLOOP.
*        IF lv_role_exists IS INITIAL.
*          "Raise error
*          ls_return_msg-number = '002'.
*          ls_return_msg-message_v1 = 'FLVN00'.
*          ls_return_msg-message_v2 = TEXT-004.
*          ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
*          "ls_return_msg-message = 'The role FLVN00 must be assigned for Supplier Company Code'.
*          ls_return_msg-type = 'E'.
*          MESSAGE e002(CI_DRAFTBP_MESSAGE) WITH 'FLVN00' ls_return_msg-message_v2 INTO lv_dummy.
*          APPEND ls_return_msg TO lt_return_msgs.
*        ENDIF.
*      ENDIF.
*
*      "Disable CRUD operations on Employee relevant Business Partner data - Start
*      DATA: lt_partner type bu_partner_t,
*            lt_employee_info type cmd_t_bp_empl_status.
*      lv_role_exists = ' '.
*      IF ls_update_data-partner-header-object_task EQ 'U'.
***        APPEND ls_update_data-partner-header-object_instance-bpartner to lt_partner.
***        CALL METHOD cl_cmd_employee_check=>is_bp_employee_relevant
***        EXPORTING
***          it_partner       = lt_partner
***        IMPORTING
***          et_employee_info = lt_employee_info .
***        read table lt_employee_info into data(ls_employee_info) index 1.
***        if ls_employee_info-is_relevant EQ abap_true.
***          lv_role_exists = 'X'.
***        endif.
*      ELSEIF ls_update_data-partner-header-object_task EQ 'I'.
*        IF ls_update_data-partner-central_data-role-roles IS NOT INITIAL.
*          LOOP AT ls_update_data-partner-central_data-role-roles TRANSPORTING NO FIELDS
*            WHERE data-rolecategory = 'BUP003' OR data-rolecategory = 'BBP010' OR data-rolecategory = 'BBP005'.
*            lv_role_exists = 'X'.
*          ENDLOOP.
*        ENDIF.
*      ENDIF.
*      IF lv_role_exists IS NOT INITIAL.
*        "Raise error
*        ls_return_msg-number = '066'.
*        ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
*        ls_return_msg-type = 'E'.
*        MESSAGE e066(CI_DRAFTBP_MESSAGE) INTO lv_dummy.
*        APPEND ls_return_msg TO lt_return_msgs.
*      ENDIF.
*      "Disable CRUD operations on Employee relevant Business Partner data - End
*
*      IF lt_return_msgs IS NOT INITIAL.
*        CALL METHOD lr_msg_container->add_messages_from_bapi(
*          EXPORTING
*            it_bapi_messages         = lt_return_msgs
*            iv_determine_leading_msg = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*          EXPORTING
*            http_status_code  = /iwbep/cx_mgw_busi_exception=>gcs_http_status_codes-bad_request
*            message_container = lr_msg_container.
*      ENDIF.
*    ENDLOOP.

  ENDMETHOD.


  METHOD build_dynamic_where.

*    DATA : lt_condtab TYPE TT_DYNAMIC_WHERE.
*
*    DATA : ls_condtab TYPE TY_DYNAMIC_WHERE.

    TYPES : BEGIN OF lty_eq_tab,
              field TYPE dfies-fieldname,
              count TYPE i,
            END   OF lty_eq_tab.

    DATA : eq_tab  TYPE TABLE OF lty_eq_tab,
           unfield TYPE RANGE OF dfies-fieldname.

    DATA : line TYPE ty_clause.

    CLEAR unfield.
*  UNFIELD-OPTION = 'EQ'.
*  UNFIELD-SIGN   = 'I'.
    unfield = VALUE #(
    ( sign = 'I' option = 'EQ') ).

    LOOP AT it_contab INTO DATA(ls_condtab).
      IF ls_condtab-opera EQ 'IN'.
        RAISE wrong_condition.
      ENDIF.
      IF ls_condtab-opera EQ 'BT' AND
        ls_condtab-high EQ space.
        RAISE wrong_condition.
      ENDIF.
*      IF ls_condtab_imp-opera NE 'EQ'.
*        READ TABLE EQ_TAB
*             WITH KEY field = ls_condtab_imp-field.
*        IF sy-subrc EQ 0.
*          RAISE WRONG_CONDITION.
*        ENDIF.
*
*      ELSE.
*        EQ_TAB-
*      ENDIF.

    ENDLOOP.

    LOOP AT it_contab INTO ls_condtab.
      CASE ls_condtab-opera.
        WHEN 'BT'.
          CONCATENATE 'AND' ls_condtab-field
                      'BETWEEN' ''''  INTO line-line SEPARATED BY space.
          IF ls_condtab-low NE space.
            CONCATENATE line-line ls_condtab-low '''' INTO line-line.
          ELSE.
            CONCATENATE line-line '''' INTO line-line SEPARATED BY space.
          ENDIF.
          CONCATENATE line-line 'AND' '''' INTO line-line SEPARATED BY space.
          IF ls_condtab-high NE space.
            CONCATENATE line-line ls_condtab-high '''' INTO line-line.
          ELSE.
            CONCATENATE line-line '''' INTO line-line SEPARATED BY space.
          ENDIF.
        WHEN 'LK'.
          TRANSLATE ls_condtab-low USING '*%+_'.
          CONCATENATE 'AND' ls_condtab-field
                      'LIKE' ''''  INTO line-line SEPARATED BY space.
          IF ls_condtab-low NE space.
            CONCATENATE line-line ls_condtab-low '''' INTO line-line.
          ELSE.
            CONCATENATE line-line '''' INTO line-line SEPARATED BY space.
          ENDIF.
        WHEN OTHERS.
          CONCATENATE 'AND' ls_condtab-field
                      ls_condtab-opera ''''  INTO line-line SEPARATED BY space.
          IF ls_condtab-low NE space.
            CONCATENATE line-line ls_condtab-low '''' INTO line-line.
          ELSE.
            CONCATENATE line-line '''' INTO line-line SEPARATED BY space.
          ENDIF.
      ENDCASE.

      APPEND line TO et_where_clause.
    ENDLOOP.

    READ TABLE et_where_clause INDEX 1 INTO line.
    IF line-line(4) EQ 'AND '.
      SHIFT line-line BY 4 PLACES LEFT.
      MODIFY et_where_clause INDEX sy-tabix FROM line.
    ENDIF.

  ENDMETHOD.


  METHOD changeset_add_bp_number.

    FIELD-SYMBOLS: <lv_bpartner> TYPE bu_partner.
    FIELD-SYMBOLS: <lv_partner_guid> TYPE bu_partner_guid.
    FIELD-SYMBOLS: <ls_structure> TYPE data.
    FIELD-SYMBOLS: <lt_address>    TYPE ANY TABLE,
                   <ls_address>    TYPE any,
                   <ls_addr_usage> TYPE any,
                   <lt_addr_usage> TYPE ANY TABLE.
    DATA :lv_addr_guid TYPE bu_address_guid_bapi,
          lt_messages  TYPE TABLE OF bapiret2.


    DATA: lv_partner TYPE bu_partner.
    IF gv_partner_guid IS NOT INITIAL.
      CALL FUNCTION 'BUPA_NUMBERS_GET'
        EXPORTING
          iv_partner_guid = gv_partner_guid
*         IV_REQ_MASK     = 'X'
        IMPORTING
          ev_partner      = lv_partner.
*      SELECT SINGLE partner FROM but000 INTO lv_partner WHERE partner_guid = gv_partner_guid.

    ENDIF.

    FIELD-SYMBOLS : <ls_data> TYPE any.

    IF lv_partner IS NOT INITIAL."successful commit

      ASSIGN cs_data->* TO <ls_data>.

      ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_temp>).
      IF sy-subrc = '0'.
        <lv_temp> = lv_partner.
        gv_partner = lv_partner.
      ENDIF.

      ASSIGN COMPONENT 'BUSINESSPARTNERCOMPANY' OF STRUCTURE <ls_data> TO <lv_temp>.
      IF sy-subrc = '0'.
        <lv_temp> = lv_partner.
      ENDIF.

      ASSIGN COMPONENT 'BUSINESSPARTNERUUID' OF STRUCTURE <ls_data> TO <lv_temp>.
      IF sy-subrc = '0'.
        <lv_temp> = gv_partner_guid.
      ENDIF.

      ASSIGN COMPONENT 'CUSTOMER' OF STRUCTURE <ls_data> TO <lv_temp>.
      IF sy-subrc = '0'.
        SELECT SINGLE customer FROM cvi_cust_link INTO <lv_temp> WHERE partner_guid = gv_partner_guid.
      ENDIF.

      ASSIGN COMPONENT 'SUPPLIER' OF STRUCTURE <ls_data> TO <lv_temp>.
      IF sy-subrc = '0'.
        SELECT SINGLE vendor FROM cvi_vend_link INTO <lv_temp> WHERE partner_guid = gv_partner_guid.
      ENDIF.

      ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE <ls_data> TO <lv_temp>.
      IF sy-subrc = '0'.
        ASSIGN COMPONENT 'ADDRESSUUID' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_temp1>).
        IF sy-subrc = '0' AND <lv_temp1> IS NOT INITIAL.
          MOVE <lv_temp1> TO lv_addr_guid.
          CALL FUNCTION 'BAPI_BUPA_ADDRESS_GET_NUMBERS'
            EXPORTING
              businesspartner = gv_partner
              addressguid     = lv_addr_guid
            IMPORTING
              addr_no_out     = <lv_temp>
            TABLES
              return          = lt_messages.
          "SELECT SINGLE addrnumber FROM but020 INTO <lv_temp> WHERE address_guid = <lv_temp1>.
          ASSIGN COMPONENT 'TO_ADDRESSUSAGE' OF STRUCTURE <ls_data> TO <lt_addr_usage>.
          IF sy-subrc = '0'.
            LOOP AT <lt_addr_usage> ASSIGNING <ls_addr_usage>.
              ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE <ls_addr_usage> TO FIELD-SYMBOL(<lv_temp2>).
              IF <lv_temp2> IS INITIAL.
                <lv_temp2> = <lv_temp>.
              ENDIF.
              ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE <ls_addr_usage> TO <lv_temp2>.
              IF <lv_temp2> IS INITIAL.
                <lv_temp2> = gv_partner.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.

      ASSIGN COMPONENT 'TO_BUSINESSPARTNERADDRESS' OF STRUCTURE <ls_data> TO <lt_address>.
      IF sy-subrc = '0'.
        LOOP AT <lt_address> ASSIGNING <ls_address>.
          ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE <ls_address> TO <lv_temp>.
          IF sy-subrc = '0' AND <lv_temp> IS INITIAL.
            ASSIGN COMPONENT 'ADDRESSUUID' OF STRUCTURE <ls_address> TO <lv_temp1>.
            IF sy-subrc = '0' AND <lv_temp1> IS NOT INITIAL.
              MOVE <lv_temp1> TO lv_addr_guid.
              CALL FUNCTION 'BAPI_BUPA_ADDRESS_GET_NUMBERS'
                EXPORTING
                  businesspartner = gv_partner
                  addressguid     = lv_addr_guid
                IMPORTING
                  addr_no_out     = <lv_temp>
                TABLES
                  return          = lt_messages.
              ASSIGN COMPONENT 'TO_ADDRESSUSAGE' OF STRUCTURE <ls_address> TO <lt_addr_usage>.
              IF sy-subrc = '0'.
                LOOP AT <lt_addr_usage> ASSIGNING <ls_addr_usage>.
                  ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE <ls_addr_usage> TO <lv_temp2>.
                  IF <lv_temp2> IS INITIAL.
                    <lv_temp2> = <lv_temp>.
                  ENDIF.
                  ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE <ls_addr_usage> TO <lv_temp2>.
                  IF <lv_temp2> IS INITIAL.
                    <lv_temp2> = gv_partner.
                  ENDIF.
                ENDLOOP.
              ENDIF.
              "SELECT SINGLE addrnumber FROM but020 INTO <lv_temp> WHERE address_guid = <lv_temp1>.
            ENDIF.
            ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE <ls_address> TO FIELD-SYMBOL(<lv_temp3>).
            IF sy-subrc = '0' AND <lv_temp3> IS INITIAL.
              <lv_temp3> = gv_partner.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD change_bp_data.
    "-- Relationship date
    DATA:
*      LV_TIMESTAMP  TYPE  TZONREF-TSTAMPS,
*      LV_DATE TYPE  SY-DATLO,
*      LV_TIME TYPE  SY-TIMLO .
      lv_partner2                 TYPE bu_partner,
      lv_validfromdate            TYPE  bapibus1006002_header-validfromdate,
      lv_validuntildate           TYPE  bapibus1006002_header-validuntildate VALUE  '99991231',
      lv_relationshipcategory     TYPE  but050-reltyp,
      lv_relationshiptype         TYPE  but050-relkind,
      lv_differentiationtypevalue TYPE  but050-dftval.

    DATA:
      lv_num10(10)   TYPE n,
      lv_partner     TYPE bu_partner,
      objectkeynew   TYPE  bapi1003_key-object,
      objecttablenew TYPE  bapi1003_key-objecttable,
      classnumnew    TYPE  bapi1003_key-classnum,
      objecttable    TYPE  bapi1003_key-objecttable,
      classtypenew   TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar    TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar    TYPE bapi1003_alloc_values_char,
      t_allocvaluesnumnew  TYPE STANDARD TABLE OF  bapi1003_alloc_values_num,
      t_allocvaluescurrnew TYPE STANDARD TABLE OF  bapi1003_alloc_values_curr,
      lt_return            TYPE STANDARD TABLE OF bapiret2.

    DATA:
      lv_credit_sgmnt  TYPE ukm_credit_sgmnt,
      ls_creditsegment TYPE /simple/cl_mdg_gw_core_mpc=>ts_businesspartnercreditsegmen,
      lt_all_accounts  TYPE  ukm_ts_acc_objs2,
      io_facade        TYPE REF TO cl_ukm_facade,
      io_calculator    TYPE REF TO if_ukm_calculator,
      io_partner       TYPE REF TO cl_ukm_business_partner,
      io_bupa_factory  TYPE REF TO cl_ukm_bupa_factory,
      io_account       TYPE REF TO cl_ukm_account,
      lw_bp_credit_sgm TYPE ukm_s_bp_cms_sgm,
      lw_bp_cms        TYPE ukm_s_bp_cms,
      lt_ukm_return    TYPE ukm_t_monitor_return.

    DATA:
      lv_object_type TYPE  tcla-obtab,
      lv_object      TYPE  kssk-objek,
      lv_class_type  TYPE  kssk-klart,
      lv_class       TYPE  klah-class.

    DATA:
      lt_charact_values        TYPE STANDARD TABLE OF  api_val_r,
      lt_object_identification TYPE STANDARD TABLE OF  api_ob_key.

    lv_partner = is_deep_type-objectid.
    IF is_deep_type-objecttype = 'Customer'.
      objecttable = 'KNA1'.
      lv_object_type = 'KNA1'.
    ELSEIF is_deep_type-objecttype = 'Vendor'.
      objecttable = 'LFA1'.
      lv_object_type = 'LFA1'.
    ENDIF.
    lv_num10 = is_deep_type-objectid.
    objectkeynew = lv_num10.
    lv_object = lv_num10.


    IF is_deep_type-toclassification IS NOT INITIAL.
      LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
        IF ls_classification-class IS NOT INITIAL.
          classnumnew = ls_classification-class.
          classtypenew = ls_classification-classtype.
          LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
            TRANSLATE ls_characteristic-charact TO UPPER CASE.
            s_allocvalueschar-charact = ls_characteristic-charact.
            s_allocvalueschar-value_char = ls_characteristic-value.
            APPEND s_allocvalueschar TO t_allocvalueschar.
            CLEAR ls_characteristic.
          ENDLOOP.

          IF ls_classification-action = 'Delete'.
            CALL FUNCTION 'BAPI_OBJCL_DELETE'
              EXPORTING
                objectkey   = objectkeynew
                objecttable = objecttable
                classnum    = classnumnew
                classtype   = classtypenew
              TABLES
                return      = lt_return.
          ELSEIF ls_classification-action = 'Insert'.
            CALL FUNCTION 'BAPI_OBJCL_CREATE'
              EXPORTING
                objectkeynew    = objectkeynew
                objecttablenew  = objecttable
                classnumnew     = classnumnew
                classtypenew    = classtypenew
              TABLES
                allocvalueschar = t_allocvalueschar
                return          = lt_return.
          ELSE.
            lv_class_type = ls_classification-classtype.
            lv_class = ls_classification-class.

            CALL FUNCTION 'CACL_OBJECT_READ_VALIDATION'
              EXPORTING
                object                = lv_object
                object_type           = lv_object_type
                class_type            = lv_class_type
                class                 = lv_class
              TABLES
                charact_values        = lt_charact_values
                object_identification = lt_object_identification
              EXCEPTIONS
                error                 = 1
                warning               = 2
                OTHERS                = 3.

            IF lt_charact_values IS NOT INITIAL.
              LOOP AT lt_charact_values INTO DATA(ls_charact) WHERE val_assign = 'X'.
                READ TABLE t_allocvalueschar TRANSPORTING NO FIELDS WITH KEY charact = ls_charact-charact.
                IF sy-subrc <> 0.
                  s_allocvalueschar-charact = ls_charact-charact.
                  s_allocvalueschar-value_char = ls_charact-value_neutral.
                  APPEND s_allocvalueschar TO t_allocvalueschar.
                  CLEAR s_allocvalueschar.
                ENDIF.
              ENDLOOP.
            ENDIF.

            CALL FUNCTION 'BAPI_OBJCL_CHANGE'
              EXPORTING
                objectkey          = objectkeynew
                objecttable        = objecttable
                classnum           = classnumnew
                classtype          = classtypenew
              TABLES
                allocvaluesnumnew  = t_allocvaluesnumnew
                allocvaluescharnew = t_allocvalueschar
                allocvaluescurrnew = t_allocvaluescurrnew
                return             = lt_return.
          ENDIF.

          DELETE lt_return WHERE type <> 'E'.

          IF lt_return IS NOT INITIAL.
            RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
          ENDIF.

          IF is_deep_type-action = 'ChangeTest'.
            CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
          ENDIF.

          CLEAR classnumnew.
          CLEAR classtypenew.
          CLEAR ls_characteristic.
          CLEAR t_allocvalueschar.
          CLEAR lt_return.
        ENDIF.
      ENDLOOP.
    ENDIF.

    "-- Get credit management data
    " Logic is disabled on S4 but enabled on ECC. S4 class support credit management data.

*    io_facade = cl_ukm_facade=>create( i_activity = cl_ukm_cnst_eventing=>bp_maintenance ).
*    io_calculator = io_facade->get_calculator( ).
*    io_bupa_factory = io_facade->get_bupa_factory( ).
*    if is_deep_type-tobusinesspartnercreditprofile is NOT INITIAL.
*
*      "read businee partner
*      io_partner = io_bupa_factory->get_business_partner( lv_partner ).
*
*      "Get credit profile
*      CALL METHOD io_partner->get_bp_cms
*        IMPORTING
*          es_bp_cms = lw_bp_cms.
*
*      "Set credit profile data
*      lw_bp_cms-alternate_bp = is_deep_type-tobusinesspartnercreditprofile-alternatebp.
*      lw_bp_cms-check_rule = is_deep_type-tobusinesspartnercreditprofile-checkrule.
*      lw_bp_cms-credit_group = is_deep_type-tobusinesspartnercreditprofile-creditgroup.
*      lw_bp_cms-limit_rule = is_deep_type-tobusinesspartnercreditprofile-limitrule.
*      lw_bp_cms-own_rating = is_deep_type-tobusinesspartnercreditprofile-ownrating.
*      lw_bp_cms-own_rating_calc = is_deep_type-tobusinesspartnercreditprofile-ownratingcalc.
**      lw_bp_cms-rating_chg_date = is_deep_type-tobusinesspartnercreditprofile-ratingchangedate.
*
*      IF is_deep_type-tobusinesspartnercreditprofile-ratingchangedate <> '0'.
*        lw_bp_cms-rating_chg_date = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-ratingchangedate ).
*      ENDIF.
*
**      lw_bp_cms-risk_class_chgdt = is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate.
*
*      IF is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate <> '0'.
*        lw_bp_cms-risk_class_chgdt = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate ).
*      ENDIF.
*
**      lw_bp_cms-rating_val_date = is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate.
*
*      IF is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate <> '0'.
*        lw_bp_cms-rating_val_date = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate ).
*      ENDIF.
*
*      lw_bp_cms-risk_class = is_deep_type-tobusinesspartnercreditprofile-riskclass.
*      lw_bp_cms-risk_class_calc = is_deep_type-tobusinesspartnercreditprofile-riskclasscalc.
*
*      io_partner->set_bp_cms( EXPORTING IS_BP_CMS = lw_BP_CMS ).
*
*
*    ENDIF.

*    "Set credit segment data
*    if is_deep_type-tobusinesspartnercreditsegment is NOT INITIAL.
*      LOOP at is_deep_type-tobusinesspartnercreditsegment INTO ls_creditsegment.
*        lv_CREDIT_SGMNT = ls_creditsegment-creditsegment.
*        CALL METHOD io_bupa_factory->get_credit_account
*          EXPORTING
*            i_partner = lv_partner
*            i_credit_sgmnt = lv_CREDIT_SGMNT
*          RECEIVING
*            ro_credit_account = io_account.
*
*        lw_bp_credit_sgm-block_reason = ls_creditsegment-blockreason.
*        lw_bp_credit_sgm-coordinator = ls_creditsegment-coordinator.
*        lw_bp_credit_sgm-credit_limit = ls_creditsegment-creditlimit.
*        lw_bp_credit_sgm-cred_lim_calc = ls_creditsegment-creditlimitcal.
*        lw_bp_credit_sgm-cred_lim_req = ls_creditsegment-creditlimitreq.
*        lw_bp_credit_sgm-cust_group = ls_creditsegment-custgroup.
**        lw_bp_credit_sgm-follow_up_dt = ls_creditsegment-followupdate.
*
*        IF ls_creditsegment-followupdate <> '0'.
*          lw_bp_credit_sgm-follow_up_dt = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-followupdate ).
*        ENDIF.
*
*
*        lw_bp_credit_sgm-automatic_req = ls_creditsegment-isautomaticreq.
*        lw_bp_credit_sgm-xblocked = ls_creditsegment-isblocked.
*        lw_bp_credit_sgm-item_error = ls_creditsegment-isitemerror.
*        lw_bp_credit_sgm-x_limit_zero = ls_creditsegment-islimitzero.
**        lw_bp_credit_sgm-limit_chg_date = ls_creditsegment-limitchangedate.
*
*        IF ls_creditsegment-limitchangedate <> '0'.
*          lw_bp_credit_sgm-limit_chg_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-limitchangedate ).
*        ENDIF.
*
**        lw_bp_credit_sgm-limit_valid_date = ls_creditsegment-limitvaliddate.
*
*        IF ls_creditsegment-limitvaliddate <> '0'.
*          lw_bp_credit_sgm-limit_valid_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-limitvaliddate ).
*        ENDIF.
*
*        lw_bp_credit_sgm-log_hndl = ls_creditsegment-loghndl.
**        lw_bp_credit_sgm-req_date = ls_creditsegment-reqdate.
*
*        IF ls_creditsegment-reqdate <> '0'.
*          lw_bp_credit_sgm-req_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-reqdate ).
*        ENDIF.
*
**        lw_bp_credit_sgm-limit_valid_date = ls_creditsegment-validtodate.
*
*        IF ls_creditsegment-validtodate <> '0'.
*          lw_bp_credit_sgm-limit_valid_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-validtodate ).
*        ENDIF.
*
*        lw_bp_credit_sgm-xcritical = ls_creditsegment-iscritical.
*
*        io_account->set_bp_cms_sgm( EXPORTING is_bp_cms_sgm = lw_bp_credit_sgm ).
*      ENDLOOP.
*
*      IF is_deep_type-action = 'Change'.
*        io_bupa_factory->save_all( EXPORTING i_upd_task = '' ).
*      ENDIF.
*    endif.

*    IF is_deep_type-tobusinesspartnerrelationship IS NOT INITIAL.
*      LOOP AT is_deep_type-tobusinesspartnerrelationship INTO DATA(ls_businesspartnerrelationship).
*
*        lv_partner2 = ls_businesspartnerrelationship-businesspartner.
*        lv_differentiationtypevalue = ls_businesspartnerrelationship-differentiationtypevalue.
*        lv_relationshiptype = ls_businesspartnerrelationship-relationshiptype.
*        lv_validfromdate = sy-datlo.
*        IF ls_businesspartnerrelationship-validfromdate IS NOT INITIAL.
**          lv_validfromdate = ls_businesspartnerrelationship-validfromdate.
*          IF ls_businesspartnerrelationship-validfromdate <> '0'.
*            lv_validfromdate = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_businesspartnerrelationship-validfromdate ).
*          ENDIF.
*        ENDIF.
*
*        IF ls_businesspartnerrelationship-validuntildate IS NOT INITIAL.
**          lv_validuntildate = ls_businesspartnerrelationship-validuntildate.
*          IF ls_businesspartnerrelationship-validuntildate <> '0'.
*            lv_validuntildate = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_businesspartnerrelationship-validuntildate ).
*          ENDIF.
*        ENDIF.
*
*        IF strlen( ls_businesspartnerrelationship-relationshipcategory ) = 6.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner
*              businesspartner2               = lv_partner2
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*
*        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'T'.
*          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner2
*              businesspartner2               = lv_partner
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*
*        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'F'.
*          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner
*              businesspartner2               = lv_partner2
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*        ENDIF.
*
*        DELETE lt_return WHERE type <> 'E'.
*        IF lt_return IS NOT INITIAL.
*          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
*        ENDIF.
*        IF is_deep_type-action = 'ChangeTest'.
*          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
*        ENDIF.
*
*        CLEAR lt_return.
*      ENDLOOP.
*    ENDIF.

    IF is_deep_type-action = 'Change'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD change_product_data.
    DATA:
      material       TYPE  bapimatall-material,
      lv_num(18)     TYPE n,
      lv_num10(10)   TYPE n,
      objectkeynew   TYPE  bapi1003_key-object,
      objecttablenew TYPE  bapi1003_key-objecttable,
      classnumnew    TYPE  bapi1003_key-classnum,
      objecttable    TYPE  bapi1003_key-objecttable,
      classtypenew   TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar    TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar    TYPE bapi1003_alloc_values_char,
      t_allocvaluesnumnew  TYPE STANDARD TABLE OF  bapi1003_alloc_values_num,
      t_allocvaluescurrnew TYPE STANDARD TABLE OF  bapi1003_alloc_values_curr,
      lt_return            TYPE STANDARD TABLE OF bapiret2.

    DATA:
      lv_object_type TYPE  tcla-obtab,
      lv_object      TYPE  kssk-objek,
      lv_class_type  TYPE  kssk-klart,
      lv_class       TYPE  klah-class.

    DATA:
      lt_charact_values        TYPE STANDARD TABLE OF  api_val_r,
      lt_object_identification TYPE STANDARD TABLE OF  api_ob_key.

    lv_object_type = 'MARA'.
    objecttable = 'MARA'.
    lv_num = is_deep_type-objectid.
    objectkeynew = lv_num.
    lv_object = lv_num.

    LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
      IF ls_classification-class IS NOT INITIAL.
        classnumnew = ls_classification-class.
        classtypenew = ls_classification-classtype.
        LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
          TRANSLATE ls_characteristic-charact TO UPPER CASE.
          s_allocvalueschar-charact = ls_characteristic-charact.
          s_allocvalueschar-value_char = ls_characteristic-value.
          APPEND s_allocvalueschar TO t_allocvalueschar.
          CLEAR ls_characteristic.
        ENDLOOP.

        IF ls_classification-action = 'Delete'.
          CALL FUNCTION 'BAPI_OBJCL_DELETE'
            EXPORTING
              objectkey   = objectkeynew
              objecttable = objecttable
              classnum    = classnumnew
              classtype   = classtypenew
            TABLES
              return      = lt_return.
        ELSEIF ls_classification-action = 'Insert'.
          CALL FUNCTION 'BAPI_OBJCL_CREATE'
            EXPORTING
              objectkeynew    = objectkeynew
              objecttablenew  = objecttable
              classnumnew     = classnumnew
              classtypenew    = classtypenew
            TABLES
              allocvalueschar = t_allocvalueschar
              return          = lt_return.
        ELSE.
          lv_class_type = ls_classification-classtype.
          lv_class = ls_classification-class.

          CALL FUNCTION 'CACL_OBJECT_READ_VALIDATION'
            EXPORTING
              object                = lv_object
              object_type           = lv_object_type
              class_type            = lv_class_type
              class                 = lv_class
            TABLES
              charact_values        = lt_charact_values
              object_identification = lt_object_identification
            EXCEPTIONS
              error                 = 1
              warning               = 2
              OTHERS                = 3.

          IF lt_charact_values IS NOT INITIAL.
            LOOP AT lt_charact_values INTO DATA(ls_charact) WHERE val_assign = 'X'.
              READ TABLE t_allocvalueschar TRANSPORTING NO FIELDS WITH KEY charact = ls_charact-charact.
              IF sy-subrc <> 0.
                s_allocvalueschar-charact = ls_charact-charact.
                s_allocvalueschar-value_char = ls_charact-value_neutral.
                APPEND s_allocvalueschar TO t_allocvalueschar.
                CLEAR s_allocvalueschar.
              ENDIF.
            ENDLOOP.
          ENDIF.

          CALL FUNCTION 'BAPI_OBJCL_CHANGE'
            EXPORTING
              objectkey          = objectkeynew
              objecttable        = objecttable
              classnum           = classnumnew
              classtype          = classtypenew
            TABLES
              allocvaluesnumnew  = t_allocvaluesnumnew
              allocvaluescharnew = t_allocvalueschar
              allocvaluescurrnew = t_allocvaluescurrnew
              return             = lt_return.
        ENDIF.
        DELETE lt_return WHERE type <> 'E'.

        IF lt_return IS NOT INITIAL.
          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
        ENDIF.

        IF is_deep_type-action = 'ChangeTest'.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        ENDIF.

        CLEAR classnumnew.
        CLEAR classtypenew.
        CLEAR ls_characteristic.
        CLEAR t_allocvalueschar.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    IF is_deep_type-action = 'Change'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD check_key_fields.

    DATA: lv_flag TYPE char1.

    lv_flag = ' '.

    CASE iv_entity_name. "check if key fields are changed during patch and throw error.

      WHEN 'A_BuPaIdentificationType' OR 'A_BusinessPartnerTaxNumberType' OR 'A_BusinessPartnerBankType' OR 'A_BusinessPartnerRoleType'
             OR 'A_BusinessPartnerType' OR 'A_BusinessPartnerAddressType' OR 'A_BuPaAddressUsageType' OR 'A_BuPaIndustryType'.

        ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE is_entity_1 TO FIELD-SYMBOL(<lv_temp>). " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BUSINESSPARTNER' OF STRUCTURE is_entity_2 TO FIELD-SYMBOL(<lv_temp1>). " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_CustomerType' OR 'A_CustomerCompanyType' OR 'A_CustomerSalesAreaType' OR 'A_CustomerDunningType'
            OR 'A_CustomerWithHoldingTaxType' OR 'A_CustSalesPartnerFuncType' OR 'A_CustomerSalesAreaTaxType'.

        ASSIGN COMPONENT 'CUSTOMER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'CUSTOMER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'COMPANYCODE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'COMPANYCODE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'SALESORGANIZATION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'SALESORGANIZATION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'DISTRIBUTIONCHANNEL' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DISTRIBUTIONCHANNEL' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'DIVISION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DIVISION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_SupplierType' OR 'A_SupplierCompanyType' OR 'A_SupplierPurchasingOrgType' OR 'A_SupplierWithHoldingTaxType'
            OR 'A_SupplierPartnerFuncType' OR 'A_SupplierDunningType'.

        ASSIGN COMPONENT 'SUPPLIER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'SUPPLIER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'COMPANYCODE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'COMPANYCODE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PURCHASINGORGANIZATION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PURCHASINGORGANIZATION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

    ENDCASE.


    CASE iv_entity_name.

      WHEN 'A_BuPaIdentificationType'.

        ASSIGN COMPONENT 'BPIDENTIFICATIONTYPE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BPIDENTIFICATIONTYPE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'BPIDENTIFICATIONNUMBER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BPIDENTIFICATIONNUMBER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BuPaIndustryType'.

        ASSIGN COMPONENT 'INDUSTRYSECTOR' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'INDUSTRYSECTOR' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'INDUSTRYSYSTEMTYPE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'INDUSTRYSYSTEMTYPE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BusinessPartnerTaxNumberType'.

        ASSIGN COMPONENT 'BPTAXTYPE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BPTAXTYPE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BusinessPartnerBankType'.

        ASSIGN COMPONENT 'BANKIDENTIFICATION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BANKIDENTIFICATION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BusinessPartnerRoleType'.

        ASSIGN COMPONENT 'BUSINESSPARTNERROLE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BUSINESSPARTNERROLE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BusinessPartnerAddressType' .

        ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_AddressPhoneNumberType' OR 'A_AddressFaxNumberType' OR 'A_AddressEmailAddressType' OR 'A_AddressHomePageURLType'.

        ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'ADDRESSID' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PERSON' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PERSON' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'ORDINALNUMBER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'ORDINALNUMBER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BuPaAddressUsageType'.

        ASSIGN COMPONENT 'ADDRESSUSAGE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'ADDRESSUSAGE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'VALIDITYENDDATE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'VALIDITYENDDATE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_CustomerDunningType'.

        ASSIGN COMPONENT 'DUNNINGAREA' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DUNNINGAREA' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_SupplierDunningType'.

        ASSIGN COMPONENT 'DUNNINGAREA' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DUNNINGAREA' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_CustomerWithHoldingTaxType' OR 'A_SupplierWithHoldingTaxType'.

        ASSIGN COMPONENT 'WITHHOLDINGTAXTYPE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'WITHHOLDINGTAXTYPE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_CustSalesPartnerFuncType'.

        ASSIGN COMPONENT 'PARTNERCOUNTER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PARTNERCOUNTER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PARTNERFUNCTION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PARTNERFUNCTION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_CustomerSalesAreaTaxType'.

        ASSIGN COMPONENT 'DEPARTURECOUNTRY' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'DEPARTURECOUNTRY' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'CUSTOMERTAXCATEGORY' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'CUSTOMERTAXCATEGORY' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_SupplierPartnerFuncType'.

        ASSIGN COMPONENT 'SUPPLIERSUBRANGE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'SUPPLIERSUBRANGE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PLANT' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PLANT' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PARTNERCOUNTER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PARTNERCOUNTER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'PARTNERFUNCTION' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'PARTNERFUNCTION' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN 'A_BusinessPartnerContactType' OR 'A_BPContactToFuncAndDeptType'.

        ASSIGN COMPONENT 'RELATIONSHIPNUMBER' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'RELATIONSHIPNUMBER' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'BUSINESSPARTNERCOMPANY' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BUSINESSPARTNERCOMPANY' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'BUSINESSPARTNERPERSON' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'BUSINESSPARTNERPERSON' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT 'VALIDITYENDDATE' OF STRUCTURE is_entity_1 TO <lv_temp>. " data from db
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'VALIDITYENDDATE' OF STRUCTURE is_entity_2 TO <lv_temp1>. " data from json
          IF sy-subrc = 0.
            IF <lv_temp> <> <lv_temp1>.
              lv_flag = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

    ENDCASE. " check if key fields are changed during patch and throw error.

    IF lv_flag = 'X'.
      export_messages( iv_error =  'KEYS'
                       iv_entity_name = iv_entity_name ).
    ENDIF.

  ENDMETHOD.


  METHOD convert_itf_to_string.
************************************************************************
* This module converts a text provided in the internal text format
* into a string.
* Only the formatting tags * (new paragraph) and = (continuation line)
* are observed.
************************************************************************

    FIELD-SYMBOLS:
      <ls_line>  TYPE  tline.

* initialize
    CLEAR ev_text_as_string.

* each line in the text
    LOOP AT it_text_as_itf ASSIGNING <ls_line>.

*   First line: Insert label if wanted, formatting-tag doesn't matter
      IF sy-tabix = 1.
        ev_text_as_string = <ls_line>-tdline.

*   Second and following lines: concatenate to string
      ELSE.
        CASE <ls_line>-tdformat.
*       new paragraph
*       (concatenate with carriage return/line feed in between)
          WHEN gc_new_paragraph.
            CONCATENATE ev_text_as_string
                        cl_abap_char_utilities=>cr_lf
                        <ls_line>-tdline
                        INTO ev_text_as_string.

*       continuation line
*       (concatenate without space in between)
          WHEN gc_continuation.
            CONCATENATE ev_text_as_string
                        <ls_line>-tdline
                        INTO ev_text_as_string.

*       other tags
*       (concatenate with space in between)
          WHEN OTHERS.
            CONCATENATE ev_text_as_string
                        <ls_line>-tdline
                        INTO ev_text_as_string
                        SEPARATED BY space.
        ENDCASE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD convert_timestamp_to_date.
    DATA:
      lc_tzone_utc       TYPE tznzone VALUE 'UTC'.
*    CALL FUNCTION 'ABI_TIMESTAMP_CONVERT_FROM'
*      EXPORTING
*        iv_timestamp           = IV_TIMESTAMP
*      IMPORTING
*        O_DATE                 = RV_DATE.

*    DATA lv_timestamp TYPE bu_role_valid_from."ad_tstamp.
*    lv_timestamp = ls_partner_address-validitystartdate.
*
*    IF lv_timestamp IS NOT INITIAL.

    CONVERT TIME STAMP iv_timestamp   TIME ZONE lc_tzone_utc
            INTO DATE rv_date.
*    ELSE .
*      ls_output-data-postal-data-validfromdate = ls_partner_address-validitystartdate.
*    ENDIF.

  ENDMETHOD.


  METHOD convert_timestamp_to_date_op.
    DATA:
      lv_timestamp TYPE  tzonref-tstamps,
      lv_date      TYPE  sy-datlo,
      lv_time      TYPE  sy-timlo.

    LOOP AT ct_select_option ASSIGNING FIELD-SYMBOL(<ls_select_option>).
      lv_timestamp = <ls_select_option>-low.
      CALL FUNCTION 'ABI_TIMESTAMP_CONVERT_FROM'
        EXPORTING
          iv_timestamp = lv_timestamp
        IMPORTING
          o_date       = lv_date
          o_time       = lv_time.

      <ls_select_option>-low = lv_date.
    ENDLOOP.
  ENDMETHOD.


  METHOD create_appl_log.
    DATA ls_log TYPE bal_s_log.

* Defining some header data of the application log.
    ls_log-aldate    = sy-datum.
    ls_log-altime    = sy-uzeit.
    ls_log-aluser    = sy-uname.
    ls_log-alprog    = sy-repid.
    ls_log-extnumber = iv_extnumber.
    ls_log-object    = iv_object.
    ls_log-subobject = iv_subobject.

* Creationg the application log.
    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = ls_log
      IMPORTING
        e_log_handle            = ev_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.
* Not necessary to cater for this exception.
  ENDMETHOD.


  METHOD create_bp_data.
    DATA:
      ls_data  TYPE bapibus1006_central,
      ls_datax TYPE bapibus1006_central_x.

    "-- Relationship date
    DATA:
*      LV_TIMESTAMP  TYPE  TZONREF-TSTAMPS,
*      LV_DATE TYPE  SY-DATLO,
*      LV_TIME TYPE  SY-TIMLO .
      lv_validfromdate            TYPE  bapibus1006002_header-validfromdate,
      lv_validuntildate           TYPE  bapibus1006002_header-validuntildate VALUE  '99991231',
      lv_relationshipcategory     TYPE  but050-reltyp,
      lv_relationshiptype         TYPE  but050-relkind,
      lv_differentiationtypevalue TYPE  but050-dftval.

    DATA:
      lv_customer    TYPE kunnr,
      lv_vendor      TYPE lifnr,
      lv_partner     TYPE bu_partner,
      lv_partner2    TYPE bu_partner,
      lv_num10(10)   TYPE n,
      objectkeynew   TYPE  bapi1003_key-object,
      objecttablenew TYPE  bapi1003_key-objecttable,
      classnumnew    TYPE  bapi1003_key-classnum,
      classtypenew   TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar TYPE bapi1003_alloc_values_char,
      lt_return         TYPE STANDARD TABLE OF bapiret2.

    DATA:
      lv_credit_sgmnt  TYPE ukm_credit_sgmnt,
      ls_creditsegment TYPE /simple/cl_mdg_gw_core_mpc=>ts_businesspartnercreditsegmen,
      lt_all_accounts  TYPE  ukm_ts_acc_objs2,
      io_facade        TYPE REF TO cl_ukm_facade,
      io_calculator    TYPE REF TO if_ukm_calculator,
      io_partner       TYPE REF TO cl_ukm_business_partner,
      io_bupa_factory  TYPE REF TO cl_ukm_bupa_factory,
      io_account       TYPE REF TO cl_ukm_account,
      lw_bp_credit_sgm TYPE ukm_s_bp_cms_sgm,
      lw_bp_cms        TYPE ukm_s_bp_cms,
      lt_ukm_return    TYPE ukm_t_monitor_return.

    lv_partner = is_deep_type-objectid.
    IF is_deep_type-objecttype = 'Customer'.
      objecttablenew = 'KNA1'.
      "-- Get customer number based on business partner number
      SELECT SINGLE customer
        INTO lv_customer
        FROM cvi_cust_link AS a
       INNER JOIN but000 AS b
          ON a~partner_guid = b~partner_guid
       WHERE b~partner = lv_partner.

      lv_num10 = lv_customer.
      objectkeynew = lv_num10.
    ELSEIF is_deep_type-objecttype = 'Vendor'.
      objecttablenew = 'LFA1'.
      "-- Get supplier number based on business partner number
      SELECT SINGLE vendor
        INTO lv_vendor
        FROM cvi_vend_link AS a
       INNER JOIN but000 AS b
          ON a~partner_guid = b~partner_guid
       WHERE b~partner = lv_partner.

      lv_num10 = lv_vendor.
      objectkeynew = lv_num10.
    ENDIF.

    LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
      IF ls_classification-class IS NOT INITIAL.
        classnumnew = ls_classification-class.
        classtypenew = ls_classification-classtype.
        LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
          TRANSLATE ls_characteristic-charact TO UPPER CASE.
          s_allocvalueschar-charact = ls_characteristic-charact.
          s_allocvalueschar-value_char = ls_characteristic-value.
          APPEND s_allocvalueschar TO t_allocvalueschar.
          CLEAR ls_characteristic.
        ENDLOOP.

        CALL FUNCTION 'BAPI_OBJCL_CREATE'
          EXPORTING
            objectkeynew    = objectkeynew
            objecttablenew  = objecttablenew
            classnumnew     = classnumnew
            classtypenew    = classtypenew
          TABLES
            allocvalueschar = t_allocvalueschar
            return          = lt_return.

        DELETE lt_return WHERE type <> 'E'.
        IF lt_return IS NOT INITIAL.
          "-- Archive Business Partner
          ls_data-centralarchivingflag  = 'X'.
          ls_datax-centralarchivingflag = 'X'.

          CALL FUNCTION 'BUPA_CENTRAL_CHANGE'
            EXPORTING
              iv_partner = lv_partner
              is_data    = ls_data
              is_data_x  = ls_datax.
*            TABLES
*              et_return  = lt_return.

          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
        ENDIF.

        CLEAR ls_characteristic.
        CLEAR t_allocvalueschar.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    "-- Get credit management data
    " Logic is disabled on S4 but enabled on ECC. S4 class support credit management data.

*    IF is_deep_type-tobusinesspartnercreditprofile IS NOT INITIAL.
*      io_facade = cl_ukm_facade=>create( i_activity = cl_ukm_cnst_eventing=>bp_maintenance ).
*      io_calculator = io_facade->get_calculator( ).
*      io_bupa_factory = io_facade->get_bupa_factory( ).
*
*      "read businee partner
*      io_partner = io_bupa_factory->get_business_partner( lv_partner ).
*
*      "Get credit profile
*      CALL METHOD io_partner->get_bp_cms
*        IMPORTING
*          es_bp_cms = lw_bp_cms.
*
*      "Set credit profile data
*      lw_bp_cms-alternate_bp = is_deep_type-tobusinesspartnercreditprofile-alternatebp.
*      lw_bp_cms-check_rule = is_deep_type-tobusinesspartnercreditprofile-checkrule.
*      lw_bp_cms-credit_group = is_deep_type-tobusinesspartnercreditprofile-creditgroup.
*      lw_bp_cms-limit_rule = is_deep_type-tobusinesspartnercreditprofile-limitrule.
*      lw_bp_cms-own_rating = is_deep_type-tobusinesspartnercreditprofile-ownrating.
*      lw_bp_cms-own_rating_calc = is_deep_type-tobusinesspartnercreditprofile-ownratingcalc.
**      lw_bp_cms-rating_chg_date = is_deep_type-tobusinesspartnercreditprofile-ratingchangedate.
*
*      IF is_deep_type-tobusinesspartnercreditprofile-ratingchangedate <> '0'.
*        lw_bp_cms-rating_chg_date = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-ratingchangedate ).
*      ENDIF.
**      lw_bp_cms-risk_class_chgdt = is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate.
*      IF is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate <> '0'.
*        lw_bp_cms-risk_class_chgdt = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate ).
*      ENDIF.
**      lw_bp_cms-rating_val_date = is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate.
*      IF is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate <> '0'.
*        lw_bp_cms-rating_val_date = convert_timestamp_to_date( EXPORTING iv_timestamp = is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate ).
*      ENDIF.
*
*      lw_bp_cms-risk_class = is_deep_type-tobusinesspartnercreditprofile-riskclass.
*      lw_bp_cms-risk_class_calc = is_deep_type-tobusinesspartnercreditprofile-riskclasscalc.
*      io_partner->set_bp_cms( EXPORTING is_bp_cms = lw_bp_cms ).
*
*    ENDIF.
*
*    "Set credit segment data
*    IF is_deep_type-tobusinesspartnercreditsegment IS NOT INITIAL.
*      LOOP AT is_deep_type-tobusinesspartnercreditsegment INTO ls_creditsegment.
*        lv_credit_sgmnt = ls_creditsegment-creditsegment.
*        CALL METHOD io_bupa_factory->get_credit_account
*          EXPORTING
*            i_partner = lv_partner
*            i_credit_sgmnt = lv_credit_sgmnt
*          RECEIVING
*            ro_credit_account = io_account.
*
*        lw_bp_credit_sgm-block_reason = ls_creditsegment-blockreason.
*        lw_bp_credit_sgm-coordinator = ls_creditsegment-coordinator.
*        lw_bp_credit_sgm-credit_limit = ls_creditsegment-creditlimit.
*        lw_bp_credit_sgm-cred_lim_calc = ls_creditsegment-creditlimitcal.
*        lw_bp_credit_sgm-cred_lim_req = ls_creditsegment-creditlimitreq.
*        lw_bp_credit_sgm-cust_group = ls_creditsegment-custgroup.
**        lw_bp_credit_sgm-follow_up_dt = ls_creditsegment-followupdate.
*        IF ls_creditsegment-followupdate <> '0'.
*          lw_bp_credit_sgm-follow_up_dt = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-followupdate ).
*        ENDIF.
*
*        lw_bp_credit_sgm-automatic_req = ls_creditsegment-isautomaticreq.
*        lw_bp_credit_sgm-xblocked = ls_creditsegment-isblocked.
*        lw_bp_credit_sgm-item_error = ls_creditsegment-isitemerror.
*        lw_bp_credit_sgm-x_limit_zero = ls_creditsegment-islimitzero.
*        lw_bp_credit_sgm-limit_chg_date = ls_creditsegment-limitchangedate.
*
*        IF ls_creditsegment-limitchangedate <> '0'.
*          lw_bp_credit_sgm-limit_chg_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-limitchangedate ).
*        ENDIF.
*
**        lw_bp_credit_sgm-limit_valid_date = ls_creditsegment-limitvaliddate.
*        IF ls_creditsegment-limitvaliddate <> '0'.
*          lw_bp_credit_sgm-limit_valid_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-limitvaliddate ).
*        ENDIF.
*
*        lw_bp_credit_sgm-log_hndl = ls_creditsegment-loghndl.
**        lw_bp_credit_sgm-req_date = ls_creditsegment-reqdate.
*        IF ls_creditsegment-reqdate <> '0'.
*          lw_bp_credit_sgm-req_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-reqdate ).
*        ENDIF.
*
**        lw_bp_credit_sgm-limit_valid_date = ls_creditsegment-validtodate.
*        IF ls_creditsegment-validtodate <> '0'.
*          lw_bp_credit_sgm-limit_valid_date = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_creditsegment-validtodate ).
*        ENDIF.
*
*        lw_bp_credit_sgm-xcritical = ls_creditsegment-iscritical.
*        io_account->set_bp_cms_sgm( EXPORTING is_bp_cms_sgm = lw_bp_credit_sgm ).
*
*      ENDLOOP.
*
*      io_bupa_factory->save_all( EXPORTING i_upd_task = '' ).
*
*    ENDIF.

    IF is_deep_type-tobusinesspartnerrelationship IS NOT INITIAL.
*      LOOP AT is_deep_type-tobusinesspartnerrelationship INTO DATA(ls_businesspartnerrelationship).
*
*        lv_partner2 = ls_businesspartnerrelationship-businesspartner.
*        lv_differentiationtypevalue = ls_businesspartnerrelationship-differentiationtypevalue.
*        lv_relationshiptype = ls_businesspartnerrelationship-relationshiptype.
*        lv_validfromdate = sy-datlo.
*        IF ls_businesspartnerrelationship-validfromdate IS NOT INITIAL.
**          lv_validfromdate = ls_businesspartnerrelationship-validfromdate.
*          IF ls_businesspartnerrelationship-validfromdate <> '0'.
*            lv_validfromdate = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_businesspartnerrelationship-validfromdate ).
*          ENDIF.
*        ENDIF.
*
*        IF ls_businesspartnerrelationship-validuntildate IS NOT INITIAL.
**          lv_validuntildate = ls_businesspartnerrelationship-validuntildate.
*          IF ls_businesspartnerrelationship-validuntildate <> '0'.
*            lv_validuntildate = convert_timestamp_to_date( EXPORTING iv_timestamp = ls_businesspartnerrelationship-validuntildate ).
*          ENDIF.
*        ENDIF.
*
*        IF strlen( ls_businesspartnerrelationship-relationshipcategory ) = 6.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner
*              businesspartner2               = lv_partner2
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*
*        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'T'.
*          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner2
*              businesspartner2               = lv_partner
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*
*        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'F'.
*          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
*          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
*
*          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_CREATE'
*            EXPORTING
*              businesspartner1               = lv_partner
*              businesspartner2               = lv_partner2
*              relationshipcategory           = lv_relationshipcategory
*              relationshiptype               = lv_relationshiptype
*              validfromdate                  = lv_validfromdate
*              validuntildate                 = lv_validuntildate
*              differentiationtypevalue       = lv_differentiationtypevalue
**              XDFREL                         =
*            TABLES
*              return                         = lt_return.
*        ENDIF.
*
*        DELETE lt_return WHERE type <> 'E'.
*        IF lt_return IS NOT INITIAL.
*          "-- Archive Business Partner
*          ls_data-centralarchivingflag  = 'X'.
*          ls_datax-centralarchivingflag = 'X'.
*
*          CALL FUNCTION 'BUPA_CENTRAL_CHANGE'
*            EXPORTING
*              iv_partner = lv_partner
*              is_data    = ls_data
*              is_data_x  = ls_datax.
**            TABLES
**              et_return  = lt_return.
*
*          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
*          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
*        ENDIF.
*
*
*        CLEAR lt_return.
*      ENDLOOP.
    ENDIF.

    IF is_deep_type-action = 'Create'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD create_product_data.
    DATA:
      material       TYPE  bapimatall-material,
      lv_num(18)     TYPE n,
      lv_char18(18)  TYPE c,
      objectkeynew   TYPE  bapi1003_key-object,
      objecttablenew TYPE  bapi1003_key-objecttable VALUE 'MARA',
      classnumnew    TYPE  bapi1003_key-classnum,
      classtypenew   TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar TYPE bapi1003_alloc_values_char,
      lt_return         TYPE STANDARD TABLE OF bapiret2.

*    lv_num = is_deep_type-objectid.
*    objectkeynew = lv_num.
    lv_char18 = is_deep_type-objectid.
    objecttablenew = 'MARA'.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = lv_char18
      IMPORTING
        output = lv_char18.

    objectkeynew = lv_char18.

    LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
      IF ls_classification-class IS NOT INITIAL.
        classnumnew = ls_classification-class.
        classtypenew = ls_classification-classtype.
        LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
          TRANSLATE ls_characteristic-charact TO UPPER CASE.
          s_allocvalueschar-charact = ls_characteristic-charact.
          s_allocvalueschar-value_char = ls_characteristic-value.
          APPEND s_allocvalueschar TO t_allocvalueschar.
          CLEAR ls_characteristic.
        ENDLOOP.

        CALL FUNCTION 'BAPI_OBJCL_CREATE'
          EXPORTING
            objectkeynew    = objectkeynew
            objecttablenew  = objecttablenew
            classnumnew     = classnumnew
            classtypenew    = classtypenew
          TABLES
            allocvalueschar = t_allocvalueschar
            return          = lt_return.

        DELETE lt_return WHERE type <> 'E'.

        IF lt_return IS NOT INITIAL.
          "-- Archive Material
          material = is_deep_type-objectid.

          CALL FUNCTION 'BAPI_MATERIAL_DELETE'
            EXPORTING
              material = material.

          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
        ENDIF.

        CLEAR ls_characteristic.
        CLEAR t_allocvalueschar.
        CLEAR classnumnew.
        CLEAR classtypenew.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD delete_bp_data.
    DATA:
      lv_partner1                 TYPE  bapibus1006_head-bpartner,
      lv_partner2                 TYPE  bapibus1006_head-bpartner,
      lv_relationshipcategory     TYPE  but050-reltyp,
      lv_differentiationtypevalue TYPE  but050-dftval.

    DATA:
      lv_num10(10) TYPE n,
      objectkeynew TYPE  bapi1003_key-object,
      objecttable  TYPE  bapi1003_key-objecttable,
      classnumnew  TYPE  bapi1003_key-classnum,
      classtypenew TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar    TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar    TYPE bapi1003_alloc_values_char,
      t_allocvaluesnumnew  TYPE STANDARD TABLE OF  bapi1003_alloc_values_num,
      t_allocvaluescurrnew TYPE STANDARD TABLE OF  bapi1003_alloc_values_curr,
      lt_return            TYPE STANDARD TABLE OF bapiret2.

    lv_num10 = is_deep_type-objectid.
    objectkeynew = lv_num10.

    lv_partner1 = lv_num10.
    lv_num10 = is_deep_type-objectid.
    objectkeynew = lv_num10.
    IF is_deep_type-objecttype = 'Customer'.
      objecttable = 'KNA1'.
      lv_num10 = is_deep_type-objectid.
      objectkeynew = lv_num10.
    ELSEIF is_deep_type-objecttype = 'Vendor'.
      objecttable = 'LFA1'.

    ENDIF.

    LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
      IF ls_classification-class IS NOT INITIAL AND ls_classification-classtype IS NOT INITIAL.
        classnumnew = ls_classification-class.
        classtypenew = ls_classification-classtype.
        LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
          TRANSLATE ls_characteristic-charact TO UPPER CASE.
          s_allocvalueschar-charact = ls_characteristic-charact.
          s_allocvalueschar-value_char = ls_characteristic-value.
          APPEND s_allocvalueschar TO t_allocvalueschar.
          CLEAR ls_characteristic.
        ENDLOOP.

        CALL FUNCTION 'BAPI_OBJCL_DELETE'
          EXPORTING
            objectkey   = objectkeynew
            objecttable = objecttable
            classnum    = classnumnew
            classtype   = classtypenew
          TABLES
            return      = lt_return.

        DELETE lt_return WHERE type <> 'E'.

        IF lt_return IS NOT INITIAL.
          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
        ENDIF.

        IF is_deep_type-action = 'DeleteTest'.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        ENDIF.

        CLEAR ls_characteristic.
        CLEAR t_allocvalueschar.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    IF is_deep_type-tobusinesspartnerrelationship IS NOT INITIAL.
      LOOP AT is_deep_type-tobusinesspartnerrelationship INTO DATA(ls_businesspartnerrelationship).
        lv_differentiationtypevalue = ls_businesspartnerrelationship-differentiationtypevalue.
        lv_partner2 = ls_businesspartnerrelationship-businesspartner.
        IF strlen( ls_businesspartnerrelationship-relationshipcategory ) = 6.
          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.
          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_DELETE'
            EXPORTING
              businesspartner1         = lv_partner1
              businesspartner2         = lv_partner2
              relationshipcategory     = lv_relationshipcategory
              differentiationtypevalue = lv_differentiationtypevalue
            TABLES
              return                   = lt_return.
        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'F'.
          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.

          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_DELETE'
            EXPORTING
              businesspartner1         = lv_partner2
              businesspartner2         = lv_partner1
              relationshipcategory     = lv_relationshipcategory
              differentiationtypevalue = lv_differentiationtypevalue
            TABLES
              return                   = lt_return.
        ELSEIF ls_businesspartnerrelationship-relationshipcategory(1) = 'T'.
          SHIFT ls_businesspartnerrelationship-relationshipcategory  BY 1 PLACES.
          lv_relationshipcategory = ls_businesspartnerrelationship-relationshipcategory.

          CALL FUNCTION 'BAPI_BUPR_RELATIONSHIP_DELETE'
            EXPORTING
              businesspartner1         = lv_partner1
              businesspartner2         = lv_partner2
              relationshipcategory     = lv_relationshipcategory
              differentiationtypevalue = lv_differentiationtypevalue
            TABLES
              return                   = lt_return.
        ENDIF.

        DELETE lt_return WHERE type <> 'E'.

        IF lt_return IS NOT INITIAL.
          RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
        ENDIF.

        IF is_deep_type-action = 'DeleteTest'.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        ENDIF.

      ENDLOOP.
      CLEAR lt_return.
    ENDIF.

    IF is_deep_type-action = 'Delete'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD delete_product_data.
    DATA:
      material       TYPE  bapimatall-material,
      lv_num(18)     TYPE n,
      objectkeynew   TYPE  bapi1003_key-object,
      objecttablenew TYPE  bapi1003_key-objecttable,
      classnumnew    TYPE  bapi1003_key-classnum,
      classtypenew   TYPE  bapi1003_key-classtype.

    DATA:
      t_allocvalueschar    TYPE STANDARD TABLE OF bapi1003_alloc_values_char,
      s_allocvalueschar    TYPE bapi1003_alloc_values_char,
      t_allocvaluesnumnew  TYPE STANDARD TABLE OF  bapi1003_alloc_values_num,
      t_allocvaluescurrnew TYPE STANDARD TABLE OF  bapi1003_alloc_values_curr,
      lt_return            TYPE STANDARD TABLE OF bapiret2.

    lv_num = is_deep_type-objectid.
    objectkeynew = lv_num.

    LOOP AT is_deep_type-toclassification INTO DATA(ls_classification).
      classnumnew = ls_classification-class.
      classtypenew = ls_classification-classtype.
      LOOP AT ls_classification-tocharacteristic INTO DATA(ls_characteristic).
        TRANSLATE ls_characteristic-charact TO UPPER CASE.
        s_allocvalueschar-charact = ls_characteristic-charact.
        s_allocvalueschar-value_char = ls_characteristic-value.
        APPEND s_allocvalueschar TO t_allocvalueschar.
        CLEAR ls_characteristic.
      ENDLOOP.

      CALL FUNCTION 'BAPI_OBJCL_DELETE'
        EXPORTING
          objectkey   = objectkeynew
          objecttable = 'MARA'
          classnum    = classnumnew
          classtype   = classtypenew
        TABLES
          return      = lt_return.

      DELETE lt_return WHERE type <> 'E'.

      IF lt_return IS NOT INITIAL.
        RAISE EXCEPTION TYPE /simple/cx_custom_error EXPORTING it_return = lt_return.
      ENDIF.

      IF is_deep_type-action = 'DeleteTest'.
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      ENDIF.

      CLEAR ls_characteristic.
      CLEAR t_allocvalueschar.
      CLEAR lt_return.

    ENDLOOP.

    IF is_deep_type-action = 'Delete'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = is_deep_type
                             CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD export_messages.

    DATA: lt_return_msgs TYPE STANDARD TABLE OF bapiret2,
          ls_return_msg  LIKE LINE OF lt_return_msgs.

    CASE iv_error.

      WHEN 'KEYS'.

        ls_return_msg-number = '031'.

      WHEN 'INVALID'.

        ls_return_msg-number = '032'.

      WHEN 'MULTIPLE'.

        ls_return_msg-number = '033'.

      WHEN 'NOBP'.

        ls_return_msg-number = '034'.

      WHEN 'UNSUPPORTEDPHONETYPE'.

        ls_return_msg-number = '080'.

      WHEN 'NOCONSUMERKEY'.

        ls_return_msg-number = '074'.

      WHEN 'NOADDRDATA'.

        ls_return_msg-number = '079'.

      WHEN 'NOPHONEDATA'.

        ls_return_msg-number = '075'.

      WHEN 'NOFAXDATA'.

        ls_return_msg-number = '076'.

      WHEN 'NOEMAILDATA'.

        ls_return_msg-number = '078'.

      WHEN 'NOURLDATA'.

        ls_return_msg-number = '077'.

    ENDCASE.

    IF ls_return_msg IS NOT INITIAL.
      ls_return_msg-id = 'CI_DRAFTBP_MESSAGE'.
      ls_return_msg-type = 'E'.
      APPEND ls_return_msg TO lt_return_msgs.
      IF 1 EQ 2. " for message traceability
        MESSAGE e031(ci_draftbp_message).
        MESSAGE e032(ci_draftbp_message).
        MESSAGE e033(ci_draftbp_message).
        MESSAGE e034(ci_draftbp_message).
        MESSAGE e074(ci_draftbp_message).
        MESSAGE e075(ci_draftbp_message).
        MESSAGE e076(ci_draftbp_message).
        MESSAGE e077(ci_draftbp_message).
        MESSAGE e078(ci_draftbp_message).
        MESSAGE e079(ci_draftbp_message).
        MESSAGE e080(ci_draftbp_message).
      ENDIF.
    ENDIF.

    IF lt_return_msgs IS NOT INITIAL.

      CALL METHOD mo_context->get_message_container( )->add_messages_from_bapi(
              EXPORTING
              it_bapi_messages = lt_return_msgs
              iv_determine_leading_msg = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          entity_type       = iv_entity_name
          http_status_code  = /iwbep/cx_mgw_busi_exception=>gcs_http_status_codes-bad_request
          message_container = mo_context->get_message_container( ).

    ENDIF.

  ENDMETHOD.


  METHOD fill_address_comm_email_data.

    DATA: ls_email_payload_data TYPE cl_api_business_partne_mpc=>ts_a_addressemailaddresstype,   " Declaration for email data.
          ls_email_api_input    TYPE LINE OF bus_ei_bupa_smtp_t,
          lt_email_api_input    TYPE bus_ei_bupa_smtp_t,
          lt_db_email_data      TYPE TABLE OF bapiadsmtp,
          lv_bp_adr_guid        TYPE but020-address_guid,
          ls_address_api_input  TYPE bus_ei_bupa_address,
          lv_bp_adr_num         TYPE ad_addrnum,
          lx_busi_excep         TYPE REF TO /iwbep/cx_mgw_busi_exception,
          lx_tech_excep         TYPE REF TO /iwbep/cx_mgw_tech_exception.

    ls_email_payload_data = is_data.
    " Check existence of address in DB
    CALL FUNCTION 'BUPA_ADDRESS_READ_NUMBERS'
      EXPORTING
        iv_partner            = gv_partner
        iv_addrnumber         = ls_email_payload_data-addressid
      IMPORTING
        ev_addrguid           = lv_bp_adr_guid
      EXCEPTIONS
        no_partner_specified  = 1
        no_address_specified  = 2
        no_valid_record_found = 3
        not_found             = 4
        blocked_partner       = 5
        OTHERS                = 6.
    IF sy-subrc EQ 0 AND lv_bp_adr_guid IS NOT INITIAL.
      " Read email and Remarks data from db
      CALL FUNCTION 'BUPA_ADDRESS_READ_DETAIL'
        EXPORTING
          iv_partner            = gv_partner
          iv_addrnumber         = ls_email_payload_data-addressid
          iv_xadsmtp            = 'X'
          iv_xadcomrem          = 'X'
        TABLES
          et_adsmtp             = lt_db_email_data
        EXCEPTIONS
          no_partner_specified  = 1
          no_valid_record_found = 2
          not_found             = 3
          blocked_partner       = 4
          OTHERS                = 5.
      IF lt_db_email_data IS NOT INITIAL OR iv_task EQ 'I'.
        IF iv_task EQ 'I' AND ls_email_payload_data-ordinalnumber IS NOT INITIAL.
          " ordinal number is not required for insert scenario, as ordinal number is generated by address api but not the user.
          CLEAR ls_email_payload_data-ordinalnumber.
        ENDIF.
        IF iv_task NE 'I'.
          " Only required for update/delete scenario to check if the record with same ordinal number provided in the payload exists in the db for update/delete
          READ TABLE lt_db_email_data WITH KEY consnumber = ls_email_payload_data-ordinalnumber TRANSPORTING NO FIELDS.
        ENDIF.
        " For update and delete scenario, an entry with same consumer number should exist in db
        IF ( sy-subrc EQ 0 AND ( iv_task EQ 'U' OR iv_task EQ 'D' ) ) OR ( iv_task EQ 'I').
          " Add/delete db data or changed data data to the api input structures to prepare for full send
          LOOP AT lt_db_email_data ASSIGNING FIELD-SYMBOL(<fs_db_email_data>).
            CLEAR ls_email_api_input.
            " For delete scenario, skip adding the record with ordinal number specified in the payload to the full send structure so that it will be deleted
            IF iv_task EQ 'D' AND <fs_db_email_data>-consnumber EQ ls_email_payload_data-ordinalnumber.
              CONTINUE.
            ENDIF.
            " For update scenario, Map payload data to the api input structure, replacing the db data
            IF iv_task EQ 'U' AND <fs_db_email_data>-consnumber EQ ls_email_payload_data-ordinalnumber.
              ls_email_api_input-contact-data-e_mail = ls_email_payload_data-emailaddress.
            ELSE.
              " Move db data to the full send api structures for insert or update scenario
              MOVE-CORRESPONDING <fs_db_email_data> TO ls_email_api_input-contact-data.
            ENDIF.
            " Conusmer numbers are generated by the Address API, hence clearing the consumer numbers in the full send data
            CLEAR ls_email_api_input-contact-data-consnumber.
            APPEND ls_email_api_input TO lt_email_api_input.
          ENDLOOP.
          " In the case of create scenario, add the new record from the payload to the full send api structure to complete the current state
          IF iv_task EQ 'I'.
            CLEAR ls_email_api_input.
            " Map payload data to the api input structure
            ls_email_api_input-contact-data-e_mail = ls_email_payload_data-emailaddress.
            APPEND ls_email_api_input TO lt_email_api_input.
          ENDIF.
          " fill address header , task and time depandant flags
          ls_address_api_input-data-communication-smtp-smtp = lt_email_api_input.
          ls_address_api_input-data_key-guid = lv_bp_adr_guid.
          ls_address_api_input-data-communication-time_dependent = 'X'.
          ls_address_api_input-task = 'U'.
          ls_address_api_input-data-communication-smtp-current_state = 'X'.
          " check if the address data already exists in the global structure
          READ TABLE gs_data-partner-central_data-address-addresses WITH KEY data_key-guid = lv_bp_adr_guid ASSIGNING FIELD-SYMBOL(<ls_address>).
          IF sy-subrc EQ 0.
            " if address data already exists in the global structure , replace email records with the current full send data and set required header data
            <ls_address>-data-communication-smtp-smtp = lt_email_api_input  .
            <ls_address>-data-communication-time_dependent = 'X'.
            <ls_address>-data-communication-smtp-current_state = 'X'.
          ELSE.
            "  If address data doesn't exist, add a new record to the global structure.
            APPEND ls_address_api_input TO gs_data-partner-central_data-address-addresses.
            gs_data-partner-central_data-address-time_dependent = 'X'.
          ENDIF.
          " For insert task, send the inserted record as export. This is used later in calling method to send comfirmation to the end user
          IF iv_task EQ 'I' .
            es_data = lt_email_api_input.
          ENDIF.
        ELSE.
          IF iv_task EQ 'U' OR iv_task EQ 'D'.   " consumer key doesn't exist
            TRY .
                export_messages( iv_error =  'NOCONSUMERKEY'
                                iv_entity_name = 'A_AddressEmailAddress' ).
              CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                RAISE EXCEPTION lx_busi_excep.
              CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                RAISE EXCEPTION lx_tech_excep.
            ENDTRY.
          ENDIF.
        ENDIF.
      ELSE.  " No email data exists to update
        IF iv_task EQ 'D' OR iv_task EQ 'U'.
          TRY .
              export_messages( iv_error =  'NOEMAILDATA'
                              iv_entity_name = 'A_AddressEmailAddress' ).
            CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
              RAISE EXCEPTION lx_busi_excep.
            CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
              RAISE EXCEPTION lx_tech_excep.
          ENDTRY.
        ENDIF.
      ENDIF.
    ELSE. " Address doesn't exists
      TRY .
          export_messages( iv_error =  'NOADDRDATA'
                          iv_entity_name = 'A_AddressEmailAddress' ).
        CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
          RAISE EXCEPTION lx_busi_excep.
        CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
          RAISE EXCEPTION lx_tech_excep.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD fill_address_comm_fax_data.

    DATA: ls_fax_payload_data  TYPE cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype,   " Declaration for fax data.
          ls_fax_api_input     TYPE LINE OF bus_ei_bupa_fax_t,
          lt_fax_api_input     TYPE bus_ei_bupa_fax_t,
          lt_db_fax_data       TYPE TABLE OF bapiadfax,
          ls_address_api_input TYPE bus_ei_bupa_address,
          lv_bp_adr_guid       TYPE but020-address_guid,
          lv_bp_adr_num        TYPE ad_addrnum,
          lx_busi_excep        TYPE REF TO /iwbep/cx_mgw_busi_exception,
          lx_tech_excep        TYPE REF TO /iwbep/cx_mgw_tech_exception.

    ls_fax_payload_data = is_data.
    " Check existence of address in DB
    CALL FUNCTION 'BUPA_ADDRESS_READ_NUMBERS'
      EXPORTING
        iv_partner            = gv_partner
        iv_addrnumber         = ls_fax_payload_data-addressid
      IMPORTING
        ev_addrguid           = lv_bp_adr_guid   " This  will be used to fill address headers later in this program
      EXCEPTIONS
        no_partner_specified  = 1
        no_address_specified  = 2
        no_valid_record_found = 3
        not_found             = 4
        blocked_partner       = 5
        OTHERS                = 6.
    IF sy-subrc EQ 0 AND lv_bp_adr_guid IS NOT INITIAL.
      " Read Fax and Remarks data from db
      CALL FUNCTION 'BUPA_ADDRESS_READ_DETAIL'
        EXPORTING
          iv_partner            = gv_partner
          iv_addrnumber         = ls_fax_payload_data-addressid
          iv_xadfax             = 'X'
          iv_xadcomrem          = 'X'
        TABLES
          et_adfax              = lt_db_fax_data
        EXCEPTIONS
          no_partner_specified  = 1
          no_valid_record_found = 2
          not_found             = 3
          blocked_partner       = 4
          OTHERS                = 5.
      IF lt_db_fax_data IS NOT INITIAL OR iv_task EQ 'I'.
        IF iv_task EQ 'I' AND ls_fax_payload_data-ordinalnumber IS NOT INITIAL.
          " ordinal number is not required for insert scenario, as ordinal number is generated by address api but not the user.
          CLEAR ls_fax_payload_data-ordinalnumber.
        ENDIF.
        IF iv_task NE 'I'.
          " Only required for update/delete scenario to check if the record with same ordinal number provided in the payload exists in the db for update/delete
          READ TABLE lt_db_fax_data WITH KEY consnumber = ls_fax_payload_data-ordinalnumber TRANSPORTING NO FIELDS.
        ENDIF.
        "For update and delete scenario, an entry with same consumer number should exist in db
        IF ( sy-subrc EQ 0 AND ( iv_task EQ 'U' OR iv_task EQ 'D' ) ) OR ( iv_task EQ 'I').
          " Add/delete db data or changed data data to the api input structures to prepare for full send
          LOOP AT lt_db_fax_data ASSIGNING FIELD-SYMBOL(<fs_db_fax_data>).
            CLEAR ls_fax_api_input.
            " For delete scenario, skip adding the record with ordinal number specified in the payload to the full send structure so that it will be deleted
            IF iv_task EQ 'D' AND <fs_db_fax_data>-consnumber EQ ls_fax_payload_data-ordinalnumber.
              CONTINUE.
            ENDIF.
            " For update scenario, Map payload data to the api input structure, replacing the db data
            IF iv_task EQ 'U' AND <fs_db_fax_data>-consnumber EQ ls_fax_payload_data-ordinalnumber.
              ls_fax_api_input-contact-data-country = ls_fax_payload_data-faxcountry.
              ls_fax_api_input-contact-data-fax = ls_fax_payload_data-faxnumber.
              ls_fax_api_input-contact-data-extension = ls_fax_payload_data-faxnumberextension.
            ELSE.
              " Move db data to the full send api structures for insert or update scenario
              MOVE-CORRESPONDING <fs_db_fax_data> TO ls_fax_api_input-contact-data.
            ENDIF.
*            " Conusmer numbers are generated by the Address API, hence clearing the consumer numbers in the full send data
            CLEAR ls_fax_api_input-contact-data-consnumber.
            APPEND ls_fax_api_input TO lt_fax_api_input.
          ENDLOOP.
          " In the case of create scenario, add the new record from the payload to the full send api structure to complete the current state
          IF iv_task EQ 'I'.
            CLEAR ls_fax_api_input.
            " Map payload data to the api input structure
            ls_fax_api_input-contact-data-country = ls_fax_payload_data-faxcountry.
            ls_fax_api_input-contact-data-fax = ls_fax_payload_data-faxnumber.
            ls_fax_api_input-contact-data-extension = ls_fax_payload_data-faxnumberextension.
            APPEND ls_fax_api_input TO lt_fax_api_input.
          ENDIF.
          " fill address header , task and time depandant flags
          ls_address_api_input-data-communication-fax-fax = lt_fax_api_input.
          ls_address_api_input-data_key-guid = lv_bp_adr_guid.
          ls_address_api_input-data-communication-time_dependent = 'X'.
          ls_address_api_input-task = 'U'.
          ls_address_api_input-data-communication-fax-current_state = 'X'.
          " check if the address data already exists in the global structure
          READ TABLE gs_data-partner-central_data-address-addresses WITH KEY data_key-guid = lv_bp_adr_guid ASSIGNING FIELD-SYMBOL(<ls_address>).
          IF sy-subrc EQ 0.
            " if address data already exists in the global structure , replace fax records with the current full send data and set required header data
            <ls_address>-data-communication-fax-fax = lt_fax_api_input  .
            <ls_address>-data-communication-time_dependent = 'X'.
            <ls_address>-data-communication-fax-current_state = 'X'.
          ELSE.
            "  If address data doesn't exist, add a new record to the global structure.
            APPEND ls_address_api_input TO gs_data-partner-central_data-address-addresses.
            gs_data-partner-central_data-address-time_dependent = 'X'.
          ENDIF.
          IF iv_task EQ 'I' .
            es_data = lt_fax_api_input.
          ENDIF.
        ELSE.
          IF iv_task EQ 'U' OR iv_task EQ 'D'.   " consumer key doesn't exist
            TRY .
                export_messages( iv_error =  'NOCONSUMERKEY'
                                iv_entity_name = 'A_BusinessPartner' ).
              CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                RAISE EXCEPTION lx_busi_excep.
              CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                RAISE EXCEPTION lx_tech_excep.
            ENDTRY.
          ENDIF.
        ENDIF.
      ELSE.  " No fax data exists to update
        IF iv_task EQ 'D' OR iv_task EQ 'U'.
          TRY .
              export_messages( iv_error =  'NOFAXDATA'
                              iv_entity_name = 'A_BusinessPartner' ).
            CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
              RAISE EXCEPTION lx_busi_excep.
            CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
              RAISE EXCEPTION lx_tech_excep.
          ENDTRY.
        ENDIF.
      ENDIF.
    ELSE.  " Address doesn't exists
      TRY .
          export_messages( iv_error =  'NOADDRDATA'
                          iv_entity_name = 'A_BusinessPartner' ).
        CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
          RAISE EXCEPTION lx_busi_excep.
        CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
          RAISE EXCEPTION lx_tech_excep.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD fill_address_comm_phone_data.

    DATA: ls_phone_payload_data TYPE cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,   " Declaration for telephone data.
          ls_phone_api_input    TYPE LINE OF bus_ei_bupa_telephone_t,
          lt_phone_api_input    TYPE bus_ei_bupa_telephone_t,
          lt_db_phone_data      TYPE TABLE OF bapiadtel,            " Declarations for address and exceptions
          ls_address_api_input  TYPE bus_ei_bupa_address,
          lv_bp_adr_guid        TYPE but020-address_guid,
          lv_bp_adr_num         TYPE ad_addrnum,
          lx_busi_excep         TYPE REF TO /iwbep/cx_mgw_busi_exception,
          lx_tech_excep         TYPE REF TO /iwbep/cx_mgw_tech_exception.

    ls_phone_payload_data = is_data.
    " Check existence of address in DB
    CALL FUNCTION 'BUPA_ADDRESS_READ_NUMBERS'
      EXPORTING
        iv_partner            = gv_partner
        iv_addrnumber         = ls_phone_payload_data-addressid
      IMPORTING
        ev_addrguid           = lv_bp_adr_guid   " This  will be used to fill address headers later in this program
      EXCEPTIONS
        no_partner_specified  = 1
        no_address_specified  = 2
        no_valid_record_found = 3
        not_found             = 4
        blocked_partner       = 5
        OTHERS                = 6.
    IF sy-subrc EQ 0 AND lv_bp_adr_guid IS NOT INITIAL.
      " Read phone and Remarks data from db
      CALL FUNCTION 'BUPA_ADDRESS_READ_DETAIL'
        EXPORTING
          iv_partner            = gv_partner
          iv_addrnumber         = ls_phone_payload_data-addressid
          iv_xadtel             = 'X'
          iv_xadcomrem          = 'X'
        TABLES
          et_adtel              = lt_db_phone_data
        EXCEPTIONS
          no_partner_specified  = 1
          no_valid_record_found = 2
          not_found             = 3
          blocked_partner       = 4
          OTHERS                = 5.
      IF lt_db_phone_data IS NOT INITIAL OR iv_task EQ 'I'.
        IF iv_task EQ 'I' AND ls_phone_payload_data-ordinalnumber IS NOT INITIAL.
          " ordinal number is not required for insert scenario, as ordinal number is generated by address api but not the user.
          CLEAR ls_phone_payload_data-ordinalnumber.
        ENDIF.
        IF iv_task NE 'I'.
          " Only required for update/delete scenario to check if the record with same ordinal number provided in the payload exists in the db for update/delete
          READ TABLE lt_db_phone_data WITH KEY consnumber = ls_phone_payload_data-ordinalnumber TRANSPORTING NO FIELDS.
        ENDIF.
        " For update and delete scenario, an entry with same consumer number should exist in db
        IF ( sy-subrc EQ 0 AND ( iv_task EQ 'U' OR iv_task EQ 'D' ) ) OR ( iv_task EQ 'I').
          " Add/delete db data or changed data data to the api input structures to prepare for full send
          LOOP AT lt_db_phone_data ASSIGNING FIELD-SYMBOL(<fs_db_phone_data>).
            CLEAR ls_phone_api_input.
            " For delete scenario, skip adding the record with ordinal number specified in the payload to the full send structure so that it will be deleted
            IF iv_task EQ 'D' AND <fs_db_phone_data>-consnumber EQ ls_phone_payload_data-ordinalnumber.
              CONTINUE.
            ENDIF.
            " For update scenario, Map payload data to the api input structure, replacing the db data
            IF iv_task EQ 'U' AND <fs_db_phone_data>-consnumber EQ ls_phone_payload_data-ordinalnumber.
              ls_phone_api_input-contact-data-country = ls_phone_payload_data-destinationlocationcountry.
              ls_phone_api_input-contact-data-telephone = ls_phone_payload_data-phonenumber.
              ls_phone_api_input-contact-data-extension = ls_phone_payload_data-phonenumberextension.
              CASE iv_entity_name.
                WHEN 'A_AddressPhoneNumberType'.
                  ls_phone_api_input-contact-data-r_3_user = '1'.
                WHEN 'A_AddressMobilePhoneNumberType'.
                  ls_phone_api_input-contact-data-r_3_user = '3'.
                WHEN OTHERS.
                  TRY .
                      export_messages( iv_error =  'UNSUPPORTEDPHONETYPE'
                                      iv_entity_name = 'A_AddressPhoneNumber' ).
                    CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                      RAISE EXCEPTION lx_busi_excep.
                    CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                      RAISE EXCEPTION lx_tech_excep.
                  ENDTRY.
              ENDCASE.
            ELSE.
              " Move db data to the full send api structures for insert or update scenario
              MOVE-CORRESPONDING <fs_db_phone_data> TO ls_phone_api_input-contact-data.
            ENDIF.
*          " Conusmer numbers are generated by the Address API, hence clearing the consumer numbers in the full send data
            CLEAR ls_phone_api_input-contact-data-consnumber.
            APPEND ls_phone_api_input TO lt_phone_api_input.
          ENDLOOP.
          " In the case of create scenario, add the new record from the payload to the full send api structure to complete the current state
          IF iv_task EQ 'I'.
            CLEAR ls_phone_api_input.
            " Map payload data to the api input structure
            ls_phone_api_input-contact-data-country = ls_phone_payload_data-destinationlocationcountry.
            ls_phone_api_input-contact-data-telephone = ls_phone_payload_data-phonenumber.
            ls_phone_api_input-contact-data-extension = ls_phone_payload_data-phonenumberextension.
            CASE iv_entity_name.
              WHEN 'A_AddressPhoneNumberType'.
                ls_phone_api_input-contact-data-r_3_user = '1'.
              WHEN 'A_AddressMobilePhoneNumberType'.
                ls_phone_api_input-contact-data-r_3_user = '3'.
              WHEN 'A_AddressMobileOrPhoneNumber'.
                ls_phone_api_input-contact-data-r_3_user = ls_phone_payload_data-phonenumbertype.
              WHEN OTHERS.
                TRY .
                    export_messages( iv_error =  'UNSUPPORTEDPHONETYPE'
                                    iv_entity_name = 'A_AddressPhoneNumber' ).
                  CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                    RAISE EXCEPTION lx_busi_excep.
                  CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                    RAISE EXCEPTION lx_tech_excep.
                ENDTRY.
            ENDCASE.
            APPEND ls_phone_api_input TO lt_phone_api_input.
          ENDIF.
          " fill address header , task and time depandant flags
          ls_address_api_input-data-communication-phone-phone = lt_phone_api_input.
          ls_address_api_input-data_key-guid = lv_bp_adr_guid.
          ls_address_api_input-data-communication-time_dependent = 'X'.
          ls_address_api_input-task = 'U'.
          ls_address_api_input-data-communication-phone-current_state = 'X'.
          " check if the address data already exists in the global structure
          READ TABLE gs_data-partner-central_data-address-addresses WITH KEY data_key-guid = lv_bp_adr_guid ASSIGNING FIELD-SYMBOL(<ls_address>).
          IF sy-subrc EQ 0.
            " if address data already exists in the global structure , replace phone records with the current full send data and set required header data
            <ls_address>-data-communication-phone-phone = lt_phone_api_input  .
            <ls_address>-data-communication-time_dependent = 'X'.
            <ls_address>-data-communication-phone-current_state = 'X'.
          ELSE.
            "  If address data doesn't exist, add a new record to the global structure.
            APPEND ls_address_api_input TO gs_data-partner-central_data-address-addresses.
            gs_data-partner-central_data-address-time_dependent = 'X'.
          ENDIF.
          " For insert task, send the inserted record as export. This is used later in calling method to send comfirmation to the end user
          IF iv_task EQ 'I' .
            es_data = lt_phone_api_input.
          ENDIF.
        ELSE.
          IF iv_task EQ 'U' OR iv_task EQ 'D'.   " consumer key doesn't exist
            TRY .
                export_messages( iv_error =  'NOCONSUMERKEY'
                                iv_entity_name = 'A_AddressPhoneNumber' ).
              CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                RAISE EXCEPTION lx_busi_excep.
              CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                RAISE EXCEPTION lx_tech_excep.
            ENDTRY.
          ENDIF.
        ENDIF.
      ELSE.  " No phone data exists to update
        IF iv_task EQ 'D' OR iv_task EQ 'U'.
          TRY .
              export_messages( iv_error =  'NOPHONEDATA'
                              iv_entity_name = 'A_AddressPhoneNumber'
                              ).
            CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
              RAISE EXCEPTION lx_busi_excep.
            CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
              RAISE EXCEPTION lx_tech_excep.
          ENDTRY.
        ENDIF.
      ENDIF.
    ELSE.  " Address doesn't exists
      TRY .
          export_messages( iv_error =  'NOADDRDATA'
                          iv_entity_name = 'A_BusinessPartner' ).
        CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
          RAISE EXCEPTION lx_busi_excep.
        CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
          RAISE EXCEPTION lx_tech_excep.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD fill_address_comm_url_data.

    DATA: ls_url_payload_data  TYPE cl_api_business_partne_mpc=>ts_a_addresshomepageurltype,   " Declaration for url data.
          ls_url_api_input     TYPE LINE OF bus_ei_bupa_uri_t,
          lt_url_api_input     TYPE bus_ei_bupa_uri_t,
          lt_db_url_data       TYPE TABLE OF bapiaduri,
          ls_address_api_input TYPE bus_ei_bupa_address,
          lv_bp_adr_guid       TYPE but020-address_guid,
          lv_bp_adr_num        TYPE ad_addrnum,
          lx_busi_excep        TYPE REF TO /iwbep/cx_mgw_busi_exception,
          lx_tech_excep        TYPE REF TO /iwbep/cx_mgw_tech_exception.

    ls_url_payload_data = is_data.
    " Check existence of address in DB
    CALL FUNCTION 'BUPA_ADDRESS_READ_NUMBERS'
      EXPORTING
        iv_partner            = gv_partner
        iv_addrnumber         = ls_url_payload_data-addressid
      IMPORTING
        ev_addrguid           = lv_bp_adr_guid   " This  will be used to fill address headers later in this program
      EXCEPTIONS
        no_partner_specified  = 1
        no_address_specified  = 2
        no_valid_record_found = 3
        not_found             = 4
        blocked_partner       = 5
        OTHERS                = 6.
    IF sy-subrc EQ 0 AND lv_bp_adr_guid IS NOT INITIAL.
      " Read url and Remarks data from db
      CALL FUNCTION 'BUPA_ADDRESS_READ_DETAIL'
        EXPORTING
          iv_partner            = gv_partner
          iv_addrnumber         = ls_url_payload_data-addressid
          iv_xaduri             = 'X'
          iv_xadcomrem          = 'X'
        TABLES
          et_aduri              = lt_db_url_data
        EXCEPTIONS
          no_partner_specified  = 1
          no_valid_record_found = 2
          not_found             = 3
          blocked_partner       = 4
          OTHERS                = 5.
      IF lt_db_url_data IS NOT INITIAL OR iv_task EQ 'I'.
        IF iv_task EQ 'I' AND ls_url_payload_data-ordinalnumber IS NOT INITIAL.
          " ordinal number is not required for insert scenario, as ordinal number is generated by address api but not the user.
          CLEAR ls_url_payload_data-ordinalnumber.
        ENDIF.
        IF iv_task NE 'I'.
          " Only required for update/delete scenario to check if the record with same ordinal number provided in the payload exists in the db for update/delete
          READ TABLE lt_db_url_data WITH KEY consnumber = ls_url_payload_data-ordinalnumber TRANSPORTING NO FIELDS.
        ENDIF.
        " For update and delete scenario, an entry with same consumer number should exist in db
        IF ( sy-subrc EQ 0 AND ( iv_task EQ 'U' OR iv_task EQ 'D' ) ) OR ( iv_task EQ 'I').
          " Add/delete db data or changed data data to the api input structures to prepare for full send
          LOOP AT lt_db_url_data ASSIGNING FIELD-SYMBOL(<fs_db_url_data>).
            CLEAR ls_url_api_input.
            " For delete scenario, skip adding the record with ordinal number specified in the payload to the full send structure so that it will be deleted
            IF iv_task EQ 'D' AND <fs_db_url_data>-consnumber EQ ls_url_payload_data-ordinalnumber.
              CONTINUE.
            ENDIF.
            " For update scenario, Map payload data to the api input structure, replacing the db data
            IF iv_task EQ 'U' AND <fs_db_url_data>-consnumber EQ ls_url_payload_data-ordinalnumber.
              ls_url_api_input-contact-data-uri = ls_url_payload_data-websiteurl.     " Map payload data to the api input structure
              ls_url_api_input-contact-data-valid_from = ls_url_payload_data-validitystartdate.
              ls_url_api_input-contact-data-uri_type =  'HPG'.
            ELSE.
              " Move db data to the full send api structures for insert or update scenario
              MOVE-CORRESPONDING <fs_db_url_data> TO ls_url_api_input-contact-data.
            ENDIF.
            " Conusmer numbers are generated by the Address API, hence clearing the consumer numbers in the full send data
            CLEAR ls_url_api_input-contact-data-consnumber.
            APPEND ls_url_api_input TO lt_url_api_input.
          ENDLOOP.
          " In the case of create scenario, add the new record from the payload to the full send api structure to complete the current state
          IF iv_task EQ 'I'.
            CLEAR ls_url_api_input.
            " Map payload data to the api input structure
            ls_url_api_input-contact-data-uri = ls_url_payload_data-websiteurl.     " Map payload data to the api input structure
            ls_url_api_input-contact-data-valid_from = ls_url_payload_data-validitystartdate.
            ls_url_api_input-contact-data-uri_type =  'HPG'.
            ls_url_api_input-remark-current_state = 'X'.
            APPEND ls_url_api_input TO lt_url_api_input.
          ENDIF.
          " fill address header , task and time depandant flags
          ls_address_api_input-data-communication-uri-uri = lt_url_api_input.
          ls_address_api_input-data_key-guid = lv_bp_adr_guid.
          ls_address_api_input-data-communication-time_dependent = 'X'.
          ls_address_api_input-task = 'U'.
          ls_address_api_input-data-communication-uri-current_state = 'X'.
          " check if the address data already exists in the global structure
          READ TABLE gs_data-partner-central_data-address-addresses WITH KEY data_key-guid = lv_bp_adr_guid ASSIGNING FIELD-SYMBOL(<ls_address>).
          IF sy-subrc EQ 0.
            " if address data already exists in the global structure , replace url records with the current full send data and set required header data
            <ls_address>-data-communication-uri-uri = lt_url_api_input  .
            <ls_address>-data-communication-time_dependent = 'X'.
            <ls_address>-data-communication-uri-current_state = 'X'.
          ELSE.
            "  If address data doesn't exist, add a new record to the global structure.
            APPEND ls_address_api_input TO gs_data-partner-central_data-address-addresses.
            gs_data-partner-central_data-address-time_dependent = 'X'.
          ENDIF.
          " For insert task, send the inserted record as export. This is used later in calling method to send comfirmation to the end user
          IF iv_task EQ 'I' .
            es_data = lt_url_api_input.
          ENDIF.
        ELSE.
          IF iv_task EQ 'U' OR iv_task EQ 'D'.   " consumer key doesn't exist
            TRY .
                export_messages( iv_error =  'NOCONSUMERKEY'
                                iv_entity_name = 'A_AddressHomePageURL' ).
              CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
                RAISE EXCEPTION lx_busi_excep.
              CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
                RAISE EXCEPTION lx_tech_excep.
            ENDTRY.
          ENDIF.
        ENDIF.
      ELSE.  " No url data exists to update
        IF iv_task EQ 'D' OR iv_task EQ 'U'.
          TRY .
              export_messages( iv_error =  'NOURLDATA'
                              iv_entity_name = 'A_AddressHomePageURL'
                              ).
            CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
              RAISE EXCEPTION lx_busi_excep.
            CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
              RAISE EXCEPTION lx_tech_excep.
          ENDTRY.
        ENDIF.
      ENDIF.
    ELSE.  " Address doesn't exists
      TRY .
          export_messages( iv_error =  'NOADDRDATA'
                          iv_entity_name = 'A_AddressHomePageURL' ).
        CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_excep.
          RAISE EXCEPTION lx_busi_excep.
        CATCH /iwbep/cx_mgw_tech_exception INTO lx_tech_excep .
          RAISE EXCEPTION lx_tech_excep.
      ENDTRY.
    ENDIF.

  ENDMETHOD.


  METHOD fill_address_data.

    DATA : ls_partner_address LIKE is_address_data,
           ls_output          LIKE es_address_data,
           lc_tzone_utc       TYPE tznzone VALUE 'UTC'.

    ls_partner_address = is_address_data.

    "TASK
    ls_output-task = iv_task.
    "datakey
    IF iv_task = 'I'.
      TRY.
          CALL METHOD cl_system_uuid=>create_uuid_x16_static
            RECEIVING
              uuid = DATA(lv_adr_data).
        CATCH cx_uuid_error .
      ENDTRY.
      ls_output-data_key = lv_adr_data.
      "ls_output-currently_valid = 'X'.
    ELSE.
      IF ls_partner_address-addressuuid IS NOT INITIAL.
        ls_output-data_key = ls_partner_address-addressuuid.
      ENDIF.
      "ls_output-currently_valid = 'X'.
    ENDIF.



    "data
    ls_output-data-postal-data-c_o_name = ls_partner_address-careofname.
    ls_output-data-postal-data-house_no = ls_partner_address-housenumber.
    ls_output-data-postal-data-street = ls_partner_address-streetname.
    ls_output-data-postal-data-house_no2 = ls_partner_address-housenumbersupplementtext.
    ls_output-data-postal-data-district = ls_partner_address-district.
    ls_output-data-postal-data-postl_cod1 = ls_partner_address-postalcode.
    ls_output-data-postal-data-city = ls_partner_address-cityname.
    ls_output-data-postal-data-city_no = ls_partner_address-citycode.
    ls_output-data-postal-data-county = ls_partner_address-county.
    ls_output-data-postal-data-country = ls_partner_address-country.
    ls_output-data-postal-data-region = ls_partner_address-region.
    ls_output-data-postal-data-time_zone = ls_partner_address-addresstimezone.
    ls_output-data-postal-data-postl_cod3 = ls_partner_address-companypostalcode.
    ls_output-data-postal-data-deli_serv_number = ls_partner_address-deliveryservicenumber.
    ls_output-data-postal-data-po_box = ls_partner_address-pobox.
    ls_output-data-postal-data-po_w_o_no = ls_partner_address-poboxiswithoutnumber.
    ls_output-data-postal-data-postl_cod2 = ls_partner_address-poboxpostalcode.
    ls_output-data-postal-data-po_box_lobby = ls_partner_address-poboxlobbyname.
    ls_output-data-postal-data-po_box_cit = ls_partner_address-poboxdeviatingcityname.
    ls_output-data-postal-data-po_box_reg = ls_partner_address-poboxdeviatingregion.
    ls_output-data-postal-data-pobox_ctry = ls_partner_address-poboxdeviatingcountry.
    ls_output-data-postal-data-langu = ls_partner_address-language.
    ls_output-data-postal-data-comm_type = ls_partner_address-prfrdcommmediumtype.
    ls_output-data-postal-data-str_suppl1 = ls_partner_address-streetprefixname.
    ls_output-data-postal-data-str_suppl2 = ls_partner_address-additionalstreetprefixname.
    ls_output-data-postal-data-str_suppl3 = ls_partner_address-streetsuffixname.
    ls_output-data-postal-data-location   = ls_partner_address-additionalstreetsuffixname.
    ls_output-data-postal-data-home_city  = ls_partner_address-homecityname.
    ls_output-data-postal-data-taxjurcode = ls_partner_address-taxjurisdiction.
    ls_output-data-postal-data-transpzone = ls_partner_address-transportzone.
    ls_output-data-postal-data-deli_serv_type = ls_partner_address-deliveryservicetypecode.
    ls_output-data-postal-data-extaddressnumber = ls_partner_address-addressidbyexternalsystem."1802


    DATA lv_timestamp TYPE bu_role_valid_from."ad_tstamp.
    lv_timestamp = ls_partner_address-validitystartdate.

    IF lv_timestamp IS NOT INITIAL.

      CONVERT TIME STAMP lv_timestamp   TIME ZONE lc_tzone_utc
              INTO DATE ls_output-data-postal-data-validfromdate.
    ELSE .
      ls_output-data-postal-data-validfromdate = ls_partner_address-validitystartdate.
    ENDIF.

    lv_timestamp = ls_partner_address-validityenddate.

    IF lv_timestamp IS NOT INITIAL.
      CONVERT TIME STAMP lv_timestamp   TIME ZONE lc_tzone_utc
          INTO DATE ls_output-data-postal-data-validtodate.
    ELSE .
      ls_output-data-postal-data-validtodate = ls_partner_address-validityenddate.
    ENDIF.

    CLEAR lv_timestamp.

    ls_output-data-postal-datax-validtodate = 'X'.
    ls_output-data-postal-datax-validfromdate = 'X'.
    ls_output-data-postal-datax-country = 'X'.
    ls_output-data-postal-datax-c_o_name = 'X'.
    ls_output-data-postal-datax-house_no = 'X'.
    ls_output-data-postal-datax-street = 'X'.
    ls_output-data-postal-datax-house_no2 = 'X'.
    ls_output-data-postal-datax-district = 'X'.
    ls_output-data-postal-datax-postl_cod1 = 'X'.
    ls_output-data-postal-datax-city = 'X'.
    ls_output-data-postal-datax-city_no = 'X'.
    ls_output-data-postal-datax-county = 'X'.
    ls_output-data-postal-datax-country = 'X'.
    ls_output-data-postal-datax-region = 'X'.
    ls_output-data-postal-datax-time_zone = 'X'.
    ls_output-data-postal-datax-postl_cod3 = 'X'.
    ls_output-data-postal-datax-deli_serv_number = 'X'.
    ls_output-data-postal-datax-po_box = 'X'.
    ls_output-data-postal-datax-po_w_o_no = 'X'.
    ls_output-data-postal-datax-postl_cod2 = 'X'.
    ls_output-data-postal-datax-po_box_lobby = 'X'.
    ls_output-data-postal-datax-po_box_cit = 'X'.
    ls_output-data-postal-datax-po_box_reg = 'X'.
    ls_output-data-postal-datax-pobox_ctry = 'X'.
    ls_output-data-postal-datax-langu = 'X'.
    ls_output-data-postal-datax-comm_type = 'X'.
    ls_output-data-postal-datax-str_suppl1 = 'X'.
    ls_output-data-postal-datax-str_suppl2 = 'X'.
    ls_output-data-postal-datax-str_suppl3 = 'X'.
    ls_output-data-postal-datax-location   = 'X'.
    ls_output-data-postal-datax-home_city  = 'X'.
    ls_output-data-postal-datax-taxjurcode = 'X'.
    ls_output-data-postal-datax-transpzone = 'X'.
    ls_output-data-postal-datax-deli_serv_type = 'X'.
    ls_output-data-postal-datax-extaddressnumber = 'X'."1802

    es_address_data = ls_output.

  ENDMETHOD.


  METHOD fill_address_usage_data.

    DATA:ls_partner_addr_usage LIKE is_address_usage_data,
         ls_output             LIKE es_address_usage_data,
         lc_tzone_utc          TYPE tznzone VALUE 'UTC'.

    DATA lv_timestamp1 TYPE bu_advw_valid_from.
    DATA lv_timestamp2 TYPE bu_advw_valid_to.

    ls_partner_addr_usage = is_address_usage_data.

    "task
    ls_output-task = iv_task.
    "data_key
    ls_output-data_key-addresstype = ls_partner_addr_usage-addressusage.

    lv_timestamp1 = ls_partner_addr_usage-validityenddate.

    IF lv_timestamp1 IS NOT INITIAL.
      CONVERT TIME STAMP lv_timestamp1 TIME ZONE lc_tzone_utc
        INTO DATE ls_output-data_key-valid_to.
    ELSE.
      ls_output-data_key-valid_to = ls_partner_addr_usage-validityenddate.
    ENDIF.
    CLEAR lv_timestamp1.

    "data
    IF ls_partner_addr_usage-addressusage IS NOT INITIAL AND ls_partner_addr_usage-addressusage NE 'XXDEFAULT'.
      ls_output-data-standard = 'X'.
    ENDIF.
    lv_timestamp2 = ls_partner_addr_usage-validitystartdate.
    IF lv_timestamp2 IS NOT INITIAL.
      CONVERT TIME STAMP lv_timestamp2   TIME ZONE lc_tzone_utc
              INTO DATE ls_output-data-valid_from.
    ELSE.
      ls_output-data-valid_from = ls_partner_addr_usage-validitystartdate.
    ENDIF.

    CLEAR lv_timestamp2.

    "datax
    ls_output-datax-standard = 'X'.
    ls_output-datax-valid_from = 'X'.

    es_address_usage_data = ls_output.


  ENDMETHOD.


  METHOD fill_bank_data.

    DATA : ls_partner_bank TYPE  cl_api_business_partne_mpc=>ts_a_businesspartnerbanktype,
           ls_bank_data    LIKE es_partner_bank,
           lc_tzone_utc    TYPE tznzone VALUE 'UTC',
           lv_count(4)     TYPE n.
    DATA   lt_but0bk        TYPE tty_but0bk.
    DATA   ls_bankid        TYPE nbnk-stand.
    DATA   ls_bank_old_data LIKE ls_bank_data-data.


    lv_count = '0000'.
    ls_partner_bank = is_partner_bank.

    ls_bank_data-task = iv_task.

    "datakey
    ls_bank_data-data_key = ls_partner_bank-bankidentification.
    "data
    ls_bank_data-data-bank_ctry = ls_partner_bank-bankcountrykey.
    ls_bank_data-data-bank_key = ls_partner_bank-banknumber.
    ls_bank_data-data-bank_acct = ls_partner_bank-bankaccount.
    ls_bank_data-data-ctrl_key = ls_partner_bank-bankcontrolkey.
    ls_bank_data-data-iban = ls_partner_bank-iban.
    ls_bank_data-data-iban_from_date = ls_partner_bank-ibanvaliditystartdate.
    ls_bank_data-data-accountholder = ls_partner_bank-bankaccountholdername.
    ls_bank_data-data-bank_ref = ls_partner_bank-bankaccountreferencetext.
    ls_bank_data-data-bankaccountname = ls_partner_bank-bankaccountname.
    ls_bank_data-data-coll_auth = ls_partner_bank-collectionauthind.


    DATA lv_timestamp1 TYPE bu_bk_valid_from."ad_tstamp.
    lv_timestamp1 = ls_partner_bank-validitystartdate.

    IF lv_timestamp1 IS NOT INITIAL.

      CONVERT TIME STAMP lv_timestamp1   TIME ZONE lc_tzone_utc
              INTO DATE ls_bank_data-data-bankdetailvalidfrom .
    ELSE .
      ls_bank_data-data-bankdetailvalidfrom =  ls_partner_bank-validitystartdate.
    ENDIF.


    lv_timestamp1 = ls_partner_bank-validityenddate.
    IF lv_timestamp1 IS NOT INITIAL.

      CONVERT TIME STAMP lv_timestamp1   TIME ZONE lc_tzone_utc
              INTO DATE ls_bank_data-data-bankdetailvalidto  .
    ELSE .
      ls_bank_data-data-bankdetailvalidto =  ls_partner_bank-validityenddate.
    ENDIF.

    CLEAR lv_timestamp1.

    "datax
    ls_bank_data-datax-bank_ctry = 'X'.
    ls_bank_data-datax-bank_key = 'X'.
    ls_bank_data-datax-bank_acct = 'X'.
    ls_bank_data-datax-ctrl_key = 'X'.
    ls_bank_data-datax-iban = 'X'.
    ls_bank_data-datax-iban_from_date = 'X'.
    ls_bank_data-datax-accountholder = 'X'.
    ls_bank_data-datax-bank_ref = 'X'.
    ls_bank_data-datax-bankaccountname = 'X'.
    ls_bank_data-datax-coll_auth = 'X'.
    ls_bank_data-datax-bankdetailvalidfrom = 'X'.
    ls_bank_data-datax-bankdetailvalidto = 'X'.

    es_partner_bank = ls_bank_data.


  ENDMETHOD.


  METHOD fill_bp_contact_function.

    DATA : ls_contact_data_func LIKE is_partner_contact_func.
    DATA : ls_partner_relation_func LIKE es_partner_contact_func.
    DATA: lv_contact_guid LIKE partner_struc-businesspartneruuid.

    ls_contact_data_func = is_partner_contact_func.

    ls_partner_relation_func-central_data-data-function = ls_contact_data_func-contactpersonfunction.
    ls_partner_relation_func-central_data-data-department = ls_contact_data_func-contactpersondepartment.
    ls_partner_relation_func-central_data-data-tel1_numbr = ls_contact_data_func-phonenumber.
    ls_partner_relation_func-central_data-data-tel1_ext = ls_contact_data_func-phonenumberextension.
    ls_partner_relation_func-central_data-data-fax_number = ls_contact_data_func-faxnumber.
    ls_partner_relation_func-central_data-data-fax_extens = ls_contact_data_func-faxnumberextension.
    ls_partner_relation_func-central_data-data-e_mail =  ls_contact_data_func-emailaddress.

    ls_partner_relation_func-central_data-datax-function = 'X'.
    ls_partner_relation_func-central_data-datax-department = 'X'.
    ls_partner_relation_func-central_data-datax-tel1_numbr = 'X'.
    ls_partner_relation_func-central_data-datax-tel1_ext = 'X'.
    ls_partner_relation_func-central_data-datax-fax_number = 'X'.
    ls_partner_relation_func-central_data-datax-fax_extens = 'X'.
    ls_partner_relation_func-central_data-datax-e_mail =  'X'.

    es_partner_contact_func = ls_partner_relation_func.

  ENDMETHOD.


  METHOD fill_bp_data.

    DATA : ls_bp_root   LIKE is_partner_data.

    ls_bp_root = is_partner_data.

    MOVE-CORRESPONDING ls_bp_root TO gs_data-partner-central_data-common-data EXPANDING NESTED TABLES.

    "data
    gs_data-partner-header-object_task = iv_task.

    "-- remove business partner for update request check
*    gs_data-partner-header-object_instance-bpartner = ls_bp_root-businesspartner.
    gs_data-partner-header-object_instance-bpartner = ''.
    gs_data-partner-header-object_instance-bpartnerguid = gv_partner_guid.
    gs_data-partner-central_data-common-data-bp_centraldata-title_key = ls_bp_root-formofaddress.
    gs_data-partner-central_data-common-data-bp_control-category = ls_bp_root-businesspartnercategory.
    "determine grouping if its not filled from json , this is required to determine sales area and purchasing org partner functions

    gs_data-partner-central_data-common-data-bp_control-grouping = ls_bp_root-businesspartnergrouping.
    gv_bp_grouping = ls_bp_root-businesspartnergrouping.

    gs_data-partner-central_data-common-data-bp_centraldata-searchterm1 = ls_bp_root-searchterm1.
    gs_data-partner-central_data-common-data-bp_centraldata-partnerlanguage = ls_bp_root-language.
    gs_data-partner-central_data-common-data-bp_centraldata-authorizationgroup = ls_bp_root-authorizationgroup.
    gs_data-partner-central_data-common-data-bp_organization-name1 = ls_bp_root-organizationbpname1.
    gs_data-partner-central_data-common-data-bp_organization-name2 = ls_bp_root-organizationbpname2.
    gs_data-partner-central_data-common-data-bp_organization-name3 = ls_bp_root-organizationbpname3.
    gs_data-partner-central_data-common-data-bp_organization-name4 = ls_bp_root-organizationbpname4.
    gs_data-partner-central_data-common-data-bp_organization-loc_no_1 = ls_bp_root-internationallocationnumber1.
    gs_data-partner-central_data-common-data-bp_organization-loc_no_2 = ls_bp_root-internationallocationnumber2.
    gs_data-partner-central_data-common-data-bp_organization-foundationdate = ls_bp_root-organizationfoundationdate.
    gs_data-partner-central_data-common-data-bp_organization-liquidationdate = ls_bp_root-organizationliquidationdate.
    gs_data-partner-central_data-common-data-bp_organization-legalform = ls_bp_root-legalform.
    gs_data-partner-central_data-common-data-bp_organization-industrysector = ls_bp_root-industry.
    gs_data-partner-central_data-common-data-bp_person-firstname = ls_bp_root-firstname.
    gs_data-partner-central_data-common-data-bp_person-lastname = ls_bp_root-lastname.
    gs_data-partner-central_data-common-data-bp_person-middlename = ls_bp_root-middlename.
    gs_data-partner-central_data-common-data-bp_person-birthdate = ls_bp_root-birthdate.
    gs_data-partner-central_data-common-data-bp_person-title_aca1 = ls_bp_root-academictitle.
    gs_data-partner-central_data-common-data-bp_person-correspondlanguage = ls_bp_root-correspondencelanguage.
    gs_data-partner-central_data-taxnumber-common-data-nat_person = ls_bp_root-isnaturalperson.
    gs_data-partner-central_data-common-data-bp_centraldata-centralblock = ls_bp_root-businesspartnerisblocked.
    gs_data-partner-central_data-common-data-bp_centraldata-partnertype = ls_bp_root-businesspartnertype.
    gs_data-partner-central_data-common-data-bp_person-namcountry = ls_bp_root-namecountry.
    gs_data-partner-central_data-common-data-bp_person-nameformat = ls_bp_root-nameformat.
    gs_data-partner-central_data-common-data-bp_group-namegroup1 = ls_bp_root-groupbusinesspartnername1.
    gs_data-partner-central_data-common-data-bp_group-namegroup2 = ls_bp_root-groupbusinesspartnername2.
    gs_data-partner-central_data-common-data-bp_person-fullname = ls_bp_root-personfullname.
    gs_data-partner-central_data-common-data-bp_centraldata-centralarchivingflag = ls_bp_root-ismarkedforarchiving.
    gs_data-partner-central_data-common-data-bp_centraldata-partnerexternal = ls_bp_root-businesspartneridbyextsystem."1802

    "AdditionalLastName,
    "InternationalLocationNumber3,
    "map these fields

    IF ls_bp_root-ismale = 'X'.
      gs_data-partner-central_data-common-data-bp_person-sex = '2'.
    ELSEIF ls_bp_root-isfemale = 'X'.
      gs_data-partner-central_data-common-data-bp_person-sex = '1'.
    ELSEIF ls_bp_root-issexunknown = 'X'.
      gs_data-partner-central_data-common-data-bp_person-sex = ''.
    ENDIF.

    "datax
    gs_data-partner-central_data-common-datax-bp_centraldata-title_key = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-sex = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-searchterm1 = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-partnerlanguage = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-authorizationgroup = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-name1 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-name2 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-name3 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-name4 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-loc_no_1 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-loc_no_2 = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-foundationdate = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-liquidationdate = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-legalform = 'X'.
    gs_data-partner-central_data-common-datax-bp_organization-industrysector = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-firstname = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-lastname = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-middlename = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-birthdate = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-title_aca1 = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-correspondlanguage = 'X'.
    gs_data-partner-central_data-taxnumber-common-datax-nat_person = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-centralblock = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-partnertype = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-namcountry = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-nameformat = 'X'.
    gs_data-partner-central_data-common-datax-bp_group-namegroup1 = 'X'.
    gs_data-partner-central_data-common-datax-bp_group-namegroup2 = 'X'.
    gs_data-partner-central_data-taxnumber-common-datax-nat_person = 'X'.
    gs_data-partner-central_data-common-datax-bp_person-fullname = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-centralarchivingflag = 'X'.
    gs_data-partner-central_data-common-datax-bp_centraldata-partnerexternal = 'X'."1802

    " code to set data and datax for extensibility fields

    FIELD-SYMBOLS: <ls_field_datax> TYPE any .
    DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
    DATA : lt_tables   TYPE abap_compdescr_tab.
    DATA : ls_tab   LIKE LINE OF lt_tables.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_BUT000_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE gs_data-partner-central_data-common-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.


  METHOD fill_bp_identification_data.

    DATA: ls_partner_identification LIKE is_partner_identification,
          ls_output                 LIKE es_partner_identification.

    ls_partner_identification = is_partner_identification.
    "task
    ls_output-task = iv_task.
    "data
    ls_output-data_key-identificationcategory = ls_partner_identification-bpidentificationtype.
    ls_output-data_key-identificationnumber = ls_partner_identification-bpidentificationnumber.
    ls_output-data-country = ls_partner_identification-country.
    ls_output-data-identrydate = ls_partner_identification-bpidentificationentrydate.
    ls_output-data-idinstitute = ls_partner_identification-bpidnnmbrissuinginstitute.
    ls_output-data-region = ls_partner_identification-region.
    ls_output-data-idvalidfromdate = ls_partner_identification-validitystartdate.
    ls_output-data-idvalidtodate = ls_partner_identification-validityenddate.
    "datax
    ls_output-datax-country = 'X'.
    ls_output-datax-identrydate = 'X'.
    ls_output-datax-idinstitute = 'X'.
    ls_output-datax-region = 'X'.
    ls_output-datax-idvalidfromdate = 'X'.
    ls_output-datax-idvalidtodate = 'X'.

    es_partner_identification = ls_output.


  ENDMETHOD.


  METHOD fill_bp_industry_data.

    DATA: ls_partner_industry LIKE is_partner_industry,
          ls_output           LIKE es_partner_industry.

    ls_partner_industry = is_partner_industry.
    "task
    ls_output-task = iv_task.
    "data
    ls_output-data_key-ind_sector = ls_partner_industry-industrysector.
    ls_output-data_key-keysystem  = ls_partner_industry-industrysystemtype.
    ls_output-data-ind_default    = ls_partner_industry-isstandardindustry.

    "datax
    ls_output-datax-ind_default   = 'X'.

    es_partner_industry = ls_output.

  ENDMETHOD.


  METHOD fill_bp_role_data.

    DATA: ls_bp_role   LIKE is_partner_role,
          lc_tzone_utc TYPE tznzone VALUE 'UTC',
          ls_role      TYPE bus_ei_bupa_roles,
          ls_tb003     TYPE tb003.

    ls_bp_role = is_partner_role.

    ls_role-task = iv_task.
    ls_role-data_key = ls_bp_role-businesspartnerrole.

    CALL FUNCTION 'BUP_TB003_SELECT_SINGLE'
      EXPORTING
        i_role    = ls_bp_role-businesspartnerrole
      IMPORTING
        e_tb003   = ls_tb003
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.

    IF sy-subrc = 0.
      ls_role-data-rolecategory = ls_tb003-rolecategory.
    ENDIF.

    DATA lv_timestamp1 TYPE bu_role_valid_from.
    lv_timestamp1 = ls_bp_role-validfrom.

    IF lv_timestamp1 IS NOT INITIAL.

      CONVERT TIME STAMP lv_timestamp1   TIME ZONE lc_tzone_utc
              INTO DATE ls_role-data-valid_from.
    ELSE .
      ls_role-data-valid_from = ls_bp_role-validfrom.
    ENDIF.

    lv_timestamp1 = ls_bp_role-validto.

    IF lv_timestamp1 IS NOT INITIAL.
      CONVERT TIME STAMP lv_timestamp1   TIME ZONE lc_tzone_utc
          INTO DATE ls_role-data-valid_to.
    ELSE .
      ls_role-data-valid_to = ls_bp_role-validto.
    ENDIF.

    CLEAR lv_timestamp1.

    "Fill DATAX for Roles

    ls_role-datax-valid_from = 'X'.
    ls_role-datax-valid_to = 'X'.

    es_partner_role = ls_role.

  ENDMETHOD.


  METHOD fill_communication_data.

*    case iv_entity_name.
*
*      when 'A_AddressPhoneNumberType'.
*
*        data: ls_phone      type line of bus_ei_bupa_telephone_t,
*              ls_phone_data type cl_api_business_partne_mpc=>ts_a_addressphonenumbertype.
*
*        ls_phone_data = is_data.
*
*        ls_phone-contact-task = iv_task.
*        ls_phone-contact-data-country = ls_phone_data-destinationlocationcountry.
*        ls_phone-contact-data-telephone = ls_phone_data-phonenumber.
*        ls_phone-contact-data-extension = ls_phone_data-phonenumberextension.
*        ls_phone-contact-data-r_3_user = '1'.
*        ls_phone-contact-data-consnumber = ls_phone_data-ordinalnumber.
*
*        ls_phone-contact-datax-country = 'X'.
*        ls_phone-contact-datax-telephone = 'X'.
*        ls_phone-contact-datax-extension = 'X'.
*        ls_phone-contact-datax-r_3_user = 'X'.
*        ls_phone-contact-datax-consnumber = 'X'.
*
*        es_data = ls_phone.
*
*      when 'A_AddressMobilePhoneNumberType'.
*
*        data: ls_mobile      type line of bus_ei_bupa_telephone_t,
*              ls_mobile_data type cl_api_business_partne_mpc=>ts_a_addressphonenumbertype.
*
*        ls_mobile_data = is_data.
*
*        ls_mobile-contact-task = iv_task.
*        ls_mobile-contact-data-country = ls_mobile_data-destinationlocationcountry.
*        ls_mobile-contact-data-telephone = ls_mobile_data-phonenumber.
*        ls_mobile-contact-data-extension = ls_mobile_data-phonenumberextension.
*        ls_mobile-contact-data-r_3_user = '3'.
*        ls_mobile-contact-data-consnumber = ls_mobile_data-ordinalnumber.
*
*        ls_mobile-contact-datax-country = 'X'.
*        ls_mobile-contact-datax-telephone = 'X'.
*        ls_mobile-contact-datax-extension = 'X'.
*        ls_mobile-contact-datax-r_3_user = 'X'.
*        ls_mobile-contact-datax-consnumber = 'X'.
*
*        es_data = ls_mobile.
*
*     when 'A_AddressMobileOrPhoneNumber'.
*
*        data: ls_mobilephone      type line of bus_ei_bupa_telephone_t,
*              ls_mobilephone_data type cl_api_business_partne_mpc=>ts_a_addressphonenumbertype.
*
*        ls_mobilephone_data = is_data.
*
*        ls_mobilephone-contact-task = iv_task.
*        ls_mobilephone-contact-data-country = ls_mobilephone_data-destinationlocationcountry.
*        ls_mobilephone-contact-data-telephone = ls_mobilephone_data-phonenumber.
*        ls_mobilephone-contact-data-extension = ls_mobilephone_data-phonenumberextension.
*        ls_mobilephone-contact-data-r_3_user = ls_mobilephone_data-phonenumbertype.
*        ls_mobilephone-contact-data-consnumber = ls_mobilephone_data-ordinalnumber.
*
*
*        ls_mobilephone-contact-datax-country = 'X'.
*        ls_mobilephone-contact-datax-telephone = 'X'.
*        ls_mobilephone-contact-datax-extension = 'X'.
*        ls_mobilephone-contact-datax-r_3_user = 'X'.
*        ls_mobilephone-contact-datax-consnumber = 'X'.
*
*        es_data = ls_mobilephone.
*
*
*
*      when 'A_AddressFaxNumberType'.
*
*        data: ls_fax      type line of bus_ei_bupa_fax_t,
*              ls_fax_data type cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype.
*
*        ls_fax_data = is_data.
*
*        ls_fax-contact-task = iv_task.
*        ls_fax-contact-data-country = ls_fax_data-faxcountry.
*        ls_fax-contact-data-fax = ls_fax_data-faxnumber.
*        ls_fax-contact-data-extension = ls_fax_data-faxnumberextension.
*        ls_fax-contact-data-consnumber = ls_fax_data-ordinalnumber.
*
*        ls_fax-contact-datax-country = 'X'.
*        ls_fax-contact-datax-fax = 'X'.
*        ls_fax-contact-datax-extension = 'X'.
*        ls_fax-contact-datax-consnumber = 'X'.
*
*        es_data = ls_fax.
*
*      when 'A_AddressEmailAddressType'.
*
*        data: ls_smtp      type line of bus_ei_bupa_smtp_t,
*              ls_smtp_data type cl_api_business_partne_mpc=>ts_a_addressemailaddresstype.
*
*        ls_smtp_data = is_data.
*
*        ls_smtp-contact-task = iv_task. " Standard
*        ls_smtp-contact-data-e_mail = ls_smtp_data-emailaddress.
*        ls_smtp-contact-data-consnumber = ls_smtp_data-ordinalnumber.
*
*        ls_smtp-contact-datax-e_mail = 'X'.
*        ls_smtp-contact-datax-consnumber = 'X'.
*
*        es_data = ls_smtp.
*
*      when 'A_AddressHomePageURLType'.
*
*        data: ls_uri      type line of bus_ei_bupa_uri_t,
*              ls_uri_data type cl_api_business_partne_mpc=>ts_a_addresshomepageurltype.
*
*        ls_uri_data = is_data.
*
*        ls_uri-contact-task = iv_task.
*        ls_uri-contact-data-uri =  ls_uri_data-websiteurl.
*        ls_uri-contact-data-valid_from = ls_uri_data-validitystartdate.
*        ls_uri-contact-data-uri_type = 'HPG'.
*        ls_uri-contact-data-consnumber = ls_uri_data-ordinalnumber.
*
*        ls_uri-contact-datax-uri =  'X'.
*        ls_uri-contact-datax-valid_from = 'X'.
*        ls_uri-contact-datax-uri_type = 'X'.
*        ls_uri-contact-datax-consnumber = 'X'.
*
*        es_data = ls_uri.
*
*    endcase.


  ENDMETHOD.


  METHOD fill_contact_data.

    DATA : ls_contact_data LIKE is_partner_contact.
    DATA : ls_partner_relation LIKE es_partner_contact.
    DATA: lv_contact_guid LIKE partner_struc-businesspartneruuid.

    ls_contact_data = is_partner_contact.
    CALL FUNCTION 'BUPA_NUMBERS_GET'
      EXPORTING
        iv_partner      = ls_contact_data-businesspartnerperson
      IMPORTING
        ev_partner_guid = lv_contact_guid.

    IF sy-subrc = '0'.

      ls_partner_relation-header-object_task = iv_task.
      ls_partner_relation-header-object_instance-partner1-bpartner = gv_partner.
      ls_partner_relation-header-object_instance-partner1-bpartnerguid = gv_partner_guid.
      ls_partner_relation-header-object_instance-partner2-bpartner = ls_contact_data-businesspartnerperson.
      ls_partner_relation-header-object_instance-partner2-bpartnerguid = lv_contact_guid.
      ls_partner_relation-header-object_instance-relat_category = 'BUR001'.
      ls_partner_relation-header-object_instance-date_to = ls_contact_data-validityenddate.

      ls_partner_relation-central_data-main-task = iv_task.
      ls_partner_relation-central_data-main-data-date_from = ls_contact_data-validitystartdate.
      ls_partner_relation-central_data-main-data-defaultrelationship = ls_contact_data-isstandardrelationship.

      ls_partner_relation-central_data-main-datax-date_from = 'X'.
      ls_partner_relation-central_data-main-datax-defaultrelationship = 'X'.

      es_partner_contact = ls_partner_relation.

    ENDIF.

  ENDMETHOD.


  METHOD fill_customer_companycode_data.

    DATA : ls_data              LIKE es_company_data,
           ls_customer_compcode LIKE is_company_data.

    ls_customer_compcode = is_company_data.

    MOVE-CORRESPONDING ls_customer_compcode TO ls_data-data EXPANDING NESTED TABLES.
    ls_data-task = iv_task.

    "datakey
    ls_data-data_key-bukrs = ls_customer_compcode-companycode.
    "data
    ls_data-data-busab = ls_customer_compcode-accountingclerk.
    ls_data-data-intad = ls_customer_compcode-accountingclerkinternetaddress.
    ls_data-data-tlfns = ls_customer_compcode-accountingclerkphonenumber.
    ls_data-data-tlfxs = ls_customer_compcode-accountingclerkfaxnumber.
    ls_data-data-zsabe = ls_customer_compcode-useratcustomer.
    ls_data-data-eikto = ls_customer_compcode-accountbycustomer.
    ls_data-data-perkz = ls_customer_compcode-collectiveinvoicevariant.
    ls_data-data-xdezv = ls_customer_compcode-istobelocallyprocessed.
    ls_data-data-kverm = ls_customer_compcode-customeraccountnote.
    ls_data-data-zterm = ls_customer_compcode-paymentterms.
    ls_data-data-zwels = ls_customer_compcode-paymentmethodslist.
    ls_data-data-zahls = ls_customer_compcode-paymentblockingreason.
    ls_data-data-xzver = ls_customer_compcode-recordpaymenthistoryindicator.
    ls_data-data-togru = ls_customer_compcode-apartolerancegroup.
    ls_data-data-xpore = ls_customer_compcode-itemistobepaidseparately.
    ls_data-data-xverr = ls_customer_compcode-customersupplierclearingisused.
    ls_data-data-xedip = ls_customer_compcode-paytadviceissentbyedi.
    ls_data-data-knrzb = ls_customer_compcode-alternativepayeraccount.
    ls_data-data-akont = ls_customer_compcode-reconciliationaccount.
    ls_data-data-knrze = ls_customer_compcode-customerheadoffice.
    ls_data-data-zuawa = ls_customer_compcode-layoutsortingrule.
    ls_data-data-begru = ls_customer_compcode-authorizationgroup.
    ls_data-data-vzskz = ls_customer_compcode-interestcalculationcode.
    ls_data-data-zindt = ls_customer_compcode-interestcalculationdate.
    ls_data-data-zinrt = ls_customer_compcode-intrstcalcfrequencyinmonths.
    ls_data-data-hbkid = ls_customer_compcode-housebank.
    ls_data-data-sperr = ls_customer_compcode-physicalinventoryblockind.
    ls_data-data-begru = ls_customer_compcode-authorizationgroup.
    ls_data-data-loevm = ls_customer_compcode-deletionindicator.

    "datax
    ls_data-datax-busab = 'X'.
    ls_data-datax-intad = 'X'.
    ls_data-datax-tlfns = 'X'.
    ls_data-datax-tlfxs = 'X'.
    ls_data-datax-zsabe = 'X'.
    ls_data-datax-eikto = 'X'.
    ls_data-datax-perkz = 'X'.
    ls_data-datax-xdezv = 'X'.
    ls_data-datax-kverm = 'X'.
    ls_data-datax-zterm = 'X'.
    ls_data-datax-zwels = 'X'.
    ls_data-datax-zahls = 'X'.
    ls_data-datax-xzver = 'X'.
    ls_data-datax-togru = 'X'.
    ls_data-datax-xpore = 'X'.
    ls_data-datax-xverr = 'X'.
    ls_data-datax-xedip = 'X'.
    ls_data-datax-knrzb = 'X'.
    ls_data-datax-akont = 'X'.
    ls_data-datax-knrze = 'X'.
    ls_data-datax-zuawa = 'X'.
    ls_data-datax-begru = 'X'.
    ls_data-datax-vzskz = 'X'.
    ls_data-datax-zindt = 'X'.
    ls_data-datax-zinrt = 'X'.
    ls_data-datax-hbkid = 'X'.
    ls_data-datax-sperr = 'X'.
    ls_data-datax-begru = 'X'.
    ls_data-datax-loevm = 'X'.

    " code to set data and datax for extensibility fields

    FIELD-SYMBOLS: <ls_field_datax> TYPE any .
    DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
    DATA : lt_tables   TYPE abap_compdescr_tab.
    DATA : ls_tab   LIKE LINE OF lt_tables.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_KNB1_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE ls_data-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.
    ENDLOOP.

    es_company_data = ls_data.


  ENDMETHOD.


  METHOD fill_customer_dunning_data.

    DATA: ls_data1            LIKE es_customer_dunning,
          ls_customer_dunning LIKE is_customer_dunning.

    ls_customer_dunning = is_customer_dunning.

    "task
    ls_data1-task = iv_task.

    "data_key
    ls_data1-data_key-maber = ls_customer_dunning-dunningarea.

    "data
    ls_data1-data-mahna = ls_customer_dunning-dunningprocedure.
    ls_data1-data-mansp = ls_customer_dunning-dunningblock.
    ls_data1-data-madat = ls_customer_dunning-lastdunnedon.
    ls_data1-data-mahns = ls_customer_dunning-dunninglevel.
    ls_data1-data-knrma = ls_customer_dunning-dunningrecipient.
    ls_data1-data-gmvdt = ls_customer_dunning-legdunningprocedureon.
    ls_data1-data-busab = ls_customer_dunning-dunningclerk.

    "datax
    ls_data1-datax-mahna = 'X'.
    ls_data1-datax-mansp = 'X'.
    ls_data1-datax-madat = 'X'.
    ls_data1-datax-mahns = 'X'.
    ls_data1-datax-knrma = 'X'.
    ls_data1-datax-gmvdt = 'X'.
    ls_data1-datax-busab ='X'.

    es_customer_dunning = ls_data1.


  ENDMETHOD.


  METHOD fill_customer_general_data.

    DATA : ls_customer_gen TYPE cl_api_business_partne_mpc_ext=>ts_a_customertype.
    "ls_data         like cs_customer_data.

    ls_customer_gen = is_customer_data.

    MOVE-CORRESPONDING ls_customer_gen TO gs_data-customer-central_data-central-data EXPANDING NESTED TABLES.

*    gs_data-customer-header-object_instance-kunnr = ls_customer_gen-customer.
    gs_data-customer-header-object_instance-kunnr = ''.
    gs_data-customer-header-object_task = iv_task.

    DATA: lv_external TYPE nrind,
          lv_nr       TYPE bu_nrrng.

    SELECT SINGLE nrrng FROM tb001 INTO lv_nr WHERE bu_group = gv_bp_grouping.

    IF sy-subrc = 0.
      SELECT SINGLE externind FROM nriv INTO lv_external WHERE object = 'BU_PARTNER' AND nrrangenr =  lv_nr.
    ENDIF.

    IF lv_external IS NOT INITIAL.
      gs_data-customer-header-object_instance-kunnr = gv_partner.
    ENDIF.

    " In case of flexible Account Group, Acc Grp value should come from UI.
    IF ls_customer_gen-customeraccountgroup IS NOT INITIAL.
      gs_data-customer-central_data-central-data-ktokd = ls_customer_gen-customeraccountgroup.
      "else get it from customization
    ELSE.
      SELECT SINGLE ktokd FROM tbd001 INTO gs_data-customer-central_data-central-data-ktokd WHERE bu_group EQ gv_bp_grouping."ls_bp_root-businesspartnergrouping.
    ENDIF.

    "data
    gs_data-customer-central_data-central-data-lifnr = ls_customer_gen-supplier.
    gs_data-customer-central_data-central-data-sperr = ls_customer_gen-postingisblocked.
    gs_data-customer-central_data-central-data-aufsd = ls_customer_gen-orderisblockedforcustomer.
    gs_data-customer-central_data-central-data-lifsd = ls_customer_gen-deliveryisblocked.
    gs_data-customer-central_data-central-data-faksd = ls_customer_gen-billingisblockedforcustomer.
    gs_data-customer-central_data-central-data-kukla = ls_customer_gen-customerclassification.
    gs_data-customer-central_data-central-data-stkzn = ls_customer_gen-nfpartnerisnaturalperson.
    gs_data-customer-central_data-central-data-begru = ls_customer_gen-authorizationgroup.
    gs_data-customer-central_data-central-data-stkzn = ls_customer_gen-nfpartnerisnaturalperson.
    gs_data-customer-central_data-central-data-konzs = ls_customer_gen-customercorporategroup.
    gs_data-customer-central_data-central-data-fiskn = ls_customer_gen-fiscaladdress.
*    gs_data-customer-central_data-central-data-brsch = ls_customer_gen-industry.
*    gs_data-customer-central_data-central-data-bran1 = ls_customer_gen-industrycode1.
*    gs_data-customer-central_data-central-data-bran2 = ls_customer_gen-industrycode2.
*    gs_data-customer-central_data-central-data-bran3 = ls_customer_gen-industrycode3.
*    gs_data-customer-central_data-central-data-bran4 = ls_customer_gen-industrycode4.
*    gs_data-customer-central_data-central-data-bran5 = ls_customer_gen-industrycode5.
    gs_data-customer-central_data-central-data-bbbnr = ls_customer_gen-internationallocationnumber1.
    gs_data-customer-central_data-central-data-niels = ls_customer_gen-nielsenregion.
    gs_data-customer-central_data-central-data-fityp = ls_customer_gen-responsibletype.
*    gs_data-customer-central_data-central-data-stcd1 = ls_customer_gen-taxnumber1.
*    gs_data-customer-central_data-central-data-stcd2 = ls_customer_gen-taxnumber2.
*    gs_data-customer-central_data-central-data-stcd3 = ls_customer_gen-taxnumber3.
*    gs_data-customer-central_data-central-data-stcd4 = ls_customer_gen-taxnumber4.
*    gs_data-customer-central_data-central-data-stcd5 = ls_customer_gen-taxnumber5.
    gs_data-customer-central_data-central-data-stceg = ls_customer_gen-vatregistration.
    gs_data-customer-central_data-central-data-loevm = ls_customer_gen-deletionindicator.
    gs_data-customer-central_data-central-data-stcdt = ls_customer_gen-taxnumbertype.

    "datax
    gs_data-customer-central_data-central-datax-ktokd = 'X'.
    gs_data-customer-central_data-central-datax-lifnr = 'X'.
    gs_data-customer-central_data-central-datax-sperr = 'X'.
    gs_data-customer-central_data-central-datax-aufsd = 'X'.
    gs_data-customer-central_data-central-datax-lifsd = 'X'.
    gs_data-customer-central_data-central-datax-faksd = 'X'.
    gs_data-customer-central_data-central-datax-kukla = 'X'.
    gs_data-customer-central_data-central-datax-stkzn = 'X'.
    gs_data-customer-central_data-central-datax-begru = 'X'.
    gs_data-customer-central_data-central-datax-stkzn = 'X'.
    gs_data-customer-central_data-central-datax-konzs = 'X'.
    gs_data-customer-central_data-central-datax-fiskn = 'X'.
*    gs_data-customer-central_data-central-datax-brsch = 'X'.
*    gs_data-customer-central_data-central-datax-bran1 = 'X'.
*    gs_data-customer-central_data-central-datax-bran2 = 'X'.
*    gs_data-customer-central_data-central-datax-bran3 = 'X'.
*    gs_data-customer-central_data-central-datax-bran4 = 'X'.
*    gs_data-customer-central_data-central-datax-bran5 = 'X'.
    gs_data-customer-central_data-central-datax-bbbnr = 'X'.
    gs_data-customer-central_data-central-datax-niels = 'X'.
    gs_data-customer-central_data-central-datax-fityp = 'X'.
*    gs_data-customer-central_data-central-datax-stcd1 = 'X'.
*    gs_data-customer-central_data-central-datax-stcd2 = 'X'.
*    gs_data-customer-central_data-central-datax-stcd3 = 'X'.
*    gs_data-customer-central_data-central-datax-stcd4 = 'X'.
*    gs_data-customer-central_data-central-datax-stcd5 = 'X'.
    gs_data-customer-central_data-central-datax-stceg = 'X'.
    gs_data-customer-central_data-central-datax-loevm = 'X'.
    gs_data-customer-central_data-central-datax-stcdt = 'X'.

    " code to set data and datax for extensibility fields
    FIELD-SYMBOLS: <ls_field_datax> TYPE any .
    DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
    DATA : lt_tables   TYPE abap_compdescr_tab.
    DATA : ls_tab   LIKE LINE OF lt_tables.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_KNA1_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE gs_data-customer-central_data-central-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD fill_customer_partner_func.

    DATA : ls_customer_partnerfunc LIKE is_customer_function,
           ls_output1              LIKE es_customer_function.
    CONSTANTS cv_dummy_new_customer_number TYPE kunnr VALUE '##'.

    ls_customer_partnerfunc = is_customer_function.

    "task
    ls_output1-task = iv_task.

    "datakey
    ls_output1-data_key-parvw = ls_customer_partnerfunc-partnerfunction.
    ls_output1-data_key-parza = ls_customer_partnerfunc-partnercounter.

    "data
    ls_output1-data-defpa = ls_customer_partnerfunc-defaultpartner.
    ls_output1-data-knref = ls_customer_partnerfunc-customerpartnerdescription.


    IF ls_customer_partnerfunc-bpcustomernumber IS NOT INITIAL.
      ls_output1-data-partner = ls_customer_partnerfunc-bpcustomernumber.
    ELSE.
      IF iv_task = 'I' AND iv_customer IS NOT INITIAL.
        ls_output1-data-partner = iv_customer.
      ELSE.
        ls_output1-data-partner = cv_dummy_new_customer_number.
      ENDIF.
    ENDIF.

    "datax
    ls_output1-datax-defpa = 'X'.
    ls_output1-datax-knref = 'X'.
    ls_output1-datax-partner = 'X'.

    es_customer_function = ls_output1.

  ENDMETHOD.


  METHOD fill_customer_salesarea_data.

    DATA : ls_customer_salesarea LIKE is_sales_data,
           ls_output             LIKE es_sales_data.

    ls_customer_salesarea = is_sales_data.

    ls_output-task = iv_task.

    MOVE-CORRESPONDING ls_customer_salesarea TO ls_output-data EXPANDING NESTED TABLES.

    "datakey
    ls_output-data_key-spart = ls_customer_salesarea-division.
    ls_output-data_key-vkorg = ls_customer_salesarea-salesorganization.
    ls_output-data_key-vtweg = ls_customer_salesarea-distributionchannel.


    "data
    ls_output-data-aufsd = ls_customer_salesarea-orderisblockedforcustomer.
    ls_output-data-lifsd = ls_customer_salesarea-deliveryisblockedforcustomer.
    ls_output-data-faksd = ls_customer_salesarea-billingisblockedforcustomer.
    ls_output-data-vkbur = ls_customer_salesarea-salesoffice.
    ls_output-data-vkgrp = ls_customer_salesarea-salesgroup.
    ls_output-data-eikto = ls_customer_salesarea-accountbycustomer.
    ls_output-data-klabc = ls_customer_salesarea-customerabcclassification.
    ls_output-data-waers = ls_customer_salesarea-currency.
    ls_output-data-konda = ls_customer_salesarea-customerpricegroup.
    ls_output-data-kalks = ls_customer_salesarea-customerpricingprocedure.
    ls_output-data-pltyp = ls_customer_salesarea-pricelisttype.
    ls_output-data-lprio = ls_customer_salesarea-deliverypriority.
    ls_output-data-vsbed = ls_customer_salesarea-shippingcondition.
    ls_output-data-kzazu = ls_customer_salesarea-ordercombinationisallowed.
    ls_output-data-autlf = ls_customer_salesarea-completedeliveryisdefined.
    ls_output-data-kztlf = ls_customer_salesarea-partialdeliveryisallowed.
    ls_output-data-perfk = ls_customer_salesarea-invoicedate.
    ls_output-data-inco1 = ls_customer_salesarea-incotermsclassification.
    ls_output-data-inco2 = ls_customer_salesarea-incotermstransferlocation.
    ls_output-data-begru = ls_customer_salesarea-authorizationgroup.
    ls_output-data-inco2_l = ls_customer_salesarea-incotermslocation1.
    ls_output-data-inco3_l = ls_customer_salesarea-incotermslocation2.
    ls_output-data-incov = ls_customer_salesarea-incotermsversion.
    ls_output-data-loevm = ls_customer_salesarea-deletionindicator.
    ls_output-data-zterm = ls_customer_salesarea-customerpaymentterms.
    ls_output-data-ktgrd = ls_customer_salesarea-customeraccountassignmentgroup.
    ls_output-data-kdgrp = ls_customer_salesarea-customergroup.
    ls_output-data-vwerk = ls_customer_salesarea-supplyingplant.
    ls_output-data-awahr = ls_customer_salesarea-itemorderprobabilityinpercent.
    ls_output-data-bzirk = ls_customer_salesarea-salesdistrict.  " Sales District field

    "datax
    ls_output-datax-aufsd = 'X'.
    ls_output-datax-lifsd = 'X'.
    ls_output-datax-faksd = 'X'.
    ls_output-datax-vkbur = 'X'.
    ls_output-datax-vkgrp = 'X'.
    ls_output-datax-eikto = 'X'.
    ls_output-datax-klabc = 'X'.
    ls_output-datax-waers = 'X'.
    ls_output-datax-konda = 'X'.
    ls_output-datax-kalks = 'X'.
    ls_output-datax-pltyp = 'X'.
    ls_output-datax-lprio = 'X'.
    ls_output-datax-vsbed = 'X'.
    ls_output-datax-kzazu = 'X'.
    ls_output-datax-autlf = 'X'.
    ls_output-datax-kztlf = 'X'.
    ls_output-datax-perfk = 'X'.
    ls_output-datax-inco1 = 'X'.
    ls_output-datax-inco2 = 'X'.
    ls_output-datax-begru = 'X'.
    ls_output-datax-inco2_l = 'X'.
    ls_output-datax-inco3_l = 'X'.
    ls_output-datax-incov = 'X'.
    ls_output-datax-loevm = 'X'.
    ls_output-datax-zterm = 'X'.
    ls_output-datax-ktgrd = 'X'.
    ls_output-datax-kdgrp = 'X'.
    ls_output-datax-vwerk = 'X'.
    ls_output-datax-awahr = 'X'.
    ls_output-datax-bzirk = 'X'.


    " code to set data and datax for extensibility fields

    FIELD-SYMBOLS: <ls_field_datax> TYPE any .
    DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
    DATA : lt_tables   TYPE abap_compdescr_tab.
    DATA : ls_tab   LIKE LINE OF lt_tables.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_KNVV_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE  ls_output-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.
    ENDLOOP.


    es_sales_data = ls_output.

  ENDMETHOD.


  METHOD fill_customer_wtax_data.

    DATA: ls_customer_withtax LIKE is_customer_wtax,
          ls_data2            LIKE es_customer_wtax.

    ls_customer_withtax = is_customer_wtax.
    "task
    ls_data2-task = iv_task.

    "data_key
    ls_data2-data_key-witht = ls_customer_withtax-withholdingtaxtype.

    "data
    ls_data2-data-wt_withcd = ls_customer_withtax-withholdingtaxcode.
    ls_data2-data-wt_agent = ls_customer_withtax-withholdingtaxagent.
    ls_data2-data-wt_agtdf = ls_customer_withtax-obligationdatebegin.
    ls_data2-data-wt_agtdt = ls_customer_withtax-obligationdateend.
    ls_data2-data-wt_wtstcd = ls_customer_withtax-withholdingtaxnumber.
    ls_data2-data-wt_exnr = ls_customer_withtax-withholdingtaxcertificate.
    ls_data2-data-wt_exrt = ls_customer_withtax-withholdingtaxexmptpercent.
    ls_data2-data-wt_exdf = ls_customer_withtax-exemptiondatebegin.
    ls_data2-data-wt_exdt = ls_customer_withtax-exemptiondateend.
    ls_data2-data-wt_wtexrs = ls_customer_withtax-exemptionreason.

    "datax
    ls_data2-datax-wt_withcd = 'X'.
    ls_data2-datax-wt_agent = 'X'.
    ls_data2-datax-wt_agtdf = 'X'.
    ls_data2-datax-wt_agtdt = 'X'.
    ls_data2-datax-wt_wtstcd = 'X'.
    ls_data2-datax-wt_exnr = 'X'.
    ls_data2-datax-wt_exrt = 'X'.
    ls_data2-datax-wt_exdf = 'X'.
    ls_data2-datax-wt_exdt = 'X'.
    ls_data2-datax-wt_wtexrs = 'X'.

    es_customer_wtax = ls_data2.


  ENDMETHOD.


  METHOD fill_deep_address.

    DATA : ls_partner_address      LIKE bupa_address_struc,
           ls_output               LIKE LINE OF et_partner_address,
           lv_adr_data             TYPE bapibus1006_addresses_int-addrguid,
           lt_adr_usage            TYPE bus_ei_bupa_addressusage_t,
           ls_adr_usage            LIKE LINE OF lt_adr_usage,
           ls_partner_addressusage LIKE LINE OF bupa_address_struc-to_addressusage,
           lc_tzone_utc            TYPE tznzone VALUE 'UTC'.

    DATA : lt_phone TYPE bus_ei_bupa_telephone_t,
           ls_phone LIKE LINE OF lt_phone,
           lt_fax   TYPE bus_ei_bupa_fax_t,
           ls_fax   LIKE LINE OF lt_fax,
           lt_smtp  TYPE bus_ei_bupa_smtp_t,
           ls_smtp  LIKE LINE OF lt_smtp,
           lt_uri   TYPE bus_ei_bupa_uri_t,
           ls_uri   LIKE LINE OF lt_uri.

    DATA: lt_address_all  TYPE TABLE OF bapibus1006_addresses.

    DATA:lt_partner_address LIKE TABLE OF bupa_address_struc,
         lt_bp_address      LIKE TABLE OF bupa_address_struc.

    lt_bp_address = ct_partner_address.

    LOOP AT lt_bp_address INTO ls_partner_address.

      "TASK
      ls_output-task = iv_task.
      "datakey
      IF iv_task = 'I'.
        TRY.
            CALL METHOD cl_system_uuid=>create_uuid_x16_static
              RECEIVING
                uuid = lv_adr_data.
          CATCH cx_uuid_error .
        ENDTRY.
        ls_output-data_key = lv_adr_data.
        ls_partner_address-addressuuid = lv_adr_data.
        "ls_output-currently_valid = 'X'.

      ELSE.
        IF ls_partner_address-addressuuid IS NOT INITIAL.
          ls_output-data_key = lv_adr_data.
          ls_partner_address-addressuuid = lv_adr_data.
        ENDIF.
        "ls_output-currently_valid = 'X'.
      ENDIF.


      "data
      ls_output-data-postal-data-c_o_name = ls_partner_address-careofname.
      ls_output-data-postal-data-house_no = ls_partner_address-housenumber.
      ls_output-data-postal-data-street = ls_partner_address-streetname.
      ls_output-data-postal-data-house_no2 = ls_partner_address-housenumbersupplementtext.
      ls_output-data-postal-data-district = ls_partner_address-district.
      ls_output-data-postal-data-postl_cod1 = ls_partner_address-postalcode.
      ls_output-data-postal-data-city = ls_partner_address-cityname.
      ls_output-data-postal-data-city_no = ls_partner_address-citycode.
      ls_output-data-postal-data-county = ls_partner_address-county.
      ls_output-data-postal-data-country = ls_partner_address-country.
      ls_output-data-postal-data-region = ls_partner_address-region.
      ls_output-data-postal-data-time_zone = ls_partner_address-addresstimezone.
      ls_output-data-postal-data-postl_cod3 = ls_partner_address-companypostalcode.
      ls_output-data-postal-data-deli_serv_number = ls_partner_address-deliveryservicenumber.
      ls_output-data-postal-data-po_box = ls_partner_address-pobox.
      ls_output-data-postal-data-po_w_o_no = ls_partner_address-poboxiswithoutnumber.
      ls_output-data-postal-data-postl_cod2 = ls_partner_address-poboxpostalcode.
      ls_output-data-postal-data-po_box_lobby = ls_partner_address-poboxlobbyname.
      ls_output-data-postal-data-po_box_cit = ls_partner_address-poboxdeviatingcityname.
      ls_output-data-postal-data-po_box_reg = ls_partner_address-poboxdeviatingregion.
      ls_output-data-postal-data-pobox_ctry = ls_partner_address-poboxdeviatingcountry.
      ls_output-data-postal-data-langu = ls_partner_address-language.
      ls_output-data-postal-data-comm_type = ls_partner_address-prfrdcommmediumtype.
      ls_output-data-postal-data-str_suppl1 = ls_partner_address-streetprefixname.
      ls_output-data-postal-data-str_suppl2 = ls_partner_address-additionalstreetprefixname.
      ls_output-data-postal-data-str_suppl3 = ls_partner_address-streetsuffixname.
      ls_output-data-postal-data-location   = ls_partner_address-additionalstreetsuffixname.
      ls_output-data-postal-data-home_city  = ls_partner_address-homecityname.
      ls_output-data-postal-data-taxjurcode = ls_partner_address-taxjurisdiction.
      ls_output-data-postal-data-transpzone = ls_partner_address-transportzone.
      ls_output-data-postal-data-deli_serv_type = ls_partner_address-deliveryservicetypecode.
      ls_output-data-postal-data-extaddressnumber = ls_partner_address-addressidbyexternalsystem."1802


      DATA lv_timestamp TYPE bu_role_valid_from."ad_tstamp.
      lv_timestamp = ls_partner_address-validitystartdate.

      IF lv_timestamp IS NOT INITIAL.

        CONVERT TIME STAMP lv_timestamp   TIME ZONE lc_tzone_utc
                INTO DATE ls_output-data-postal-data-validfromdate.
      ELSE .
        ls_output-data-postal-data-validfromdate = ls_partner_address-validitystartdate.
      ENDIF.

      lv_timestamp = ls_partner_address-validityenddate.

      IF lv_timestamp IS NOT INITIAL.
        CONVERT TIME STAMP lv_timestamp   TIME ZONE lc_tzone_utc
            INTO DATE ls_output-data-postal-data-validtodate.
      ELSE .
        ls_output-data-postal-data-validtodate = ls_partner_address-validityenddate.
      ENDIF.

      CLEAR lv_timestamp.

      ls_output-data-postal-datax-validtodate = 'X'.
      ls_output-data-postal-datax-validfromdate = 'X'.
      ls_output-data-postal-datax-country = 'X'.
      ls_output-data-postal-datax-c_o_name = 'X'.
      ls_output-data-postal-datax-house_no = 'X'.
      ls_output-data-postal-datax-street = 'X'.
      ls_output-data-postal-datax-house_no2 = 'X'.
      ls_output-data-postal-datax-district = 'X'.
      ls_output-data-postal-datax-postl_cod1 = 'X'.
      ls_output-data-postal-datax-city = 'X'.
      ls_output-data-postal-datax-city_no = 'X'.
      ls_output-data-postal-datax-county = 'X'.
      ls_output-data-postal-datax-country = 'X'.
      ls_output-data-postal-datax-region = 'X'.
      ls_output-data-postal-datax-time_zone = 'X'.
      ls_output-data-postal-datax-postl_cod3 = 'X'.
      ls_output-data-postal-datax-deli_serv_number = 'X'.
      ls_output-data-postal-datax-po_box = 'X'.
      ls_output-data-postal-datax-po_w_o_no = 'X'.
      ls_output-data-postal-datax-postl_cod2 = 'X'.
      ls_output-data-postal-datax-po_box_lobby = 'X'.
      ls_output-data-postal-datax-po_box_cit = 'X'.
      ls_output-data-postal-datax-po_box_reg = 'X'.
      ls_output-data-postal-datax-pobox_ctry = 'X'.
      ls_output-data-postal-datax-langu = 'X'.
      ls_output-data-postal-datax-comm_type = 'X'.
      ls_output-data-postal-datax-str_suppl1 = 'X'.
      ls_output-data-postal-datax-str_suppl2 = 'X'.
      ls_output-data-postal-datax-str_suppl3 = 'X'.
      ls_output-data-postal-datax-location   = 'X'.
      ls_output-data-postal-datax-home_city  = 'X'.
      ls_output-data-postal-datax-taxjurcode = 'X'.
      ls_output-data-postal-datax-transpzone = 'X'.
      ls_output-data-postal-datax-deli_serv_type = 'X'.
      ls_output-data-postal-datax-extaddressnumber = 'X'."1802



*     Fill Address Usages
      DATA(lt_partner_addressusage) = ls_partner_address-to_addressusage.
      READ TABLE lt_partner_addressusage WITH KEY addressusage = 'XXDEFAULT' TRANSPORTING NO FIELDS.

      LOOP AT lt_partner_addressusage INTO ls_partner_addressusage.
        "if ls_partner_addressusage-parent_key = ls_partner_address-key.
        ls_adr_usage-task = iv_task.

        IF ls_partner_addressusage-addressusage IS NOT INITIAL.

          IF ls_partner_addressusage-addressusage NE 'XXDEFAULT'.
            ls_adr_usage-data-standard = 'X'.

          ELSE.
            CLEAR ls_adr_usage-data-standard.
          ENDIF.
*            ls_adr_usage-datax-standard = 'X'.
          ls_adr_usage-data_key-addresstype = ls_partner_addressusage-addressusage.
        ENDIF.

        DATA lv_timestamp1 TYPE bu_advw_valid_from."BU_ADDR_VALID_FROM."ad_tstamp.
        lv_timestamp1 = ls_partner_addressusage-validityenddate.

        IF lv_timestamp1 IS NOT INITIAL.
          CONVERT TIME STAMP lv_timestamp1   TIME ZONE lc_tzone_utc
            INTO DATE ls_adr_usage-data_key-valid_to.
        ELSE.
          ls_adr_usage-data_key-valid_to = ls_partner_addressusage-validityenddate.
        ENDIF.


        DATA lv_timestamp2 TYPE bu_advw_valid_to."ad_tstamp.
        lv_timestamp2 = ls_partner_addressusage-validitystartdate.

        IF lv_timestamp1 IS NOT INITIAL.
          CONVERT TIME STAMP lv_timestamp2   TIME ZONE lc_tzone_utc
                  INTO DATE ls_adr_usage-data-valid_from.
        ELSE.
          ls_adr_usage-data-valid_from = ls_partner_addressusage-validitystartdate.
        ENDIF.
        CLEAR lv_timestamp1.
        CLEAR lv_timestamp2.


        ls_adr_usage-datax-standard = 'X'.
        ls_adr_usage-datax-valid_from = 'X'.

        APPEND ls_adr_usage TO lt_adr_usage.
        CLEAR ls_adr_usage.

      ENDLOOP.

      ls_output-data-addr_usage-addr_usages = lt_adr_usage.
      CLEAR lt_adr_usage.

      " communication , check from here

      ls_output-data-communication-time_dependent = 'X'.


      "phone
      DATA(lt_phone_data) = ls_partner_address-to_phonenumber.
      LOOP AT lt_phone_data INTO DATA(ls_phone_data).
        ls_phone-contact-task = iv_task.
        ls_phone-contact-data-country = ls_phone_data-destinationlocationcountry.
        ls_phone-contact-data-telephone = ls_phone_data-phonenumber.
        ls_phone-contact-data-extension = ls_phone_data-phonenumberextension.
        ls_phone-contact-data-r_3_user = '1'.

        ls_phone-contact-datax-country = 'X'.
        ls_phone-contact-datax-telephone = 'X'.
        ls_phone-contact-datax-extension = 'X'.
        ls_phone-contact-datax-r_3_user = 'X'.

        APPEND ls_phone TO lt_phone.
        CLEAR ls_phone.
      ENDLOOP.

      DATA(lt_mobile_data) = ls_partner_address-to_mobilephonenumber.
      LOOP AT lt_mobile_data INTO DATA(ls_mobile_data).
        ls_phone-contact-task = iv_task.
        ls_phone-contact-data-country = ls_mobile_data-destinationlocationcountry.
        ls_phone-contact-data-telephone = ls_mobile_data-phonenumber.
        ls_phone-contact-data-r_3_user = '3'.

        ls_phone-contact-datax-country = 'X'.
        ls_phone-contact-datax-telephone = 'X'.
        ls_phone-contact-datax-r_3_user = 'X'.
        APPEND ls_phone TO lt_phone.
        CLEAR ls_phone.
      ENDLOOP.

      ls_output-data-communication-phone-phone = lt_phone.
      CLEAR lt_phone.
      "fax
      DATA(lt_fax_data) = ls_partner_address-to_faxnumber.
      LOOP AT lt_fax_data INTO DATA(ls_fax_data).
        ls_fax-contact-task = iv_task.
        ls_fax-contact-data-country = ls_fax_data-faxcountry.
        ls_fax-contact-data-fax = ls_fax_data-faxnumber.
        ls_fax-contact-data-extension = ls_fax_data-faxnumberextension.

        ls_fax-contact-datax-country = 'X'.
        ls_fax-contact-datax-fax = 'X'.
        ls_fax-contact-datax-extension = 'X'.

        APPEND ls_fax TO lt_fax.
        CLEAR ls_fax.
      ENDLOOP.

      ls_output-data-communication-fax-fax = lt_fax.
      CLEAR lt_fax.


      "smtp
      DATA(lt_smtp_data) = ls_partner_address-to_emailaddress.
      LOOP AT lt_smtp_data INTO DATA(ls_smtp_data).

        ls_smtp-contact-task = iv_task. " Standard
        ls_smtp-contact-data-e_mail = ls_smtp_data-emailaddress.
        "datax not set dynamically for one field
        ls_smtp-contact-datax-e_mail = 'X'.

        APPEND ls_smtp TO lt_smtp.
        CLEAR ls_smtp.
        IF iv_task = 'U' AND ls_smtp_data-emailaddress IS INITIAL.
          CLEAR lt_smtp.
        ENDIF.

        IF iv_task = 'I' AND ls_smtp_data-emailaddress IS INITIAL.
          CLEAR lt_smtp.
        ENDIF.
      ENDLOOP.

      ls_output-data-communication-smtp-smtp = lt_smtp.
      CLEAR lt_smtp.

      "Website
      DATA(lt_url_data) = ls_partner_address-to_urladdress.
      LOOP AT lt_url_data INTO DATA(ls_url_data).
        ls_uri-contact-task = iv_task.
        ls_uri-contact-data-uri =  ls_url_data-websiteurl.
        ls_uri-contact-data-uri_type = 'HPG'.

        ls_uri-contact-datax-uri =  'X'.
        ls_uri-contact-datax-uri_type = 'X'.

        APPEND ls_uri TO lt_uri.
        CLEAR ls_uri.
      ENDLOOP.

      ls_output-data-communication-uri-uri = lt_uri.
      CLEAR lt_uri.

      APPEND ls_output TO et_partner_address.
      APPEND ls_partner_address TO lt_partner_address.

      CLEAR ls_partner_address.
      CLEAR ls_output.
      CLEAR lt_fax.
      CLEAR ls_phone.
      CLEAR ls_adr_usage.
      CLEAR lv_adr_data.

    ENDLOOP.

    ct_partner_address = lt_partner_address.

  ENDMETHOD.


  METHOD fill_deep_contact_data.

    DATA : ls_contact_data LIKE contact_struc.
    DATA : ls_partner_relation TYPE LINE OF burs_ei_extern_t.
    DATA: lv_task TYPE char1.
    DATA: lv_contact_guid LIKE partner_struc-businesspartneruuid.
    DATA lt_contact_data LIKE TABLE OF contact_struc.
    lt_contact_data = it_partner_relation.
    DATA: ls_contact_address TYPE LINE OF burs_ei_rel_address_t.
    DATA: lv_adr_guid TYPE bapibus1006_addresses_int-addrguid.
    DATA: lv_adr_number TYPE bapibus1006_addresses_int-addrnumber.

    IF iv_task = 'I'.
      lv_task = 'I'.
    ELSE.
      "decide update or delete.
    ENDIF.


    LOOP AT lt_contact_data INTO ls_contact_data.

      CALL FUNCTION 'BUPA_NUMBERS_GET'
        EXPORTING
          iv_partner      = ls_contact_data-businesspartnerperson
        IMPORTING
          ev_partner_guid = lv_contact_guid.
      IF sy-subrc = '0'.
        ls_partner_relation-header-object_task = lv_task.
        ls_partner_relation-header-object_instance-partner1-bpartner = gv_partner.
        ls_partner_relation-header-object_instance-partner1-bpartnerguid = gv_partner_guid.
        ls_partner_relation-header-object_instance-partner2-bpartner = ls_contact_data-businesspartnerperson.
        ls_partner_relation-header-object_instance-partner2-bpartnerguid = lv_contact_guid.
        ls_partner_relation-header-object_instance-relat_category = 'BUR001'.
        ls_partner_relation-header-object_instance-date_to = ls_contact_data-validityenddate.

        DATA(ls_func_dept_data) = ls_contact_data-to_contactrelationship.

        ls_partner_relation-central_data-contact-central_data-data-function = ls_func_dept_data-contactpersonfunction.
        ls_partner_relation-central_data-contact-central_data-data-department = ls_func_dept_data-contactpersondepartment.
        ls_partner_relation-central_data-contact-central_data-data-tel1_numbr = ls_func_dept_data-phonenumber.
        ls_partner_relation-central_data-contact-central_data-data-tel1_ext = ls_func_dept_data-phonenumberextension.
        ls_partner_relation-central_data-contact-central_data-data-fax_number = ls_func_dept_data-faxnumber.
        ls_partner_relation-central_data-contact-central_data-data-fax_extens = ls_func_dept_data-faxnumberextension.
        ls_partner_relation-central_data-contact-central_data-data-e_mail =  ls_func_dept_data-emailaddress.

        ls_partner_relation-central_data-contact-central_data-datax-function = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-department = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-tel1_numbr = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-tel1_ext = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-fax_number = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-fax_extens = 'X'.
        ls_partner_relation-central_data-contact-central_data-datax-e_mail =  'X'.

      ENDIF.

      APPEND ls_partner_relation TO et_partner_relation.
      CLEAR ls_partner_relation.
    ENDLOOP.


  ENDMETHOD.


  METHOD fill_deep_customer_companycode.

    DATA : ls_customer_compcode LIKE customer_company_struc,
           ls_data              LIKE LINE OF et_customer_companycode_data.

    DATA   lv_partner                TYPE bu_partner.

    DATA   lt_customer_companycode LIKE TABLE OF customer_company_struc.

    lt_customer_companycode = it_customer_companycode_data.


    LOOP AT lt_customer_companycode INTO ls_customer_compcode.
      "if sy-subrc = 0.
      MOVE-CORRESPONDING ls_customer_compcode TO ls_data-data EXPANDING NESTED TABLES.

      "Determine child task by has active entity
      IF iv_task = 'I'.
        ls_data-task = iv_task.
      ELSE.
        "determine update or delete
      ENDIF.

      "datakey
      ls_data-data_key-bukrs = ls_customer_compcode-companycode.
      "data
      ls_data-data-busab = ls_customer_compcode-accountingclerk.
      ls_data-data-intad = ls_customer_compcode-accountingclerkinternetaddress.
      ls_data-data-tlfns = ls_customer_compcode-accountingclerkphonenumber.
      ls_data-data-tlfxs = ls_customer_compcode-accountingclerkfaxnumber.
      ls_data-data-zsabe = ls_customer_compcode-useratcustomer.
      ls_data-data-eikto = ls_customer_compcode-accountbycustomer.
      ls_data-data-perkz = ls_customer_compcode-collectiveinvoicevariant.
      ls_data-data-xdezv = ls_customer_compcode-istobelocallyprocessed.
      ls_data-data-kverm = ls_customer_compcode-customeraccountnote.
      ls_data-data-zterm = ls_customer_compcode-paymentterms.
      ls_data-data-zwels = ls_customer_compcode-paymentmethodslist.
      ls_data-data-zahls = ls_customer_compcode-paymentblockingreason.
      ls_data-data-xzver = ls_customer_compcode-recordpaymenthistoryindicator.
      ls_data-data-togru = ls_customer_compcode-apartolerancegroup.
      ls_data-data-xpore = ls_customer_compcode-itemistobepaidseparately.
      ls_data-data-xverr = ls_customer_compcode-customersupplierclearingisused.
      ls_data-data-xedip = ls_customer_compcode-paytadviceissentbyedi.
      ls_data-data-knrzb = ls_customer_compcode-alternativepayeraccount.
      ls_data-data-akont = ls_customer_compcode-reconciliationaccount.
      ls_data-data-knrze = ls_customer_compcode-customerheadoffice.
      ls_data-data-zuawa = ls_customer_compcode-layoutsortingrule.
      ls_data-data-begru = ls_customer_compcode-authorizationgroup.
      ls_data-data-vzskz = ls_customer_compcode-interestcalculationcode.
      ls_data-data-zindt = ls_customer_compcode-interestcalculationdate.
      ls_data-data-zinrt = ls_customer_compcode-intrstcalcfrequencyinmonths.
      ls_data-data-hbkid = ls_customer_compcode-housebank.
      ls_data-data-sperr = ls_customer_compcode-physicalinventoryblockind.
      ls_data-data-begru = ls_customer_compcode-authorizationgroup.
      ls_data-data-loevm = ls_customer_compcode-deletionindicator.
      "ls_data-data-cvp_xblck_b = ls_customer_compcode-IsBusinessPurposeCompleted.

      "Fill DATAX for customer company code

      ls_data-datax-busab = 'X'.
      ls_data-datax-intad = 'X'.
      ls_data-datax-tlfns = 'X'.
      ls_data-datax-tlfxs = 'X'.
      ls_data-datax-zsabe = 'X'.
      ls_data-datax-eikto = 'X'.
      ls_data-datax-perkz = 'X'.
      ls_data-datax-xdezv = 'X'.
      ls_data-datax-kverm = 'X'.
      ls_data-datax-zterm = 'X'.
      ls_data-datax-zwels = 'X'.
      ls_data-datax-zahls = 'X'.
      ls_data-datax-xzver = 'X'.
      ls_data-datax-togru = 'X'.
      ls_data-datax-xpore = 'X'.
      ls_data-datax-xverr = 'X'.
      ls_data-datax-xedip = 'X'.
      ls_data-datax-knrzb = 'X'.
      ls_data-datax-akont = 'X'.
      ls_data-datax-knrze = 'X'.
      ls_data-datax-zuawa = 'X'.
      ls_data-datax-begru = 'X'.
      ls_data-datax-vzskz = 'X'.
      ls_data-datax-zindt = 'X'.
      ls_data-datax-zinrt = 'X'.
      ls_data-datax-hbkid = 'X'.
      ls_data-datax-sperr = 'X'.
      ls_data-datax-begru = 'X'.
      ls_data-datax-loevm = 'X'.

      " code to set data and datax for extensibility fields

      FIELD-SYMBOLS: <ls_field_datax> TYPE any .
      DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
      DATA : lt_tables   TYPE abap_compdescr_tab.
      DATA : ls_tab   LIKE LINE OF lt_tables.

      ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_KNB1_X').
      lt_tables[] = ref_table_des->components[].

      LOOP AT lt_tables INTO ls_tab.
        ASSIGN COMPONENT ls_tab-name OF STRUCTURE  ls_data-datax TO <ls_field_datax>.
        IF <ls_field_datax> IS ASSIGNED.
          <ls_field_datax> = abap_true.
        ENDIF.
      ENDLOOP.



      "customer dunning
      DATA : lt_data1            TYPE cmds_ei_dunning_t,
             ls_data1            LIKE LINE OF lt_data1,
             lt_customer_dunning TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_customerdunningtype,
             ls_customer_dunning LIKE LINE OF lt_customer_dunning.

      lt_customer_dunning = ls_customer_compcode-to_customerdunning.

      LOOP AT lt_customer_dunning INTO ls_customer_dunning.
        IF iv_task = 'I'.
          ls_data1-task = iv_task.
        ELSE.
          "determine update or delete
        ENDIF.
        ls_data1-data_key-maber = ls_customer_dunning-dunningarea.
        ls_data1-data-busab = ls_customer_dunning-dunningclerk.
        ls_data1-data-mahna = ls_customer_dunning-dunningprocedure.
        ls_data1-data-mansp = ls_customer_dunning-dunningblock.
        ls_data1-data-madat = ls_customer_dunning-lastdunnedon.
        ls_data1-data-mahns = ls_customer_dunning-dunninglevel.
        ls_data1-data-knrma = ls_customer_dunning-dunningrecipient.
        ls_data1-data-gmvdt = ls_customer_dunning-legdunningprocedureon.

        ls_data1-datax-mahna = 'X'.
        ls_data1-datax-busab = 'X'.
        ls_data1-datax-mansp = 'X'.
        ls_data1-datax-madat = 'X'.
        ls_data1-datax-mahns = 'X'.
        ls_data1-datax-knrma = 'X'.
        ls_data1-datax-gmvdt = 'X'.

        APPEND ls_data1 TO lt_data1.
        CLEAR ls_customer_dunning.

      ENDLOOP.
      "endif.

      ls_data-dunning-dunning = lt_data1.
      CLEAR lt_data1.


      "customer withholding taxes
      DATA : lt_data2            TYPE cmds_ei_wtax_type_t,
             ls_data2            LIKE LINE OF lt_data2,
             lt_customer_withtax TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_customerwithholdingtaxtyp,
             ls_customer_withtax LIKE LINE OF lt_customer_withtax.

      lt_customer_withtax = ls_customer_compcode-to_withholdingtax.

      LOOP AT lt_customer_withtax INTO ls_customer_withtax.
        IF iv_task = 'I'.
          ls_data2-task = iv_task.
        ELSE.
          "determine update or delete
        ENDIF.
        ls_data2-data_key-witht = ls_customer_withtax-withholdingtaxtype.


        ls_data2-data-wt_withcd = ls_customer_withtax-withholdingtaxcode.
        ls_data2-data-wt_agent = ls_customer_withtax-withholdingtaxagent.
        ls_data2-data-wt_agtdf = ls_customer_withtax-obligationdatebegin.
        ls_data2-data-wt_agtdt = ls_customer_withtax-obligationdateend.
        ls_data2-data-wt_wtstcd = ls_customer_withtax-withholdingtaxnumber.
        ls_data2-data-wt_exnr = ls_customer_withtax-withholdingtaxcertificate.
        ls_data2-data-wt_exrt = ls_customer_withtax-withholdingtaxexmptpercent.
        ls_data2-data-wt_exdf = ls_customer_withtax-exemptiondatebegin.
        ls_data2-data-wt_exdt = ls_customer_withtax-exemptiondateend.
        ls_data2-data-wt_wtexrs = ls_customer_withtax-exemptionreason.

        ls_data2-datax-wt_withcd = 'X'.
        ls_data2-datax-wt_agent = 'X'.
        ls_data2-datax-wt_agtdf = 'X'.
        ls_data2-datax-wt_agtdt = 'X'.
        ls_data2-datax-wt_wtstcd = 'X'.
        ls_data2-datax-wt_exnr = 'X'.
        ls_data2-datax-wt_exrt = 'X'.
        ls_data2-datax-wt_exdf = 'X'.
        ls_data2-datax-wt_exdt = 'X'.
        ls_data2-datax-wt_wtexrs = 'X'.


        APPEND ls_data2 TO lt_data2.
        CLEAR ls_customer_withtax.

      ENDLOOP.
      "endif.

      ls_data-wtax_type-wtax_type = lt_data2.
      CLEAR lt_data2.

      APPEND ls_data TO  et_customer_companycode_data.
      CLEAR ls_data.
    ENDLOOP.


  ENDMETHOD.


  METHOD fill_deep_customer_salesarea.

    DATA : ls_customer_salesarea LIKE customer_sales_struc,
           ls_customer_gen       LIKE customer_struc,
           ls_output             LIKE LINE OF et_customer_salesarea.

    DATA : ls_customer_partnerfunc   TYPE cl_api_business_partne_mpc_ext=>ts_a_custsalespartnerfunctype,
           et_customer_sapartnerfunc TYPE cmds_ei_functions_t,
           ls_output1                LIKE LINE OF  et_customer_sapartnerfunc.

    DATA : lt_partfunc_temp TYPE itbusinesspartnerpartfunctp,
           lt_partfunc_copy TYPE itbusinesspartnerpartfunctp,
           ls_partfunc_temp LIKE LINE OF lt_partfunc_temp,
           index            TYPE i.

    CONSTANTS cv_dummy_new_customer_number TYPE kunnr VALUE '##'.
    DATA : lt_customer_salesarea LIKE TABLE OF customer_sales_struc.

    lt_customer_salesarea = it_customer_salesarea.


    LOOP AT lt_customer_salesarea INTO ls_customer_salesarea.

      MOVE-CORRESPONDING ls_customer_salesarea TO ls_output-data EXPANDING NESTED TABLES.

      "Determine child task by has active entity
      IF iv_task = 'I'.
        ls_output-task = iv_task.
      ELSE.
        "determine update or delete
      ENDIF.

      "datakey
      ls_output-data_key-spart = ls_customer_salesarea-division.
      ls_output-data_key-vkorg = ls_customer_salesarea-salesorganization.
      ls_output-data_key-vtweg = ls_customer_salesarea-distributionchannel.


      "data
      ls_output-data-aufsd = ls_customer_salesarea-orderisblockedforcustomer.
      ls_output-data-lifsd = ls_customer_salesarea-deliveryisblockedforcustomer.
      ls_output-data-faksd = ls_customer_salesarea-billingisblockedforcustomer.
      ls_output-data-vkbur = ls_customer_salesarea-salesoffice.
      ls_output-data-vkgrp = ls_customer_salesarea-salesgroup.
      ls_output-data-eikto = ls_customer_salesarea-accountbycustomer.
      ls_output-data-klabc = ls_customer_salesarea-customerabcclassification.
      ls_output-data-waers = ls_customer_salesarea-currency.
      ls_output-data-konda = ls_customer_salesarea-customerpricegroup.
      ls_output-data-kalks = ls_customer_salesarea-customerpricingprocedure.
      ls_output-data-pltyp = ls_customer_salesarea-pricelisttype.
      ls_output-data-lprio = ls_customer_salesarea-deliverypriority.
      ls_output-data-vsbed = ls_customer_salesarea-shippingcondition.
      ls_output-data-kzazu = ls_customer_salesarea-ordercombinationisallowed.
      ls_output-data-autlf = ls_customer_salesarea-completedeliveryisdefined.
      ls_output-data-kztlf = ls_customer_salesarea-partialdeliveryisallowed.
      ls_output-data-perfk = ls_customer_salesarea-invoicedate.
      ls_output-data-inco1 = ls_customer_salesarea-incotermsclassification.
      ls_output-data-inco2 = ls_customer_salesarea-incotermstransferlocation.
      ls_output-data-begru = ls_customer_salesarea-authorizationgroup.
      ls_output-data-inco2_l = ls_customer_salesarea-incotermslocation1.
      ls_output-data-inco3_l = ls_customer_salesarea-incotermslocation2.
      ls_output-data-incov = ls_customer_salesarea-incotermsversion.
      ls_output-data-loevm = ls_customer_salesarea-deletionindicator.
      ls_output-data-zterm = ls_customer_salesarea-customerpaymentterms.
      ls_output-data-ktgrd = ls_customer_salesarea-customeraccountassignmentgroup.
      ls_output-data-kdgrp = ls_customer_salesarea-customergroup.
      ls_output-data-vwerk = ls_customer_salesarea-supplyingplant.
      ls_output-data-awahr = ls_customer_salesarea-itemorderprobabilityinpercent.
      ls_output-data-bzirk = ls_customer_salesarea-salesdistrict.  " Sales District field

      "datax
      ls_output-datax-aufsd = 'X'.
      ls_output-datax-lifsd = 'X'.
      ls_output-datax-faksd = 'X'.
      ls_output-datax-vkbur = 'X'.
      ls_output-datax-vkgrp = 'X'.
      ls_output-datax-eikto = 'X'.
      ls_output-datax-klabc = 'X'.
      ls_output-datax-waers = 'X'.
      ls_output-datax-konda = 'X'.
      ls_output-datax-kalks = 'X'.
      ls_output-datax-pltyp = 'X'.
      ls_output-datax-lprio = 'X'.
      ls_output-datax-vsbed = 'X'.
      ls_output-datax-kzazu = 'X'.
      ls_output-datax-autlf = 'X'.
      ls_output-datax-kztlf = 'X'.
      ls_output-datax-perfk = 'X'.
      ls_output-datax-inco1 = 'X'.
      ls_output-datax-inco2 = 'X'.
      ls_output-datax-begru = 'X'.
      ls_output-datax-inco2_l = 'X'.
      ls_output-datax-inco3_l = 'X'.
      ls_output-datax-incov = 'X'.
      ls_output-datax-loevm = 'X'.
      ls_output-datax-zterm = 'X'.
      ls_output-datax-ktgrd = 'X'.
      ls_output-datax-kdgrp = 'X'.
      ls_output-datax-vwerk = 'X'.
      ls_output-datax-awahr = 'X'.
      ls_output-datax-bzirk = 'X'.

      " code to set data and datax for extensibility fields

      FIELD-SYMBOLS: <ls_field_datax> TYPE any .
      DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
      DATA : lt_tables   TYPE abap_compdescr_tab.
      DATA : ls_tab   LIKE LINE OF lt_tables.

      ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_KNVV_X').
      lt_tables[] = ref_table_des->components[].

      LOOP AT lt_tables INTO ls_tab.
        ASSIGN COMPONENT ls_tab-name OF STRUCTURE  ls_output-datax TO <ls_field_datax>.
        IF <ls_field_datax> IS ASSIGNED.
          <ls_field_datax> = abap_true.
        ENDIF.
      ENDLOOP.


      DATA : lt_partfunc TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_custsalespartnerfunctype.
      lt_partfunc = ls_customer_salesarea-to_partnerfunction.

      "partnerfunction
      LOOP AT lt_partfunc INTO ls_customer_partnerfunc.

        IF iv_task ='I'.
          ls_output1-task = iv_task.
        ELSE.
          "determine update or delete
        ENDIF.

        "datakey
        ls_output1-data_key-parvw = ls_customer_partnerfunc-partnerfunction.
        ls_output1-data_key-parza = ls_customer_partnerfunc-partnercounter.

        "data
        ls_output1-data-defpa = ls_customer_partnerfunc-defaultpartner.
        ls_output1-data-knref = ls_customer_partnerfunc-customerpartnerdescription.


        IF ls_customer_partnerfunc-bpcustomernumber IS NOT INITIAL.
          ls_output1-data-partner = ls_customer_partnerfunc-bpcustomernumber.
        ELSE.
          IF iv_task = 'I' AND iv_customer IS NOT INITIAL.
            ls_output1-data-partner = iv_customer.
          ELSE.
            ls_output1-data-partner = cv_dummy_new_customer_number.
          ENDIF.
        ENDIF.

        "datax
        ls_output1-datax-defpa = 'X'.
        ls_output1-datax-knref = 'X'.
        ls_output1-datax-partner = 'X'.


        APPEND ls_output1 TO et_customer_sapartnerfunc.
        CLEAR ls_customer_partnerfunc.

      ENDLOOP.

      ls_output-functions-functions = et_customer_sapartnerfunc.
      CLEAR et_customer_sapartnerfunc.

      APPEND ls_output TO et_customer_salesarea.

      CLEAR ls_customer_salesarea.

    ENDLOOP.

  ENDMETHOD.


  METHOD fill_deep_supplier_companycode.

    DATA : lt_supplier_compcode      LIKE TABLE OF supplier_company_struc,
           ls_supplier_compcode      LIKE LINE OF lt_supplier_compcode,
           ls_supplier_compcode_data LIKE LINE OF et_supplier_companycode_data.

    DATA : lt_supplier_withtax      TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_supplierwithholdingtaxtyp,
           ls_supplier_withtax      LIKE LINE OF lt_supplier_withtax,
           et_supplier_withtax      TYPE vmds_ei_wtax_type_t,
           ls_supplier_withtax_data LIKE LINE OF et_supplier_withtax.

    lt_supplier_compcode = it_supplier_companycode_data.


    LOOP AT lt_supplier_compcode INTO ls_supplier_compcode.
      MOVE-CORRESPONDING ls_supplier_compcode TO ls_supplier_compcode_data-data EXPANDING NESTED TABLES.
      "Determine child task by has active entity
      IF ls_supplier_compcode-companycode IS INITIAL.
        ls_supplier_compcode_data-task = 'I'.
      ELSE.
        ls_supplier_compcode_data-task = iv_task.
      ENDIF.
      "datakey
      ls_supplier_compcode_data-data_key-bukrs = ls_supplier_compcode-companycode .
      "data
      ls_supplier_compcode_data-data-busab = ls_supplier_compcode-accountingclerk.
      ls_supplier_compcode_data-data-intad = ls_supplier_compcode-supplierclerkurl.
      ls_supplier_compcode_data-data-tlfns = ls_supplier_compcode-accountingclerkphonenumber.
      ls_supplier_compcode_data-data-tlfxs = ls_supplier_compcode-accountingclerkfaxnumber.
      ls_supplier_compcode_data-data-zsabe = ls_supplier_compcode-supplierclerk.
      ls_supplier_compcode_data-data-eikto = ls_supplier_compcode-supplierclerkidbysupplier.
      ls_supplier_compcode_data-data-xdezv = ls_supplier_compcode-istobelocallyprocessed.
      ls_supplier_compcode_data-data-kverm = ls_supplier_compcode-supplieraccountnote.
      ls_supplier_compcode_data-data-zterm = ls_supplier_compcode-paymentterms.
      ls_supplier_compcode_data-data-zwels = ls_supplier_compcode-paymentmethodslist.
      ls_supplier_compcode_data-data-zahls = ls_supplier_compcode-paymentblockingreason.
      ls_supplier_compcode_data-data-togru = ls_supplier_compcode-apartolerancegroup.
      ls_supplier_compcode_data-data-xpore = ls_supplier_compcode-itemistobepaidseparately.
      ls_supplier_compcode_data-data-xverr = ls_supplier_compcode-clearcustomersupplier.
      ls_supplier_compcode_data-data-xedip = ls_supplier_compcode-paymentistobesentbyedi.
      ls_supplier_compcode_data-data-lnrzb = ls_supplier_compcode-alternativepayee.
      ls_supplier_compcode_data-data-akont = ls_supplier_compcode-reconciliationaccount.
      ls_supplier_compcode_data-data-lnrze = ls_supplier_compcode-supplierheadoffice.
      ls_supplier_compcode_data-data-zuawa = ls_supplier_compcode-layoutsortingrule.
      ls_supplier_compcode_data-data-hbkid = ls_supplier_compcode-housebank.
      ls_supplier_compcode_data-data-sperr = ls_supplier_compcode-supplierisblockedforposting.
      ls_supplier_compcode_data-data-kultg = ls_supplier_compcode-checkpaiddurationindays.
      ls_supplier_compcode_data-data-cerdt = ls_supplier_compcode-suppliercertificationdate.
      ls_supplier_compcode_data-data-webtr = ls_supplier_compcode-billofexchlmtamtincocodecrcy.
      ls_supplier_compcode_data-data-begru = ls_supplier_compcode-authorizationgroup.
      "ls_supplier_compcode_data-data-cvp_xblck_b = ls_supplier_compcode-isbusinesspurposecompleted.
      ls_supplier_compcode_data-data-vzskz = ls_supplier_compcode-interestcalculationcode.
      ls_supplier_compcode_data-data-zindt = ls_supplier_compcode-interestcalculationdate.
      ls_supplier_compcode_data-data-zinrt = ls_supplier_compcode-intrstcalcfrequencyinmonths.
      ls_supplier_compcode_data-data-qland = ls_supplier_compcode-withholdingtaxcountry.
      ls_supplier_compcode_data-data-loevm = ls_supplier_compcode-deletionindicator.
      ls_supplier_compcode_data-data-fdgrv = ls_supplier_compcode-cashplanninggroup.
      ls_supplier_compcode_data-data-reprf = ls_supplier_compcode-istobecheckedforduplicates.

      ls_supplier_compcode_data-datax-busab = 'X'.
      ls_supplier_compcode_data-datax-intad = 'X'.
      ls_supplier_compcode_data-datax-tlfns = 'X'.
      ls_supplier_compcode_data-datax-tlfxs = 'X'.
      ls_supplier_compcode_data-datax-zsabe = 'X'.
      ls_supplier_compcode_data-datax-eikto = 'X'.
      ls_supplier_compcode_data-datax-xdezv = 'X'.
      ls_supplier_compcode_data-datax-kverm = 'X'.
      ls_supplier_compcode_data-datax-zterm = 'X'.
      ls_supplier_compcode_data-datax-zwels = 'X'.
      ls_supplier_compcode_data-datax-zahls = 'X'.
      ls_supplier_compcode_data-datax-togru = 'X'.
      ls_supplier_compcode_data-datax-xpore = 'X'.
      ls_supplier_compcode_data-datax-xverr = 'X'.
      ls_supplier_compcode_data-datax-xedip = 'X'.
      ls_supplier_compcode_data-datax-lnrzb = 'X'.
      ls_supplier_compcode_data-datax-akont = 'X'.
      ls_supplier_compcode_data-datax-lnrze = 'X'.
      ls_supplier_compcode_data-datax-zuawa = 'X'.
      ls_supplier_compcode_data-datax-hbkid = 'X'.
      ls_supplier_compcode_data-datax-sperr = 'X'.
      ls_supplier_compcode_data-datax-kultg = 'X'.
      ls_supplier_compcode_data-datax-cerdt = 'X'.
      ls_supplier_compcode_data-datax-webtr = 'X'.
      ls_supplier_compcode_data-datax-begru = 'X'.
      ls_supplier_compcode_data-datax-vzskz = 'X'.
      ls_supplier_compcode_data-datax-zindt = 'X'.
      ls_supplier_compcode_data-datax-zinrt = 'X'.
      ls_supplier_compcode_data-datax-qland = 'X'.
      ls_supplier_compcode_data-datax-loevm = 'X'.
      ls_supplier_compcode_data-datax-fdgrv = 'X'.
      ls_supplier_compcode_data-datax-reprf = 'X'.

      " code to set datax for extensibility fields
      DATA   ref_table_des             TYPE REF TO cl_abap_structdescr.
      DATA   lt_tables                 TYPE abap_compdescr_tab.
      DATA   ls_tab                    LIKE LINE OF lt_tables.
      FIELD-SYMBOLS: <ls_field_datax>  TYPE any .
      ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_LFB1_X').
      lt_tables[] = ref_table_des->components[].

      LOOP AT lt_tables INTO ls_tab.
        ASSIGN COMPONENT ls_tab-name OF STRUCTURE ls_supplier_compcode_data-datax TO <ls_field_datax>.
        IF <ls_field_datax> IS ASSIGNED.
          <ls_field_datax> = abap_true.
        ENDIF.

      ENDLOOP.


      "supplier dunning
      DATA : lt_data1            TYPE vmds_ei_dunning_t,
             ls_data1            LIKE LINE OF lt_data1,
             lt_supplier_dunning TYPE TABLE OF cl_api_business_partne_mpc=>ts_a_supplierdunningtype,
             ls_supplier_dunning LIKE LINE OF lt_supplier_dunning.

      lt_supplier_dunning = ls_supplier_compcode-to_supplierdunning.

      LOOP AT lt_supplier_dunning INTO ls_supplier_dunning.
        IF iv_task = 'I'.
          ls_data1-task = iv_task.
        ELSE.
          "determine update or delete
        ENDIF.
        ls_data1-data_key-maber = ls_supplier_dunning-dunningarea.
        ls_data1-data-busab = ls_supplier_dunning-dunningclerk.
        ls_data1-data-mahna = ls_supplier_dunning-dunningprocedure.
        ls_data1-data-mansp = ls_supplier_dunning-dunningblock.
        ls_data1-data-madat = ls_supplier_dunning-lastdunnedon.
        ls_data1-data-mahns = ls_supplier_dunning-dunninglevel.
        ls_data1-data-lfrma = ls_supplier_dunning-dunningrecipient.
        ls_data1-data-gmvdt = ls_supplier_dunning-legdunningprocedureon.

        ls_data1-datax-mahna = 'X'.
        ls_data1-datax-busab = 'X'.
        ls_data1-datax-mansp = 'X'.
        ls_data1-datax-madat = 'X'.
        ls_data1-datax-mahns = 'X'.
        ls_data1-datax-lfrma = 'X'.
        ls_data1-datax-gmvdt = 'X'.

        APPEND ls_data1 TO lt_data1.
        CLEAR ls_supplier_dunning.

      ENDLOOP.


      ls_supplier_compcode_data-dunning-dunning = lt_data1.
      CLEAR lt_data1.

      "end of dunning .


      "withholding tax
      lt_supplier_withtax = ls_supplier_compcode-to_supplierwithholdingtax.

      LOOP AT lt_supplier_withtax INTO ls_supplier_withtax ."where parent_key = ls_supplier_compcode-key.

        IF ls_supplier_withtax-withholdingtaxtype IS INITIAL.
          ls_supplier_withtax_data-task = 'I'.
        ELSE.
          ls_supplier_withtax_data-task = iv_task.
        ENDIF.

        "datakey
        ls_supplier_withtax_data-data_key-witht = ls_supplier_withtax-withholdingtaxtype .

        "data
        ls_supplier_withtax_data-data-wt_subjct = ls_supplier_withtax-iswithholdingtaxsubject.
        ls_supplier_withtax_data-data-qsrec = ls_supplier_withtax-recipienttype.
        ls_supplier_withtax_data-data-wt_wtstcd = ls_supplier_withtax-withholdingtaxnumber.
        ls_supplier_withtax_data-data-wt_withcd = ls_supplier_withtax-withholdingtaxcode.
        ls_supplier_withtax_data-data-wt_exnr = ls_supplier_withtax-withholdingtaxcertificate.
        ls_supplier_withtax_data-data-wt_exrt = ls_supplier_withtax-withholdingtaxexmptpercent.
        ls_supplier_withtax_data-data-wt_exdf = ls_supplier_withtax-exemptiondatebegin.
        ls_supplier_withtax_data-data-wt_exdt = ls_supplier_withtax-exemptiondateend.
        ls_supplier_withtax_data-data-wt_wtexrs = ls_supplier_withtax-exemptionreason.

        "datax
        ls_supplier_withtax_data-datax-wt_subjct = 'X'.
        ls_supplier_withtax_data-datax-qsrec = 'X'.
        ls_supplier_withtax_data-datax-wt_wtstcd = 'X'.
        ls_supplier_withtax_data-datax-wt_withcd = 'X'.
        ls_supplier_withtax_data-datax-wt_exnr = 'X'.
        ls_supplier_withtax_data-datax-wt_exrt = 'X'.
        ls_supplier_withtax_data-datax-wt_exdf = 'X'.
        ls_supplier_withtax_data-datax-wt_exdt = 'X'.
        ls_supplier_withtax_data-datax-wt_wtexrs = 'X'.

        APPEND ls_supplier_withtax_data TO et_supplier_withtax.

        CLEAR ls_supplier_withtax.

      ENDLOOP.

      ls_supplier_compcode_data-wtax_type-wtax_type = et_supplier_withtax.
      CLEAR et_supplier_withtax.


      APPEND ls_supplier_compcode_data TO et_supplier_companycode_data.
      CLEAR ls_supplier_compcode_data.

    ENDLOOP.

  ENDMETHOD.


  METHOD fill_deep_supplier_purchase.

    DATA   lt_supplier_purchase LIKE TABLE OF  supplier_purchasing_struc.
    DATA   ls_supplier_purchase LIKE LINE OF lt_supplier_purchase.
    DATA   ls_purg_org_data     LIKE LINE OF et_supplier_purchase_data.
*    data   ls_bp_root           like line of it_bp_root.
    DATA   lt_partner_fn        TYPE vmds_ei_functions_t.
    DATA   ls_partner_fn        LIKE LINE OF lt_partner_fn.

    DATA   ls_purgorg_old_data  LIKE ls_purg_org_data-data.

    CONSTANTS cv_dummy_new_supplier_number TYPE lifnr VALUE '##'.

    lt_supplier_purchase = it_supplier_purchase_data.

    LOOP AT lt_supplier_purchase INTO ls_supplier_purchase.
      MOVE-CORRESPONDING ls_supplier_purchase TO ls_purg_org_data-data EXPANDING NESTED TABLES.

      ls_purg_org_data-task = iv_task.

      "datakey
      ls_purg_org_data-data_key-ekorg = ls_supplier_purchase-purchasingorganization.
      "data
      ls_purg_org_data-data-minbw = ls_supplier_purchase-minimumorderamount.
      ls_purg_org_data-data-waers = ls_supplier_purchase-purchaseordercurrency.
      ls_purg_org_data-data-sperm = ls_supplier_purchase-purchasingisblockedforsupplier.
      ls_purg_org_data-data-kalsk = ls_supplier_purchase-calculationschemagroupcode.
      ls_purg_org_data-data-zterm = ls_supplier_purchase-paymentterms.
      ls_purg_org_data-data-meprf = ls_supplier_purchase-pricingdatecontrol.
      ls_purg_org_data-data-verkf = ls_supplier_purchase-supplierrespsalespersonname.
      ls_purg_org_data-data-telf1 = ls_supplier_purchase-supplierphonenumber.
      ls_purg_org_data-data-lfabc = ls_supplier_purchase-supplierabcclassificationcode.
      ls_purg_org_data-data-webre = ls_supplier_purchase-invoiceisgoodsreceiptbased.
      ls_purg_org_data-data-ekgrp = ls_supplier_purchase-purchasinggroup.
      ls_purg_org_data-data-plifz = ls_supplier_purchase-materialplanneddeliverydurn.
      ls_purg_org_data-data-kzaut = ls_supplier_purchase-purordautogenerationisallowed.
      ls_purg_org_data-data-vsbed = ls_supplier_purchase-shippingcondition.
      ls_purg_org_data-data-loevm = ls_supplier_purchase-deletionindicator.
      ls_purg_org_data-data-inco1 = ls_supplier_purchase-incotermsclassification.
      ls_purg_org_data-data-inco2 = ls_supplier_purchase-incotermstransferlocation.
      ls_purg_org_data-data-incov = ls_supplier_purchase-incotermsversion.
      ls_purg_org_data-data-inco2_l = ls_supplier_purchase-incotermslocation1.
      ls_purg_org_data-data-inco3_l = ls_supplier_purchase-incotermslocation2.

      "DATAX
      ls_purg_org_data-datax-minbw = 'X'.
      ls_purg_org_data-datax-waers = 'X'.
      ls_purg_org_data-datax-sperm = 'X'.
      ls_purg_org_data-datax-kalsk = 'X'.
      ls_purg_org_data-datax-zterm = 'X'.
      ls_purg_org_data-datax-meprf = 'X'.
      ls_purg_org_data-datax-verkf = 'X'.
      ls_purg_org_data-datax-telf1 = 'X'.
      ls_purg_org_data-datax-lfabc = 'X'.
      ls_purg_org_data-datax-webre = 'X'.
      ls_purg_org_data-datax-ekgrp = 'X'.
      ls_purg_org_data-datax-plifz = 'X'.
      ls_purg_org_data-datax-kzaut = 'X'.
      ls_purg_org_data-datax-vsbed = 'X'.
      ls_purg_org_data-datax-loevm = 'X'.
      ls_purg_org_data-datax-inco1 = 'X'.
      ls_purg_org_data-datax-inco2 = 'X'.
      ls_purg_org_data-datax-incov = 'X'.
      ls_purg_org_data-datax-inco2_l = 'X'.
      ls_purg_org_data-datax-inco3_l = 'X'.

      " code to set datax for extensibility fields
      FIELD-SYMBOLS: <ls_field_datax> TYPE any .
      DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
      DATA : lt_tables   TYPE abap_compdescr_tab.
      DATA : ls_tab   LIKE LINE OF lt_tables.
      DATA   lt_comp_tables       TYPE abap_compdescr_tab.

      ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_LFM1_X').
      lt_comp_tables[] = ref_table_des->components[].

      LOOP AT lt_comp_tables INTO ls_tab.
        ASSIGN COMPONENT ls_tab-name OF STRUCTURE ls_purg_org_data-datax TO <ls_field_datax>.
        IF <ls_field_datax> IS ASSIGNED.
          <ls_field_datax> = abap_true.
        ENDIF.

      ENDLOOP.


      DATA(lt_supplier_function) = ls_supplier_purchase-to_partnerfunction.

      LOOP AT lt_supplier_function INTO DATA(ls_supplier_function).


        "TASK
        ls_partner_fn-task = iv_task.
        "data_key
        ls_partner_fn-data_key-werks = ''.
        ls_partner_fn-data_key-ltsnr = ''.
        ls_partner_fn-data_key-parvw = ls_supplier_function-partnerfunction.
        ls_partner_fn-data_key-parza = ls_supplier_function-partnercounter.

        ls_partner_fn-data-defpa = ls_supplier_function-defaultpartner.

        IF ls_supplier_function-referencesupplier IS NOT INITIAL.
          ls_partner_fn-data-partner = ls_supplier_function-referencesupplier.
        ELSE.
          IF iv_task = 'I' AND iv_supplier IS NOT INITIAL.
            ls_partner_fn-data-partner = iv_supplier.
          ELSE.
            ls_partner_fn-data-partner = cv_dummy_new_supplier_number.
          ENDIF.
        ENDIF.

        ls_partner_fn-datax-defpa = 'X'.
        ls_partner_fn-datax-partner = 'X'.
        .
        APPEND ls_partner_fn TO lt_partner_fn.
        CLEAR ls_supplier_function.

      ENDLOOP.

      ls_purg_org_data-functions-functions = lt_partner_fn.
      CLEAR lt_partner_fn.

      APPEND ls_purg_org_data TO et_supplier_purchase_data.
      CLEAR ls_purg_org_data.
    ENDLOOP.

  ENDMETHOD.


  METHOD fill_salesarea_tax_data.

    DATA :ls_partner_tax LIKE is_sales_tax,
          ls_output      LIKE es_sales_tax.

    ls_partner_tax = is_sales_tax.

    "task
    ls_output-task = iv_task.

    "datakey
    ls_output-data_key-aland = ls_partner_tax-departurecountry.
    ls_output-data_key-tatyp = ls_partner_tax-customertaxcategory.

    "data
    ls_output-data-taxkd = ls_partner_tax-customertaxclassification.

    "datax
    ls_output-datax-taxkd = 'X'.

    es_sales_tax = ls_output.


  ENDMETHOD.


  METHOD fill_supplier_companycode_data.

    DATA : ls_supplier_compcode LIKE is_company_data,
           ls_output            LIKE es_company_data.

    ls_supplier_compcode = is_company_data.

    MOVE-CORRESPONDING ls_supplier_compcode TO ls_output-data EXPANDING NESTED TABLES.

    ls_output-task = iv_task.
    "datakey
    ls_output-data_key-bukrs = ls_supplier_compcode-companycode.

    "data
    ls_output-data-busab = ls_supplier_compcode-accountingclerk.
    ls_output-data-intad = ls_supplier_compcode-supplierclerkurl.
    ls_output-data-tlfns = ls_supplier_compcode-accountingclerkphonenumber.
    ls_output-data-tlfxs = ls_supplier_compcode-accountingclerkfaxnumber.
    ls_output-data-zsabe = ls_supplier_compcode-supplierclerk.
    ls_output-data-eikto = ls_supplier_compcode-supplierclerkidbysupplier.
    ls_output-data-xdezv = ls_supplier_compcode-istobelocallyprocessed.
    ls_output-data-kverm = ls_supplier_compcode-supplieraccountnote.
    ls_output-data-zterm = ls_supplier_compcode-paymentterms.
    ls_output-data-zwels = ls_supplier_compcode-paymentmethodslist.
    ls_output-data-zahls = ls_supplier_compcode-paymentblockingreason.
    ls_output-data-togru = ls_supplier_compcode-apartolerancegroup.
    ls_output-data-xpore = ls_supplier_compcode-itemistobepaidseparately.
    ls_output-data-xverr = ls_supplier_compcode-clearcustomersupplier.
    ls_output-data-xedip = ls_supplier_compcode-paymentistobesentbyedi.
    ls_output-data-lnrzb = ls_supplier_compcode-alternativepayee.
    ls_output-data-akont = ls_supplier_compcode-reconciliationaccount.
    ls_output-data-lnrze = ls_supplier_compcode-supplierheadoffice.
    ls_output-data-zuawa = ls_supplier_compcode-layoutsortingrule.
    ls_output-data-hbkid = ls_supplier_compcode-housebank.
    ls_output-data-sperr = ls_supplier_compcode-supplierisblockedforposting.
    ls_output-data-kultg = ls_supplier_compcode-checkpaiddurationindays.
    ls_output-data-cerdt = ls_supplier_compcode-suppliercertificationdate.
    ls_output-data-webtr = ls_supplier_compcode-billofexchlmtamtincocodecrcy.
    ls_output-data-begru = ls_supplier_compcode-authorizationgroup.
    ls_output-data-vzskz = ls_supplier_compcode-interestcalculationcode.
    ls_output-data-zindt = ls_supplier_compcode-interestcalculationdate.
    ls_output-data-zinrt = ls_supplier_compcode-intrstcalcfrequencyinmonths.
    ls_output-data-qland = ls_supplier_compcode-withholdingtaxcountry.
    ls_output-data-loevm = ls_supplier_compcode-deletionindicator.
    ls_output-data-fdgrv = ls_supplier_compcode-cashplanninggroup.
    ls_output-data-reprf = ls_supplier_compcode-istobecheckedforduplicates.

    "data
    ls_output-datax-busab = 'X'.
    ls_output-datax-intad = 'X'.
    ls_output-datax-tlfns = 'X'.
    ls_output-datax-tlfxs = 'X'.
    ls_output-datax-zsabe = 'X'.
    ls_output-datax-eikto = 'X'.
    ls_output-datax-xdezv = 'X'.
    ls_output-datax-kverm = 'X'.
    ls_output-datax-zterm = 'X'.
    ls_output-datax-zwels = 'X'.
    ls_output-datax-zahls = 'X'.
    ls_output-datax-togru = 'X'.
    ls_output-datax-xpore = 'X'.
    ls_output-datax-xverr = 'X'.
    ls_output-datax-xedip = 'X'.
    ls_output-datax-lnrzb = 'X'.
    ls_output-datax-akont = 'X'.
    ls_output-datax-lnrze = 'X'.
    ls_output-datax-zuawa = 'X'.
    ls_output-datax-hbkid = 'X'.
    ls_output-datax-sperr = 'X'.
    ls_output-datax-kultg = 'X'.
    ls_output-datax-cerdt = 'X'.
    ls_output-datax-webtr = 'X'.
    ls_output-datax-begru = 'X'.
    ls_output-datax-vzskz = 'X'.
    ls_output-datax-zindt = 'X'.
    ls_output-datax-zinrt = 'X'.
    ls_output-datax-qland = 'X'.
    ls_output-datax-loevm = 'X'.
    ls_output-datax-fdgrv = 'X'.
    ls_output-datax-reprf = 'X'.

    " code to set datax for extensibility fields
    DATA   ref_table_des             TYPE REF TO cl_abap_structdescr.
    DATA   lt_tables                 TYPE abap_compdescr_tab.
    DATA   ls_tab                    LIKE LINE OF lt_tables.
    FIELD-SYMBOLS: <ls_field_datax>  TYPE any .
    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_LFB1_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE ls_output-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.

    ENDLOOP.

    es_company_data = ls_output.


  ENDMETHOD.


  METHOD fill_supplier_dunning_data.

    DATA: ls_data1            LIKE es_supplier_dunning,
          ls_supplier_dunning LIKE is_supplier_dunning.

    ls_supplier_dunning = is_supplier_dunning.

    "task
    ls_data1-task = iv_task.

    "data_key
    ls_data1-data_key-maber = ls_supplier_dunning-dunningarea.

    "data
    ls_data1-data-mahna = ls_supplier_dunning-dunningprocedure.
    ls_data1-data-mansp = ls_supplier_dunning-dunningblock.
    ls_data1-data-madat = ls_supplier_dunning-lastdunnedon.
    ls_data1-data-mahns = ls_supplier_dunning-dunninglevel.
    ls_data1-data-lfrma = ls_supplier_dunning-dunningrecipient.
    ls_data1-data-gmvdt = ls_supplier_dunning-legdunningprocedureon.
    ls_data1-data-busab = ls_supplier_dunning-dunningclerk.

    "datax
    ls_data1-datax-mahna = 'X'.
    ls_data1-datax-mansp = 'X'.
    ls_data1-datax-madat = 'X'.
    ls_data1-datax-mahns = 'X'.
    ls_data1-datax-lfrma = 'X'.
    ls_data1-datax-gmvdt = 'X'.
    ls_data1-datax-busab = 'X'.

    es_supplier_dunning = ls_data1.


  ENDMETHOD.


  METHOD fill_supplier_general_data.

    DATA : ls_supplier_gen TYPE cl_api_business_partne_mpc_ext=>ts_a_suppliertype.

    ls_supplier_gen = is_supplier_data.

    MOVE-CORRESPONDING ls_supplier_gen TO gs_data-vendor-central_data-central-data EXPANDING NESTED TABLES.

    gs_data-vendor-header-object_task = iv_task.
*    gs_data-vendor-header-object_instance-lifnr = ls_supplier_gen-supplier."ls_bp_root-businesspartner.
    gs_data-vendor-header-object_instance-lifnr = ''."ls_bp_root-businesspartner.

    SELECT SINGLE nrrng FROM tb001 INTO @DATA(lv_nr) WHERE bu_group = @gv_bp_grouping.

    IF sy-subrc = 0.
      SELECT SINGLE externind FROM nriv INTO @DATA(lv_external) WHERE object = 'BU_PARTNER' AND nrrangenr = @lv_nr.
    ENDIF.

    IF lv_external IS NOT INITIAL.
      gs_data-vendor-header-object_instance-lifnr = gv_partner.
    ENDIF.

    " In case of flexible Account Group, Acc Grp value should come from UI.
    IF ls_supplier_gen-supplieraccountgroup IS NOT INITIAL.
      gs_data-vendor-central_data-central-data-ktokk = ls_supplier_gen-supplieraccountgroup.
      "else get it from customization
    ELSE.
      SELECT SINGLE ktokk FROM tbc001 INTO gs_data-vendor-central_data-central-data-ktokk WHERE  bu_group EQ gv_bp_grouping .
    ENDIF.

    "data
    gs_data-vendor-central_data-central-data-bbbnr = ls_supplier_gen-internationallocationnumber1.
    gs_data-vendor-central_data-central-data-bbsnr = ls_supplier_gen-internationallocationnumber2.
    gs_data-vendor-central_data-central-data-bubkz = ls_supplier_gen-internationallocationnumber3.
    gs_data-vendor-central_data-central-data-lnrza = ls_supplier_gen-alternativepayeeaccountnumber.
    gs_data-vendor-central_data-central-data-kunnr = ls_supplier_gen-customer.
    gs_data-vendor-central_data-central-data-sperr = ls_supplier_gen-postingisblocked.
    gs_data-vendor-central_data-central-data-gbdat = ls_supplier_gen-birthdate.
    gs_data-vendor-central_data-central-data-loevm = ls_supplier_gen-deletionindicator.
    gs_data-vendor-central_data-central-data-fiskn = ls_supplier_gen-fiscaladdress.
*    gs_data-vendor-central_data-central-data-brsch = ls_supplier_gen-industry.
    gs_data-vendor-central_data-central-data-sperm = ls_supplier_gen-purchasingisblocked.
    gs_data-vendor-central_data-central-data-sperz = ls_supplier_gen-paymentisblockedforsupplier.
    gs_data-vendor-central_data-central-data-stceg = ls_supplier_gen-vatregistration.
    gs_data-vendor-central_data-central-data-begru = ls_supplier_gen-authorizationgroup.
    gs_data-vendor-central_data-central-data-stkzn = ls_supplier_gen-isnaturalperson.
    gs_data-vendor-central_data-central-data-fityp = ls_supplier_gen-responsibletype.
    gs_data-vendor-central_data-central-data-stenr = ls_supplier_gen-taxnumberresponsible.
    gs_data-vendor-central_data-central-data-stcdt = ls_supplier_gen-taxnumbertype.
*    gs_data-vendor-central_data-central-data-stcd1 = ls_supplier_gen-taxnumber1.
*    gs_data-vendor-central_data-central-data-stcd2 = ls_supplier_gen-taxnumber2.
*    gs_data-vendor-central_data-central-data-stcd3 = ls_supplier_gen-taxnumber3.
*    gs_data-vendor-central_data-central-data-stcd4 = ls_supplier_gen-taxnumber4.
*    gs_data-vendor-central_data-central-data-stcd5 = ls_supplier_gen-taxnumber5.
    gs_data-vendor-central_data-central-data-qssysdat = ls_supplier_gen-suplrqltyinprocmtcertfnvalidto.
    gs_data-vendor-central_data-central-data-qssys = ls_supplier_gen-suplrqualitymanagementsystem.
    gs_data-vendor-central_data-central-data-konzs = ls_supplier_gen-suppliercorporategroup.
    gs_data-vendor-central_data-central-data-sperq = ls_supplier_gen-supplierprocurementblock.

    "datax
    gs_data-vendor-central_data-central-datax-bbbnr = 'X'.
    gs_data-vendor-central_data-central-datax-bbsnr = 'X'.
    gs_data-vendor-central_data-central-datax-bubkz = 'X'.
    gs_data-vendor-central_data-central-datax-lnrza = 'X'.
    gs_data-vendor-central_data-central-datax-kunnr = 'X'.
    gs_data-vendor-central_data-central-datax-sperr = 'X'.
    gs_data-vendor-central_data-central-datax-gbdat = 'X'.
    gs_data-vendor-central_data-central-datax-loevm = 'X'.
    gs_data-vendor-central_data-central-datax-fiskn = 'X'.
*    gs_data-vendor-central_data-central-datax-brsch = 'X'.
    gs_data-vendor-central_data-central-datax-sperm = 'X'.
    gs_data-vendor-central_data-central-datax-sperz = 'X'.
    gs_data-vendor-central_data-central-datax-stceg = 'X'.
    gs_data-vendor-central_data-central-datax-begru = 'X'.
    gs_data-vendor-central_data-central-datax-stkzn = 'X'.
    gs_data-vendor-central_data-central-datax-fityp = 'X'.
    gs_data-vendor-central_data-central-datax-stenr = 'X'.
    gs_data-vendor-central_data-central-datax-stcdt = 'X'.
*    gs_data-vendor-central_data-central-datax-stcd1 = 'X'.
*    gs_data-vendor-central_data-central-datax-stcd2 = 'X'.
*    gs_data-vendor-central_data-central-datax-stcd3 = 'X'.
*    gs_data-vendor-central_data-central-datax-stcd4 = 'X'.
*    gs_data-vendor-central_data-central-datax-stcd5 = 'X'.
    gs_data-vendor-central_data-central-datax-qssysdat = 'X'.
    gs_data-vendor-central_data-central-datax-qssys = 'X'.
    gs_data-vendor-central_data-central-datax-konzs = 'X'.
    gs_data-vendor-central_data-central-datax-sperq = 'X'.

    " code to set data and datax for extensibility fields
    FIELD-SYMBOLS: <ls_field_datax> TYPE any .
    DATA :   ref_table_des     TYPE REF TO cl_abap_structdescr.
    DATA : lt_tables   TYPE abap_compdescr_tab.
    DATA : ls_tab   LIKE LINE OF lt_tables.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_LFA1_X').
    lt_tables[] = ref_table_des->components[].

    LOOP AT lt_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE gs_data-vendor-central_data-central-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.


  METHOD fill_supplier_partner_func.

    DATA : ls_partner_fn        LIKE es_supplier_function,
           ls_supplier_function LIKE is_supplier_function.
    CONSTANTS cv_dummy_new_supplier_number TYPE lifnr VALUE '##'.

    ls_supplier_function = is_supplier_function.

    "task
    ls_partner_fn-task = iv_task.

    "data_key
    ls_partner_fn-data_key-werks = ''.
    ls_partner_fn-data_key-ltsnr = ''.
    ls_partner_fn-data_key-parvw = ls_supplier_function-partnerfunction.
    ls_partner_fn-data_key-parza = ls_supplier_function-partnercounter.
    ls_partner_fn-data-defpa = ls_supplier_function-defaultpartner.

    IF ls_supplier_function-referencesupplier IS NOT INITIAL.
      ls_partner_fn-data-partner = ls_supplier_function-referencesupplier.
    ELSE.
      IF iv_task = 'I' AND iv_supplier IS NOT INITIAL.
        ls_partner_fn-data-partner = iv_supplier.
      ELSE.
        ls_partner_fn-data-partner = cv_dummy_new_supplier_number.
      ENDIF.

    ENDIF.

    ls_partner_fn-datax-defpa = 'X'.
    ls_partner_fn-datax-partner = 'X'.

    es_supplier_function = ls_partner_fn.


  ENDMETHOD.


  METHOD fill_supplier_purchase_data.

    DATA : ls_purg_org_data     LIKE es_purchase_data,
           ls_supplier_purchase LIKE is_purchase_data.

    ls_supplier_purchase = is_purchase_data.

    MOVE-CORRESPONDING ls_supplier_purchase TO ls_purg_org_data-data EXPANDING NESTED TABLES.

    ls_purg_org_data-task = iv_task.

    "datakey
    ls_purg_org_data-data_key-ekorg = ls_supplier_purchase-purchasingorganization.
    "data
    ls_purg_org_data-data-minbw = ls_supplier_purchase-minimumorderamount.
    ls_purg_org_data-data-waers = ls_supplier_purchase-purchaseordercurrency.
    ls_purg_org_data-data-sperm = ls_supplier_purchase-purchasingisblockedforsupplier.
    ls_purg_org_data-data-kalsk = ls_supplier_purchase-calculationschemagroupcode.
    ls_purg_org_data-data-zterm = ls_supplier_purchase-paymentterms.
    ls_purg_org_data-data-meprf = ls_supplier_purchase-pricingdatecontrol.
    ls_purg_org_data-data-verkf = ls_supplier_purchase-supplierrespsalespersonname.
    ls_purg_org_data-data-telf1 = ls_supplier_purchase-supplierphonenumber.
    ls_purg_org_data-data-lfabc = ls_supplier_purchase-supplierabcclassificationcode.
    ls_purg_org_data-data-webre = ls_supplier_purchase-invoiceisgoodsreceiptbased.
    ls_purg_org_data-data-ekgrp = ls_supplier_purchase-purchasinggroup.
    ls_purg_org_data-data-plifz = ls_supplier_purchase-materialplanneddeliverydurn.
    ls_purg_org_data-data-kzaut = ls_supplier_purchase-purordautogenerationisallowed.
    ls_purg_org_data-data-vsbed = ls_supplier_purchase-shippingcondition.
    ls_purg_org_data-data-loevm = ls_supplier_purchase-deletionindicator.
    ls_purg_org_data-data-inco1 = ls_supplier_purchase-incotermsclassification.
    ls_purg_org_data-data-inco2 = ls_supplier_purchase-incotermstransferlocation.
    ls_purg_org_data-data-incov = ls_supplier_purchase-incotermsversion.
    ls_purg_org_data-data-inco2_l = ls_supplier_purchase-incotermslocation1.
    ls_purg_org_data-data-inco3_l = ls_supplier_purchase-incotermslocation2.
    "datax
    ls_purg_org_data-datax-minbw = 'X'.
    ls_purg_org_data-datax-waers = 'X'.
    ls_purg_org_data-datax-sperm = 'X'.
    ls_purg_org_data-datax-kalsk = 'X'.
    ls_purg_org_data-datax-zterm = 'X'.
    ls_purg_org_data-datax-meprf = 'X'.
    ls_purg_org_data-datax-verkf = 'X'.
    ls_purg_org_data-datax-telf1 = 'X'.
    ls_purg_org_data-datax-lfabc = 'X'.
    ls_purg_org_data-datax-webre = 'X'.
    ls_purg_org_data-datax-ekgrp = 'X'.
    ls_purg_org_data-datax-plifz = 'X'.
    ls_purg_org_data-datax-kzaut = 'X'.
    ls_purg_org_data-datax-vsbed = 'X'.
    ls_purg_org_data-datax-loevm = 'X'.
    ls_purg_org_data-datax-inco1 = 'X'.
    ls_purg_org_data-datax-inco2 = 'X'.
    ls_purg_org_data-datax-incov = 'X'.
    ls_purg_org_data-datax-inco2_l = 'X'.
    ls_purg_org_data-datax-inco3_l = 'X'.

    " code to set datax for extensibility fields
    DATA   ref_table_des        TYPE REF TO cl_abap_structdescr.
    DATA   lt_comp_tables       TYPE abap_compdescr_tab.
    DATA   ls_tab               LIKE LINE OF lt_comp_tables.
    FIELD-SYMBOLS: <ls_field_datax> TYPE any.

    ref_table_des ?= cl_abap_typedescr=>describe_by_name('INCL_EEW_LFM1_X').
    lt_comp_tables[] = ref_table_des->components[].

    LOOP AT lt_comp_tables INTO ls_tab.
      ASSIGN COMPONENT ls_tab-name OF STRUCTURE ls_purg_org_data-datax TO <ls_field_datax>.
      IF <ls_field_datax> IS ASSIGNED.
        <ls_field_datax> = abap_true.
      ENDIF.

    ENDLOOP.

    es_purchase_data = ls_purg_org_data.

  ENDMETHOD.


  METHOD fill_supplier_wtax_data.

    DATA : ls_supplier_withtax_data LIKE es_supplier_wtax,
           ls_supplier_withtax      LIKE is_supplier_wtax.

    ls_supplier_withtax = is_supplier_wtax.

    "task
    ls_supplier_withtax_data-task = iv_task.

    "datakey
    ls_supplier_withtax_data-data_key-witht = ls_supplier_withtax-withholdingtaxtype .

    "data
    ls_supplier_withtax_data-data-wt_subjct = ls_supplier_withtax-iswithholdingtaxsubject.
    ls_supplier_withtax_data-data-qsrec = ls_supplier_withtax-recipienttype.
    ls_supplier_withtax_data-data-wt_wtstcd = ls_supplier_withtax-withholdingtaxnumber.
    ls_supplier_withtax_data-data-wt_withcd = ls_supplier_withtax-withholdingtaxcode.
    ls_supplier_withtax_data-data-wt_exnr = ls_supplier_withtax-withholdingtaxcertificate.
    ls_supplier_withtax_data-data-wt_exrt = ls_supplier_withtax-withholdingtaxexmptpercent.
    ls_supplier_withtax_data-data-wt_exdf = ls_supplier_withtax-exemptiondatebegin.
    ls_supplier_withtax_data-data-wt_exdt = ls_supplier_withtax-exemptiondateend.
    ls_supplier_withtax_data-data-wt_wtexrs = ls_supplier_withtax-exemptionreason.

    "datax
    ls_supplier_withtax_data-datax-wt_subjct = 'X'.
    ls_supplier_withtax_data-datax-qsrec = 'X'.
    ls_supplier_withtax_data-datax-wt_wtstcd = 'X'.
    ls_supplier_withtax_data-datax-wt_withcd = 'X'.
    ls_supplier_withtax_data-datax-wt_exnr = 'X'.
    ls_supplier_withtax_data-datax-wt_exrt = 'X'.
    ls_supplier_withtax_data-datax-wt_exdf = 'X'.
    ls_supplier_withtax_data-datax-wt_exdt = 'X'.
    ls_supplier_withtax_data-datax-wt_wtexrs = 'X'.

    es_supplier_wtax = ls_supplier_withtax_data.

  ENDMETHOD.


  METHOD fill_taxnumber_data.

    DATA : ls_partner_taxnum TYPE  cl_api_business_partne_mpc=>ts_a_businesspartnertaxnumbert,
           ls_output         LIKE  es_partner_taxnum.

    ls_partner_taxnum = is_partner_taxnum.

    ls_output-task = iv_task.
    ls_output-data_key-taxnumber = ls_partner_taxnum-bptaxnumber.
    ls_output-data_key-taxtype = ls_partner_taxnum-bptaxtype.
    ls_output-data_key-taxnumxl = ls_partner_taxnum-bptaxlongnumber.

    es_partner_taxnum = ls_output.

  ENDMETHOD.


  METHOD get_bp_data.

* Data for relationship
    TYPES:
      BEGIN OF ty_relationship,
        partner1   TYPE  bu_partner,
        partner2   TYPE  bu_partner,
        date_to    TYPE bu_datto,
        date_from  TYPE bu_datfrom,
        reltyp     TYPE bu_reltyp,
        dftval     TYPE  bu_dftval,
        relkind    TYPE  bu_relkind,
        xdirection TYPE  bu_xdirect,
      END OF ty_relationship.

    DATA:
      lt_relationship TYPE STANDARD TABLE OF ty_relationship.

* Data declaration
    DATA:
      lv_ad_tstamp    TYPE ad_tstamp,
      lv_string       TYPE string,
      ls_is_deep_type TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type.
    " Data declaration for creadit mangement
    DATA:
      ls_creditsegment               TYPE /simple/cl_mdg_gw_core_mpc=>ts_businesspartnercreditsegmen,
      ls_businesspartnerrelationship TYPE /simple/cl_mdg_gw_core_mpc=>ts_businesspartnerrelationship,
      lv_partner                     TYPE bu_partner,
      lt_all_accounts                TYPE  ukm_ts_acc_objs2,
      io_facade                      TYPE REF TO cl_ukm_facade,
      io_calculator                  TYPE REF TO if_ukm_calculator,
      io_partner                     TYPE REF TO cl_ukm_business_partner,
      io_bupa_factory                TYPE REF TO cl_ukm_bupa_factory,
      io_account                     TYPE REF TO cl_ukm_account,
      lw_bp_credit_sgm               TYPE ukm_s_bp_cms_sgm,
      lw_bp_cms                      TYPE ukm_s_bp_cms,
      lt_ukm_return                  TYPE ukm_t_monitor_return.


    " Data declaration for class
    TYPES:
      BEGIN OF ty_kssk,
        objek TYPE cuobn,
        klart TYPE klassenart,
      END OF ty_kssk.

    DATA:
      lv_object_type           TYPE  tcla-obtab,
      ls_classification        TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_classification,
      ls_characteristic        TYPE /simple/cl_mdg_gw_core_mpc=>ts_characteristic,
      lt_return                TYPE STANDARD TABLE OF  bapiret2,
      lt_alloclist             TYPE STANDARD TABLE OF  bapi1003_alloc_list,
      lv_objek                 TYPE cuobn,
      lt_kssk                  TYPE STANDARD TABLE OF ty_kssk,
      lv_num10(10)             TYPE n,
      objecttable_imp          TYPE  bapi1003_key-objecttable,
      classtype_imp            TYPE bapi1003_key-classtype,
      objectkey_imp            TYPE bapi1003_key-object,
      lt_charact_values        TYPE STANDARD TABLE OF  api_val_r,
      lt_object_identification TYPE STANDARD TABLE OF  api_ob_key,
      lv_object                TYPE  kssk-objek,
      lv_class_type            TYPE  kssk-klart,
      lv_class                 TYPE  klah-class.


* Start of getting data
    ls_is_deep_type = is_deep_type.
    CLEAR ls_is_deep_type-toclassification.

* Get classification data

    IF is_deep_type-objecttype = 'Customer'.
      objecttable_imp = 'KNA1'.
      lv_object_type = 'KNA1'.
    ELSEIF is_deep_type-objecttype = 'Vendor'.
      objecttable_imp = 'LFA1'.
      lv_object_type = 'LFA1'.
    ENDIF.


    lv_num10 = ls_is_deep_type-objectid.
    objectkey_imp = lv_num10.
    lv_objek = lv_num10.
    lv_partner = lv_num10.

    "-- Get Classification Data
    "-- Get Material Class Type
    SELECT objek,
           klart
      FROM kssk
      INTO TABLE @lt_kssk
      WHERE objek = @lv_objek.

    IF lt_kssk IS NOT INITIAL.
      SORT lt_kssk BY
        objek klart ASCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_kssk COMPARING
        objek klart.
    ENDIF.


    LOOP AT lt_kssk INTO DATA(ls_kssk).
      "-- Get Object Class
      classtype_imp = ls_kssk-klart.

      CALL FUNCTION 'BAPI_OBJCL_GETCLASSES'
        EXPORTING
          objectkey_imp   = objectkey_imp
          objecttable_imp = objecttable_imp
          classtype_imp   = classtype_imp
        TABLES
          alloclist       = lt_alloclist
          return          = lt_return.

      IF lt_alloclist IS NOT INITIAL.
        LOOP AT lt_alloclist INTO DATA(ls_alloclist).
          lv_object = ls_alloclist-object.
          lv_class_type = ls_alloclist-classtype.
          lv_class = ls_alloclist-classnum.

          CALL FUNCTION 'CACL_OBJECT_READ_VALIDATION'
            EXPORTING
              object                = lv_object
              object_type           = lv_object_type
              class_type            = lv_class_type
              class                 = lv_class
            TABLES
              charact_values        = lt_charact_values
              object_identification = lt_object_identification
            EXCEPTIONS
              error                 = 1
              warning               = 2
              OTHERS                = 3.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ENDIF.
          ls_classification-classtype = ls_alloclist-classtype.
          ls_classification-class = ls_alloclist-classnum.
          ls_classification-objecttable = ls_alloclist-objtyp.
          ls_classification-objectkey = ls_alloclist-object.
          IF lt_charact_values IS NOT INITIAL.
            LOOP AT lt_charact_values INTO DATA(ls_charact_values)
              WHERE val_assign = 'X' AND inherited = ''.
              ls_characteristic-charact    = ls_charact_values-charact.
              ls_characteristic-value      = ls_charact_values-value.
              ls_characteristic-class      = ls_classification-class.
              ls_characteristic-classtype  = ls_classification-classtype.
              APPEND ls_characteristic TO ls_classification-tocharacteristic.
            ENDLOOP.
          ENDIF.

          APPEND ls_classification TO ls_is_deep_type-toclassification.
          CLEAR ls_classification.
        ENDLOOP.
        CLEAR lt_alloclist.
      ENDIF.
    ENDLOOP.

    "-- Get credit management data
    " Logic is disabled on S4 but enabled on ECC. S4 class support credit management data.

*    io_facade = cl_ukm_facade=>create( i_activity = cl_ukm_cnst_eventing=>bp_maintenance ).
*    io_calculator = io_facade->get_calculator( ).
*    io_bupa_factory = io_facade->get_bupa_factory( ).
*
*    "read businee partner
*    io_partner = io_bupa_factory->get_business_partner( lv_partner ).
*
*    "Get credit profile
*    CALL METHOD io_partner->get_bp_cms
*      IMPORTING
*        es_bp_cms = lw_bp_cms.
*
*    IF lw_bp_cms IS NOT INITIAL.
*      ls_is_deep_type-tobusinesspartnercreditprofile-alternatebp = lw_bp_cms-alternate_bp.
*      ls_is_deep_type-tobusinesspartnercreditprofile-checkrule = lw_bp_cms-check_rule.
*      ls_is_deep_type-tobusinesspartnercreditprofile-creditgroup = lw_bp_cms-credit_group.
*      ls_is_deep_type-tobusinesspartnercreditprofile-limitrule = lw_bp_cms-limit_rule.
*      ls_is_deep_type-tobusinesspartnercreditprofile-ownrating = lw_bp_cms-own_rating.
*      ls_is_deep_type-tobusinesspartnercreditprofile-ownratingcalc = lw_bp_cms-own_rating_calc.
**      ls_is_deep_type-tobusinesspartnercreditprofile-ratingchangedate = lw_bp_cms-rating_chg_date.
*
*      CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*        EXPORTING
*          ip_start_date          = lw_bp_cms-rating_chg_date
*        IMPORTING
*          EP_START_DATE          = ls_is_deep_type-tobusinesspartnercreditprofile-ratingchangedate
*        EXCEPTIONS
*          CONVERSION_ERROR       = 1
*          OTHERS                 = 2.
*
**      ls_is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate = lw_bp_cms-risk_class_chgdt.
*
*      CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*        EXPORTING
*          ip_start_date          = lw_bp_cms-risk_class_chgdt
*        IMPORTING
*          EP_START_DATE          = ls_is_deep_type-tobusinesspartnercreditprofile-riskclasschangedate
*        EXCEPTIONS
*          CONVERSION_ERROR       = 1
*          OTHERS                 = 2.
*
**      ls_is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate = lw_bp_cms-rating_val_date.
*
*      CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*        EXPORTING
*          ip_start_date          = lw_bp_cms-rating_val_date
*        IMPORTING
*          EP_START_DATE          = ls_is_deep_type-tobusinesspartnercreditprofile-ratingvaluedate
*        EXCEPTIONS
*          CONVERSION_ERROR       = 1
*          OTHERS                 = 2.
*
*      ls_is_deep_type-tobusinesspartnercreditprofile-riskclass = lw_bp_cms-risk_class.
*      ls_is_deep_type-tobusinesspartnercreditprofile-riskclasscalc = lw_bp_cms-risk_class_calc.
*
*    ENDIF.
*
*    "Get all credit account
*    CALL METHOD io_bupa_factory->get_all_accounts
*      EXPORTING
*        i_partner       = lv_partner
*      RECEIVING
*        rt_all_accounts = lt_all_accounts.
*
*    IF lt_all_accounts IS NOT INITIAL.
*      LOOP AT lt_all_accounts INTO DATA(ls_account).
*        ls_account-credit_account->get_bp_cms_sgm( IMPORTING es_bp_cms_sgm = lw_bp_credit_sgm ).
*        ls_creditsegment-creditsegment = ls_account-credit_sgmnt.
*        ls_creditsegment-blockreason = lw_bp_credit_sgm-block_reason.
*        ls_creditsegment-coordinator = lw_bp_credit_sgm-coordinator.
*        ls_creditsegment-creditlimit = lw_bp_credit_sgm-credit_limit.
*        ls_creditsegment-creditlimitcal = lw_bp_credit_sgm-cred_lim_calc.
*        ls_creditsegment-creditlimitreq = lw_bp_credit_sgm-cred_lim_req.
*        ls_creditsegment-custgroup = lw_bp_credit_sgm-cust_group.
**        ls_creditsegment-followupdate = lw_bp_credit_sgm-follow_up_dt.
*
*        CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*          EXPORTING
*            ip_start_date          = lw_bp_credit_sgm-follow_up_dt
*          IMPORTING
*            EP_START_DATE          = ls_creditsegment-followupdate
*          EXCEPTIONS
*            CONVERSION_ERROR       = 1
*            OTHERS                 = 2.
*
*        ls_creditsegment-isautomaticreq = lw_bp_credit_sgm-automatic_req.
*        ls_creditsegment-isblocked = lw_bp_credit_sgm-xblocked.
*        ls_creditsegment-isitemerror = lw_bp_credit_sgm-item_error.
*        ls_creditsegment-islimitzero = lw_bp_credit_sgm-x_limit_zero.
**        ls_creditsegment-limitchangedate = lw_bp_credit_sgm-limit_chg_date.
*
*        CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*          EXPORTING
*            ip_start_date          = lw_bp_credit_sgm-limit_chg_date
*          IMPORTING
*            EP_START_DATE          = ls_creditsegment-limitchangedate
*          EXCEPTIONS
*            CONVERSION_ERROR       = 1
*            OTHERS                 = 2.
*
**        ls_creditsegment-limitvaliddate = lw_bp_credit_sgm-limit_valid_date.
*
*        CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*          EXPORTING
*            ip_start_date          = lw_bp_credit_sgm-limit_valid_date
*          IMPORTING
*            EP_START_DATE          = ls_creditsegment-limitvaliddate
*          EXCEPTIONS
*            CONVERSION_ERROR       = 1
*            OTHERS                 = 2.
*
*        ls_creditsegment-loghndl = lw_bp_credit_sgm-log_hndl.
**        ls_creditsegment-reqdate = lw_bp_credit_sgm-req_date.
*
*        CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*          EXPORTING
*            ip_start_date          = lw_bp_credit_sgm-req_date
*          IMPORTING
*            EP_START_DATE          = ls_creditsegment-reqdate
*          EXCEPTIONS
*            CONVERSION_ERROR       = 1
*            OTHERS                 = 2.
*
**        ls_creditsegment-validtodate = lw_bp_credit_sgm-limit_valid_date.
*
*        CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
*          EXPORTING
*            ip_start_date          = lw_bp_credit_sgm-limit_valid_date
*          IMPORTING
*            EP_START_DATE          = ls_creditsegment-validtodate
*          EXCEPTIONS
*            CONVERSION_ERROR       = 1
*            OTHERS                 = 2.
*
*        ls_creditsegment-iscritical = lw_bp_credit_sgm-xcritical.
*        APPEND ls_creditsegment TO ls_is_deep_type-tobusinesspartnercreditsegment.
*        CLEAR lw_bp_credit_sgm.
*      ENDLOOP.
*    ENDIF.

    "-- Get Business Partner Relationship
    SELECT t1~partner1,
           t1~partner2,
           t1~date_to,
           t1~date_from,
           t1~reltyp,
           t1~dftval,
           t1~relkind,
           t2~xdirection
      FROM but050 AS t1
     INNER JOIN tbz9 AS t2
        ON t1~reltyp = t2~reltyp
      INTO TABLE @lt_relationship
     WHERE partner1 = @lv_partner
        OR partner2 = @lv_partner.

    IF lt_relationship IS NOT INITIAL.
      LOOP AT lt_relationship INTO DATA(ls_relationship).
        ls_businesspartnerrelationship-relationshiptype = ls_relationship-relkind.
        IF ls_relationship-date_from IS NOT INITIAL.
          CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
            EXPORTING
              ip_start_date    = ls_relationship-date_from
            IMPORTING
              ep_start_date    = ls_businesspartnerrelationship-validfromdate
            EXCEPTIONS
              conversion_error = 1
              OTHERS           = 2.
        ENDIF.
        IF ls_relationship-date_from IS NOT INITIAL.
          CALL FUNCTION 'FRE_CONVERT_DATE_TO_TIMESTMP'
            EXPORTING
              ip_start_date    = ls_relationship-date_to
            IMPORTING
              ep_start_date    = ls_businesspartnerrelationship-validuntildate
            EXCEPTIONS
              conversion_error = 1
              OTHERS           = 2.
        ENDIF.

        ls_businesspartnerrelationship-differentiationtypevalue = ls_relationship-dftval.
        IF ls_relationship-partner1 <> lv_partner.
          ls_businesspartnerrelationship-businesspartner = ls_relationship-partner1.
        ELSE.
          ls_businesspartnerrelationship-businesspartner = ls_relationship-partner2.
        ENDIF.
        IF ls_relationship-xdirection = 'X'.
          IF ls_relationship-partner1 = lv_partner.
            CONCATENATE 'F' ls_relationship-reltyp INTO ls_businesspartnerrelationship-relationshipcategory.
          ELSE.
            CONCATENATE 'T' ls_relationship-reltyp INTO ls_businesspartnerrelationship-relationshipcategory.
          ENDIF.
        ELSE.
          ls_businesspartnerrelationship-relationshipcategory = ls_relationship-reltyp.
        ENDIF.
        APPEND ls_businesspartnerrelationship TO ls_is_deep_type-tobusinesspartnerrelationship.
        CLEAR ls_businesspartnerrelationship.
      ENDLOOP.
    ENDIF.

    copy_data_to_ref( EXPORTING is_data = ls_is_deep_type
                      CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD get_f4_mdbomclasstype.
    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.
    TYPES: BEGIN OF ty_data,
             itemcategory TYPE postp,
             classtype    TYPE klassenart,
             objecttable  TYPE tabelle,
             locale       TYPE spras,
             description  TYPE arttxt,
           END OF ty_data.
    DATA:
      ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
      lt_data               TYPE TABLE OF ty_data,
      ls_data               TYPE ty_data,
      lv_string             TYPE string,
      lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `ItemCategory` )
                                             ( `ClassType` )
                                             ( `ObjectTable` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    SELECT tcla~klart AS classtype,
           tcla~obtab AS objecttable,
           tclat~spras AS locale,
           tclat~artxt AS description
      FROM tcla LEFT OUTER JOIN tclat ON tcla~klart = tclat~klart
      INTO TABLE @DATA(lt_data_temp)
     WHERE ( tcla~obtab = 'DRAW' OR tcla~obtab = 'MARA' ).

    SELECT postp,
           dkpos
      FROM t418
      INTO TABLE @DATA(lt_postp).

    LOOP AT lt_data_temp INTO DATA(ls_temp).
      MOVE-CORRESPONDING ls_temp TO ls_data.
      IF ls_temp-objecttable = 'DRAW'.
        LOOP AT lt_postp INTO DATA(ls_postp) WHERE dkpos = 'X'.
          ls_data-itemcategory = ls_postp-postp.
          APPEND ls_data TO lt_data.
        ENDLOOP.
      ELSEIF ls_temp-objecttable = 'MARA'.
        LOOP AT lt_postp INTO ls_postp WHERE dkpos <> 'X'.
          ls_data-itemcategory = ls_postp-postp.
          APPEND ls_data TO lt_data.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_data INTO ls_data.
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mdcostcentergroup.
    CONSTANTS: lc_costcenter_setclass TYPE setclass VALUE '0101'.

    TYPES: BEGIN OF lty_hierset,
             coarea            TYPE kokrs,
             standardhierarchy TYPE khinr,
             costcentergroup   TYPE khinr,
           END OF lty_hierset.

    TYPES: BEGIN OF ty_entity,
             coarea            TYPE string,
             standardhierarchy TYPE string,
             costcentergroup   TYPE string,
             locale            TYPE string,
             description       TYPE string,
           END OF ty_entity.

    DATA: ls_entity   TYPE ty_entity,
          lt_entity   TYPE TABLE OF ty_entity,
          i_hier_sets TYPE setidlist.

    DATA: ld_setid    TYPE sethier-setid,
          l_shortname TYPE sethier-shortname.

    DATA: ls_hierset TYPE lty_hierset,
          lt_hierset TYPE STANDARD TABLE OF lty_hierset.

    DATA: setid    TYPE sethier-setid,
          setname  TYPE setheader-setname,
          subclass TYPE setheader-subclass,
          setclass TYPE setheader-setclass.
    DATA: lv_tabix TYPE i VALUE 1.

    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA: ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
          lv_string             TYPE string,
          lv_value_string       TYPE string.

    DATA(lt_fieldname) = VALUE ty_fieldname( ( `COArea` )
                                             ( `StandardHierarchy` )
                                             ( `CostCenterGroup` )
                                             ( `Locale` )
                                             ( `Description` ) ).

    SELECT co~kokrs      AS coarea,
           co~khinr      AS standardhierarchy,
           set~setname   AS costcentergroup,
           sett~langu    AS locale,
           sett~descript AS description
      FROM tka01 AS co
      LEFT OUTER JOIN setheader  AS set  ON co~kokrs = set~subclass
      LEFT OUTER JOIN setheadert AS sett ON set~setclass = sett~setclass
                                        AND set~subclass = sett~subclass
                                        AND set~setname = sett~setname
      INTO TABLE @DATA(lt_data)
     WHERE set~setclass = '0101'
       AND ( set~settype = 'S' OR set~settype = 'B' )
       AND set~rollname = 'KOSTL'.

    SORT lt_data ASCENDING BY coarea standardhierarchy costcentergroup.

    DATA(lt_coarea) = lt_data.
    DELETE ADJACENT DUPLICATES FROM lt_coarea COMPARING coarea standardhierarchy.

    LOOP AT lt_coarea INTO DATA(ls_coarea).
      CALL FUNCTION 'G_SET_ENCRYPT_SETID'
        EXPORTING
          setclass  = lc_costcenter_setclass
          shortname = ls_coarea-standardhierarchy
          kokrs     = ls_coarea-coarea
        IMPORTING
          setid     = ld_setid.

      "  Search for sets in the standard hierarchy
      CALL FUNCTION 'G_SET_LIST_SELECT_IN_HIERARCHY'
        EXPORTING
          top_setid     = ld_setid
          shortname     = l_shortname
        IMPORTING
          matching_sets = i_hier_sets
        EXCEPTIONS
          OTHERS        = 0.

      LOOP AT i_hier_sets INTO DATA(ls_setid).
        CLEAR setid.
        setid = ls_setid.
        PERFORM get_keys_from_setid IN PROGRAM saplgsac USING setid
                                     CHANGING setclass
                                              subclass
                                              setname.

        ls_hierset-coarea = ls_coarea-coarea.
        ls_hierset-standardhierarchy = ls_coarea-standardhierarchy.
        ls_hierset-costcentergroup = setname.

        APPEND ls_hierset TO lt_hierset.
      ENDLOOP.

      ls_entity-coarea         = ls_coarea-coarea.
      ls_entity-standardhierarchy  = ls_coarea-standardhierarchy.

      LOOP AT lt_data INTO DATA(ls_grouptext) FROM lv_tabix.
        lv_tabix = sy-tabix.
        IF ls_grouptext-coarea NE ls_coarea-coarea OR ls_grouptext-standardhierarchy NE ls_coarea-standardhierarchy.
          EXIT.
        ENDIF.

        READ TABLE lt_hierset INTO ls_hierset
                              WITH KEY coarea = ls_grouptext-coarea
                                       standardhierarchy = ls_grouptext-standardhierarchy
                                       costcentergroup = ls_grouptext-costcentergroup.
        IF sy-subrc = 0.
          ls_entity-costcentergroup  = ls_grouptext-costcentergroup.
          ls_entity-locale             = ls_grouptext-locale.
          ls_entity-description        = ls_grouptext-description.
          APPEND ls_entity TO lt_entity.
        ENDIF.
      ENDLOOP.

      CLEAR: l_shortname, ls_entity.
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_f4_mddeliverypriority.
    TYPES ty_fieldname TYPE TABLE OF string WITH EMPTY KEY.

    DATA:
      ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
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
      ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
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
      ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
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
      ls_search_help_result TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult,
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
      ls_search_help_result-value = lv_value_string.

      APPEND ls_search_help_result TO lc_search_help_request-to_searchhelpresult.
      CLEAR: ls_search_help_result, lv_value_string.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_multiple_search_help_data.
    DATA:
      ls_search_help         TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelp,
      ls_search_help_request TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_searchhelprequest,
      ls_search_help_result  TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult.

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
      lv_string          TYPE string.

    FIELD-SYMBOLS:
      <line>    TYPE any,
      <lt_line> TYPE ANY TABLE.

    lv_language_string = lc_multiple_search_help-languagekey.
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

    LOOP AT lc_multiple_search_help-to_searchhelprequest INTO ls_search_help_request.
      IF ls_search_help_request-mdtable = 'MDPaymentMethod'.
        get_f4_mdpaymentmethod( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtable = 'MDRelationship'.
        get_f4_mdrelationship( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtable = 'MDRelationshipType'.
        get_f4_mdrelationshiptype( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtable = 'MDDeliveryPriority'.
        get_f4_mddeliverypriority( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtable = 'MDCostCenterGroup'.
        get_f4_mdcostcentergroup( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSEIF ls_search_help_request-mdtable = 'MDBOMClassType'.
        get_f4_mdbomclasstype( CHANGING lc_search_help_request = ls_search_help_request ).
      ELSE.
        LOOP AT ls_search_help_request-to_searchhelp INTO ls_search_help.
          "Initialize
          CLEAR: lt_sel_list, lt_where_tab, lt_components.

          "Build structure and select fields list
          LOOP AT ls_search_help-to_searchhelpselectfield INTO DATA(ls_select_field).
            DATA(lv_index) = sy-tabix.
            IF ls_select_field-fieldtype IS INITIAL.
              lv_fieldname = ls_select_field-tablename && '-' &&
                             ls_select_field-technicalfieldname.

              IF lv_index = lines( ls_search_help-to_searchhelpselectfield ).
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

              IF lv_index = lines( ls_search_help-to_searchhelpselectfield ).
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
            cl_abap_datadescr=>describe_by_name(
              EXPORTING
                p_name         = lv_fieldname
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

            READ TABLE ls_search_help-to_searchhelpselectfield INTO ls_select_field
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
            ENDTRY.
          ENDIF.

          "Build Return Value
          IF <lt_line> IS ASSIGNED.
            LOOP AT <lt_line> INTO <line>.
              LOOP AT ls_search_help-to_searchhelpselectfield INTO DATA(ls_selectfield_1).
                ASSIGN COMPONENT ls_selectfield_1-fieldname OF STRUCTURE <line> TO FIELD-SYMBOL(<lf_data>).
                IF sy-subrc = 0.
                  CLEAR lv_string.
                  lv_string = <lf_data>.
                  IF ls_selectfield_1-fieldname = 'Locale'.
                    CALL FUNCTION 'CONVERSION_EXIT_ISOLA_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.
                  ENDIF.

                  lv_data_element = ls_selectfield_1-technicalfieldname.
                  TRANSLATE lv_data_element TO UPPER CASE.
                  "Convert external value for UoM
                  IF lv_data_element = 'MSEHI'.
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

                  ENDIF.

                  "Conversion routine PARVW
                  IF lv_data_element = 'PARVW'.
                    CALL FUNCTION 'CONVERSION_EXIT_PARVW_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.
                  ENDIF.

                  "Conversion routine DOKNR
                  IF lv_data_element = 'DOKNR'.
                    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
                      EXPORTING
                        input  = lv_string
                      IMPORTING
                        output = lv_string.
                    CONDENSE lv_string NO-GAPS.
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
              ls_search_help_result-value = lv_value_string.
              APPEND ls_search_help_result TO ls_search_help_request-to_searchhelpresult.
              CLEAR: ls_search_help_result, lv_value_string, lv_data_element.
            ENDLOOP.
          ENDIF.
        ENDLOOP.
      ENDIF.

      MODIFY lc_multiple_search_help-to_searchhelprequest FROM ls_search_help_request.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_product_data.
    TYPES:
      BEGIN OF ty_kssk,
        objek TYPE cuobn,
        klart TYPE klassenart,
      END OF ty_kssk.

    DATA:
      lv_object_type    TYPE  tcla-obtab,
      ls_is_deep_type   TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_create_deep_type,
      ls_classification TYPE /simple/cl_mdg_gw_core_mpc_ext=>ty_classification,
      ls_characteristic TYPE /simple/cl_mdg_gw_core_mpc=>ts_characteristic,
      lt_return         TYPE STANDARD TABLE OF  bapiret2,
      lt_alloclist      TYPE STANDARD TABLE OF  bapi1003_alloc_list,
      lv_objek          TYPE cuobn,
      lt_kssk           TYPE STANDARD TABLE OF ty_kssk,
      lv_num(18)        TYPE n,
      lv_num10(10)      TYPE n,
      objecttable_imp   TYPE  bapi1003_key-objecttable,
      classtype_imp     TYPE bapi1003_key-classtype,
      objectkey_imp     TYPE bapi1003_key-object.

    "Data for getting characteristic
    DATA:
      lt_charact_values        TYPE STANDARD TABLE OF  api_val_r,
      lt_object_identification TYPE STANDARD TABLE OF  api_ob_key,
      lv_object                TYPE  kssk-objek,
      lv_class_type            TYPE  kssk-klart,
      lv_class                 TYPE  klah-class.

    ls_is_deep_type = is_deep_type.
    CLEAR ls_is_deep_type-toclassification.

    lv_object_type = 'MARA'.
    objecttable_imp = 'MARA'.
    lv_num = ls_is_deep_type-objectid.
    objectkey_imp = lv_num.
    lv_objek = lv_num.


    "-- Get Classification Data
    "-- Get Material Class Type
    SELECT objek,
           klart
      FROM kssk
      INTO TABLE @lt_kssk
      WHERE objek = @lv_objek.

    IF lt_kssk IS NOT INITIAL.
      SORT lt_kssk BY
        objek klart ASCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_kssk COMPARING
        objek klart.
    ENDIF.

    LOOP AT lt_kssk INTO DATA(ls_kssk).
      "-- Get Object Class
      classtype_imp = ls_kssk-klart.

      CALL FUNCTION 'BAPI_OBJCL_GETCLASSES'
        EXPORTING
          objectkey_imp   = objectkey_imp
          objecttable_imp = objecttable_imp
          classtype_imp   = classtype_imp
        TABLES
          alloclist       = lt_alloclist
          return          = lt_return.

      IF lt_alloclist IS NOT INITIAL.
        LOOP AT lt_alloclist INTO DATA(ls_alloclist).
          lv_object = ls_alloclist-object.
          lv_class_type = ls_alloclist-classtype.
          lv_class = ls_alloclist-classnum.

          CALL FUNCTION 'CACL_OBJECT_READ_VALIDATION'
            EXPORTING
              object                = lv_object
              object_type           = lv_object_type
              class_type            = lv_class_type
              class                 = lv_class
            TABLES
              charact_values        = lt_charact_values
              object_identification = lt_object_identification
            EXCEPTIONS
              error                 = 1
              warning               = 2
              OTHERS                = 3.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ENDIF.
          ls_classification-classtype = ls_alloclist-classtype.
          ls_classification-class = ls_alloclist-classnum.
          ls_classification-objecttable = ls_alloclist-objtyp.
          ls_classification-objectkey = ls_alloclist-object.
          IF lt_charact_values IS NOT INITIAL.
            LOOP AT lt_charact_values INTO DATA(ls_charact_values)
              WHERE val_assign = 'X' AND inherited = ''..
              ls_characteristic-charact    = ls_charact_values-charact.
              ls_characteristic-value      = ls_charact_values-value_neutral.
              ls_characteristic-class      = ls_classification-class.
              ls_characteristic-classtype  = ls_classification-classtype.
              APPEND ls_characteristic TO ls_classification-tocharacteristic.
            ENDLOOP.
          ENDIF.

          APPEND ls_classification TO ls_is_deep_type-toclassification.
          CLEAR ls_classification.
        ENDLOOP.
        CLEAR lt_alloclist.
      ENDIF.
    ENDLOOP.

    copy_data_to_ref( EXPORTING is_data = ls_is_deep_type
                      CHANGING cr_data = er_deep_entity ).

  ENDMETHOD.


  METHOD get_target_entity.

    CASE is_changeset_request-operation_type.

      WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-create_deep_entity.
        DATA lr_create_deep_context TYPE REF TO /iwbep/if_mgw_req_entity_c.
        lr_create_deep_context ?= is_changeset_request-request_context.
        rv_result = lr_create_deep_context->get_entity_type_name( ).
      WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-create_entity.
        DATA lr_create_context TYPE REF TO /iwbep/if_mgw_req_entity_c.
        lr_create_context ?= is_changeset_request-request_context.
        rv_result = lr_create_context->get_entity_type_name( ).
      WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-update_entity.
        DATA lr_update_context TYPE REF TO /iwbep/if_mgw_req_entity_u.
        lr_update_context ?= is_changeset_request-request_context.
        rv_result = lr_update_context->get_entity_type_name( ).
      WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-patch_entity.
        DATA lr_patch_context TYPE REF TO /iwbep/if_mgw_req_entity_p.
        lr_patch_context ?= is_changeset_request-request_context.
        rv_result = lr_patch_context->get_entity_type_name( ).
      WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-delete_entity.
        DATA lr_delete_context TYPE REF TO /iwbep/if_mgw_req_entity_d.
        lr_delete_context ?= is_changeset_request-request_context.
        rv_result = lr_delete_context->get_entity_type_name( ).
    ENDCASE.

    ASSERT rv_result IS NOT INITIAL.

  ENDMETHOD.


  METHOD handle_appl_log.

    DELETE it_message WHERE type <> 'E' AND type <> 'A' AND type <> 'X'.
    DELETE it_message2 WHERE type <> 'E' AND type <> 'A' AND type <> 'X'.

    DATA: lv_log        TYPE /simple/api_log,
          lv_log_handle TYPE balloghndl.
    IF iv_status IS NOT INITIAL.
      lv_log-status = iv_status.

    ELSE.
      lv_log-status = COND #( WHEN line_exists( it_message[ type = 'E' ] ) OR
                                  line_exists( it_message[ type = 'A' ] ) OR
                                  line_exists( it_message[ type = 'X' ] ) THEN 'F'  ELSE 'S' ).
    ENDIF.
    lv_log = VALUE #( BASE lv_log mdg_key          = is_response-mdkey
                      time_run         = ( /simple/cl_mdg_gw_core_dpc_ext=>gv_tstop - /simple/cl_mdg_gw_core_dpc_ext=>gv_tstart )  / 1000000
                      obj_type         = iv_subobject
                      mdglogid         = is_response-mdglogid
                      cr_number        = is_response-crnumber
                      cr_item          = is_response-critem
                      activate_id      = is_response-activateid
                      activate_item_id = is_response-activateitemid
                      messaging_core   =  /simple/cl_mdg_gw_core_dpc_ext=>gv_messaging_core
                      messaging_object_type      =  /simple/cl_mdg_gw_core_dpc_ext=>gv_messaging_object_type
                      message_log      = COND #( WHEN lv_log-status <> 'F' THEN lv_log-mdg_key ) ).



    IF lv_log-status = 'F'
    AND it_message[] IS NOT INITIAL.
      CLEAR:lv_log-message_log.
      LOOP AT it_message[] INTO DATA(ls_msg) WHERE type IS NOT INITIAL.
        IF ls_msg-type = 'E' AND ls_msg-number = '000' AND ls_msg-message_v1 IS INITIAL.
          DATA(lv_msg) = ls_msg-message.
        ELSEIF ls_msg-type = 'E' and ls_msg-id = '00' AND ls_msg-number = '000' AND ls_msg-message_v1 IS NOT INITIAL.
          lv_msg = ls_msg-message_v1.
        ELSE.
          TRY.
              MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
              WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
              INTO lv_msg.
            CATCH cx_root.
              CONTINUE.
          ENDTRY.
        ENDIF.
        IF lv_log-message_log IS INITIAL.
          lv_log-message_log = condense( lv_msg ).
        ELSE.
          lv_log-message_log = condense( lv_msg ) && |{ cl_abap_char_utilities=>newline }| && lv_log-message_log.
        ENDIF.
      ENDLOOP.
    ENDIF.

    LOOP AT it_message2[] INTO ls_msg WHERE type IS NOT INITIAL.
      IF ls_msg-type = 'E' AND ls_msg-number = '000' AND ls_msg-message_v1 IS INITIAL.
        lv_msg = ls_msg-message.
      ELSE.
        TRY.
            MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
            WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
            INTO lv_msg.
          CATCH cx_root.
            CONTINUE.
        ENDTRY.
      ENDIF.
      IF lv_log-additional_message IS INITIAL.
        lv_log-additional_message = condense( lv_msg ).
      ELSE.
        lv_log-additional_message = condense( lv_msg ) && |{ cl_abap_char_utilities=>newline }| && lv_log-additional_message.
      ENDIF.
    ENDLOOP.

    IF iv_step IS INITIAL.
      IF to_upper( is_response-actionmode ) CS 'VALIDATION'.
        lv_log-step = COND #( WHEN  to_upper( is_response-actionmode ) CS 'BACKGROUND' THEN 'BV'  ELSE 'V'  ). " Validation check?
      ELSE.
        lv_log-step = COND #( WHEN  to_upper( is_response-actionmode ) CS 'BACKGROUND' THEN 'B'   ELSE 'A'  ). " Not validation check?
      ENDIF.

    ELSE.
      lv_log-step = iv_step.
    ENDIF.
    CALL FUNCTION '/SIMPLE/FM_LOG_SAVE'
      EXPORTING
        is_log        = lv_log
      EXCEPTIONS
        error_message = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    cs_log = lv_log.
  ENDMETHOD.


  METHOD handle_queue_rfc.

    DATA: lv_queue_number TYPE string,
          queue_name      TYPE qrfc_queue_name.

    DATA(lo_exception) = NEW /iwbep/cx_mgw_busi_exception( ).

    SELECT *
      FROM /simple/mdg_conf
      INTO TABLE @DATA(lt_mdg_conf).

    IF iv_mass_run = abap_false.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = '/SIMPLE/BG'
        IMPORTING
          number                  = lv_queue_number
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 4
          quantity_is_not_1       = 5
          interval_overflow       = 6
          buffer_overflow         = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
*      RAISE EXCEPTION lo_exception.
        lv_queue_number = '1'.
      ENDIF.

*      queue_name = |SIMPLEMDG_BGRFC_QUEUE_SINGLE|.
      READ TABLE lt_mdg_conf INTO DATA(ls_mdg_conf) WITH KEY fieldname = 'BGRFC_QUEUE_SINGLE'.
      IF sy-subrc = 0.
        queue_name = ls_mdg_conf-fieldvalue.
      ENDIF.

    ELSE.
      IF iv_queue_id IS NOT INITIAL.
        lv_queue_number = iv_queue_id.
      ELSE.
        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr             = '02'
            object                  = '/SIMPLE/BG'
          IMPORTING
            number                  = lv_queue_number
          EXCEPTIONS
            interval_not_found      = 1
            number_range_not_intern = 2
            object_not_found        = 3
            quantity_is_0           = 4
            quantity_is_not_1       = 5
            interval_overflow       = 6
            buffer_overflow         = 7
            OTHERS                  = 8.
        IF sy-subrc <> 0.
*      RAISE EXCEPTION lo_exception.
          lv_queue_number = '1'.
        ENDIF.

      ENDIF.

*      queue_name = |SIMPLEMDG_BGRFC_QUEUE_MASS|.
      READ TABLE lt_mdg_conf INTO ls_mdg_conf WITH KEY fieldname = 'BGRFC_QUEUE_MASS'.
      IF sy-subrc = 0.
        queue_name = ls_mdg_conf-fieldvalue.
      ENDIF.

    ENDIF.

    IF iv_queue_id <> 'ART'.
      SELECT SINGLE *
      FROM /simple/mdg_host
      WHERE uname = @sy-uname
      INTO @DATA(ls_mdg_host).

      IF sy-uname EQ ls_mdg_host-uname.
        queue_name = |{ queue_name }_{ lv_queue_number }|.
      ELSE.
        queue_name = |{ queue_name }_{ sy-uname }|.
      ENDIF.
    ELSE.
      queue_name = |{ queue_name }_{ lv_queue_number }|.
    ENDIF.

    is_unit->add_queue_name_inbound( queue_name = queue_name
                                     ignore_duplicates = abap_false ).
  ENDMETHOD.


  METHOD map_response.

    FIELD-SYMBOLS:
                  <ls_data> TYPE any.

    CREATE DATA cr_data LIKE is_data.
    ASSIGN cr_data->* TO <ls_data>.
    <ls_data> = is_data.

  ENDMETHOD.


  METHOD populate_key_fields.

    DATA : ls_keys LIKE LINE OF et_keys,
           lt_keys LIKE et_keys.

    DATA : ls_partner_role           TYPE cl_api_business_partne_mpc=>ts_a_businesspartnerroletype,
           ls_partner_identification TYPE cl_api_business_partne_mpc=>ts_a_bupaidentificationtype,
           ls_partner_tax            TYPE cl_api_business_partne_mpc=>ts_a_businesspartnertaxnumbert,
           ls_partner_bank           TYPE cl_api_business_partne_mpc=>ts_a_businesspartnerbanktype,
           ls_partner_address        TYPE cl_api_business_partne_mpc=>ts_a_businesspartneraddresstyp,
           ls_partner_address_usage  TYPE cl_api_business_partne_mpc=>ts_a_bupaaddressusagetype,
           "ls_customer               TYPE cl_api_business_partne_mpc=>ts_a_customertype,
           ls_customer_company       TYPE cl_api_business_partne_mpc=>ts_a_customercompanytype,
           ls_customer_sales         TYPE cl_api_business_partne_mpc=>ts_a_customersalesareatype,
           "ls_supplier               TYPE cl_api_business_partne_mpc=>ts_a_suppliertype,
           ls_supplier_company       TYPE cl_api_business_partne_mpc=>ts_a_suppliercompanytype,
           ls_supplier_purchase      TYPE cl_api_business_partne_mpc=>ts_a_supplierpurchasingorgtype,
           ls_supplier_wtax          TYPE cl_api_business_partne_mpc=>ts_a_supplierwithholdingtaxtyp,
           ls_supplier_partfunc      TYPE cl_api_business_partne_mpc=>ts_a_supplierpartnerfunctype,
           ls_customer_dunning       TYPE cl_api_business_partne_mpc=>ts_a_customerdunningtype,
           ls_supplier_dunning       TYPE cl_api_business_partne_mpc=>ts_a_supplierdunningtype,
           ls_customer_partfunc      TYPE cl_api_business_partne_mpc=>ts_a_custsalespartnerfunctype,
           ls_customer_salestax      TYPE cl_api_business_partne_mpc=>ts_a_customersalesareataxtype,
           ls_customer_wtax          TYPE cl_api_business_partne_mpc=>ts_a_customerwithholdingtaxtyp,
           ls_partner_contact        TYPE cl_api_business_partne_mpc=>ts_a_businesspartnercontacttyp,
           "ls_partner_contact_func   TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttofuncanddepttyp,
           ls_phone                  TYPE cl_api_business_partne_mpc=>ts_a_addressphonenumbertype,
           ls_fax                    TYPE cl_api_business_partne_mpc=>ts_a_addressfaxnumbertype,
           ls_email                  TYPE cl_api_business_partne_mpc=>ts_a_addressemailaddresstype,
           ls_uri                    TYPE cl_api_business_partne_mpc=>ts_a_addresshomepageurltype,
           ls_partner_indsec         TYPE cl_api_business_partne_mpc=>ts_a_bupaindustrytype.

    DATA : lv_keys_missing TYPE char1,
           lv_nobp         TYPE char1.

    CASE iv_entity_name.

      WHEN 'A_BusinessPartnerRoleType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_role ).

        IF ls_partner_role-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_role-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BuPaIndustryType'.                            " Added for industry sector fields extension

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_indsec ).

        IF ls_partner_indsec-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_indsec-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BuPaIdentificationType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_identification ).

        IF ls_partner_identification-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_identification-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BusinessPartnerTaxNumberType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_tax ).

        IF ls_partner_tax-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_tax-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BusinessPartnerBankType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_bank ).

        IF ls_partner_bank-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_bank-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BusinessPartnerAddressType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_address ).

        IF ls_partner_address-businesspartner IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_address-businesspartner.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BuPaAddressUsageType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_address_usage ).

        IF ls_partner_address_usage-businesspartner IS NOT INITIAL AND ls_partner_address_usage-addressid IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_address_usage-businesspartner.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'ADDRESSID'.
          ls_keys-value = ls_partner_address_usage-addressid.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_AddressPhoneNumberType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_phone ).

        IF ls_phone-addressid IS NOT INITIAL.
          ls_keys-name = 'ADDRESSID'.
          ls_keys-value = ls_phone-addressid.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          SELECT SINGLE partner FROM but020 INTO @DATA(lv_partner) WHERE addrnumber = @ls_phone-addressid.
          IF sy-subrc = '0'.
            ls_keys-name = 'BUSINESSPARTNER'.
            ls_keys-value = lv_partner.
            APPEND ls_keys TO lt_keys.
          ELSE.
            lv_nobp = 'X'.
          ENDIF.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_AddressFaxNumberType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_fax ).

        IF ls_fax-addressid IS NOT INITIAL.
          ls_keys-name = 'ADDRESSID'.
          ls_keys-value = ls_fax-addressid.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          SELECT SINGLE partner FROM but020 INTO @lv_partner WHERE addrnumber = @ls_fax-addressid.
          IF sy-subrc = '0'.
            ls_keys-name = 'BUSINESSPARTNER'.
            ls_keys-value = lv_partner.
            APPEND ls_keys TO lt_keys.
          ELSE.
            lv_nobp = 'X'.
          ENDIF.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_AddressEmailAddressType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_email ).

        IF ls_email-addressid IS NOT INITIAL.
          ls_keys-name = 'ADDRESSID'.
          ls_keys-value = ls_email-addressid.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          SELECT SINGLE partner FROM but020 INTO @lv_partner WHERE addrnumber = @ls_email-addressid.
          IF sy-subrc = '0'.
            ls_keys-name = 'BUSINESSPARTNER'.
            ls_keys-value = lv_partner.
            APPEND ls_keys TO lt_keys.
          ELSE.
            lv_nobp = 'X'.
          ENDIF.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_AddressHomePageURLType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_uri ).

        IF ls_uri-addressid IS NOT INITIAL.
          ls_keys-name = 'ADDRESSID'.
          ls_keys-value = ls_uri-addressid.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          SELECT SINGLE partner FROM but020 INTO @lv_partner WHERE addrnumber = @ls_uri-addressid.
          IF sy-subrc = '0'.
            ls_keys-name = 'BUSINESSPARTNER'.
            ls_keys-value = lv_partner.
            APPEND ls_keys TO lt_keys.
          ELSE.
            lv_nobp = 'X'.
          ENDIF.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustomerCompanyType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_company ).

        IF ls_customer_company-customer IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_company-customer.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustomerSalesAreaType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_sales ).

        IF ls_customer_sales-customer IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_sales-customer.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustomerWithHoldingTaxType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_wtax ).

        IF ls_customer_wtax-customer IS NOT INITIAL AND ls_customer_wtax-companycode IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_wtax-customer.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'COMPANYCODE'.
          ls_keys-value = ls_customer_wtax-companycode.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustomerDunningType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_dunning ).

        IF ls_customer_dunning-customer IS NOT INITIAL AND ls_customer_dunning-companycode IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_dunning-customer.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'COMPANYCODE'.
          ls_keys-value = ls_customer_dunning-companycode.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustSalesPartnerFuncType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_partfunc ).

        IF ls_customer_partfunc-customer IS NOT INITIAL AND ls_customer_partfunc-salesorganization IS NOT INITIAL AND
           ls_customer_partfunc-distributionchannel IS NOT INITIAL AND ls_customer_partfunc-division IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_partfunc-customer.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'SALESORGANIZATION'.
          ls_keys-value = ls_customer_partfunc-salesorganization.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'DISTRIBUTIONCHANNEL'.
          ls_keys-value = ls_customer_partfunc-distributionchannel.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'DIVISION'.
          ls_keys-value = ls_customer_partfunc-division.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_CustomerSalesAreaTaxType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_customer_salestax ).

        IF ls_customer_salestax-customer IS NOT INITIAL AND ls_customer_salestax-salesorganization IS NOT INITIAL AND
           ls_customer_salestax-distributionchannel IS NOT INITIAL AND ls_customer_salestax-division IS NOT INITIAL.
          ls_keys-name = 'CUSTOMER'.
          ls_keys-value = ls_customer_salestax-customer.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'SALESORGANIZATION'.
          ls_keys-value = ls_customer_salestax-salesorganization.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'DISTRIBUTIONCHANNEL'.
          ls_keys-value = ls_customer_salestax-distributionchannel.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'DIVISION'.
          ls_keys-value = ls_customer_salestax-division.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_SupplierCompanyType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_supplier_company ).

        IF ls_supplier_company-supplier IS NOT INITIAL.
          ls_keys-name = 'SUPPLIER'.
          ls_keys-value = ls_supplier_company-supplier.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_SupplierPurchasingOrgType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_supplier_purchase ).

        IF ls_supplier_purchase-supplier IS NOT INITIAL.
          ls_keys-name = 'SUPPLIER'.
          ls_keys-value = ls_supplier_purchase-supplier.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_SupplierWithHoldingTaxType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_supplier_wtax ).

        IF ls_supplier_wtax-supplier IS NOT INITIAL AND ls_supplier_wtax-companycode IS NOT INITIAL.
          ls_keys-name = 'SUPPLIER'.
          ls_keys-value = ls_supplier_wtax-supplier.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'COMPANYCODE'.
          ls_keys-value = ls_supplier_wtax-companycode.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_SupplierPartnerFuncType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_supplier_partfunc ).

        IF ls_supplier_partfunc-supplier IS NOT INITIAL AND ls_supplier_partfunc-purchasingorganization IS NOT INITIAL.
          ls_keys-name = 'SUPPLIER'.
          ls_keys-value = ls_supplier_partfunc-supplier.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'PURCHASINGORGANIZATION'.
          ls_keys-value = ls_supplier_partfunc-purchasingorganization.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_SupplierDunningType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_supplier_dunning ).

        IF ls_supplier_dunning-supplier IS NOT INITIAL AND ls_supplier_dunning-companycode IS NOT INITIAL.
          ls_keys-name = 'SUPPLIER'.
          ls_keys-value = ls_supplier_dunning-supplier.
          APPEND ls_keys TO lt_keys.
          CLEAR ls_keys.
          ls_keys-name = 'COMPANYCODE'.
          ls_keys-value = ls_supplier_dunning-companycode.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

      WHEN 'A_BusinessPartnerContactType'.

        io_data_provider->read_entry_data(
        IMPORTING
        es_data = ls_partner_contact ).

        IF ls_partner_contact-businesspartnercompany IS NOT INITIAL.
          ls_keys-name = 'BUSINESSPARTNER'.
          ls_keys-value = ls_partner_contact-businesspartnercompany.
          APPEND ls_keys TO lt_keys.
        ELSE.
          lv_keys_missing = 'X'.
        ENDIF.

    ENDCASE.

    IF lv_keys_missing = 'X'.
      export_messages(
        EXPORTING
          iv_error                     =  'INCOMPLETE_KEYS'
          iv_entity_name               =  iv_entity_name
      ).
    ENDIF.

    IF lv_nobp = 'X'.
      export_messages(
      EXPORTING
        iv_error                     =  'NOBP'
        iv_entity_name               =  iv_entity_name
    ).
    ENDIF.

    et_keys = lt_keys.

  ENDMETHOD.


  METHOD process_request.

    DATA : ls_changeset_request LIKE is_changeset_request,
           lr_entity            TYPE REF TO data.

    ls_changeset_request = is_changeset_request.

    IF ls_changeset_request-operation_type = 'CD'."post : create_deep

      DATA :lo_cd_request TYPE REF TO /iwbep/if_mgw_req_entity_c.
      lo_cd_request ?= ls_changeset_request-request_context.
      me->/iwbep/if_mgw_appl_srv_runtime~create_deep_entity(
        EXPORTING
          iv_entity_name               =     get_target_entity( is_changeset_request )
          io_data_provider             =     ls_changeset_request-entry_provider
          io_expand                    =     ls_changeset_request-expand_node
          io_tech_request_context      =     lo_cd_request
        IMPORTING
          er_deep_entity               =     lr_entity ).

    ELSEIF ls_changeset_request-operation_type = 'CE'. "post : create

      DATA :lo_create_request TYPE REF TO /iwbep/if_mgw_req_entity_c.
      lo_create_request ?= ls_changeset_request-request_context.
      me->/iwbep/if_mgw_appl_srv_runtime~create_entity(
        EXPORTING
          iv_entity_name               =     get_target_entity( is_changeset_request )
          io_data_provider             =     ls_changeset_request-entry_provider
          io_tech_request_context      =     lo_create_request
        IMPORTING
          er_entity                    =      lr_entity ).

    ELSEIF ls_changeset_request-operation_type = 'PE'."patch and merge : update

      DATA :lo_patch_request TYPE REF TO /iwbep/if_mgw_req_entity_p.
      lo_patch_request ?= ls_changeset_request-request_context.
      me->/iwbep/if_mgw_appl_srv_runtime~patch_entity(
       EXPORTING
         iv_entity_name               =      get_target_entity( is_changeset_request )
         io_data_provider             =      ls_changeset_request-entry_provider " MGW Entry Data Provider
         io_tech_request_context      =      lo_patch_request " Request Details for Entity Patch Operation
         IMPORTING
           er_entity                  =      lr_entity
     ).

    ELSEIF ls_changeset_request-operation_type = 'UE'."put : update

      DATA :lo_update_request TYPE REF TO /iwbep/if_mgw_req_entity_u.
      lo_update_request ?= ls_changeset_request-request_context.
      me->/iwbep/if_mgw_appl_srv_runtime~update_entity(
       EXPORTING
         iv_entity_name               =      get_target_entity( is_changeset_request )
         io_data_provider             =      ls_changeset_request-entry_provider " MGW Entry Data Provider
         io_tech_request_context      =      lo_update_request " Request Details for Entity Patch Operation
         IMPORTING
           er_entity                  =      lr_entity ).

    ELSEIF ls_changeset_request-operation_type = 'DE'."delete

      DATA :lo_delete_request TYPE REF TO /iwbep/if_mgw_req_entity_d.
      lo_delete_request ?= ls_changeset_request-request_context.
      me->/iwbep/if_mgw_appl_srv_runtime~delete_entity(
        EXPORTING
          iv_entity_name               =     get_target_entity( is_changeset_request )
          io_tech_request_context      =     lo_delete_request ).

    ENDIF.

    er_entity = lr_entity.


  ENDMETHOD.


  METHOD save_appl_log.
    DATA lt_loghandle TYPE bal_t_logh.
    APPEND iv_log_handle TO lt_loghandle.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle   = lt_loghandle
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        error_message    = 4
        OTHERS           = 5.

  ENDMETHOD.


  METHOD searchbusinesspa_get_entityset.
    TYPES: BEGIN OF ty_result,
             objek            TYPE cuobn,
             class            TYPE klasse_d,
             klart            TYPE klassenart,
             atnam            TYPE atnam,
             atwrt            TYPE atwrt,
             partner          TYPE bu_partner,
             own_rating       TYPE  ukm_own_rating,
             check_rule       TYPE  ukm_check_rule,
             limit_rule       TYPE ukm_limit_rule,
             rating_val_date  TYPE ukm_rating_valid_date,
             rating_chg_date  TYPE ukm_rating_chg_date,
             alternate_bp     TYPE ukm_alternate_bp,
             own_rating_calc  TYPE ukm_own_rating_calc,
             risk_class       TYPE ukm_risk_class,
             risk_class_calc  TYPE ukm_risk_class_calc,
             risk_class_chgdt TYPE ukm_risk_class_chg_date,
             credit_group     TYPE ukm_cred_group,
             credit_sgmnt     TYPE ukm_credit_sgmnt,
             credit_limit     TYPE ukm_credit_limit,
             xblocked         TYPE ukm_xblocked,
             limit_valid_date TYPE ukm_valid_date,
             limit_chg_date   TYPE ukm_chg_date,
             coordinator      TYPE ukm_coordinator,
             cust_group       TYPE ukm_cust_group,
             follow_up_dt     TYPE ukm_follow_up_dt,
             cred_lim_calc    TYPE ukm_credit_limit_calc,
             xcritical        TYPE ukm_critical_account,
             x_limit_zero     TYPE ukm_limit_zero,
             block_reason     TYPE ukm_block_reason,
             cred_lim_req     TYPE ukm_credit_limit_req,
             automatic_req    TYPE ukm_automatic_request,
             lim_val_date_req TYPE ukm_valid_date_req,
             req_date         TYPE ukm_req_date,
             item_error       TYPE ukm_item_error,
             log_hndl         TYPE balloghndl,
             partner1         TYPE  bu_partner,
             partner2         TYPE bu_partner,
             date_to          TYPE bu_datto,
             date_from        TYPE  bu_datfrom,
             reltyp           TYPE bu_reltyp,
             relkind          TYPE  bu_relkind,
           END OF ty_result.

    TYPES: BEGIN OF /iwbep/s_cod_select_option,
             sign   TYPE char1,
             option TYPE char2,
             low    TYPE string,
             high   TYPE string,
           END OF /iwbep/s_cod_select_option.

    DATA:
      lv_direction                   TYPE char1,

      lr_relationshipbusinesspartner TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_relationshipcategory        TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_relationshiptype            TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_validfromdate               TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_validuntildate              TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,

      lr_ownrating                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_checkrule                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_limitrule                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_ratingvaluedate             TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_ratingchangedate            TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_alternatebp                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_ownratingcalc               TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_riskclass                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_riskclasscalc               TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_riskclasschangedate         TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_creditgroup                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_loghndl                     TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_custgroup                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_coordinator                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_blockreason                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,

      lr_creditsegment               TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_creditlimitcal              TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_creditlimit                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_validtodate                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_reqdate                     TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_limitvaliddate              TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_limitchangedate             TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_followupdate                TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_creditlimitreq              TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_islimitzero                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_isitemerror                 TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_isblocked                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_isautomaticreq              TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_iscritical                  TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,

      lr_classtype                   TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_class                       TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_charc                       TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      lr_charcvalue                  TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,
      ls_searchbusinesspartner       TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchbusinesspartner.


    DATA: lv_search_string TYPE string,
          lt_result        TYPE STANDARD TABLE OF ty_result.

    LOOP AT it_filter_select_options INTO DATA(ls_filter).
      IF ls_filter-property = 'ClassType'.
        lr_classtype = it_filter_select_options[ property = 'ClassType' ]-select_options.
      ELSEIF ls_filter-property = 'Class'.
        lr_class = it_filter_select_options[ property = 'Class' ]-select_options.
      ELSEIF ls_filter-property = 'Charc'.
        lr_charc = it_filter_select_options[ property = 'Charc' ]-select_options.
      ELSEIF ls_filter-property = 'CharcValue'.
        lr_charcvalue = it_filter_select_options[ property = 'CharcValue' ]-select_options.
      ELSEIF ls_filter-property = 'OwnRating'.
        lr_ownrating = it_filter_select_options[ property = 'OwnRating' ]-select_options.
      ELSEIF ls_filter-property = 'CheckRule'.
        lr_checkrule = it_filter_select_options[ property = 'CheckRule' ]-select_options.
      ELSEIF ls_filter-property = 'LimitRule'.
        lr_limitrule = it_filter_select_options[ property = 'LimitRule' ]-select_options.
      ELSEIF ls_filter-property = 'RatingValueDate'.
        lr_ratingvaluedate = it_filter_select_options[ property = 'RatingValueDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_ratingvaluedate ).
      ELSEIF ls_filter-property = 'RatingChangeDate'.
        lr_ratingchangedate = it_filter_select_options[ property = 'RatingChangeDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_ratingchangedate ).
      ELSEIF ls_filter-property = 'AlternateBP'.
        lr_alternatebp = it_filter_select_options[ property = 'AlternateBP' ]-select_options.
      ELSEIF ls_filter-property = 'OwnRatingCalc'.
        lr_ownratingcalc = it_filter_select_options[ property = 'OwnRatingCalc' ]-select_options.
      ELSEIF ls_filter-property = 'RiskClass'.
        lr_riskclass = it_filter_select_options[ property = 'RiskClass' ]-select_options.
      ELSEIF ls_filter-property = 'RiskClassCalc'.
        lr_riskclasscalc = it_filter_select_options[ property = 'RiskClassCalc' ]-select_options.
      ELSEIF ls_filter-property = 'RiskClassChangeDate'.
        lr_riskclasschangedate = it_filter_select_options[ property = 'RiskClassChangeDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_riskclasschangedate ).
      ELSEIF ls_filter-property = 'CreditGroup'.
        lr_creditgroup = it_filter_select_options[ property = 'CreditGroup' ]-select_options.
      ELSEIF ls_filter-property = 'LogHNDL'.
        lr_loghndl = it_filter_select_options[ property = 'LogHNDL' ]-select_options.
      ELSEIF ls_filter-property = 'CustGroup'.
        lr_custgroup = it_filter_select_options[ property = 'CustGroup' ]-select_options.
      ELSEIF ls_filter-property = 'Coordinator'.
        lr_coordinator = it_filter_select_options[ property = 'Coordinator' ]-select_options.
      ELSEIF ls_filter-property = 'BlockReason'.
        lr_blockreason = it_filter_select_options[ property = 'BlockReason' ]-select_options.
      ELSEIF ls_filter-property = 'CreditSegment'.
        lr_creditsegment = it_filter_select_options[ property = 'CreditSegment' ]-select_options.
      ELSEIF ls_filter-property = 'CreditLimitCal'.
        lr_creditlimitcal = it_filter_select_options[ property = 'CreditLimitCal' ]-select_options.
      ELSEIF ls_filter-property = 'CreditLimit'.
        lr_creditlimit = it_filter_select_options[ property = 'CreditLimit' ]-select_options.
      ELSEIF ls_filter-property = 'ValidToDate'.
        lr_validtodate = it_filter_select_options[ property = 'ValidToDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_validtodate ).
      ELSEIF ls_filter-property = 'ReqDate'.
        lr_reqdate = it_filter_select_options[ property = 'ReqDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_reqdate ).
      ELSEIF ls_filter-property = 'LimitValidDate'.
        lr_limitvaliddate = it_filter_select_options[ property = 'LimitValidDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_limitvaliddate ).
      ELSEIF ls_filter-property = 'LimitChangeDate'.
        lr_limitchangedate = it_filter_select_options[ property = 'LimitChangeDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_limitchangedate ).
      ELSEIF ls_filter-property = 'FollowUpDate'.
        lr_followupdate = it_filter_select_options[ property = 'FollowUpDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_followupdate ).
      ELSEIF ls_filter-property = 'CreditLimitReq'.
        lr_creditlimitreq = it_filter_select_options[ property = 'CreditLimitReq' ]-select_options.
      ELSEIF ls_filter-property = 'IsLimitZero'.
        lr_islimitzero = it_filter_select_options[ property = 'IsLimitZero' ]-select_options.
      ELSEIF ls_filter-property = 'IsItemError'.
        lr_isitemerror = it_filter_select_options[ property = 'IsItemError' ]-select_options.
      ELSEIF ls_filter-property = 'IsBlocked'.
        lr_isblocked = it_filter_select_options[ property = 'IsBlocked' ]-select_options.
      ELSEIF ls_filter-property = 'IsAutomaticReq'.
        lr_isautomaticreq = it_filter_select_options[ property = 'IsAutomaticReq' ]-select_options.
      ELSEIF ls_filter-property = 'IsCritical'.
        lr_iscritical = it_filter_select_options[ property = 'IsCritical' ]-select_options.

      ELSEIF ls_filter-property = 'RelationshipCategory'.
        lr_relationshipcategory = it_filter_select_options[ property = 'RelationshipCategory' ]-select_options.
      ELSEIF ls_filter-property = 'lr_RelationshipType'.
        lr_relationshiptype = it_filter_select_options[ property = 'lr_RelationshipType' ]-select_options.
      ELSEIF ls_filter-property = 'RelationshipBusinessPartner'.
        lr_relationshipbusinesspartner = it_filter_select_options[ property = 'RelationshipBusinessPartner' ]-select_options.
      ELSEIF ls_filter-property = 'ValidFromDate'.
        lr_validfromdate = it_filter_select_options[ property = 'ValidFromDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_validfromdate ).
      ELSEIF ls_filter-property = 'ValidUntilDate'.
        lr_validuntildate = it_filter_select_options[ property = 'ValidUntilDate' ]-select_options.
        convert_timestamp_to_date_op( CHANGING ct_select_option = lr_validuntildate ).
      ENDIF.
    ENDLOOP.

    "-- Data Selection
    "Search class
    IF lr_classtype IS NOT INITIAL OR lr_class IS NOT INITIAL OR
      lr_charc IS NOT INITIAL OR lr_charcvalue IS NOT INITIAL.
      SELECT a~objek,
             a~klart,
             b~class,
             c~atwrt,
             d~atnam
        FROM kssk AS a
       INNER JOIN klah AS b
          ON a~clint = b~clint
       INNER JOIN ausp AS c
          ON a~objek = c~objek
       INNER JOIN cabn AS d
          ON c~atinn = d~atinn
        INTO CORRESPONDING FIELDS OF TABLE @lt_result
       WHERE a~klart IN @lr_classtype
         AND b~class IN @lr_class
         AND d~atnam IN @lr_charc
         AND c~atwrt IN @lr_charcvalue.

      IF lt_result IS NOT INITIAL.
        LOOP AT lt_result INTO DATA(ls_result).
          ls_searchbusinesspartner-businesspartner = ls_result-objek.
          ls_searchbusinesspartner-charc = ls_result-atnam.
          ls_searchbusinesspartner-charcvalue = ls_result-atwrt.
          ls_searchbusinesspartner-class = ls_result-class.
          ls_searchbusinesspartner-classtype = ls_result-klart.
          APPEND ls_searchbusinesspartner TO et_entityset.
          CLEAR ls_searchbusinesspartner.
        ENDLOOP.
        CLEAR lt_result.
      ENDIF.
    ENDIF.



    "Search credit profile
    IF lr_ownrating IS NOT INITIAL OR lr_checkrule IS NOT INITIAL
      OR lr_limitrule IS NOT INITIAL OR lr_ratingvaluedate IS NOT INITIAL OR
      lr_ratingchangedate IS NOT INITIAL OR lr_alternatebp IS NOT INITIAL OR
      lr_ownratingcalc IS NOT INITIAL OR lr_riskclass IS NOT INITIAL OR
      lr_riskclasscalc IS NOT INITIAL OR lr_riskclasschangedate IS NOT INITIAL OR
      lr_creditgroup IS NOT INITIAL.

      SELECT partner
             own_rating
             check_rule
             limit_rule
             rating_val_date
             rating_chg_date
             alternate_bp
             own_rating_calc
             risk_class
             risk_class_calc
             risk_class_chgdt
             credit_group
        FROM ukmbp_cms AS a
        INTO CORRESPONDING FIELDS OF TABLE lt_result
       WHERE own_rating IN lr_classtype
         AND check_rule IN lr_checkrule
         AND limit_rule IN lr_charc
         AND rating_val_date IN lr_ratingvaluedate
         AND rating_chg_date IN lr_ratingchangedate
         AND alternate_bp IN lr_alternatebp
         AND own_rating_calc IN lr_ownratingcalc
         AND risk_class IN lr_riskclass
         AND risk_class_calc IN lr_riskclasscalc
         AND risk_class_chgdt IN lr_riskclasschangedate
         AND credit_group IN lr_creditgroup.

      IF lt_result IS NOT INITIAL.
        LOOP AT lt_result INTO ls_result.
          ls_searchbusinesspartner-businesspartner = ls_result-partner.
          APPEND ls_searchbusinesspartner TO et_entityset.
          CLEAR ls_searchbusinesspartner.
        ENDLOOP.
      ENDIF.
      CLEAR lt_result.
    ENDIF.

    "Search credit segment
    IF lr_creditsegment IS NOT INITIAL OR lr_creditlimitcal IS NOT INITIAL
      OR lr_creditlimit IS NOT INITIAL OR lr_validtodate IS NOT INITIAL OR
      lr_reqdate IS NOT INITIAL OR lr_limitvaliddate IS NOT INITIAL OR
      lr_limitchangedate IS NOT INITIAL OR lr_followupdate IS NOT INITIAL OR
      lr_creditlimitreq IS NOT INITIAL OR lr_islimitzero IS NOT INITIAL OR
      lr_isitemerror IS NOT INITIAL OR lr_isblocked IS NOT INITIAL OR
      lr_isautomaticreq IS NOT INITIAL OR lr_iscritical IS NOT INITIAL OR lr_coordinator IS NOT INITIAL
      OR lr_custgroup IS NOT INITIAL OR lr_loghndl IS NOT INITIAL.

      SELECT partner
        FROM ukmbp_cms_sgm AS a
        INTO CORRESPONDING FIELDS OF TABLE lt_result
       WHERE credit_sgmnt IN lr_creditsegment
         AND credit_limit IN lr_creditlimit
         AND cred_lim_calc IN lr_creditlimitcal
         AND xblocked IN lr_isblocked
         AND limit_valid_date IN lr_validtodate
         AND limit_chg_date IN lr_limitchangedate
         AND coordinator IN lr_coordinator
         AND cust_group IN lr_custgroup
         AND follow_up_dt IN lr_followupdate
         AND xcritical IN lr_iscritical
         AND block_reason IN lr_isblocked
         AND cred_lim_req IN lr_creditlimitreq
         AND automatic_req IN lr_isautomaticreq
         AND lim_val_date_req IN lr_limitvaliddate
         AND req_date IN lr_reqdate
         AND item_error IN lr_isitemerror
         AND log_hndl IN lr_loghndl.

      IF lt_result IS NOT INITIAL.
        LOOP AT lt_result INTO ls_result.
          ls_searchbusinesspartner-businesspartner = ls_result-partner.
          APPEND ls_searchbusinesspartner TO et_entityset.
          CLEAR ls_searchbusinesspartner.
        ENDLOOP.
        CLEAR lt_result.
      ENDIF.

    ENDIF.

    "--Search Relationship
    IF lr_relationshipbusinesspartner IS NOT INITIAL OR lr_relationshipcategory IS NOT INITIAL
      OR lr_relationshiptype IS NOT INITIAL OR lr_validfromdate IS NOT INITIAL
      OR lr_validuntildate IS NOT INITIAL.

      IF lr_relationshipcategory IS NOT INITIAL.
        LOOP AT lr_relationshipcategory ASSIGNING FIELD-SYMBOL(<lrs_relationshipcategory>).
          IF strlen( <lrs_relationshipcategory>-low ) = 8.

          ELSE.
            SHIFT <lrs_relationshipcategory>-low  BY 1 PLACES.
            lv_direction = <lrs_relationshipcategory>-low(1).
            SHIFT <lrs_relationshipcategory>-low  BY 1 PLACES.
            CONCATENATE '*' <lrs_relationshipcategory>-low INTO <lrs_relationshipcategory>-low.
          ENDIF.
        ENDLOOP.
      ENDIF.

      SELECT partner1
             partner2
        FROM but050
        INTO CORRESPONDING FIELDS OF TABLE lt_result
       WHERE partner2 IN lr_relationshipbusinesspartner
         AND date_from IN lr_validfromdate
         AND date_to IN lr_validuntildate
         AND reltyp IN lr_relationshipcategory
         AND relkind IN lr_relationshiptype.

      IF lt_result IS NOT INITIAL.
        LOOP AT lt_result INTO ls_result.
          IF lv_direction = 'T'.
            ls_searchbusinesspartner-businesspartner = ls_result-partner1.
            APPEND ls_searchbusinesspartner TO et_entityset.
            CLEAR ls_searchbusinesspartner.
          ELSEIF lv_direction = 'F'.
            ls_searchbusinesspartner-businesspartner = ls_result-partner2.
            APPEND ls_searchbusinesspartner TO et_entityset.
            CLEAR ls_searchbusinesspartner.
          ELSE.
            ls_searchbusinesspartner-businesspartner = ls_result-partner1.
            APPEND ls_searchbusinesspartner TO et_entityset.
            CLEAR ls_searchbusinesspartner.
            ls_searchbusinesspartner-businesspartner = ls_result-partner2.
            APPEND ls_searchbusinesspartner TO et_entityset.
            CLEAR ls_searchbusinesspartner.
          ENDIF.
        ENDLOOP.
        CLEAR lt_result.
      ENDIF.
    ENDIF.

    SORT et_entityset BY businesspartner.

    DELETE ADJACENT DUPLICATES FROM et_entityset COMPARING businesspartner.


  ENDMETHOD.


  METHOD update_log_table.
    DATA: lv_date LIKE sy-datum.
    CALL FUNCTION 'ENQUEUE_/SIMPLE/EAPILOG'
      EXPORTING
        mode_/simple/api_log = 'E'
        client               = sy-mandt
*       cr_number            = is_log-cr_number
*       cr_item              = is_log-cr_item
        mdglogid             = is_log-mdglogid
*       X_CR_NUMBER          = ' '
*       X_CR_ITEM            = ' '
*       _SCOPE               = '2'
*       _WAIT                = ' '
*       _COLLECT             = ' '
      EXCEPTIONS
        foreign_lock         = 1
        system_failure       = 2
        OTHERS               = 3.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    MODIFY /simple/api_log FROM is_log.

    lv_date = sy-datum - 30.
    SELECT * FROM /simple/api_log WHERE changedat < @lv_date INTO TABLE @DATA(lt_apilog).
    DELETE /simple/api_log FROM TABLE lt_apilog.

    CALL FUNCTION 'DEQUEUE_/SIMPLE/EAPILOG'
      EXPORTING
        mode_/simple/api_log = 'E'
        client               = sy-mandt
*       cr_number            = is_log-cr_number
*       cr_item              = is_log-cr_item
        mdglogid             = is_log-mdglogid
*       X_CR_NUMBER          = ' '
*       X_CR_ITEM            = ' '
*       _SCOPE               = '3'
*       _SYNCHRON            = ' '
*       _COLLECT             = ' '
      .
  ENDMETHOD.


  METHOD xsimplexmdrela01_get_entityset.
    TYPES:
      BEGIN OF ty_description,
        reltyp  TYPE bu_reltyp,
        bez50   TYPE bu_bez50,
        bez50_2 TYPE bu_bez50,
        laiso   TYPE laiso,
      END OF ty_description.

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
      ls_entityset TYPE /simple/cl_mdg_gw_core_mpc=>ts_xsimplexmdrelationshiptype.

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

        LOOP AT lt_reltyp_data INTO ls_reltyp_data.
          ls_entityset-differentiationtype = ls_reltyp_data-dftyp.
          IF ls_reltyp_data-xdirection IS INITIAL.
            IF ls_reltyp_data-xpers_p1 = 'X'.
              ls_entityset-businesspartnercategory = '1'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              LOOP AT lt_description INTO DATA(ls_description)
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO et_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xorga_p1 = 'X'.
              ls_entityset-businesspartnercategory = '2'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO et_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
            IF ls_reltyp_data-xgrou_p1 = 'X'.
              ls_entityset-businesspartnercategory = '3'.
              ls_entityset-relationshipcategory = ls_reltyp_data-reltyp.
              LOOP AT lt_description INTO ls_description
                WHERE reltyp = ls_reltyp_data-reltyp.
                ls_entityset-description = ls_description-bez50.
                ls_entityset-locale = ls_description-laiso.
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
                CLEAR:
                  ls_entityset-description,
                  ls_entityset-locale.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.

    ENDTRY.
  ENDMETHOD.


  METHOD xsimplexmdrela02_get_entityset.
    TYPES:
      BEGIN OF ty_description,
        reltyp  TYPE bu_reltyp,
        relkind TYPE bu_relkind,
        text30  TYPE bu_bez30,
        laiso   TYPE laiso,
      END OF ty_description.

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
      ls_entityset TYPE /simple/cl_mdg_gw_core_mpc=>ts_xsimplexmdrelationshiptypet.

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
              APPEND ls_entityset TO et_entityset.
              CLEAR ls_entityset-relationshipcategory.
            ELSE.
              IF ls_reltyp_data-xpers_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xpers_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xorga_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xorga_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xgrou_p1 = 'X'.
                CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ENDIF.
              IF ls_reltyp_data-xgrou_p2 = 'X'.
                CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                APPEND ls_entityset TO et_entityset.
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
                APPEND ls_entityset TO et_entityset.
                CLEAR ls_entityset-relationshipcategory.
              ELSE.
                IF ls_reltyp_data-xpers_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xpers_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xorga_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xorga_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xgrou_p1 = 'X'.
                  CONCATENATE 'F' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
                  CLEAR ls_entityset-relationshipcategory.
                ENDIF.
                IF ls_reltyp_data-xgrou_p2 = 'X'.
                  CONCATENATE 'T' ls_reltyp_data-reltyp INTO ls_entityset-relationshipcategory.
                  APPEND ls_entityset TO et_entityset.
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
  ENDMETHOD.


  METHOD xsimplexmdtaxcat_get_entityset.
    CONSTANTS: lc_msgrf TYPE msgid VALUE 'RF',
               lc_txt19 TYPE txtnr_050t VALUE '0019',
               lc_txt20 TYPE txtnr_050t VALUE '0020',
               lc_txt21 TYPE txtnr_050t VALUE '0021',
               lc_txt22 TYPE txtnr_050t VALUE '0022',
               lc_txt23 TYPE txtnr_050t VALUE '0023',
               lc_txt24 TYPE txtnr_050t VALUE '0024',
               lc_txt25 TYPE txtnr_050t VALUE '0025'.

    DATA: lt_taxcat_tmp TYPE /simple/cl_mdg_gw_core_mpc=>tt_xsimplexmdtaxcategorytype,
          ls_taxcat     TYPE /simple/cl_mdg_gw_core_mpc=>ts_xsimplexmdtaxcategorytype.

    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = lt_taxcat_tmp
                                                             es_response_context     = es_response_context ).

*    SELECT *
*      FROM T683
*      into table @data(lt_t683)
*      WHERE kvewe = 'A' and
*            kappl = 'TX'.


    SELECT *
      FROM t050t
      INTO TABLE @DATA(lt_t050t)
      WHERE msgid = 'RF'
      AND txtnr BETWEEN @lc_txt19 AND @lc_txt25
         AND spras = @sy-langu.

*    LOOP AT lt_t683 into data(ls_t683).
*      ls_taxcat-procedureid = ls_t683-kalsm.
*
*      LOOP AT lt_t050t into data(ls_t050t).
*        CASE ls_t050t-txtnr.
*          WHEN lc_txt19.
*            ls_taxcat-taxcode = '- '.
*          WHEN lc_txt20.
*            ls_taxcat-taxcode = '+ '.
*          WHEN lc_txt21.
*            ls_taxcat-taxcode = '* '.
*          WHEN lc_txt22.
*            ls_taxcat-taxcode = '< '.
*          WHEN lc_txt23.
*            ls_taxcat-taxcode = '> '.
*          WHEN lc_txt24.
*            ls_taxcat-taxcode = '+B'.
*          WHEN lc_txt25.
*            ls_taxcat-taxcode = '-B'.
*        ENDCASE.
*
*        ls_taxcat-locale = ls_t050t-spras.
*        ls_taxcat-description = ls_t050t-ltext.
*
*        APPEND ls_taxcat TO ET_ENTITYSET.
*
*        CLEAR:  ls_taxcat-taxcode,
*                ls_taxcat-locale,
*                ls_taxcat-description.
*      ENDLOOP.
*
*      CLEAR ls_taxcat.
*    ENDLOOP.
    READ TABLE lt_taxcat_tmp INTO DATA(ls_taxcat_tmp) INDEX 1.
    IF sy-subrc = 0.
      ls_taxcat-procedureid = ls_taxcat_tmp-procedureid.
      ls_taxcat-companycode = ls_taxcat_tmp-companycode.
    ENDIF.
    LOOP AT lt_t050t INTO DATA(ls_t050t).
      CASE ls_t050t-txtnr.
        WHEN lc_txt19.
          ls_taxcat-taxcode = '- '.
        WHEN lc_txt20.
          ls_taxcat-taxcode = '+ '.
        WHEN lc_txt21.
          ls_taxcat-taxcode = '* '.
        WHEN lc_txt22.
          ls_taxcat-taxcode = '< '.
        WHEN lc_txt23.
          ls_taxcat-taxcode = '> '.
        WHEN lc_txt24.
          ls_taxcat-taxcode = '+B'.
        WHEN lc_txt25.
          ls_taxcat-taxcode = '-B'.
      ENDCASE.

      ls_taxcat-locale = ls_t050t-spras.
      ls_taxcat-description = ls_t050t-ltext.

      APPEND ls_taxcat TO et_entityset.

      CLEAR:  ls_taxcat-taxcode,
              ls_taxcat-locale,
              ls_taxcat-description.
    ENDLOOP.

    APPEND LINES OF lt_taxcat_tmp TO et_entityset.

  ENDMETHOD.
ENDCLASS.
