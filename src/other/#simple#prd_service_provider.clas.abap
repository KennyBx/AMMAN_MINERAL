**********************************************************************
*
* Service Provider class
*
**********************************************************************
class /SIMPLE/PRD_SERVICE_PROVIDER definition
  public
  final
  create private .

public section.

  interfaces /SIMPLE/IF_MDG_SRV_PROVIDER .

  types:
    t_mapped_late TYPE TABLE FOR MAPPED LATE /simple/c_product .
  types:
    BEGIN OF gty_prd_key_log,
        product TYPE /simple/c_product-product,
      END   OF gty_prd_key_log .
  types:
    BEGIN OF gty_charc,
        class TYPE klah-class,
        klart TYPE klah-klart,
        atnam TYPE cabn-atnam,
        value TYPE ausp-atwrt,
      END OF gty_charc .
  types:
    gty_t_charc TYPE STANDARD TABLE OF gty_charc WITH DEFAULT KEY .
  types:
    BEGIN OF gty_ausp,
        class TYPE klah-class,
        klart TYPE tcla-klart,
        atnam TYPE cabn-atnam,
        atfor TYPE cabn-atfor,
        mazst TYPE cabn-anzst,
        mazdz TYPE cabn-anzdz,
        atdex TYPE cabn-atdex,
        atdim TYPE cabn-atdim,
        mvorz TYPE cabn-atvor,
        mscha TYPE cabn-atsch,
        meinh TYPE cabn-msehi,
        miwrt TYPE cabn-atint,
        atkle TYPE cabn-atkle,
        atein TYPE cabn-atein,
        atson TYPE cabn-atson,
      END   OF gty_ausp .
  types:
    gty_t_ausp TYPE STANDARD TABLE OF gty_ausp WITH DEFAULT KEY .
  types:
    BEGIN OF gty_plant.
        INCLUDE TYPE /simple/c_productplant.
    TYPES:
        to_storagelocation             TYPE STANDARD TABLE OF /simple/c_prdstoragelocation WITH DEFAULT KEY,
        to_productplantprocurement     TYPE /simple/c_prdplantprocurement,
        to_productworkscheduling       TYPE /simple/c_prdworkscheduling,
        to_productsupplyplanning       TYPE /simple/c_prdsupplyplanning,
        to_prodplantinternationaltrade TYPE /simple/c_prdplantintltrd,
        to_productplantcosting         TYPE /simple/c_prdplantcosting,
        to_productplantforecast        TYPE /simple/c_prdplantforecasting,
        to_plantqualitymgmt            TYPE /simple/c_prdplantqualitymgmt,
        to_plantsales                  TYPE /simple/c_prdplantsales,
        to_plantstorage                TYPE /simple/c_prdplantstorage,
        to_planttext                   TYPE /simple/c_prdplanttext,
        to_plantmrparea                TYPE STANDARD TABLE OF /simple/c_prdplantmrparea WITH DEFAULT KEY,
        to_insptypesttng               TYPE STANDARD TABLE OF /simple/c_prdinsptypesttng WITH DEFAULT KEY,
        to_prodplntfcstparam           TYPE /simple/c_prdplntfcstparams,
        to_productresourcetool         TYPE /simple/c_prdprt,
      END OF gty_plant .
  types:
    BEGIN OF gty_sales.
        INCLUDE TYPE /simple/c_productsalesdelivery.
    TYPES: to_salestext TYPE STANDARD TABLE OF /simple/c_productsalestext WITH DEFAULT KEY,
      END OF gty_sales .
  types:
    BEGIN OF gty_uom.
        INCLUDE TYPE /simple/c_prdunitsofmeasure.
    TYPES: to_internationalarticlenumber TYPE STANDARD TABLE OF /simple/c_prdunitsofmeasureean WITH DEFAULT KEY,
      END OF gty_uom .
  types:
    BEGIN OF gty_valuation.
        INCLUDE TYPE /simple/c_productvaluation.
    TYPES:
        to_valuationaccount TYPE /simple/c_prdvaluationaccount,
        to_mlaccount        TYPE STANDARD TABLE OF /simple/c_productmlaccount WITH DEFAULT KEY,
        to_mlprices         TYPE STANDARD TABLE OF /simple/c_productmlprices WITH DEFAULT KEY,
      END OF gty_valuation .
  types:
    gty_valuation_tab TYPE STANDARD TABLE OF gty_valuation WITH DEFAULT KEY .
  types:
    BEGIN OF gty_warehouse.
        INCLUDE TYPE /simple/c_productwarehouse.
    TYPES: to_productstoragetype TYPE STANDARD TABLE OF /simple/c_productstoragetype WITH DEFAULT KEY,
      END OF gty_warehouse .
  types:
    BEGIN OF gty_classification.
        INCLUDE TYPE /simple/c_prdclassification.
    TYPES: to_characteristic TYPE STANDARD TABLE OF /simple/c_prdcharacteristic WITH DEFAULT KEY,
      END OF gty_classification .
  types:
    BEGIN OF gty_deep_data.
        INCLUDE TYPE /simple/c_product.
    TYPES:
        cid                      TYPE string,
        to_description           TYPE STANDARD TABLE OF /simple/c_productdescription WITH DEFAULT KEY,
        to_plant                 TYPE STANDARD TABLE OF gty_plant WITH DEFAULT KEY,
        to_salesdelivery         TYPE STANDARD TABLE OF gty_sales WITH DEFAULT KEY,
        to_productsalestax       TYPE STANDARD TABLE OF /simple/c_productsalestax WITH DEFAULT KEY,
        to_productsales          TYPE /simple/c_productsales,
        to_productqualitymgmt    TYPE /simple/c_productqualitymgmt,
        to_productprocurement    TYPE /simple/c_productprocurement,
        to_productbasictext      TYPE STANDARD TABLE OF /simple/c_productbasictext WITH DEFAULT KEY,
        to_productunitsofmeasure TYPE STANDARD TABLE OF gty_uom WITH DEFAULT KEY,
        to_productstorage        TYPE /simple/c_productstorage,
        to_productinspectiontext TYPE STANDARD TABLE OF /simple/c_prdinspectiontext WITH DEFAULT KEY,
        to_productpurchasetext   TYPE STANDARD TABLE OF /simple/c_productpurchasetext WITH DEFAULT KEY,
*        to_valuation             TYPE /simple/prd_val_t, " STANDARD TABLE OF gty_valuation WITH DEFAULT KEY, "25.12.2023 elsa rem code & update
        to_valuation             TYPE STANDARD TABLE OF gty_valuation WITH DEFAULT KEY,
        to_productwarehouse      TYPE STANDARD TABLE OF gty_warehouse WITH DEFAULT KEY,
        to_classification        TYPE STANDARD TABLE OF gty_classification WITH DEFAULT KEY,
        to_prdextendwarehouse    TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse WITH DEFAULT KEY,
      END OF gty_deep_data .
  types:
    BEGIN OF gty_conv_period,
        bukrs TYPE bukrs,
        budat TYPE budat,
        gjahr TYPE bdatj,
        poper TYPE poper,
      END   OF gty_conv_period .
  types:
    gty_t_conv_period TYPE SORTED TABLE OF gty_conv_period
                               WITH UNIQUE KEY bukrs
                                               budat .
  types:
    BEGIN OF gty_t001wk,
        bukrs TYPE bukrs,
        werks TYPE werks,
        bwkey TYPE bwkey,
      END   OF gty_t001wk .
  types:
    gty_t_t001wk TYPE SORTED TABLE OF gty_t001wk
                          WITH UNIQUE KEY bukrs
                                          werks .
  types:
    BEGIN OF gty_curr,
        curtp  TYPE cki_ml_cty-curtp,
        waers  TYPE cki_ml_cty-waers,
        text   TYPE cki_ml_cty-text,
        text10 TYPE cki_ml_cty-text10,
        kurst  TYPE cki_ml_cty-kurst,
      END OF gty_curr .
  types:
    gty_t_curr TYPE STANDARD TABLE OF gty_curr .
  types:
    BEGIN OF gty_allcurr,
        icurtp   TYPE cki_mr21_input-curtp,
        one_curr TYPE STANDARD TABLE OF cki_mr21_input WITH DEFAULT KEY,
      END   OF gty_allcurr .
  types:
    gty_t_allcurr TYPE STANDARD TABLE OF gty_allcurr WITH DEFAULT KEY .
  types:
    BEGIN OF gty_mr21_change,
        fieldchange TYPE string,
        auto_conv   TYPE flag,
        price       TYPE mbew-stprs,
        priceunit   TYPE mbew-peinh,
      END   OF gty_mr21_change .
  types:
    BEGIN OF gty_str_price_change,
        bukrs     TYPE mr21head-bukrs,
        budat     TYPE mr21head-budat,
        bdatj     TYPE ckmlpp-bdatj,
        poper     TYPE ckmlpp-poper,
        t_allcurr TYPE gty_t_allcurr,
      END   OF gty_str_price_change .
  types:
    gty_t_str_price_change TYPE STANDARD TABLE OF gty_str_price_change
                                                 WITH DEFAULT KEY .
  types:
    BEGIN OF gty_matcb,
        kalnr  TYPE mbew-kaln1,
        ckmlpr TYPE t_ckmlpr,
      END OF gty_matcb .
  types:
    gty_matcb_tbl TYPE SORTED TABLE OF gty_matcb
                      WITH UNIQUE KEY
                      kalnr .
  types:
    BEGIN OF gty_kekocb,
        kalnr TYPE mbew-kaln1,
        keko  TYPE t_keko,
      END OF gty_kekocb .
  types:
    gty_kekocb_tbl TYPE SORTED TABLE OF gty_kekocb
                      WITH UNIQUE KEY
                      kalnr .
  types:
    gty_t_ckmpr_mat_price TYPE STANDARD TABLE OF ckmpr_f_mat_price WITH DEFAULT KEY .

  class-data GV_MDG type C .
  class-data GV_STATUS type /SIMPLE/API_LOG-STATUS .                     "BEN
  class-data GV_STEP type /SIMPLE/API_LOG-STEP .                       "BEN
  constants GC_MATNR_TMP type MATNR value '!!ABCD' ##NO_TEXT.
  constants:
    BEGIN OF gc_entity,
        product                     TYPE string VALUE 'PRODUCT' ##NO_TEXT,
        description                 TYPE string VALUE 'DESCRIPTION' ##NO_TEXT,
        plant                       TYPE string VALUE 'PLANT' ##NO_TEXT,
        salesdelivery               TYPE string VALUE 'SALESDELIVERY' ##NO_TEXT,
        productsalestax             TYPE string VALUE 'PRODUCTSALESTAX' ##NO_TEXT,
        productsales                TYPE string VALUE 'PRODUCTSALES' ##NO_TEXT,
        productqualitymgmt          TYPE string VALUE 'PRODUCTQUALITYMGMT' ##NO_TEXT,
        productprocurement          TYPE string VALUE 'PRODUCTPROCUREMENT' ##NO_TEXT,
        productbasictext            TYPE string VALUE 'PRODUCTBASICTEXT' ##NO_TEXT,
        productunitsofmeasure       TYPE string VALUE 'PRODUCTUNITSOFMEASURE' ##NO_TEXT,
        productstorage              TYPE string VALUE 'PRODUCTSTORAGE' ##NO_TEXT,
        productinspectiontext       TYPE string VALUE 'PRODUCTINSPECTIONTEXT' ##NO_TEXT,
        productpurchasetext         TYPE string VALUE 'PRODUCTPURCHASETEXT' ##NO_TEXT,
        valuation                   TYPE string VALUE 'VALUATION' ##NO_TEXT,
        productwarehouse            TYPE string VALUE 'PRODUCTWAREHOUSE' ##NO_TEXT,
        storagelocation             TYPE string VALUE 'STORAGELOCATION' ##NO_TEXT,
        productplantprocurement     TYPE string VALUE 'PRODUCTPLANTPROCUREMENT' ##NO_TEXT,
        productworkscheduling       TYPE string VALUE 'PRODUCTWORKSCHEDULING' ##NO_TEXT,
        productsupplyplanning       TYPE string VALUE 'PRODUCTSUPPLYPLANNING' ##NO_TEXT,
        prodplantinternationaltrade TYPE string VALUE 'PRODPLANTINTERNATIONALTRADE' ##NO_TEXT,
        productplantcosting         TYPE string VALUE 'PRODUCTPLANTCOSTING' ##NO_TEXT,
        productplantforecast        TYPE string VALUE 'PRODUCTPLANTFORECAST' ##NO_TEXT,
        plantqualitymgmt            TYPE string VALUE 'PLANTQUALITYMGMT' ##NO_TEXT,
        plantsales                  TYPE string VALUE 'PLANTSALES' ##NO_TEXT,
        plantstorage                TYPE string VALUE 'PLANTSTORAGE' ##NO_TEXT,
        planttext                   TYPE string VALUE 'PLANTTEXT' ##NO_TEXT,
        plantmrparea                TYPE string VALUE 'PLANTMRPAREA' ##NO_TEXT,
        insptypesttng               TYPE string VALUE 'INSPTYPESTTNG' ##NO_TEXT,
        prodplntfcstparam           TYPE string VALUE 'PRODPLNTFCSTPARAM' ##NO_TEXT,
        salestext                   TYPE string VALUE 'SALESTEXT' ##NO_TEXT,
        internationalarticlenumber  TYPE string VALUE 'INTERNATIONALARTICLENUMBER' ##NO_TEXT,
        valuationaccount            TYPE string VALUE 'VALUATIONACCOUNT' ##NO_TEXT,
        mlaccount                   TYPE string VALUE 'MLACCOUNT' ##NO_TEXT,
        mlprices                    TYPE string VALUE 'MLPRICES' ##NO_TEXT,
        productstoragetype          TYPE string VALUE 'PRODUCTSTORAGETYPE' ##NO_TEXT,
        productionresourcetool      TYPE string VALUE 'PRODUCTRESOURCETOOL' ##NO_TEXT,
        productplanning             TYPE string VALUE 'PRODUCTPLANNING' ##NO_TEXT,
        prdextendwarehouse          TYPE string VALUE 'PRDEXTENDWAREHOUSE',
      END OF gc_entity .
  data GS_DATA_RESPONSE type GTY_DEEP_DATA .
  data GT_AUSP type GTY_T_AUSP .
  data GT_CONV_PERIOD type GTY_T_CONV_PERIOD .
  data GT_T001WK type GTY_T_T001WK .
  data:
      " JHOANG add for Product Warehouse - 27/10/2023 - start
    gt_matlwh TYPE STANDARD TABLE OF /sapapo/matlwh .

    " JHOANG add for Product Warehouse - 27/10/2023 - end
  class-methods GET_INSTANCE
    returning
      value(RO_OBJECT) type ref to /SIMPLE/PRD_SERVICE_PROVIDER .
*    METHODS map_response
*      CHANGING
*        !cr_data TYPE /simple/prd_service_provider=>gty_deep_data .
  methods MAP_FIELDS
    importing
      !IV_ENTITY_NAME type STRING
      !IV_INPUT_STRU type ANY
      !IV_INPUT_STRU_DB type ANY optional
    changing
      !EV_OUTPUT_STRU type ANY
      !EV_OUTPUT_STRU_X type ANY optional .
  methods SET_DATA
    importing
      !IS_DATA type GTY_DEEP_DATA .
  methods CREATE_APPL_LOG .
  methods GET_OBJECT_KEY
    exporting
      !EV_CID type STRING
      !EV_PRODUCT type /SIMPLE/C_PRODUCT-PRODUCT
      !EV_BACKGROUND type STRING .
  methods UPDATE_LOG_TABLE
    importing
      !IV_SAVE type C default SPACE
      !IV_STATUS type /SIMPLE/API_LOG-STATUS
      !IV_STEP type /SIMPLE/API_LOG-STEP .
  methods EXECUTE_API_RFC
    importing
      !IS_MAT type CMD_BS_MAT_S_MAT_DATA
      !IV_MRP_OPERATION type CHAR1
      !IV_TEST_MODE type XFELD optional
      !IT_QMAT_INS type CMD_BS_MAT_T_QMAT optional
      !IT_QMAT_UPD type CMD_BS_MAT_T_QMAT optional
      !IT_QMAT_DEL type CMD_BS_MAT_T_QMAT optional
      !IT_QMAT_X type CMD_BS_MAT_T_QMAT_X optional
      !IT_VALUATION type GTY_DEEP_DATA-TO_VALUATION optional
    exporting
      value(EV_PRODUCT) type MATNR
      !ET_MESSAGE type BAPIRET2_T .
  methods EXECUTE_PRICE_CHANGE
    importing
      !IT_VALUATUON type /SIMPLE/PRD_VAL_T
      !IV_ACTIONMODE type CHAR20
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods GET_RAW_DATA
    returning
      value(RV_RAW_DATA) type STRING .
  methods ADJUST_NUMBER
    exporting
      !ET_MAPPED type T_MAPPED_LATE .
  methods GET_ACTION
    returning
      value(EV_ACTION) type CHAR50 .
  methods GET_ACTION_MODE
    returning
      value(EV_ACTION_MODE) type /SIMPLE/C_PRODUCT-ACTIONMODE .
  methods _EXECUTE_PRODUCT_WAREHOUSE .
  methods CHECK_ML_DATA
    importing
      !IT_VALUATION type GTY_DEEP_DATA-TO_VALUATION
      !IT_CKMLHD type CMD_BS_MAT_T_MLA_CKMLHD
      !IT_CKMLCR type CMD_BS_MAT_T_MLA_CKMLCR
      !IT_CKMLPR type CMD_BS_MAT_T_MLA_CKMLPR
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG .
  PROTECTED SECTION.
private section.

  class-data GO_OBJECT type ref to /SIMPLE/PRD_SERVICE_PROVIDER .
  data GS_DATA type GTY_DEEP_DATA .
  data GV_RAW_DATA type STRING .
  data GV_LOG_HANDLE type BALLOGHNDL .
  data GV_EXTERNAL_LOG_NO type BALHDRI-EXTNUMBER .
  data GT_MESSAGE type BAPIRET2_T .
  data GS_LOG type /SIMPLE/API_LOG .
  data GS_MAT type CMD_BS_MAT_S_MAT_DATA .
  data GV_TESTRUN type ABAP_BOOL .
  data GT_QMAT_INS type CMD_BS_MAT_T_QMAT .
  data GT_QMAT_UPD type CMD_BS_MAT_T_QMAT .
  data GT_QMAT_DEL type CMD_BS_MAT_T_QMAT .
  data GT_QMAT_X type CMD_BS_MAT_T_QMAT_X .
  data MT_VAL_KEYS type /SIMPLE/VAL_KEY_T .
  data GV_PRODUCT type MATNR .
  data MV_MRP_OPERATION type C .
  data GT_CLASSIFICATION type /SIMPLE/CLFN_T .
  data GS_REVISIONLEVEL type AEOI .

  methods _VALIDATE_PRICE_CHANGE
    importing
      !IT_VALUATION type GTY_VALUATION_TAB .
  methods _PROCESS_CHANGE_PRICE
    importing
      !IT_VALUATION type GTY_VALUATION_TAB
      !IV_ACTIONMODE type CHAR20
    exporting
      !ET_RETURN type BAPIRET2_T .
  methods _GET_ALL_CURTP
    importing
      !IV_BUKRS type BUKRS
      !IV_BWKEY type BWKEY
    exporting
      !ET_ALLCURTP type GTY_T_ALLCURR
      !ET_RETURN type BAPIRET2_T .
  methods _CHECK_MATERIAL
    importing
      !IV_BWKEY type BWKEY
      !IV_MATNR type MATNR
      !IV_BUKRS type BUKRS
      !IV_BDATJ type BDATJ
      !IV_POPER type POPER
    exporting
      !ES_MATPR type CKMPR_F_MAT_PRICE
      !ET_RETURN type BAPIRET2_T
    changing
      !CT_ALLCURR type GTY_T_ALLCURR
      !CT_MATCB type GTY_MATCB_TBL
      !CT_KEKOCB type GTY_KEKOCB_TBL .
  methods _KALK_ENRICH
    importing
      !IT_MATCB type GTY_MATCB_TBL
      !IT_KEKOCB type GTY_KEKOCB_TBL
    changing
      !CT_MATPR type GTY_T_CKMPR_MAT_PRICE .
  methods _SAVE_PRICE_CHANGE
    importing
      !IT_DATA_POST type GTY_T_STR_PRICE_CHANGE
      !IT_MATCB type GTY_MATCB_TBL
      !IT_KEKOCB type GTY_KEKOCB_TBL
    exporting
      !ET_RETURN type BAPIRET2_T .
  methods _UPDATE_CHANGED_VALUE
    importing
      !IS_MR21_CHANGE type GTY_MR21_CHANGE
    changing
      !CS_ONECURR type CKI_MR21_INPUT .
*    METHODS _put_onecurr_to_allcurr
*      IMPORTING
*        !is_mr21_change TYPE gty_mr21_change
*      EXPORTING
*        !et_return      TYPE bapiret2_t
*      CHANGING
*        !ct_allcurr     TYPE gty_t_allcurr.
  methods _PLANT_NECESSARY
    importing
      !IV_WERKS type T001W-WERKS
      !IV_BWKEY type T001W-BWKEY
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods _CHECK_PERIOD
    importing
      !IV_BUDAT type BUDAT
      !IV_BUKRS type BUKRS
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods _HANDLE_UOM_RP .
  methods _SAVE_LOG .
  methods _INIT .
  methods _EXECUTE_CREATE .
  methods _EXECUTE_CHANGE .
  methods _EXECUTE_DELETE .
  methods _EXECUTE_API
    importing
      !IV_MRP_OPERATION type CHAR1 .
  methods _CALL_SAVE_API
    importing
      !IS_DATA type CMD_BS_MAT_S_MAT_DATA
      !IV_MRP_OPERATION type CHAR1 optional
      !IV_TEST_MODE type XFELD optional
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG
      !ET_MATNR_MAP type CMD_BS_MAT_T_TMP_TO_INT_ID_MAP .
  methods _CHECK_EXISTENCE
    importing
      !IV_PRODUCT type /SIMPLE/C_PRODUCT-PRODUCT
    returning
      value(CV_EXIST) type ABAP_BOOL .
  methods _ADJUST_VAL_ML_NODES
    importing
      !IV_AFTER_MMD type BOOLE_D
    changing
      !CT_VALUATION_DATA type GTY_DEEP_DATA-TO_VALUATION .
  methods _CALL_MLA_API
    importing
      !IS_DATA type CMD_BS_MAT_S_MAT_DATA
      !IT_MATNR_MAP type CMD_BS_MAT_T_TMP_TO_INT_ID_MAP optional
      !IV_TEST_MODE type XFELD optional
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG .
  methods _CALL_QMAT_API
    importing
      !IT_QMAT_INS type CMD_BS_MAT_T_QMAT
      !IT_QMAT_UPD type CMD_BS_MAT_T_QMAT
      !IT_QMAT_DEL type CMD_BS_MAT_T_QMAT
      !IT_QMAT_X type CMD_BS_MAT_T_QMAT_X
      !IT_MATNR_MAP type CMD_BS_MAT_T_TMP_TO_INT_ID_MAP optional
      !IV_TEST_MODE type XFELD optional
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG .
  methods _CALL_MDMA_API
    importing
      !IT_MDMA type CMD_BS_MAT_T_MDMA
      !IT_MDMA_X type CMD_BS_MAT_T_MDMA_X
      !IV_OPERATION type CHAR1
      !IT_MATNR_MAP type CMD_BS_MAT_T_TMP_TO_INT_ID_MAP optional
      !IV_TEST_MODE type XFELD optional
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG .
  methods _MAP_FIELD_NAMES
    importing
      !IV_NODE_NAME type STRING
      !IV_FIELDNAME type FIELDNAME
    exporting
      !EV_FIELD type STRING .
  methods _ADD_MESSAGE
    importing
      !MSGTY type SY-MSGTY
      !MSGID type SY-MSGID
      !MSGNO type SY-MSGNO
      !MSGV1 type SY-MSGV1 default SPACE
      !MSGV2 type SY-MSGV2 default SPACE
      !MSGV3 type SY-MSGV3 default SPACE
      !MSGV4 type SY-MSGV4 default SPACE .
  methods _EXPORT_MESSAGES
    importing
      !IT_MESSAGES type CMD_BS_MAT_T_MAT_MSG optional
      !IT_MMD_MESSAGES type CMD_BS_MAT_T_MAT_MSG optional
      !IT_MSG type IF_CMD_PRODUCT_MAINT_API=>TT_MESSAGE optional
      !IT_GEN_MSG type IF_CMD_PRODUCT_MAINT_API=>TT_MESSAGE optional
      !IV_ERROR type STRING optional
      !IV_ENTITY_NAME type STRING optional
    changing
      !CT_MESSAGE type BAPIRET2_T optional .
  methods _MAP_MESSAGES
    importing
      !IS_MSG type SYMSG
    exporting
      !ES_MSG type SYMSG .
  methods _MAP_FIELDNAME_EXT
    importing
      !IV_FIELDNAME type CHAR30
    returning
      value(EV_FIELDNAME) type CHAR30 .
  methods _GET_FIELD_INFO
    importing
      !IV_FIELDNAME type FNAME_FULL
    returning
      value(RV_TEXT) type MSGV1 .
  methods _GET_TABLEFIELD_INFO
    importing
      !IV_TABLEFIELD type CHAR30
    returning
      value(RV_TEXT) type MSGV1 .
  methods _DO_MAPPING_ML
    importing
      !IV_MRP_OPERATION type CHAR1
    changing
      !CT_VALUATION_DATA type GTY_DEEP_DATA-TO_VALUATION
      !CS_DATA type CMD_BS_MAT_S_MAT_DATA .
  methods _REPLACE_TEMP_MATNR_CKML
    importing
      !IT_TMP_KEY_MAP type CMD_BS_MAT_T_TMP_TO_INT_ID_MAP
    changing
      !CT_DATA type SORTED TABLE
      !CT_DATA_X type SORTED TABLE .
  methods _FIELD_VALIDATION
    importing
      !IS_DATA type CMD_BS_MAT_S_MAT_DATA
    exporting
      !ET_MESSAGE type CMD_BS_MAT_T_MAT_MSG .
  methods _MAP_REVISION_LEVEL .
  methods _MAP_VIEW_EXTEND .
  methods _EXECUTE_REVISION_LEVEL .
ENDCLASS.



CLASS /SIMPLE/PRD_SERVICE_PROVIDER IMPLEMENTATION.


  METHOD /simple/if_mdg_srv_provider~change.
    me->_init( ).
    IF line_exists( gs_data-to_valuation[ pricechange = 'X' ] ).
      DATA(l_flag) = 'X'.
    ENDIF.
    IF l_flag IS INITIAL.
      me->/simple/if_mdg_srv_provider~validate_change( ).
*      et_message = gt_message.
      IF gt_message IS INITIAL.
        me->/simple/if_mdg_srv_provider~do_mapping_change( ).
        me->_execute_change( ).


        et_message = gt_message.
        IF line_exists( et_message[ type   = 'E'
                                       id     = 'MM'
                                       number = '304' ] ).

          DELETE et_message WHERE type   = 'E'
                              AND id     = 'MM'
                              AND number = '304'.

          APPEND VALUE #(  type   = 'E'
                           id     = 'M3'
                           number = '137' )
                       TO et_message.
        ENDIF.
      ELSEIF gt_message IS NOT INITIAL AND to_upper( gs_data-actionmode ) CS 'BACKGROUND'.
        DATA:
          lv_log        TYPE /simple/api_log,
          lv_log_handle TYPE balloghndl.

        et_message = gt_message. "BEN
*    BEN        DATA(ls_key) = VALUE /simple/prd_service_provider=>gty_prd_key_log(
*    BEN                                       product      = gv_product
*    BEN
*    BEN                                     ).
*    BEN        lv_log = VALUE #( mdg_key          = /simple/cl_json_utility=>convert_stuct_to_json(
*    BEN                                               EXPORTING im_s_data = ls_key
*    BEN                                                         im_v_case = /simple/cl_json_utility=>co_ftype_camelcase )
*    BEN                          obj_type         = 'Product'
*    BEN                          mdglogid         = gs_data-mdglogid
*    BEN                          cr_number        = gs_data-crnumber
*    BEN                          cr_item          = gs_data-critem
*    BEN                          activate_id      = gs_data-activateid
*    BEN                          activate_item_id = gs_data-activateitemid
*    BEN                          status           = COND #( WHEN line_exists( gt_message[ type = 'E' ] ) OR
*    BEN                                                          line_exists( gt_message[ type = 'A' ] ) OR
*    BEN                                                          line_exists( gt_message[ type = 'X' ] ) THEN 'F'  ELSE 'S' )
*    BEN                          message_log      = lv_log-mdg_key ).
*    BEN        IF lv_log-status = 'F' .
*    BEN          CLEAR:lv_log-message_log.
*    BEN          LOOP AT gt_message[] INTO DATA(ls_msg).
*    BEN            MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
*    BEN            WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
*    BEN            INTO DATA(lv_msg).
*    BEN            IF lv_log-message_log IS INITIAL.
*    BEN              lv_log-message_log = condense( lv_msg ).
*    BEN            ELSE.
*    BEN              lv_log-message_log = condense( lv_msg ) && |,| && lv_log-message_log.
*    BEN            ENDIF.
*    BEN          ENDLOOP.
*    BEN        ENDIF.
*    BEN        IF to_upper( gs_data-actionmode ) CS 'VALIDATION'.
*    BEN          lv_log-step = COND #( WHEN  to_upper( gs_data-actionmode ) CS 'BACKGROUND' THEN 'BV'  ELSE 'V'  ). " Validation check?
*    BEN        ELSE.
*    BEN          lv_log-step = COND #( WHEN  to_upper( gs_data-actionmode ) CS 'BACKGROUND' THEN 'B'   ELSE 'A'  ). " Not validation check?
*    BEN        ENDIF.
*    BEN
*    BEN        CALL FUNCTION 'LOG_SAVE' " DESTINATION 'NONE'
*    BEN          EXPORTING
*    BEN            is_log        = lv_log
*    BEN             iv_log_handle = lv_log_handle.
**
      ENDIF.
    ELSE. "Price change
      DATA:
*        lt_valuation_comb TYPE /simple/prd_val_t. "Bruce
        lt_valuation_comb TYPE /simple/prd_val_t. "Bruce
      DATA lv_amount TYPE bapicurr-bapicurr.
      SELECT t1~bwkey,
           t1~waers
      FROM ckmlct AS t1
     INNER JOIN @gs_data-to_valuation AS t2
        ON t1~bwkey = t2~valuationarea
     WHERE t1~curtp = '10'
      INTO TABLE @DATA(lt_ckmlct).

      lt_valuation_comb = CORRESPONDING #( DEEP gs_data-to_valuation ).
      LOOP AT lt_valuation_comb ASSIGNING FIELD-SYMBOL(<fs_valuation_comb>).
        LOOP AT <fs_valuation_comb>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlaccount>) WHERE currencyrole = '10'.
          READ TABLE lt_ckmlct INTO DATA(ls_ckmlct)
       WITH KEY bwkey = <fs_valuation_comb>-valuationarea.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.
          IF <fs_mlaccount>-standardprice <> 0.
            lv_amount = <fs_mlaccount>-standardprice.
            CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
              EXPORTING
                currency             = ls_ckmlct-waers
                amount_external      = lv_amount
                max_number_of_digits = '23'
              IMPORTING
                amount_internal      = lv_amount
*               return               =
              .
            IF sy-subrc = 0.
              <fs_mlaccount>-standardprice = lv_amount.
            ENDIF.
          ENDIF.
          IF <fs_mlaccount>-movingaverageprice <> 0.
            lv_amount = <fs_mlaccount>-movingaverageprice.
            CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
              EXPORTING
                currency             = ls_ckmlct-waers
                amount_external      = lv_amount
                max_number_of_digits = '23'
              IMPORTING
                amount_internal      = lv_amount
*               return               =
              .
            IF sy-subrc = 0.
              <fs_mlaccount>-movingaverageprice = lv_amount.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
      CALL FUNCTION '/SIMPLE/PRICE_CHANGE_SAVE'
        EXPORTING
          it_valuation      = lt_valuation_comb
          iv_activateid     = gs_data-activateid
          iv_activateitemid = gs_data-activateitemid
*         iv_critem         = gs_data-activateitemid
*         iv_crnumber       = gs_data-activateid
          iv_critem         = gs_data-critem
          iv_crnumber       = gs_data-crnumber
          iv_mdglogid       = gs_data-mdglogid
          iv_actionmode     = gs_data-actionmode
          iv_product        = gs_data-product
        IMPORTING
          et_message        = gt_message.
    ENDIF.
    et_message = gt_message.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~clean_up.
    CLEAR: go_object.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~create.
    me->_init( ).
    me->/simple/if_mdg_srv_provider~validate_create( ).

    IF gt_message IS INITIAL.
      me->/simple/if_mdg_srv_provider~do_mapping_create( ).
      me->_execute_create( ).
      et_message = gt_message.
    ELSEIF gt_message IS NOT INITIAL AND to_upper( gs_data-actionmode ) CS 'BACKGROUND'.
      DATA:
        lv_log        TYPE /simple/api_log,
        lv_log_handle TYPE balloghndl.
      et_message = gt_message.
*    BEN      DATA(ls_key) = VALUE /simple/prd_service_provider=>gty_prd_key_log(
*    BEN                                     product      = gv_product
*    BEN
*    BEN                                   ).
*    BEN      lv_log = VALUE #( mdg_key          = /simple/cl_json_utility=>convert_stuct_to_json(
*    BEN                                             EXPORTING im_s_data = ls_key
*    BEN                                                       im_v_case = /simple/cl_json_utility=>co_ftype_camelcase )
*    BEN                        obj_type         = 'Product'
*    BEN                        mdglogid         = gs_data-mdglogid
*    BEN                        cr_number        = gs_data-crnumber
*    BEN                        cr_item          = gs_data-critem
*    BEN                        activate_id      = gs_data-activateid
*    BEN                        activate_item_id = gs_data-activateitemid
*    BEN                        status           = COND #( WHEN line_exists( gt_message[ type = 'E' ] ) OR
*    BEN                                                        line_exists( gt_message[ type = 'A' ] ) OR
*    BEN                                                        line_exists( gt_message[ type = 'X' ] ) THEN 'F'  ELSE 'S' )
*    BEN                        message_log      = lv_log-mdg_key ).
*    BEN      IF lv_log-status = 'F' .
*    BEN        CLEAR:lv_log-message_log.
*    BEN        LOOP AT gt_message[] INTO DATA(ls_msg).
*    BEN          MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
*    BEN          WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
*    BEN          INTO DATA(lv_msg).
*    BEN          IF lv_log-message_log IS INITIAL.
*    BEN            lv_log-message_log = condense( lv_msg ).
*    BEN          ELSE.
*    BEN            lv_log-message_log = condense( lv_msg ) && |,| && lv_log-message_log.
*    BEN          ENDIF.
*    BEN        ENDLOOP.
*    BEN      ENDIF.
*    BEN      IF to_upper( gs_data-actionmode ) CS 'VALIDATION'.
*    BEN        lv_log-step = COND #( WHEN  to_upper( gs_data-actionmode ) CS 'BACKGROUND' THEN 'BV'  ELSE 'V'  ). " Validation check?
*    BEN      ELSE.
*    BEN        lv_log-step = COND #( WHEN  to_upper( gs_data-actionmode ) CS 'BACKGROUND' THEN 'B'   ELSE 'A'  ). " Not validation check?
*    BEN      ENDIF.
*    BEN
*    BEN      CALL FUNCTION 'LOG_SAVE' " DESTINATION 'NONE'
*    BEN        EXPORTING
*    BEN          is_log        = lv_log
*    BEN          iv_log_handle = lv_log_handle.

    ENDIF.



  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~delete.
    me->_init( ).
    me->/simple/if_mdg_srv_provider~validate_delete( ).
    IF gt_message IS INITIAL.
      me->/simple/if_mdg_srv_provider~do_mapping_delete( ).
      me->_execute_delete( ).
    ENDIF.

    et_message = gt_message.
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_change.

    DATA:
      lv_matnr        TYPE matnr,
      ls_mara         TYPE cmd_bs_mat_s_mara,
      ls_mara_x       TYPE cmd_bs_mat_s_mara_x,
      ls_makt         TYPE cmd_bs_mat_s_makt,
      ls_makt_x       TYPE cmd_bs_mat_s_makt_x,
      ls_stxl_sales   TYPE cmd_bs_mat_s_notes_sales,
      ls_stxl_sales_x TYPE cmd_bs_mat_s_notes_sales_x,
      ls_mvke         TYPE cmd_bs_mat_s_mvke,
      ls_mvke_x       TYPE cmd_bs_mat_s_mvke_x,
      ls_marc         TYPE cmd_bs_mat_s_marc,
      ls_marc_x       TYPE cmd_bs_mat_s_marc_x,
      ls_stxl_plant   TYPE cmd_bs_mat_s_notes_plant,
      ls_stxl_plant_x TYPE cmd_bs_mat_s_notes_plant_x,
      ls_mard         TYPE cmd_bs_mat_s_mard,
      ls_mard_x       TYPE cmd_bs_mat_s_mard_x,
      ls_mdma         TYPE cmd_bs_mat_s_mdma,
      ls_mdma_x       TYPE cmd_bs_mat_s_mdma_x,
      ls_qmat         TYPE cmd_bs_mat_s_qmat,
      ls_qmat_x       TYPE cmd_bs_mat_s_qmat_x,
      ls_mpop         TYPE cmd_bs_mat_s_mpop,
      ls_mpop_x       TYPE cmd_bs_mat_s_mpop_x,
      ls_mlgn         TYPE cmd_bs_mat_s_mlgn,
      ls_mlgn_x       TYPE cmd_bs_mat_s_mlgn_x,
      ls_mlgt         TYPE cmd_bs_mat_s_mlgt,
      ls_mlgt_x       TYPE cmd_bs_mat_s_mlgt_x,
      ls_mlan         TYPE cmd_bs_mat_s_steu,
      ls_mlan_x       TYPE cmd_bs_mat_s_steu_x,
      ls_stxl         TYPE cmd_bs_mat_s_notes,
      ls_stxl_x       TYPE cmd_bs_mat_s_notes_x,
      ls_mean         TYPE cmd_bs_mat_s_mean,
      ls_mean_x       TYPE cmd_bs_mat_s_mean_x,
      ls_marm         TYPE cmd_bs_mat_s_marm,
      ls_marm_x       TYPE cmd_bs_mat_s_marm_x,
      ls_mbew         TYPE cmd_bs_mat_s_mbew,
      ls_mbew_x       TYPE cmd_bs_mat_s_mbew_x,
      lv_marc_modify  TYPE char1,
      ls_mfhm         TYPE cmd_bs_mat_s_mfhm,
      ls_mfhm_x       TYPE cmd_bs_mat_s_mfhm_x,
      ls_mpgd         TYPE cmd_bs_mat_s_mpgd,
      ls_mpgd_x       TYPE cmd_bs_mat_s_mpgd_x.

    DATA:
      lv_fieldname          TYPE fieldname,
      lv_table_fieldname    TYPE string,
      ls_markforchange      TYPE string,
      lt_markforchange_temp TYPE TABLE OF string,
      lt_markforchange      TYPE TABLE OF string.

    " For delete
    DATA:
      lt_lines         TYPE TABLE OF tline,
      ls_lines         LIKE LINE OF  lt_lines,
      lv_stxl_name     TYPE tdobname,
      lv_stxl_str_name TYPE string.

    LOOP AT gs_data-to_valuation INTO DATA(ls_valuation).
      LOOP AT ls_valuation-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlaccount>) WHERE currencyrole = '10'.
        IF <fs_mlaccount>-standardprice <> ls_valuation-standardprice.
          <fs_mlaccount>-standardprice = ls_valuation-standardprice.
        ENDIF.
        IF <fs_mlaccount>-movingaverageprice <> ls_valuation-movingaverageprice.
          <fs_mlaccount>-movingaverageprice = ls_valuation-movingaverageprice.
        ENDIF.
      ENDLOOP.
    ENDLOOP.


    _adjust_val_ml_nodes(
      EXPORTING
        iv_after_mmd      = abap_false
      CHANGING
        ct_valuation_data = gs_data-to_valuation
    ).

    lv_matnr = gv_product.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " MARA
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Sales
    IF gs_data-to_productsales IS NOT INITIAL AND gs_data-to_productsales-action <> ''.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productsales
          iv_input_stru    = gs_data-to_productsales
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.

      IF gs_data-to_productsales-action = 'Change'.
        CLEAR ls_mara_x.
      ENDIF.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
      IF gs_data-to_productsales-mdgmarkforchange IS NOT INITIAL.
        SPLIT gs_data-to_productsales-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
      ENDIF.
      APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
      CLEAR lt_markforchange_temp.
    ENDIF.

    " Product Procurement
    IF gs_data-to_productprocurement IS NOT INITIAL AND gs_data-to_productprocurement-action <> ''.
      IF gs_data-to_productsales-action = 'Change'.
        DATA(ls_temp_mara_x) = ls_mara_x.
      ENDIF.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productprocurement
          iv_input_stru    = gs_data-to_productprocurement
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.

      IF gs_data-to_productsales-action = 'Change'.
        CLEAR ls_mara_x.
        ls_mara_x = ls_temp_mara_x.
        CLEAR ls_temp_mara_x.
      ENDIF.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
      IF gs_data-to_productprocurement-mdgmarkforchange IS NOT INITIAL.
        SPLIT gs_data-to_productprocurement-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
      ENDIF.
      APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
      CLEAR lt_markforchange_temp.
    ENDIF.

    " Product Storage
    IF gs_data-to_productstorage IS NOT INITIAL AND gs_data-to_productstorage-action <> ''.
      IF gs_data-to_productstorage-action = 'Change'.
        ls_temp_mara_x = ls_mara_x.
      ENDIF.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productstorage
          iv_input_stru    = gs_data-to_productstorage
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.

      IF gs_data-to_productstorage-shelflifeexpirationdateperiod IS NOT INITIAL.
        CALL FUNCTION 'CONVERSION_EXIT_PERKZ_INPUT'
          EXPORTING
            input  = gs_data-to_productstorage-shelflifeexpirationdateperiod
          IMPORTING
            output = ls_mara-iprkz.
      ENDIF.

      IF gs_data-to_productstorage-action = 'Change'.
        CLEAR ls_mara_x.
        ls_mara_x = ls_temp_mara_x.
        CLEAR ls_temp_mara_x.
      ENDIF.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
      IF gs_data-to_productstorage-mdgmarkforchange IS NOT INITIAL.
        SPLIT gs_data-to_productstorage-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
      ENDIF.
      APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
      CLEAR lt_markforchange_temp.
    ENDIF.

    " Product Quality Mgmt
    IF gs_data-to_productqualitymgmt IS NOT INITIAL AND gs_data-to_productqualitymgmt-action <> ''.
      IF gs_data-to_productstorage-action = 'Change'.
        ls_temp_mara_x = ls_mara_x.
      ENDIF.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productqualitymgmt
          iv_input_stru    = gs_data-to_productqualitymgmt
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.
      IF gs_data-to_productstorage-action = 'Change'.
        CLEAR ls_mara_x.
        ls_mara_x = ls_temp_mara_x.
        CLEAR ls_temp_mara_x.
      ENDIF.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
      IF gs_data-to_productqualitymgmt-mdgmarkforchange IS NOT INITIAL.
        SPLIT gs_data-to_productqualitymgmt-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
      ENDIF.
      APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
      CLEAR lt_markforchange_temp.
    ENDIF.

    " Product
    IF gs_data-mdgmarkforchange IS NOT INITIAL.
      ls_temp_mara_x = ls_mara_x.
      " Material Root
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-product
          iv_input_stru    = gs_data
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.

      " Conversion for REQMAXSHLIFE to SCM_SHLF_LFE_REQ_MAX
      IF gs_data-reqmaxshlife IS NOT INITIAL .
        CALL FUNCTION 'CONVERSION_EXIT_TSTRG_INPUT'
          EXPORTING
            input          = gs_data-reqmaxshlife
          IMPORTING
            output         = ls_mara-scm_shlf_lfe_req_max
          EXCEPTIONS
            invalid_format = 1
            OTHERS         = 2.
      ENDIF.

      CLEAR ls_mara_x.
      ls_mara_x = ls_temp_mara_x.
      CLEAR ls_temp_mara_x.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
        ls_mara-is_matnr_tmp = abap_true.
      ENDIF.
      SPLIT gs_data-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
      APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
    ENDIF.

    " Handle mark for change
    LOOP AT lt_markforchange INTO ls_markforchange.
      lv_fieldname = ls_markforchange.
      IF |{ lv_fieldname CASE = UPPER }| <> 'REQMAXSHLIFE'. " Conversion for REQMAXSHLIFE to SCM_SHLF_LFE_REQ_MAX
        CALL METHOD _map_field_names
          EXPORTING
            iv_node_name = gc_entity-product
            iv_fieldname = |{ lv_fieldname CASE = UPPER }|
          IMPORTING
            ev_field     = lv_table_fieldname.

        ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mara_x TO FIELD-SYMBOL(<ls_field_data>).
        IF <ls_field_data> IS ASSIGNED.
          <ls_field_data> = abap_true.
        ENDIF.

      ELSE.
        ls_mara_x-scm_shlf_lfe_req_max = 'X'.
      ENDIF.
    ENDLOOP.
    CLEAR lt_markforchange.

    ls_mara-matnr = lv_matnr.
    ls_mara_x-matnr = ls_mara-matnr.

    INSERT ls_mara INTO TABLE gs_mat-mara_tab.
    INSERT ls_mara_x INTO TABLE gs_mat-mara_x_tab.
    CLEAR: ls_mara, ls_mara_x.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Description
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_description INTO DATA(ls_description) WHERE action IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-description
          iv_input_stru    = ls_description
        CHANGING
          ev_output_stru   = ls_makt
          ev_output_stru_x = ls_makt_x.
      IF ls_makt-matnr IS INITIAL.
        ls_makt-matnr = lv_matnr.
      ENDIF.
      IF ls_description-action = 'Change'.
        CLEAR ls_makt_x.
      ENDIF.
      IF ls_description-mdgmarkforchange IS NOT INITIAL.
        SPLIT ls_description-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
      ENDIF.

      " Handle mark for change
      LOOP AT lt_markforchange INTO ls_markforchange.
        lv_fieldname = ls_markforchange.
        CALL METHOD _map_field_names
          EXPORTING
            iv_node_name = gc_entity-description
            iv_fieldname = |{ lv_fieldname CASE = UPPER }|
          IMPORTING
            ev_field     = lv_table_fieldname.
        ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_makt_x TO <ls_field_data>.
        IF <ls_field_data> IS ASSIGNED.
          <ls_field_data> = abap_true.
        ENDIF.
      ENDLOOP.
      CLEAR lt_markforchange.

      ls_makt_x-matnr = ls_makt-matnr.
      ls_makt_x-spras = ls_makt-spras.
      IF ls_description-action = 'Delete'.
        ls_makt_x-delete_row = abap_true.
      ENDIF.
      INSERT ls_makt INTO TABLE gs_mat-makt_tab.
      INSERT ls_makt_x INTO TABLE gs_mat-makt_x_tab.
      CLEAR: ls_makt, ls_makt_x.

    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Warehouse
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    LOOP AT gs_data-to_productwarehouse INTO DATA(ls_warehouse).
      IF ls_warehouse-action = 'Change'
        OR ls_warehouse-action = 'Delete'
        OR ls_warehouse-action = 'Insert'.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productwarehouse
            iv_input_stru    = ls_warehouse
          CHANGING
            ev_output_stru   = ls_mlgn
            ev_output_stru_x = ls_mlgn_x.
        IF ls_mlgn-matnr IS INITIAL.
          ls_mlgn-matnr = lv_matnr.
        ENDIF.
        IF ls_warehouse-action = 'Change'.
          CLEAR ls_mlgn_x.
        ENDIF.
        IF ls_warehouse-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_warehouse-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.

        " Handle mark for change
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-productwarehouse
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mlgn_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        ls_mlgn_x-matnr = ls_mlgn-matnr.
        ls_mlgn_x-lgnum = ls_mlgn-lgnum.

        INSERT ls_mlgn INTO TABLE gs_mat-mlgn_tab.
        INSERT ls_mlgn_x INTO TABLE gs_mat-mlgn_x_tab.
      ENDIF.

      LOOP AT ls_warehouse-to_productstoragetype INTO DATA(ls_storagetype).
        IF ls_storagetype-action = 'Change'
          OR ls_storagetype-action = 'Delete'
          OR ls_storagetype-action = 'Insert'.

          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-productstoragetype
              iv_input_stru    = ls_storagetype
            CHANGING
              ev_output_stru   = ls_mlgt
              ev_output_stru_x = ls_mlgt_x.
          IF ls_mlgt-matnr IS INITIAL.
            ls_mlgt-matnr = lv_matnr.
          ENDIF.
          IF ls_storagetype-action = 'Change'.
            CLEAR ls_mlgt_x.
          ENDIF.
          IF ls_storagetype-mdgmarkforchange IS NOT INITIAL.
            SPLIT ls_storagetype-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
          ENDIF.

          " Handle mark for change
          LOOP AT lt_markforchange INTO ls_markforchange.
            lv_fieldname = ls_markforchange.
            CALL METHOD _map_field_names
              EXPORTING
                iv_node_name = gc_entity-productstoragetype
                iv_fieldname = |{ lv_fieldname CASE = UPPER }|
              IMPORTING
                ev_field     = lv_table_fieldname.
            ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mlgt_x TO <ls_field_data>.
            IF <ls_field_data> IS ASSIGNED.
              <ls_field_data> = abap_true.
            ENDIF.
          ENDLOOP.
          CLEAR lt_markforchange.
          IF ls_mlgt-lgnum IS INITIAL.
            ls_mlgt-lgnum = ls_warehouse-warehousenumber.
          ENDIF.
          ls_mlgt_x-lgtyp = ls_mlgt-lgtyp.
          ls_mlgt_x-matnr = ls_mlgt-matnr.
          ls_mlgt_x-lgnum = ls_mlgt-lgnum.

          INSERT ls_mlgt INTO TABLE gs_mat-mlgt_tab.
          INSERT ls_mlgt_x INTO TABLE gs_mat-mlgt_x_tab.
          CLEAR: ls_mlgt, ls_mlgt_x.
        ENDIF.
      ENDLOOP.
      CLEAR: ls_mlgn, ls_mlgn_x.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Sales Delivery
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_salesdelivery INTO DATA(ls_salesdelivery).
      IF ls_salesdelivery-to_salestext IS NOT INITIAL.
        "-- Fill sales text
        LOOP AT ls_salesdelivery-to_salestext INTO DATA(ls_salestext).
          IF ls_salestext-action = 'Change' OR ls_salestext-action = 'Insert'.

            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-salestext
                iv_input_stru    = ls_salestext
              CHANGING
                ev_output_stru   = ls_stxl_sales
                ev_output_stru_x = ls_stxl_sales_x.
            IF ls_stxl_sales-matnr IS INITIAL.
              ls_stxl_sales-matnr = lv_matnr.
            ENDIF.

            " Handle MarkedForChange logic
            IF ls_salestext-action = 'Change'.
              CLEAR ls_stxl_sales_x.
            ENDIF.
            IF ls_salestext-mdgmarkforchange IS NOT INITIAL.
              SPLIT ls_salestext-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
            ENDIF.
            LOOP AT lt_markforchange INTO ls_markforchange.
              lv_fieldname = ls_markforchange.
              CALL METHOD _map_field_names
                EXPORTING
                  iv_node_name = gc_entity-salestext
                  iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                IMPORTING
                  ev_field     = lv_table_fieldname.
              ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_stxl_sales_x TO <ls_field_data>.
              IF <ls_field_data> IS ASSIGNED.
                <ls_field_data> = abap_true.
              ENDIF.
            ENDLOOP.
            CLEAR lt_markforchange.

            ls_stxl_x-matnr = ls_stxl_sales-matnr.
            ls_stxl_sales_x-vkorg = ls_stxl_sales-vkorg.
            ls_stxl_sales_x-vtweg = ls_stxl_sales-vtweg.
            ls_stxl_sales_x-langu = ls_stxl_sales-langu.
            ls_stxl_sales-tdid = '0001'.
            ls_stxl_sales_x-tdid = abap_true.
            INSERT ls_stxl_sales INTO TABLE gs_mat-sales_notes_tab.
            INSERT ls_stxl_sales_x INTO TABLE gs_mat-sales_notes_x_tab.
            CLEAR: ls_stxl_sales, ls_stxl_sales_x.

          ELSEIF ls_salestext-action = 'Delete'.
            CLEAR lv_stxl_str_name.
            IF ls_salestext IS NOT INITIAL.
              CONCATENATE
                  ls_salestext-product
                  ls_salestext-productsalesorg
                  ls_salestext-productdistributionchnl
              INTO lv_stxl_str_name RESPECTING BLANKS.
            ENDIF.
            CLEAR lv_stxl_name.
            lv_stxl_name = lv_stxl_str_name.
            IF lv_stxl_name IS NOT INITIAL.
              CALL FUNCTION 'READ_TEXT'
                EXPORTING
                  id       = '0001'
                  language = ls_salestext-language
                  name     = lv_stxl_name
                  object   = 'MVKE' "Remains constant for sales text
                TABLES
                  lines    = lt_lines.
              IF sy-subrc EQ 0.
                CALL FUNCTION 'DELETE_TEXT'
                  EXPORTING
                    id              = '0001'
                    language        = ls_salestext-language
                    name            = lv_stxl_name
                    object          = 'MVKE' "Remains constant for sales text
                    savemode_direct = abap_true.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

      " Fill Sales Tax Data
*      IF ls_salesdelivery-to_salestax IS NOT INITIAL.
*        LOOP AT ls_salesdelivery-to_salestax ASSIGNING FIELD-SYMBOL(<fs_salestax>).
*          IF sy-subrc = 0 AND <fs_salestax> IS NOT INITIAL.
*            IF <fs_salestax>-action = 'Change' OR <fs_salestax>-action = 'Delete' OR <fs_salestax>-action = 'Insert'.
*              CALL METHOD _map_fields
*                EXPORTING
*                  iv_entity_name   = 'xSIMPLExA_ProductSalesTaxType'
*                  iv_input_stru    = <fs_salestax>
*                CHANGING
*                  ev_output_stru   = ls_mlan
*                  ev_output_stru_x = ls_mlan_x.
*
*              " Handle MarkedForChange
*              IF <fs_salestax>-action = 'Change'.
*                CLEAR ls_mlan_x.
*              ENDIF.
*              IF <fs_salestax>-mdgmarkforchange IS NOT INITIAL.
*                SPLIT <fs_salestax>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
*              ENDIF.
*              LOOP AT lt_markforchange INTO ls_markforchange.
*                lv_fieldname = ls_markforchange.
*                CALL METHOD _map_field_names
*                  EXPORTING
*                    iv_node_name = 'xSIMPLExA_ProductSalesTaxType'
*                    iv_fieldname = |{ lv_fieldname CASE = UPPER }|
*                  IMPORTING
*                    ev_field     = lv_table_fieldname.
*                ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mlan_x TO <ls_field_data>.
*                IF <ls_field_data> IS ASSIGNED.
*                  <ls_field_data> = abap_true.
*                ENDIF.
*              ENDLOOP.
*              CLEAR lt_markforchange.
*
*              IF ls_mlan-matnr IS INITIAL.
*                ls_mlan-matnr = lv_matnr.
*              ENDIF.
*              ls_mlan_x-matnr = ls_mlan-matnr.
*              ls_mlan_x-aland = ls_mlan-aland.
*              ls_mlan_x-tatyp = ls_mlan-tatyp.
*              IF <fs_salestax>-action = 'Delete'.
*                ls_mlan_x-delete_row = abap_true.
*              ENDIF.
*              INSERT ls_mlan INTO TABLE gs_mat-mlan_sales_tab.
*              INSERT ls_mlan_x INTO TABLE gs_mat-mlan_sales_x_tab.
*              CLEAR ls_mlan.
*              CLEAR ls_mlan_x.
*            ENDIF.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.

      "Handle MarkedForChange
      IF ls_salesdelivery-action = 'Change' OR ls_salesdelivery-action = 'Insert'.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-salesdelivery
            iv_input_stru    = ls_salesdelivery
          CHANGING
            ev_output_stru   = ls_mvke
            ev_output_stru_x = ls_mvke_x.
        IF ls_salesdelivery-action = 'Change'.
          CLEAR ls_mvke_x.
        ENDIF.
        IF ls_salesdelivery-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_salesdelivery-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-salesdelivery
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mvke_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.
        IF ls_mvke-matnr IS INITIAL.
          ls_mvke-matnr = lv_matnr.
        ENDIF.
        ls_mvke_x-matnr = ls_mvke-matnr.
        ls_mvke_x-vkorg = ls_mvke-vkorg.
        ls_mvke_x-vtweg = ls_mvke-vtweg.
        INSERT ls_mvke INTO TABLE gs_mat-mvke_tab.
        INSERT ls_mvke_x INTO TABLE gs_mat-mvke_x_tab.
        CLEAR: ls_mvke, ls_mvke_x.
      ENDIF.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Sales Tax
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productsalestax INTO DATA(ls_productsalestax) WHERE action IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productsalestax
          iv_input_stru    = ls_productsalestax
        CHANGING
          ev_output_stru   = ls_mlan
          ev_output_stru_x = ls_mlan_x.

      " Handle MarkedForChange
      IF ls_productsalestax-action = 'Change'.
        CLEAR ls_mlan_x.
      ENDIF.
      IF ls_productsalestax-mdgmarkforchange IS NOT INITIAL.
        SPLIT ls_productsalestax-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
      ENDIF.
      LOOP AT lt_markforchange INTO ls_markforchange.
        lv_fieldname = ls_markforchange.
        CALL METHOD _map_field_names
          EXPORTING
            iv_node_name = gc_entity-productsalestax
            iv_fieldname = |{ lv_fieldname CASE = UPPER }|
          IMPORTING
            ev_field     = lv_table_fieldname.
        ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mlan_x TO <ls_field_data>.
        IF <ls_field_data> IS ASSIGNED.
          <ls_field_data> = abap_true.
        ENDIF.
      ENDLOOP.
      CLEAR lt_markforchange.

      IF ls_mlan-matnr IS INITIAL.
        ls_mlan-matnr = lv_matnr.
      ENDIF.
      ls_mlan_x-matnr = ls_mlan-matnr.
      ls_mlan_x-aland = ls_mlan-aland.
      ls_mlan_x-tatyp = ls_mlan-tatyp.
      IF ls_productsalestax-action = 'Delete'.
        ls_mlan_x-delete_row = abap_true.
      ENDIF.
      INSERT ls_mlan INTO TABLE gs_mat-mlan_sales_tab.

      INSERT ls_mlan_x INTO TABLE gs_mat-mlan_sales_x_tab.
      CLEAR: ls_mlan, ls_mlan_x.

    ENDLOOP.
    DATA:
      ls_mlan1   TYPE cmd_bs_mat_s_steumm,
      ls_mlan1_x TYPE cmd_bs_mat_s_steumm_x.
*    LOOP AT gs_data-to_productsalestax ASSIGNING FIELD-SYMBOL(<fs_sal_tax>).
*      CALL METHOD map_fields
*        EXPORTING
*          iv_entity_name   = gc_entity-productsalestax
*          iv_input_stru    = <fs_sal_tax>
*        CHANGING
*          ev_output_stru   = ls_mlan1
*          ev_output_stru_x = ls_mlan1_x.
*      IF ls_mlan1-matnr IS INITIAL.
*        ls_mlan1-matnr = lv_matnr.
*      ENDIF.
*      ls_mlan1-matnr = lv_matnr.
*      ls_mlan1-aland = <fs_sal_tax>-country.
**      ls_mlan1-taxim = '1'.
*      ls_mlan1_x-matnr = lv_matnr.
*      ls_mlan1_x-aland = <fs_sal_tax>-country.
*      ls_mlan1_x-taxim = 'X'.
**      INSERT ls_mlan INTO TABLE gs_mat-mlan_sales_tab.
**      INSERT ls_mlan_x INTO TABLE gs_mat-mlan_sales_x_tab.
*      INSERT ls_mlan1 INTO TABLE gs_mat-mlan_purchase_tab.
*      INSERT ls_mlan1_x INTO TABLE gs_mat-mlan_purchase_x_tab.
*      CLEAR: ls_mlan1, ls_mlan1_x.
*    ENDLOOP.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Basic Text
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productbasictext INTO DATA(ls_productbasictext).
      IF ls_productbasictext-action = 'Change'
        OR ls_productbasictext-action = 'Insert'.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productbasictext
            iv_input_stru    = ls_productbasictext
          CHANGING
            ev_output_stru   = ls_stxl
            ev_output_stru_x = ls_stxl_x.

        " Handle MarkedForChange
        IF ls_productbasictext-action = 'Change'.
          CLEAR ls_stxl_x.
        ENDIF.

        IF ls_productbasictext-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_productbasictext-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-productbasictext
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_stxl_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_stxl-matnr IS INITIAL.
          ls_stxl-matnr = lv_matnr.
        ENDIF.
        ls_stxl-tdid = 'GRUN'.
        ls_stxl_x-matnr = ls_stxl-matnr.
        ls_stxl_x-langu = ls_stxl-langu.
        ls_stxl_x-tdid = abap_true.
        INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
        INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
        CLEAR ls_stxl.
        CLEAR ls_stxl_x.
      ELSEIF ls_productbasictext-action = 'Delete'.
        CLEAR lv_stxl_name.
        lv_stxl_name = lv_matnr.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            id       = 'GRUN'
            language = ls_productbasictext-language
            name     = lv_stxl_name
            object   = 'MATERIAL' "This is always Material, hence hard-coded.
          TABLES
            lines    = lt_lines.
        IF sy-subrc EQ 0.
          CALL FUNCTION 'DELETE_TEXT'
            EXPORTING
              id              = 'GRUN'
              language        = ls_productbasictext-language
              name            = lv_stxl_name
              object          = 'MATERIAL' "This is always Material, hence hard-coded
              savemode_direct = abap_true.
        ENDIF.
      ENDIF.
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Purchase Text
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productpurchasetext INTO DATA(ls_productpurchasetext).
      IF ls_productpurchasetext-action = 'Change'
        OR ls_productpurchasetext-action = 'Insert'.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productbasictext   "since structure is same as product basic text
            iv_input_stru    = ls_productpurchasetext
          CHANGING
            ev_output_stru   = ls_stxl
            ev_output_stru_x = ls_stxl_x.

        "Handle MarkedForChange
        IF ls_productpurchasetext-action = 'Change'.
          CLEAR ls_stxl_x.
        ENDIF.
        IF ls_productpurchasetext-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_productpurchasetext-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-productbasictext
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_stxl_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_stxl-matnr IS INITIAL.
          ls_stxl-matnr = lv_matnr.
        ENDIF.
        ls_stxl-tdid = 'BEST'.
        ls_stxl_x-matnr = ls_stxl-matnr.
        ls_stxl_x-langu = ls_stxl-langu.
        ls_stxl_x-tdid = abap_true.
        INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
        INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
        CLEAR ls_stxl.
        CLEAR ls_stxl_x.
      ELSEIF ls_productpurchasetext-action = 'Delete'.
        CLEAR lv_stxl_name.
        lv_stxl_name = lv_matnr.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            id       = 'BEST'
            language = ls_productpurchasetext-language
            name     = lv_stxl_name
            object   = 'MATERIAL' "This is always Material, hence hard-coded.
          TABLES
            lines    = lt_lines.
        IF sy-subrc EQ 0.
          CALL FUNCTION 'DELETE_TEXT'
            EXPORTING
              id              = 'BEST'
              language        = ls_productpurchasetext-language
              name            = lv_stxl_name
              object          = 'MATERIAL'
              savemode_direct = abap_true.
        ENDIF.
      ENDIF.
    ENDLOOP.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Inspection Text
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productinspectiontext INTO DATA(ls_productinspectiontext).
      IF ls_productinspectiontext-action = 'Change'
        OR ls_productinspectiontext-action = 'Insert'.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productbasictext
            iv_input_stru    = ls_productinspectiontext
          CHANGING
            ev_output_stru   = ls_stxl
            ev_output_stru_x = ls_stxl_x.

        " Handle MarkedForChange
        IF ls_productinspectiontext-action = 'Change'.
          CLEAR ls_stxl_x.
        ENDIF.
        IF ls_productinspectiontext-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_productinspectiontext-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-productbasictext
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_stxl_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_stxl-matnr IS INITIAL.
          ls_stxl-matnr = lv_matnr.
        ENDIF.
        ls_stxl-tdid = 'PRUE'.
        ls_stxl_x-matnr = ls_stxl-matnr.
        ls_stxl_x-langu = ls_stxl-langu.
        ls_stxl_x-tdid = abap_true.
        INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
        INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
        CLEAR ls_stxl.
        CLEAR ls_stxl_x.
      ELSEIF ls_productinspectiontext-action = 'Delete'.
        CLEAR lv_stxl_name.
        lv_stxl_name = lv_matnr.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            id       = 'PRUE'
            language = ls_productinspectiontext-language
            name     = lv_stxl_name
            object   = 'MATERIAL' "This is always Material, hence hard-coded.
          TABLES
            lines    = lt_lines.
        IF sy-subrc EQ 0.
          CALL FUNCTION 'DELETE_TEXT'
            EXPORTING
              id              = 'PRUE'
              language        = ls_productinspectiontext-language
              name            = lv_stxl_name
              object          = 'MATERIAL'
              savemode_direct = abap_true.
        ENDIF.
      ENDIF.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Product Units of Measure
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productunitsofmeasure INTO DATA(ls_productunitsofmeasure).
      " International Article Number
      LOOP AT ls_productunitsofmeasure-to_internationalarticlenumber
      INTO DATA(ls_internationalarticlenumber) WHERE action IS NOT INITIAL.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-internationalarticlenumber
            iv_input_stru    = ls_internationalarticlenumber
          CHANGING
            ev_output_stru   = ls_mean
            ev_output_stru_x = ls_mean_x.

        " Handle MarkedForChange
        IF ls_internationalarticlenumber-action = 'Change'.
          CLEAR ls_mean_x.
        ENDIF.
        IF ls_internationalarticlenumber-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_internationalarticlenumber-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-internationalarticlenumber
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mean_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_mean-matnr IS INITIAL.
          ls_mean-matnr = lv_matnr.
        ENDIF.
        ls_mean_x-matnr = ls_mean-matnr.
        ls_mean_x-meinh = ls_mean-meinh.
        ls_mean_x-lfnum = ls_mean-lfnum.
        IF ls_internationalarticlenumber-action = 'Delete'.
          ls_mean_x-delete_row = abap_true.
        ENDIF.
        INSERT ls_mean INTO TABLE gs_mat-mean_tab.
        INSERT ls_mean_x INTO TABLE gs_mat-mean_x_tab.
        CLEAR ls_mean.
        CLEAR ls_mean_x.

      ENDLOOP.

      " Units of Measure
      IF ls_productunitsofmeasure-action = 'Change'
        OR ls_productunitsofmeasure-action = 'Delete'
        OR ls_productunitsofmeasure-action = 'Insert'.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productunitsofmeasure
            iv_input_stru    = ls_productunitsofmeasure
          CHANGING
            ev_output_stru   = ls_marm
            ev_output_stru_x = ls_marm_x.

        " Handle MarkedForChange
        IF ls_productunitsofmeasure-action = 'Change'.
          CLEAR ls_marm_x.
        ENDIF.
        IF ls_productunitsofmeasure-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_productunitsofmeasure-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
        ENDIF.
        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-productunitsofmeasure
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_marm_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_marm-matnr IS INITIAL.
          ls_marm-matnr = lv_matnr.
        ENDIF.
        ls_marm_x-matnr = ls_marm-matnr.
        ls_marm_x-meinh = ls_marm-meinh.
        IF ls_productunitsofmeasure-action = 'Delete'.
          ls_marm_x-delete_row = abap_true.
        ENDIF.

        IF ls_productunitsofmeasure-alternativeunit = gs_data-baseunit.
          IF ls_marm_x-brgew = '' AND gs_mat-mara_x_tab[ 1 ]-brgew = 'X'. "Gross Weight
            ls_marm_x-brgew = 'X'.
            ls_marm-brgew = gs_mat-mara_tab[ 1 ]-brgew.
          ENDIF.
          IF ls_marm_x-gewei = '' AND gs_mat-mara_x_tab[ 1 ]-gewei = 'X'. "Weight Unit
            ls_marm_x-gewei = 'X'.
            ls_marm-gewei = gs_mat-mara_tab[ 1 ]-gewei.
          ENDIF.
          IF ls_marm_x-volum = '' AND gs_mat-mara_x_tab[ 1 ]-volum = 'X'. "Volume
            ls_marm_x-volum = 'X'.
            ls_marm-volum = gs_mat-mara_tab[ 1 ]-volum.
          ENDIF.
          IF ls_marm_x-voleh = '' AND gs_mat-mara_x_tab[ 1 ]-voleh = 'X'. "Volume Unit
            ls_marm_x-voleh = 'X'.
            ls_marm-voleh = gs_mat-mara_tab[ 1 ]-voleh.
          ENDIF.
          IF ls_marm_x-ean11 = '' AND gs_mat-mara_x_tab[ 1 ]-ean11 = 'X'. "EAN/UPC
            ls_marm_x-ean11 = 'X'.
            ls_marm-ean11 = gs_mat-mara_tab[ 1 ]-ean11.
          ENDIF.
          IF ls_marm_x-numtp = '' AND gs_mat-mara_x_tab[ 1 ]-numtp = 'X'. "EAN/UPC
            ls_marm_x-numtp = 'X'.
            ls_marm-numtp = gs_mat-mara_tab[ 1 ]-numtp.
          ENDIF.
        ENDIF.

        CLEAR lt_markforchange.
        INSERT ls_marm INTO TABLE gs_mat-marm_tab.
        INSERT ls_marm_x INTO TABLE gs_mat-marm_x_tab.
        CLEAR ls_marm.
        CLEAR ls_marm_x.
      ENDIF.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Plant
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT t1~plant,
           t2~land1
      FROM @gs_data-to_plant AS t1
     INNER JOIN t001w AS t2
        ON t1~plant = t2~werks
      INTO TABLE @DATA(lt_country).

    LOOP AT gs_data-to_plant ASSIGNING FIELD-SYMBOL(<fs_plant_tab>).
      IF to_upper( <fs_plant_tab>-action ) = 'INSERT'.
        ls_mlan1-matnr = <fs_plant_tab>-product.
        ls_mlan1_x-matnr = <fs_plant_tab>-product.
        TRY.
            DATA(ls_country) = lt_country[ plant = <fs_plant_tab>-plant ].
          CATCH cx_sy_itab_line_not_found.
            CLEAR ls_country.
        ENDTRY.
        ls_mlan1-aland   = ls_country-land1.
        ls_mlan1_x-aland = ls_country-land1.

      ENDIF.
      DATA(lv_plant) = <fs_plant_tab>-plant.
      " Plant Procurement
      IF <fs_plant_tab>-to_productplantprocurement IS NOT INITIAL AND ( <fs_plant_tab>-to_productplantprocurement-action = 'Change'
        OR <fs_plant_tab>-to_productplantprocurement-action = 'Insert' ).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantprocurement
            iv_input_stru    = <fs_plant_tab>-to_productplantprocurement
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_productplantprocurement-action = 'Change'.
          CLEAR ls_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_productplantprocurement-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_productplantprocurement-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
        IF  <fs_plant_tab>-to_productplantprocurement-action = 'Insert'
        AND <fs_plant_tab>-to_productplantprocurement-taxindicator IS NOT INITIAL.
          ls_mlan1-taxim = <fs_plant_tab>-to_productplantprocurement-taxindicator.
          ls_mlan1_x-taxim = 'X'.
        ELSEIF <fs_plant_tab>-to_productplantprocurement-action = 'Change'.
          LOOP AT lt_markforchange INTO ls_markforchange.
            IF to_upper( ls_markforchange ) = 'TAXINDICATOR'.
              DATA(l_flag) = 'X'.
              EXIT.
            ENDIF.
          ENDLOOP.
          IF l_flag = 'X'.
            TRY.
                ls_country = lt_country[ plant = <fs_plant_tab>-plant ].
              CATCH cx_sy_itab_line_not_found.
                CLEAR ls_country.
            ENDTRY.
            ls_mlan1-matnr = <fs_plant_tab>-to_productplantprocurement-product.
            ls_mlan1-aland = ls_country-land1.
            ls_mlan1-taxim = <fs_plant_tab>-to_productplantprocurement-taxindicator.
            ls_mlan1_x-matnr = <fs_plant_tab>-to_productplantprocurement-product.
            ls_mlan1_x-aland = ls_country-land1.
            ls_mlan1_x-taxim = 'X'.
            CLEAR l_flag.
          ENDIF.
        ENDIF.
      ENDIF.

      IF ls_mlan1 IS NOT INITIAL.
        IF ls_mlan1-matnr IS INITIAL.
          ls_mlan1_x-matnr = lv_matnr.
          ls_mlan1-matnr = lv_matnr.
        ENDIF.
        INSERT ls_mlan1 INTO TABLE gs_mat-mlan_purchase_tab.
        INSERT ls_mlan1_x INTO TABLE gs_mat-mlan_purchase_x_tab.
        CLEAR ls_mlan1.
        CLEAR ls_mlan1_x.
      ENDIF.
      IF <fs_plant_tab>-to_productworkscheduling IS NOT INITIAL AND ( <fs_plant_tab>-to_productworkscheduling-action = 'Change' OR
        <fs_plant_tab>-to_productworkscheduling-action = 'Insert' ).
        IF <fs_plant_tab>-to_productworkscheduling-action = 'Change'.
          DATA(ls_temp_marc_x) = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productworkscheduling
            iv_input_stru    = <fs_plant_tab>-to_productworkscheduling
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_productworkscheduling-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_productworkscheduling-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_productworkscheduling-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_productsupplyplanning IS NOT INITIAL AND ( <fs_plant_tab>-to_productsupplyplanning-action = 'Change' OR
        <fs_plant_tab>-to_productsupplyplanning-action = 'Insert' ).
        IF <fs_plant_tab>-to_productsupplyplanning-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productsupplyplanning
            iv_input_stru    = <fs_plant_tab>-to_productsupplyplanning
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_productsupplyplanning-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_productsupplyplanning-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_productsupplyplanning-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantsales IS NOT INITIAL AND ( <fs_plant_tab>-to_plantsales-action = 'Change' OR <fs_plant_tab>-to_plantsales-action = 'Insert' ).
        IF <fs_plant_tab>-to_plantsales-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantsales
            iv_input_stru    = <fs_plant_tab>-to_plantsales
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_plantsales-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_plantsales-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_plantsales-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.

      ENDIF.

      IF <fs_plant_tab>-to_planttext IS NOT INITIAL.
        IF <fs_plant_tab>-to_planttext-action = 'Change' AND <fs_plant_tab>-to_planttext-action = 'Insert'.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-planttext
              iv_input_stru    = <fs_plant_tab>-to_planttext
            CHANGING
              ev_output_stru   = ls_stxl_plant
              ev_output_stru_x = ls_stxl_plant_x.

          lv_marc_modify = 'X'.

          IF ls_stxl_plant-matnr IS INITIAL.
            ls_stxl_plant-matnr = lv_matnr.
          ENDIF.
          ls_stxl_plant_x-matnr = ls_stxl_plant-matnr.
          ls_stxl_plant_x-werks = ls_stxl_plant-werks.
          ls_stxl_plant-tdid = 'LTXT'.
          ls_stxl_plant_x-tdid = abap_true.
          INSERT ls_stxl_plant INTO TABLE gs_mat-plant_notes_tab.
          INSERT ls_stxl_plant_x INTO TABLE gs_mat-plant_notes_x_tab.
          CLEAR ls_stxl_plant.
          CLEAR ls_stxl_plant_x.
        ELSEIF <fs_plant_tab>-to_planttext-action = 'Delete'.
          CLEAR lv_stxl_str_name.
          IF <fs_plant_tab>-to_plantsales IS NOT INITIAL.
            CONCATENATE <fs_plant_tab>-to_plantsales-product ' ' <fs_plant_tab>-to_plantsales-plant INTO lv_stxl_str_name
                      RESPECTING BLANKS.
          ENDIF.
          CLEAR lv_stxl_name.
          lv_stxl_name = lv_stxl_str_name.
          IF lv_stxl_name IS NOT INITIAL.

            DATA: lt_selection    TYPE TABLE OF thead.

            CALL FUNCTION 'SELECT_TEXT'
              EXPORTING
                object                  = 'MDTXT'
                name                    = lv_stxl_name
                id                      = 'LTXT'
              TABLES
                selections              = lt_selection
              EXCEPTIONS
                wrong_access_to_archive = 1
                OTHERS                  = 2.

            IF sy-subrc = 0.
              DATA(ls_selection) = lt_selection[ 1 ].

              CALL FUNCTION 'DELETE_TEXT'
                EXPORTING
                  id              = 'LTXT'
                  language        = ls_selection-tdspras
                  name            = lv_stxl_name   "ls_stxl_before-tdname
                  object          = 'MDTXT' "Remains constant for sales text
                  savemode_direct = abap_true.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_productplantcosting IS NOT INITIAL AND ( <fs_plant_tab>-to_productplantcosting-action = 'Change'
        OR <fs_plant_tab>-to_productplantcosting-action = 'Insert' ).
        IF <fs_plant_tab>-to_productplantcosting-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantcosting
            iv_input_stru    = <fs_plant_tab>-to_productplantcosting
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_productplantcosting-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_productplantcosting-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_productplantcosting-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_productplantforecast IS NOT INITIAL AND ( <fs_plant_tab>-to_productplantforecast-action = 'Change'
        OR <fs_plant_tab>-to_productplantforecast-action = 'Insert' ).
        IF <fs_plant_tab>-to_productplantforecast-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantforecast
            iv_input_stru    = <fs_plant_tab>-to_productplantforecast
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_productplantforecast-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_productplantforecast-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_productplantforecast-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_prodplantinternationaltrade IS NOT INITIAL AND ( <fs_plant_tab>-to_prodplantinternationaltrade-action = 'Change'
        OR <fs_plant_tab>-to_prodplantinternationaltrade-action = 'Insert' ).
        IF <fs_plant_tab>-to_prodplantinternationaltrade-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-prodplantinternationaltrade
            iv_input_stru    = <fs_plant_tab>-to_prodplantinternationaltrade
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_prodplantinternationaltrade-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_prodplantinternationaltrade-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_prodplantinternationaltrade-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantstorage IS NOT INITIAL AND ( <fs_plant_tab>-to_plantstorage-action = 'Change' OR <fs_plant_tab>-to_plantstorage-action = 'Insert' ).
        IF <fs_plant_tab>-to_plantstorage-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantstorage
            iv_input_stru    = <fs_plant_tab>-to_plantstorage
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_plantstorage-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_plantstorage-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_plantstorage-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantqualitymgmt IS NOT INITIAL AND ( <fs_plant_tab>-to_plantqualitymgmt-action = 'Change'
        OR <fs_plant_tab>-to_plantqualitymgmt-action = 'Insert' ).
        IF <fs_plant_tab>-to_plantqualitymgmt-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantqualitymgmt
            iv_input_stru    = <fs_plant_tab>-to_plantqualitymgmt
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.

        lv_marc_modify = 'X'.

        IF <fs_plant_tab>-to_plantqualitymgmt-action = 'Change'.
          CLEAR ls_marc_x.
          ls_marc_x = ls_temp_marc_x.
          CLEAR ls_temp_marc_x.
        ENDIF.

        IF <fs_plant_tab>-to_plantqualitymgmt-mdgmarkforchange IS NOT INITIAL.
          SPLIT <fs_plant_tab>-to_plantqualitymgmt-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

***********************For plant main node under product deep struct
      IF <fs_plant_tab>-action = 'Change' OR <fs_plant_tab>-action = 'Insert' OR lt_markforchange IS NOT INITIAL
        OR lv_marc_modify = 'X'.
        IF <fs_plant_tab>-action = 'Change'.
          ls_temp_marc_x = ls_marc_x.
        ENDIF.

        IF <fs_plant_tab>-action IS NOT INITIAL.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-plant
              iv_input_stru    = <fs_plant_tab>
            CHANGING
              ev_output_stru   = ls_marc
              ev_output_stru_x = ls_marc_x.

          IF <fs_plant_tab>-action = 'Change'.
            CLEAR ls_marc_x.
            ls_marc_x = ls_temp_marc_x.
            CLEAR ls_temp_marc_x.
          ENDIF.

          IF ls_marc-matnr IS INITIAL.
            ls_marc-matnr = lv_matnr.
          ENDIF.

          IF <fs_plant_tab>-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_plant_tab>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
          ENDIF.
          APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
          CLEAR lt_markforchange_temp.
        ENDIF.
        "Handle update field for marc table
*          CLEAR ls_marc_x.
        ls_mpgd-prgrp   = <fs_plant_tab>-planningproduct.
        ls_mpgd-prwrk   = <fs_plant_tab>-planningplant.
        ls_mpgd-umref   = <fs_plant_tab>-plngconvfactor.
        IF <fs_plant_tab>-action = 'Insert'.
          ls_mpgd_x-prgrp = 'X'.
          ls_mpgd_x-prwrk = 'X'.
          ls_mpgd_x-umref = 'X'.
        ENDIF.

        LOOP AT lt_markforchange INTO ls_markforchange.
          lv_fieldname = ls_markforchange.
*            lv_table_fieldname = map_field_names( EXPORTING iv_node_name = 'BuPaIdentification' iv_fieldname = lv_FIELDNAME ).

          IF to_upper( lv_fieldname ) = 'PLANNINGPRODUCT'.
            ls_mpgd_x-prgrp = 'X'.
            CONTINUE.
          ENDIF.
          IF to_upper( lv_fieldname ) = 'PLANNINGPLANT'.
            ls_mpgd_x-prwrk = 'X'.
            CONTINUE.
          ENDIF.
          IF to_upper( lv_fieldname ) = 'PLNGCONVFACTOR'.
            ls_mpgd_x-umref = 'X'.
            CONTINUE.
          ENDIF.


          CALL METHOD _map_field_names
            EXPORTING
              iv_node_name = gc_entity-plant
              iv_fieldname = |{ lv_fieldname CASE = UPPER }|
            IMPORTING
              ev_field     = lv_table_fieldname.
          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_marc_x TO <ls_field_data>.
          IF <ls_field_data> IS ASSIGNED.
            <ls_field_data> = abap_true.
          ENDIF.

*          UNASSIGN <ls_field_data>.
*          FIELD-SYMBOLS <ls_changed_val> TYPE any.
*          ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_marc TO <ls_field_data>.
*          ASSIGN COMPONENT lv_fieldname OF STRUCTURE <fs_plant_tab> TO <ls_changed_val>.
*          IF <ls_field_data> IS ASSIGNED AND <ls_changed_val> IS ASSIGNED.
*            <ls_field_data> = <ls_changed_val>.
*          ENDIF.
        ENDLOOP.
        CLEAR lt_markforchange.

        IF ls_marc-werks IS INITIAL.
          ls_marc-werks = <fs_plant_tab>-plant.
        ENDIF.

        ls_marc_x-matnr = ls_marc-matnr.
        ls_marc_x-werks = ls_marc-werks.
        IF ls_marc IS NOT INITIAL.
*          ls_marc-zz_packaging_mode = 'D'.
          INSERT ls_marc INTO TABLE gs_mat-marc_tab.
          INSERT ls_marc_x INTO TABLE gs_mat-marc_x_tab.
          CLEAR lv_marc_modify.
          CLEAR ls_marc.
          CLEAR ls_marc_x.
        ENDIF.
        IF ls_marc-lvorm = abap_true.
          mv_mrp_operation = 'D'.
*          lv_mrparea_api_call = abap_true.
          ls_mdma-matnr = ls_marc-matnr.
          ls_mdma-werks = ls_marc-werks.
          INSERT ls_mdma INTO TABLE gs_mat-mdma_tab.
          CLEAR ls_mdma.
        ENDIF.

        IF ls_mpgd_x IS NOT INITIAL.
          ls_mpgd-matnr = ls_marc-matnr.
          ls_mpgd-werks = ls_marc-werks.
          ls_mpgd_x-matnr = ls_mpgd-matnr.
          ls_mpgd_x-werks = ls_mpgd-werks.
          INSERT ls_mpgd INTO TABLE gs_mat-mpgd_tab.
          INSERT ls_mpgd_x INTO TABLE gs_mat-mpgd_x_tab.
        ENDIF.
        CLEAR: ls_mpgd, ls_mpgd_x.
      ENDIF.
***************************************

      IF <fs_plant_tab>-to_storagelocation IS NOT INITIAL.
        LOOP AT <fs_plant_tab>-to_storagelocation ASSIGNING FIELD-SYMBOL(<fs_storage_loc>).
          IF <fs_storage_loc>-action = 'Change' OR <fs_storage_loc>-action = 'Insert'.
            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-storagelocation
                iv_input_stru    = <fs_storage_loc>
              CHANGING
                ev_output_stru   = ls_mard
                ev_output_stru_x = ls_mard_x.

            "Handle MarkedForChange
            IF <fs_storage_loc>-action = 'Change'.
              CLEAR ls_mard_x.
            ENDIF.
            IF <fs_storage_loc>-mdgmarkforchange IS NOT INITIAL.
              SPLIT <fs_storage_loc>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
            ENDIF.
            LOOP AT lt_markforchange INTO ls_markforchange.
              lv_fieldname = ls_markforchange.
              CALL METHOD _map_field_names
                EXPORTING
                  iv_node_name = gc_entity-storagelocation
                  iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                IMPORTING
                  ev_field     = lv_table_fieldname.
              ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mard_x TO <ls_field_data>.
              IF <ls_field_data> IS ASSIGNED.
                <ls_field_data> = abap_true.
              ENDIF.
            ENDLOOP.
            CLEAR lt_markforchange.

            IF ls_mard-matnr IS INITIAL.
              ls_mard-matnr = lv_matnr.
            ENDIF.
            ls_mard_x-matnr = ls_mard-matnr.
            ls_mard_x-werks = ls_mard-werks.
            ls_mard_x-lgort = ls_mard-lgort.
            INSERT ls_mard INTO TABLE gs_mat-mard_tab.
            INSERT ls_mard_x INTO TABLE gs_mat-mard_x_tab.
            CLEAR ls_mard.
            CLEAR ls_mard_x.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF <fs_plant_tab>-to_plantmrparea IS NOT INITIAL.
        LOOP AT <fs_plant_tab>-to_plantmrparea ASSIGNING FIELD-SYMBOL(<fs_plantmrparea>).
          IF <fs_plantmrparea>-action = 'Change' OR <fs_plantmrparea>-action = 'Insert'.
            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-plantmrparea
                iv_input_stru    = <fs_plantmrparea>
              CHANGING
                ev_output_stru   = ls_mdma
                ev_output_stru_x = ls_mdma_x.

            "Handle MarkedForChange
            IF <fs_plantmrparea>-action = 'Change'.
              CLEAR ls_mdma_x.
            ENDIF.
            IF <fs_plantmrparea>-mdgmarkforchange IS NOT INITIAL.
              SPLIT <fs_plantmrparea>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
            ENDIF.
            LOOP AT lt_markforchange INTO ls_markforchange.
              lv_fieldname = ls_markforchange.
              CALL METHOD _map_field_names
                EXPORTING
                  iv_node_name = gc_entity-plantmrparea
                  iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                IMPORTING
                  ev_field     = lv_table_fieldname.
              ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mdma_x TO <ls_field_data>.
              IF <ls_field_data> IS ASSIGNED.
                <ls_field_data> = abap_true.
              ENDIF.
            ENDLOOP.
            CLEAR lt_markforchange.

            IF ls_mdma-matnr IS INITIAL.
              ls_mdma-matnr = lv_matnr.
            ENDIF.
            ls_mdma_x-matnr = ls_mdma-matnr.
            ls_mdma_x-werks = ls_mdma-werks.
            ls_mdma_x-berid = ls_mdma-berid.
            INSERT ls_mdma INTO TABLE gs_mat-mdma_tab.
            INSERT ls_mdma_x INTO TABLE gs_mat-mdma_x_tab.
            CLEAR ls_mdma.
            CLEAR ls_mdma_x.
          ENDIF.
        ENDLOOP.
      ENDIF.

      " Product Plant forecast parameter MPOP
      IF <fs_plant_tab>-to_prodplntfcstparam IS NOT INITIAL
        AND ( <fs_plant_tab>-to_prodplntfcstparam-action = 'Change'
          OR  <fs_plant_tab>-to_prodplntfcstparam-action = 'Insert'
          OR  <fs_plant_tab>-to_prodplntfcstparam-action = 'Delete'  ).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-prodplntfcstparam
            iv_input_stru    = <fs_plant_tab>-to_prodplntfcstparam
          CHANGING
            ev_output_stru   = ls_mpop
            ev_output_stru_x = ls_mpop_x.

        IF ls_mpop-matnr IS INITIAL.
          ls_mpop-matnr = lv_matnr.
        ENDIF.

        IF ls_mpop-werks IS INITIAL.
          ls_mpop-werks = lv_plant.
        ENDIF.

        ls_mpop_x-matnr = ls_mpop-matnr.
        ls_mpop_x-werks = ls_mpop-werks.

        IF <fs_plant_tab>-to_prodplntfcstparam-action = 'Change' .
          CLEAR: ls_mpop_x.
          IF <fs_plant_tab>-to_prodplntfcstparam-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_plant_tab>-to_prodplntfcstparam-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.

            LOOP AT lt_markforchange INTO ls_markforchange.
              lv_fieldname = ls_markforchange.
              CALL METHOD _map_field_names
                EXPORTING
                  iv_node_name = gc_entity-prodplntfcstparam
                  iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                IMPORTING
                  ev_field     = lv_table_fieldname.
              ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mpop_x TO <ls_field_data>.
              IF <ls_field_data> IS ASSIGNED.
                <ls_field_data> = abap_true.
              ENDIF.
            ENDLOOP.
*           LD-0123 20231128 Kenny Start++
            CLEAR lt_markforchange.
*           LD-0123 20231128 Kenny End++

            ls_mpop_x-matnr = ls_mpop-matnr.
            ls_mpop_x-werks = ls_mpop-werks.
          ENDIF.
        ENDIF.

        IF <fs_plant_tab>-to_prodplntfcstparam-action = 'Delete' .
          CLEAR: ls_mpop_x.
          ls_mpop_x-matnr = ls_mpop-matnr.
          ls_mpop_x-werks = ls_mpop-werks.
          ls_mpop_x-delete_row = abap_true.
        ENDIF.

        INSERT ls_mpop   INTO TABLE gs_mat-mpop_tab.
        INSERT ls_mpop_x INTO TABLE gs_mat-mpop_x_tab.
        CLEAR: ls_mpop, ls_mpop_x.
      ENDIF.

      " Product Plant inspection setting QMAT
      IF <fs_plant_tab>-to_insptypesttng IS NOT INITIAL.
        LOOP AT <fs_plant_tab>-to_insptypesttng ASSIGNING FIELD-SYMBOL(<fs_insptypesttng>)
          WHERE action = 'Change' OR action = 'Delete' OR action = 'Insert'.

          CLEAR: ls_qmat, ls_qmat_x.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-insptypesttng
              iv_input_stru    = <fs_insptypesttng>
            CHANGING
              ev_output_stru   = ls_qmat
              ev_output_stru_x = ls_qmat_x.

          IF ls_qmat-matnr IS INITIAL.
            ls_qmat-matnr = lv_matnr.
          ENDIF.

          IF ls_qmat-werks IS INITIAL.
            ls_qmat-werks = lv_plant.
          ENDIF.

          ls_qmat_x-matnr = ls_qmat-matnr.
          ls_qmat_x-werks = ls_qmat-werks.
          ls_qmat_x-art   = ls_qmat-art.

          " Insert - gt_qmat_ins
          IF <fs_insptypesttng>-action = 'Insert'.
            INSERT ls_qmat   INTO TABLE gt_qmat_ins.
            INSERT ls_qmat_x INTO TABLE gt_qmat_x.

            INSERT ls_qmat   INTO TABLE gs_mat-qmat_tab.
            INSERT ls_qmat_x INTO TABLE gs_mat-qmat_x_tab.
            " Change - gt_qmat_upd
          ELSEIF <fs_insptypesttng>-action = 'Change'.
            CLEAR: ls_qmat_x.
            IF <fs_insptypesttng>-mdgmarkforchange IS NOT INITIAL.

              ls_qmat_x-matnr = ls_qmat-matnr.
              ls_qmat_x-werks = ls_qmat-werks.
              ls_qmat_x-art   = ls_qmat-art.

              SPLIT <fs_insptypesttng>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
              LOOP AT lt_markforchange INTO ls_markforchange.
                lv_fieldname = condense( ls_markforchange ).

                CALL METHOD _map_field_names
                  EXPORTING
                    iv_node_name = gc_entity-insptypesttng
                    iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                  IMPORTING
                    ev_field     = lv_table_fieldname.

                ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_qmat_x TO <ls_field_data>.
                IF <ls_field_data> IS ASSIGNED.
                  <ls_field_data> = abap_true.
                ENDIF.
              ENDLOOP.
*             LD-0123 20231128 Kenny Start++
              CLEAR lt_markforchange.
*             LD-0123 20231128 Kenny End++
              INSERT ls_qmat   INTO TABLE gt_qmat_upd.
              INSERT ls_qmat_x INTO TABLE gt_qmat_x.

              INSERT ls_qmat   INTO TABLE gs_mat-qmat_tab.
              INSERT ls_qmat_x INTO TABLE gs_mat-qmat_x_tab.
            ENDIF.
            " Delete - gt_qmat_del
          ELSEIF <fs_insptypesttng>-action = 'Delete'.
            APPEND ls_qmat TO gt_qmat_del.
            APPEND ls_qmat_x TO gt_qmat_x.
          ENDIF.

        ENDLOOP.
      ENDIF.

      " Product Plant Production Resource Tool
      IF <fs_plant_tab>-to_productresourcetool IS NOT INITIAL
        AND ( <fs_plant_tab>-to_productresourcetool-action = 'Change'
          OR  <fs_plant_tab>-to_productresourcetool-action = 'Insert'
          OR  <fs_plant_tab>-to_productresourcetool-action = 'Delete'  ).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productionresourcetool
            iv_input_stru    = <fs_plant_tab>-to_productresourcetool
          CHANGING
            ev_output_stru   = ls_mfhm
            ev_output_stru_x = ls_mfhm_x.
        IF ls_mpop-matnr IS INITIAL.
          ls_mfhm-matnr = lv_matnr.
        ENDIF.
        IF ls_mpop-werks IS INITIAL.
          ls_mfhm-werks = lv_plant.
        ENDIF.
        ls_mfhm_x-matnr = ls_mfhm-matnr.
        ls_mfhm_x-werks = ls_mfhm-werks.
        IF <fs_plant_tab>-to_productresourcetool-action = 'Change' .
          CLEAR: ls_mfhm_x.
          IF <fs_plant_tab>-to_productresourcetool-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_plant_tab>-to_productresourcetool-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange.
            LOOP AT lt_markforchange INTO ls_markforchange.
              lv_fieldname = ls_markforchange.
              CALL METHOD _map_field_names
                EXPORTING
                  iv_node_name = gc_entity-productionresourcetool
                  iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                IMPORTING
                  ev_field     = lv_table_fieldname.
              ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mpop_x TO <ls_field_data>.
              IF <ls_field_data> IS ASSIGNED.
                <ls_field_data> = abap_true.
              ENDIF.
            ENDLOOP.
*             LD-0123 20231128 Kenny Start++
            CLEAR lt_markforchange.
*             LD-0123 20231128 Kenny End++
            ls_mfhm_x-matnr = ls_mfhm-matnr.
            ls_mfhm_x-werks = ls_mfhm-werks.
          ENDIF.
        ENDIF.
*        Handle case delete production resource tools
*        IF <fs_plant_tab>-to_productresourcetool-action = 'Delete' .
*          CLEAR: ls_mfhm_x.
*          ls_mfhm_x-matnr = ls_mfhm-matnr.
*          ls_mfhm_x-werks = ls_mfhm-werks.
*          ls_mfhm_x-delete_row = abap_true.
*        ENDIF.
        INSERT ls_mfhm   INTO TABLE gs_mat-mfhm_tab.
        INSERT ls_mfhm_x INTO TABLE gs_mat-mfhm_x_tab.
        CLEAR: ls_mfhm, ls_mfhm_x.
      ENDIF.
*     Check if mdgMarkForChange contain planning fields.
      IF to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLANNINGPRODUCT' OR
         to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLANNINGPLANT' OR
         to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLNGCONVFACTOR' OR
         <fs_plant_tab>-action = 'Insert'.
        ls_mpgd-matnr = ls_marc-matnr.
        ls_mpgd-werks = ls_marc-werks.
        ls_mpgd_x-matnr = ls_mpgd-matnr.
        ls_mpgd_x-werks = ls_mpgd-werks.
        IF to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLANNINGPRODUCT' OR  <fs_plant_tab>-action = 'Insert'.
          ls_mpgd-prgrp = <fs_plant_tab>-planningproduct.
          ls_mpgd_x-prgrp = 'X'.
        ENDIF.
        IF to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLANNINGPRODUCT' OR  <fs_plant_tab>-action = 'Insert'.
          ls_mpgd-prwrk = <fs_plant_tab>-planningplant.
          ls_mpgd_x-prwrk = 'X'.
        ENDIF.
        IF to_upper( <fs_plant_tab>-mdgmarkforchange ) CS 'PLANNINGPRODUCT' OR  <fs_plant_tab>-action = 'Insert'.
          ls_mpgd-umref = <fs_plant_tab>-plngconvfactor.
          ls_mpgd_x-umref = 'X'.
        ENDIF.
        INSERT ls_mpgd INTO TABLE gs_mat-mpgd_tab.
        INSERT ls_mpgd_x INTO TABLE gs_mat-mpgd_x_tab.
        CLEAR: ls_mpgd,ls_mpgd_x.

      ENDIF.
    ENDLOOP.

    SELECT t1~bwkey,
           t1~waers
      FROM fmlv_ckmlct AS t1
     INNER JOIN @gs_data-to_valuation AS t2
        ON t1~bwkey = t2~valuationarea
     WHERE t1~curtp = '10'
      INTO TABLE @DATA(lt_ckmlct).
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Valuation
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA
         lv_amount TYPE bapicurr-bapicurr.
    LOOP AT gs_data-to_valuation ASSIGNING FIELD-SYMBOL(<fs_valuation>).
      READ TABLE lt_ckmlct INTO DATA(ls_ckmlct)
        WITH KEY bwkey = <fs_valuation>-valuationarea.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      IF <fs_valuation>-standardprice <> 0.
        lv_amount = <fs_valuation>-standardprice.
        CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
          EXPORTING
            currency             = ls_ckmlct-waers
            amount_external      = lv_amount
            max_number_of_digits = '23'
          IMPORTING
            amount_internal      = lv_amount
*           return               =
          .
        IF sy-subrc = 0.
          <fs_valuation>-standardprice = lv_amount.
        ENDIF.
      ENDIF.
      IF <fs_valuation>-movingaverageprice <> 0.
        lv_amount = <fs_valuation>-movingaverageprice.
        CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
          EXPORTING
            currency             = ls_ckmlct-waers
            amount_external      = lv_amount
            max_number_of_digits = '23'
          IMPORTING
            amount_internal      = lv_amount
*           return               =
          .
        IF sy-subrc = 0.
          <fs_valuation>-movingaverageprice = lv_amount.
        ENDIF.
      ENDIF.
      MOVE-CORRESPONDING <fs_valuation> TO ls_valuation.
      IF ls_valuation-to_valuationaccount-action = 'Change'
        OR ls_valuation-to_valuationaccount-action = 'Insert'.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-valuationaccount
            iv_input_stru    = ls_valuation-to_valuationaccount
          CHANGING
            ev_output_stru   = ls_mbew
            ev_output_stru_x = ls_mbew_x.

        IF ls_valuation-to_valuationaccount-action = 'Change'.
          CLEAR ls_mbew_x.
        ENDIF.
        IF ls_valuation-to_valuationaccount-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_valuation-to_valuationaccount-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.

        IF ls_mbew-matnr IS INITIAL.
          ls_mbew-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF ls_valuation-action = 'Change'
        OR ls_valuation-action = 'Insert'.
        IF ls_valuation-action = 'Change'.
          DATA(temp_ls_mbew_x) = ls_mbew_x.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-valuation
            iv_input_stru    = ls_valuation
          CHANGING
            ev_output_stru   = ls_mbew
            ev_output_stru_x = ls_mbew_x.
        IF ls_valuation-action = 'Change'.
          CLEAR ls_mbew_x.
          ls_mbew_x = temp_ls_mbew_x.
          CLEAR temp_ls_mbew_x.
        ENDIF.
        IF ls_mbew-matnr IS INITIAL.
          ls_mbew-matnr = lv_matnr.
        ENDIF.

        IF ls_valuation-mdgmarkforchange IS NOT INITIAL.
          SPLIT ls_valuation-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
        ENDIF.
        APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
        CLEAR lt_markforchange_temp.
      ENDIF.
      "Handle update field for marc table
*        CLEAR ls_mbew_x.

      LOOP AT <fs_valuation>-to_mlaccount ASSIGNING <fs_mlaccount>.

        IF <fs_mlaccount>-currencyrole = 10 AND <fs_mlaccount>-standardprice <> 0.
          lv_amount = <fs_mlaccount>-standardprice.
          CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
            EXPORTING
              currency             = ls_ckmlct-waers
              amount_external      = lv_amount
              max_number_of_digits = '23'
            IMPORTING
              amount_internal      = lv_amount
*             return               =
            .
          IF sy-subrc = 0.
            <fs_mlaccount>-standardprice = lv_amount.
          ENDIF.
        ENDIF.
        IF <fs_mlaccount>-currencyrole = 10 AND <fs_mlaccount>-movingaverageprice <> 0.
          lv_amount = <fs_mlaccount>-movingaverageprice.
          CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
            EXPORTING
              currency             = ls_ckmlct-waers
              amount_external      = lv_amount
              max_number_of_digits = '23'
            IMPORTING
              amount_internal      = lv_amount
*             return               =
            .
          IF sy-subrc = 0.
            <fs_mlaccount>-movingaverageprice = lv_amount.
          ENDIF.
        ENDIF.
        IF <fs_mlaccount>-action = 'Change' OR <fs_mlaccount>-action = 'Insert'.
          IF ls_valuation-action = 'Change'.
            temp_ls_mbew_x = ls_mbew_x.
          ENDIF.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-mlaccount
              iv_input_stru    = <fs_mlaccount>
            CHANGING
              ev_output_stru   = ls_mbew
              ev_output_stru_x = ls_mbew_x.

          IF <fs_mlaccount>-action = 'Change'.
            CLEAR ls_mbew_x.
            ls_mbew_x = temp_ls_mbew_x.
            CLEAR temp_ls_mbew_x.
          ENDIF.

          IF <fs_mlaccount>-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_mlaccount>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
          ENDIF.
          APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
          CLEAR lt_markforchange_temp.

          IF ls_mbew-matnr IS INITIAL.
            ls_mbew-matnr = lv_matnr.
          ENDIF.

        ENDIF.
      ENDLOOP.

      LOOP AT lt_markforchange INTO ls_markforchange.
        lv_fieldname = ls_markforchange.
        IF lv_fieldname = 'standardPrice' OR lv_fieldname = 'movingAveragePrice'.
          CONTINUE.
        ENDIF.
*          lv_table_fieldname = map_field_names( EXPORTING iv_node_name = 'BuPaIdentification' iv_fieldname = lv_FIELDNAME ).
        CALL METHOD _map_field_names
          EXPORTING
            iv_node_name = gc_entity-valuation
            iv_fieldname = |{ lv_fieldname CASE = UPPER }|
          IMPORTING
            ev_field     = lv_table_fieldname.
        ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_mbew_x TO <ls_field_data>.
        IF <ls_field_data> IS ASSIGNED.
          <ls_field_data> = abap_true.
        ENDIF.
      ENDLOOP.
*     LD-0123 20231128 Kenny Start++
      CLEAR lt_markforchange.
*     LD-0123 20231128 Kenny End++
      IF ls_mbew-matnr IS NOT INITIAL.
        ls_mbew_x-matnr = ls_mbew-matnr.

        IF ls_mbew-bwtar IS INITIAL.
          ls_mbew-bwtar = ls_valuation-valuationtype.
        ENDIF.

        IF ls_mbew-bwkey IS INITIAL.
          ls_mbew-bwkey = ls_valuation-valuationarea.
        ENDIF.

        ls_mbew_x-bwtar = ls_mbew-bwtar.
        ls_mbew_x-bwkey = ls_mbew-bwkey.
        INSERT ls_mbew INTO TABLE gs_mat-mbew_tab.
        INSERT ls_mbew_x INTO TABLE gs_mat-mbew_x_tab.
        CLEAR ls_mbew.
        CLEAR ls_mbew_x.
      ENDIF.
      CLEAR lt_markforchange.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Classification
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT t1~objek,
           t1~klart,
           t3~class,
           t1~stdcl,
           t1~statu
      FROM kssk AS t1
     INNER JOIN klah AS t3
        ON t1~clint = t3~clint
     INNER JOIN @gs_data-to_classification AS t2
        ON t1~objek = t2~product
       AND t1~klart = t2~classtype
       AND t3~class = t2~class
     WHERE t1~klart <> '023'
     UNION ALL
    SELECT t1~objek,
           t2~klart,
           t3~class,
           t2~stdcl,
           t3~statu
      FROM inob AS t1
     INNER JOIN kssk AS t2
        ON t1~cuobj = t2~objek
     INNER JOIN klah AS t3
        ON t2~clint = t3~clint
     WHERE t1~obtab = 'MARA'
       AND t2~klart = '023'
       AND t1~objek = @gs_data-product
      INTO TABLE @DATA(lt_kssk).

    DATA: ls_classification TYPE /simple/clfn_s.
    LOOP AT gs_data-to_classification INTO DATA(ls_clfn).
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " Start add - Add logic update for classification - 20220306
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      TRY.
          DATA(ls_kssk) = lt_kssk[ objek = gv_product
                                   klart = ls_clfn-classtype
                                   class = ls_clfn-class ].
          DATA(lv_standardclass) = ls_kssk-stdcl.
          DATA(lv_status)        = ls_kssk-statu.

        CATCH cx_sy_itab_line_not_found.
          CLEAR: lv_status, lv_standardclass.
      ENDTRY.

      IF to_upper( ls_clfn-action ) = 'CHANGE'.
        SPLIT ls_clfn-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
        IF lt_markforchange IS NOT INITIAL.
          LOOP AT lt_markforchange INTO ls_markforchange.
            IF ls_markforchange = 'standardClass'.
              lv_standardclass = ls_clfn-standardclass.
            ELSEIF ls_markforchange = 'status'.
              lv_status = ls_clfn-status.
            ENDIF.
          ENDLOOP.
*         LD-0123 20231128 Kenny Start++
          CLEAR lt_markforchange.
*         LD-0123 20231128 Kenny End++

        ENDIF.
      ELSEIF to_upper( ls_clfn-action ) = 'INSERT'.
        lv_standardclass = ls_clfn-standardclass.
        lv_status        = ls_clfn-status.
      ENDIF.
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      " Start add - Add logic update for classification - 20220306
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      ls_classification-action      = ls_clfn-action.
      ls_classification-objecttable = 'MARA'.
      ls_classification-classnum    = ls_clfn-class.
      ls_classification-classtype   = ls_clfn-classtype.
      ls_classification-stdclass    = lv_standardclass.
      ls_classification-status      = lv_status.

      LOOP AT ls_clfn-to_characteristic INTO DATA(ls_characteristic).
        DATA(ls_instance) = '1'.
        TRY.
            DATA(ls_ausp) = gt_ausp[ atnam = ls_characteristic-charc ].
          CATCH cx_sy_itab_line_not_found.
            CLEAR ls_ausp.
        ENDTRY.


*       Ignore deleted characteristic
        IF to_upper( ls_characteristic-action ) NE 'DELETE'.
          IF ls_ausp-atfor = 'CHAR'.
            APPEND VALUE #( charact    = |{ ls_characteristic-charc CASE = UPPER }|
                          value_char_long = ls_characteristic-charcvalue
                          instance   = ls_instance )
                      TO ls_classification-allocvalueschar.
          ELSEIF ls_ausp-atfor = 'NUM'.
            APPEND VALUE #( charact    = |{ ls_characteristic-charc CASE = UPPER }|
                            value_from = ls_characteristic-charcvalue
                            instance   = ls_instance )
                      TO ls_classification-allocvaluesnum.
          ENDIF.
        ENDIF.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " Start add - Add logic update for classification
        " in case of change it's characteristic - 20220530
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        IF ls_classification-action IS INITIAL.

          IF ls_characteristic-action IS NOT INITIAL.
            ls_classification-action = 'Change'.
          ENDIF.

        ENDIF.
      ENDLOOP.

      APPEND ls_classification TO gt_classification.
      CLEAR: ls_classification.
    ENDLOOP.
    me->_map_revision_level( ).
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_create.

    DATA:
      lv_matnr              TYPE matnr,
      ls_mara               TYPE cmd_bs_mat_s_mara,
      ls_mara_x             TYPE cmd_bs_mat_s_mara_x,
      ls_makt               TYPE cmd_bs_mat_s_makt,
      ls_makt_x             TYPE cmd_bs_mat_s_makt_x,
      ls_stxl_sales         TYPE cmd_bs_mat_s_notes_sales,
      ls_stxl_sales_x       TYPE cmd_bs_mat_s_notes_sales_x,
      ls_mvke               TYPE cmd_bs_mat_s_mvke,
      ls_mvke_x             TYPE cmd_bs_mat_s_mvke_x,
      ls_marc               TYPE cmd_bs_mat_s_marc,
      ls_marc_x             TYPE cmd_bs_mat_s_marc_x,
      ls_stxl_plant         TYPE cmd_bs_mat_s_notes_plant,
      ls_stxl_plant_x       TYPE cmd_bs_mat_s_notes_plant_x,
      ls_mard               TYPE cmd_bs_mat_s_mard,
      ls_mard_x             TYPE cmd_bs_mat_s_mard_x,
      ls_mdma               TYPE cmd_bs_mat_s_mdma,
      ls_mdma_x             TYPE cmd_bs_mat_s_mdma_x,
      ls_qmat               TYPE cmd_bs_mat_s_qmat,
      ls_qmat_x             TYPE cmd_bs_mat_s_qmat_x,
      ls_mpop               TYPE cmd_bs_mat_s_mpop,
      ls_mpop_x             TYPE cmd_bs_mat_s_mpop_x,
      ls_mlgn               TYPE cmd_bs_mat_s_mlgn,
      ls_mlgn_x             TYPE cmd_bs_mat_s_mlgn_x,
      ls_mlgt               TYPE cmd_bs_mat_s_mlgt,
      ls_mlgt_x             TYPE cmd_bs_mat_s_mlgt_x,
      ls_mlan               TYPE cmd_bs_mat_s_steu,
      ls_mlan_x             TYPE cmd_bs_mat_s_steu_x,
      ls_mlan1              TYPE cmd_bs_mat_s_steumm,
      ls_mlan1_x            TYPE cmd_bs_mat_s_steumm_x,
      ls_stxl               TYPE cmd_bs_mat_s_notes,
      ls_stxl_x             TYPE cmd_bs_mat_s_notes_x,
      ls_mean               TYPE cmd_bs_mat_s_mean,
      ls_mean_x             TYPE cmd_bs_mat_s_mean_x,
      ls_marm               TYPE cmd_bs_mat_s_marm,
      ls_marm_x             TYPE cmd_bs_mat_s_marm_x,
      ls_mbew               TYPE cmd_bs_mat_s_mbew,
      ls_mbew_x             TYPE cmd_bs_mat_s_mbew_x,
      ls_mfhm               TYPE cmd_bs_mat_s_mfhm,
      ls_mfhm_x             TYPE cmd_bs_mat_s_mfhm_x,
      ls_mpgd               TYPE cmd_bs_mat_s_mpgd,
      ls_mpgd_x             TYPE cmd_bs_mat_s_mpgd_x,
      " JHOANG adds mapping structure declaration for Product Warehouse - 27/10/2023 - start
      ls_matlwh             TYPE /sapapo/matlwh,
      lt_prdextendwarehouse TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse.
    " JHOANG adds mapping structure declaration for Product Warehouse - 27/10/2023 - end

    _adjust_val_ml_nodes(
      EXPORTING
        iv_after_mmd      = abap_false
      CHANGING
        ct_valuation_data = gs_data-to_valuation
    ).

    IF gs_data-product IS NOT INITIAL.
      lv_matnr = gs_data-product.
    ELSE.
*     Begin of Ins by Danh Tran - LD-0075
*      lv_matnr = gc_matnr_tmp.

      IF gs_data-producttype ='HERS'.
        IF gv_testrun IS INITIAL.
          DATA LV_RETURNCODE TYPE INRI-RETURNCODE.
          CALL FUNCTION 'NUMBER_GET_NEXT'
            EXPORTING
              nr_range_nr                   = '01'
              object                        = '/SIMPLE/HE'
           IMPORTING
             NUMBER                        = lv_matnr
             RETURNCODE                    = LV_RETURNCODE
           EXCEPTIONS
             INTERVAL_NOT_FOUND            = 1
             NUMBER_RANGE_NOT_INTERN       = 2
             OBJECT_NOT_FOUND              = 3
             QUANTITY_IS_0                 = 4
             QUANTITY_IS_NOT_1             = 5
             INTERVAL_OVERFLOW             = 6
             BUFFER_OVERFLOW               = 7
                    .
          IF SY-SUBRC <> 0 OR LV_RETURNCODE IS NOT INITIAL.
            lv_matnr = gc_matnr_tmp.

          ELSE.
            lv_matnr = 'MPN' && lv_matnr.
          ENDIF.

        ELSE.
          lv_matnr = gc_matnr_tmp && 'T'.
        ENDIF.

      ELSE.
        lv_matnr = gc_matnr_tmp.
      ENDIF.
*     End of Ins by Danh Tran - LD-0075
      IF gs_data-mdgkeyprefix1 IS NOT INITIAL OR
         gs_data-mdgkeyprefix2 IS NOT INITIAL OR
         gs_data-mdgkeyprefix3 IS NOT INITIAL OR
         gs_data-mdgkeyprefix4 IS NOT INITIAL OR
         gs_data-mdgkeyprefix5 IS NOT INITIAL.

        DATA: lv_prefix TYPE string.
        DATA: lv_prefix_que TYPE string.
        DATA: lv_max_matnr TYPE mara-matnr.
        DATA: lv_prefix_length TYPE i.
        DATA: lv_surfix_length TYPE i.
        DATA: lv_surfix TYPE string.
        DATA: lv_surfix_after TYPE string.
        DATA: lv_surfix_count TYPE i.

        CONCATENATE gs_data-mdgkeyprefix1
                    gs_data-mdgkeyprefix2
                    gs_data-mdgkeyprefix3
                    gs_data-mdgkeyprefix4
                    gs_data-mdgkeyprefix5 INTO lv_prefix.

        CONCATENATE gs_data-mdgkeyprefix1
                    gs_data-mdgkeyprefix2
                    gs_data-mdgkeyprefix3
                    gs_data-mdgkeyprefix4
                    gs_data-mdgkeyprefix5 '%' INTO lv_prefix_que.

        lv_prefix_length = strlen( lv_prefix ).

*      Check the incresement of prefix
        SELECT MAX( matnr ) INTO lv_max_matnr
           FROM mara WHERE matnr LIKE lv_prefix_que.
        IF sy-subrc = 0 AND lv_max_matnr IS NOT INITIAL.
          lv_surfix = lv_max_matnr+lv_prefix_length.
          IF lv_surfix CO '0123456789'.

            MOVE lv_surfix TO lv_surfix_count.
            lv_surfix_count = lv_surfix_count + 1.
            lv_surfix_after = lv_surfix_count.
            CONDENSE lv_surfix_after NO-GAPS.
            lv_surfix_length = strlen( lv_surfix_after ).

            DO ( 18 - lv_prefix_length - lv_surfix_length ) TIMES.
              IF sy-index <> ( 18 - lv_prefix_length ).
                CONCATENATE '0' lv_surfix_after INTO lv_surfix_after.
              ENDIF.
            ENDDO.

            CONCATENATE lv_prefix lv_surfix_after INTO lv_matnr.
          ELSE.
            lv_matnr = gc_matnr_tmp.
          ENDIF.
        ELSE.
          lv_matnr = lv_prefix.
          DO ( 18 - lv_prefix_length ) TIMES.
            IF sy-index <> ( 18 - lv_prefix_length ).
              CONCATENATE lv_matnr '0' INTO lv_matnr.
            ELSE.
              CONCATENATE lv_matnr '1' INTO lv_matnr.
            ENDIF.
          ENDDO.
        ENDIF.

      ELSE.
        lv_matnr = gc_matnr_tmp.
      ENDIF.
    ENDIF.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " MARA
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    IF gs_data-to_productsales IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productsales
          iv_input_stru    = gs_data-to_productsales
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
    ENDIF.

    IF gs_data-to_productprocurement IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productprocurement
          iv_input_stru    = gs_data-to_productprocurement
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
    ENDIF.

    IF gs_data-to_productstorage IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productstorage
          iv_input_stru    = gs_data-to_productstorage
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
    ENDIF.

    IF gs_data-to_productqualitymgmt IS NOT INITIAL.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productqualitymgmt
          iv_input_stru    = gs_data-to_productqualitymgmt
        CHANGING
          ev_output_stru   = ls_mara
          ev_output_stru_x = ls_mara_x.
      IF ls_mara-matnr IS INITIAL.
        ls_mara-matnr = lv_matnr.
      ENDIF.
    ENDIF.

    CALL METHOD map_fields
      EXPORTING
        iv_entity_name   = gc_entity-product
        iv_input_stru    = gs_data
      CHANGING
        ev_output_stru   = ls_mara
        ev_output_stru_x = ls_mara_x.
    IF ls_mara-matnr IS INITIAL.
      ls_mara-matnr = lv_matnr.
    ENDIF.

    IF ls_mara-matnr = gc_matnr_tmp.
      ls_mara-is_matnr_tmp = 'X'.
    ENDIF.
    ls_mara-mbrsh   = gs_data-industrysector.   " Industry sector
    ls_mara_x-mbrsh = 'X'.
    ls_mara_x-matnr = ls_mara-matnr.

    " Conversion
    " Conversion for REQMAXSHLIFE to SCM_SHLF_LFE_REQ_MAX
    IF gs_data-reqmaxshlife IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_TSTRG_INPUT'
        EXPORTING
          input          = gs_data-reqmaxshlife
        IMPORTING
          output         = ls_mara-scm_shlf_lfe_req_max
        EXCEPTIONS
          invalid_format = 1
          OTHERS         = 2.
      IF sy-subrc = 0.
        ls_mara_x-scm_shlf_lfe_req_max = 'X'.
      ENDIF.
    ENDIF.

    " Conversion for Period Ind. (mara-iprkz)
    IF gs_data-to_productstorage-shelflifeexpirationdateperiod IS NOT INITIAL.
      CALL FUNCTION 'CONVERSION_EXIT_PERKZ_INPUT'
        EXPORTING
          input  = gs_data-to_productstorage-shelflifeexpirationdateperiod
        IMPORTING
          output = ls_mara-iprkz.
      ls_mara_x-iprkz = 'X'.
    ENDIF.
    INSERT ls_mara_x INTO TABLE gs_mat-mara_x_tab.
    INSERT ls_mara INTO TABLE gs_mat-mara_tab.
    CLEAR: ls_mara, ls_mara_x.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " MAKT
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_description ASSIGNING FIELD-SYMBOL(<fs_description>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-description
          iv_input_stru    = <fs_description>
        CHANGING
          ev_output_stru   = ls_makt
          ev_output_stru_x = ls_makt_x.
      IF ls_makt-matnr IS INITIAL.
        ls_makt-matnr = lv_matnr.
      ENDIF.
      ls_makt_x-matnr = ls_makt-matnr.
      ls_makt_x-spras = ls_makt-spras.
      INSERT ls_makt INTO TABLE gs_mat-makt_tab.
      INSERT ls_makt_x INTO TABLE gs_mat-makt_x_tab.
      CLEAR: ls_makt, ls_makt_x.
    ENDLOOP. " MAKT

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Sales delivery
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_salesdelivery ASSIGNING FIELD-SYMBOL(<fs_sal_del>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-salesdelivery
          iv_input_stru    = <fs_sal_del>
        CHANGING
          ev_output_stru   = ls_mvke
          ev_output_stru_x = ls_mvke_x.
      IF ls_mvke-matnr IS INITIAL.
        ls_mvke-matnr = lv_matnr.
      ENDIF.
      ls_mvke_x-matnr = ls_mvke-matnr.
      ls_mvke_x-vkorg = ls_mvke-vkorg.
      ls_mvke_x-vtweg = ls_mvke-vtweg.
      INSERT ls_mvke INTO TABLE gs_mat-mvke_tab.
      INSERT ls_mvke_x INTO TABLE gs_mat-mvke_x_tab.

      LOOP AT <fs_sal_del>-to_salestext ASSIGNING FIELD-SYMBOL(<fs_sales_text>).
        IF <fs_sales_text> IS NOT INITIAL.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-salestext
              iv_input_stru    = <fs_sales_text>
            CHANGING
              ev_output_stru   = ls_stxl_sales
              ev_output_stru_x = ls_stxl_sales_x.

          IF ls_stxl_sales-matnr IS INITIAL.
            ls_stxl_sales-matnr = lv_matnr.
          ENDIF.

          IF ls_stxl_sales-vkorg IS INITIAL.
            ls_stxl_sales-vkorg = ls_mvke-vkorg.
          ENDIF.

          IF ls_stxl_sales-vtweg IS INITIAL.
            ls_stxl_sales-vtweg = ls_mvke-vtweg.
          ENDIF.

          ls_stxl_sales_x-matnr = ls_stxl_sales-matnr.
          ls_stxl_sales_x-vkorg = ls_stxl_sales-vkorg.
          ls_stxl_sales_x-vtweg = ls_stxl_sales-vtweg.
          ls_stxl_sales_x-langu = ls_stxl_sales-langu.
          ls_stxl_sales-tdid    = '0001'.
          ls_stxl_sales_x-tdid  = 'X'.
          INSERT ls_stxl_sales INTO TABLE gs_mat-sales_notes_tab.
          INSERT ls_stxl_sales_x INTO TABLE gs_mat-sales_notes_x_tab.
          CLEAR: ls_stxl_sales, ls_stxl_sales_x.
        ENDIF.
      ENDLOOP.

      CLEAR: ls_mvke, ls_mvke_x.
    ENDLOOP. " Sales Delivery

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Plant
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "
    SELECT t1~plant,
           t2~land1
      FROM @gs_data-to_plant AS t1
     INNER JOIN t001w AS t2
        ON t1~plant = t2~werks
      INTO TABLE @DATA(lt_country).
*       .

    LOOP AT gs_data-to_plant ASSIGNING FIELD-SYMBOL(<fs_plant_tab>).

      ls_mlan1-matnr = <fs_plant_tab>-product.
      ls_mlan1_x-matnr = <fs_plant_tab>-product.
      TRY.
          DATA(ls_country) = lt_country[ plant = <fs_plant_tab>-plant ].
        CATCH cx_sy_itab_line_not_found.
          CLEAR ls_country.
      ENDTRY.
      ls_mlan1-aland = ls_country-land1.
      ls_mlan1_x-aland = ls_country-land1.
      " New nodes under plant , procurement and scheduling
      IF <fs_plant_tab>-to_productplantprocurement IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantprocurement
            iv_input_stru    = <fs_plant_tab>-to_productplantprocurement
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
        IF <fs_plant_tab>-to_productplantprocurement-taxindicator IS NOT INITIAL.
          ls_mlan1-taxim = <fs_plant_tab>-to_productplantprocurement-taxindicator.
          ls_mlan1_x-taxim = 'X'.
        ENDIF.

      ENDIF.
      IF ls_mlan1-matnr IS  INITIAL.
        ls_mlan1-matnr = lv_matnr.
        ls_mlan1_x-matnr     = lv_matnr.
      ENDIF.
      IF ls_mlan1 IS NOT INITIAL.
        INSERT ls_mlan1 INTO TABLE gs_mat-mlan_purchase_tab.
        INSERT ls_mlan1_x INTO TABLE gs_mat-mlan_purchase_x_tab.
        CLEAR: ls_mlan1, ls_mlan1_x.
      ENDIF.



      IF <fs_plant_tab>-to_productworkscheduling IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productworkscheduling
            iv_input_stru    = <fs_plant_tab>-to_productworkscheduling
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_productsupplyplanning IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productsupplyplanning
            iv_input_stru    = <fs_plant_tab>-to_productsupplyplanning
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantsales IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantsales
            iv_input_stru    = <fs_plant_tab>-to_plantsales
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.

      ENDIF.

      IF <fs_plant_tab>-to_productplantcosting IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantcosting
            iv_input_stru    = <fs_plant_tab>-to_productplantcosting
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_productplantforecast IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productplantforecast
            iv_input_stru    = <fs_plant_tab>-to_productplantforecast
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_prodplantinternationaltrade IS NOT INITIAL.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-prodplantinternationaltrade
            iv_input_stru    = <fs_plant_tab>-to_prodplantinternationaltrade
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantstorage IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantstorage
            iv_input_stru    = <fs_plant_tab>-to_plantstorage
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      IF <fs_plant_tab>-to_plantqualitymgmt IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantqualitymgmt
            iv_input_stru    = <fs_plant_tab>-to_plantqualitymgmt
          CHANGING
            ev_output_stru   = ls_marc
            ev_output_stru_x = ls_marc_x.
        IF ls_marc-matnr IS INITIAL.
          ls_marc-matnr = lv_matnr.
        ENDIF.
      ENDIF.

***************************For plant main node under product deep struct
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-plant
          iv_input_stru    = <fs_plant_tab>
        CHANGING
          ev_output_stru   = ls_marc
          ev_output_stru_x = ls_marc_x.
      IF ls_marc-matnr IS INITIAL.
        ls_marc-matnr = lv_matnr.
      ENDIF.
      ls_marc_x-matnr = ls_marc-matnr.
      ls_marc_x-werks = ls_marc-werks.
      IF ls_marc IS NOT INITIAL.
*        ls_marc-zz_packaging_mode = 'D'.
*        ls_marc_x-zz_packaging_mode = 'X'.
        INSERT ls_marc INTO TABLE gs_mat-marc_tab.
        INSERT ls_marc_x INTO TABLE gs_mat-marc_x_tab.
      ENDIF.
*******************************************

      IF <fs_plant_tab>-to_planttext IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-planttext
            iv_input_stru    = <fs_plant_tab>-to_planttext
          CHANGING
            ev_output_stru   = ls_stxl_plant
            ev_output_stru_x = ls_stxl_plant_x.
        IF ls_stxl_plant-matnr IS INITIAL.
          ls_stxl_plant-matnr = lv_matnr.
        ENDIF.
        IF ls_stxl_plant-werks IS INITIAL.
          ls_stxl_plant-werks = ls_marc-werks.
        ENDIF.
        ls_stxl_plant_x-matnr = ls_stxl_plant-matnr.
        ls_stxl_plant_x-werks = ls_stxl_plant-werks.
        ls_stxl_plant-tdid = 'LTXT'.
        ls_stxl_plant_x-tdid = 'X'.
        INSERT ls_stxl_plant INTO TABLE gs_mat-plant_notes_tab.
        INSERT ls_stxl_plant_x INTO TABLE gs_mat-plant_notes_x_tab.
        CLEAR ls_stxl_plant.
        CLEAR ls_stxl_plant_x.
      ENDIF.

      LOOP AT <fs_plant_tab>-to_storagelocation ASSIGNING FIELD-SYMBOL(<fs_storage_loc>).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-storagelocation
            iv_input_stru    = <fs_storage_loc>
          CHANGING
            ev_output_stru   = ls_mard
            ev_output_stru_x = ls_mard_x.
        IF ls_mard-matnr IS INITIAL.
          ls_mard-matnr = lv_matnr.
        ENDIF.
        IF ls_mard-werks IS INITIAL.
          ls_mard-werks = ls_marc-werks.
        ENDIF.
        ls_mard_x-matnr = ls_mard-matnr.
        ls_mard_x-werks = ls_mard-werks.
        ls_mard_x-lgort = ls_mard-lgort.
        INSERT ls_mard INTO TABLE gs_mat-mard_tab.
        INSERT ls_mard_x INTO TABLE gs_mat-mard_x_tab.
        CLEAR: ls_mard, ls_mard_x.
      ENDLOOP.

      LOOP AT <fs_plant_tab>-to_plantmrparea ASSIGNING FIELD-SYMBOL(<fs_plantmrparea>).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-plantmrparea
            iv_input_stru    = <fs_plantmrparea>
          CHANGING
            ev_output_stru   = ls_mdma
            ev_output_stru_x = ls_mdma_x.
        IF ls_mdma-matnr IS INITIAL.
          ls_mdma-matnr = lv_matnr.
        ENDIF.
        IF ls_mdma-werks IS INITIAL.
          ls_mdma-werks = ls_marc-werks.
        ENDIF.
        ls_mdma_x-matnr = ls_mdma-matnr.
        ls_mdma_x-werks = ls_mdma-werks.
        ls_mdma_x-berid = ls_mdma-berid.
        INSERT ls_mdma INTO TABLE gs_mat-mdma_tab.
        INSERT ls_mdma_x INTO TABLE gs_mat-mdma_x_tab.
        CLEAR: ls_mdma, ls_mdma_x.
      ENDLOOP.

      " Product Plant inspection type setting
      LOOP AT <fs_plant_tab>-to_insptypesttng ASSIGNING FIELD-SYMBOL(<fs_insptypest>).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-insptypesttng
            iv_input_stru    = <fs_insptypest>
          CHANGING
            ev_output_stru   = ls_qmat
            ev_output_stru_x = ls_qmat_x.
        IF ls_qmat-matnr IS INITIAL.
          ls_qmat-matnr = lv_matnr.
        ENDIF.
        IF ls_qmat-werks IS INITIAL.
          ls_qmat-werks = ls_marc-werks.
        ENDIF.
        ls_qmat_x-matnr = ls_qmat-matnr.
        ls_qmat_x-werks = ls_qmat-werks.
        ls_qmat_x-art   = ls_qmat-art.
        INSERT ls_qmat   INTO TABLE gs_mat-qmat_tab.
        INSERT ls_qmat_x INTO TABLE gs_mat-qmat_x_tab.

        INSERT ls_qmat   INTO TABLE gt_qmat_ins.
        INSERT ls_qmat_x INTO TABLE gt_qmat_x.
        CLEAR: ls_qmat, ls_qmat_x.
      ENDLOOP.

      " Product Plant forecast parameters
      IF <fs_plant_tab>-to_prodplntfcstparam IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-prodplntfcstparam
            iv_input_stru    = <fs_plant_tab>-to_prodplntfcstparam
          CHANGING
            ev_output_stru   = ls_mpop
            ev_output_stru_x = ls_mpop_x.
        IF ls_mpop-matnr IS INITIAL.
          ls_mpop-matnr = lv_matnr.
        ENDIF.
        IF ls_mpop-werks IS INITIAL.
          ls_mpop-werks = ls_marc-werks.
        ENDIF.
        ls_mpop_x-matnr = ls_mpop-matnr.
        ls_mpop_x-werks = ls_mpop-werks.

        IF ls_marc-perkz IS NOT INITIAL.
          ls_mpop-perkz   = ls_marc-perkz.
          ls_mpop_x-perkz = 'X'.
        ENDIF.

        INSERT ls_mpop   INTO TABLE gs_mat-mpop_tab.
        INSERT ls_mpop_x INTO TABLE gs_mat-mpop_x_tab.
        CLEAR: ls_mpop, ls_mpop_x.
      ENDIF.

      "Production Resource Tool
      IF <fs_plant_tab>-to_productresourcetool IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productionresourcetool
            iv_input_stru    = <fs_plant_tab>-to_productresourcetool
          CHANGING
            ev_output_stru   = ls_mfhm
            ev_output_stru_x = ls_mfhm_x.
        IF ls_mfhm-matnr IS INITIAL.
          ls_mfhm-matnr = lv_matnr.
        ENDIF.
        IF ls_mfhm-werks IS INITIAL.
          ls_mfhm-werks = ls_marc-werks.
        ENDIF.
        ls_mfhm_x-matnr = ls_mfhm-matnr.
        ls_mfhm_x-werks = ls_mfhm-werks.
        INSERT ls_mfhm INTO TABLE gs_mat-mfhm_tab.
        INSERT ls_mfhm_x INTO TABLE gs_mat-mfhm_x_tab.
      ENDIF.
      IF <fs_plant_tab>-planningproduct IS NOT INITIAL OR
         <fs_plant_tab>-planningplant   IS NOT INITIAL OR
         <fs_plant_tab>-plngconvfactor  IS NOT INITIAL .
        IF <fs_plant_tab>-planningproduct IS NOT INITIAL.
          ls_mpgd-prgrp   = <fs_plant_tab>-planningproduct.
          ls_mpgd_x-prgrp = 'X'.
        ENDIF.
        IF <fs_plant_tab>-planningplant IS NOT INITIAL.
          ls_mpgd-prwrk   = <fs_plant_tab>-planningplant.
          ls_mpgd_x-prwrk = 'X'.
        ENDIF.
        IF <fs_plant_tab>-plngconvfactor IS NOT INITIAL.
          ls_mpgd-umref   = <fs_plant_tab>-plngconvfactor.
          ls_mpgd_x-umref = 'X'.
        ENDIF.
        ls_mpgd-matnr = ls_marc-matnr.
        ls_mpgd-werks = ls_marc-werks.
        ls_mpgd_x-matnr = ls_mpgd-matnr.
        ls_mpgd_x-werks = ls_mpgd-werks.
        INSERT ls_mpgd INTO TABLE gs_mat-mpgd_tab.
        INSERT ls_mpgd_x INTO TABLE gs_mat-mpgd_x_tab.
        CLEAR: ls_mpgd, ls_mpgd_x.
      ENDIF.

      CLEAR: ls_marc, ls_marc_x.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Warehouse
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productwarehouse ASSIGNING FIELD-SYMBOL(<fs_prd_warehouse>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productwarehouse
          iv_input_stru    = <fs_prd_warehouse>
        CHANGING
          ev_output_stru   = ls_mlgn
          ev_output_stru_x = ls_mlgn_x.
      IF ls_mlgn-matnr IS INITIAL.
        ls_mlgn-matnr = lv_matnr.
      ENDIF.
      ls_mlgn_x-matnr = ls_mlgn-matnr.
      ls_mlgn_x-lgnum = ls_mlgn-lgnum.
      INSERT ls_mlgn INTO TABLE gs_mat-mlgn_tab.
      INSERT ls_mlgn_x INTO TABLE gs_mat-mlgn_x_tab.

      LOOP AT <fs_prd_warehouse>-to_productstoragetype ASSIGNING FIELD-SYMBOL(<fs_prd_storagetype>).
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productstoragetype
            iv_input_stru    = <fs_prd_storagetype>
          CHANGING
            ev_output_stru   = ls_mlgt
            ev_output_stru_x = ls_mlgt_x.
        IF ls_mlgt-matnr IS INITIAL.
          ls_mlgt-matnr = lv_matnr.
        ENDIF.
        IF ls_mlgt-lgnum IS INITIAL.
          ls_mlgt-lgnum = ls_mlgn-lgnum.
        ENDIF.
        ls_mlgt_x-matnr = ls_mlgt-matnr.
        ls_mlgt_x-lgnum = ls_mlgt-lgnum.
        ls_mlgt_x-lgtyp = ls_mlgt-lgtyp.
        INSERT ls_mlgt INTO TABLE gs_mat-mlgt_tab.
        INSERT ls_mlgt_x INTO TABLE gs_mat-mlgt_x_tab.
        CLEAR: ls_mlgt, ls_mlgt_x.
      ENDLOOP.
      CLEAR: ls_mlgn, ls_mlgn_x.
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Sales Tax
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productsalestax ASSIGNING FIELD-SYMBOL(<fs_sal_tax>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productsalestax
          iv_input_stru    = <fs_sal_tax>
        CHANGING
          ev_output_stru   = ls_mlan
          ev_output_stru_x = ls_mlan_x.
      IF ls_mlan-matnr IS INITIAL.
        ls_mlan-matnr = lv_matnr.
      ENDIF.
      ls_mlan_x-matnr = ls_mlan-matnr.
      ls_mlan_x-aland = ls_mlan-aland.
      ls_mlan_x-tatyp = ls_mlan-tatyp.
      INSERT ls_mlan INTO TABLE gs_mat-mlan_sales_tab.
      INSERT ls_mlan_x INTO TABLE gs_mat-mlan_sales_x_tab.
*       INSERT ls_mlan INTO TABLE gs_mat-mlan_purchase_tab.
*       INSERT ls_mlan_x INTO TABLE gs_mat-mlan_purchase_x_tab.
      CLEAR: ls_mlan, ls_mlan_x.
    ENDLOOP.
*    LOOP AT gs_data-to_productsalestax ASSIGNING <fs_sal_tax>.
**      CALL METHOD map_fields
**        EXPORTING
**          iv_entity_name   = gc_entity-productsalestax
**          iv_input_stru    = <fs_sal_tax>
**        CHANGING
**          ev_output_stru   = ls_mlan1
**          ev_output_stru_x = ls_mlan1_x.
**      IF ls_mlan1-matnr IS INITIAL.
**        ls_mlan1-matnr = lv_matnr.
**      ENDIF.
*      ls_mlan1-matnr = lv_matnr.
*      ls_mlan1-aland = <fs_sal_tax>-country.
**      ls_mlan1-taxim = '1'.
*      ls_mlan1_x-matnr = lv_matnr.
*      ls_mlan1_x-aland = <fs_sal_tax>-country.
*      ls_mlan1_x-taxim = 'X'.
**      INSERT ls_mlan INTO TABLE gs_mat-mlan_sales_tab.
**      INSERT ls_mlan_x INTO TABLE gs_mat-mlan_sales_x_tab.
*      INSERT ls_mlan1 INTO TABLE gs_mat-mlan_purchase_tab.
*      INSERT ls_mlan1_x INTO TABLE gs_mat-mlan_purchase_x_tab.
*      CLEAR: ls_mlan1, ls_mlan1_x.
*    ENDLOOP.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Basic text - purchase text - inspection text
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productbasictext ASSIGNING FIELD-SYMBOL(<fs_prod_text>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productbasictext
          iv_input_stru    = <fs_prod_text>
        CHANGING
          ev_output_stru   = ls_stxl
          ev_output_stru_x = ls_stxl_x.
      IF ls_stxl-matnr IS INITIAL.
        ls_stxl-matnr = lv_matnr.
      ENDIF.
      ls_stxl_x-matnr = ls_stxl-matnr.
      ls_stxl_x-langu = ls_stxl-langu.
      ls_stxl-tdid    = 'GRUN'.
      ls_stxl_x-tdid  = 'X'.
      INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
      INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
      CLEAR: ls_stxl, ls_stxl_x.
    ENDLOOP.

    LOOP AT gs_data-to_productpurchasetext ASSIGNING FIELD-SYMBOL(<fs_prod_purchase_text>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productbasictext   "since structure is as same as product basic text
          iv_input_stru    = <fs_prod_purchase_text>
        CHANGING
          ev_output_stru   = ls_stxl
          ev_output_stru_x = ls_stxl_x.
      IF ls_stxl-matnr IS INITIAL.
        ls_stxl-matnr = lv_matnr.
      ENDIF.
      ls_stxl_x-matnr = ls_stxl-matnr.
      ls_stxl_x-langu = ls_stxl-langu.
      ls_stxl-tdid    = 'BEST'.
      ls_stxl_x-tdid  = 'X'.
      INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
      INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
      CLEAR: ls_stxl, ls_stxl_x.
    ENDLOOP.

    LOOP AT gs_data-to_productinspectiontext ASSIGNING FIELD-SYMBOL(<fs_prod_inspection_text>).
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-productbasictext   "since structure is as same as product basic text
          iv_input_stru    = <fs_prod_inspection_text>
        CHANGING
          ev_output_stru   = ls_stxl
          ev_output_stru_x = ls_stxl_x.
      IF ls_stxl-matnr IS INITIAL.
        ls_stxl-matnr = lv_matnr.
      ENDIF.
      ls_stxl_x-matnr = ls_stxl-matnr.
      ls_stxl_x-langu = ls_stxl-langu.
      ls_stxl-tdid    = 'PRUE'.
      ls_stxl_x-tdid  = 'X'.
      INSERT ls_stxl INTO TABLE gs_mat-notes_tab.
      INSERT ls_stxl_x INTO TABLE gs_mat-notes_x_tab.
      CLEAR: ls_stxl, ls_stxl_x.
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " UoM
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT gs_data-to_productunitsofmeasure ASSIGNING FIELD-SYMBOL(<fs_prod_uom>).
      IF <fs_prod_uom>-alternativeunit <> gs_data-baseunit.
        IF <fs_prod_uom>-to_internationalarticlenumber IS NOT INITIAL.
          LOOP AT <fs_prod_uom>-to_internationalarticlenumber ASSIGNING FIELD-SYMBOL(<fs_prod_uom_ean>).
            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-internationalarticlenumber
                iv_input_stru    = <fs_prod_uom_ean>
              CHANGING
                ev_output_stru   = ls_mean
                ev_output_stru_x = ls_mean_x.
            IF ls_mean-matnr IS INITIAL.
              ls_mean-matnr = lv_matnr.
            ENDIF.
            ls_mean_x-matnr = ls_mean-matnr.
            ls_mean_x-meinh = ls_mean-meinh.
            ls_mean_x-lfnum = ls_mean-lfnum.
            INSERT ls_mean INTO TABLE gs_mat-mean_tab.
            INSERT ls_mean_x INTO TABLE gs_mat-mean_x_tab.
            CLEAR: ls_mean, ls_mean_x.
          ENDLOOP.
        ENDIF.

        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-productunitsofmeasure
            iv_input_stru    = <fs_prod_uom>
          CHANGING
            ev_output_stru   = ls_marm
            ev_output_stru_x = ls_marm_x.
        IF ls_marm-matnr IS INITIAL.
          ls_marm-matnr = lv_matnr.
        ENDIF.
        ls_marm_x-matnr = ls_marm-matnr.
        ls_marm_x-meinh = ls_marm-meinh.
        INSERT ls_marm INTO TABLE gs_mat-marm_tab.
        INSERT ls_marm_x INTO TABLE gs_mat-marm_x_tab.
        CLEAR: ls_marm, ls_marm_x.
      ENDIF.
    ENDLOOP.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Valuation
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA lv_amount TYPE bapicurr-bapicurr.
    SELECT t1~bwkey,
           t1~waers
      FROM fmlv_ckmlct AS t1
     INNER JOIN @gs_data-to_valuation AS t2
        ON t1~bwkey = t2~valuationarea
     WHERE t1~curtp = '10'
      INTO TABLE @DATA(lt_ckmlct).
    LOOP AT gs_data-to_valuation ASSIGNING FIELD-SYMBOL(<fs_prod_val>).
      READ TABLE lt_ckmlct INTO DATA(ls_ckmlct)
        WITH KEY bwkey = <fs_prod_val>-valuationarea.
      IF sy-subrc <> 0.
*        CONTINUE.
        CLEAR ls_ckmlct.
      ENDIF.
      IF ls_ckmlct IS NOT INITIAL.
        IF <fs_prod_val>-standardprice <> 0.
          lv_amount = <fs_prod_val>-standardprice.
          CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
            EXPORTING
              currency             = ls_ckmlct-waers
              amount_external      = lv_amount
              max_number_of_digits = '23'
            IMPORTING
              amount_internal      = lv_amount
*             return               =
            .
          IF sy-subrc = 0.
            <fs_prod_val>-standardprice = lv_amount.
          ENDIF.
        ENDIF.
      ENDIF.
      IF ls_ckmlct IS NOT INITIAL.
        IF <fs_prod_val>-movingaverageprice <> 0.
          lv_amount = <fs_prod_val>-movingaverageprice.
          CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
            EXPORTING
              currency             = ls_ckmlct-waers
              amount_external      = lv_amount
              max_number_of_digits = '23'
            IMPORTING
              amount_internal      = lv_amount
*             return               =
            .
          IF sy-subrc = 0.
            <fs_prod_val>-movingaverageprice = lv_amount.
          ENDIF.
        ENDIF.
      ENDIF.
      CALL METHOD map_fields
        EXPORTING
          iv_entity_name   = gc_entity-valuation
          iv_input_stru    = <fs_prod_val>
        CHANGING
          ev_output_stru   = ls_mbew
          ev_output_stru_x = ls_mbew_x.
      IF ls_mbew-matnr IS INITIAL.
        ls_mbew-matnr = lv_matnr.
      ENDIF.

      IF <fs_prod_val>-to_valuationaccount IS NOT INITIAL.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-valuationaccount
            iv_input_stru    = <fs_prod_val>-to_valuationaccount
          CHANGING
            ev_output_stru   = ls_mbew
            ev_output_stru_x = ls_mbew_x.
        IF ls_mbew-matnr IS INITIAL.
          ls_mbew-matnr = lv_matnr.
        ENDIF.
      ENDIF.

      LOOP AT <fs_prod_val>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlaccount>).
        IF ( <fs_mlaccount>-currency = '10' OR <fs_mlaccount>-currency = '' )  AND <fs_prod_val>-standardprice <> 0.
          lv_amount = <fs_prod_val>-standardprice.
          IF ls_ckmlct IS NOT INITIAL.
            CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
              EXPORTING
                currency             = ls_ckmlct-waers
                amount_external      = lv_amount
                max_number_of_digits = '23'
              IMPORTING
                amount_internal      = lv_amount
*               return               =
              .
            IF sy-subrc = 0.
              <fs_prod_val>-standardprice = lv_amount.
            ENDIF.
          ENDIF.
        ENDIF.

        IF ( <fs_mlaccount>-currency = '10' OR <fs_mlaccount>-currency = '' ) AND <fs_mlaccount>-movingaverageprice <> 0.
          lv_amount = <fs_prod_val>-movingaverageprice.
          IF ls_ckmlct IS NOT INITIAL.
            CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
              EXPORTING
                currency             = ls_ckmlct-waers
                amount_external      = lv_amount
                max_number_of_digits = '23'
              IMPORTING
                amount_internal      = lv_amount.
*           return               =
            IF sy-subrc = 0.
              <fs_prod_val>-movingaverageprice = lv_amount.
            ENDIF.
          ENDIF.
        ENDIF.
        CALL METHOD map_fields
          EXPORTING
            iv_entity_name   = gc_entity-mlaccount
            iv_input_stru    = <fs_mlaccount>
          CHANGING
            ev_output_stru   = ls_mbew
            ev_output_stru_x = ls_mbew_x.
      ENDLOOP.

      ls_mbew_x-matnr = ls_mbew-matnr.
      ls_mbew_x-bwtar = ls_mbew-bwtar.
      ls_mbew_x-bwkey = ls_mbew-bwkey.
      INSERT ls_mbew INTO TABLE gs_mat-mbew_tab.
      INSERT ls_mbew_x INTO TABLE gs_mat-mbew_x_tab.
      CLEAR: ls_mbew, ls_mbew_x.
    ENDLOOP.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Classification
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA: ls_classification TYPE /simple/clfn_s.
    LOOP AT gs_data-to_classification INTO DATA(ls_clfn).
      ls_classification-objecttable = 'MARA'.
      ls_classification-classnum = ls_clfn-class.
      ls_classification-classtype = ls_clfn-classtype.
      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      "Start add - add fields for classification - 20220306
      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      ls_classification-stdclass    = ls_clfn-standardclass.
      ls_classification-status      = ls_clfn-status.
      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      "End add - add fields for classification - 20220306
      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

      LOOP AT ls_clfn-to_characteristic INTO DATA(ls_characteristic)
        GROUP BY ( charact = ls_characteristic-charc )
         INTO DATA(ls_group).
        DATA: ls_instance TYPE numchar3.
        LOOP AT GROUP ls_group INTO ls_characteristic.
          DATA(ls_ausp) = gt_ausp[ atnam = ls_characteristic-charc ].
          ls_instance = ls_instance + 1.
          IF ls_ausp-atfor = 'CHAR'.
            APPEND VALUE #( charact    = |{ ls_characteristic-charc CASE = UPPER }|
                          value_char_long = ls_characteristic-charcvalue
                          instance   = ls_instance )
                      TO ls_classification-allocvalueschar.
          ELSEIF ls_ausp-atfor = 'NUM'.
            APPEND VALUE #( charact    = |{ ls_characteristic-charc CASE = UPPER }|
                            value_from = ls_characteristic-charcvalue
                            instance   = ls_instance )
                      TO ls_classification-allocvaluesnum.
          ENDIF.

        ENDLOOP.


      ENDLOOP.

      APPEND ls_classification TO gt_classification.
      CLEAR: ls_classification.
    ENDLOOP.
*   LD-0099 - 20231030 - Kenny Bui - Start++
    me->_map_view_extend( ).
*   LD-0099 - 20231030 - Kenny Bui - End++
    me->_map_revision_level( ).
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~do_mapping_delete.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_change.
    DATA(lv_exist) = _check_existence( iv_product = gs_data-product ).
    IF lv_exist = abap_false.
      me->_add_message(
        EXPORTING
          msgty = 'E'
          msgid = 'M3'
          msgno = '305'
          msgv1 = |{ gs_data-product }| ).
    ENDIF.


*SELECT talnd,
*           tatyp,
*           t4~VKORG
*      FROM tstl AS t1
*     INNER JOIN @gs_data-to_productsalestax AS t2
*        ON t1~talnd = t2~country
*       AND t1~tatyp = t2~taxcategory
*     INNER JOIN adrc AS t3
*        ON t1~talnd = t3~country
*     INNER JOIN tvko AS t4
*        ON t3~addrnumber = t4~adrnr
*      INTO TABLE @DATA(lt_tax).
*
*    SELECT t1~werks,
*           t1~land1
*      FROM t001w AS t1
*     INNER JOIN tstl AS t2
*        ON t1~land1 = t2~talnd
*     INNER JOIN @gs_data-to_productsalestax AS t3
*        ON t2~talnd = t3~country
*       AND t2~tatyp = t3~taxcategory
*      INTO TABLE @DATA(lt_plant).
*
*    LOOP AT gs_data-to_productsalestax INTO DATA(ls_prdsalestax).
*
*      TRY.
*          DATA(ls_tax) = lt_tax[ talnd = ls_prdsalestax-country
*                                 tatyp = ls_prdsalestax-taxcategory ].
*        CATCH cx_sy_itab_line_not_found.
*          CLEAR ls_tax.
*      ENDTRY.
*
*      IF ls_tax IS INITIAL.
*        gt_message = VALUE #( BASE et_message (
*                          type   = 'E'
*                          id     = 'M3'
*                          number = '019'
*                          message_v1 = ls_prdsalestax-country
*                          message_v2 = ls_prdsalestax-taxcategory ) ).
*      ELSE.
*        IF NOT line_exists( gs_data-to_salesdelivery[ productsalesorg = ls_tax-vkorg ] ).
*          gt_message = VALUE #( BASE et_message (
*                          type   = 'E'
**                          id     = 'M3'
**                          number = '019'
*                          message = |'Cannot enter the sales tax for country { ls_prdsalestax-country }|
*                                  & | without maintaining corresponding Sales Organization'| ) ).
*        ENDIF.
*
*      ENDIF.
*    ENDLOOP.
    DATA(lt_charc) = VALUE gty_t_charc( ).

    SELECT t1~klart,
           t1~class
        FROM klah AS t1
        INNER JOIN @gs_data-to_classification AS t2
        ON t1~klart = t2~classtype
        AND t1~class = t2~class
        INTO TABLE @DATA(lt_class).

    IF gs_data-to_classification IS NOT INITIAL.
      LOOP AT gs_data-to_classification INTO DATA(ls_classification).
*        DATA(lv_matnr) = |{ ls_classification-product ALPHA = IN }|.
        IF NOT line_exists( lt_class[ klart = ls_classification-classtype
                              class = ls_classification-class ] ).

          gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = 'CL'
                                 number      = '503'
                                 message_v1  = ls_classification-classtype
                                 message_v2  = ls_classification-class
                               ) ).

        ENDIF.
        IF ls_classification-classtype = '023'.
          IF to_upper( ls_classification-action ) = 'DELETE'.
            SELECT DISTINCT
                   t1~werks,
                   t1~lgort,
                   t1~charg,
                   t1~lfgja,
                   t1~lfmon,
                   concat( t1~lfgja , t1~lfmon ) AS period,
                   CAST( 'X' AS CHAR ) AS delete
              FROM mchb AS t1
             WHERE t1~matnr = @ls_classification-product
              INTO TABLE @DATA(lt_period).

            SELECT t1~werks,
                   t1~lgort,
                   t1~charg,
                   MAX( t1~period ) AS period
              FROM @lt_period AS t1
             GROUP BY
                   t1~werks,
                   t1~lgort,
                   t1~charg
              INTO TABLE @DATA(lt_max_period).

            LOOP AT lt_period ASSIGNING FIELD-SYMBOL(<fs_period>).
              READ TABLE lt_max_period INTO DATA(ls_max_period)
                WITH KEY period = <fs_period>-period.
              IF sy-subrc = 0.
                <fs_period>-delete = ''.
              ENDIF.
            ENDLOOP.

            DELETE lt_period WHERE delete = 'X'.

            SELECT t1~matnr,
                   t1~clabs
              FROM mchb AS t1
             INNER JOIN @lt_period AS t2
                ON t1~werks = t2~werks
               AND t1~lgort = t2~lgort
               AND t1~charg = t2~charg
             WHERE t1~matnr = @ls_classification-product
               AND t1~clabs <> 0
              INTO TABLE @DATA(lt_stock_batch).
            IF sy-subrc = 0.
              gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = 'CL'
                                 number      = '572'
*                                 message     = |{ ls_charac-atnam }: Invalid Characteristic of Class Type|

                               ) ).
            ENDIF.
          ENDIF.
        ENDIF.
        LOOP AT ls_classification-to_characteristic INTO DATA(ls_charc).
*         Ignore character has been deleted
          IF to_upper( ls_charc-action ) NE 'DELETE'.

            lt_charc =  VALUE #( BASE lt_charc
                                  ( class = ls_classification-class
                                    klart = ls_classification-classtype
                                    atnam = ls_charc-charc
                                    value = ls_charc-charcvalue ) ).
          ENDIF.
        ENDLOOP.

      ENDLOOP.
    ENDIF.
    SELECT t1~class,
           t1~klart,
           t3~atnam,
           t3~atfor,
           t3~anzst,
           t3~anzdz,
           t3~atdex,
           t3~atdim,
           t3~atvor,
           t3~atsch,
           t3~msehi,
           t3~atint,
           t3~atkle,
           t3~atein,
           t3~atson
      FROM klah AS t1
     INNER JOIN ksml AS t2
        ON t1~clint = t2~clint
     INNER JOIN cabn AS t3
        ON t2~imerk = t3~atinn
     INNER JOIN @lt_charc AS t4
        ON t1~class = t4~class
       AND t1~klart = t4~klart
       AND t3~atnam = t4~atnam
      INTO TABLE @gt_ausp.

    SELECT t1~class,
       t1~klart,
       t1~atnam,
       t1~atein,
       COUNT( * ) AS count
  FROM @gt_ausp AS t1
 WHERE t1~atein = 'X'
 GROUP BY t1~class,
          t1~klart,
          t1~atnam,
          t1~atein
HAVING COUNT( * ) > 1
  INTO TABLE @DATA(lt_count).

    SELECT t1~class,
           t1~klart,
           t3~atnam,
           t5~atwrt,
           t3~atson
      FROM klah AS t1
     INNER JOIN ksml AS t2
        ON t1~clint = t2~clint
     INNER JOIN cabn AS t3
        ON t2~imerk = t3~atinn
     INNER JOIN @lt_charc AS t4
        ON t1~class = t4~class
       AND t1~klart = t4~klart
       AND t3~atnam = t4~atnam
     INNER JOIN cawn AS t5
        ON t3~atinn = t5~atinn
      INTO TABLE @DATA(lt_fix_value).


    LOOP AT lt_charc INTO DATA(ls_charac).
      IF line_exists( lt_count[ class = ls_charac-class
                                klart = ls_charac-klart
                                atnam = ls_charac-atnam ] ).
        gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = '000'
                                 message     = |{ ls_charac-atnam }: Multiple values assignment is not allowed| )  ).

      ENDIF.

      IF NOT line_exists( gt_ausp[ class = ls_charac-class
                                   klart = ls_charac-klart
                                   atnam = ls_charac-atnam ] ).
        gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = ''
                                 message     = |{ ls_charac-atnam }: Invalid Characteristic of Class Type| )  ).

      ELSE.
        IF ls_charac-value IS NOT INITIAL.
          DATA(lv_type_charc) = gt_ausp[ class = ls_charac-class
                                         klart = ls_charac-klart
                                         atnam = ls_charac-atnam ].
          DATA lt_strg TYPE STANDARD TABLE OF strg.
          IF line_exists( lt_fix_value[ class = ls_charac-class
                                            klart = ls_charac-klart
                                            atnam = ls_charac-atnam
                                            atson = '' ] ).

            IF NOT line_exists( lt_fix_value[ class = ls_charac-class
                                          klart = ls_charac-klart
                                          atnam = ls_charac-atnam
                                          atwrt = ls_charac-value ] ).
              gt_message = VALUE #( BASE gt_message
                             ( type        = 'E'
                               message     = |{ ls_charac-atnam }: invalid value inputted| )  ).

            ENDIF.


          ELSE.
            IF lv_type_charc-atfor = 'CHAR'.
              DATA lv_value TYPE string.
              lv_value = ls_charac-value.
              CONDENSE lv_value.
              DATA(lv_length) = strlen( lv_value ).
              IF lv_length > lv_type_charc-mazst.
                gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = ''
                                 message     = |{ ls_charac-atnam }: Value { ls_charac-value } is too long| )  ).
              ENDIF.
            ELSE.
              CALL FUNCTION 'CTCV_SYNTAX_CHECK'
                EXPORTING
                  attribut                  = lv_type_charc-atnam
                  baseunit                  = lv_type_charc-meinh
                  decimals                  = lv_type_charc-mazdz
                  dec_presentation          = ','
                  exponent                  = lv_type_charc-atdim
                  exponent_art              = lv_type_charc-atdex
                  format                    = lv_type_charc-atfor
                  interval                  = lv_type_charc-miwrt
                  language                  = sy-langu
                  length                    = lv_type_charc-mazst
                  lowercase                 = lv_type_charc-atein
                  mask                      = lv_type_charc-mscha
                  mask_allowed              = ' '
                  negativ                   = lv_type_charc-mvorz
*                 screen_name               = space
*                 single_selection          = space
                  string                    = ls_charac-value
*                 value_seperator           = ';'
                  classtype                 = lv_type_charc-klart
*                 t_separator               = ' '
*                 err_name                  =
*             IMPORTING
*                 string_is_masked          =
                TABLES
                  tstrg                     = lt_strg
                EXCEPTIONS
                  currency_check            = 1
                  date_check                = 2
                  format_check              = 3
                  illegal_internal_baseunit = 4
                  interval_check            = 5
                  pattern_check             = 6
                  time_check                = 7
                  unit_check                = 8
                  no_valid_dimension        = 9
                  interval_not_allowed      = 10
                  presentation_not_possible = 11
                  OTHERS                    = 12.
              IF sy-subrc <> 0.
                DATA lv_msg TYPE string.
                CALL FUNCTION 'FORMAT_MESSAGE'
                  EXPORTING
                    id        = sy-msgid
                    lang      = sy-langu
                    no        = sy-msgno
                    v1        = ls_charac-value
                    v2        = sy-msgv2
                    v3        = sy-msgv3
                    v4        = sy-msgv4
                  IMPORTING
                    msg       = lv_msg
                  EXCEPTIONS
                    not_found = 1
                    OTHERS    = 2.

                DATA(lv_msgty) = sy-msgty.
                IF sy-subrc = 0.
                  gt_message = VALUE #( BASE gt_message
                                ( type        = lv_msgty
                                  message     = |{ ls_charac-atnam }:{ lv_msg }| ) ).
                ENDIF.
              ENDIF.


            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

    "15.11.2023 add by elsa - start
    IF gs_data-to_salesdelivery IS NOT INITIAL.

      SELECT vkorg,
             werks
        FROM tvkwz AS t1
       INNER JOIN @gs_data-to_salesdelivery AS t2
          ON t1~vkorg = t2~productsalesorg AND
             t1~vtweg = t2~productdistributionchnl
        INTO TABLE @DATA(lt_tvkwz).

      SELECT land1
        FROM t001w AS t1
       INNER JOIN @lt_tvkwz AS t2
          ON t1~werks = t2~werks
       INTO TABLE @DATA(lt_country).

      LOOP AT lt_country INTO DATA(ls_country).
        IF NOT line_exists( gs_data-to_productsalestax[ country = ls_country-land1 ] ).
          gt_message = VALUE #( BASE et_message (
                                  type = 'E'
                                  id   = 'MG'
                                  number = '172' ) ).
        ENDIF.
      ENDLOOP.
    ENDIF.

*checks whether AKTIV-KZ can be set or withdrawn
*    types:
*      begin of lty_insptype,
*        matnr type qmat-matnr,
*        werks type qmat-werks,
*        art   type qmat-art,
*      end of lty_insptype.
*    loop at gs_data-to_plant into data(ls_plant).
*
*    endloop.
*    CALL FUNCTION 'MATERIAL_READ_QINS'
*      EXPORTING
*        matnr              = gs_data-product
*        werks              =
**      IMPORTING
**        qmbestand_exi      =
**        /cwm/qmbestand_exi =
    .
  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_create.

    DATA(lv_exist) = _check_existence( iv_product = gs_data-product ).
    IF lv_exist = abap_true.
      me->_add_message(
        EXPORTING
          msgty = 'E'
          msgid = 'M3'
          msgno = '307' ).
    ENDIF.

    DATA(lt_charc) = VALUE gty_t_charc( ).

    SELECT t1~klart,
           t1~class
      FROM klah AS t1
     INNER JOIN @gs_data-to_classification AS t2
        ON t1~klart = t2~classtype
       AND t1~class = t2~class
      INTO TABLE @DATA(lt_class).

    IF gs_data-to_classification IS NOT INITIAL.
      LOOP AT gs_data-to_classification INTO DATA(ls_classification).
        IF NOT line_exists( lt_class[ klart = ls_classification-classtype
                                     class = ls_classification-class ] ).

          gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = 'CL'
                                 number      = '503'
                                 message_v1  = ls_classification-classtype
                                 message_v2  = ls_classification-class
                               ) ).

        ENDIF.
        LOOP AT ls_classification-to_characteristic INTO DATA(ls_charc).
          lt_charc = VALUE #( BASE lt_charc
                                ( class = ls_classification-class
                                  klart = ls_classification-classtype
                                  atnam = ls_charc-charc
                                  value = ls_charc-charcvalue ) ).
        ENDLOOP.

      ENDLOOP.
    ENDIF.
    DATA(ls_t134) = VALUE t134( ).
    CALL FUNCTION 'T134_SINGLE_READ'
      EXPORTING
        t134_mtart = gs_data-producttype
      IMPORTING
        wt134      = ls_t134
      EXCEPTIONS
        not_found  = 01.
    IF NOT ls_t134-envop IS INITIAL.
      IF  gs_data-product CO ' 0123456789' AND gs_data-division <> 'PK'
      AND gs_data-producttype = 'ZFER'.
        me->_add_message(
          EXPORTING
            msgty = 'E'
            msgid = 'M3'
            msgno = '565' ).
      ELSEIF gs_data-product CO ' 0123456789' AND
             (   ( gs_data-division = 'PK' AND gs_data-producttype = 'ZFER' )
              OR ( gs_data-producttype = 'ZHAL') ).
        SELECT fromnumber,
               tonumber
          FROM nriv
         WHERE object = 'MATERIALNR'
           AND nrrangenr = '80'
          INTO TABLE @DATA(lt_nriv).

        DATA(ls_nriv) = lt_nriv[ 1 ].
        IF gs_data-product NOT BETWEEN ls_nriv-fromnumber AND ls_nriv-tonumber.
          gt_message = VALUE #( BASE et_message (
                          type = 'E'
                          message = |Ext.Material number must be in { ls_nriv-fromnumber } - { ls_nriv-tonumber }| ) ).
        ENDIF.
      ENDIF.
    ENDIF.

*    SELECT talnd,
*           tatyp,
*           t4~VKORG
*      FROM tstl AS t1
*     INNER JOIN @gs_data-to_productsalestax AS t2
*        ON t1~talnd = t2~country
*       AND t1~tatyp = t2~taxcategory
*     INNER JOIN adrc AS t3
*        ON t1~talnd = t3~country
*     INNER JOIN tvko AS t4
*        ON t3~addrnumber = t4~adrnr
*      INTO TABLE @DATA(lt_tax).
*
*    SELECT t1~werks,
*           t1~land1
*      FROM t001w AS t1
*     INNER JOIN tstl AS t2
*        ON t1~land1 = t2~talnd
*     INNER JOIN @gs_data-to_productsalestax AS t3
*        ON t2~talnd = t3~country
*       AND t2~tatyp = t3~taxcategory
*      INTO TABLE @DATA(lt_plant).
*
*    LOOP AT gs_data-to_productsalestax INTO DATA(ls_prdsalestax).
*
*      TRY.
*          DATA(ls_tax) = lt_tax[ talnd = ls_prdsalestax-country
*                                 tatyp = ls_prdsalestax-taxcategory ].
*        CATCH cx_sy_itab_line_not_found.
*          CLEAR ls_tax.
*      ENDTRY.
*
*      IF ls_tax IS INITIAL.
*        gt_message = VALUE #( BASE et_message (
*                          type   = 'E'
*                          id     = 'M3'
*                          number = '019'
*                          message_v1 = ls_prdsalestax-country
*                          message_v2 = ls_prdsalestax-taxcategory ) ).
*      ELSE.
*        IF NOT line_exists( gs_data-to_salesdelivery[ productsalesorg = ls_tax-vkorg ] ).
*          gt_message = VALUE #( BASE et_message (
*                          type   = 'E'
**                          id     = 'M3'
**                          number = '019'
*                          message = |'Cannot enter the sales tax for country { ls_prdsalestax-country }|
*                                  & | without maintaining corresponding Sales Organization'| ) ).
*        ENDIF.
*
*      ENDIF.
*    ENDLOOP.
*    data(lv_returncode) = VALUE NRRETURN( ).
*    IF ls_t134-numke IS NOT INITIAL.
*        CALL FUNCTION 'NUMBER_CHECK'
*          EXPORTING
*            nr_range_nr             = ls_t134-numke
*            number                  = gs_data-product
*            object                  = 'MATERIALNR'
*          IMPORTING
*            returncode              = lv_returncode
*          EXCEPTIONS
*            interval_not_found      = 01
*            number_range_not_extern = 02
*            object_not_found        = 03.
*        if  lv_returncode = 'X' and gs_data-division <> 'PK'
*        AND gs_data-producttype = 'ZFER'.
*          SELECT SINGLE *
*            FROM t134t
*           WHERE mtart = @gs_data-producttype
*             AND spras = @sy-langu
*            into @data(ls_t134t).
*          me->_add_message(
*              EXPORTING
*                msgty = 'E'
*                msgid = 'M3'
*                msgno = '318' ).
*        endif.
*    ENDIF.

    "15.11.2023 add by elsa - start
    IF gs_data-to_salesdelivery IS NOT INITIAL.

      SELECT vkorg,
             werks
        FROM tvkwz AS t1
       INNER JOIN @gs_data-to_salesdelivery AS t2
          ON t1~vkorg = t2~productsalesorg AND
             t1~vtweg = t2~productdistributionchnl
        INTO TABLE @DATA(lt_tvkwz).

      SELECT land1
        FROM t001w AS t1
       INNER JOIN @lt_tvkwz AS t2
          ON t1~werks = t2~werks
       INTO TABLE @DATA(lt_country).

      LOOP AT lt_country INTO DATA(ls_country).
        IF NOT line_exists( gs_data-to_productsalestax[ country = ls_country-land1 ] ).
          gt_message = VALUE #( BASE et_message (
                                  type = 'E'
                                  id   = 'MG'
                                  number = '172' ) ).
        ENDIF.
      ENDLOOP.
    ENDIF.

    SELECT t1~class AS class ,
           t1~klart AS klart ,
           t3~atnam AS atnam ,
           t3~atfor AS atfor ,
           t3~anzst AS mazst ,
           t3~anzdz AS mazdz ,
           t3~atdex AS atdex ,
           t3~atdim AS atdim ,
           t3~atvor AS mvorz ,
           t3~atsch AS mscha ,
           t3~msehi AS meinh ,
           t3~atint AS miwrt ,
           t3~atkle AS atkle ,
           t3~atein AS atein,
           t3~atson AS atson
      FROM klah AS t1
     INNER JOIN ksml AS t2
        ON t1~clint = t2~clint
     INNER JOIN cabn AS t3
        ON t2~imerk = t3~atinn
     INNER JOIN @lt_charc AS t4
        ON t1~class = t4~class
       AND t1~klart = t4~klart
       AND t3~atnam = t4~atnam
      INTO TABLE @gt_ausp.

    SELECT t1~class,
           t1~klart,
           t3~atnam,
           t5~atwrt,
           t3~atson
      FROM klah AS t1
     INNER JOIN ksml AS t2
        ON t1~clint = t2~clint
     INNER JOIN cabn AS t3
        ON t2~imerk = t3~atinn
     INNER JOIN @lt_charc AS t4
        ON t1~class = t4~class
       AND t1~klart = t4~klart
       AND t3~atnam = t4~atnam
     INNER JOIN cawn AS t5
        ON t3~atinn = t5~atinn
      INTO TABLE @DATA(lt_fix_value).

    SELECT t1~class,
           t1~klart,
           t1~atnam,
           t1~atein,
           COUNT( * ) AS count
      FROM @gt_ausp AS t1
     WHERE t1~atein = 'X'
     GROUP BY t1~class,
              t1~klart,
              t1~atnam,
              t1~atein
    HAVING COUNT( * ) > 1
      INTO TABLE @DATA(lt_count).



    LOOP AT lt_charc INTO DATA(ls_charac).
      IF line_exists( lt_count[ class = ls_charac-class
                                klart = ls_charac-klart
                                atnam = ls_charac-atnam ] ).
        gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = '000'
                                 message     = |{ ls_charac-atnam }: Multiple values assignment is not allowed| )  ).

      ENDIF.
      IF NOT line_exists( gt_ausp[ class = ls_charac-class
                                   klart = ls_charac-klart
                                   atnam = ls_charac-atnam ] ).
        gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = ''
                                 message     = |{ ls_charac-atnam }: Invalid Characteristic of Class Type| )  ).

      ELSE.
        IF ls_charac-value IS NOT INITIAL.
          IF line_exists( lt_fix_value[ class = ls_charac-class
                                            klart = ls_charac-klart
                                            atnam = ls_charac-atnam
                                            atson = '' ] ).

            IF NOT line_exists( lt_fix_value[ class = ls_charac-class
                                          klart = ls_charac-klart
                                          atnam = ls_charac-atnam
                                          atwrt = ls_charac-value
                                           ] ).
              gt_message = VALUE #( BASE gt_message
                             ( type        = 'E'
                               message     = |{ ls_charac-atnam }: invalid value inputted|

                                )  ).

            ENDIF.


          ELSE.
            DATA(lv_type_charc) = gt_ausp[ class = ls_charac-class
                                           klart = ls_charac-klart
                                           atnam = ls_charac-atnam ].
            DATA lt_strg TYPE STANDARD TABLE OF strg.
            IF lv_type_charc-atfor = 'CHAR'.
              DATA lv_value TYPE string.
              lv_value = ls_charac-value.
              CONDENSE lv_value.
              DATA(lv_length) = strlen( lv_value ).
              IF lv_length > lv_type_charc-mazst.
                gt_message = VALUE #( BASE gt_message
                               ( type        = 'E'
                                 id          = ''
                                 number      = ''
                                 message     = |{ ls_charac-atnam }: Value { ls_charac-value } is too long| )  ).
              ENDIF.
            ELSE.
              CALL FUNCTION 'CTCV_SYNTAX_CHECK'
                EXPORTING
                  attribut                  = lv_type_charc-atnam
                  baseunit                  = lv_type_charc-meinh
                  decimals                  = lv_type_charc-mazdz
                  dec_presentation          = ','
                  exponent                  = lv_type_charc-atdim
                  exponent_art              = lv_type_charc-atdex
                  format                    = lv_type_charc-atfor
                  interval                  = lv_type_charc-miwrt
                  language                  = sy-langu
                  length                    = lv_type_charc-mazst
                  lowercase                 = lv_type_charc-atein
                  mask                      = lv_type_charc-mscha
                  mask_allowed              = ' '
                  negativ                   = lv_type_charc-mvorz
*                 screen_name               = space
*                 single_selection          = space
                  string                    = ls_charac-value
*                 value_seperator           = ';'
                  classtype                 = lv_type_charc-klart
*                 t_separator               = ' '
*                 err_name                  =
*             IMPORTING
*                 string_is_masked          =
                TABLES
                  tstrg                     = lt_strg
                EXCEPTIONS
                  currency_check            = 1
                  date_check                = 2
                  format_check              = 3
                  illegal_internal_baseunit = 4
                  interval_check            = 5
                  pattern_check             = 6
                  time_check                = 7
                  unit_check                = 8
                  no_valid_dimension        = 9
                  interval_not_allowed      = 10
                  presentation_not_possible = 11
                  OTHERS                    = 12.
              IF sy-subrc <> 0.
                DATA lv_msg TYPE string.
                CALL FUNCTION 'FORMAT_MESSAGE'
                  EXPORTING
                    id        = sy-msgid
                    lang      = sy-langu
                    no        = sy-msgno
                    v1        = ls_charac-value
                    v2        = sy-msgv2
                    v3        = sy-msgv3
                    v4        = sy-msgv4
                  IMPORTING
                    msg       = lv_msg
                  EXCEPTIONS
                    not_found = 1
                    OTHERS    = 2.

                DATA(lv_msgty) = sy-msgty.
                IF sy-subrc = 0.
                  gt_message = VALUE #( BASE gt_message
                                ( type        = lv_msgty
                                  message     = |{ ls_charac-atnam }:{ lv_msg }| ) ).
                ENDIF.

              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.

      ENDIF.

    ENDLOOP.

    IF gt_message IS NOT INITIAL.
      DELETE ADJACENT DUPLICATES FROM gt_message COMPARING type id number message.
    ENDIF.

  ENDMETHOD.


  METHOD /simple/if_mdg_srv_provider~validate_delete.
    DATA(lv_exist) = _check_existence( iv_product = gs_data-product ).
    IF lv_exist = abap_false.
      me->_add_message(
        EXPORTING
          msgty = 'E'
          msgid = 'M3'
          msgno = '305'
          msgv1 = |{ gs_data-product }| ).
    ENDIF.
  ENDMETHOD.


  METHOD adjust_number.
    APPEND VALUE #( product = gv_product ) TO et_mapped.
  ENDMETHOD.


  METHOD create_appl_log.
    IF gv_external_log_no IS INITIAL.
      gv_external_log_no = gs_data-activateid && gs_data-activateitemid.
    ENDIF.

    gv_log_handle = /simple/cl_mdg_gw_core_dpc_ext=>create_appl_log(
      iv_extnumber = gv_external_log_no
      iv_object    = /simple/cl_mdg_gw_core_dpc_ext=>gc_log_obj
      iv_subobject = /simple/cl_mdg_gw_core_dpc_ext=>gc_log_product ).
  ENDMETHOD.


  METHOD execute_api_rfc.
    DATA:
      lt_error_message  TYPE cmd_bs_mat_t_mat_msg,
*      lt_valuation_comb TYPE /simple/prd_val_t,
      lt_valuation_comb TYPE gty_deep_data-to_valuation, "Bruce
      ls_valuation_comb TYPE /simple/prd_val_s,
      lt_return_msgs    TYPE STANDARD TABLE OF bapi_matreturn2,
      ls_return_msg     LIKE LINE OF lt_return_msgs,
      lt_message_mla    TYPE cmd_bs_mat_t_mat_msg.

    lt_valuation_comb = it_valuation.
    gs_mat      = is_mat.
    gv_testrun  = iv_test_mode.
    gt_qmat_ins = it_qmat_ins.
    gt_qmat_upd = it_qmat_upd.
    gt_qmat_del = it_qmat_del.
    gt_qmat_x   = it_qmat_x  .

    CALL METHOD me->_call_save_api
      EXPORTING
        is_data          = gs_mat
        iv_mrp_operation = iv_mrp_operation
        iv_test_mode     = gv_testrun
      IMPORTING
        et_message       = DATA(lt_message)
        et_matnr_map     = DATA(lt_int_mat_map).

    LOOP AT lt_message INTO DATA(ls_message) WHERE msgty CA 'EAX'.
      IF ls_message-msgv1 NS gc_matnr_tmp.
        IF ls_message-msgid = 'WE' AND ls_message-msgno = '112'.
          ls_message-msgno = '218'.
          TRY .
              ls_message-msgv1 = gs_mat-mara_tab[ 1 ]-ean11.
            CATCH cx_sy_itab_line_not_found.
          ENDTRY.
        ENDIF.
        INSERT ls_message INTO TABLE lt_error_message.
      ENDIF.
    ENDLOOP.

    SORT lt_error_message BY msgty msgid msgno msgv1 ASCENDING.
    DELETE ADJACENT DUPLICATES FROM lt_error_message COMPARING msgty msgid msgno msgv1.

    IF lt_error_message IS NOT INITIAL.

      _export_messages(
        EXPORTING
          it_messages = lt_error_message
        CHANGING
          ct_message  = gt_message ).
    ELSE.
      IF gs_mat-mbew_tab IS NOT INITIAL OR lt_valuation_comb IS NOT INITIAL.
        IF lt_int_mat_map IS NOT INITIAL.
          LOOP AT lt_valuation_comb ASSIGNING FIELD-SYMBOL(<ls_valuation_comb>).
            <ls_valuation_comb>-product = lt_int_mat_map[ 1 ]-matnr_int.
            LOOP AT <ls_valuation_comb>-to_mlaccount ASSIGNING FIELD-SYMBOL(<ls_mlaccount>).
              <ls_mlaccount>-product = lt_int_mat_map[ 1 ]-matnr_int.
            ENDLOOP.
            LOOP AT <ls_valuation_comb>-to_mlprices ASSIGNING FIELD-SYMBOL(<ls_mlprices>).
              <ls_mlprices>-product = lt_int_mat_map[ 1 ]-matnr_int.
            ENDLOOP.
          ENDLOOP.
        ELSE.
          LOOP AT lt_valuation_comb ASSIGNING <ls_valuation_comb>.
            <ls_valuation_comb>-product = gs_mat-mara_tab[ 1 ]-matnr.
            LOOP AT <ls_valuation_comb>-to_mlaccount ASSIGNING <ls_mlaccount>.
              <ls_mlaccount>-product = gs_mat-mara_tab[ 1 ]-matnr.
            ENDLOOP.
            LOOP AT <ls_valuation_comb>-to_mlprices ASSIGNING <ls_mlprices>.
              <ls_mlprices>-product = gs_mat-mara_tab[ 1 ]-matnr.
            ENDLOOP.
          ENDLOOP.
        ENDIF.
        DATA lv_flchange TYPE c LENGTH 1.
        IF gs_data-action = 'Change'.
          READ TABLE lt_valuation_comb INTO DATA(ls_valuation_comb1)
            WITH KEY action = 'Change'.
          IF sy-subrc <> 0.
            READ TABLE lt_valuation_comb INTO ls_valuation_comb1
             WITH KEY action = 'Insert'.
            IF sy-subrc <> 0.
              lv_flchange = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

*        LOOP AT lt_valuation_comb ASSIGNING FIELD-SYMBOL(<fs_val_data>).
**          CLEAR lv_flchange.
*          IF gs_data-action = '' OR gs_data-action = 'background'.
*            EXIT.
*          ENDIF.
*          IF <fs_val_data>-action = 'Change'.
*            IF <fs_val_data>-mdgmarkforchange IS INITIAL.
*              LOOP AT <fs_val_data>-to_mlaccount INTO DATA(ls_mlaccount).
*                IF ls_mlaccount-mdgmarkforchange IS INITIAL.
*                  lv_flchange = 'X'.
*                ENDIF.
*              ENDLOOP.
*            ENDIF.
*          ELSEIF <fs_val_data>-action = 'Insert'.
*            CLEAR lv_flchange.
*            EXIT.
*          ELSE.
**            lv_flchange = 'X'.
*          ENDIF.
*        ENDLOOP.
*        CHECK gs_data-action =
        CHECK lv_flchange IS INITIAL.
        IF to_upper( gs_data-action ) = space.



        ELSE.

        ENDIF.
        me->_adjust_val_ml_nodes(
          EXPORTING
            iv_after_mmd      = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
          CHANGING
            ct_valuation_data = lt_valuation_comb ).

        LOOP AT lt_valuation_comb ASSIGNING FIELD-SYMBOL(<fs_valuation>).
          DELETE <fs_valuation>-to_mlaccount WHERE product IS INITIAL.
        ENDLOOP.

        me->_do_mapping_ml(
          EXPORTING
            iv_mrp_operation  = iv_mrp_operation
          CHANGING
            ct_valuation_data = lt_valuation_comb
            cs_data           = gs_mat
        ).

        DATA:
          lt_message_ml TYPE cmd_bs_mat_t_mat_msg.
        me->check_ml_data(
          EXPORTING
            it_valuation = it_valuation
            it_ckmlhd    = gs_mat-ckmlhd_tab
            it_ckmlcr    = gs_mat-ckmlcr_tab
            it_ckmlpr    = gs_mat-ckmlpr_tab
          IMPORTING
            et_message   = lt_message_ml
        ).
        LOOP AT lt_message_ml INTO ls_message WHERE msgty CA 'EAX'.
          INSERT ls_message INTO TABLE lt_error_message.
        ENDLOOP.


        CLEAR: lt_error_message.
        IF gs_mat-ckmlhd_tab IS NOT INITIAL OR gs_mat-ckmlcr_tab IS NOT INITIAL OR gs_mat-ckmlpr_tab IS NOT INITIAL.
          me->_call_mla_api(
            EXPORTING
              is_data      = gs_mat                  " MDG BS MAT: Material Master Data Structure
              it_matnr_map = lt_int_mat_map          " MDG BS MAT: Material No TMP to Internal Mapping Table
              iv_test_mode = gv_testrun
            IMPORTING
              et_message   = lt_message_mla          " MDG BS MAT: Material Error Message Table
          ).

          LOOP AT lt_message_mla INTO ls_message WHERE msgty CA 'EAX'.
            INSERT ls_message INTO TABLE lt_error_message.
          ENDLOOP.
        ENDIF.

        IF lt_error_message IS NOT INITIAL.
          _export_messages(
            EXPORTING
              it_messages = lt_error_message
            CHANGING
              ct_message  = gt_message ).
        ENDIF.
      ENDIF.
*     trigger revision level update
      me->_execute_revision_level( ).
    ENDIF.

    et_message = gt_message.

    READ TABLE lt_message INTO ls_return_msg WITH KEY msgty = 'S' msgid = 'M3'.
    IF sy-subrc = 0.
      IF gs_data-product IS INITIAL.
        READ TABLE lt_int_mat_map INTO DATA(product_num) INDEX 1.
        gv_product = product_num-matnr_int.
      ENDIF.
    ENDIF.

    IF gv_product IS INITIAL.
      TRY .
          gv_product = gs_mat-mara_tab[ 1 ]-matnr.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ENDIF.

    ev_product = gv_product.

  ENDMETHOD.


  METHOD execute_price_change.
    DATA:
      ls_key        TYPE /simple/prd_service_provider=>gty_prd_key_log,
      lv_log        TYPE /simple/api_log,
      lv_log_handle TYPE balloghndl,

      lt_valuation  TYPE GTY_VALUATION_TAB.


    lt_valuation = CORRESPONDING #( DEEP it_valuatuon ).
    DELETE lt_valuation WHERE pricechange = abap_false.
    LOOP AT lt_valuation ASSIGNING FIELD-SYMBOL(<fs_valuation>).
      DATA(lv_flag_d) = ''.
      LOOP AT <fs_valuation>-to_mlaccount INTO DATA(ls_mlaccount).
        IF ls_mlaccount-mdgmarkforchange IS NOT INITIAL.
          lv_flag_d = 'X'.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF lv_flag_d IS INITIAL.
        <fs_valuation>-pricechange = abap_false.
      ENDIF.
    ENDLOOP.
    DELETE lt_valuation WHERE pricechange = abap_false.
    me->_validate_price_change( it_valuation = lt_valuation ).
    et_message = gt_message.
    IF et_message IS INITIAL.
      me->_process_change_price( EXPORTING
                                    iv_actionmode = iv_actionmode
                                    it_valuation  = lt_valuation
                                 IMPORTING et_return = et_message ).
    ENDIF.
  ENDMETHOD.


  METHOD get_action.
    ev_action = gs_data-action.
  ENDMETHOD.


  METHOD get_action_mode.
    ev_action_mode = gs_data-actionmode.
  ENDMETHOD.


  METHOD get_instance.
    IF go_object IS INITIAL.
      go_object = NEW #( ).
    ENDIF.
    ro_object = go_object.
  ENDMETHOD.


  METHOD get_object_key.
    ev_cid = gs_data-cid.
    ev_product = gv_product.
    IF to_upper( gs_data-actionmode ) = 'BACKGROUND' OR to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION'.
      ev_background = 'X'.
    ENDIF.
  ENDMETHOD.


  METHOD get_raw_data.
    TRY.
        rv_raw_data = /simple/cl_json_utility=>convert_stuct_to_json(
          EXPORTING
            im_s_data = gs_data
            im_v_case = /simple/cl_json_utility=>co_ftype_camelcase ).
      CATCH /simple/cx_json_conversion_err.
    ENDTRY.
  ENDMETHOD.


  METHOD map_fields.
    DATA:
      lo_type_descr  TYPE REF TO cl_abap_typedescr,
      lo_tabl_descr  TYPE REF TO cl_abap_tabledescr,
      lo_stru_descr  TYPE REF TO cl_abap_structdescr,
      lt_fields      TYPE abap_compdescr_tab,
      lv_tab_field   TYPE string,
      lv_trimmed     TYPE string,
      lv_struct_name TYPE ddobjname,
      gt_fields      TYPE SORTED TABLE OF dfies WITH UNIQUE KEY primary_key COMPONENTS tabname fieldname.

    FIELD-SYMBOLS: <fs_output>   TYPE any,
                   <fs_output_x> TYPE any.
    FIELD-SYMBOLS : <fs_tab>   TYPE any,<fs_bopf> TYPE any, <fs_tab_x> TYPE any.

    ASSIGN ev_output_stru   TO <fs_output>.
    ASSIGN ev_output_stru_x TO <fs_output_x>.

    lo_type_descr = cl_abap_typedescr=>describe_by_data( iv_input_stru ).

    IF lo_type_descr->type_kind = cl_abap_typedescr=>typekind_table.
      lo_tabl_descr ?= lo_type_descr.
      lo_stru_descr ?= lo_tabl_descr->get_table_line_type( ).
    ELSEIF lo_type_descr->kind = cl_abap_structdescr=>kind_struct.
      lo_stru_descr ?= lo_type_descr.
    ELSE.
      ASSERT 1 = 2. "not a table or struct?
    ENDIF.

    lt_fields = lo_stru_descr->components.

    LOOP AT lt_fields ASSIGNING FIELD-SYMBOL(<fs_column>).
      UNASSIGN : <fs_tab>,<fs_bopf>,<fs_tab_x>.
      CLEAR lv_tab_field.
      IF <fs_column>-name EQ 'MANDT' OR <fs_column>-name CP 'TO_*'.
        CONTINUE.
      ENDIF.

      CALL METHOD me->_map_field_names
        EXPORTING
          iv_node_name = iv_entity_name
          iv_fieldname = <fs_column>-name
        IMPORTING
          ev_field     = lv_tab_field.

      IF lv_tab_field IS  NOT INITIAL.
        ASSIGN COMPONENT lv_tab_field OF STRUCTURE <fs_output> TO <fs_tab>.
        ASSIGN COMPONENT <fs_column>-name OF STRUCTURE iv_input_stru TO <fs_bopf>.
        IF <fs_tab> IS ASSIGNED AND <fs_bopf> IS ASSIGNED.
          IF <fs_tab> IS INITIAL.
            <fs_tab> = <fs_bopf>.
          ENDIF.
        ENDIF.

        IF <fs_output_x> IS ASSIGNED.
          ASSIGN COMPONENT lv_tab_field OF STRUCTURE <fs_output_x> TO <fs_tab_x>.
          IF sy-subrc = 0.
            <fs_tab_x> = abap_true.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD set_data.
    IF is_data IS NOT INITIAL.
      gs_data = is_data.
    ENDIF.

    IF gv_raw_data IS INITIAL.
      gv_raw_data = /ui2/cl_json=>serialize( data        = gs_data
                                             compress    = abap_false
                                             pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).
    ENDIF.

  ENDMETHOD.


  METHOD update_log_table.
    IF gs_log IS INITIAL.
      gs_log-activate_id      = gs_data-activateid.
      gs_log-activate_item_id = gs_data-activateitemid.
      gs_log-mdglogid         = gs_data-mdglogid.
      gs_log-cr_number        = gs_log-activate_id.
      gs_log-cr_item          = gs_log-activate_item_id.
      gs_log-obj_type         = /simple/cl_mdg_gw_core_dpc_ext=>gc_log_product.

      gs_log-mdg_key = gs_data-product.
    ENDIF.

    gs_log-status = iv_status.
    gs_log-step   = iv_step.

    IF iv_save IS NOT INITIAL.
      LOOP AT gt_message INTO DATA(ls_msg).
        IF ls_msg-type CA 'EAX'.
          MESSAGE ID ls_msg-id TYPE ls_msg-type NUMBER ls_msg-number
          WITH ls_msg-message_v1 ls_msg-message_v2 ls_msg-message_v3 ls_msg-message_v4
          INTO DATA(lv_msg).

          IF gs_log-message_log IS INITIAL.
            gs_log-message_log = condense( lv_msg ).
          ELSE.
            gs_log-message_log = gs_log-message_log && |,| && condense( lv_msg ).
          ENDIF.
        ENDIF.


        IF gv_log_handle IS NOT INITIAL.
          /simple/cl_mdg_gw_core_dpc_ext=>add_message_to_log(
            iv_log_handle = gv_log_handle
            is_message    = VALUE bal_s_msg(
                                        msgty = ls_msg-type
                                        msgid = ls_msg-id
                                        msgno = ls_msg-number
                                        msgv1 = ls_msg-message_v1
                                        msgv2 = ls_msg-message_v2
                                        msgv3 = ls_msg-message_v3
                                        msgv4 = ls_msg-message_v4 )
          ).
        ENDIF.
      ENDLOOP.
      _save_log( ).
    ENDIF.
  ENDMETHOD.


  METHOD _add_message.
    gt_message = VALUE #( BASE gt_message (
                                type       = msgty
                                id         = msgid
                                number     = msgno
                                message_v1 = msgv1
                                message_v2 = msgv2
                                message_v3 = msgv3
                                message_v4 = msgv4
    ) ).
  ENDMETHOD.


  METHOD _adjust_val_ml_nodes.

    DATA:
      ls_val_keys          TYPE /simple/val_key_s,
      lt_val_keys          TYPE /simple/val_key_t,
      lt_pre04             TYPE TABLE OF pre04,
      lt_mbew_md           TYPE TABLE OF v_mbew_md,
      lv_local_price       TYPE ck_stprs_1,
      lv_mlacc_emtpy       TYPE boole_d,
      lv_mlpr_emtpy        TYPE boole_d,
      ls_ml_account        TYPE /simple/c_productmlaccount, "/simple/cprdmla,
      ls_ml_prices         TYPE /simple/c_productmlprices, "/simple/cprdmlp,
      ls_product_valuation TYPE /simple/c_productvaluation, "/simple/cprdv,
      lv_flchange          TYPE char1.


    LOOP AT ct_valuation_data ASSIGNING FIELD-SYMBOL(<fs_val_data>).
*      CLEAR lv_flchange.
*      IF gs_data-action = 'Change'.
*        IF <fs_val_data>-mdgmarkforchange IS INITIAL.
*          LOOP AT <fs_val_data>-to_mlaccount INTO DATA(ls_mlaccount).
*            IF ls_mlaccount-mdgmarkforchange IS INITIAL.
*              lv_flchange = 'X'.
*            ENDIF.
*          ENDLOOP.
*        ENDIF.
*      ENDIF.
*      IF lv_flchange = 'X'.
*        CONTINUE.
*      ENDIF.
      CLEAR ls_val_keys.
      MOVE-CORRESPONDING <fs_val_data> TO ls_val_keys.
      IF ls_val_keys IS NOT INITIAL.
        APPEND  ls_val_keys TO  lt_val_keys.
      ENDIF.
      CLEAR ls_val_keys.
      MOVE-CORRESPONDING <fs_val_data>-to_valuationaccount TO ls_val_keys.
      IF ls_val_keys IS NOT INITIAL.
        APPEND  ls_val_keys TO  lt_val_keys.
      ENDIF.
      MOVE-CORRESPONDING <fs_val_data>-to_mlaccount TO lt_val_keys KEEPING TARGET LINES.
      MOVE-CORRESPONDING <fs_val_data>-to_mlprices TO lt_val_keys KEEPING TARGET LINES.
    ENDLOOP.

    DELETE lt_val_keys WHERE product IS INITIAL AND valuationarea IS INITIAL AND valuationtype IS INITIAL.

    SORT lt_val_keys BY product valuationarea valuationtype.
    DELETE ADJACENT DUPLICATES FROM lt_val_keys.

    CHECK lt_val_keys IS NOT INITIAL.

    mt_val_keys = lt_val_keys.

    SELECT * FROM fmlv_ckmlct INTO TABLE @DATA(lt_ckmlct)
      FOR ALL ENTRIES IN @lt_val_keys
      WHERE bwkey = @lt_val_keys-valuationarea.
*      SORT lt_ckmlct BY bwkey curtp.
*      DELETE ADJACENT DUPLICATES FROM lt_ckmlct.

    SELECT * FROM mbew INTO TABLE @DATA(lt_mbew_db)
      FOR ALL ENTRIES IN @lt_val_keys
      WHERE matnr = @lt_val_keys-product
        AND bwkey = @lt_val_keys-valuationarea
        AND bwtar = @lt_val_keys-valuationtype.
    IF lt_mbew_db IS NOT INITIAL.
      SELECT * FROM ckmlcr INTO TABLE @DATA(lt_ckmlcr_db) FOR ALL ENTRIES IN @lt_mbew_db WHERE kalnr = @lt_mbew_db-kaln1.
      SELECT * FROM ckmlpr INTO TABLE @DATA(lt_ckmlpr_db) FOR ALL ENTRIES IN @lt_mbew_db WHERE kalnr = @lt_mbew_db-kaln1.
      SORT lt_ckmlcr_db  BY kalnr untper curtp bdatj DESCENDING poper DESCENDING.
      DELETE ADJACENT DUPLICATES FROM lt_ckmlcr_db COMPARING kalnr untper curtp.
    ENDIF.

    lt_pre04 = lt_val_keys.
    CALL FUNCTION 'MBEW_MD_ARRAY_READ'  "Check for internal number
      TABLES
        ipre04               = lt_pre04
        mbew_tab_md          = lt_mbew_md
      EXCEPTIONS
        enqueue_mode_changed = 1
        lock_on_mbew         = 2
        lock_system_error    = 3
        OTHERS               = 4.
    IF sy-subrc <> 0.
      " Todo-> raise exception
    ENDIF.

    LOOP AT lt_val_keys ASSIGNING FIELD-SYMBOL(<fs_val_keys>).
      READ TABLE ct_valuation_data ASSIGNING <fs_val_data>
                           WITH KEY product = <fs_val_keys>-product
                                    valuationarea = <fs_val_keys>-valuationarea
                                    valuationtype = <fs_val_keys>-valuationtype .

      CHECK <fs_val_data> IS ASSIGNED.

      READ TABLE <fs_val_data>-to_mlaccount WITH KEY currencyrole = '10' INTO DATA(ls_ml_acct_cco).
      IF sy-subrc <> 0.
        CLEAR ls_ml_acct_cco.
      ENDIF.
      READ TABLE <fs_val_data>-to_mlprices WITH KEY currencyrole = '10' INTO DATA(ls_ml_pr_cco).
      IF sy-subrc <> 0.
        CLEAR ls_ml_pr_cco.
      ENDIF.

      lv_mlacc_emtpy = abap_false. lv_mlpr_emtpy = abap_false.
      IF <fs_val_data>-to_mlaccount IS INITIAL.
        lv_mlacc_emtpy = abap_true.
      ENDIF.
      IF <fs_val_data>-to_mlprices IS INITIAL.
        lv_mlpr_emtpy = abap_true.
      ENDIF.

      IF iv_after_mmd = abap_true.
        IF ls_ml_acct_cco IS NOT INITIAL." AND ls_prd_val IS NOT INITIAL.
          IF <fs_val_data>-inventoryvaluationprocedure <> ls_ml_acct_cco-productpricecontrol
            OR <fs_val_data>-priceunitqty <> ls_ml_acct_cco-priceunitqty
            OR <fs_val_data>-standardprice <> ls_ml_acct_cco-standardprice
            OR <fs_val_data>-movingaverageprice <> ls_ml_acct_cco-movingaverageprice .
            "Data passed inconsistently
            _add_message(
              EXPORTING
                msgty = 'E'
                msgid = 'PMD_MSG'
                msgno = '017'
                msgv1 = CONV sy-msgv1( <fs_val_keys>-product )
                msgv2 = CONV sy-msgv2( <fs_val_keys>-valuationarea )
                msgv3 = CONV sy-msgv3( <fs_val_keys>-valuationtype )
            ).
          ENDIF.
        ENDIF.
        IF ls_ml_pr_cco IS NOT INITIAL AND <fs_val_data>-to_valuationaccount IS NOT INITIAL.
          IF ls_ml_pr_cco-futureprice <> <fs_val_data>-to_valuationaccount-futureevaluatedamountvalue
            OR ls_ml_pr_cco-futurepricevaliditystartdate <> <fs_val_data>-to_valuationaccount-futurepricevaliditystartdate
            OR ls_ml_pr_cco-plannedprice <> <fs_val_data>-plannedprice. "CHECK
            "Data passed inconsistently
            _add_message(
              EXPORTING
                msgty = 'E'
                msgid = 'PMD_MSG'
                msgno = '017'
                msgv1 = CONV sy-msgv1( <fs_val_keys>-product )
                msgv2 = CONV sy-msgv2( <fs_val_keys>-valuationarea )
                msgv3 = CONV sy-msgv3( <fs_val_keys>-valuationtype )
            ).
          ENDIF.
        ENDIF.

        READ TABLE lt_mbew_db INTO DATA(ls_mbew_db) WITH KEY matnr = <fs_val_keys>-product
                                                             bwkey = <fs_val_keys>-valuationarea
                                                             bwtar = <fs_val_keys>-valuationtype. "DB data
        IF sy-subrc <> 0.
          DATA(lv_create) = abap_true.
          CLEAR ls_mbew_db.
        ENDIF.

        READ TABLE lt_mbew_md INTO DATA(ls_mbew_md)
          WITH KEY matnr = <fs_val_keys>-product
                   bwkey = <fs_val_keys>-valuationarea
                   bwtar = <fs_val_keys>-valuationtype. "Buffer data

        READ TABLE lt_ckmlct INTO DATA(ls_currency_cco) WITH KEY bwkey = <fs_val_keys>-valuationarea
                                                                 curtp = '10'.

        LOOP AT lt_ckmlct INTO DATA(ls_currency) WHERE bwkey = <fs_val_keys>-valuationarea.

          READ TABLE lt_ckmlcr_db INTO DATA(ls_ckmlcr_db)
            WITH KEY kalnr = ls_mbew_db-kaln1
                     curtp = ls_currency-curtp.
          IF sy-subrc <> 0.
            CLEAR ls_ckmlcr_db.
          ENDIF.
          READ TABLE <fs_val_data>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_to_mlacc>)
            WITH KEY valuationarea = ls_currency-bwkey
                     currencyrole  = ls_currency-curtp.
          IF sy-subrc <> 0. "ML_Account not filled
            IF lv_create = abap_true .
              CLEAR ls_ml_account.
              ls_ml_account =
                CORRESPONDING #(
                  ls_mbew_md MAPPING product    = matnr
                                  valuationarea    = bwkey
                                  valuationtype = bwtar
                                  productpricecontrol = vprsv
                                  priceunitqty = peinh
                                  standardprice = stprs
                                  movingaverageprice = verpr
                                  ).
              IF  ls_ml_account IS NOT INITIAL.
                ls_ml_account-currencyrole =  ls_currency-curtp.
              ENDIF.
              IF ls_currency-curtp <> '10'. " price conversion for non-company code currency

                IF <fs_val_data>-standardprice <> 0 AND <fs_val_data>-standardprice IS NOT INITIAL. "could be changed to ls_mbew_md
                  CLEAR lv_local_price.
                  CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
                    EXPORTING
                      date             = sy-datum
                      foreign_amount   = ls_mbew_md-stprs "ls_prd_val-standardprice
                      foreign_currency = ls_currency_cco-waers
                      local_currency   = ls_currency-waers
                    IMPORTING
                      local_amount     = lv_local_price
                    EXCEPTIONS
                      no_rate_found    = 1
                      overflow         = 2.
                  .
                  IF sy-subrc = 0.
                    ls_ml_account-standardprice = lv_local_price. " converted price
                  ELSE.
                    _add_message(
                      EXPORTING
                        msgty = sy-msgty
                        msgid = sy-msgid
                        msgno = sy-msgno
                        msgv1 = sy-msgv1
                        msgv2 = sy-msgv2
                        msgv3 = sy-msgv3
                        msgv4 = sy-msgv4
                    ).
                  ENDIF.
                ENDIF.
                IF <fs_val_data>-movingaverageprice <> 0 AND <fs_val_data>-movingaverageprice IS NOT INITIAL. "could be changed to ls_mbew_md
                  CLEAR lv_local_price.
                  CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
                    EXPORTING
                      date             = sy-datum
                      foreign_amount   = ls_mbew_md-verpr
                      foreign_currency = ls_currency_cco-waers
                      local_currency   = ls_currency-waers
                    IMPORTING
                      local_amount     = lv_local_price
                    EXCEPTIONS
                      no_rate_found    = 1
                      overflow         = 2.
                  .
                  IF sy-subrc = 0.
                    ls_ml_account-movingaverageprice = lv_local_price. " converted price
                  ELSE.
                    _add_message(
                      EXPORTING
                        msgty = sy-msgty
                        msgid = sy-msgid
                        msgno = sy-msgno
                        msgv1 = sy-msgv1
                        msgv2 = sy-msgv2
                        msgv3 = sy-msgv3
                        msgv4 = sy-msgv4
                    ).
                  ENDIF.
                ENDIF.
              ENDIF.

            ELSE .
              CLEAR ls_ml_account.

              IF <fs_val_data>-valuationarea IS NOT INITIAL AND ls_currency-curtp = '10'.
                ls_ml_account =
                  CORRESPONDING #(
                    ls_mbew_md MAPPING product    = matnr
                                    valuationarea    = bwkey
                                    valuationtype = bwtar
                                    productpricecontrol = vprsv
                                    priceunitqty = peinh
                                    standardprice = stprs
                                    movingaverageprice = verpr
                                    ).


              ELSEIF <fs_val_data>-valuationarea IS NOT INITIAL OR lv_mlacc_emtpy = abap_false.
                ls_ml_account =
                                      CORRESPONDING #(
                                        ls_ckmlcr_db MAPPING "product    = matnr
                                                        "valuationarea    = bwkey
                                                        "valuationtype = bwtar
                                                        productpricecontrol = vprsv
                                                        priceunitqty = peinh
                                                        standardprice = stprs
                                                        movingaverageprice = pvprs
                                                        ).
                IF ls_ml_account IS NOT INITIAL.
                  ls_ml_account-product = <fs_val_keys>-product.
                  ls_ml_account-valuationarea = <fs_val_keys>-valuationarea.
                  ls_ml_account-valuationtype = <fs_val_keys>-valuationtype.
                ENDIF.
              ENDIF.
              IF ls_ml_account IS NOT INITIAL.
                ls_ml_account-currencyrole =  ls_currency-curtp.
              ENDIF.
            ENDIF.
            IF ls_ml_account IS NOT INITIAL.
              INSERT ls_ml_account INTO TABLE <fs_val_data>-to_mlaccount.
            ENDIF.
          ELSE. "ml_account is passed, however MMD handles the data differently from ML API
            IF ls_mbew_md IS NOT INITIAL AND ls_currency-curtp = '10'.
              CLEAR ls_ml_account.
              ls_ml_account =
                CORRESPONDING #(
                  ls_mbew_md MAPPING product    = matnr
                                  valuationarea    = bwkey
                                  valuationtype = bwtar
                                  productpricecontrol = vprsv
                                  priceunitqty = peinh
                                  standardprice = stprs
                                  movingaverageprice = verpr
                                  ).
              IF ls_ml_account IS NOT INITIAL.
                ls_ml_account-currencyrole = ls_currency-curtp.
                MOVE-CORRESPONDING ls_ml_account TO <fs_to_mlacc>.
              ENDIF.
            ELSEIF ls_currency-curtp = '30'.
              IF ls_ckmlcr_db IS NOT INITIAL.
                <fs_to_mlacc>-movingaverageprice  = ls_ckmlcr_db-pvprs.
                <fs_to_mlacc>-standardprice       = ls_ckmlcr_db-stprs.
              ENDIF.

            ENDIF.
          ENDIF.


          READ TABLE lt_ckmlpr_db INTO DATA(ls_ckmlpr_db) WITH KEY kalnr = ls_mbew_db-kaln1 curtp = ls_currency-curtp.
          READ TABLE <fs_val_data>-to_mlprices WITH KEY valuationarea = ls_currency-bwkey
                                                                   currencyrole = ls_currency-curtp TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.

            IF lv_create = abap_true .
              "auto-create CCo currency
              CLEAR ls_ml_prices.
              ls_ml_prices =
                CORRESPONDING #(
                  ls_mbew_md MAPPING product    = matnr
                                  valuationarea    = bwkey
                                  valuationtype = bwtar
                                  futureprice = zkprs
                                  futurepricevaliditystartdate = zkdat
                                  plannedprice = zplpr
*                                  priceunitqty = peinh "CHECK
                                  ).
              IF ls_ml_prices IS NOT INITIAL.
                ls_ml_prices-currencyrole = ls_currency-curtp.
              ENDIF.


              IF ls_currency-curtp <> '10'. " price conversion for non-company code currency
                IF <fs_val_data>-to_valuationaccount-futureevaluatedamountvalue <> 0 AND <fs_val_data>-to_valuationaccount-futureevaluatedamountvalue IS NOT INITIAL. "could be changed to ls_mbew_md
                  CLEAR lv_local_price.
                  CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
                    EXPORTING
                      date             = sy-datum
                      foreign_amount   = ls_mbew_md-zkprs
                      foreign_currency = ls_currency_cco-waers
                      local_currency   = ls_currency-waers
                    IMPORTING
                      local_amount     = lv_local_price
                    EXCEPTIONS
                      no_rate_found    = 1
                      overflow         = 2.
                  .
                  IF sy-subrc = 0.
                    ls_ml_prices-futureprice = lv_local_price. " converted price
                  ELSE.
                    _add_message(
                      EXPORTING
                        msgty = sy-msgty
                        msgid = sy-msgid
                        msgno = sy-msgno
                        msgv1 = sy-msgv1
                        msgv2 = sy-msgv2
                        msgv3 = sy-msgv3
                        msgv4 = sy-msgv4
                    ).
                  ENDIF.
                ENDIF.
                IF  <fs_val_data>-plannedprice <> 0 AND  <fs_val_data>-plannedprice IS NOT INITIAL.  "CHECK, "could be changed to ls_mbew_md
                  CLEAR lv_local_price.
                  CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
                    EXPORTING
                      date             = sy-datum
                      foreign_amount   = <fs_val_data>-plannedprice
                      foreign_currency = ls_currency_cco-waers
                      local_currency   = ls_currency-waers
                    IMPORTING
                      local_amount     = lv_local_price
                    EXCEPTIONS
                      no_rate_found    = 1
                      overflow         = 2.

                  IF sy-subrc = 0.
                    ls_ml_prices-plannedprice = lv_local_price. " converted price
                  ELSE.
                    _add_message(
                      EXPORTING
                        msgty = sy-msgty
                        msgid = sy-msgid
                        msgno = sy-msgno
                        msgv1 = sy-msgv1
                        msgv2 = sy-msgv2
                        msgv3 = sy-msgv3
                        msgv4 = sy-msgv4
                    ).
                  ENDIF.
                ENDIF.
              ENDIF.
            ELSE.
              IF <fs_val_data>-to_valuationaccount IS NOT INITIAL AND ls_currency-curtp = '10'.
                ls_ml_prices =
                  CORRESPONDING #(
                    ls_mbew_md MAPPING product    = matnr
                                    valuationarea    = bwkey
                                    valuationtype = bwtar
                                      futureprice = zkprs
                                      futurepricevaliditystartdate = zkdat
                                      plannedprice = zplpr
*                                      priceunitqty = peinh "CHECK
                                    ).
                IF ls_ml_prices IS NOT INITIAL.
                  ls_ml_prices-currencyrole = ls_currency-curtp.
                ENDIF.

              ELSEIF <fs_val_data>-to_valuationaccount IS NOT INITIAL OR lv_mlpr_emtpy = abap_false.
*              "Create from DB.
                ls_ml_prices =
                    CORRESPONDING #(
                      ls_ckmlpr_db MAPPING "product    = matnr
*                                    valuationarea    = bwkey
*                                    valuationtype = bwtar
                                      futureprice = zkprs
                                      futurepricevaliditystartdate = zprsdat
                                      plannedprice = zplpr
*                                      priceunitqty = peinh "CHECK
                                      ).
                IF ls_ml_prices IS NOT INITIAL.
                  ls_ml_prices-product = <fs_val_keys>-product.
                  ls_ml_prices-valuationarea = <fs_val_keys>-valuationarea.
                  ls_ml_prices-valuationtype = <fs_val_keys>-valuationtype.
                  ls_ml_prices-currencyrole = ls_currency-curtp.
                ENDIF.
              ENDIF.
            ENDIF.
            IF ls_ml_prices IS NOT INITIAL.
              INSERT ls_ml_prices INTO TABLE <fs_val_data>-to_mlprices.
            ENDIF.
          ENDIF.
          CLEAR ls_ckmlcr_db.
        ENDLOOP.

        IF <fs_val_data> IS ASSIGNED.
          DELETE <fs_val_data>-to_mlaccount WHERE currencyrole IS INITIAL.
          DELETE <fs_val_data>-to_mlprices WHERE currencyrole IS INITIAL.
        ENDIF.

*       recalculate price
        READ TABLE lt_mbew_db INTO DATA(ls_mbew_check) WITH KEY matnr = <fs_val_keys>-product
                                                            bwkey = <fs_val_keys>-valuationarea
                                                            bwtar = <fs_val_keys>-valuationtype. "DB data
        IF sy-subrc = 0.
          LOOP AT <fs_val_data>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_to_mlacc_adj>).
            CHECK <fs_to_mlacc_adj> IS ASSIGNED.
            READ TABLE lt_ckmlcr_db INTO DATA(ls_ckmlcr_check)
              WITH KEY kalnr = ls_mbew_check-kaln1
                       curtp = <fs_to_mlacc_adj>-currencyrole.
            IF sy-subrc = 0.
              IF ls_ckmlcr_check-peinh <> <fs_to_mlacc_adj>-priceunitqty.
                IF ls_ckmlcr_check-vprsv = 'V'.
*                  IF ls_ckmlcr_check-pvprs = <fs_to_mlacc_adj>-movingaverageprice.
                  IF ls_ckmlcr_check-salk3 <> 0 AND ls_mbew_check-lbkum <> 0.
                    ls_ckmlcr_check-pvprs = ls_ckmlcr_check-salk3 / ls_mbew_check-lbkum *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ELSE.
                    ls_ckmlcr_check-pvprs = ls_ckmlcr_check-pvprs /
                                         ls_ckmlcr_check-peinh *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ENDIF.
                  <fs_to_mlacc_adj>-movingaverageprice = ls_ckmlcr_check-pvprs.
*                  ENDIF.
*                  IF ls_ckmlcr_check-stprs = <fs_to_mlacc_adj>-standardprice.
                  ls_ckmlcr_check-stprs = ls_ckmlcr_check-stprs / ls_ckmlcr_check-peinh
                                               * <fs_to_mlacc_adj>-priceunitqty.
                  <fs_to_mlacc_adj>-standardprice = ls_ckmlcr_check-stprs.
*                  ENDIF.
                ELSE.
*                  IF ls_ckmlcr_check-stprs = <fs_to_mlacc_adj>-standardprice.
                  IF ls_ckmlcr_check-salk3 <> 0 AND ls_mbew_check-lbkum <> 0.
                    ls_ckmlcr_check-stprs = ls_ckmlcr_check-salk3 / ls_mbew_check-lbkum *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ELSE.
                    ls_ckmlcr_check-stprs = ls_ckmlcr_check-stprs /
                                         ls_ckmlcr_check-peinh *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ENDIF.
                  <fs_to_mlacc_adj>-standardprice = ls_ckmlcr_check-stprs.
*                  ENDIF.
*                  IF ls_ckmlcr_check-pvprs = <fs_to_mlacc_adj>-movingaverageprice.
                  IF ls_ckmlcr_check-salkv <> 0 AND ls_mbew_check-lbkum <> 0.
                    ls_ckmlcr_check-pvprs = ls_ckmlcr_check-salkv / ls_mbew_check-lbkum *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ELSE.
                    ls_ckmlcr_check-pvprs = ls_ckmlcr_check-pvprs /
                                         ls_ckmlcr_check-peinh *
                                         <fs_to_mlacc_adj>-priceunitqty.
                  ENDIF.
                  <fs_to_mlacc_adj>-movingaverageprice = ls_ckmlcr_check-pvprs.
*                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.

      ELSE.
*        ****     Fill Val nodes
        IF <fs_val_data>-valuationarea IS INITIAL AND ls_ml_acct_cco IS NOT INITIAL.
          "create/update val
          ls_product_valuation-plannedprice = ls_ml_pr_cco-plannedprice.
          ls_product_valuation = CORRESPONDING #( ls_ml_acct_cco MAPPING inventoryvaluationprocedure = productpricecontrol ) .
          MOVE-CORRESPONDING ls_product_valuation TO <fs_val_data>.
        ENDIF.

        IF <fs_val_data>-to_valuationaccount IS INITIAL AND ls_ml_pr_cco IS NOT INITIAL.
          "create/update val_acct
          <fs_val_data>-to_valuationaccount =
          CORRESPONDING #( ls_ml_pr_cco MAPPING futureevaluatedamountvalue = futureprice ).
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD _call_mdma_api.
    DATA:
      lt_message  TYPE cmd_bs_mat_t_mat_msg,
      lt_mdma_tab TYPE mdma_tab.

    DATA(lt_mdma) = it_mdma.
    DATA(lt_mdma_x) = it_mdma_x.

    DATA(lr_cmd_mdma_api) = cl_cmd_bs_mat_mdma_api=>get_instance( ).

    CLEAR et_message.

    IF iv_operation EQ 'I'.
      CLEAR lt_message.
      lr_cmd_mdma_api->check_insert(
        EXPORTING
          it_mdma    = lt_mdma
          it_mdma_x  = lt_mdma_x
        IMPORTING
          et_message = lt_message
      ).
      IF lt_message IS NOT INITIAL.
        INSERT LINES OF lt_message INTO TABLE et_message.
        LOOP AT lt_message ASSIGNING FIELD-SYMBOL(<ls_message>) WHERE msgty CA 'EAX'.EXIT.ENDLOOP.
        IF <ls_message> IS ASSIGNED.
          RETURN.
        ENDIF.
      ENDIF.

*check data ( update )
    ELSEIF iv_operation EQ 'U'.
      CLEAR lt_message.
      lr_cmd_mdma_api->check_update(
        EXPORTING
          it_mdma    = lt_mdma
          it_mdma_x  = lt_mdma_x
        IMPORTING
          et_message = lt_message
      ).
      IF lt_message IS NOT INITIAL.
        INSERT LINES OF lt_message INTO TABLE et_message.
        LOOP AT lt_message ASSIGNING FIELD-SYMBOL(<ls_message1>) WHERE msgty CA 'EAX'.EXIT.ENDLOOP.
        IF <ls_message1> IS ASSIGNED.
          RETURN.
        ENDIF.
      ENDIF.
    ELSEIF iv_operation EQ 'D'.

      DATA: ls_select_mdma     TYPE cmd_bs_mat_s_mat_mdma_select,
            ls_seloption_matnr TYPE range_s_matnr,
            ls_seloption_werks TYPE range_s_werks_d,
            ls_mdma_x          TYPE cmd_bs_mat_s_mdma_x.

      "Creating input to read db data from API
      LOOP AT lt_mdma ASSIGNING FIELD-SYMBOL(<fs_mdma_tab>).
        IF <fs_mdma_tab> IS ASSIGNED.
          ls_seloption_matnr-sign = 'I'.
          ls_seloption_matnr-option = 'EQ'.
          ls_seloption_matnr-low = <fs_mdma_tab>-matnr.
          APPEND ls_seloption_matnr TO ls_select_mdma-range_matnr.
          ls_seloption_werks-sign = 'I'.
          ls_seloption_werks-option = 'EQ'.
          ls_seloption_werks-low = <fs_mdma_tab>-werks.
          APPEND ls_seloption_werks TO ls_select_mdma-range_werks.
        ENDIF.
      ENDLOOP.

      CLEAR: lt_mdma,
             lt_mdma_x.
      IF ls_select_mdma IS NOT INITIAL.
        lr_cmd_mdma_api->read(
          EXPORTING
            is_selection = ls_select_mdma
          IMPORTING
            et_mdma      = lt_mdma
        ).
      ENDIF.
      LOOP AT lt_mdma ASSIGNING FIELD-SYMBOL(<fs_mdma_del>).
        IF <fs_mdma_del> IS ASSIGNED.
          <fs_mdma_del>-loekz = abap_true.
          ls_mdma_x-matnr = <fs_mdma_del>-matnr.
          ls_mdma_x-werks = <fs_mdma_del>-werks.
          ls_mdma_x-berid = <fs_mdma_del>-berid.
          ls_mdma_x-loekz = <fs_mdma_del>-loekz.
          APPEND ls_mdma_x TO lt_mdma_x.
        ENDIF.
      ENDLOOP.
    ENDIF.

    "Save MDMA data
    IF iv_test_mode IS INITIAL.
      IF lt_mdma IS NOT INITIAL.
        CLEAR et_message.
        lr_cmd_mdma_api->save(
          EXPORTING
            it_matnr_map = it_matnr_map
            it_mdma      = lt_mdma
            it_mdma_x    = lt_mdma_x
          IMPORTING
            et_message   = DATA(lt_mdma_message) ).
        IF lt_mdma_message IS NOT INITIAL.
          INSERT LINES OF lt_mdma_message INTO TABLE et_message.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD _call_mla_api.
    DATA: lt_mtart_meins    TYPE cmd_bs_mat_t_mtart_meins,
          ls_mtart_meins    TYPE cmd_bs_mat_s_mtart_meins,
          lt_matnr          TYPE pre03_tab,
          ls_matnr          TYPE pre03,
          lt_mara           TYPE mara_tab,
          lv_matnr          TYPE matnr,
          ls_matnr_map      TYPE cmd_bs_mat_s_tmp_to_int_id_map,
          lt_pre04          TYPE pre04_tab,
          ls_pre04          TYPE pre04,
          lt_mbew_md        TYPE TABLE OF v_mbew_md,
          lt_mbew_md_header TYPE TABLE OF v_mbew_md,
          ls_mbew_md        TYPE v_mbew_md,
          ls_ckmlcr         TYPE cmd_bs_mat_s_mla_ckmlcr,
          lt_ckmlcr         TYPE cmd_bs_mat_t_mla_ckmlcr,
          lt_ckmlcr_x       TYPE cmd_bs_mat_t_mla_ckmlcr_x,
          ls_ckmlcr_x       TYPE cmd_bs_mat_s_mla_ckmlcr_x,
          lt_ckmlpr         TYPE cmd_bs_mat_t_mla_ckmlpr,
          ls_ckmlpr_x       TYPE cmd_bs_mat_s_mla_ckmlpr_x,
          lt_ckmlpr_header  TYPE cmd_bs_mat_t_mla_ckmlpr,
          ls_ckmlpr_header  TYPE cmd_bs_mat_s_mla_ckmlpr,
          ls_bwkey          TYPE bwkey,
          ls_marv           TYPE marv.

    TYPES: BEGIN OF bwkey_current_period,
             bwkey TYPE bwkey,
             lfmon TYPE lfmon,
             lfgja TYPE lfgja,
           END OF bwkey_current_period.

    DATA : ls_bwkey_current_period TYPE bwkey_current_period,
           lt_bwkey_current_period TYPE TABLE OF bwkey_current_period.

    DATA(ls_data) = is_data.

****Collecting lt_mtart_meins **********************************************************************
*    lt_matnr = CORRESPONDING pre03_tab( ls_data-ckmlpr_tab ).
    LOOP AT ls_data-ckmlpr_tab ASSIGNING FIELD-SYMBOL(<fs_ckmlpr>).
      ls_matnr = <fs_ckmlpr>-matnr.
      COLLECT ls_matnr INTO lt_matnr.
    ENDLOOP.

    IF it_matnr_map IS NOT INITIAL.
      DATA(lv_temp_matnr) = it_matnr_map[ 1 ]-matnr_tmp.
    ENDIF.


    IF ls_data-mara_tab IS NOT INITIAL.
      LOOP AT lt_matnr INTO lv_matnr.
        CLEAR: ls_mtart_meins.

        ls_mtart_meins-matnr = lv_matnr.

        READ TABLE ls_data-mara_tab ASSIGNING FIELD-SYMBOL(<ls_mara>) WITH TABLE KEY matnr = lv_temp_matnr.
        IF sy-subrc = 0.
          ls_mtart_meins-meins = <ls_mara>-meins.
          ls_mtart_meins-mtart = <ls_mara>-mtart.
        ENDIF.
        IF it_matnr_map IS SUPPLIED.
          READ TABLE it_matnr_map INTO ls_matnr_map WITH KEY matnr_tmp = lv_temp_matnr.
          IF sy-subrc = 0.
            ls_mtart_meins-matnr = ls_matnr_map-matnr_int.
          ENDIF.
        ENDIF.

        INSERT ls_mtart_meins INTO TABLE lt_mtart_meins.
      ENDLOOP.
    ELSE.
      CALL FUNCTION 'MARA_ARRAY_READ'
        TABLES
          ipre03               = lt_matnr
          mara_tab             = lt_mara
        EXCEPTIONS
          enqueue_mode_changed = 1
          OTHERS               = 2.
      IF sy-subrc = 0.
        lt_mtart_meins = CORRESPONDING cmd_bs_mat_t_mtart_meins( lt_mara ).
      ENDIF.
    ENDIF.
**********************************************************************
******** Setting MLA Data********************************************************************
* Setting Internal numbering from CMD API to MLA Data
    IF it_matnr_map IS SUPPLIED.
      me->_replace_temp_matnr_ckml( EXPORTING it_tmp_key_map = it_matnr_map
                                    CHANGING  ct_data        = ls_data-ckmlhd_tab
                                              ct_data_x      = ls_data-ckmlhd_x_tab ).
      me->_replace_temp_matnr_ckml( EXPORTING it_tmp_key_map = it_matnr_map
                                    CHANGING  ct_data        = ls_data-ckmlcr_tab
                                              ct_data_x      = ls_data-ckmlcr_x_tab ).
      me->_replace_temp_matnr_ckml( EXPORTING it_tmp_key_map = it_matnr_map
                                    CHANGING  ct_data        = ls_data-ckmlpr_tab
                                              ct_data_x      = ls_data-ckmlpr_x_tab ).

    ENDIF.
* Setting LFMON, LFGJA, KALN1 from MBEW to CKML* tables

*       Collecting Current Periods of all Company codes

    LOOP AT ls_data-ckmlhd_tab ASSIGNING FIELD-SYMBOL(<fs_ckmlhd>).
      ls_bwkey = <fs_ckmlhd>-bwkey.

      CALL FUNCTION 'MARV_READ'
        EXPORTING
*         MARV_BUKRS = ' '
          marv_bwkey = ls_bwkey
*         MARV_WERKS = ' '
        IMPORTING
          wmarv      = ls_marv
        EXCEPTIONS
          not_found  = 1
          wrong_call = 2.
      IF sy-subrc = 0.
        ls_bwkey_current_period-bwkey = ls_bwkey.
        ls_bwkey_current_period-lfgja = ls_marv-lfgja.
        ls_bwkey_current_period-lfmon = ls_marv-lfmon.
        COLLECT ls_bwkey_current_period INTO lt_bwkey_current_period.
        CLEAR ls_bwkey_current_period.
      ENDIF.
    ENDLOOP.


*    lt_pre04 = CORRESPONDING pre04_tab( ls_data-mbew_tab ).

    lt_pre04 = CORRESPONDING pre04_tab( mt_val_keys MAPPING matnr = product
                                                            bwkey = valuationarea
                                                            bwtar = valuationtype ).

    IF it_matnr_map IS NOT INITIAL.
      LOOP AT lt_pre04 ASSIGNING FIELD-SYMBOL(<ls_pre04>).
        <ls_pre04>-matnr = it_matnr_map[ 1 ]-matnr_int.
      ENDLOOP.
    ENDIF.

    CALL FUNCTION 'MBEW_MD_ARRAY_READ'
      TABLES
        ipre04               = lt_pre04
        mbew_tab_md          = lt_mbew_md
      EXCEPTIONS
        enqueue_mode_changed = 1
        lock_on_mbew         = 2
        lock_system_error    = 3
        OTHERS               = 4.
    IF sy-subrc <> 0.
** Updated records from MMD still not in TMBEW - Action required ?
    ENDIF.
    SORT lt_mbew_md BY matnr bwkey bwtar.

    LOOP AT ls_data-ckmlhd_tab ASSIGNING FIELD-SYMBOL(<ls_ckmlhd>).
      TRY.
          <ls_ckmlhd>-kalnr = VALUE #( lt_mbew_md[ matnr = <ls_ckmlhd>-matnr bwkey = <ls_ckmlhd>-bwkey bwtar = <ls_ckmlhd>-bwtar ]-kaln1 ).
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ENDLOOP.

    LOOP AT ls_data-ckmlcr_tab ASSIGNING FIELD-SYMBOL(<ls_ckmlcr>).
      CLEAR ls_mbew_md.
      READ TABLE lt_mbew_md WITH KEY matnr = <ls_ckmlcr>-matnr bwkey = <ls_ckmlcr>-bwkey bwtar = <ls_ckmlcr>-bwtar INTO ls_mbew_md BINARY SEARCH.
      IF sy-subrc = 0.
        CLEAR: ls_ckmlcr,ls_ckmlcr_x.
        READ TABLE ls_data-ckmlcr_x_tab INTO ls_ckmlcr_x WITH KEY matnr = <ls_ckmlcr>-matnr bwkey = <ls_ckmlcr>-bwkey bwtar = <ls_ckmlcr>-bwtar curtp = <ls_ckmlcr>-curtp ."bdatj = <ls_ckmlcr>-bdatj poper = <ls_ckmlcr>-poper.
        IF sy-subrc = 0.
          DELETE ls_data-ckmlcr_x_tab WHERE matnr = <ls_ckmlcr>-matnr AND bwkey = <ls_ckmlcr>-bwkey AND curtp = <ls_ckmlcr>-curtp AND bwtar = <ls_ckmlcr>-bwtar AND poper = <ls_ckmlcr>-poper AND bdatj = <ls_ckmlcr>-bdatj.
          READ TABLE lt_bwkey_current_period ASSIGNING FIELD-SYMBOL(<ls_bwkey_current_period>) WITH KEY bwkey = <ls_ckmlcr>-bwkey.
          IF <ls_bwkey_current_period> IS ASSIGNED.
            ls_ckmlcr_x-matnr = <ls_ckmlcr>-matnr.
            ls_ckmlcr_x-bwkey = <ls_ckmlcr>-bwkey.
            ls_ckmlcr_x-bwtar = <ls_ckmlcr>-bwtar.
            ls_ckmlcr_x-curtp = <ls_ckmlcr>-curtp.
            ls_ckmlcr_x-bdatj = <ls_bwkey_current_period>-lfgja.
            ls_ckmlcr_x-poper = <ls_bwkey_current_period>-lfmon.
            INSERT ls_ckmlcr_x INTO TABLE lt_ckmlcr_x.
          ENDIF.
        ENDIF.
        MOVE-CORRESPONDING <ls_ckmlcr> TO ls_ckmlcr .

        ls_ckmlcr-kalnr = ls_mbew_md-kaln1.
        IF <ls_bwkey_current_period> IS ASSIGNED.
          ls_ckmlcr-matnr = <ls_ckmlcr>-matnr.
          ls_ckmlcr-bwkey = <ls_ckmlcr>-bwkey.
          ls_ckmlcr-bwtar = <ls_ckmlcr>-bwtar.
          ls_ckmlcr-curtp = <ls_ckmlcr>-curtp.
          ls_ckmlcr-bdatj = <ls_bwkey_current_period>-lfgja.
          ls_ckmlcr-poper = <ls_bwkey_current_period>-lfmon.
          INSERT ls_ckmlcr INTO TABLE lt_ckmlcr.
        ENDIF.
        DELETE ls_data-ckmlcr_tab WHERE curtp = <ls_ckmlcr>-curtp AND matnr = <ls_ckmlcr>-matnr  AND bwkey = <ls_ckmlcr>-bwkey AND bwtar = <ls_ckmlcr>-bwtar.
      ENDIF.
    ENDLOOP.

    IF lt_ckmlcr IS NOT INITIAL.
      INSERT LINES OF lt_ckmlcr INTO TABLE ls_data-ckmlcr_tab.
      INSERT LINES OF lt_ckmlcr_x INTO TABLE ls_data-ckmlcr_x_tab.
    ENDIF.

    LOOP AT ls_data-ckmlpr_tab ASSIGNING FIELD-SYMBOL(<ls_ckmlpr>).
      TRY.
          <ls_ckmlpr>-kalnr = VALUE #( lt_mbew_md[ matnr = <ls_ckmlpr>-matnr bwkey = <ls_ckmlpr>-bwkey bwtar = <ls_ckmlpr>-bwtar ]-kaln1 ).
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ENDLOOP.

    CLEAR lt_pre04.
    LOOP AT lt_mbew_md INTO ls_mbew_md WHERE bwtar IS NOT INITIAL.
      READ TABLE lt_mbew_md WITH KEY matnr = ls_mbew_md-matnr bwkey = ls_mbew_md-bwkey bwtar = '' TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      CLEAR ls_pre04.
      MOVE-CORRESPONDING ls_mbew_md TO ls_pre04.
      ls_pre04-bwtar = ''.
      APPEND ls_pre04 TO lt_pre04.
    ENDLOOP.
    CALL FUNCTION 'MBEW_MD_ARRAY_READ'
      TABLES
        ipre04               = lt_pre04
        mbew_tab_md          = lt_mbew_md_header
      EXCEPTIONS
        enqueue_mode_changed = 1
        lock_on_mbew         = 2
        lock_system_error    = 3
        OTHERS               = 4.
    IF sy-subrc <> 0.
** Updated records from MMD still not in TMBEW - Action required ?
    ENDIF.
    IF lt_mbew_md_header IS NOT INITIAL.
      SELECT * FROM ckmlpr INTO CORRESPONDING FIELDS OF TABLE lt_ckmlpr FOR ALL ENTRIES IN lt_mbew_md_header WHERE kalnr = lt_mbew_md_header-kaln1.
    ENDIF.
    LOOP AT lt_ckmlpr ASSIGNING FIELD-SYMBOL(<fs_ckmlpr_header>).
      READ TABLE lt_mbew_md_header INTO DATA(ls_mbew_md_header) WITH KEY kaln1 = <fs_ckmlpr_header>-kalnr.
      CLEAR ls_ckmlpr_header.
      MOVE-CORRESPONDING <fs_ckmlpr_header> TO ls_ckmlpr_header.
      ls_ckmlpr_header-matnr = ls_mbew_md_header-matnr.
      ls_ckmlpr_header-bwkey = ls_mbew_md_header-bwkey.
      INSERT ls_ckmlpr_header INTO TABLE ls_data-ckmlpr_tab.

      CLEAR: ls_ckmlpr_x.
      ls_ckmlpr_x-matnr = ls_mbew_md_header-matnr.
      ls_ckmlpr_x-bwkey = ls_mbew_md_header-bwkey.
      ls_ckmlpr_x-bwtar = ls_mbew_md_header-bwtar.
      ls_ckmlpr_x-curtp = <fs_ckmlpr_header>-curtp.
      INSERT ls_ckmlpr_x INTO TABLE ls_data-ckmlpr_x_tab.
    ENDLOOP.

******** Calling CHECK **********************************************************************

    CALL METHOD me->_field_validation
      EXPORTING
        is_data    = is_data
      IMPORTING
        et_message = et_message.

    IF et_message IS INITIAL.

      CALL METHOD cl_cmd_bs_mat_mla_api=>get_instance
        RECEIVING
          ro_instance = DATA(lr_cmd_mla_api).

      CALL METHOD lr_cmd_mla_api->check
        EXPORTING
          it_ckmlhd      = ls_data-ckmlhd_tab
          it_ckmlhd_x    = ls_data-ckmlhd_x_tab
          it_ckmlcr      = ls_data-ckmlcr_tab
          it_ckmlcr_x    = ls_data-ckmlcr_x_tab
          it_ckmlpr      = ls_data-ckmlpr_tab
          it_ckmlpr_x    = ls_data-ckmlpr_x_tab
          it_mtart_meins = lt_mtart_meins
*         iv_verbose_messages = ABAP_FALSE
        IMPORTING
          et_message     = DATA(lt_message).

      LOOP AT lt_message ASSIGNING FIELD-SYMBOL(<ls_message>) WHERE msgty CA 'EAX'.EXIT.ENDLOOP.
      IF <ls_message> IS NOT ASSIGNED.
        CLEAR lt_message.
******** Calling SAVE **********************************************************************
        lr_cmd_mla_api->set_call_mode( iv_call_mode = 'MDG' ).

        IF iv_test_mode IS INITIAL.
*        ld-092 - 20231025 - kbui start ++
*********In case of change, check missing Period before save
*       Build Missing Period
          IF to_upper( gs_data-action ) = 'CHANGE'.

            DATA: lt_kalnr_dummy     TYPE ckmv0_matobj_tbl,
                  ls_kalnr_dummy     LIKE LINE OF lt_kalnr_dummy,
                  lt_ckmlhd_dummy    TYPE TABLE OF ckmlhd,
                  lt_ckmlpr_dummy    TYPE TABLE OF ckmlpr,
                  lt_ckmlpp_dummy    TYPE TABLE OF ckmlpp,
                  lt_ckmlcr_dummy    TYPE TABLE OF ckmlcr,
                  ls_current_period  TYPE cki_per_ml,
                  ls_previous_period TYPE cki_per_ml,
                  ls_las_year_period TYPE cki_per_ml,
                  lt_ckmlcr_all      TYPE TABLE OF ckmlcr,
                  lt_ckmlpp_all      TYPE TABLE OF ckmlpp,
                  lt_ckmlprkeko_all  TYPE TABLE OF ckmlprkeko,
                  lt_ckmlprkeph_all  TYPE TABLE OF ckmlprkeph.

            LOOP AT gs_mat-mbew_tab INTO DATA(ls_kalnr_map).

              ls_kalnr_dummy-matnr = ls_kalnr_map-matnr.
              ls_kalnr_dummy-bwkey = ls_kalnr_map-bwkey.
              ls_kalnr_dummy-bwtar = ls_kalnr_map-bwtar.
              ls_kalnr_dummy-kalnr = ls_kalnr_map-kalnr.
              APPEND ls_kalnr_dummy TO lt_kalnr_dummy.
              CLEAR ls_kalnr_dummy.

              CALL METHOD lr_cmd_mla_api->get_posting_periods
                EXPORTING
                  iv_bwkey                 = ls_kalnr_map-bwkey
                IMPORTING
                  es_current_period        = ls_current_period
                  es_previous_period       = ls_previous_period
                  es_last_period_prev_year = ls_las_year_period.

*           ml-kopf/preissatz lesen
              CALL FUNCTION 'CKMS_HEADER_READ_WITH_ITAB'
                EXPORTING
                  refresh_buffer          = ' '
*                 ENQUEUE_MBEW            = ' '
                TABLES
                  in_kalnr                = lt_kalnr_dummy
                  out_ckmlhd              = lt_ckmlhd_dummy
                  out_ckmlpr              = lt_ckmlpr_dummy
*                 OUT_CKMLHD_LOCK         =
*                 OUT_CKMLPR_LOCK         =
                EXCEPTIONS
                  no_data_found           = 1
                  input_data_inconsistent = 2
                  lock_system_failure     = 3
                  internal_error          = 4
                  OTHERS                  = 5.
              IF sy-subrc <> 0.
*               LD-103 - 20231025 - KBUI Start ++
*               If data not found it means create new Valuation
                CONTINUE.
*               LD-103 - 20231025 - KBUI End ++
*               LD-103 - 20231025 - KBUI Start --
*                MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*               LD-103 - 20231025 - KBUI Start --
              ENDIF.

*             ML-Periodens盲tze lesen
              TRY . "LD-103 - 20231025 - KBUI Start++
                  CALL FUNCTION 'CKMS_PERIOD_READ_WITH_ITAB'
                    EXPORTING
                      i_refresh_buffer        = ' '
                      i_build_smbew           = 'X'
                      i_bdatj_1               = ls_current_period-bdatj
                      i_poper_1               = ls_current_period-poper
                      i_bdatj_2               = ls_previous_period-bdatj
                      i_poper_2               = ls_previous_period-poper
                      i_bdatj_3               = ls_las_year_period-bdatj
                      i_poper_3               = ls_las_year_period-poper
                    TABLES
                      t_kalnr                 = lt_kalnr_dummy
                      t_ckmlpp                = lt_ckmlpp_dummy
                      t_ckmlcr                = lt_ckmlcr_dummy
                    EXCEPTIONS
                      no_data_found           = 1
                      input_data_inconsistent = 2
                      buffer_inconsistent     = 3
                      OTHERS                  = 4.
                  IF sy-subrc <> 0.
*                   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno "LD-103 - 20231025 - KBUI --
*                        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4. "LD-103 - 20231025 - KBUI --
*                   LD-103 - 20231025 - KBUI Start++
                    lt_message = VALUE #( BASE gt_message
                      (   msgty       = 'E'
                          msgid         = sy-msgid
                          msgno     = sy-msgno
                          msgv1 = sy-msgv1
                          msgv2 = sy-msgv2
                          msgv3 = sy-msgv3
                          msgv4 = sy-msgv4
                         )  ).
*                   LD-103 - 20231025 - KBUI End++
                  ENDIF.

*             LD-103 - 20231025 - KBUI Start++
                CATCH cx_root INTO DATA(lo_exeption).
                  lt_message = VALUE #( BASE gt_message
                                      (   msgty       = 'E'
                                          msgid         = sy-msgid
                                          msgno     = sy-msgno
                                          msgv1 = sy-msgv1
                                          msgv2 = sy-msgv2
                                          msgv3 = sy-msgv3
                                          msgv4 = sy-msgv4
                                         )  ).
                  EXIT.
              ENDTRY.
*             LD-103 - 20231025 - KBUI End++

              FIELD-SYMBOLS <fs_prkeko> TYPE ANY TABLE.
              ASSIGN ('(SAPLMLCCS_DBACCESS)T_DYN_PRKEKO') TO <fs_prkeko>.

              FIELD-SYMBOLS <fs_prkeph> TYPE ANY TABLE.
              ASSIGN ('(SAPLMLCCS_DBACCESS)T_DYN_PRKEPH') TO <fs_prkeph>.

              FIELD-SYMBOLS <fs_ckmlpp_miss> TYPE ANY TABLE.
              ASSIGN ('(SAPLCKMS)T_DYN_CKMLPP') TO <fs_ckmlpp_miss>.

              FIELD-SYMBOLS <fs_ckmlcr_miss> TYPE ANY TABLE.
              ASSIGN ('(SAPLCKMS)T_DYN_CKMLCR') TO <fs_ckmlcr_miss>.

*             APPEND MISSING CKMLPRKEKO & CKMLPRKEPH
              IF <fs_prkeko> IS ASSIGNED AND
                 <fs_prkeko> IS NOT INITIAL.
                APPEND LINES OF <fs_prkeko> TO lt_ckmlprkeko_all.
                SORT lt_ckmlprkeko_all ASCENDING BY mandt kalnr bdatj poper untper prtyp curtp.
                DELETE ADJACENT DUPLICATES FROM lt_ckmlprkeko_all COMPARING mandt kalnr bdatj poper untper prtyp curtp.
              ENDIF.

              IF <fs_prkeph> IS ASSIGNED AND
                 <fs_prkeph> IS NOT INITIAL.
                APPEND LINES OF <fs_prkeph> TO lt_ckmlprkeph_all.
                SORT lt_ckmlprkeph_all ASCENDING BY kalnr bdatj poper untper keart prtyp kkzst patnr dipa curtp.
                DELETE ADJACENT DUPLICATES FROM lt_ckmlprkeph_all COMPARING kalnr bdatj poper untper keart prtyp kkzst patnr dipa curtp.
              ENDIF.

*           APPEND MISSING period to lt_old_ckmlcr and lt_new_ckmlpp
              IF <fs_ckmlcr_miss> IS ASSIGNED AND
                 <fs_ckmlcr_miss> IS NOT INITIAL.
                APPEND LINES OF <fs_ckmlcr_miss> TO lt_ckmlcr_all.
                SORT lt_ckmlcr_all ASCENDING BY kalnr bdatj poper untper curtp.
                DELETE ADJACENT DUPLICATES FROM lt_ckmlcr_all COMPARING  kalnr bdatj poper untper curtp.
              ENDIF.

              IF <fs_ckmlpp_miss> IS ASSIGNED AND
                 <fs_ckmlpp_miss> IS NOT INITIAL.
                APPEND LINES OF <fs_ckmlpp_miss> TO lt_ckmlpp_all.
                SORT lt_ckmlpp_all ASCENDING BY kalnr bdatj poper untper.
                DELETE ADJACENT DUPLICATES FROM lt_ckmlpp_all COMPARING kalnr bdatj poper untper.
              ENDIF.

              REFRESH: lt_ckmlpp_dummy,
                       lt_ckmlcr_dummy,
                       lt_ckmlhd_dummy,
                       lt_ckmlpr_dummy.

              CLEAR: ls_current_period,
                     ls_previous_period,
                     ls_las_year_period.

            ENDLOOP.

*           Append data to staic attribute
*           LD-092 - 20231025 - KBUI Start ++
**           LD-0127 - Danh Tran - 20230312 - Start - Mod
***             POST missing period first
***            CALL FUNCTION 'CKMS_BUFFER_POST_DYN'
***              EXPORTING
***                t_dyn_ckmlpp = lt_ckmlpp_all
***                t_dyn_ckmlcr = lt_ckmlcr_all.
***
****           Post ALL CKMLKEO & CKMLKEPH allow duplicate
***            CALL FUNCTION 'MLCCS_POST_DYN'
***              EXPORTING
***                it_dyn_prkeph = lt_ckmlprkeph_all
***                it_dyn_prkeko = lt_ckmlprkeko_all.

            DATA:
              lt_ckmlpp_all_s     TYPE ckmlpp_sorted,
              lt_ckmlcr_all_s     TYPE ckmlcr_sorted,
              lt_ckmlprkeph_all_s TYPE mlccs_t_prkeph,
              lt_ckmlprkeko_all_s TYPE mlccs_t_prkeko.

            IF lt_ckmlpp_all IS NOT INITIAL OR
               lt_ckmlcr_all IS NOT INITIAL.
*             POST missing period first
              FREE: lt_ckmlpp_all_s[], lt_ckmlcr_all_s[].
              MOVE-CORRESPONDING lt_ckmlpp_all[] TO lt_ckmlpp_all_s[].
              MOVE-CORRESPONDING lt_ckmlcr_all[] TO lt_ckmlcr_all_s[].

              CALL FUNCTION 'CKMS_BUFFER_POST_DYN'
                EXPORTING
                  t_dyn_ckmlpp = lt_ckmlpp_all_s[]
                  t_dyn_ckmlcr = lt_ckmlcr_all_s[].
            ENDIF.

            IF lt_ckmlprkeph_all IS NOT INITIAL OR
               lt_ckmlprkeko_all IS NOT INITIAL.
*             Post ALL CKMLKEO & CKMLKEPH allow duplicate
              FREE: lt_ckmlprkeph_all_s[], lt_ckmlprkeko_all_s[].
*              MOVE-CORRESPONDING lt_ckmlprkeph_all[] TO lt_ckmlpp_all_s[].
              MOVE-CORRESPONDING lt_ckmlprkeph_all[] TO lt_ckmlprkeph_all_s[]. "JLR-514 20240313 Kbui++
              MOVE-CORRESPONDING lt_ckmlprkeko_all[] TO lt_ckmlprkeko_all_s[].
              CALL FUNCTION 'MLCCS_POST_DYN'
                EXPORTING
                  it_dyn_prkeph = lt_ckmlprkeph_all_s
                  it_dyn_prkeko = lt_ckmlprkeko_all_s.
            ENDIF.
**          LD-0127 - Danh Tran - 20230312 - Start - Mod

          ENDIF.
*        LD-092 - 20231025 - KBUI End ++

          TRY.
              CALL METHOD lr_cmd_mla_api->save
                EXPORTING
                  it_ckmlhd      = ls_data-ckmlhd_tab
                  it_ckmlhd_x    = ls_data-ckmlhd_x_tab
                  it_ckmlcr      = ls_data-ckmlcr_tab
                  it_ckmlcr_x    = ls_data-ckmlcr_x_tab
                  it_ckmlpr      = ls_data-ckmlpr_tab
                  it_ckmlpr_x    = ls_data-ckmlpr_x_tab
                  it_mtart_meins = lt_mtart_meins
*                 iv_verbose_messages = ABAP_FALSE
                IMPORTING
                  et_message     = lt_message.
            CATCH cx_fml_product_master_api_busi.
            CATCH  cx_fml_product_master_api_tech.
          ENDTRY.
        ENDIF.
      ENDIF.
      et_message = lt_message.
    ENDIF.
  ENDMETHOD.


  METHOD _call_qmat_api.
    CALL METHOD cl_cmd_bs_qmat_api=>get_instance
      RECEIVING
        ro_bo = DATA(cl_qmat_api).

**checks whether AKTIV-KZ can be set or withdrawn
*    TYPES:
*      BEGIN OF lty_insptype,
*        matnr TYPE qmat-matnr,
*        werks TYPE qmat-werks,
*        art   TYPE qmat-art,
*      END OF lty_insptype.
*    TYPES:
*      lty_t_insptype TYPE TABLE OF lty_insptype.
*
*    DATA:
*      lt_insptype TYPE lty_t_insptype,
*      l_afr       TYPE qmat-afr.
*    SELECT * FROM tq32 INTO TABLE @DATA(lt_tq32).
*
*    SELECT * FROM tq32 INTO TABLE @DATA(lt_tq32_bestrel)
*    WHERE ( herkunft EQ '01'
*       OR   herkunft EQ '04'
*       OR   herkunft EQ '05'
*       OR   herkunft EQ '08'
*       OR   herkunft EQ '09' ) .
*
*    LOOP AT it_qmat_upd INTO DATA(ls_qmat_upd).
*      TRY.
*          DATA(ls_qmat_upd_x) = it_qmat_upd[ matnr = ls_qmat_upd-matnr
*                                             werks = ls_qmat_upd-werks
*                                             art   = ls_qmat_upd-art ].
*        CATCH cx_sy_itab_line_not_found.
*      ENDTRY.
*      IF ls_qmat_upd_x-aktiv = 'X'.
*        lt_insptype = VALUE #( BASE lt_insptype (
*                                       matnr = ls_qmat_upd-matnr
*                                       werks = ls_qmat_upd-werks
*                                       art   = ls_qmat_upd-art ) ).
*      ENDIF.
*    ENDLOOP.
*    IF lt_insptype IS NOT INITIAL.
*      SELECT *
*        FROM qmat AS t1
*         FOR ALL ENTRIES IN @lt_insptype
*       WHERE t1~matnr = @lt_insptype-matnr
*         AND t1~werks = @lt_insptype-werks
**         AND t1~art  = @lt_insptype-art
*        INTO TABLE @DATA(lt_qmat).
*    ENDIF.
*
*    LOOP AT lt_insptype INTO DATA(ls_insptype).
*
*      TRY.
*          ls_qmat_upd  = it_qmat_upd[ matnr = ls_insptype-matnr
*                                      werks = ls_insptype-werks
*                                      art   = ls_insptype-art ].
*        CATCH cx_sy_itab_line_not_found.
*          CONTINUE.
*      ENDTRY.
*
*      TRY.
*          DATA(ls_qmat) = lt_qmat[ matnr = ls_insptype-matnr
*                                   werks = ls_insptype-werks
*                                   art   = ls_insptype-art ].
*        CATCH cx_sy_itab_line_not_found.
*          DATA(l_message_flag) = ''.
*      ENDTRY.
*      l_afr = ls_qmat-afr.
*      IF l_afr IS INITIAL.
*        IF line_exists( lt_tq32_bestrel[ art = ls_insptype-art ] ).
*          l_afr = ls_qmat-afr.
*          CHECK l_afr IS INITIAL.
*          l_message_flag  = 'X'.
*          LOOP AT lt_qmat INTO DATA(ls_qmat_check) WHERE werks = ls_qmat-werks
*                                                     AND art   <> ls_qmat-art
*                                                     AND aktiv = 'X'.
*
*            IF line_exists( lt_tq32_bestrel[ art = ls_qmat-art ] ) AND ls_qmat-afr = space.
*              l_message_flag = ''.
*            ENDIF.
*
*          ENDLOOP.
*
*
*        ENDIF.
*      ENDIF.
*
*      IF l_message_flag IS NOT INITIAL.
*        IF ls_qmat_upd-aktiv = 'X'.
*          gt_message = VALUE #( BASE gt_message (
*                type   = 'E'
*                id     = 'QA'
*                number = '142') ).
*        ENDIF.
*      ENDIF.
*
*    ENDLOOP.


*    if not line_exists( gt_message[ type = 'E' ] )
*    or not line_exists( gt_message[ type = 'A' ] )
*    or not line_exists( gt_message[ type = 'X' ] ).
    " Insert QMAT
    cl_qmat_api->save(
      EXPORTING
        it_data_ins  = it_qmat_ins
        it_data_upd  = it_qmat_upd
        it_data_del  = it_qmat_del
        it_qmat_x    = it_qmat_x
        iv_test_mode = iv_test_mode
        it_matnr_map = it_matnr_map
      IMPORTING
        et_message   = et_message ).
*    endif.

  ENDMETHOD.


  METHOD _call_save_api.
    CLEAR et_message.
    IF is_data-mara_tab IS NOT INITIAL OR is_data-mara_x_tab IS NOT INITIAL
      OR is_data-marc_tab IS NOT INITIAL OR is_data-marc_x_tab IS NOT INITIAL
      OR is_data-mard_tab IS NOT INITIAL OR is_data-mard_x_tab IS NOT INITIAL
      OR is_data-makt_tab IS NOT INITIAL OR is_data-makt_x_tab IS NOT INITIAL
      OR is_data-mbew_tab IS NOT INITIAL OR is_data-mbew_x_tab IS NOT INITIAL
      OR is_data-marm_tab IS NOT INITIAL OR is_data-marm_x_tab IS NOT INITIAL
      OR is_data-mean_tab IS NOT INITIAL OR is_data-mean_x_tab IS NOT INITIAL
      OR is_data-mlan_sales_tab IS NOT INITIAL OR is_data-mlan_sales_x_tab IS NOT INITIAL
      OR is_data-mvke_tab IS NOT INITIAL OR is_data-mvke_x_tab IS NOT INITIAL
      OR is_data-notes_tab IS NOT INITIAL OR is_data-notes_x_tab IS NOT INITIAL
      OR is_data-plant_notes_tab IS NOT INITIAL OR is_data-plant_notes_x_tab IS NOT INITIAL
      OR is_data-sales_notes_tab IS NOT INITIAL OR is_data-sales_notes_x_tab IS NOT INITIAL
      .
*      Call CMD API
      CALL METHOD cl_cmd_bs_mat_api=>get_instance
        IMPORTING
          eo_bo = DATA(cl_cmd).

      CALL METHOD cl_cmd->save
        EXPORTING
          is_data        = is_data
          iv_test_mode   = iv_test_mode
          iv_check_matnr = 'X'
        IMPORTING
          et_message     = DATA(lt_cmd_message)
          et_mmd_message = DATA(lt_mmd_message)
          et_matnr_map   = DATA(lt_matnr_map).

      IF lt_cmd_message IS NOT INITIAL.
        INSERT LINES OF lt_cmd_message INTO TABLE et_message.
      ENDIF.
      IF lt_mmd_message IS NOT INITIAL.
        INSERT LINES OF lt_mmd_message INTO TABLE et_message.
      ENDIF.
      LOOP AT et_message ASSIGNING FIELD-SYMBOL(<ls_message>) WHERE msgty CA 'EAX'.EXIT.ENDLOOP.
      IF <ls_message> IS ASSIGNED.
        RETURN.
      ENDIF.

    ENDIF.

    " Call QMAT API
    IF gt_qmat_ins IS NOT INITIAL
      OR gt_qmat_upd IS NOT INITIAL
      OR gt_qmat_del IS NOT INITIAL.
      me->_call_qmat_api(
        EXPORTING
          it_matnr_map = lt_matnr_map
          it_qmat_ins  = gt_qmat_ins
          it_qmat_upd  = gt_qmat_upd
          it_qmat_del  = gt_qmat_del
          it_qmat_x    = gt_qmat_x
          iv_test_mode = iv_test_mode
        IMPORTING
          et_message   = DATA(lt_qmat_message) ).

      IF lt_qmat_message IS NOT INITIAL.
        APPEND LINES OF lt_qmat_message TO et_message.
      ENDIF.
    ENDIF.

    IF is_data-mdma_tab IS  NOT INITIAL OR is_data-mdma_x_tab IS NOT INITIAL.
*      Call MDMA API
      CALL METHOD me->_call_mdma_api
        EXPORTING
          it_matnr_map = lt_matnr_map
          it_mdma      = is_data-mdma_tab
          it_mdma_x    = is_data-mdma_x_tab
          iv_operation = iv_mrp_operation
          iv_test_mode = iv_test_mode
        IMPORTING
          et_message   = DATA(lt_mdma_message).
      IF lt_mdma_message IS NOT INITIAL.
        INSERT LINES OF lt_mdma_message INTO TABLE et_message.
      ENDIF.

    ENDIF.

    et_matnr_map = lt_matnr_map.
  ENDMETHOD.


  METHOD _check_existence.
    SELECT SINGLE matnr
      FROM mara
     WHERE matnr = @gs_data-product
      INTO @gv_product.
    IF sy-subrc = 0.
      cv_exist = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD _check_material.
    DATA:
      lt_matpr   TYPE STANDARD TABLE OF ckmpr_f_mat_price WITH DEFAULT KEY,
      ls_onecurr TYPE cki_mr21_input.
    CLEAR lt_matpr.
    lt_matpr = VALUE #( ( pp-matnr = iv_matnr
                          pp-bwkey = iv_bwkey ) ).

    CALL FUNCTION 'PRICES_PROPOSE'
      EXPORTING
        actual_bdatj = iv_bdatj
        actual_poper = iv_poper
        bukrs        = iv_bukrs
*       subs_dbt     =
*       s_price_prop_ctrl =
*       im_aiv_flag  = abap_false
*       i_acc_principle   =
*        IMPORTING
*       prices_proposed   =
      TABLES
        t_matpr      = lt_matpr
      EXCEPTIONS
        data_error   = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      et_return = VALUE #( BASE gt_message
                          ( type       = sy-msgty
                            id         = sy-msgid
                            number     = sy-msgno
                            message_v1 = sy-msgv1
                            message_v2 = sy-msgv2
                            message_v3 = sy-msgv3
                            message_v4 = sy-msgv4 ) ).
    ELSE.
      READ TABLE lt_matpr INTO es_matpr INDEX 1.
    ENDIF.
    LOOP AT es_matpr-cr INTO DATA(ls_matpr).
      MOVE-CORRESPONDING ls_matpr TO ls_onecurr.
      ls_onecurr-ierzkalk = ls_onecurr-erzkalk.
      ls_onecurr-izukbew  = ls_onecurr-zukbew.
      CLEAR:
        ls_onecurr-erzkalk,
        ls_onecurr-zukbew.

      ls_onecurr = VALUE #( BASE ls_onecurr
                             savepr_v = ls_matpr-newpvprs
                             savepr_s = ls_matpr-newstprs
                             stapr    = COND #( WHEN es_matpr-pp-vprsv = 'V'
                                                  THEN ls_matpr-stprs
                                                ELSE ls_matpr-pvprs   )
                             newstapr = COND #( WHEN es_matpr-pp-vprsv = 'V'
                                                  THEN ls_matpr-stprs
                                                ELSE ls_matpr-pvprs   )
                             valpr    = COND #( WHEN es_matpr-pp-vprsv = 'V'
                                                  THEN ls_matpr-pvprs
                                                ELSE ls_matpr-stprs   )
                             newvalpr = COND #( WHEN es_matpr-pp-vprsv = 'V'
                                                  THEN ls_matpr-pvprs
                                                ELSE ls_matpr-stprs   )
                             pstxt    = COND #( WHEN es_matpr-pp-vprsv = 'V'
                                                  THEN 'Moving Avg Price'
                                                ELSE 'Standard Price'   )  ).
      MOVE-CORRESPONDING es_matpr-pp TO ls_onecurr.
      "Set prices with calculation
      IF ls_onecurr-ierzkalk IS NOT INITIAL
      OR ls_onecurr-lfdkalk IS NOT INITIAL.
        DATA(kalk_flag) = 'X'.
        IF es_matpr-pp-vprsv = 'V'.
          IF ls_onecurr-savepr_s IS NOT INITIAL.
            ls_onecurr-newstapr = ls_onecurr-savepr_s.
          ELSE.
            CLEAR ls_onecurr-newstapr.
          ENDIF.
        ELSE.
          IF ls_onecurr-savepr_s IS INITIAL.
            ls_onecurr-newvalpr = ls_onecurr-savepr_s.
          ELSE.
            CLEAR ls_onecurr-newvalpr.
          ENDIF.
        ENDIF.
      ENDIF.

      READ TABLE ct_allcurr ASSIGNING FIELD-SYMBOL(<fs_allcurr>)
        WITH KEY icurtp = ls_matpr-curtp.

      IF sy-subrc = 0.
        APPEND ls_onecurr TO <fs_allcurr>-one_curr.
      ENDIF.
    ENDLOOP.

    CHECK NOT es_matpr-pp-kaln1 IS INITIAL.
    READ TABLE ct_matcb INTO DATA(ls_wa_matcb)
       WITH TABLE KEY kalnr = es_matpr-pp-kaln1.
    IF sy-subrc = 0.
      ls_wa_matcb-ckmlpr = es_matpr-ckmlpr.
      MODIFY TABLE ct_matcb FROM ls_wa_matcb.
    ELSE.
      CLEAR ls_wa_matcb.
      ls_wa_matcb-kalnr = es_matpr-pp-kaln1.
      ls_wa_matcb-ckmlpr = es_matpr-ckmlpr.
      INSERT ls_wa_matcb INTO TABLE ct_matcb.
    ENDIF.
* CKMLPR-Daten
    READ TABLE ct_kekocb INTO DATA(ls_wa_kekocb)
         WITH TABLE KEY kalnr = es_matpr-pp-kaln1.
    IF sy-subrc EQ 0.
      ls_wa_kekocb-keko = es_matpr-keko.
      MODIFY TABLE ct_kekocb FROM ls_wa_kekocb.
    ELSE.
      CLEAR ls_wa_kekocb.
      ls_wa_kekocb-kalnr  = es_matpr-pp-kaln1.
      ls_wa_kekocb-keko   = es_matpr-keko.
      INSERT ls_wa_kekocb INTO TABLE ct_kekocb.
    ENDIF.
  ENDMETHOD.


  METHOD _check_period.

    DATA:
      lv_poper            TYPE bkpf-monat,
      lv_bdatj            TYPE bkpf-gjahr,
      lv_monat            TYPE t001b-frpe1,
      lv_error            TYPE char1,
      ls_marv             TYPE marv,
      lv_xruem            TYPE xfeld,
      lv_xruej            TYPE xfeld,
      lv_message_text(60).

    CLEAR lv_error.
    CALL FUNCTION 'FI_PERIOD_DETERMINE'
      EXPORTING
        i_budat = iv_budat
        i_bukrs = iv_bukrs
      IMPORTING
        e_gjahr = lv_bdatj
        e_monat = lv_poper.
    lv_monat = lv_poper.

    CALL FUNCTION 'FI_PERIOD_CHECK'
      EXPORTING
        i_bukrs          = iv_bukrs
        i_gjahr          = lv_bdatj
        i_koart          = '+'
        i_konto          = '+'
        i_monat          = lv_monat
      EXCEPTIONS
        error_period     = 1
        error_period_acc = 2.
    CASE sy-subrc.
      WHEN 1.
        et_message = VALUE #( BASE et_message (
          type       = 'E'
          id         = 'F5'
          number     = '201'
          message_v1 = lv_poper
          message_v2 = lv_bdatj ) ).
        lv_error = 'X'.
      WHEN 2.
        et_message = VALUE #( BASE et_message (
          type       = 'E'
          id         = 'F5'
          number     = '286'
          message_v1 = lv_poper
          message_v2 = lv_bdatj
          message_v3 = '+'
          message_v4 = '+' ) ).
        lv_error = 'X'.
    ENDCASE.
    IF lv_error IS INITIAL.
      CALL FUNCTION 'MARV_SINGLE_READ'
        EXPORTING
          kzrfb      = ' '
          maxtz      = '100'
          bukrs      = iv_bukrs
        IMPORTING
          wmarv      = ls_marv
        EXCEPTIONS
          not_found  = 1
          wrong_call = 2
          OTHERS     = 3.
      IF sy-subrc <> 0.
        et_message = VALUE #( BASE et_message (
            type       = sy-msgty
            id         = sy-msgid
            number     = sy-msgno
            message_v1 = sy-msgv1
            message_v2 = sy-msgv2
            message_v3 = sy-msgv3
            message_v4 = sy-msgv4  ) ).
      ENDIF.
    ENDIF.
    IF lv_bdatj NE ls_marv-lfgja "NOT current period
    OR lv_poper NE ls_marv-lfmon.
      IF  lv_bdatj = ls_marv-vjgja
      AND lv_poper = ls_marv-vjmon.
        lv_xruej = 'X'.
      ENDIF.
      IF  lv_bdatj = ls_marv-vmgja
      AND lv_poper = ls_marv-vmmon.
        lv_xruem = 'X'.
      ENDIF.
      IF lv_xruem IS INITIAL OR ( lv_xruem = 'X' AND ls_marv-xruem IS INITIAL ). "AND allow_backposting IS INITIAL ).
        " Not to prev period or last period prev year  or
        IF ls_marv-xruem = space. "AND allow_backposting IS INITIAL.
          CALL FUNCTION 'MB_EDIT_MESSAGE'
            EXPORTING
              t1      = ls_marv-lfmon
              t2      = ls_marv-lfgja
            IMPORTING
              message = lv_message_text.
        ELSE.
          CALL FUNCTION 'MB_EDIT_MESSAGE'
            EXPORTING
              t1      = ls_marv-lfmon
              t2      = ls_marv-lfgja
              t3      = '/'
              t4      = ls_marv-vmmon
              t5      = ls_marv-vmgja
            IMPORTING
              message = lv_message_text.
        ENDIF.
        et_message = VALUE #( BASE et_message (
            type       = 'E'
            id         = 'CKPRCH'
            number     = '009'
            message_v1 = lv_message_text   ) ).
      ENDIF.
    ENDIF.
    IF et_message IS INITIAL.

      gt_conv_period = VALUE #( BASE gt_conv_period
                                 ( bukrs = iv_bukrs
                                   budat = iv_budat
                                   gjahr = lv_bdatj
                                   poper = lv_poper  ) ).
    ENDIF.


  ENDMETHOD.


  METHOD _do_mapping_ml.
    DATA:
      ls_ckmlhd                     TYPE cmd_bs_mat_s_mla_ckmlhd,
      ls_ckmlhd_x                   TYPE cmd_bs_mat_s_mla_ckmlhd_x,
      ls_ckmlcr                     TYPE cmd_bs_mat_s_mla_ckmlcr,
      ls_ckmlcr_x                   TYPE cmd_bs_mat_s_mla_ckmlcr_x,
      ls_ckmlpr                     TYPE cmd_bs_mat_s_mla_ckmlpr,
      ls_ckmlpr_x                   TYPE cmd_bs_mat_s_mla_ckmlpr_x,
      iv_ckml_neccessary_check_done TYPE boolean VALUE abap_false,
      iv_ckml_neccessary_subrc      LIKE sy-subrc,
      ls_mara                       TYPE mara,
      lv_product                    TYPE mara-matnr,
      lt_markforchange_temp         TYPE TABLE OF string,
      lt_markforchange              TYPE TABLE OF string,
      lv_table_fieldname            TYPE string.

    CHECK ct_valuation_data IS NOT INITIAL.


    IF ct_valuation_data[ 1 ]-product IS NOT INITIAL.

      lv_product = ct_valuation_data[ 1 ]-product.

    ELSEIF ct_valuation_data[ 1 ]-to_valuationaccount-product IS NOT INITIAL.

      lv_product = ct_valuation_data[ 1 ]-to_valuationaccount-product.

    ELSEIF ct_valuation_data[ 1 ]-to_mlaccount IS NOT INITIAL
            AND ct_valuation_data[ 1 ]-to_mlaccount[ 1 ]-product IS NOT INITIAL.

      lv_product = ct_valuation_data[ 1 ]-to_mlaccount[ 1 ]-product.

    ELSEIF ct_valuation_data[ 1 ]-to_mlprices IS NOT INITIAL
            AND ct_valuation_data[ 1 ]-to_mlprices[ 1 ]-product IS NOT INITIAL.

      lv_product = ct_valuation_data[ 1 ]-to_mlprices[ 1 ]-product.
    ENDIF.

    CALL FUNCTION 'MARA_SINGLE_READ'
      EXPORTING
        matnr             = lv_product
      IMPORTING
        wmara             = ls_mara
      EXCEPTIONS
        lock_on_material  = 1
        lock_system_error = 2
        wrong_call        = 3
        not_found         = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
*    DATA lt_markforchange TYPE TABLE OF string.

    IF iv_mrp_operation = 'I'.
      LOOP AT ct_valuation_data ASSIGNING FIELD-SYMBOL(<fs_val>).

        IF iv_mrp_operation = 'I' OR ( iv_mrp_operation = 'U' AND <fs_val>-action = 'Insert' ) .
          IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
            DATA(lv_flag) = 'X'.
          ENDIF.

        ELSEIF iv_mrp_operation = 'U'.
          IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
            LOOP AT lt_markforchange INTO DATA(ls_markforchage).
              IF ls_markforchage = 'priceDeterminationControl'.
                lv_flag = 'X'.
                EXIT.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.

*          IF iv_mrp_operation = 'U'.
*              IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
*                SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
*                LOOP AT lt_markforchange INTO DATA(ls_markforchage).
*                  IF ls_markforchage = 'priceDeterminationControl'.
*                    DATA(lv_flag) = 'X'.
*                    EXIT.
*                  ENDIF.
*                ENDLOOP.
*              ENDIF.
*          ELSEIF iv_mrp_operation = 'I'.
*            if <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
*              lv_flag = 'X'.
*            endif.
*          ENDIF.

        LOOP AT <fs_val>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlacc>).
*    **            Check if ckml tables are required.
          CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
            EXPORTING
              l_matnr        = ''
              l_bwtar        = ''
              l_bwkey        = <fs_mlacc>-valuationarea
              l_bwtty        = ''
              l_mtart        = ls_mara-mtart
            EXCEPTIONS
              no_ml_records  = 1
              only_ckmlpr    = 2
              internal_error = 3
              OTHERS         = 4.

          CHECK sy-subrc = 0 OR sy-subrc = 2.

          READ TABLE <fs_val>-to_mlprices ASSIGNING FIELD-SYMBOL(<fs_mlprice>)
                WITH KEY product = <fs_mlacc>-product valuationarea = <fs_mlacc>-valuationarea
                valuationtype = <fs_mlacc>-valuationtype currencyrole = <fs_mlacc>-currencyrole.

          IF <fs_val>-valuationcategory IS INITIAL
            OR ( <fs_val>-valuationcategory IS NOT INITIAL AND <fs_val>-valuationtype IS NOT INITIAL ). "For Header record CKMLHD/CR not filled

            CLEAR ls_ckmlhd. CLEAR ls_ckmlhd_x.

            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-valuationaccount
                iv_input_stru    = <fs_mlacc>
              CHANGING
                ev_output_stru   = ls_ckmlhd
                ev_output_stru_x = ls_ckmlhd_x.
            IF <fs_mlprice> IS ASSIGNED.
              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlprices
                  iv_input_stru    = <fs_mlprice>
                CHANGING
                  ev_output_stru   = ls_ckmlhd
                  ev_output_stru_x = ls_ckmlhd_x.
            ENDIF.
            IF ls_ckmlhd-matnr IS INITIAL.
              ls_ckmlhd-matnr = gc_matnr_tmp.
            ENDIF.
            CLEAR ls_ckmlhd_x.


            IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL AND lv_flag = 'X'.
              ls_ckmlhd-mlast = <fs_val>-pricedeterminationcontrol.
              ls_ckmlhd_x-mlast = 'X'.
            ENDIF.
            ls_ckmlhd_x-matnr = ls_ckmlhd-matnr.
            ls_ckmlhd_x-bwtar = ls_ckmlhd-bwtar.
            ls_ckmlhd_x-bwkey = ls_ckmlhd-bwkey.
            READ TABLE cs_data-ckmlhd_tab WITH TABLE KEY matnr = ls_ckmlhd-matnr bwkey = ls_ckmlhd-bwkey bwtar = ls_ckmlhd-bwtar TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_ckmlhd INTO TABLE cs_data-ckmlhd_tab.
            ENDIF.
            READ TABLE cs_data-ckmlhd_x_tab WITH TABLE KEY matnr = ls_ckmlhd_x-matnr bwkey = ls_ckmlhd_x-bwkey bwtar = ls_ckmlhd_x-bwtar TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_ckmlhd_x INTO TABLE cs_data-ckmlhd_x_tab.
            ENDIF.

            CLEAR ls_ckmlcr. CLEAR ls_ckmlcr_x.

            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-mlaccount
                iv_input_stru    = <fs_mlacc>
              CHANGING
                ev_output_stru   = ls_ckmlcr
                ev_output_stru_x = ls_ckmlcr_x.
            IF <fs_mlprice> IS ASSIGNED.
              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlprices
                  iv_input_stru    = <fs_mlprice>
                CHANGING
                  ev_output_stru   = ls_ckmlcr
                  ev_output_stru_x = ls_ckmlcr_x.
            ENDIF.
            IF ls_ckmlcr-matnr IS INITIAL.
              ls_ckmlcr-matnr = gc_matnr_tmp.
            ENDIF.
            ls_ckmlcr_x-matnr = ls_ckmlcr-matnr.
            ls_ckmlcr_x-bwtar = ls_ckmlcr-bwtar.
            ls_ckmlcr_x-bwkey = ls_ckmlcr-bwkey.
            ls_ckmlcr_x-curtp = ls_ckmlcr-curtp.
            READ TABLE cs_data-ckmlcr_tab WITH KEY matnr = ls_ckmlcr-matnr bwkey = ls_ckmlcr-bwkey bwtar = ls_ckmlcr-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_ckmlcr INTO TABLE cs_data-ckmlcr_tab.
            ENDIF.
            READ TABLE cs_data-ckmlcr_x_tab WITH KEY matnr = ls_ckmlcr_x-matnr bwkey = ls_ckmlcr_x-bwkey bwtar = ls_ckmlcr_x-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
            IF sy-subrc <> 0.
              INSERT ls_ckmlcr_x INTO TABLE cs_data-ckmlcr_x_tab.
            ENDIF.

            IF <fs_val>-to_mlprices IS INITIAL.
              CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.

              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlaccount
                  iv_input_stru    = <fs_mlacc>
                CHANGING
                  ev_output_stru   = ls_ckmlpr
                  ev_output_stru_x = ls_ckmlpr_x.
              IF <fs_mlprice> IS ASSIGNED.
                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlprices
                    iv_input_stru    = <fs_mlprice>
                  CHANGING
                    ev_output_stru   = ls_ckmlpr
                    ev_output_stru_x = ls_ckmlpr_x.
              ENDIF.
              IF ls_ckmlpr-matnr IS INITIAL.
                ls_ckmlpr-matnr = gc_matnr_tmp.
              ENDIF.
              ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
              ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
              ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
              ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

              IF ls_ckmlpr-peinh IS INITIAL.
                ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
                ls_ckmlpr_x-peinh = abap_true.
              ENDIF.

              READ TABLE cs_data-ckmlpr_tab WITH TABLE KEY matnr = ls_ckmlpr-matnr bwkey = ls_ckmlpr-bwkey bwtar = ls_ckmlpr-bwtar curtp = ls_ckmlpr-curtp TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
                CLEAR: ls_ckmlpr.
              ENDIF.
              READ TABLE cs_data-ckmlpr_x_tab WITH TABLE KEY matnr = ls_ckmlpr_x-matnr bwkey = ls_ckmlpr_x-bwkey bwtar = ls_ckmlpr_x-bwtar curtp = ls_ckmlpr_x-curtp TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
                CLEAR: ls_ckmlpr_x.
              ENDIF.
            ENDIF.
          ENDIF.
          CLEAR lv_flag.
        ENDLOOP.

        LOOP AT <fs_val>-to_mlprices ASSIGNING FIELD-SYMBOL(<fs_mlpr>).
          " Check if ckml tables are required.
          CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
            EXPORTING
              l_matnr        = ''
              l_bwtar        = ''
              l_bwkey        = <fs_mlpr>-valuationarea
              l_bwtty        = ''
              l_mtart        = ls_mara-mtart
            EXCEPTIONS
              no_ml_records  = 1
              only_ckmlpr    = 2
              internal_error = 3
              OTHERS         = 4.

          CHECK sy-subrc = 0 OR sy-subrc = 2.

          READ TABLE <fs_val>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlac>)
              WITH KEY product = <fs_mlpr>-product valuationarea = <fs_mlpr>-valuationarea
              valuationtype = <fs_mlpr>-valuationtype currencyrole = <fs_mlpr>-currencyrole.

          IF <fs_mlac> IS ASSIGNED.
            CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-mlaccount
                iv_input_stru    = <fs_mlac>
              CHANGING
                ev_output_stru   = ls_ckmlpr
                ev_output_stru_x = ls_ckmlpr_x.
          ENDIF.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name   = gc_entity-mlprices
              iv_input_stru    = <fs_mlpr>
            CHANGING
              ev_output_stru   = ls_ckmlpr
              ev_output_stru_x = ls_ckmlpr_x.
*            ENDIF.
          IF ls_ckmlpr-matnr IS INITIAL.
            ls_ckmlpr-matnr = gc_matnr_tmp.
          ENDIF.
          ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
          ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
          ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
          ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

          IF ls_ckmlpr-peinh IS INITIAL.
            ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
            ls_ckmlpr_x-peinh = abap_true.
          ENDIF.

          INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
          INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
          CLEAR: ls_ckmlpr, ls_ckmlpr_x.
        ENDLOOP.

      ENDLOOP.
    ELSEIF iv_mrp_operation = 'U'.

      LOOP AT ct_valuation_data ASSIGNING <fs_val>.
        IF iv_mrp_operation = 'I' OR ( iv_mrp_operation = 'U' AND <fs_val>-action = 'Insert' ) .
          IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
            lv_flag = 'X'.
          ENDIF.

        ELSEIF iv_mrp_operation = 'U'.
          IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
            SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
            LOOP AT lt_markforchange INTO ls_markforchage.
              IF ls_markforchage = 'priceDeterminationControl'.
                lv_flag = 'X'.
                EXIT.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.
        CLEAR lt_markforchange.

        DATA(l_flag) = ''.
        IF <fs_val>-action <> 'Insert' AND <fs_val>-mdgmarkforchange IS INITIAL.
          LOOP AT <fs_val>-to_mlaccount ASSIGNING <fs_mlacc>.
            IF <fs_mlacc>-action <> 'Insert' AND <fs_mlacc>-mdgmarkforchange IS INITIAL.
              READ TABLE <fs_val>-to_mlprices ASSIGNING <fs_mlprice>
                WITH KEY product      = <fs_mlacc>-product
                        valuationarea = <fs_mlacc>-valuationarea
                        valuationtype = <fs_mlacc>-valuationtype
                        currencyrole  = <fs_mlacc>-currencyrole.
              IF sy-subrc = 0.
                IF <fs_mlprice>-action <> 'Insert' AND <fs_mlprice>-mdgmarkforchange IS INITIAL.



                ELSE.
                  l_flag = 'X'.
                ENDIF.
              ENDIF.
            ELSE.
              l_flag = 'X'.
            ENDIF.
          ENDLOOP.
        ELSE.
          l_flag = 'X'.
        ENDIF.
        IF <fs_val>-action = 'Insert'.
          LOOP AT <fs_val>-to_mlaccount ASSIGNING <fs_mlacc>.
*    **            Check if ckml tables are required.
            CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
              EXPORTING
                l_matnr        = ''
                l_bwtar        = ''
                l_bwkey        = <fs_mlacc>-valuationarea
                l_bwtty        = ''
                l_mtart        = ls_mara-mtart
              EXCEPTIONS
                no_ml_records  = 1
                only_ckmlpr    = 2
                internal_error = 3
                OTHERS         = 4.

            CHECK sy-subrc = 0 OR sy-subrc = 2.

            READ TABLE <fs_val>-to_mlprices ASSIGNING <fs_mlprice>
                  WITH KEY product = <fs_mlacc>-product valuationarea = <fs_mlacc>-valuationarea
                  valuationtype = <fs_mlacc>-valuationtype currencyrole = <fs_mlacc>-currencyrole.

            IF <fs_val>-valuationcategory IS INITIAL
              OR ( <fs_val>-valuationcategory IS NOT INITIAL AND <fs_val>-valuationtype IS NOT INITIAL ). "For Header record CKMLHD/CR not filled

              CLEAR ls_ckmlhd. CLEAR ls_ckmlhd_x.

              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-valuationaccount
                  iv_input_stru    = <fs_mlacc>
                CHANGING
                  ev_output_stru   = ls_ckmlhd
                  ev_output_stru_x = ls_ckmlhd_x.
              IF <fs_mlprice> IS ASSIGNED.
                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlprices
                    iv_input_stru    = <fs_mlprice>
                  CHANGING
                    ev_output_stru   = ls_ckmlhd
                    ev_output_stru_x = ls_ckmlhd_x.
              ENDIF.
              IF ls_ckmlhd-matnr IS INITIAL.
                ls_ckmlhd-matnr = gc_matnr_tmp.
              ENDIF.
              IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL AND lv_flag = 'X'.
                ls_ckmlhd-mlast = <fs_val>-pricedeterminationcontrol.
                ls_ckmlhd_x-mlast = 'X'.
              ENDIF.
              ls_ckmlhd_x-matnr = ls_ckmlhd-matnr.
              ls_ckmlhd_x-bwtar = ls_ckmlhd-bwtar.
              ls_ckmlhd_x-bwkey = ls_ckmlhd-bwkey.
              READ TABLE cs_data-ckmlhd_tab WITH TABLE KEY matnr = ls_ckmlhd-matnr bwkey = ls_ckmlhd-bwkey bwtar = ls_ckmlhd-bwtar TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlhd INTO TABLE cs_data-ckmlhd_tab.
              ENDIF.
              READ TABLE cs_data-ckmlhd_x_tab WITH TABLE KEY matnr = ls_ckmlhd_x-matnr bwkey = ls_ckmlhd_x-bwkey bwtar = ls_ckmlhd_x-bwtar TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlhd_x INTO TABLE cs_data-ckmlhd_x_tab.
              ENDIF.

              CLEAR ls_ckmlcr. CLEAR ls_ckmlcr_x.

              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlaccount
                  iv_input_stru    = <fs_mlacc>
                CHANGING
                  ev_output_stru   = ls_ckmlcr
                  ev_output_stru_x = ls_ckmlcr_x.
              IF <fs_mlprice> IS ASSIGNED.
                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlprices
                    iv_input_stru    = <fs_mlprice>
                  CHANGING
                    ev_output_stru   = ls_ckmlcr
                    ev_output_stru_x = ls_ckmlcr_x.
              ENDIF.
              IF ls_ckmlcr-matnr IS INITIAL.
                ls_ckmlcr-matnr = gc_matnr_tmp.
              ENDIF.
              ls_ckmlcr_x-matnr = ls_ckmlcr-matnr.
              ls_ckmlcr_x-bwtar = ls_ckmlcr-bwtar.
              ls_ckmlcr_x-bwkey = ls_ckmlcr-bwkey.
              ls_ckmlcr_x-curtp = ls_ckmlcr-curtp.
              READ TABLE cs_data-ckmlcr_tab WITH KEY matnr = ls_ckmlcr-matnr bwkey = ls_ckmlcr-bwkey bwtar = ls_ckmlcr-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlcr INTO TABLE cs_data-ckmlcr_tab.
              ENDIF.
              READ TABLE cs_data-ckmlcr_x_tab WITH KEY matnr = ls_ckmlcr_x-matnr bwkey = ls_ckmlcr_x-bwkey bwtar = ls_ckmlcr_x-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                INSERT ls_ckmlcr_x INTO TABLE cs_data-ckmlcr_x_tab.
              ENDIF.

              IF <fs_val>-to_mlprices IS INITIAL.
                CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.

                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlaccount
                    iv_input_stru    = <fs_mlacc>
                  CHANGING
                    ev_output_stru   = ls_ckmlpr
                    ev_output_stru_x = ls_ckmlpr_x.
                IF <fs_mlprice> IS ASSIGNED.
                  CALL METHOD map_fields
                    EXPORTING
                      iv_entity_name   = gc_entity-mlprices
                      iv_input_stru    = <fs_mlprice>
                    CHANGING
                      ev_output_stru   = ls_ckmlpr
                      ev_output_stru_x = ls_ckmlpr_x.
                ENDIF.
                IF ls_ckmlpr-matnr IS INITIAL.
                  ls_ckmlpr-matnr = gc_matnr_tmp.
                ENDIF.
                ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
                ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
                ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
                ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

                IF ls_ckmlpr-peinh IS INITIAL.
                  ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
                  ls_ckmlpr_x-peinh = abap_true.
                ENDIF.

                READ TABLE cs_data-ckmlpr_tab WITH TABLE KEY matnr = ls_ckmlpr-matnr bwkey = ls_ckmlpr-bwkey bwtar = ls_ckmlpr-bwtar curtp = ls_ckmlpr-curtp TRANSPORTING NO FIELDS.
                IF sy-subrc <> 0.
                  INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
                  CLEAR: ls_ckmlpr.
                ENDIF.
                READ TABLE cs_data-ckmlpr_x_tab WITH TABLE KEY matnr = ls_ckmlpr_x-matnr bwkey = ls_ckmlpr_x-bwkey bwtar = ls_ckmlpr_x-bwtar curtp = ls_ckmlpr_x-curtp TRANSPORTING NO FIELDS.
                IF sy-subrc <> 0.
                  INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
                  CLEAR: ls_ckmlpr_x.
                ENDIF.
              ENDIF.
            ENDIF.
            CLEAR lv_flag.
          ENDLOOP.

          LOOP AT <fs_val>-to_mlprices ASSIGNING <fs_mlpr>.
            " Check if ckml tables are required.
            CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
              EXPORTING
                l_matnr        = ''
                l_bwtar        = ''
                l_bwkey        = <fs_mlpr>-valuationarea
                l_bwtty        = ''
                l_mtart        = ls_mara-mtart
              EXCEPTIONS
                no_ml_records  = 1
                only_ckmlpr    = 2
                internal_error = 3
                OTHERS         = 4.

            CHECK sy-subrc = 0 OR sy-subrc = 2.

            READ TABLE <fs_val>-to_mlaccount ASSIGNING <fs_mlac>
                WITH KEY product = <fs_mlpr>-product valuationarea = <fs_mlpr>-valuationarea
                valuationtype = <fs_mlpr>-valuationtype currencyrole = <fs_mlpr>-currencyrole.

            IF <fs_mlac> IS ASSIGNED.
              CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlaccount
                  iv_input_stru    = <fs_mlac>
                CHANGING
                  ev_output_stru   = ls_ckmlpr
                  ev_output_stru_x = ls_ckmlpr_x.
            ENDIF.
            CALL METHOD map_fields
              EXPORTING
                iv_entity_name   = gc_entity-mlprices
                iv_input_stru    = <fs_mlpr>
              CHANGING
                ev_output_stru   = ls_ckmlpr
                ev_output_stru_x = ls_ckmlpr_x.
*            ENDIF.
            IF ls_ckmlpr-matnr IS INITIAL.
              ls_ckmlpr-matnr = gc_matnr_tmp.
            ENDIF.
            ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
            ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
            ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
            ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

            IF ls_ckmlpr-peinh IS INITIAL.
              ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
              ls_ckmlpr_x-peinh = abap_true.
            ENDIF.

            INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
            INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
            CLEAR: ls_ckmlpr, ls_ckmlpr_x.
          ENDLOOP.

        ELSE.
          IF l_flag = ''.
            LOOP AT <fs_val>-to_mlprices ASSIGNING <fs_mlpr>.
              " Check if ckml tables are required.
              CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
                EXPORTING
                  l_matnr        = ''
                  l_bwtar        = ''
                  l_bwkey        = <fs_mlpr>-valuationarea
                  l_bwtty        = ''
                  l_mtart        = ls_mara-mtart
                EXCEPTIONS
                  no_ml_records  = 1
                  only_ckmlpr    = 2
                  internal_error = 3
                  OTHERS         = 4.

              CHECK sy-subrc = 0 OR sy-subrc = 2.

              READ TABLE <fs_val>-to_mlaccount ASSIGNING <fs_mlac>
                  WITH KEY product = <fs_mlpr>-product valuationarea = <fs_mlpr>-valuationarea
                  valuationtype = <fs_mlpr>-valuationtype currencyrole = <fs_mlpr>-currencyrole.

              IF <fs_mlac> IS ASSIGNED.
                CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlaccount
                    iv_input_stru    = <fs_mlac>
                  CHANGING
                    ev_output_stru   = ls_ckmlpr
                    ev_output_stru_x = ls_ckmlpr_x.
              ENDIF.
              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlprices
                  iv_input_stru    = <fs_mlpr>
                CHANGING
                  ev_output_stru   = ls_ckmlpr
                  ev_output_stru_x = ls_ckmlpr_x.
*            ENDIF.
              IF ls_ckmlpr-matnr IS INITIAL.
                ls_ckmlpr-matnr = gc_matnr_tmp.
              ENDIF.
              CLEAR ls_ckmlpr_x.
              ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
              ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
              ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
              ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

              IF ls_ckmlpr-peinh IS INITIAL.
                ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
*                ls_ckmlpr_x-peinh = abap_true.
              ENDIF.

              INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
              INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
              CLEAR: ls_ckmlpr, ls_ckmlpr_x.
            ENDLOOP.
            CONTINUE.

          ELSE.
            LOOP AT <fs_val>-to_mlaccount ASSIGNING <fs_mlacc>.
*              IF <fs_mlacc>-action <> 'Insert' AND <fs_mlacc>-mdgmarkforchange IS INITIAL.
              READ TABLE <fs_val>-to_mlprices ASSIGNING <fs_mlprice>
                WITH KEY product      = <fs_mlacc>-product
                        valuationarea = <fs_mlacc>-valuationarea
                        valuationtype = <fs_mlacc>-valuationtype
                        currencyrole  = <fs_mlacc>-currencyrole.
              IF sy-subrc = 0.
*                IF <fs_mlprice>-action <> 'Insert' AND <fs_mlprice>-mdgmarkforchange IS INITIAL.
                CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
                  EXPORTING
                    l_matnr        = ''
                    l_bwtar        = ''
                    l_bwkey        = <fs_mlacc>-valuationarea
                    l_bwtty        = ''
                    l_mtart        = ls_mara-mtart
                  EXCEPTIONS
                    no_ml_records  = 1
                    only_ckmlpr    = 2
                    internal_error = 3
                    OTHERS         = 4.

                CHECK sy-subrc = 0 OR sy-subrc = 2.

                READ TABLE <fs_val>-to_mlprices ASSIGNING <fs_mlprice>
                      WITH KEY product = <fs_mlacc>-product valuationarea = <fs_mlacc>-valuationarea
                      valuationtype = <fs_mlacc>-valuationtype currencyrole = <fs_mlacc>-currencyrole.
*
                IF <fs_val>-valuationcategory IS INITIAL
                  OR ( <fs_val>-valuationcategory IS NOT INITIAL AND <fs_val>-valuationtype IS NOT INITIAL ). "For Header record CKMLHD/CR not filled

                  CLEAR ls_ckmlhd. CLEAR ls_ckmlhd_x.

                  CALL METHOD map_fields
                    EXPORTING
                      iv_entity_name   = gc_entity-valuationaccount
                      iv_input_stru    = <fs_mlacc>
                    CHANGING
                      ev_output_stru   = ls_ckmlhd
                      ev_output_stru_x = ls_ckmlhd_x.

                  IF <fs_mlacc>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlacc>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR lt_markforchange_temp.
                  IF <fs_mlprice> IS ASSIGNED.
                    CALL METHOD map_fields
                      EXPORTING
                        iv_entity_name   = gc_entity-mlprices
                        iv_input_stru    = <fs_mlprice>
                      CHANGING
                        ev_output_stru   = ls_ckmlhd
                        ev_output_stru_x = ls_ckmlhd_x.
                  ENDIF.
                  IF <fs_mlprice>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlprice>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR lt_markforchange_temp.
                  CLEAR ls_ckmlhd_x.
                  IF ls_ckmlhd-matnr IS INITIAL.
                    ls_ckmlhd-matnr = gc_matnr_tmp.
                  ENDIF.
                  LOOP AT lt_markforchange INTO DATA(ls_markforchange).


                    DATA(lv_fieldname) = ls_markforchange.

                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-valuationaccount
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.

                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlhd_x TO FIELD-SYMBOL(<ls_field_data>).
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.

                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-mlprices
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.

                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlhd_x TO <ls_field_data>.
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.

                  ENDLOOP.
                  CLEAR lt_markforchange.
                  IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL AND lv_flag = 'X'.
                    ls_ckmlhd_x-mlast = 'X'.
                  ENDIF.
                  ls_ckmlhd-mlast = <fs_val>-pricedeterminationcontrol.
                  ls_ckmlhd_x-matnr = ls_ckmlhd-matnr.
                  ls_ckmlhd_x-bwtar = ls_ckmlhd-bwtar.
                  ls_ckmlhd_x-bwkey = ls_ckmlhd-bwkey.
                  READ TABLE cs_data-ckmlhd_tab WITH TABLE KEY matnr = ls_ckmlhd-matnr bwkey = ls_ckmlhd-bwkey bwtar = ls_ckmlhd-bwtar TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlhd INTO TABLE cs_data-ckmlhd_tab.
                  ENDIF.
                  READ TABLE cs_data-ckmlhd_x_tab WITH TABLE KEY matnr = ls_ckmlhd_x-matnr bwkey = ls_ckmlhd_x-bwkey bwtar = ls_ckmlhd_x-bwtar TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlhd_x INTO TABLE cs_data-ckmlhd_x_tab.
                  ENDIF.

                  CLEAR ls_ckmlcr. CLEAR ls_ckmlcr_x.

                  CALL METHOD map_fields
                    EXPORTING
                      iv_entity_name   = gc_entity-mlaccount
                      iv_input_stru    = <fs_mlacc>
                    CHANGING
                      ev_output_stru   = ls_ckmlcr
                      ev_output_stru_x = ls_ckmlcr_x.
                  IF <fs_mlacc>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlacc>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR lt_markforchange_temp.
                  IF <fs_mlprice> IS ASSIGNED.
                    CALL METHOD map_fields
                      EXPORTING
                        iv_entity_name   = gc_entity-mlprices
                        iv_input_stru    = <fs_mlprice>
                      CHANGING
                        ev_output_stru   = ls_ckmlcr
                        ev_output_stru_x = ls_ckmlcr_x.
                  ENDIF.
                  IF <fs_mlprice>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlprice>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR lt_markforchange_temp.

                  IF ls_ckmlcr-matnr IS INITIAL.
                    ls_ckmlcr-matnr = gc_matnr_tmp.
                  ENDIF.
                  CLEAR ls_ckmlcr_x.
                  LOOP AT lt_markforchange INTO ls_markforchange.
                    lv_fieldname = ls_markforchange.
                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-mlaccount
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.
                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlcr_x TO <ls_field_data>.
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.

                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-mlprices
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.
                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlcr_x TO <ls_field_data>.
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.
                    IF to_upper( ls_markforchange ) = 'PRICEUNITQTY'.
                      ls_ckmlcr_x-stprs = 'X'.
                    ENDIF.

                  ENDLOOP.
                  CLEAR lt_markforchange.
                  ls_ckmlcr_x-matnr = ls_ckmlcr-matnr.
                  ls_ckmlcr_x-bwtar = ls_ckmlcr-bwtar.
                  ls_ckmlcr_x-bwkey = ls_ckmlcr-bwkey.
                  ls_ckmlcr_x-curtp = ls_ckmlcr-curtp.
                  ls_ckmlcr_x-peinh = 'X'.
                  ls_ckmlcr_x-stprs = 'X'.
                  ls_ckmlcr_x-pvprs = 'X'.
                  READ TABLE cs_data-ckmlcr_tab WITH KEY matnr = ls_ckmlcr-matnr bwkey = ls_ckmlcr-bwkey bwtar = ls_ckmlcr-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlcr INTO TABLE cs_data-ckmlcr_tab.
                  ENDIF.
                  READ TABLE cs_data-ckmlcr_x_tab WITH KEY matnr = ls_ckmlcr_x-matnr bwkey = ls_ckmlcr_x-bwkey bwtar = ls_ckmlcr_x-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlcr_x INTO TABLE cs_data-ckmlcr_x_tab.
                  ENDIF.

*                    IF <fs_val>-to_mlprices IS INITIAL.
                  CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.

                  CALL METHOD map_fields
                    EXPORTING
                      iv_entity_name   = gc_entity-mlaccount
                      iv_input_stru    = <fs_mlacc>
                    CHANGING
                      ev_output_stru   = ls_ckmlpr
                      ev_output_stru_x = ls_ckmlpr_x.

                  IF <fs_mlacc>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlacc>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR lt_markforchange_temp.
                  IF <fs_mlprice> IS ASSIGNED.
                    CALL METHOD map_fields
                      EXPORTING
                        iv_entity_name   = gc_entity-mlprices
                        iv_input_stru    = <fs_mlprice>
                      CHANGING
                        ev_output_stru   = ls_ckmlpr
                        ev_output_stru_x = ls_ckmlpr_x.
                  ENDIF.
                  IF <fs_mlprice>-mdgmarkforchange IS NOT INITIAL.
                    SPLIT <fs_mlprice>-mdgmarkforchange AT  ',' INTO TABLE lt_markforchange_temp.
                  ENDIF.
                  APPEND LINES OF lt_markforchange_temp TO lt_markforchange.
                  CLEAR ls_ckmlpr_x.
                  CLEAR lt_markforchange_temp.
                  IF ls_ckmlpr-matnr IS INITIAL.
                    ls_ckmlpr-matnr = gc_matnr_tmp.
                  ENDIF.
                  LOOP AT lt_markforchange INTO ls_markforchange.
                    lv_fieldname = ls_markforchange.
                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-mlaccount
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.
                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlpr_x TO <ls_field_data>.
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.

                    CALL METHOD _map_field_names
                      EXPORTING
                        iv_node_name = gc_entity-mlprices
                        iv_fieldname = |{ lv_fieldname CASE = UPPER }|
                      IMPORTING
                        ev_field     = lv_table_fieldname.
                    ASSIGN COMPONENT lv_table_fieldname OF STRUCTURE ls_ckmlpr_x TO <ls_field_data>.
                    IF <ls_field_data> IS ASSIGNED.
                      <ls_field_data> = abap_true.
                    ENDIF.
                    IF to_upper( ls_markforchange ) = 'PRICEUNITQTY'.
                      ls_ckmlcr_x-stprs = 'X'.
                    ENDIF.
                  ENDLOOP.
                  CLEAR lt_markforchange.
                  ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
                  ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
                  ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
                  ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.
                  ls_ckmlpr_x-peinh = 'X'.
                  IF ls_ckmlpr-peinh IS INITIAL.
                    ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
                    ls_ckmlpr_x-peinh = abap_true.
                  ENDIF.

                  READ TABLE cs_data-ckmlpr_tab WITH TABLE KEY matnr = ls_ckmlpr-matnr bwkey = ls_ckmlpr-bwkey bwtar = ls_ckmlpr-bwtar curtp = ls_ckmlpr-curtp TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
                    CLEAR: ls_ckmlpr.
                  ENDIF.
                  READ TABLE cs_data-ckmlpr_x_tab WITH TABLE KEY matnr = ls_ckmlpr_x-matnr bwkey = ls_ckmlpr_x-bwkey bwtar = ls_ckmlpr_x-bwtar curtp = ls_ckmlpr_x-curtp TRANSPORTING NO FIELDS.
                  IF sy-subrc <> 0.
                    INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
                    CLEAR: ls_ckmlpr_x.
                  ENDIF.
*                    ENDIF.
                ENDIF.
                CLEAR lv_flag.

*
*

              ENDIF.

            ENDLOOP.
            LOOP AT <fs_val>-to_mlprices ASSIGNING <fs_mlpr>.
              " Check if ckml tables are required.
              CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
                EXPORTING
                  l_matnr        = ''
                  l_bwtar        = ''
                  l_bwkey        = <fs_mlpr>-valuationarea
                  l_bwtty        = ''
                  l_mtart        = ls_mara-mtart
                EXCEPTIONS
                  no_ml_records  = 1
                  only_ckmlpr    = 2
                  internal_error = 3
                  OTHERS         = 4.

              CHECK sy-subrc = 0 OR sy-subrc = 2.

              READ TABLE <fs_val>-to_mlaccount ASSIGNING <fs_mlac>
                  WITH KEY product = <fs_mlpr>-product valuationarea = <fs_mlpr>-valuationarea
                  valuationtype = <fs_mlpr>-valuationtype currencyrole = <fs_mlpr>-currencyrole.

              IF <fs_mlac> IS ASSIGNED.
                CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
                CALL METHOD map_fields
                  EXPORTING
                    iv_entity_name   = gc_entity-mlaccount
                    iv_input_stru    = <fs_mlac>
                  CHANGING
                    ev_output_stru   = ls_ckmlpr
                    ev_output_stru_x = ls_ckmlpr_x.
              ENDIF.
              CALL METHOD map_fields
                EXPORTING
                  iv_entity_name   = gc_entity-mlprices
                  iv_input_stru    = <fs_mlpr>
                CHANGING
                  ev_output_stru   = ls_ckmlpr
                  ev_output_stru_x = ls_ckmlpr_x.
*            ENDIF.
              IF ls_ckmlpr-matnr IS INITIAL.
                ls_ckmlpr-matnr = gc_matnr_tmp.
              ENDIF.
              ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
              ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
              ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
              ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.

              IF ls_ckmlpr-peinh IS INITIAL.
                ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
                ls_ckmlpr_x-peinh = abap_true.
              ENDIF.

              INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
              INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
              CLEAR: ls_ckmlpr, ls_ckmlpr_x.
            ENDLOOP.
          ENDIF.

        ENDIF.

      ENDLOOP.


*          IF iv_mrp_operation = 'U'.
*              IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
*                SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
*                LOOP AT lt_markforchange INTO DATA(ls_markforchage).
*                  IF ls_markforchage = 'priceDeterminationControl'.
*                    DATA(lv_flag) = 'X'.
*                    EXIT.
*                  ENDIF.
*                ENDLOOP.
*              ENDIF.
*          ELSEIF iv_mrp_operation = 'I'.
*            if <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
*              lv_flag = 'X'.
*            endif.
*          ENDIF.
*         ENDIF.
*      ENDLOOP.
    ENDIF.
*     DATA:
*      ls_ckmlhd                     TYPE cmd_bs_mat_s_mla_ckmlhd,
*      ls_ckmlhd_x                   TYPE cmd_bs_mat_s_mla_ckmlhd_x,
*      ls_ckmlcr                     TYPE cmd_bs_mat_s_mla_ckmlcr,
*      ls_ckmlcr_x                   TYPE cmd_bs_mat_s_mla_ckmlcr_x,
*      ls_ckmlpr                     TYPE cmd_bs_mat_s_mla_ckmlpr,
*      ls_ckmlpr_x                   TYPE cmd_bs_mat_s_mla_ckmlpr_x,
*      iv_ckml_neccessary_check_done TYPE boolean VALUE abap_false,
*      iv_ckml_neccessary_subrc      LIKE sy-subrc,
*      ls_mara                       TYPE mara,
*      lv_product                    TYPE mara-matnr.
*
*    CHECK ct_valuation_data IS NOT INITIAL.
*
*    IF ct_valuation_data[ 1 ]-product IS NOT INITIAL.
*
*      lv_product = ct_valuation_data[ 1 ]-product.
*
*    ELSEIF ct_valuation_data[ 1 ]-to_valuationaccount-product IS NOT INITIAL.
*
*      lv_product = ct_valuation_data[ 1 ]-to_valuationaccount-product.
*
*    ELSEIF ct_valuation_data[ 1 ]-to_mlaccount IS NOT INITIAL
*            AND ct_valuation_data[ 1 ]-to_mlaccount[ 1 ]-product IS NOT INITIAL.
*
*      lv_product = ct_valuation_data[ 1 ]-to_mlaccount[ 1 ]-product.
*
*    ELSEIF ct_valuation_data[ 1 ]-to_mlprices IS NOT INITIAL
*            AND ct_valuation_data[ 1 ]-to_mlprices[ 1 ]-product IS NOT INITIAL.
*
*      lv_product = ct_valuation_data[ 1 ]-to_mlprices[ 1 ]-product.
*    ENDIF.
*
*    CALL FUNCTION 'MARA_SINGLE_READ'
*      EXPORTING
*        matnr             = lv_product
*      IMPORTING
*        wmara             = ls_mara
*      EXCEPTIONS
*        lock_on_material  = 1
*        lock_system_error = 2
*        wrong_call        = 3
*        not_found         = 4
*        OTHERS            = 5.
*    IF sy-subrc <> 0.
** Implement suitable error handling here
*    ENDIF.
*    DATA lt_markforchange TYPE TABLE OF string.
*    LOOP AT ct_valuation_data ASSIGNING FIELD-SYMBOL(<fs_val>).
*
*      IF iv_mrp_operation = 'I' or ( iv_mrp_operation = 'U' and <fs_val>-action = 'Insert' ) .
*        if <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
*          DATA(lv_flag) = 'X'.
*        endif.
*
*      ELSEIF iv_mrp_operation = 'U'.
*        IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
*            SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
*            LOOP AT lt_markforchange INTO DATA(ls_markforchage).
*              IF ls_markforchage = 'priceDeterminationControl'.
*                lv_flag = 'X'.
*                EXIT.
*              ENDIF.
*            ENDLOOP.
*          ENDIF.
*      ENDIF.
*
**      IF iv_mrp_operation = 'U'.
**          IF <fs_val>-mdgmarkforchange IS NOT INITIAL.
**            SPLIT <fs_val>-mdgmarkforchange AT ',' INTO TABLE lt_markforchange.
**            LOOP AT lt_markforchange INTO DATA(ls_markforchage).
**              IF ls_markforchage = 'priceDeterminationControl'.
**                DATA(lv_flag) = 'X'.
**                EXIT.
**              ENDIF.
**            ENDLOOP.
**          ENDIF.
**      ELSEIF iv_mrp_operation = 'I'.
**        if <fs_val>-pricedeterminationcontrol IS NOT INITIAL.
**          lv_flag = 'X'.
**        endif.
**      ENDIF.
*
*      LOOP AT <fs_val>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlacc>).
****            Check if ckml tables are required.
*        CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
*          EXPORTING
*            l_matnr        = ''
*            l_bwtar        = ''
*            l_bwkey        = <fs_mlacc>-valuationarea
*            l_bwtty        = ''
*            l_mtart        = ls_mara-mtart
*          EXCEPTIONS
*            no_ml_records  = 1
*            only_ckmlpr    = 2
*            internal_error = 3
*            OTHERS         = 4.
*
*        CHECK sy-subrc = 0 OR sy-subrc = 2.
*
*        READ TABLE <fs_val>-to_mlprices ASSIGNING FIELD-SYMBOL(<fs_mlprice>)
*              WITH KEY product = <fs_mlacc>-product valuationarea = <fs_mlacc>-valuationarea
*              valuationtype = <fs_mlacc>-valuationtype currencyrole = <fs_mlacc>-currencyrole.
*
*        IF <fs_val>-valuationcategory IS INITIAL
*          OR ( <fs_val>-valuationcategory IS NOT INITIAL AND <fs_val>-valuationtype IS NOT INITIAL ). "For Header record CKMLHD/CR not filled
*
*          CLEAR ls_ckmlhd. CLEAR ls_ckmlhd_x.
*
*          CALL METHOD map_fields
*            EXPORTING
*              iv_entity_name   = gc_entity-valuationaccount
*              iv_input_stru    = <fs_mlacc>
*            CHANGING
*              ev_output_stru   = ls_ckmlhd
*              ev_output_stru_x = ls_ckmlhd_x.
*          IF <fs_mlprice> IS ASSIGNED.
*            CALL METHOD map_fields
*              EXPORTING
*                iv_entity_name   = gc_entity-mlprices
*                iv_input_stru    = <fs_mlprice>
*              CHANGING
*                ev_output_stru   = ls_ckmlhd
*                ev_output_stru_x = ls_ckmlhd_x.
*          ENDIF.
*          IF ls_ckmlhd-matnr IS INITIAL.
*            ls_ckmlhd-matnr = gc_matnr_tmp.
*          ENDIF.
*          IF <fs_val>-pricedeterminationcontrol IS NOT INITIAL AND lv_flag = 'X'.
*            ls_ckmlhd-mlast = <fs_val>-pricedeterminationcontrol.
*            ls_ckmlhd_x-mlast = 'X'.
*          ENDIF.
*          ls_ckmlhd_x-matnr = ls_ckmlhd-matnr.
*          ls_ckmlhd_x-bwtar = ls_ckmlhd-bwtar.
*          ls_ckmlhd_x-bwkey = ls_ckmlhd-bwkey.
*          READ TABLE cs_data-ckmlhd_tab WITH TABLE KEY matnr = ls_ckmlhd-matnr bwkey = ls_ckmlhd-bwkey bwtar = ls_ckmlhd-bwtar TRANSPORTING NO FIELDS.
*          IF sy-subrc <> 0.
*            INSERT ls_ckmlhd INTO TABLE cs_data-ckmlhd_tab.
*          ENDIF.
*          READ TABLE cs_data-ckmlhd_x_tab WITH TABLE KEY matnr = ls_ckmlhd_x-matnr bwkey = ls_ckmlhd_x-bwkey bwtar = ls_ckmlhd_x-bwtar TRANSPORTING NO FIELDS.
*          IF sy-subrc <> 0.
*            INSERT ls_ckmlhd_x INTO TABLE cs_data-ckmlhd_x_tab.
*          ENDIF.
*
*          CLEAR ls_ckmlcr. CLEAR ls_ckmlcr_x.
*
*          CALL METHOD map_fields
*            EXPORTING
*              iv_entity_name   = gc_entity-mlaccount
*              iv_input_stru    = <fs_mlacc>
*            CHANGING
*              ev_output_stru   = ls_ckmlcr
*              ev_output_stru_x = ls_ckmlcr_x.
*          IF <fs_mlprice> IS ASSIGNED.
*            CALL METHOD map_fields
*              EXPORTING
*                iv_entity_name   = gc_entity-mlprices
*                iv_input_stru    = <fs_mlprice>
*              CHANGING
*                ev_output_stru   = ls_ckmlcr
*                ev_output_stru_x = ls_ckmlcr_x.
*          ENDIF.
*          IF ls_ckmlcr-matnr IS INITIAL.
*            ls_ckmlcr-matnr = gc_matnr_tmp.
*          ENDIF.
*          ls_ckmlcr_x-matnr = ls_ckmlcr-matnr.
*          ls_ckmlcr_x-bwtar = ls_ckmlcr-bwtar.
*          ls_ckmlcr_x-bwkey = ls_ckmlcr-bwkey.
*          ls_ckmlcr_x-curtp = ls_ckmlcr-curtp.
*          READ TABLE cs_data-ckmlcr_tab WITH KEY matnr = ls_ckmlcr-matnr bwkey = ls_ckmlcr-bwkey bwtar = ls_ckmlcr-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
*          IF sy-subrc <> 0.
*            INSERT ls_ckmlcr INTO TABLE cs_data-ckmlcr_tab.
*          ENDIF.
*          READ TABLE cs_data-ckmlcr_x_tab WITH KEY matnr = ls_ckmlcr_x-matnr bwkey = ls_ckmlcr_x-bwkey bwtar = ls_ckmlcr_x-bwtar curtp = ls_ckmlcr-curtp TRANSPORTING NO FIELDS.
*          IF sy-subrc <> 0.
*            INSERT ls_ckmlcr_x INTO TABLE cs_data-ckmlcr_x_tab.
*          ENDIF.
*
*          IF <fs_val>-to_mlprices IS INITIAL.
*            CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
*
*            CALL METHOD map_fields
*              EXPORTING
*                iv_entity_name   = gc_entity-mlaccount
*                iv_input_stru    = <fs_mlacc>
*              CHANGING
*                ev_output_stru   = ls_ckmlpr
*                ev_output_stru_x = ls_ckmlpr_x.
*            IF <fs_mlprice> IS ASSIGNED.
*              CALL METHOD map_fields
*                EXPORTING
*                  iv_entity_name   = gc_entity-mlprices
*                  iv_input_stru    = <fs_mlprice>
*                CHANGING
*                  ev_output_stru   = ls_ckmlpr
*                  ev_output_stru_x = ls_ckmlpr_x.
*            ENDIF.
*            IF ls_ckmlpr-matnr IS INITIAL.
*              ls_ckmlpr-matnr = gc_matnr_tmp.
*            ENDIF.
*            ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
*            ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
*            ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
*            ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.
*
*            IF ls_ckmlpr-peinh IS INITIAL.
*              ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
*              ls_ckmlpr_x-peinh = abap_true.
*            ENDIF.
*
*            READ TABLE cs_data-ckmlpr_tab WITH TABLE KEY matnr = ls_ckmlpr-matnr bwkey = ls_ckmlpr-bwkey bwtar = ls_ckmlpr-bwtar curtp = ls_ckmlpr-curtp TRANSPORTING NO FIELDS.
*            IF sy-subrc <> 0.
*              INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
*              CLEAR: ls_ckmlpr.
*            ENDIF.
*            READ TABLE cs_data-ckmlpr_x_tab WITH TABLE KEY matnr = ls_ckmlpr_x-matnr bwkey = ls_ckmlpr_x-bwkey bwtar = ls_ckmlpr_x-bwtar curtp = ls_ckmlpr_x-curtp TRANSPORTING NO FIELDS.
*            IF sy-subrc <> 0.
*              INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
*              CLEAR: ls_ckmlpr_x.
*            ENDIF.
*          ENDIF.
*        ENDIF.
*        CLEAR lv_flag.
*      ENDLOOP.
*
*      LOOP AT <fs_val>-to_mlprices ASSIGNING FIELD-SYMBOL(<fs_mlpr>).
*        " Check if ckml tables are required.
*        CALL FUNCTION 'CKML_F_CKML1_2_NECESSARY'
*          EXPORTING
*            l_matnr        = ''
*            l_bwtar        = ''
*            l_bwkey        = <fs_mlpr>-valuationarea
*            l_bwtty        = ''
*            l_mtart        = ls_mara-mtart
*          EXCEPTIONS
*            no_ml_records  = 1
*            only_ckmlpr    = 2
*            internal_error = 3
*            OTHERS         = 4.
*
*        CHECK sy-subrc = 0 OR sy-subrc = 2.
*
*        READ TABLE <fs_val>-to_mlaccount ASSIGNING FIELD-SYMBOL(<fs_mlac>)
*            WITH KEY product = <fs_mlpr>-product valuationarea = <fs_mlpr>-valuationarea
*            valuationtype = <fs_mlpr>-valuationtype currencyrole = <fs_mlpr>-currencyrole.
*
*        IF <fs_mlac> IS ASSIGNED.
*          CLEAR ls_ckmlpr. CLEAR ls_ckmlpr_x.
*          CALL METHOD map_fields
*            EXPORTING
*              iv_entity_name   = gc_entity-mlaccount
*              iv_input_stru    = <fs_mlac>
*            CHANGING
*              ev_output_stru   = ls_ckmlpr
*              ev_output_stru_x = ls_ckmlpr_x.
*        ENDIF.
*        CALL METHOD map_fields
*          EXPORTING
*            iv_entity_name   = gc_entity-mlprices
*            iv_input_stru    = <fs_mlpr>
*          CHANGING
*            ev_output_stru   = ls_ckmlpr
*            ev_output_stru_x = ls_ckmlpr_x.
**        ENDIF.
*        IF ls_ckmlpr-matnr IS INITIAL.
*          ls_ckmlpr-matnr = gc_matnr_tmp.
*        ENDIF.
*        ls_ckmlpr_x-matnr = ls_ckmlpr-matnr.
*        ls_ckmlpr_x-bwtar = ls_ckmlpr-bwtar.
*        ls_ckmlpr_x-bwkey = ls_ckmlpr-bwkey.
*        ls_ckmlpr_x-curtp = ls_ckmlpr-curtp.
*
*        IF ls_ckmlpr-peinh IS INITIAL.
*          ls_ckmlpr-peinh   = <fs_val>-priceunitqty.
*          ls_ckmlpr_x-peinh = abap_true.
*        ENDIF.
*
*        INSERT ls_ckmlpr INTO TABLE cs_data-ckmlpr_tab.
*        INSERT ls_ckmlpr_x INTO TABLE cs_data-ckmlpr_x_tab.
*        CLEAR: ls_ckmlpr, ls_ckmlpr_x.
*      ENDLOOP.
*
*    ENDLOOP.
  ENDMETHOD.


  METHOD _execute_api.

    TYPES:
      BEGIN OF lty_blockmessage,
        id     TYPE symsgid,
        number TYPE symsgno,
      END OF lty_blockmessage.

    DATA:
      lt_valuation_comb TYPE /simple/prd_val_t, "/simple/prd_val_t,
      lt_message        TYPE bapiret2_t.

    DATA:
      lv_retry_time     TYPE i,
      lv_retry_count    TYPE i,
      lv_passed_blocked TYPE abap_bool,
      lt_blockmessage   TYPE STANDARD TABLE OF lty_blockmessage,
      ls_blockmessage   TYPE lty_blockmessage.
*      ls_simplemdg_conf TYPE /simple/mdg_conf.

    CONSTANTS:
      lc_prd_message TYPE char10 VALUE 'PRODUCTMSG'.

    CLEAR lt_valuation_comb[].
    lt_valuation_comb = CORRESPONDING #( DEEP gs_data-to_valuation ).

    IF to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION'
    OR to_upper( gs_data-actionmode ) = 'BACKGROUND'.

      CALL FUNCTION '/SIMPLE/FM_PRODUCT_SAVE'
        EXPORTING
          is_mat            = gs_mat
          iv_mrp_operation  = iv_mrp_operation
          iv_mdglogid       = gs_data-mdglogid
          iv_background     = 'X'
          iv_test_mode      = gv_testrun
          it_qmat_ins       = gt_qmat_ins
          it_qmat_upd       = gt_qmat_upd
          it_qmat_del       = gt_qmat_del
          it_qmat_x         = gt_qmat_x
          it_valuation      = lt_valuation_comb
          it_classification = gt_classification
        IMPORTING
          ev_product        = gv_product
          ev_status         = gv_status
          ev_step           = gv_step
        TABLES
          et_message        = lt_message.
    ELSE.
      CALL FUNCTION '/SIMPLE/FM_PRODUCT_SAVE'
        EXPORTING
          is_mat            = gs_mat
          iv_mrp_operation  = iv_mrp_operation
          iv_mdglogid       = gs_data-mdglogid
          iv_activateid     = gs_data-activateid
          iv_activateitemid = gs_data-activateitemid
          iv_background     = ''
          iv_test_mode      = gv_testrun
          it_qmat_ins       = gt_qmat_ins
          it_qmat_upd       = gt_qmat_upd
          it_qmat_del       = gt_qmat_del
          it_qmat_x         = gt_qmat_x
          it_valuation      = lt_valuation_comb
          it_classification = gt_classification
        IMPORTING
          ev_product        = gv_product
          ev_status         = gv_status
          ev_step           = gv_step
        TABLES
          et_message        = lt_message.
    ENDIF.
    APPEND LINES OF lt_message TO gt_message.

**   Get blocked message from SIMPLEMDG CONFIG table
*    SELECT SINGLE * FROM /simple/mdg_conf
*      INTO ls_simplemdg_conf
*      WHERE fieldname = lc_prd_message.
*    IF sy-subrc = 0.
*
*      DATA:
*        lv_string TYPE string,
*        lv_pos    TYPE i,
*        lt_split  TYPE TABLE OF string,
*        ls_split  TYPE string.
*
*      lv_string  = ls_simplemdg_conf-fieldvalue.
*
*      SPLIT lv_string AT ',' INTO TABLE lt_split.
*
*      LOOP AT lt_split INTO ls_split.
*        SEARCH ls_split FOR '/'.
*        IF sy-fdpos IS NOT INITIAL.
*          CLEAR ls_blockmessage.
*
*          lv_pos  = sy-fdpos - 1.
*          ls_blockmessage-id = ls_split(sy-fdpos).
*
*          lv_pos  = sy-fdpos + 1.
*          ls_blockmessage-number = ls_split+sy-fdpos.
*
*          APPEND ls_blockmessage TO lt_blockmessage.
*        ENDIF.
*      ENDLOOP.
*    ENDIF.
**   Get blocked message from SIMPLEMDG CONFIG table
*
**   Check if return message contain blocked message
*    lv_passed_blocked = abap_true.
*    IF lt_blockmessage IS NOT INITIAL
*    AND gt_message IS NOT INITIAL.
*      LOOP AT lt_blockmessage INTO ls_blockmessage.
*        READ TABLE gt_message TRANSPORTING NO FIELDS
*         WITH KEY type   = 'E'
*                  id     = ls_blockmessage-id
*                  number = ls_blockmessage-number.
*        IF sy-subrc = 0.
*          lv_passed_blocked = abap_false.
*          EXIT.
*        ENDIF.
*        CLEAR ls_blockmessage.
*      ENDLOOP.
*    ENDIF.
**   Check if return message contain blocked message
*
**   If it is blocked then re try maximum 5 times
*    IF lv_passed_blocked =  abap_false.
*
*      lv_retry_count = 1.
*      lv_retry_time  = 5.
*      WHILE ( lv_retry_count < 7 AND lv_passed_blocked = abap_false ).
*
*        CLEAR:
*          lt_message,
*          gt_message.
*
*        lv_retry_count = lv_retry_count + 1.
*        WAIT UP TO lv_retry_time SECONDS.
*        lv_retry_time = lv_retry_time + 10.
*        IF to_upper( gs_data-actionmode ) = 'VALIDATION'
*        OR to_upper( gs_data-actionmode ) = ''.
*
*          CALL FUNCTION 'PRODUCT_SAVE' "DESTINATION 'NONE'
*            EXPORTING
*              is_mat            = gs_mat
*              iv_mrp_operation  = iv_mrp_operation
*              iv_mdglogid       = gs_data-mdglogid
*              iv_background     = ''
*              iv_test_mode      = gv_testrun
*              it_qmat_ins       = gt_qmat_ins
*              it_qmat_upd       = gt_qmat_upd
*              it_qmat_del       = gt_qmat_del
*              it_qmat_x         = gt_qmat_x
*              it_valuation      = lt_valuation_comb
*              it_classification = gt_classification
*            IMPORTING
*              ev_product        = gv_product
*            TABLES
*              et_message        = lt_message.
*          APPEND LINES OF lt_message TO gt_message.
*        ELSE.
**            CALL FUNCTION 'PRODUCT_SAVE' "DESTINATION 'NONE'
**              EXPORTING
**                is_mat            = gs_mat
**                iv_mrp_operation  = iv_mrp_operation
**                iv_mdglogid       = gs_data-mdglogid
**                iv_background     = ''
**                iv_test_mode      = gv_testrun
**                it_qmat_ins       = gt_qmat_ins
**                it_qmat_upd       = gt_qmat_upd
**                it_qmat_del       = gt_qmat_del
**                it_qmat_x         = gt_qmat_x
**                it_valuation      = lt_valuation_comb
**                it_classification = gt_classification
**              IMPORTING
**                ev_product        = gv_product
**              TABLES
**                et_message        = lt_message.
**            APPEND LINES OF lt_message TO gt_message.
*        ENDIF.
*
*        lv_passed_blocked = abap_true.
*        IF lt_blockmessage IS NOT INITIAL
*        AND gt_message IS NOT INITIAL.
*          LOOP AT lt_blockmessage INTO ls_blockmessage.
*            READ TABLE gt_message TRANSPORTING NO FIELDS
*             WITH KEY type   = 'E'
*                      id     = ls_blockmessage-id
*                      number = ls_blockmessage-number.
*            IF sy-subrc = 0.
*              lv_passed_blocked = abap_false.
*              lv_retry_time = lv_retry_time + 10.
*              EXIT.
*            ENDIF.
*            CLEAR ls_blockmessage.
*          ENDLOOP.
*        ENDIF.
*      ENDWHILE.
*
*    ENDIF.
**   If it is blocked then re try maximum 5 times
*    CALL FUNCTION 'DEQUEUE_ALL'.


  ENDMETHOD.


  METHOD _execute_change.
    _execute_api( iv_mrp_operation = 'U' ).
  ENDMETHOD.


  METHOD _execute_create.
    _execute_api( iv_mrp_operation = 'I' ).
  ENDMETHOD.


  METHOD _execute_delete.
    _execute_api( iv_mrp_operation = 'D' ).
  ENDMETHOD.


  METHOD _export_messages.

    DATA: lt_return_msgs TYPE STANDARD TABLE OF bapiret2,
          ls_return_msg  LIKE LINE OF lt_return_msgs,
          ls_msg         TYPE symsg,
          is_msg         TYPE symsg.

    CASE iv_error.

      WHEN 'KEYS'.

        ls_return_msg-number = '002'.

      WHEN 'INVALID'.

        ls_return_msg-number = '004'.


      WHEN 'MISMATCH'.

        ls_return_msg-number = '001'.

      WHEN 'UPDATE'.
        ls_return_msg-number = '005'.
        ls_return_msg-message_v1 = gv_product.

      WHEN 'CREATE'.
        ls_return_msg-number = '006'.

      WHEN 'UNSUPPORTED'.
        ls_return_msg-number = '007'.

      WHEN 'NOTALLOWED'.
        ls_return_msg-number = 008.

      WHEN 'MULTIPLE'.
        ls_return_msg-number = 003.

      WHEN 'LEDGER_MISSING'.
        ls_return_msg-number = 010.

      WHEN 'CREATE_NOT_ALLOWED'.
        ls_return_msg-number = 009.

      WHEN 'PUT_NOT_ALLOWED'.
        ls_return_msg-number = 011.

      WHEN 'PATCH_NOT_ALLOWED'.
        ls_return_msg-number = 012.

      WHEN 'KEY_FIELD_INITIAL'.
        ls_return_msg-number = 013.

    ENDCASE.
    IF ls_return_msg IS NOT INITIAL.
      ls_return_msg-id = 'API_PRD_MSG'.
      ls_return_msg-type = 'E'.
      APPEND ls_return_msg TO lt_return_msgs.
    ENDIF.

    LOOP AT it_messages ASSIGNING FIELD-SYMBOL(<fs_message>) WHERE msgty CA 'EAX'.
      CLEAR ls_msg.
      CLEAR is_msg.
      MOVE-CORRESPONDING <fs_message> TO ls_msg.
      _map_messages(
        EXPORTING
          is_msg = ls_msg
        IMPORTING
          es_msg = is_msg
      ).
      ls_return_msg-type = is_msg-msgty.
      ls_return_msg-id = is_msg-msgid.
      ls_return_msg-number = is_msg-msgno.
      ls_return_msg-message_v1 = is_msg-msgv1.
      ls_return_msg-message_v2 = is_msg-msgv2.
      ls_return_msg-message_v3 = is_msg-msgv3.
      ls_return_msg-message_v4 = is_msg-msgv4.
      APPEND ls_return_msg TO lt_return_msgs.
    ENDLOOP.

    APPEND LINES OF lt_return_msgs TO ct_message.
    CLEAR lt_return_msgs.

  ENDMETHOD.


  METHOD _field_validation.
    DATA: ls_msg LIKE LINE OF et_message.

    LOOP AT is_data-ckmlpr_tab ASSIGNING FIELD-SYMBOL(<fs_ckmlpr>).
      IF  <fs_ckmlpr>-zkprs LT 0.
        CLEAR ls_msg.

        ls_msg-msgid = 'MG'.
        ls_msg-msgno = '177'.
        ls_msg-msgty = 'E'.
        ls_msg-msgv1 = 'Future price'.

        APPEND ls_msg TO et_message.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD _get_all_curtp.
    DATA:
      lt_curtp   TYPE TABLE OF cki_ml_cty,
      lv_allowed TYPE boole-boole,
      ls_curr    TYPE gty_curr,
      lt_curr    TYPE gty_t_curr.

    CLEAR:
     et_return,
     et_allcurtp.

    CALL FUNCTION 'GET_BWKEY_CURRENCY_INFO'
      EXPORTING
        bwkey               = iv_bwkey
      TABLES
        t_curtp_for_va      = lt_curtp
      EXCEPTIONS
        bwkey_not_found     = 1
        bwkey_not_active    = 2
        matled_not_found    = 3
        internal_error      = 4
        more_than_3_curtp   = 5
        customizing_changed = 6
        OTHERS              = 7.
    IF sy-subrc <> 0.
      et_return = VALUE #( BASE gt_message
                              ( type       = sy-msgty
                                id         = sy-msgid
                                number     = sy-msgno
                                message_v1 = sy-msgv1
                                message_v2 = sy-msgv2
                                message_v3 = sy-msgv3
                                message_v4 = sy-msgv4 ) ).
    ENDIF.
    CHECK lt_curtp IS NOT INITIAL.
    LOOP AT lt_curtp INTO DATA(ls_curtp).

      CALL FUNCTION 'TP_VALUATION_AUTHORITY'
        EXPORTING
          i_bukrs = iv_bukrs
          i_cvtyp = ls_curtp-curtp
          i_actvt = '02'
        IMPORTING
          e_xauth = lv_allowed.

      IF lv_allowed IS INITIAL.
        CONTINUE.
      ENDIF.
      MOVE-CORRESPONDING ls_curtp TO ls_curr.
      APPEND ls_curr TO lt_curr.
    ENDLOOP.

    DESCRIBE TABLE lt_curr LINES DATA(lv_lines).
    IF lv_lines = 0.
      et_return = VALUE #( BASE gt_message
                                  ( type       = 'E'
                                    id         = 'CKPRCH'
                                    number     = '038'
                                    message_v1 = iv_bukrs ) ).

    ENDIF.
    CHECK et_return IS INITIAL.
    LOOP AT lt_curtp INTO ls_curtp.
      READ TABLE et_allcurtp WITH KEY icurtp = ls_curtp-curtp
        INTO DATA(ls_allcurtp).
      IF sy-subrc <> 0.
        ls_allcurtp-icurtp = ls_curtp-curtp.
        APPEND ls_allcurtp TO et_allcurtp.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD _get_field_info.
    DATA:
      lv_htabname   TYPE dfies-tabname,
      lv_hfieldname TYPE dfies-lfieldname,
      ls_dfies      TYPE dfies.

    CLEAR rv_text.
    SPLIT iv_fieldname AT '-' INTO lv_htabname lv_hfieldname.

    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname    = lv_htabname
        langu      = sy-langu
        lfieldname = lv_hfieldname
      IMPORTING
        dfies_wa   = ls_dfies
      EXCEPTIONS
        OTHERS     = 1.
    IF sy-subrc = 0.
      rv_text = ls_dfies-scrtext_l.
    ENDIF.
  ENDMETHOD.


  METHOD _get_tablefield_info.
    DATA:
      ls_dd02v TYPE dd02v,
      ls_dd04v TYPE dd04v.

    CLEAR rv_text.

    CALL FUNCTION 'DDIF_TABL_GET'
      EXPORTING
        name          = iv_tablefield
        state         = 'A'
        langu         = sy-langu
      IMPORTING
        dd02v_wa      = ls_dd02v
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.
    IF sy-subrc = 0.
      rv_text = ls_dd02v-ddtext.
    ENDIF.

    IF rv_text IS INITIAL.
      CALL FUNCTION 'DDIF_DTEL_GET'
        EXPORTING
          name          = iv_tablefield
          state         = 'A'
          langu         = sy-langu
        IMPORTING
          dd04v_wa      = ls_dd04v
        EXCEPTIONS
          illegal_input = 1
          OTHERS        = 2.
      IF sy-subrc = 0.
        rv_text = ls_dd04v-ddtext.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _handle_uom_rp.
    FIELD-SYMBOLS: <ls_data> TYPE any.
    DATA(ls_mara) = gs_mat-mara_tab[ 1 ].
    DATA(ls_mara_x) = gs_mat-mara_x_tab[ 1 ].
    TRY.
        DATA(ls_marm) = gs_mat-marm_tab[ meinh = ls_mara-meins ].
      CATCH cx_sy_itab_line_not_found.
        CLEAR ls_marm.
    ENDTRY.

    TRY.
        DATA(ls_marm_x) = gs_mat-marm_x_tab[ meinh = ls_mara-meins ].
      CATCH cx_sy_itab_line_not_found.
        CLEAR ls_marm_x.
    ENDTRY.

    READ TABLE gs_data_response-to_productunitsofmeasure ASSIGNING <ls_data>
        WITH KEY alternativeunit = gs_data_response-baseunit.
    IF <ls_data> IS NOT ASSIGNED.
      IF ls_marm-meinh = ls_mara-meins.
        IF ls_marm_x-brgew = '' AND ls_mara_x-brgew = 'X'. "Gross Weight
          ASSIGN COMPONENT 'grossWeight' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_data>).
          IF sy-subrc = 0.
            <lv_data> = ls_mara-brgew.
          ENDIF.
        ENDIF.

        IF ls_marm_x-gewei = '' AND ls_mara_x-gewei = 'X'. "Weight Unit
          ASSIGN COMPONENT 'weightUnit' OF STRUCTURE <ls_data> TO <lv_data>.
          IF sy-subrc = 0.
            <lv_data> = ls_mara-gewei.
          ENDIF.

        ENDIF.
        IF ls_marm_x-volum = '' AND ls_mara_x-volum = 'X'. "Volume
          ASSIGN COMPONENT 'materialVolume' OF STRUCTURE <ls_data> TO <lv_data>.
          IF sy-subrc = 0.
            <lv_data> = ls_mara-volum.
          ENDIF.

        ENDIF.
        IF ls_marm_x-voleh = '' AND ls_mara_x-voleh = 'X'. "Volume Unit
          ASSIGN COMPONENT 'volumeUnit' OF STRUCTURE <ls_data> TO <lv_data>.
          IF sy-subrc = 0.
            <lv_data> = ls_mara-voleh.
          ENDIF.
        ENDIF.
        IF ls_marm_x-ean11 = '' AND ls_mara_x-ean11 = 'X'. "EAN/UPC
          ASSIGN COMPONENT 'globalTradeItemNumber' OF STRUCTURE <ls_data> TO <lv_data>.
          IF sy-subrc = 0.
            <lv_data> = ls_mara-ean11.
          ENDIF.
        ENDIF.

        IF ls_marm_x-numtp = '' AND ls_mara_x-numtp = 'X'. "EAN/UPC
          ASSIGN COMPONENT 'globalTradeItemNumberCategory' OF STRUCTURE <ls_data> TO <lv_data>.
          IF sy-subrc = 0.
            <lv_data> = ls_mara-numtp.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.



  ENDMETHOD.


  METHOD _init.
    gv_mdg = 'X'.
    IF gs_data-actionmode CS 'Validation'
    OR to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION'..
      gv_testrun = 'X'.
    ELSE.
      gv_external_log_no = gs_data-activateid && gs_data-activateitemid.
    ENDIF.
  ENDMETHOD.


  METHOD _kalk_enrich.
    DATA:
      lv_costing_to_release TYPE boole_d.
    LOOP AT ct_matpr ASSIGNING FIELD-SYMBOL(<fs_matpr>).

*   Existiert zu irgendeiner Währung eine Plankalkulation?
      CLEAR lv_costing_to_release.
      LOOP AT <fs_matpr>-cr ASSIGNING FIELD-SYMBOL(<fs_matcr>).
        IF  <fs_matcr>-erzkalk = 'X'.
          lv_costing_to_release = 'X'.
        ENDIF.
      ENDLOOP.
      UNASSIGN <fs_matcr>.
      CHECK NOT lv_costing_to_release IS INITIAL.

*   Übertragen der Tabelle für die zukünftigen Preise
*   aus dem globalen Kontrollblock in die T_MATPR
      READ TABLE it_matcb INTO DATA(ls_wa_matcb)
           WITH TABLE KEY kalnr = <fs_matpr>-pp-kaln1.
      IF sy-subrc EQ 0.
        <fs_matpr>-ckmlpr = ls_wa_matcb-ckmlpr.
      ENDIF.
*   Übertragen der Tabelle für die Kalkulationsdaten
*   aus dem globalen Kontrollblock in die T_MATPR
      READ TABLE it_kekocb INTO DATA(ls_wa_kekocb)
           WITH TABLE KEY kalnr = <fs_matpr>-pp-kaln1.
      IF sy-subrc EQ 0.
        <fs_matpr>-keko = ls_wa_kekocb-keko.
      ENDIF.
    ENDLOOP.
    UNASSIGN <fs_matpr>.
  ENDMETHOD.


  METHOD _map_fieldname_ext.
    CASE iv_fieldname.


      WHEN   'MATNR'.
        ev_fieldname =  'PRODUCTNUMBER'.
      WHEN   'MTART'.
        ev_fieldname =  'PRODUCTTYPE'.
      WHEN   'ERSDA'.
        ev_fieldname =  'CREATIONDATE'.
      WHEN   'ERNAM'.
        ev_fieldname =  'CREATEDBYUSER'.
      WHEN   'LAEDA'.
        ev_fieldname =  'LASTCHANGEDATE'.
      WHEN   'AENAM'.
        ev_fieldname =  'LASTCHANGEDBYUSER'.
      WHEN   'LVORM'.
        ev_fieldname =  'ISMARKEDFORDELETION'.
      WHEN   'MSTAE'.
        ev_fieldname =  'CROSSPLANTSTATUS'.
      WHEN   'MSTDE'.
        ev_fieldname =  'CROSSPLANTSTATUSVALIDITYDATE'.
      WHEN   'BISMT'.
        ev_fieldname =  'PRODUCTOLDID'.
      WHEN   'BRGEW'.
        ev_fieldname =  'GROSSWEIGHT'.
      WHEN   'BSTME'.
        ev_fieldname =  'PURORDERQUANTITYUNIT'.
      WHEN   'GEWEI'.
        ev_fieldname =  'WEIGHTUNIT'.
      WHEN   'HERKL'.
        ev_fieldname =  'COUNTRYOFORIGIN'.
      WHEN   'KUNNR'.
        ev_fieldname =  'COMPETITORID'.
      WHEN   'MATKL'.
        ev_fieldname =  'PRODUCTGROUP'.
      WHEN   'MEINS'.
        ev_fieldname =  'PRODUCTBASEUNIT'.
      WHEN   'MTPOS_MARA'.
        ev_fieldname =  'ITEMCATEGORYGROUP'.
      WHEN   'NTGEW'.
        ev_fieldname =  'NETWEIGHT'.
      WHEN   'PRODH_D'.
        ev_fieldname =  'PRODUCTHIERARCHY'.
      WHEN   'SPART'.
        ev_fieldname =  'PRODUCTDIVISION'.
      WHEN   'VABME'.
        ev_fieldname =  'VARBLPURORDUNITISACTIVE'.
      WHEN   'VOLEH'.
        ev_fieldname =  'VOLUMEUNIT'.
      WHEN   'VOLUM'.
        ev_fieldname =  'MATERIALVOLUME'.
      WHEN   'MSTAV'.
        ev_fieldname =  'SALESSTATUS'.
      WHEN   'TRAGR'.
        ev_fieldname =  'TRANSPORTATIONGROUP'.
      WHEN   'MSTDV'.
        ev_fieldname =  'SALESSTATUSVALIDITYDATE'.
      WHEN   'J_1BANP'.
        ev_fieldname =  'ANPCODE'.
      WHEN   'ATTYP'.
        ev_fieldname =  'PRODCATEGORY'.
      WHEN   'WRF_BRAND_ID'.
        ev_fieldname =  'ProductBRAND'.
      WHEN   'BWVOR'.
        ev_fieldname =  'PROCUREMENTRULE'.
      WHEN   'DATAB'.
        ev_fieldname =  'VALIDITYSTARTDATE'.
      WHEN   'DISST'.
        ev_fieldname =  'LOWLEVELCODE'.
      WHEN   'GENNR'.
        ev_fieldname =  'PRODNOINGENPRODINPREPACKPROD'.
      WHEN   'CIFSERIAL'.
        ev_fieldname =  'SERIALIDENTIFIERASSGMTPROFILE'.
      WHEN   'GROES'.
        ev_fieldname =  'SIZEORDIMENSIONTEXT'.
      WHEN   'NORMT'.
        ev_fieldname =  'INDUSTRYSTANDARDNAME'.
      WHEN   'EAN11'.
        ev_fieldname =  'PRODUCTSTANDARDID'.
      WHEN   'NUMTP'.
        ev_fieldname =  'INTERNATIONALARTICLENUMBERCAT'.
      WHEN   'KZKFG'.
        ev_fieldname =  'PRODUCTISCONFIGURABLE'.
      WHEN   'XCHPF'.
        ev_fieldname =  'ISBATCHMANAGEMENTREQUIRED'.
      WHEN   'EXTWG'.
        ev_fieldname =  'EXTERNALPRODUCTGROUP'.
      WHEN   'SATNR'.
        ev_fieldname =  'CROSSPLANTCONFIGURABLEPRODUCT'.
      WHEN   'SERLV'.
        ev_fieldname =  'SERIALNOEXPLICITNESSLEVEL'.
      WHEN   'MFRPN'.
        ev_fieldname =  'PRODUCTMANUFACTURERNUMBER'.
      WHEN   'MFRNR'.
        ev_fieldname =  'MANUFACTURERNUMBER'.
      WHEN   'MPROF'.
        ev_fieldname =  'MANUFACTURERPARTPROFILE'.
      WHEN   'QMPUR'.
        ev_fieldname =  'QLTYMGMTINPROCMTISACTIVE'.
      WHEN   'PRD_INCL_EEW'.
        ev_fieldname =  'DUMMY_PRD_INCL_EEW_TR'.

      WHEN   'SPRAS'.
        ev_fieldname =  'SPRAS'.
      WHEN   'MAKTX'.
        ev_fieldname =  'PRODUCTDESCRIPTION'.
      WHEN   'MEINH'.
        ev_fieldname =  'ALTERNATIVEUNIT'.
      WHEN   'UMREZ'.
        ev_fieldname =  'QUANTITYNUMERATOR'.
      WHEN   'UMREN'.
        ev_fieldname =  'QUANTITYDENOMINATOR'.
      WHEN   'EKWSL'.
        ev_fieldname =  'PURCHASINGACKNPROFILE'.
      WHEN   'TAKLV'.
        ev_fieldname =  'TAXCLASSIFICATION'.
      WHEN   'RAUBE'.
        ev_fieldname =  'STORAGECONDITIONS'.
      WHEN   'TEMPB'.
        ev_fieldname =  'TEMPERATURECONDITIONIND'.
      WHEN   'STOFF'.
        ev_fieldname =  'HAZARDOUSMATERIALNUMBER'.
      WHEN   'WESCH'.
        ev_fieldname =  'NMBROFGRORGISLIPSTOPRINTQTY'.
      WHEN   'ETIAR'.
        ev_fieldname =  'LABELTYPE'.
      WHEN   'ETIFO'.
        ev_fieldname =  'LABELFORM'.
      WHEN   'MHDRZ'.
        ev_fieldname =  'MINREMAININGSHELFLIFE'.
      WHEN   'SLED_BBD'.
        ev_fieldname =  'EXPIRATIONDATE'.
      WHEN   'BWKEY'.
        ev_fieldname =  'VALUATIONAREA'.
      WHEN   'BWTAR_D'.
        ev_fieldname =  'VALUATIONTYPE'.
      WHEN   'BKLAS'.
        ev_fieldname =  'VALUATIONCLASS'.
      WHEN   'CK_ML_ABST'.
        ev_fieldname =  'PRICEDETERMINATIONCONTROL'.
      WHEN   'CK_ML_MAAC'.
        ev_fieldname =  'MLMAA'.
      WHEN   'VJBKL'.
        ev_fieldname =  'VALUATIONCLASSINPREVYEAR'.
      WHEN   'VMBKL'.
        ev_fieldname =  'VALUATIONCLASSINPREVPERIOD'.
      WHEN   'LFMON'.
        ev_fieldname =  'FISCALMONTHCURRENTPERIOD'.
      WHEN   'LFGJA'.
        ev_fieldname =  'FISCALYEARCURRENTPERIOD'.
      WHEN   'STPRS'.
        ev_fieldname =  'STANDARDPRICE'.
      WHEN   'PEINH'.
        ev_fieldname =  'PRICEUNITQTY'.
      WHEN   'VPRSV'.
        ev_fieldname =  'INVENTORYVALUATIONPROCEDURE'.
      WHEN   'ZKPRS'.
        ev_fieldname =  'FUTUREEVALUATEDAMOUNTVALUE'.
      WHEN   'ZKDAT'.
        ev_fieldname =  'FUTUREPRICEVALIDITYSTARTDATE'.
      WHEN   'LBKUM'.
        ev_fieldname =  'TOTALVALSTOCKQUANTITY'.
      WHEN   'VERPR'.
        ev_fieldname =  'MOVINGAVERAGEPRICE'.
      WHEN   'VMKUM'.
        ev_fieldname =  'TOTALVALSTOCKPREVPERIOD'.
      WHEN   'VMSAL'.
        ev_fieldname =  'TOTALVALSTOCKPREVPERIODVALUE'.
      WHEN   'VJKUM'.
        ev_fieldname =  'TOTALVALSTOCKPREVYEAR'.
      WHEN   'VJSAL'.
        ev_fieldname =  'TOTALVALSTOCKPREVYEARVALUE'.
      WHEN   'BWTTY_D'.
        ev_fieldname =  'VALUATIONCATEGORY'.
      WHEN   'SALK3'.
        ev_fieldname =  'TOTALVALSTOCKVALUE'.
      WHEN   'J_1BMATUSE'.
        ev_fieldname =  'PRODUCTUSAGETYPE'.
      WHEN   'J_1BMATORG'.
        ev_fieldname =  'PRODUCTORIGINTYPE'.
      WHEN   'J_1BOWNPRO'.
        ev_fieldname =  'ISPRODUCEDINHOUSE'.
      WHEN   'OKLAS'.
        ev_fieldname =  'VALNCLSFORSPCLSTKATVNDR'.
      WHEN   'CK_KALNR1'.
        ev_fieldname =  'PRODCOSTESTNUMBER'.
      WHEN   'CK_KALNR'.
        ev_fieldname =  'COSTESTIMATENUMBER'.
      WHEN   'VMVPR'.
        ev_fieldname =  'PRICECTRLINPREVPERIODIND'.
      WHEN   'VMVER'.
        ev_fieldname =  'MOVINGAVGPRICEPREVPERIOD'.
      WHEN   'VMSTP'.
        ev_fieldname =  'STANDARDPRICEPREVPERIOD'.
      WHEN   'VMPEI'.
        ev_fieldname =  'PRICEUNITPREVPERIOD'.
      WHEN   'VJVPR'.
        ev_fieldname =  'PRICECONTROLINPREVYEARIND'.
      WHEN   'VJVER'.
        ev_fieldname =  'MOVINGAVGPRICEPREVYEAR'.
      WHEN   'ABWKZ'.
        ev_fieldname =  'DEVALUATIONYEARCOUNT'.
      WHEN   'VKORG'.
        ev_fieldname =  'PRODUCTSALESORGANIZATION'.
      WHEN   'VTWEG'.
        ev_fieldname =  'PRODUCTDISTRIBUTIONCHANNEL'.
      WHEN   'MINAU'.
        ev_fieldname =  'MINIMUMORDERQUANTITY'.
      WHEN   'DWERK_EXT'.
        ev_fieldname =  'SUPPLYINGPLANT'.
      WHEN   'KONDM'.
        ev_fieldname =  'PRICESPECIFICATIONPRODUCTGROUP'.
      WHEN   'KTGRM'.
        ev_fieldname =  'ACCOUNTDETNPRODUCTGROUP'.
      WHEN   'MINLF'.
        ev_fieldname =  'DELIVERYNOTEPROCMINDELIVQTY'.
      WHEN   'MTPOS'.
        ev_fieldname =  'ITEMCATEGORYGROUP'.
      WHEN   'SCHME'.
        ev_fieldname =  'DELIVERYQUANTITYUNIT'.
      WHEN   'SCHRT'.
        ev_fieldname =  'DELIVERYQUANTITY'.
      WHEN   'VMSTA'.
        ev_fieldname =  'PRODUCTSALESSTATUS'.
      WHEN   'VMSTD'.
        ev_fieldname =  'PRODUCTSALESSTATUSVALIDITYDATE'.
      WHEN   'VRKME'.
        ev_fieldname =  'SALESMEASUREUNIT'.

      WHEN   'MVGR1'.
        ev_fieldname =  'FIRSTSALESSPECPRODUCTGROUP'.
      WHEN   'MVGR2'.
        ev_fieldname =  'SECONDSALESSPECPRODUCTGROUP'.
      WHEN   'MVGR3'.
        ev_fieldname =  'THIRDSALESSPECPRODUCTGROUP'.
      WHEN   'MVGR4'.
        ev_fieldname =  'FOURTHSALESSPECPRODUCTGROUP'.
      WHEN   'MVGR5'.
        ev_fieldname =  'FIFTHSALESSPECPRODUCTGROUP'.
      WHEN   'MINEF'.
        ev_fieldname =  'MINIMUMMAKETOORDERORDERQTY'.
      WHEN   'ALAND'.
        ev_fieldname =  'PRODSOURCELOCATIONCOUNTRY'.
      WHEN   'TATYP'.
        ev_fieldname =  'TAXCLASSIFICATIONCATEGORY'.
      WHEN   'TAXKM'.
        ev_fieldname =  'TAXCLASSIFICATION'.
      WHEN   'MAXLZ'.
        ev_fieldname =  'MAXIMUMSTORAGEPERIOD'.
      WHEN   'KAUTB'.
        ev_fieldname =  'ISAUTOPURORDCREATIONALLOWED'.
      WHEN   'KORDB'.
        ev_fieldname =  'ISSOURCELISTREQUIRED'.
      WHEN   'QSSPUR'.
        ev_fieldname =  'QUALITYMGMTCTRLKEY'.
      WHEN   'LADGR'.
        ev_fieldname =  'LOADINGGROUP'.
      WHEN   'VKUMC'.
        ev_fieldname =  'VKUMC'.
      WHEN   'ABCIN'.
        ev_fieldname =  'INVENTORYFORCYCLECOUNTIND'.
      WHEN   'LGORT'.
        ev_fieldname =  'STORAGELOCATION'.
      WHEN   'LGPBE'.
        ev_fieldname =  'WAREHOUSESTORAGEBIN'.
      WHEN   'PSTAT_D'.
        ev_fieldname =  'MAINTENANCESTATUS'.

      WHEN   'SPERR'.
        ev_fieldname =  'PHYSICALINVENTORYBLOCKIND'.
      WHEN   'DLINL'.
        ev_fieldname =  'DATEOFLASTPOSTEDCNTUNRSTRCDSTK'.
      WHEN   'BSKRF'.
        ev_fieldname =  'INVENTORYCORRECTIONFACTOR'.
      WHEN   'KZILE'.
        ev_fieldname =  'INVTRYRESTRICTEDUSESTOCKIND'.
      WHEN   'KZILL'.
        ev_fieldname =  'INVTRYCURRENTYEARSTOCKIND'.
      WHEN   'KZILQ'.
        ev_fieldname =  'INVTRYQUALINSPCURRENTYRSTKIND'.
      WHEN   'KZILS'.
        ev_fieldname =  'INVENTORYBLOCKSTOCKIND'.
      WHEN   'KZVLE'.
        ev_fieldname =  'INVTRYRESTSTOCKPREVPERIODIND'.
      WHEN   'KZVLL'.
        ev_fieldname =  'INVENTORYSTOCKPREVPERIOD'.
      WHEN   'KZVLQ'.
        ev_fieldname =  'INVTRYSTOCKQLTYINSPPREVPERIOD'.
      WHEN   'KZVLS'.
        ev_fieldname =  'HASINVTRYBLOCKSTOCKPREVPERIOD'.
      WHEN   'GJINV'.
        ev_fieldname =  'FISCALYEARCURRENTINVTRYPERIOD'.
      WHEN   'WERKS_D'.
        ev_fieldname =  'PRODUCTPLANT'.
      WHEN   'EKGRP'.
        ev_fieldname =  'PRODUCTPURCHASINGGROUP'.
      WHEN   'HERKR'.
        ev_fieldname =  'REGIONOFORIGIN'.
      WHEN   'LGPRO'.
        ev_fieldname =  'PRODUCTIONINVTRYMANAGEDLOC'.
      WHEN   'MMSTA'.
        ev_fieldname =  'PROFILECODE'.
      WHEN   'MMSTD'.
        ev_fieldname =  'PROFILEVALIDITYSTARTDATE'.
      WHEN   'MTVFP'.
        ev_fieldname =  'AVAILABILITYCHECKTYPE'.
      WHEN   'PERIV'.
        ev_fieldname =  'FISCALYEARVARIANT'.
      WHEN   'PERIOTYPE'.
        ev_fieldname =  'PERIODINDICATOR'.
      WHEN   'PRCTR'.
        ev_fieldname =  'PROFITCENTER'.
      WHEN   'STAWN'.
        ev_fieldname =  'COMMODITYCODE'.
      WHEN   'WEBAZ'.
        ev_fieldname =  'GOODSRECEIPTDURATION'.

      WHEN   'LVOWK'.
        ev_fieldname =  'ISMARKEDFORDELETIONATPLANT'.
      WHEN   'DISLS'.
        ev_fieldname =  'LOTSIZINGPROCEDURE'.
      WHEN   'DISMM'.
        ev_fieldname =  'MRPTYPE'.
      WHEN   'DISPO'.
        ev_fieldname =  'MRPRESPONSIBLE'.
      WHEN   'MAABC'.
        ev_fieldname =  'ABCINDICATOR'.
      WHEN   'FXHOR'.
        ev_fieldname =  'PLANNINGTIMEFENCE'.
      WHEN   'MINBE'.
        ev_fieldname =  'REORDERTHRESHOLDQUANTITY'.
      WHEN   'EISBE'.
        ev_fieldname =  'SAFETYSTOCKQUANTITY'.
      WHEN   'SHZET'.
        ev_fieldname =  'SAFETYDURATION'.
      WHEN   'EISLO'.
        ev_fieldname =  'MINIMUMSAFETYSTOCKQUANTITY'.

      WHEN   'BSTMI'.
        ev_fieldname =  'MINIMUMLOTSIZEQUANTITY'.
      WHEN   'BSTMA'.
        ev_fieldname =  'MAXIMUMLOTSIZEQUANTITY'.
      WHEN   'BSTFE'.
        ev_fieldname =  'FIXEDLOTSIZEQUANTITY'.
      WHEN   'BSTRF'.
        ev_fieldname =  'LOTSIZEROUNDINGQUANTITY'.
      WHEN   'MABST'.
        ev_fieldname =  'MAXIMUMSTOCKQUANTITY'.
      WHEN   'PLIFZ'.
        ev_fieldname =  'PLANNEDDELIVERYDURATION'.
      WHEN   'STEUC'.
        ev_fieldname =  'CONSUMPTIONTAXCTRLCODE'.
      WHEN   'KZKUPMAT'.
        ev_fieldname =  'ISCOPRODUCT'.
      WHEN   'KZKUP'.
        ev_fieldname =  'ISCOPRODUCT'.
      WHEN   'STDPD'.
        ev_fieldname =  'CONFIGURABLEPRODUCT'.
      WHEN   'BF_GROUP'.
        ev_fieldname =  'STOCKDETERMINATIONGROUP'.
      WHEN   'UMLME'.
        ev_fieldname =  'STOCKINTRANSFERQUANTITY'.
      WHEN   'TRAME'.
        ev_fieldname =  'STOCKINTRANSITQUANTITY'.
      WHEN   'INSMK_MAT'.
        ev_fieldname =  'HASPOSTTOINSPECTIONSTOCK'.
      WHEN   'SERAIL'.
        ev_fieldname =  'SERIALNUMBERPROFILE'.
      WHEN   'XMCNG'.
        ev_fieldname =  'ISNEGATIVESTOCKALLOWED'.
      WHEN   'BWESB'.
        ev_fieldname =  'GOODSRECEIPTBLOCKEDSTOCKQTY'.
      WHEN   'WRF_CONS_PROCG'.
        ev_fieldname =  'HASCONSIGNMENTCTRL'.
      WHEN   'GLGMG'.
        ev_fieldname =  'TIEDEMPTIESSTOCKQUANTITY'.
      WHEN   'WRF_POHF_OTHER_EKGRP_ALLOW'.
        ev_fieldname =  'ISPURGACROSSPURGGROUP'.
      WHEN   'XCHAR'.
        ev_fieldname =  'ISINTERNALBATCHMANAGED'.
      WHEN   'J_1BINDUS3'.
        ev_fieldname =  'PRODUCTCFOPCATEGORY'.
      WHEN 'WMAAB'.
        ev_fieldname = 'VALUATIONMARGIN'.
      WHEN 'WAUSM'.
        ev_fieldname = 'GOODSISSUEUNIT'.
      WHEN 'WHERL'.
        ev_fieldname = 'COUNTRYOFORIGIN'.
      WHEN 'WHERR'.
        ev_fieldname = 'REGIONOFORIGIN'.
      WHEN 'WBKLA'.
        ev_fieldname = 'VALUATIONCLASS'.
      WHEN 'WBWSP'.
        ev_fieldname =  'VALUATIONMARGIN'.
      WHEN 'WVRKM'.
        ev_fieldname = 'SALESUNIT'.
      WHEN 'WLADG'.
        ev_fieldname = 'LOADINGGROUP'.
      WHEN 'BWSCL'.
        ev_fieldname = 'SOURCEOFSUPPLYCATEGORY'.
      WHEN 'WEKGR'.
        ev_fieldname = 'PURCHASINGGROUP'.
      WHEN 'TDSPRAS'.
        ev_fieldname = 'LANGUAGEFOREDIT'.
      WHEN 'TDNAME'.
        ev_fieldname = 'PRODUCTFOREDIT'.
      WHEN 'TDID'.
        ev_fieldname = 'LONGTEXTIDFOREDIT'.
      WHEN 'MULTIPLE_EKGRP'.
        ev_fieldname = 'ISPURGACROSSPURGGROUP'.
      WHEN 'BASMG'.
        ev_fieldname = 'MATERIALBASEQUANTITY'.
      WHEN 'UEETK'.
        ev_fieldname = 'UNLIMITEDOVERDELIVISALLOWED'.
      WHEN 'UEETO'.
        ev_fieldname = 'OVERDELIVTOLERANCELIMIT'.
      WHEN 'UNETO'.
        ev_fieldname = 'UNDERDELIVTOLERANCELIMIT'.
      WHEN 'AUSME'.
        ev_fieldname = 'GOODSISSUEUNIT' .
      WHEN 'EPRIO'.
        ev_fieldname = 'STOCKDETERMINATIONGROUP'.
      WHEN 'FPRFM'.
        ev_fieldname = 'DISTRCNTRDISTRIBUTIONPROFILE'.
      WHEN 'INDUS'.
        ev_fieldname = 'PRODUCTCFOPCATEGORY'.
      WHEN 'MEGRU'.
        ev_fieldname = 'PRODUCTUNITGROUP' .
      WHEN 'PERKZ'.
        ev_fieldname = 'PERIODTYPE'.
      WHEN 'SERNP'.
        ev_fieldname = 'SERIALNUMBERPROFILE'.
      WHEN 'STRGR'.
        ev_fieldname = 'PLANNINGSTRATEGYGROUP'.
      WHEN 'WZEIT'.
        ev_fieldname = 'TOTALREPLENISHMENTLEADTIME'.
      WHEN 'SOBSL'.
        ev_fieldname = 'PROCUREMENTSUBTYPE'.
      WHEN 'AUSSS'.
        ev_fieldname = 'ASSEMBLYSCRAPPERCENT'.
      WHEN 'SSQSS'.
        ev_fieldname = 'QUALITYMGMTCTRLKEY'.
      WHEN 'QMATA'.
        ev_fieldname = 'MATLQUALITYAUTHORIZATIONGROUP'.
      WHEN 'INSMK'.
        ev_fieldname = 'HASPOSTTOINSPECTIONSTOCK'.
      WHEN 'SERVG'.
        ev_fieldname = 'PROVISIONINGSERVICELEVEL'.
      WHEN 'VRBDT'.
        ev_fieldname = 'CONSUMPTIONREFUSAGEENDDATE'.
      WHEN 'VRBFK'.
        ev_fieldname = 'CONSUMPTIONQTYMULTIPLIER'.
      WHEN 'VRBMT'.
        ev_fieldname = 'CONSUMPTIONREFERENCEPRODUCT'.
      WHEN 'VRBWK'.
        ev_fieldname = 'CONSUMPTIONREFERENCEPLANT'.
      WHEN 'MLAST'.
        ev_fieldname =    'PRICEDETERMINATIONCONTROL'.
      WHEN 'BWTTY'.
        ev_fieldname =    'VALUATIONCATEGORY'.
      WHEN 'MTUSE'.
        ev_fieldname =    'PRODUCTUSAGETYPE'.
      WHEN 'MTORG'.
        ev_fieldname =    'PRODUCTORIGINTYPE'.
      WHEN 'OWNPR'.
        ev_fieldname =    'ISPRODUCEDINHOUSE'.
      WHEN 'KALN1'.
        ev_fieldname =    'PRODCOSTESTNUMBER'.
      WHEN 'BWSPA'.
        ev_fieldname =    'VALUATIONMARGIN'.
      WHEN 'EKLAS'.
        ev_fieldname =    'VALUATIONCLASSSALESORDERSTOCK'.
      WHEN 'QKLAS'.
        ev_fieldname =    'PROJECTSTOCKVALUATIONCLASS'.
      WHEN 'ZPLP1'.
        ev_fieldname =    'PLANNEDPRICE1INCOCODECRCY'.
      WHEN 'ZPLP2'.
        ev_fieldname =    'PLANNEDPRICE2INCOCODECRCY'.
      WHEN 'ZPLP3'.
        ev_fieldname =    'PLANNEDPRICE3INCOCODECRCY'.
      WHEN 'ZPLD1'.
        ev_fieldname =    'FUTUREPLNDPRICE1VALDTYDATE'.
      WHEN 'ZPLD2'.
        ev_fieldname =    'FUTUREPLNDPRICE2VALDTYDATE'.
      WHEN 'ZPLD3'.
        ev_fieldname =    'FUTUREPLNDPRICE3VALDTYDATE'.
      WHEN 'BWPRH'.
        ev_fieldname =    'COMMERCIALPRICE1INCOCODECRCY'.
      WHEN 'BWPH1'.
        ev_fieldname =    'COMMERCIALPRICE2INCOCODECRCY'.
      WHEN 'VJBWH'.
        ev_fieldname =    'COMMERCIALPRICE3INCOCODECRCY'.
      WHEN 'XLIFO'.
        ev_fieldname =    'ISLIFOANDFIFORELEVANT'.
      WHEN 'MYPOL'.
        ev_fieldname =    'LIFOVALUATIONPOOLNUMBER'.
      WHEN 'BWPRS'.
        ev_fieldname =    'TAXPRICEL1INCOCODECRCY'.
      WHEN 'BWPS1'.
        ev_fieldname =    'TAXPRICE2INCOCODECRCY'.
      WHEN 'VJBWS'.
        ev_fieldname =    'TAXPRICE3INCOCODECRCY'.
      WHEN 'BWPEI'.
        ev_fieldname =    'TAXBASEDPRICESPRICEUNITQTY'.
      WHEN 'STPRV'.
        ev_fieldname =    'PREVINVTRYPRICEINCOCODECRCY'.
      WHEN 'LAEPR'.
        ev_fieldname =    'PRICELASTCHANGEDATE'.
      WHEN 'ZPLPR'.
        ev_fieldname =    'PLANNEDPRICE'.
      WHEN 'LOEKZ'.
        ev_fieldname =    'ISMARKEDFORDELETION'.
      WHEN 'BERID'.
        ev_fieldname =    'MRPAREA'.
      WHEN  'LGFSB'.
        ev_fieldname =    'DFLTSTORAGELOCATIONEXTPROCMT'.
      WHEN 'DISGR'.
        ev_fieldname =    'MRPGROUP'.
      WHEN 'LOSFX'.
        ev_fieldname =    'LOTSIZEINDEPENDENTCOSTS'.
      WHEN 'LAGPR'.
        ev_fieldname =    'ISSTORAGECOSTS'.
      WHEN 'TAKZT'.
        ev_fieldname =    'RQMTQTYRCPTTAKTTMEINWRKGDAYS'.
      WHEN 'MRPPP'.
        ev_fieldname =    'MRPPLANNINGCALENDAR'.
      WHEN 'PLIFZX'.
        ev_fieldname =    'ISPLANNEDDELIVERYTIME'.
      WHEN 'RWPRO'.
        ev_fieldname =    'RANGEOFCVRGPRFLCODE'.
      WHEN 'SHFLG'.
        ev_fieldname =    'ISSAFETYTIME'.
      WHEN 'SHPRO'.
        ev_fieldname =    'PERDPRFLFORSFTYTME'.
      WHEN 'AHDIS'.
        ev_fieldname =    'ISMRPDEPENDENTRQMT'.
      WHEN 'LGRAD'.
        ev_fieldname =    'SRVCLVL'.

      WHEN 'EXCISE_TAX_RLVNCE'.
        ev_fieldname =    'PRODUCTISEXCISETAXRELEVANT'. "April 2019 - Excise Tax

*********** mapping FOR draft TABLE

      WHEN   'MARA'.
        ev_fieldname =  'PRD_ROOT '.
      WHEN   'MAKT'.
        ev_fieldname =  ' PRD_DESCR'.
      WHEN   'MARM'.
        ev_fieldname =  ' PRD_UOM'.
      WHEN   'MEAN'.
        ev_fieldname =  ' PRD_UOM_EAN'.
      WHEN   'MBEW'.
        ev_fieldname =  'PRD_VALUATION'.
      WHEN   'MVKE'.
        ev_fieldname =  'PRD_SALES_DEL '.
      WHEN   'MLAN'.
        ev_fieldname =  'PRD_SALES_TAX '.
      WHEN   'MARC'.
        ev_fieldname =  'PRD_PLANT '.
      WHEN   'MARD'.
        ev_fieldname =  'PRD_STORAGE '.
      WHEN   'STXL'.
        ev_fieldname =  'PRD_TEXT'.

    ENDCASE.
  ENDMETHOD.


  METHOD _map_field_names.
    CASE iv_node_name.
      WHEN gc_entity-productstoragetype.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'WAREHOUSENUMBER'.
            ev_field = 'LGNUM'.
          WHEN 'STORAGETYPE'.
            ev_field = 'LGTYP'.
          WHEN 'DELETIONFLAG'.
            ev_field = 'LVORM'.
          WHEN 'STORAGEBIN'.
            ev_field = 'LGPLA'.
          WHEN 'MAXSTORAGEBINQTY'.
            ev_field = 'LPMAX'.
          WHEN 'MINSTORAGEBINQTY'.
            ev_field = 'LPMIN'.
          WHEN 'CONTROLQUANTITY'.
            ev_field = 'MAMNG'.
          WHEN 'REPLENISHMENTQTY'.
            ev_field = 'NSMNG'.
          WHEN 'PICKINGAREA'.
            ev_field = 'KOBER'.
          WHEN 'ROUNDINGQTY'.
            ev_field = 'RDMNG'.
        ENDCASE.
      WHEN gc_entity-productwarehouse.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'WAREHOUSENUMBER'.
            ev_field = 'LGNUM'.
          WHEN 'DELETIONFLAG'.
            ev_field = 'LVORM'.
          WHEN 'STORAGESECTIONINDICATOR'.
            ev_field = 'LGBKZ'.
          WHEN 'STOCKPLACEMENTINDICATOR'.
            ev_field = 'LTKZE'.
          WHEN 'STOCKREMOVALINDICATOR'.
            ev_field = 'LTKZA'.
          WHEN 'LOADINGQUANTITY1'.
            ev_field = 'LHMG1'.
          WHEN 'LOADINGQUANTITY2'.
            ev_field = 'LHMG2'.
          WHEN 'LOADINGQUANTITY3'.
            ev_field = 'LHMG3'.
          WHEN 'LOADINGUNIT1'.
            ev_field = 'LHME1'.
          WHEN 'LOADINGUNIT2'.
            ev_field = 'LHME2'.
          WHEN 'LOADINGUNIT3'.
            ev_field = 'LHME3'.
          WHEN 'STORAGETYPEUNIT1'.
            ev_field = 'LETY1'.
          WHEN 'STORAGETYPEUNIT2'.
            ev_field = 'LETY2'.
          WHEN 'STORAGETYPEUNIT3'.
            ev_field = 'LETY3'.
          WHEN 'WAREHOUSEUNITOFMEASURE'.
            ev_field = 'LVSME'.
          WHEN 'EXISTINGSTOCKINDICATOR'.
            ev_field = 'KZZUL'.
          WHEN 'BULKSTORAGEINDICATOR'.
            ev_field = 'BLOCK'.
          WHEN 'INVENTORYMESSAGEINDICATOR'.
            ev_field = 'KZMBF'.
          WHEN 'SPECIALMOVEMENTINDICATOR'.
            ev_field = 'BSSKZ'.
          WHEN 'CAPACITYUSAGE'.
            ev_field = 'MKAPV'.
          WHEN 'UOMCAPACITYCONSUMPTION'.
            ev_field = 'BEZME'.
          WHEN 'PICKINGSTORAGETYPE'.
            ev_field = 'PLKPT'.
          WHEN 'MATERIALUOM'.
            ev_field = 'VOMEM'.
          WHEN 'MATERIALRELEVANCE'.
            ev_field = 'L2SKR'.
        ENDCASE.
      WHEN gc_entity-product.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PRODUCTFOREDIT'.
            ev_field = 'MATNR'.
          WHEN 'PRODUCTTYPE'.
            ev_field = 'MTART'.
          WHEN 'CREATIONDATE'.
            ev_field = 'ERSDA'.
          WHEN 'CREATEDBYUSER'.
            ev_field = 'ERNAM'.
          WHEN 'LASTCHANGEDATE'.
            ev_field = 'LAEDA'.
          WHEN 'LASTCHANGEDBYUSER'.
            ev_field = 'AENAM'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LVORM'.
          WHEN 'CROSSPLANTSTATUS'.
            ev_field = 'MSTAE'.
          WHEN 'CROSSPLANTSTATUSVALIDITYDATE'.
            ev_field = 'MSTDE'.
          WHEN 'PRODUCTOLDID'.
            ev_field = 'BISMT'.
          WHEN 'GROSSWEIGHT'.
            ev_field = 'BRGEW'.
          WHEN 'PURORDERQUANTITYUNIT'.
            ev_field = 'BSTME'.
          WHEN 'SOURCEOFSUPPLY'.
            ev_field = 'BWSCL'.
          WHEN 'WEIGHTUNIT'.
            ev_field = 'GEWEI'.
*          WHEN 'COUNTRYOFORIGIN'.              EV_FIELD = 'HERKL'.
          WHEN 'COMPETITORID'.
            ev_field = 'KUNNR'.
          WHEN 'PRODUCTGROUP'.
            ev_field = 'MATKL'.
          WHEN 'BASEUNIT'.
            ev_field = 'MEINS'.
          WHEN 'ITEMCATEGORYGROUP'.
            ev_field = 'MTPOS_MARA'.
          WHEN 'NETWEIGHT'.
            ev_field = 'NTGEW'.
          WHEN 'PRODUCTHIERARCHY'.
            ev_field = 'PRDHA'.
          WHEN 'DIVISION'.
            ev_field = 'SPART'.
          WHEN 'VARBLPURORDUNITISACTIVE'.
            ev_field = 'VABME'.
          WHEN 'VOLUMEUNIT'.
            ev_field = 'VOLEH'.
          WHEN 'MATERIALVOLUME'.
            ev_field = 'VOLUM'.
          WHEN 'SALESSTATUS'.
            ev_field = 'MSTAV'.
          WHEN 'TRANSPORTATIONGROUP'.
            ev_field = 'TRAGR'.
          WHEN 'SALESSTATUSVALIDITYDATE'.
            ev_field = 'MSTDV'.
          WHEN 'ANPCODE'.
            ev_field = 'ANP'.
          WHEN 'PRODUCTCATEGORY'.
            ev_field = 'ATTYP'.
          WHEN 'BRAND'.
            ev_field = 'BRAND_ID'.
          WHEN 'PROCUREMENTRULE'.
            ev_field = 'BWVOR'.
          WHEN 'VALIDITYSTARTDATE'.
            ev_field = 'DATAB'.
          WHEN 'LOWLEVELCODE'.
            ev_field = 'DISST'.
          WHEN 'PRODNOINGENPRODINPREPACKPROD'.
            ev_field = 'GENNR'.
          WHEN 'SERIALIDENTIFIERASSGMTPROFILE'.
            ev_field = 'SERIAL'.
          WHEN 'SIZEORDIMENSIONTEXT'.
            ev_field = 'GROES'.
          WHEN 'INDUSTRYSTANDARDNAME'.
            ev_field = 'NORMT'.
          WHEN 'PRODUCTSTANDARDID'.
            ev_field = 'EAN11'.
          WHEN 'INTERNATIONALARTICLENUMBERCAT'.
            ev_field = 'NUMTP'.
          WHEN 'PRODUCTISCONFIGURABLE'.
            ev_field = 'KZKFG'.
          WHEN 'ISBATCHMANAGEMENTREQUIRED'.
            ev_field = 'XCHPF'.
          WHEN 'EXTERNALPRODUCTGROUP'.
            ev_field = 'EXTWG'.
          WHEN 'CROSSPLANTCONFIGURABLEPRODUCT'.
            ev_field = 'SATNR'.
          WHEN 'SERIALNOEXPLICITNESSLEVEL'.
            ev_field = 'SERLV'.
          WHEN 'PRODUCTMANUFACTURERNUMBER'.
            ev_field = 'MFRPN'.
          WHEN 'MANUFACTURERNUMBER'.
            ev_field = 'MFRNR'.
          WHEN 'MANUFACTURERPARTPROFILE'.
            ev_field = 'MPROF'.
          WHEN 'QLTYMGMTINPROCMTISACTIVE'.
            ev_field = 'QMPUR'.
          WHEN 'CHANGENUMBER'.
            ev_field = 'AENNR'.
          WHEN 'MATERIALREVISIONLEVEL'.
            ev_field = 'REVLV'.
          WHEN 'INDUSTRYSECTOR' .
            ev_field =  'MBRSH'.


*****               RETAIL EV_FIELDS

          WHEN  'MAXIMUMPACKAGINGLENGTH'.
            ev_field =  'MAXL'.
          WHEN  'MAXIMUMPACKAGINGWIDTH'.
            ev_field =  'MAXB'.
          WHEN  'MAXIMUMPACKAGINGHEIGHT'.
            ev_field =  'MAXH'.
          WHEN  'UNITFORMAXPACKAGINGDIMENSIONS'.
            ev_field =  'MAXDIM_UOM'.
          WHEN  'BASEUNITSPECIFICPRODUCTLENGTH' .
            ev_field =  'LAENG'.
          WHEN  'BASEUNITSPECIFICPRODUCTWIDTH' .
            ev_field =  'BREIT'.
          WHEN  'BASEUNITSPECIFICPRODUCTHEIGHT' .
            ev_field =  'HOEHE'.
          WHEN  'PRODUCTMEASUREMENTUNIT' .
            ev_field =  'MEABM'.
          WHEN  'PRODUCTVALIDSTARTDATE' .
            ev_field =  'DATAB'.
          WHEN  'ARTICLECATEGORY' .
            ev_field =  'ATTYP'.
          WHEN  'CONTENTUNIT' .
            ev_field =  'INHME'.
          WHEN  'NETCONTENT' .
            ev_field =  'INHAL'.
          WHEN  'COMPARISONPRICEQUANTITY' .
            ev_field =  'VPREH'.
          WHEN  'GROSSCONTENT' .
            ev_field =  'INHBR'.
          WHEN  'PRODUCTVALIDENDDATE' .
            ev_field =  'LIQDT'.
          WHEN  'ASSORTMENTLISTTYPE' .
            ev_field =  'BBTYP'.
          WHEN  'HASTEXTILEPARTSWTHANIMALORIGIN' .
            ev_field =  'ANIMAL_ORIGIN'.
          WHEN  'PRODUCTSEASONUSAGECATEGORY' .
            ev_field =  'FSH_SEALV'.
          WHEN  'SERVICEAGREEMENT' .
            ev_field =  'SERVV'.
          WHEN  'CONSUMPTIONVALUECATEGORY    ' .
            ev_field =  'WMAAB'.
          WHEN  'GOODSISSUEUNIT' .
            ev_field =  'WAUSM'.
          WHEN  'COUNTRYOFORIGIN' .
            ev_field =  'WHERL'.
          WHEN  'REGIONOFORIGIN' .
            ev_field =  'WHERR'.
          WHEN  'ASSORTMENTGRADE' .
            ev_field =  'SSTUF'.
          WHEN  'STORELISTINGPROCEDURE' .
            ev_field =  'LSTFL'.
          WHEN  'DISTRCNTRLISTINGPROCEDURE' .
            ev_field =  'LSTVZ'.
          WHEN  'STORELISTINGSTARTDATE' .
            ev_field =  'LDVFL'.
          WHEN  'STORELISTINGENDDATE' .
            ev_field =  'LDBFL'.
          WHEN  'DISTRCNTRLISTINGSTARTDATE' .
            ev_field =  'LDVZL'.
          WHEN  'DISTRCNTRLISTINGENDDATE' .
            ev_field =  'LDBZL'.
          WHEN  'STORESALESTARTDATE' .
            ev_field =  'VDVFL'.
          WHEN  'STORESALEENDDATE' .
            ev_field =  'VDBFL'.
          WHEN  'DISTRCNTRSALESTARTDATE' .
            ev_field =  'VDVZL'.
          WHEN  'DISTRCNTRSALEENDDATE' .
            ev_field =  'VDBZL'.
          WHEN  'COMMODITYCODE' .
            ev_field =  'WSTAW'.
          WHEN  'VALUATIONMARGIN' .
            ev_field =  'WBWSP'.
          WHEN  'COMMODITIYCODENUMBERUNIT' .
            ev_field =  'WEXPM'.
          WHEN  'HANDLINGUNITTYPE'.
            ev_field =  'HUTYP'.
          WHEN  'STANDARDHANDLINGUNITTYPE'.
            ev_field =  'HUTYP_DFLT'.
          WHEN  'HASVARIABLETAREWEIGHT'.
            ev_field =  'TARE_VAR'.
          WHEN  'VALUATIONCLASS'.
            ev_field =  'WBKLA'.

* MISSING FIELDS
          WHEN 'ABSOLUTEHEIGHTTHRESHOLD'.
            ev_field = 'HEIGHT_NONFLAT'.
          WHEN 'ADJUSTMENTPROFILE'.
            ev_field = 'ADPROF'.
          WHEN 'ALLOWEDPKGVOLUME'.
            ev_field = 'ERVOL'.
          WHEN 'ALLOWEDPKGWEIGHT'.
            ev_field = 'ERGEW'.
          WHEN 'AUTHORIZATIONGROUP'.
            ev_field = 'BEGRU'.
          WHEN 'BRIDGETHRESHOLD'.
            ev_field = 'BRIDGE_TRESH'.
          WHEN 'CATALOGPROFILE'.
            ev_field = 'RBNRM'.
          WHEN 'CATCHWEIGHTRELEVANT'.
            ev_field = 'CWQREL'.
          WHEN 'CATCHWTTOLERANCEGROUP'.
            ev_field = 'CWQTOLGR'.
          WHEN 'CLOSEDPACKAGMATERIAL'.
            ev_field = 'KZGVH'.
          WHEN 'CWPROFILEFORCWQTY'.
            ev_field = 'CWQPROC'.
          WHEN 'EXCESSVOLUMETOL'.
            ev_field = 'VOLTO'.
          WHEN 'EXCESSWTTOLERANCE'.
            ev_field = 'GEWTO'.
          WHEN 'HANDLINGINDICATOR'.
            ev_field = 'HNDLCODE'.
          WHEN 'ISPILFERABLE'.
            ev_field = 'PILFERABLE'.
          WHEN 'ISRELEVANTFORHZDSSUBSTANCES'.
            ev_field = 'HAZMAT'.

            "DATE TIME IS NOT HANDLED YET
*          WHEN 'LASTCHANGEDATETIME'.                 EV_FIELD = 'LAEDA'.
          WHEN 'LOGISTICSUOM'.
            ev_field = 'LOGUNIT'.
          WHEN 'MATURATIONTIME'.
            ev_field = 'SCM_MATURITY_DUR'.
          WHEN 'MAXIMUMLEVEL'.
            ev_field = 'FUELG'.
          WHEN 'MAXIMUMSLOPEFORBRIDGES'.
            ev_field = 'BRIDGE_MAX_SLOPE'.
          WHEN 'MEDIUM'.
            ev_field = 'MEDIUM'.
          WHEN 'MSBOOKPARTNUMBER'.
            ev_field = 'MSBOOKPARTNO'.
          WHEN 'OVERHANGTHRESHOLD'.
            ev_field = 'OVERHANG_TRESH'.
          WHEN 'PACKAGINGMATERIALTYPE'.
            ev_field = 'VHART'.
          WHEN 'PACKAGINGVOLUMEUNIT'.
            ev_field = 'ERVOE'.
          WHEN 'PREFERREDUNITOFMEASURE'.
            ev_field = 'SCM_PUOM'.
          WHEN 'PRODUCTCOMPOSITION'.
            ev_field = 'PRZUS'.
          WHEN 'PRODUCTORIENTATIONPROFILE'.
            ev_field = 'MO_PROFILE_ID'.
          WHEN 'PRODUCTSHAPE'.
            ev_field = 'PROD_SHAPE'.
          WHEN 'PURCHASEORDERQUANTITYUNIT'.
            ev_field = 'BSTME'.
          WHEN 'QUALITYINSPECTIONGROUP'.
            ev_field = 'QGRP'.
          WHEN 'QUARANTINEPERIOD'.
            ev_field = 'QQTIME'.
          WHEN 'REFERENCEPRDFORPACKAGEBUILDING'.
            ev_field = 'RMATP_PB'.
*          WHEN 'REQMAXSHLIFE'.                       ev_field = 'SCM_SHLF_LFE_REQ_MAX'.
          WHEN 'SEGMENTATIONSTRUCTURE'.
            ev_field = 'SGT_CSGR'.
          WHEN 'SERIALNUMBERPROFILE'.
            ev_field = 'SERIAL'.
          WHEN 'STACKABILITYFACTOR'.
            ev_field = 'STFAK'.
          WHEN 'TIMEUNITFORQUARANTINEPERIOD'.
            ev_field = 'QQTIMEUOM'.
          WHEN 'UNITOFWEIGHT'.
            ev_field = 'ERGEI'.
          WHEN 'UOMOFABSHEIGHTTHRESHOLD'.
            ev_field = 'HEIGHT_NONFLAT_UOM'.
          WHEN 'WAREHOUSEPRODUCTGROUP'.
            ev_field = 'WHMATGR'.
          WHEN 'WAREHOUSESTORAGECONDITION'.
            ev_field = 'WHSTC'.

            "XSIMPLEXA_PRODUCTQUALITYMGMTTYPE
*          WHEN 'QLTYMGMTINPROCMTISACTIVE'.           EV_FIELD = 'QMPUR'.
            "XSIMPLEXA_PRODUCTSTORAGETYPE
          WHEN 'STORAGECONDITIONS'.
            ev_field = 'RAUBE'.
          WHEN 'TEMPERATURECONDITIONIND'.
            ev_field = 'TEMPB'.
          WHEN 'HAZARDOUSMATERIALNUMBER'.
            ev_field = 'STOFF'.
          WHEN 'NMBROFGRORGISLIPSTOPRINTQTY'.
            ev_field = 'WESCH'.
          WHEN 'LABELTYPE'.
            ev_field = 'ETIAR'.
          WHEN 'LABELFORM'.
            ev_field = 'ETIFO'.
          WHEN 'MINREMAININGSHELFLIFE'.
            ev_field = 'MHDRZ'.
          WHEN 'EXPIRATIONDATE'.
            ev_field = 'SLED_BBD'.
            "XSIMPLEXA_PRODUCTPROCUREMENTTYPE
*          WHEN 'PURCHASEORDERQUANTITYUNIT'.     EV_FIELD = 'BSTME'.
          WHEN 'VARBLPURORDUNITSTATUS'.
            ev_field = 'VABME'.
          WHEN 'PURCHASINGACKNPROFILE'.
            ev_field = 'EKWSL'.
            "XSIMPLEXA_PRODUCTSALESTYPE
*          WHEN 'SALESSTATUS'.                   EV_FIELD = 'MSTAV'.
*          WHEN 'SALESSTATUSVALIDITYDATE'.       EV_FIELD = 'MSTDV'.
          WHEN 'TAXCLASSIFICATION'.
            ev_field = 'TAKLV'.
*          WHEN 'TRANSPORTATIONGROUP'.           EV_FIELD = 'TRAGR'.
          WHEN 'LABORATORYORDESIGNOFFICE'.
            ev_field = 'LABOR'.
          WHEN 'PRODALLOCDETNPROCEDURE'.
            ev_field = 'KOSCH'.
          WHEN 'PRODEFFCTYPARAMVALSAREASSIGNED'.
            ev_field = 'KZEFF'.
          WHEN 'PRODUCTIONORINSPECTIONMEMOTXT'.
            ev_field = 'FERTH'.
          WHEN 'PRODUCTIONMEMOPAGEFORMAT'.
            ev_field = 'FORMT'.
          WHEN 'DOCUMENTISCREATEDBYCAD'.
            ev_field = 'CADKZ'.
          WHEN 'BASICMATERIAL'.
            ev_field = 'WRKST'.
          WHEN 'DANGEROUSGOODSINDPROFILE'.
            ev_field = 'PROFL'.
          WHEN 'PRODISENVIRONMENTALLYRELEVANT'.
            ev_field = 'KZUMW'.
          WHEN 'TRANSPORTISINBULK'.
            ev_field = 'ILOOS'.
          WHEN 'PRODUCTISHIGHLYVISCOUS'.
            ev_field = 'IHIVI'.
          WHEN 'SEGMENTATIONSTRATEGY'.
            ev_field = 'SGT_COVSA'.
          WHEN 'PRODUCTDOCUMENTNUMBER'.
            ev_field = 'ZEINR'.
          WHEN 'PRODUCTDOCUMENTTYPE'.
            ev_field = 'ZEIAR'.
          WHEN 'PRODUCTDOCUMENTVERSION'.
            ev_field = 'ZEIVR'.
          WHEN 'PRODUCTDOCUMENTPAGENUMBER'.
            ev_field = 'BLATT'.
          WHEN 'PRODUCTDOCUMENTCHANGENUMBER'.
            ev_field = 'AESZN'.
          WHEN 'PRODUCTDOCUMENTPAGEFORMAT'.
            ev_field = 'ZEIFO'.
          WHEN 'PRODUCTDOCUMENTPAGECOUNT'.
            ev_field = 'BLANZ'.
          WHEN 'MAXIMUMCAPACITY'.
            ev_field = 'MAXC'.
          WHEN 'OVERCAPACITYTOLERANCE'.
            ev_field = 'MAXC_TOL'.
          WHEN 'DISCOUNTINKINDELIGIBILITY'.
            ev_field = 'NRFHG'.
          WHEN 'ISAPPROVEDBATCHRECORDREQD'.
            ev_field = 'XGCHP'.
          WHEN 'PACKAGINGMATERIALGROUP'.
            ev_field = 'MAGRV'.
          WHEN 'DISCOUNTINKINDELIGIBILITY'.
            ev_field = 'NRFHG'.

          WHEN 'STORAGECONDITIONS'.
            ev_field = 'RAUBE'.
          WHEN 'TEMPERATURECONDITIONIND'.
            ev_field = 'TEMPB'.
          WHEN 'HAZARDOUSMATERIALNUMBER'.
            ev_field = 'STOFF'.
          WHEN 'NMBROFGRORGISLIPSTOPRINTQTY'.
            ev_field = 'WESCH'.
          WHEN 'LABELTYPE'.
            ev_field = 'ETIAR'.
          WHEN 'LABELFORM'.
            ev_field = 'ETIFO'.
          WHEN 'MINREMAININGSHELFLIFE'.
            ev_field = 'MHDRZ'.
          WHEN 'EXPIRATIONDATE'.
            ev_field = 'SLED_BBD'.
          WHEN 'SHELFLIFEEXPIRATIONDATEPERIOD'.
            ev_field = 'IPRKZ'.
          WHEN 'SHELFLIFEEXPRTNDATERNDINGRULE'.
            ev_field = 'RDMHD'.
          WHEN 'STORAGEBININSTRUCTION'.
            ev_field = 'BEHVO'.
          WHEN 'TOTALSHELFLIFE'.
            ev_field = 'MHDHB'.
          WHEN 'TOTALSHELFLIFESTORAGEPERCENT'.
            ev_field = 'MHDLP'.
          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/APRODUCT'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field.

        ENDCASE.

      WHEN gc_entity-description.
        CASE iv_fieldname.
          WHEN 'LANGUAGE'.
            ev_field = 'SPRAS'.
          WHEN 'LANGUAGEFOREDIT'.
            ev_field = 'SPRAS'.
          WHEN 'PRODUCTDESCRIPTION'.
            ev_field = 'MAKTX'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.

          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-salesdelivery.
        CASE iv_fieldname.
          WHEN 'PRODUCTSALESORG'.
            ev_field = 'VKORG'.
          WHEN 'PRODUCTDISTRIBUTIONCHNL'.
            ev_field = 'VTWEG'.
          WHEN 'PRODUCTSALESORGFOREDIT'.
            ev_field = 'VKORG'.
          WHEN 'PRODUCTDISTRIBUTIONCHNLFOREDIT'.
            ev_field = 'VTWEG'.
          WHEN 'MINIMUMORDERQUANTITY'.
            ev_field = 'AUMNG'.
          WHEN 'SUPPLYINGPLANT'.
            ev_field = 'DWERK'.
          WHEN 'PRICESPECIFICATIONPRODUCTGROUP'.
            ev_field = 'KONDM'.
          WHEN 'ACCOUNTDETNPRODUCTGROUP'.
            ev_field = 'KTGRM'.
          WHEN 'DELIVERYNOTEPROCMINDELIVQTY'.
            ev_field = 'LFMNG'.
          WHEN 'ITEMCATEGORYGROUP'.
            ev_field = 'MTPOS'.
          WHEN 'DELIVERYQUANTITYUNIT'.
            ev_field = 'SCHME'.
          WHEN 'DELIVERYQUANTITY'.
            ev_field = 'SCMNG'.
          WHEN 'PRODUCTSALESSTATUS'.
            ev_field = 'VMSTA'.
          WHEN 'PRODUCTSALESSTATUSVALIDITYDATE'.
            ev_field = 'VMSTD'.
          WHEN 'SALESMEASUREUNIT'.
            ev_field = 'VRKME'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LVORM'.
          WHEN 'PRODUCTHIERARCHY'.
            ev_field = 'PRODH'.
          WHEN 'FIRSTSALESSPECPRODUCTGROUP'.
            ev_field = 'MVGR1'.
          WHEN 'SECONDSALESSPECPRODUCTGROUP'.
            ev_field = 'MVGR2'.
          WHEN 'THIRDSALESSPECPRODUCTGROUP'.
            ev_field = 'MVGR3'.
          WHEN 'FOURTHSALESSPECPRODUCTGROUP'.
            ev_field = 'MVGR4'.
          WHEN 'FIFTHSALESSPECPRODUCTGROUP'.
            ev_field = 'MVGR5'.
          WHEN 'MINIMUMMAKETOORDERORDERQTY'.
            ev_field = 'EFMNG'.

*          //RETAIL
          WHEN  'LOGISTICSSTATISTICSGROUP' .
            ev_field =  'VERSG'.
          WHEN  'VOLUMEREBATEGROUP' .
            ev_field =  'BONUS'.
          WHEN  'PRODUCTCOMMISSIONGROUP' .
            ev_field =  'PROVG'.
          WHEN  'CASHDISCOUNTISDEDUCTIBLE' .
            ev_field =  'SKTOF'.
          WHEN  'PRICINGREFERENCEPRODUCT' .
            ev_field =  'PMATN'.
          WHEN  'ASSORTMENTGRADE' .
            ev_field =  'SSTUF'.
          WHEN  'STORELISTINGPROCEDURE' .
            ev_field =  'LSTFL'.
          WHEN  'DISTRCNTRLISTINGPROCEDURE' .
            ev_field =  'LSTVZ'.
          WHEN  'STORELISTINGSTARTDATE' .
            ev_field =  'LDVFL'.
          WHEN  'STORELISTINGENDDATE' .
            ev_field =  'LDBFL'.
          WHEN  'DISTRCNTRLISTINGSTARTDATE' .
            ev_field =  'LDVZL'.
          WHEN  'DISTRCNTRLISTINGENDDATE' .
            ev_field =  'LDBZL'.
          WHEN  'STORESALESTARTDATE' .
            ev_field =  'VDVFL'.
          WHEN  'STORESALEENDDATE' .
            ev_field =  'VDBFL'.
          WHEN  'DISTRCNTRSALESTARTDATE' .
            ev_field =  'VDVZL'.
          WHEN  'DISTRCNTRSALEENDDATE' .
            ev_field =  'VDBZL'.
          WHEN  'ROUNDINGPROFILE' .
            ev_field =  'RDPRF'.
          WHEN  'PRODCUTUNITGROUP' .
            ev_field =  'MEGRU'.
          WHEN  'MAXDELIVERYQTYSTOREORDER' .
            ev_field =  'LFMAX'.
          WHEN  'PRICEFIXINGCATEGORY' .
            ev_field =  'PBIND'.
          WHEN  'VARIABLESALESUNITISNOTALLOWED' .
            ev_field =  'VAVME'.
          WHEN  'COMPETITIONPRESSURECATEGORY' .
            ev_field =  'MATKC'.
          WHEN  'PRODUCT' .
            ev_field =  'MATNR'.
          WHEN 'PRODUCTHASATTRIBUTEID01'.
            ev_field = 'PRAT1'.
          WHEN 'PRODUCTHASATTRIBUTEID02'.
            ev_field = 'PRAT2'.
          WHEN 'PRODUCTHASATTRIBUTEID03'.
            ev_field = 'PRAT3'.
          WHEN 'PRODUCTHASATTRIBUTEID04'.
            ev_field = 'PRAT4'.
          WHEN 'PRODUCTHASATTRIBUTEID05'.
            ev_field = 'PRAT5'.
          WHEN 'PRODUCTHASATTRIBUTEID06'.
            ev_field = 'PRAT6'.
          WHEN 'PRODUCTHASATTRIBUTEID07'.
            ev_field = 'PRAT7'.
          WHEN 'PRODUCTHASATTRIBUTEID08'.
            ev_field = 'PRAT8'.
          WHEN 'PRODUCTHASATTRIBUTEID09'.
            ev_field = 'PRAT9'.
          WHEN 'PRODUCTHASATTRIBUTEID10'.
            ev_field = 'PRATA'.
          WHEN  'PRODUCTUNITGROUP' .
            ev_field = 'MEGRU'.
          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/APRODSD'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field.

        ENDCASE.
      WHEN gc_entity-plant.
        CASE iv_fieldname.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PLANTFOREDIT'.
            ev_field = 'WERKS'.
          WHEN 'PURCHASINGGROUP'.
            ev_field = 'EKGRP'.
          WHEN 'COUNTRYOFORIGIN'.
            ev_field = 'HERKL'.
          WHEN 'REGIONOFORIGIN'.
            ev_field = 'HERKR'.
          WHEN 'ISAUTOPURORDCREATIONALLOWED'.
            ev_field = 'KAUTB'.
          WHEN 'PRODUCTIONINVTRYMANAGEDLOC'.
            ev_field = 'LGPRO'.
          WHEN 'PROFILECODE'.
            ev_field = 'MMSTA'.
          WHEN 'PROFILEVALIDITYSTARTDATE'.
            ev_field = 'MMSTD'.
          WHEN 'AVAILABILITYCHECKTYPE'.
            ev_field = 'MTVFP'.
          WHEN 'FISCALYEARVARIANT'.
            ev_field = 'PERIV'.
          WHEN 'PERIODTYPE'.
            ev_field = 'PERKZ'.
          WHEN 'PROFITCENTER'.
            ev_field = 'PRCTR'.
          WHEN 'COMMODITY'.
            ev_field = 'STAWN'.
          WHEN 'GOODSRECEIPTDURATION'.
            ev_field = 'WEBAZ'.
          WHEN 'MAINTENANCESTATUSNAME'.
            ev_field = 'PSTAT'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LVORM'.
          WHEN 'LOTSIZINGPROCEDURE'.
            ev_field = 'DISLS'.
          WHEN 'MRPTYPE'.
            ev_field = 'DISMM'.
          WHEN 'MRPRESPONSIBLE'.
            ev_field = 'DISPO'.
          WHEN 'ABCINDICATOR'.
            ev_field = 'MAABC'.
          WHEN 'PLANNINGTIMEFENCE'.
            ev_field = 'FXHOR'.
          WHEN 'REORDERTHRESHOLDQUANTITY'.
            ev_field = 'MINBE'.
          WHEN 'SAFETYSTOCKQUANTITY'.
            ev_field = 'EISBE'.
          WHEN 'SAFETYDURATION'.
            ev_field = 'SHZET'.
          WHEN 'MINIMUMSAFETYSTOCKQUANTITY'.
            ev_field = 'EISLO'.
          WHEN 'LOADINGGROUP'.
            ev_field = 'LADGR'.
          WHEN 'MINIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMI'.
          WHEN 'MAXIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMA'.
          WHEN 'FIXEDLOTSIZEQUANTITY'.
            ev_field = 'BSTFE'.
          WHEN 'LOTSIZEROUNDINGQUANTITY'.
            ev_field = 'BSTRF'.
          WHEN 'MAXIMUMSTOCKQUANTITY'.
            ev_field = 'MABST'.
          WHEN 'PLANNEDDELIVERYDURATION'.
            ev_field = 'PLIFZ'.
          WHEN 'CONSUMPTIONTAXCTRLCODE'.
            ev_field = 'STEUC'.
          WHEN 'ISCOPRODUCT'.
            ev_field = 'KZKUP'.
          WHEN 'PRODUCTISCONFIGURABLE'.
            ev_field = 'STDPD'.
          WHEN 'STOCKDETERMINATIONGROUP'.
            ev_field = 'EPRIO'.
          WHEN 'STOCKINTRANSFERQUANTITY'.
            ev_field = 'UMLMC'.
          WHEN 'STOCKINTRANSITQUANTITY'.
            ev_field = 'TRAME'.
          WHEN 'HASPOSTTOINSPECTIONSTOCK'.
            ev_field = 'INSMK'.
          WHEN 'ISBATCHMANAGEMENTREQUIRED'.
            ev_field = 'XCHPF'.
          WHEN 'SERIALNUMBERPROFILE'.
            ev_field = 'SERNP'.
          WHEN 'ISNEGATIVESTOCKALLOWED'.
            ev_field = 'XMCNG'.
          WHEN 'GOODSRECEIPTBLOCKEDSTOCKQTY'.
            ev_field = 'BWESB'.
          WHEN 'HASCONSIGNMENTCTRL'.
            ev_field = 'CONS_PROCG'.
          WHEN 'TIEDEMPTIESSTOCKQUANTITY'.
            ev_field = 'GLGMG'.
          WHEN 'FISCALYEARCURRENTPERIOD'.
            ev_field = 'LFGJA'.
          WHEN 'FISCALMONTHCURRENTPERIOD'.
            ev_field = 'LFMON'.
          WHEN 'ISPURGACROSSPURGGROUP'.
            ev_field = 'MULTIPLE_EKGRP'.
          WHEN 'ISINTERNALBATCHMANAGED'.
            ev_field = 'XCHAR'.
          WHEN 'INVENTORYFORCYCLECOUNTIND'.
            ev_field = 'ABCIN'.
          WHEN 'PRODUCTCFOPCATEGORY'.
            ev_field = 'INDUS'.
          WHEN 'PROCUREMENTTYPE'.
            ev_field = 'BESKZ'.
          WHEN 'PRODUCTISEXCISETAXRELEVANT'.
            ev_field = 'EXCISE_TAX_RLVNCE'. "APRIL 2019 - EXCISE TAX

*          //RETAIL
          WHEN  'GOODSISSUEUNIT' .
            ev_field =  'AUSME'.
          WHEN  'SOURCEOFSUPPLYCATEGORY' .
            ev_field =  'BWSCL'.
          WHEN  'CONSUMPTIONREFERENCEPRODUCT' .
            ev_field =  'VRBMT'.
          WHEN  'CONSUMPTIONREFERENCEPLANT' .
            ev_field =  'VRBWK'.
          WHEN  'CONSUMPTIONREFUSAGEENDDATE' .
            ev_field =  'VRBDT'.
          WHEN  'CONSUMPTIONQTYMULTIPLIER' .
            ev_field =  'VRBFK'.
          WHEN  'PRODUCTUNITGROUP' .
            ev_field =  'MEGRU'.
          WHEN  'DISTRCNTRDISTRIBUTIONPROFILE'.
            ev_field =  'FPRFM'.
          WHEN  'CONSIGNMENTCONTROL' .
            ev_field =  'CONS_PROCG'.
          WHEN  'GOODISSUEPROCESSINGDAYS' .
            ev_field =  'GI_PR_TIME'.
          WHEN  'PRODUCT'.
            ev_field =  'MATNR'.

*         MISSING FIELDS
          WHEN 'ADVANCEDPLANNINGINDICATOR'.
            ev_field = 'PPSKZ'.
          WHEN 'ALERTTHRESHOLDFOREARLINESS'.
            ev_field = 'SCM_PEG_FUTURE_ALERT'.
          WHEN 'ALERTTHRESHOLDFORLATENESS'.
            ev_field = 'SCM_PEG_PAST_ALERT'.
          WHEN 'ALTERNATIVEBOM'.
            ev_field = 'STLAL'.
          WHEN 'AVOIDALERTS'.
            ev_field = 'SCM_PEG_WO_ALERT_FST'.
          WHEN 'BASEQTY'.
            ev_field = 'VBAMG'.
          WHEN 'BATCHENTRY'.
            ev_field = 'KZECH'.
          WHEN 'BOMUSAGE'.
            ev_field = 'STLAN'.
          WHEN 'CCFIXED'.
            ev_field = 'CCFIX'.
          WHEN 'CONFIGURABLEPRODUCT'.
            ev_field = 'STDPD'.
          WHEN 'CONVERSIONRULE'.
            ev_field = 'SCM_PROFID'.
          WHEN 'COSTINGLOTSIZE'.
            ev_field = 'LOSGR'.
          WHEN 'DEFAULTSTOCKSEGMENT'.
            ev_field = 'SGT_DEFSC'.
          WHEN 'DONOTCOST'.
            ev_field = 'NCOST'.
          WHEN 'EXTERNALALLOCATIONOFUII'.
            ev_field = 'UID_IEA'.
          WHEN 'FIXEDPEGGING'.
            ev_field = 'SCM_FIXPEG_PROD_SET'.
          WHEN 'FIXEDPRICECOPRODUCT'.
            ev_field = 'FXPRU'.
          WHEN 'GIHANDLGCAPCONS'.
            ev_field = 'SCM_CONHAP_OUT'.
          WHEN 'GIPROCESSNGTIME'.
            ev_field = 'SCM_GIPRT'.
          WHEN 'GRHANDLGCAPCONS'.
            ev_field = 'SCM_CONHAP'.
          WHEN 'GROUPCOUNTER'.
            ev_field = 'APLAL'.
          WHEN 'GRPROCESSNGTIME'.
            ev_field = 'SCM_GRPRT'.
          WHEN 'INSPECTIONSETUPIND'.
            ev_field = 'QMATV'.
          WHEN 'INTSOURCINGPROFILE'.
            ev_field = 'SCM_INTSRC_PROF'.
          WHEN 'IUIDRELEVANT'.
            ev_field = 'IUID_RELEVANT'.
          WHEN 'IUIDTYPE'.
            ev_field = 'IUID_TYPE'.
          WHEN 'JITSCHEDINDICATOR'.
            ev_field = 'FABKZ'.
          WHEN 'LOCMATURTIME'.
            ev_field = 'SCM_MATURITY_DUR'.
          WHEN 'LOCSHELFLIFE'.
            ev_field = 'SCM_SHELF_LIFE_DUR'.
          WHEN 'LOTSIZEUNIT'.
            ev_field = 'SCM_LSUOM'.
          WHEN 'LSINDEPENDENTCOSTS'.
            ev_field = 'LOSFX'.
          WHEN 'MAXSHELFLIFE'.
            ev_field = 'SCM_SHLF_LFE_REQ_MAX'.
          WHEN 'MINPASSINGAMT'.
            ev_field = 'SCM_MIN_PASS_AMOUNT'.
          WHEN 'MINSHELFLIFE'.
            ev_field = 'SCM_SHLF_LFE_REQ_MIN'.
          WHEN 'MRPAREASEXIST'.
            ev_field = 'DIBER'.
          WHEN 'PEGGINGSTRATEGY'.
            ev_field = 'SCM_PEG_STRATEGY'.
          WHEN 'PLANEXPLOSION'.
            ev_field = 'SCM_WHATBOM'.
          WHEN 'PLANNINGCALENDAR'.
            ev_field = 'SCM_TSTRID'.
          WHEN 'PLANNINGGROUP'.
            ev_field = 'SCM_RRP_SEL_GROUP'.
          WHEN 'PLANNINGPACKAGE'.
            ev_field = 'SCM_PACKAGE_ID'.
          WHEN 'PPPLNGPROCEDURE'.
            ev_field = 'SCM_RRP_TYPE'.
          WHEN 'PRIORITY'.
            ev_field = 'SCM_PRIO'.
          WHEN 'PROCESSINGTIME'.
            ev_field = 'VBEAZ'.
          WHEN 'PRODSTORAGECOST'.
            ev_field = 'SCM_SCOST'.
          WHEN 'PRODUCTALERTS'.
            ev_field = 'SCM_GET_ALERTS'.
          WHEN 'PRODUCTHEURISTIC'.
            ev_field = 'SCM_HEUR_ID'.
          WHEN 'PRODUCTVERSION'.
            ev_field = 'FVIDK'.
          WHEN 'PROPOSEDSTRATEGY'.
            ev_field = 'SCM_STRA1'.
          WHEN 'REORDERDAYSUPPLY'.
            ev_field = 'SCM_REORD_DUR'.
          WHEN 'REPLACEMENTPART'.
            ev_field = 'ATPKZ'.
          WHEN 'REPLENISHMENTLEADTIME'.
            ev_field = 'SCM_RELDT'.
          WHEN 'RESNETWORKNAME'.
            ev_field = 'SCM_RES_NET_NAME'.
          WHEN 'SAFETYSTOCKPENALTY'.
            ev_field = 'SCM_SSPEN'.
          WHEN 'SEGMENTATIONSTRATEGY'.
            ev_field = 'SGT_COVS'.
          WHEN 'SETUPTIME'.
            ev_field = 'VRVEZ'.
          WHEN 'SHELFLIFE'.
            ev_field = 'SCM_SHELF_LIFE_LOC'.
          WHEN 'SORTSTKBASEDONSEG'.
            ev_field = 'SGT_MRPSI'.
          WHEN 'SPECIALPROCUREMCOSTING'.
            ev_field = 'SOBSK'.
          WHEN 'TARGETDAYSUPPLY'.
            ev_field = 'SCM_TARGET_DUR'.
          WHEN 'TASKLISTGROUP'.
            ev_field = 'PLNNR'.
          WHEN 'TIMEUNIT'.
            ev_field = 'LZEIH'.
          WHEN 'UOMGIHANDLGCAP'.
            ev_field = 'SCM_HUNIT_OUT'.
          WHEN 'UOMGRHANDLGCAP'.
            ev_field = 'SCM_HUNIT'.
          WHEN 'USETOTALRECEIPTS'.
            ev_field = 'SCM_GES_MNG_USE'.
          WHEN 'USETOTALSTOCK'.
            ev_field = 'SCM_GES_BST_USE'.
          WHEN 'VARIANCEKEY'.
            ev_field = 'AWSLS'.
          WHEN 'VERSIONINDICATOR'.
            ev_field = 'VERKZ'.

            "XSIMPLEXA_PRDPLANTQUALITYMGMTTYPE
          WHEN 'MAXIMUMSTORAGEPERIOD'.
            ev_field = 'MAXLZ'.
          WHEN 'QUALITYMGMTCTRLKEY'.
            ev_field = 'SSQSS'.
          WHEN 'MATLQUALITYAUTHORIZATIONGROUP'.
            ev_field = 'QMATA'.
          WHEN 'INSPLOTDOCUMENTATIONISREQUIRED'.
            ev_field = 'KZDKZ'.
          WHEN 'RECRRGINSPINTERVALTIMEINDAYS'.
            ev_field = 'PRFRQ'.
          WHEN 'PRODUCTQUALITYCERTIFICATETYPE'.
            ev_field = 'QZGTP'.
          WHEN 'SUPLRQUALITYMANAGEMENTSYSTEM'.
            ev_field = 'QSSYS'.

            "XSIMPLEXA_PRDPLANTSTORAGETYPE


            "XSIMPLEXA_PRDPLANTINTLTRDTYPE

            "XSIMPLEXA_PRDPLANTFORECASTINGTYPE

            "XSIMPLEXA_PRDPLANTCOSTINGTYPE

            "XSIMPLEXA_PRODUCTPLANTSALESTYPE

            "XSIMPLEXA_PRDSUPPLYPLANNINGTYPE
          WHEN 'PLANNEDDELIVERYDURATIONINDAYS'.
            ev_field = 'PLIFZ'.
          WHEN 'PLANNINGSTRATEGYGROUP'.
            ev_field = 'STRGR'.
          WHEN 'TOTALREPLENISHMENTLEADTIME'.
            ev_field = 'WZEIT'.
          WHEN 'PROCUREMENTTYPE'.
            ev_field = 'BESKZ'.
          WHEN 'PROCUREMENTSUBTYPE'.
            ev_field = 'SOBSL'.
          WHEN 'ASSEMBLYSCRAPPERCENT'.
            ev_field = 'AUSSS'.
          WHEN 'MRPGROUP'.
            ev_field = 'DISGR'.
          WHEN 'STORAGECOSTSPERCENTAGECODE'.
            ev_field = 'LAGPR'.
          WHEN 'RQMTQTYRCPTTAKTTMEINWRKGDAYS'.
            ev_field = 'TAKZT'.
          WHEN 'ROUNDINGPROFILE'.
            ev_field = 'RDPRF'.
          WHEN 'DFLTSTORAGELOCATIONEXTPROCMT'.
            ev_field = 'LGFSB'.
          WHEN 'MATLCOMPISMARKEDFORBACKFLUSH'.
            ev_field = 'RGEKZ'.
          WHEN 'PROPOSEDPRODUCTSUPPLYAREA'.
            ev_field = 'VSPVB'.
          WHEN 'ISBULKMATERIALCOMPONENT'.
            ev_field = 'SCHGT'.
          WHEN 'INHOUSEPRODUCTIONTIME'.
            ev_field = 'DZEIT'.
          WHEN 'PRODNPLNGANDCONTROLCALENDAR'.
            ev_field = 'MRPPP'.
          WHEN 'SCHEDULINGMARGINKEY'.
            ev_field = 'FHORI'.
          WHEN 'SRVCLVL'.
            ev_field = 'LGRAD'.
          WHEN 'RANGEOFCVRGPRFLCODE'.
            ev_field = 'RWPRO'.
          WHEN 'ISSAFETYTIME'.
            ev_field = 'SHFLG'.
          WHEN 'PERDPRFLFORSFTYTME'.
            ev_field = 'SHPRO'.
          WHEN 'FORECASTREQUIREMENTSARESPLIT'.
            ev_field = 'AUFTL'.
          WHEN 'PRODRQMTSCONSUMPTIONMODE'.
            ev_field = 'VRMOD'.
          WHEN 'BACKWARDCNSMPNPERIODINWORKDAYS'.
            ev_field = 'VINT1'.
          WHEN 'FWDCONSUMPTIONPERIODINWORKDAYS'.
            ev_field = 'VINT2'.
          WHEN 'MRPAVAILABILITYTYPE'.
            ev_field = 'MISKZ'.
          WHEN 'PRODUCTISFORCROSSPROJECT'.
            ev_field = 'KZPSP'.
          WHEN 'DEPENDENTREQUIREMENTSTYPE'.
            ev_field = 'SBDKZ'.
          WHEN 'COMPONENTSCRAPINPERCENT'.
            ev_field = 'KAUSF'.
          WHEN 'PRODRQMTSARECONSOLIDATED'.
            ev_field = 'KZBED'.
          WHEN 'ISMRPDEPENDENTRQMT'.
            ev_field = 'AHDIS'.
          WHEN 'PRODUCTISTOBEDISCONTINUED'.
            ev_field = 'KZAUS'.
          WHEN 'EFFECTIVEOUTDATE'.
            ev_field = 'AUSDT'.
          WHEN 'FOLLOWUPPRODUCT'.
            ev_field = 'NFMAT'.
          WHEN 'REPETITIVEMANUFACTURINGISALLWD'.
            ev_field = 'SAUFT'.
          WHEN 'REPETITIVEMANUFACTURINGPROFILE'.
            ev_field = 'SFEPR'.

            "XSIMPLEXA_PRDWORKSCHEDULINGTYPE
          WHEN 'MATERIALBASEQUANTITY'.
            ev_field = 'BASMG'.
          WHEN 'UNLIMITEDOVERDELIVISALLOWED'.
            ev_field = 'UEETK'.
          WHEN 'OVERDELIVTOLERANCELIMIT'.
            ev_field = 'UEETO'.
          WHEN 'UNDERDELIVTOLERANCELIMIT'.
            ev_field = 'UNETO'.
          WHEN 'PRODUCTPRODUCTIONQUANTITYUNIT'.
            ev_field = 'FRTME'.

            "XSIMPLEXA_PRDPLANTPROCUREMENTTYPE
          WHEN 'ISSOURCELISTREQUIRED'.
            ev_field = 'KORDB'.
          WHEN 'PRODUCTISCRITICALPRT'.
            ev_field = 'KZKRI'.
          WHEN 'MATERIALFREIGHTGROUP'.
            ev_field = 'MFRGR'.
          WHEN 'PRODUCTIONSUPERVISOR'.
            ev_field = 'FEVOR'.
          WHEN 'PRODUCTIONSCHEDULINGPROFILE'.
            ev_field = 'SFCPF'.
          WHEN 'PRODUCTLOGISTICSHANDLINGGROUP'.
            ev_field = 'LOGGR'.

          WHEN 'TRANSITIONMATRIXPRODUCTSGROUP'.
            ev_field = 'MATGR'.
          WHEN 'ORDERCHANGEMANAGEMENTPROFILE'.
            ev_field = 'OCMPF'.
          WHEN 'SETUPANDTEARDOWNTIME'.
            ev_field = 'RUEZT'.
          WHEN 'PRODUCTPROCESSINGTIME'.
            ev_field = 'BEARZ'.
          WHEN 'TRANSITIONTIME'.
            ev_field = 'TRANZ'.
          WHEN 'PACKAGINGMODE'.
            ev_field = 'ZZ_PACKAGING_MODE'.
          WHEN 'KANBANFLAG'.
            ev_field = 'ZZ_KANBAN'.
          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/IPPLANT'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field.


        ENDCASE.
      WHEN gc_entity-storagelocation.
        CASE iv_fieldname.
          WHEN 'STORAGELOCATION'.
            ev_field = 'LGORT'.
          WHEN 'STORAGELOCATIONFOREDIT'.
            ev_field = 'LGORT'.
          WHEN 'WAREHOUSESTORAGEBIN'.
            ev_field = 'LGPBE'.
          WHEN 'MAINTENANCESTATUS'.
            ev_field = 'PSTAT'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LVORM'.
          WHEN 'PHYSICALINVENTORYBLOCKIND'.
            ev_field = 'SPERR'.
          WHEN 'CREATIONDATE'.
            ev_field = 'ERSDA'.
          WHEN 'DATEOFLASTPOSTEDCNTUNRSTRCDSTK'.
            ev_field = 'DLINL'.
          WHEN 'INVENTORYCORRECTIONFACTOR'.
            ev_field = 'BSKRF'.
          WHEN 'INVTRYRESTRICTEDUSESTOCKIND'.
            ev_field = 'KZILE'.
          WHEN 'INVTRYCURRENTYEARSTOCKIND'.
            ev_field = 'KZILL'.
          WHEN 'INVTRYQUALINSPCURRENTYRSTKIND'.
            ev_field = 'KZILQ'.
          WHEN 'INVENTORYBLOCKSTOCKIND'.
            ev_field = 'KZILS'.
          WHEN 'INVTRYRESTSTOCKPREVPERIODIND'.
            ev_field = 'KZVLE'.
          WHEN 'INVENTORYSTOCKPREVPERIOD'.
            ev_field = 'KZVLL'.
          WHEN 'INVTRYSTOCKQLTYINSPPREVPERIOD'.
            ev_field = 'KZVLQ'.
          WHEN 'HASINVTRYBLOCKSTOCKPREVPERIOD'.
            ev_field = 'KZVLS'.
          WHEN 'FISCALYEARCURRENTPERIOD'.
            ev_field = 'LFGJA'.
          WHEN 'FISCALMONTHCURRENTPERIOD'.
            ev_field = 'LFMON'.
          WHEN 'FISCALYEARCURRENTINVTRYPERIOD'.
            ev_field = 'MDJIN'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'LEANWRHSMANAGEMENTPICKINGAREA'.
            ev_field = 'LWMKB'.
*          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/APRSLOC'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field
        ENDCASE.

      WHEN gc_entity-productsalestax.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'COUNTRY'.
            ev_field = 'ALAND'.
          WHEN 'TAXCATEGORY'.
            ev_field = 'TATYP'.
          WHEN 'TAXCLASSIFICATION'.
            ev_field = 'TAXKM'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productplantprocurement.
        CASE iv_fieldname.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'ISAUTOPURORDCREATIONALLOWED'.
            ev_field = 'KAUTB'.
          WHEN 'ISSOURCELISTREQUIRED'.
            ev_field = 'KORDB'.
          WHEN 'SOURCEOFSUPPLYCATEGORY' .
            ev_field = 'BWSCL'."PSTAT
          WHEN 'PURCHASINGGROUP'.
            ev_field = 'EKGRP'."PSTAT
          WHEN 'ISPURGACROSSPURGGROUP'.
            ev_field = 'MULTIPLE_EKGRP'."PSTAT
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productworkscheduling.
        CASE iv_fieldname.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'MATERIALBASEQUANTITY'.
            ev_field = 'BASMG'.
          WHEN 'UNLIMITEDOVERDELIVISALLOWED'.
            ev_field = 'UEETK'.
          WHEN 'OVERDELIVTOLERANCELIMIT'.
            ev_field = 'UEETO'.
          WHEN 'UNDERDELIVTOLERANCELIMIT'.
            ev_field = 'UNETO'.
*          WHEN 'GOODSISSUEUNIT' .               EV_FIELD = 'AUSME'.     "PSTAT
*          WHEN 'STOCKDETERMINATIONGROUP'.       EV_FIELD = 'EPRIO'.     "PSTAT
*          WHEN 'DISTRCNTRDISTRIBUTIONPROFILE'.  EV_FIELD = 'FPRFM'.     "PSTAT
*          WHEN 'PRODUCTCFOPCATEGORY'.           EV_FIELD = 'INDUS'.     "PSTAT
          WHEN 'PRODUCTIONINVTRYMANAGEDLOC'.
            ev_field = 'LGPRO'.     "PSTAT
*          WHEN 'PRODUCTUNITGROUP' .             EV_FIELD = 'MEGRU'.     "PSTAT
*          WHEN 'PROFILECODE'.                   EV_FIELD = 'MMSTA'.     "PSTAT
*          WHEN 'ISNEGATIVESTOCKALLOWED'.        EV_FIELD = 'XMCNG'.     "PSTAT
*          WHEN 'PROFILEVALIDITYSTARTDATE'.      EV_FIELD = 'MMSTD'.     "PSTAT
*          WHEN 'ISBATCHMANAGEMENTREQUIRED'.     EV_FIELD = 'XCHPF'.    "PSTAT
*          WHEN 'CONFIGURABLEPRODUCT'.           EV_FIELD = 'STDPD'.      "PSTAT
*          WHEN 'FISCALYEARVARIANT'.             EV_FIELD = 'PERIV'.     "PSTAT:MOVE
*          WHEN 'PERIODTYPE'.                    EV_FIELD = 'PERKZ'.     "PSTAT:MOVE
*          WHEN 'PROFITCENTER'.                  EV_FIELD = 'PRCTR'.     "PSTAT:MOVE
*          WHEN 'SERIALNUMBERPROFILE'.           EV_FIELD = 'SERNP'.     "PSTAT:MOVE

          WHEN OTHERS.

        ENDCASE.

      WHEN gc_entity-productsupplyplanning.
        CASE iv_fieldname.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'FIXEDLOTSIZEQUANTITY'.
            ev_field = 'BSTFE'.
          WHEN 'MAXIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMA'.
          WHEN 'MINIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMI'.
          WHEN 'LOTSIZEROUNDINGQUANTITY'.
            ev_field = 'BSTRF'.
          WHEN 'LOTSIZINGPROCEDURE'.
            ev_field = 'DISLS'.
          WHEN 'MRPTYPE'.
            ev_field = 'DISMM'.
          WHEN 'MRPRESPONSIBLE'.
            ev_field = 'DISPO'.
          WHEN 'SAFETYSTOCKQUANTITY'.
            ev_field = 'EISBE'.
          WHEN 'MINIMUMSAFETYSTOCKQUANTITY'.
            ev_field = 'EISLO'.
          WHEN 'PLANNINGTIMEFENCE'.
            ev_field = 'FXHOR'.
          WHEN 'ABCINDICATOR'.
            ev_field = 'MAABC'.
          WHEN 'MAXIMUMSTOCKQUANTITY'.
            ev_field = 'MABST'.
          WHEN 'REORDERTHRESHOLDQUANTITY'.
            ev_field = 'MINBE'.
          WHEN 'PLANNEDDELIVERYDURATIONINDAYS'.
            ev_field = 'PLIFZ'.
          WHEN 'SAFETYDURATION'.
            ev_field = 'SHZET'.
          WHEN 'PLANNINGSTRATEGYGROUP'.
            ev_field = 'STRGR'.
          WHEN 'TOTALREPLENISHMENTLEADTIME'.
            ev_field = 'WZEIT'.
          WHEN 'PROCUREMENTTYPE'.
            ev_field = 'BESKZ'.
          WHEN 'PROCUREMENTSUBTYPE'.
            ev_field = 'SOBSL'.
          WHEN 'LOADINGGROUP'.
            ev_field = 'LADGR'.
          WHEN 'ASSEMBLYSCRAPPERCENT'.
            ev_field = 'AUSSS'.
          WHEN 'GOODISSUEPROCESSINGDAYS' .
            ev_field = 'GI_PR_TIME'.   "PSTAT: MOVE
          WHEN 'AVAILABILITYCHECKTYPE'.
            ev_field = 'MTVFP'.        "PSTAT: MOVE
          WHEN 'GOODSRECEIPTDURATION'.
            ev_field = 'WEBAZ'.        "PSTAT: MOVE
          WHEN 'MRPGROUP'.
            ev_field = 'DISGR'.
          WHEN 'PLANANDORDERDAYDETERMINATION'.
            ev_field = 'LFRHY'.
          WHEN 'STORAGECOSTSPERCENTAGECODE'.
            ev_field = 'LAGPR'.
          WHEN 'RQMTQTYRCPTTAKTTMEINWRKGDAYS'.
            ev_field = 'TAKZT'.
          WHEN 'ROUNDINGPROFILE'.
            ev_field = 'RDPRF'.
          WHEN 'DFLTSTORAGELOCATIONEXTPROCMT'.
            ev_field = 'LGFSB'.
          WHEN 'MATLCOMPISMARKEDFORBACKFLUSH'.
            ev_field = 'RGEKZ'.
          WHEN 'PROPOSEDPRODUCTSUPPLYAREA'.
            ev_field = 'VSPVB'.
          WHEN 'ISBULKMATERIALCOMPONENT'.
            ev_field = 'SCHGT'.
          WHEN 'INHOUSEPRODUCTIONTIME'.
            ev_field = 'DZEIT'.
          WHEN 'PRODNPLNGANDCONTROLCALENDAR'.
            ev_field = 'MRPPP'.
          WHEN 'SCHEDULINGMARGINKEY'.
            ev_field = 'FHORI'.
          WHEN 'SRVCLVL'.
            ev_field = 'LGRAD'.
          WHEN 'RANGEOFCVRGPRFLCODE'.
            ev_field = 'RWPRO'.
          WHEN 'ISSAFETYTIME'.
            ev_field = 'SHFLG'.
          WHEN 'PERDPRFLFORSFTYTME'.
            ev_field = 'SHPRO'.
          WHEN 'FORECASTREQUIREMENTSARESPLIT'.
            ev_field = 'AUFTL'.
          WHEN 'PRODRQMTSCONSUMPTIONMODE'.
            ev_field = 'VRMOD'.
          WHEN 'BACKWARDCNSMPNPERIODINWORKDAYS'.
            ev_field = 'VINT1'.
          WHEN 'FWDCONSUMPTIONPERIODINWORKDAYS'.
            ev_field = 'VINT2'.
          WHEN 'MRPAVAILABILITYTYPE'.
            ev_field = 'MISKZ'.
          WHEN 'PRODUCTISFORCROSSPROJECT'.
            ev_field = 'KZPSP'.
          WHEN 'DEPENDENTREQUIREMENTSTYPE'.
            ev_field = 'SBDKZ'.
          WHEN 'COMPONENTSCRAPINPERCENT'.
            ev_field = 'KAUSF'.
          WHEN 'PRODRQMTSARECONSOLIDATED'.
            ev_field = 'KZBED'.
          WHEN 'ISMRPDEPENDENTRQMT'.
            ev_field = 'AHDIS'.
          WHEN 'PRODUCTISTOBEDISCONTINUED'.
            ev_field = 'KZAUS'.
          WHEN 'EFFECTIVEOUTDATE'.
            ev_field = 'AUSDT'.
          WHEN 'FOLLOWUPPRODUCT'.
            ev_field = 'NFMAT'.
          WHEN 'REPETITIVEMANUFACTURINGISALLWD'.
            ev_field = 'SAUFT'.
          WHEN 'REPETITIVEMANUFACTURINGPROFILE'.
            ev_field = 'SFEPR'.

        ENDCASE.
      WHEN gc_entity-productbasictext.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'LANGUAGE'.
            ev_field = 'LANGU'.
          WHEN 'LONGTEXT'.
            ev_field = 'NOTE'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productpurchasetext.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'LANGUAGE'.
            ev_field = 'LANGU'.
          WHEN 'LONGTEXT'.
            ev_field = 'NOTE'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productinspectiontext.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'LANGUAGE'.
            ev_field = 'LANGU'.
          WHEN 'LONGTEXT'.
            ev_field = 'NOTE'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productprocurement.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PURCHASEORDERQUANTITYUNIT'.
            ev_field = 'BSTME'.
          WHEN 'VARBLPURORDUNITSTATUS'.
            ev_field = 'VABME'.
          WHEN 'PURCHASINGACKNPROFILE'.
            ev_field = 'EKWSL'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productsales.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'SALESSTATUS'.
            ev_field = 'MSTAV'.
          WHEN 'SALESSTATUSVALIDITYDATE'.
            ev_field = 'MSTDV'.
          WHEN 'TAXCLASSIFICATION'.
            ev_field = 'TAKLV'.
          WHEN 'TRANSPORTATIONGROUP'.
            ev_field = 'TRAGR'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-plantsales.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'LOADINGGROUP'.
            ev_field = 'LADGR'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-planttext.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'LANGUAGE'.
            ev_field = 'LANGU'.
*          WHEN 'LONGTEXTID'.                    EV_FIELD = 'TDID'.
          WHEN 'LONGTEXT'.
            ev_field = 'NOTE'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-salestext.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PRODUCTSALESORG'.
            ev_field = 'VKORG'.
          WHEN 'PRODUCTDISTRIBUTIONCHNL'.
            ev_field = 'VTWEG'.
          WHEN 'LANGUAGE'.
            ev_field = 'LANGU'.
*          WHEN 'LONGTEXTID'.                    EV_FIELD = 'TDID'.
          WHEN 'LONGTEXT'.
            ev_field = 'NOTE'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productunitsofmeasure.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'ALTERNATIVEUNIT'.
            ev_field = 'MEINH'.
          WHEN 'QUANTITYNUMERATOR'.
            ev_field = 'UMREZ'.
          WHEN 'QUANTITYDENOMINATOR'.
            ev_field = 'UMREN'.
          WHEN 'MATERIALVOLUME'.
            ev_field = 'VOLUM'.
          WHEN 'VOLUMEUNIT'.
            ev_field = 'VOLEH'.
          WHEN 'GROSSWEIGHT'.
            ev_field = 'BRGEW'.
          WHEN 'WEIGHTUNIT'.
            ev_field = 'GEWEI'.
          WHEN 'GLOBALTRADEITEMNUMBER ' .
            ev_field =  'EAN11 '.
          WHEN 'GLOBALTRADEITEMNUMBERCATEGORY ' .
            ev_field =  'NUMTP'.
          WHEN 'UNITSPECIFICPRODUCTLENGTH ' .
            ev_field =  'LAENG'.
          WHEN 'UNITSPECIFICPRODUCTWIDTH ' .
            ev_field =  'BREIT'.
          WHEN 'UNITSPECIFICPRODUCTHEIGHT ' .
            ev_field =  'HOEHE'.
          WHEN 'PRODUCTMEASUREMENTUNIT ' .
            ev_field =  'MEABM'.
          WHEN 'LOWERLEVELPACKAGINGUNIT ' .
            ev_field =  'MESUB'.
*          EWM PACKAGING
          WHEN 'REMAININGVOLUMEAFTERNESTING'.
            ev_field = 'NEST_FTR'.
          WHEN 'MAXIMUMSTACKINGFACTOR'.
            ev_field = 'MAX_STACK'.
          WHEN 'CAPACITYUSAGE'.
            ev_field = 'CAPAUSE'.
          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/APRDUOM'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field.
        ENDCASE.

      WHEN gc_entity-internationalarticlenumber.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'ALTERNATIVEUNIT'.
            ev_field = 'MEINH'.
          WHEN 'PRODUCTSTANDARDID'.
            ev_field = 'EAN11'.
          WHEN 'INTERNATIONALARTICLENUMBERCAT'.
            ev_field = 'EANTP'.
          WHEN 'ISMAINGLOBALTRADEITEMNUMBER'.
            ev_field = 'HPEAN'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productqualitymgmt.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'QLTYMGMTINPROCMTISACTIVE'.
            ev_field = 'QMPUR'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productstorage.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'STORAGECONDITIONS'.
            ev_field = 'RAUBE'.
          WHEN 'TEMPERATURECONDITIONIND'.
            ev_field = 'TEMPB'.
          WHEN 'HAZARDOUSMATERIALNUMBER'.
            ev_field = 'STOFF'.
          WHEN 'NMBROFGRORGISLIPSTOPRINTQTY'.
            ev_field = 'WESCH'.
          WHEN 'LABELTYPE'.
            ev_field = 'ETIAR'.
          WHEN 'LABELFORM'.
            ev_field = 'ETIFO'.
          WHEN 'MINREMAININGSHELFLIFE'.
            ev_field = 'MHDRZ'.
          WHEN 'EXPIRATIONDATE'.
            ev_field = 'SLED_BBD'.
          WHEN 'SHELFLIFEEXPIRATIONDATEPERIOD'.
            ev_field = 'IPRKZ'.
          WHEN 'SHELFLIFEEXPRTNDATERNDINGRULE'.
            ev_field = 'RDMHD'.
          WHEN 'STORAGEBININSTRUCTION'.
            ev_field = 'BEHVO'.
          WHEN 'TOTALSHELFLIFE'.
            ev_field = 'MHDHB'.
          WHEN 'TOTALSHELFLIFESTORAGEPERCENT'.
            ev_field = 'MHDLP'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productplantcosting.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'ISCOPRODUCT'.
            ev_field = 'KZKUP'.
          WHEN 'TASKLISTTYPE'.
            ev_field = 'PLNTY'.

          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productplantforecast.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'CONSUMPTIONREFUSAGEENDDATE'.
            ev_field = 'VRBDT'.
          WHEN 'CONSUMPTIONQTYMULTIPLIER'.
            ev_field = 'VRBFK'.
          WHEN 'CONSUMPTIONREFERENCEPRODUCT'.
            ev_field = 'VRBMT'.
          WHEN 'CONSUMPTIONREFERENCEPLANT'.
            ev_field = 'VRBWK'.
          WHEN 'FORECASTMODELISRESET'.
            ev_field = 'AUTRU'.
          WHEN 'CORRECTIONFACTORISREQUIRED'.
            ev_field = 'KZKFK'.

          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-prodplantinternationaltrade.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'COUNTRYOFORIGIN'.
            ev_field = 'HERKL'.
          WHEN 'REGIONOFORIGIN'.
            ev_field = 'HERKR'.
          WHEN 'CONSUMPTIONTAXCTRLCODE'.
            ev_field = 'STEUC'.
          WHEN 'MATERIALFREIGHTGROUP'.
            ev_field = 'MFRGR'.
          WHEN 'EXPORTANDIMPORTPRODUCTGROUP'.
            ev_field = 'MTVER'.
          WHEN 'PRODUCTCASNUMBER'.
            ev_field = 'CASNR'.
          WHEN 'PRODINTLTRADECLASSIFICATION'.
            ev_field = 'GPNUM'.

          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-plantstorage.
        CASE iv_fieldname.
          WHEN 'INVENTORYFORCYCLECOUNTIND'.
            ev_field = 'ABCIN'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'INVENTORYFORCYCLECOUNTIND'.
            ev_field = 'ABCIN'.
*          WHEN 'PROVISIONINGSERVICELEVEL'.      EV_FIELD = 'SERVG'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-plantqualitymgmt.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'MAXIMUMSTORAGEPERIOD'.
            ev_field = 'MAXLZ'.
          WHEN 'QUALITYMGMTCTRLKEY'.
            ev_field = 'SSQSS'.
          WHEN 'MATLQUALITYAUTHORIZATIONGROUP'.
            ev_field = 'QMATA'.
          WHEN 'HASPOSTTOINSPECTIONSTOCK'.
            ev_field = 'INSMK'.
          WHEN 'INSPLOTDOCUMENTATIONISREQUIRED'.
            ev_field = 'KZDKZ'.
          WHEN 'RECRRGINSPINTERVALTIMEINDAYS'.
            ev_field = 'PRFRQ'.
          WHEN 'PRODUCTQUALITYCERTIFICATETYPE'.
            ev_field = 'QZGTP'.
          WHEN 'SUPLRQUALITYMANAGEMENTSYSTEM'.
            ev_field = 'QSSYS'.

          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-plantmrparea.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'MAINTENANCESTATUSNAME'.
            ev_field = 'PSTAT'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LOEKZ'.
          WHEN 'MRPAREA'.
            ev_field = 'BERID'.
          WHEN 'FIXEDLOTSIZEQUANTITY'.
            ev_field = 'BSTFE'.
          WHEN 'MAXIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMA'.
          WHEN 'MINIMUMLOTSIZEQUANTITY'.
            ev_field = 'BSTMI'.
          WHEN 'LOTSIZEROUNDINGQUANTITY'.
            ev_field = 'BSTRF'.
          WHEN 'LOTSIZINGPROCEDURE'.
            ev_field = 'DISLS'.
          WHEN 'MRPTYPE'.
            ev_field = 'DISMM'.
          WHEN 'MRPRESPONSIBLE'.
            ev_field = 'DISPO'.
          WHEN 'SAFETYSTOCKQUANTITY'.
            ev_field = 'EISBE'.
*          WHEN 'MINIMUMSAFETYSTOCKQUANTITY'.    EV_FIELD = 'EISLO'.
          WHEN 'PLANNINGTIMEFENCE'.
            ev_field = 'FXHOR'.
          WHEN 'MAXIMUMSTOCKQUANTITY'.
            ev_field = 'MABST'.
          WHEN 'REORDERTHRESHOLDQUANTITY'.
            ev_field = 'MINBE'.
          WHEN 'PLANNEDDELIVERYDURATIONINDAYS'.
            ev_field = 'PLIFZ'.
          WHEN 'SAFETYDURATION'.
            ev_field = 'SHZET'.
          WHEN 'PROCUREMENTSUBTYPE'.
            ev_field = 'SOBSL'.
          WHEN 'ASSEMBLYSCRAPPERCENT'.
            ev_field = 'AUSSS'.
*          WHEN 'GOODISSUEPROCESSINGDAYS' .      EV_EV_FIELD = 'GI_PR_TIME'.

          WHEN  'DFLTSTORAGELOCATIONEXTPROCMT'.
            ev_field =  'LGFSB'.
*DELTA FIELDS (COMMON FOR PLANT AND MRP AREAS
          WHEN 'MRPGROUP'.
            ev_field = 'DISGR'.
          WHEN 'LOTSIZEINDEPENDENTCOSTS'.
            ev_field = 'LOSFX'.
          WHEN 'ISSTORAGECOSTS'.
            ev_field = 'LAGPR'.
          WHEN 'TAKTTIME'.
            ev_field = 'TAKZT'.
          WHEN 'RQMTQTYRCPTTAKTTMEINWRKGDAYS'.
            ev_field = 'TAKZT'.
          WHEN 'MRPPLANNINGCALENDAR'.
            ev_field = 'MRPPP'.
          WHEN 'ISPLANNEDDELIVERYTIME'.
            ev_field = 'PLIFZX'.
          WHEN 'RANGEOFCVRGPRFLCODE'.
            ev_field = 'RWPRO'.
          WHEN 'ISSAFETYTIME'.
            ev_field = 'SHFLG'.
          WHEN 'PERDPRFLFORSFTYTME'.
            ev_field = 'SHPRO'.
          WHEN 'ISMRPDEPENDENTRQMT'.
            ev_field = 'AHDIS'.
          WHEN 'SRVCLVL'.
            ev_field = 'LGRAD'.

*MISSING FIELDS
          WHEN 'REFMATLCONSUMPTION'.
            ev_field = 'VRBMT'.
          WHEN 'REFERENCEMRPAREACONSUMPTION'.
            ev_field = 'VRBDB'.
          WHEN 'MULTIPLIER'.
            ev_field = 'VRBFK'.
          WHEN 'CORRECTIONFACTORS'.
            ev_field = 'KZKFK'.
          WHEN 'TARGETDAYSUPPLY'.
            ev_field = 'SCM_TARGET_DUR'.
          WHEN 'GRPROCESSNGTIME'.
            ev_field = 'SCM_GRPRT'.
          WHEN 'GIPROCESSNGTIME'.
            ev_field = 'SCM_GIPRT'.
          WHEN 'CREATIONDATE'.
            ev_field = 'VRBDT'.
          WHEN 'PRODUCTPLANNINGGROUP'.
            ev_field = 'SCM_RRP_SEL_GROUP'.
          WHEN 'GRHANDLINGCAPACITYQUANTITY'.
            ev_field = 'SCM_CONHAP'.
          WHEN 'GIHANDLINGCAPACITYQUANTITY'.
            ev_field = 'SCM_CONHAP_OUT'.

          WHEN 'STORAGELOCATION'.
            ev_field = 'LGPRO'.
          WHEN 'PPPLANNINGPROCEDURE'.
            ev_field = 'SCM_RRP_TYPE'.
          WHEN 'PRODNPLNGHEURISTIC'.
            ev_field = 'SCM_HEUR_ID'.
          WHEN 'PRODUCTPLANNINGPACKAGE'.
            ev_field = 'SCM_PACKAGE_ID'.
          WHEN 'LOTSIZEUNIT'.
            ev_field = 'SCM_LSUOM'.
          WHEN 'PLNGCALENDARPERDCLOTSIZING'.
            ev_field = 'SCM_TSTRID'.
          WHEN 'GRHANDLINGCAPACITYUNIT'.
            ev_field = 'SCM_HUNIT'.
          WHEN 'GIHANDLINGCAPACITYUNIT'.
            ev_field = 'SCM_HUNIT_OUT'.
        ENDCASE.

      WHEN gc_entity-valuation.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'VALUATIONAREA'.
            ev_field = 'BWKEY'.
          WHEN 'VALUATIONTYPE'.
            ev_field = 'BWTAR'.
          WHEN 'VALUATIONCLASS'.
            ev_field = 'BKLAS'.
          WHEN 'PRICEDETERMINATIONCONTROL'.
            ev_field = 'MLAST'.
          WHEN 'STANDARDPRICE'.
            ev_field = 'STPRS'.
          WHEN 'PRICEUNITQTY'.
            ev_field = 'PEINH'.
          WHEN 'INVENTORYVALUATIONPROCEDURE'.
            ev_field = 'VPRSV'.
*          WHEN 'INVENTORYVALUATIONPROCEDURE'.    EV_FIELD = 'SALKV'.
          WHEN 'MOVINGAVERAGEPRICE'.
            ev_field = 'VERPR'.
          WHEN 'VALUATIONCATEGORY'.
            ev_field = 'BWTTY'.
          WHEN 'PRODUCTUSAGETYPE'.
            ev_field = 'MTUSE'.
          WHEN 'PRODUCTORIGINTYPE'.
            ev_field = 'MTORG'.
          WHEN 'ISPRODUCEDINHOUSE'.
            ev_field = 'OWNPR'.
          WHEN 'PRODCOSTESTNUMBER'.
            ev_field = 'KALN1'.
          WHEN 'ISMARKEDFORDELETION'.
            ev_field = 'LVORM'.
          WHEN 'VALUATIONMARGIN'.
            ev_field = 'BWSPA'. "// RETAIL
          WHEN 'VALUATIONCLASSSALESORDERSTOCK'.
            ev_field = 'EKLAS'.
          WHEN 'PROJECTSTOCKVALUATIONCLASS'.
            ev_field = 'QKLAS'.
          WHEN 'PLANNEDPRICE1INCOCODECRCY'.
            ev_field = 'ZPLP1'.
          WHEN 'PLANNEDPRICE2INCOCODECRCY'.
            ev_field = 'ZPLP2'.
          WHEN 'PLANNEDPRICE3INCOCODECRCY'.
            ev_field = 'ZPLP3'.
          WHEN 'FUTUREPLNDPRICE1VALDTYDATE'.
            ev_field = 'ZPLD1'.
          WHEN 'FUTUREPLNDPRICE2VALDTYDATE'.
            ev_field = 'ZPLD2'.
          WHEN 'FUTUREPLNDPRICE3VALDTYDATE'.
            ev_field = 'ZPLD3'.
          WHEN 'TAXBASEDPRICESPRICEUNITQTY'.
            ev_field = 'BWPEI'.
          WHEN 'PRICELASTCHANGEDATE'.
            ev_field = 'LAEPR'.
          WHEN 'PLANNEDPRICE'.
            ev_field = 'ZPLPR'.
          WHEN 'PREVINVTRYPRICEINCOCODECRCY'.
            ev_field = 'STPRV'.
* MISSING FIELDS
          WHEN 'VALUATEDUOM'.
            ev_field = 'XBEWM'.
          WHEN 'WITHQTYSTRUCTURE'.
            ev_field = 'EKALR'.
          WHEN 'MATERIALORIGIN'.
            ev_field = 'HKMAT'.
          WHEN 'ORIGINGROUP'.
            ev_field = 'HRKFT'.
          WHEN 'OVERHEADGROUP'.
            ev_field = 'KOSGR'.
          WHEN 'CURRENTPERIOD'.
            ev_field = 'PPRDL'.
          WHEN 'CURRENTFISCALYEAR'.
            ev_field = 'PDATL'.
          WHEN 'PREVIOUSPERIOD'.
            ev_field = 'PPRDV'.
          WHEN 'PREVIOUSFISCALYEAR'.
            ev_field = 'PDATV'.
          WHEN 'PREVIOUSPLANNEDPRICE'.
            ev_field = 'VPLPR'.

            "-VALUATION ACCOUNT
          WHEN 'COMMERCIALPRICE1INCOCODECRCY'.
            ev_field = 'BWPRH'.
          WHEN 'COMMERCIALPRICE2INCOCODECRCY'.
            ev_field = 'BWPH1'.
          WHEN 'COMMERCIALPRICE3INCOCODECRCY'.
            ev_field = 'VJBWH'.
          WHEN 'DEVALUATIONYEARCOUNT'.
            ev_field = 'ABWKZ'.
          WHEN 'FUTUREEVALUATEDAMOUNTVALUE'.
            ev_field = 'ZKPRS'.
          WHEN 'FUTUREPRICEVALIDITYSTARTDATE'.
            ev_field = 'ZKDAT'.
          WHEN 'ISLIFOANDFIFORELEVANT'.
            ev_field = 'XLIFO'.
          WHEN 'LIFOVALUATIONPOOLNUMBER'.
            ev_field = 'MYPOL'.
          WHEN 'TAXPRICEL1INCOCODECRCY'.
            ev_field = 'BWPRS'.
          WHEN 'TAXPRICE2INCOCODECRCY'.
            ev_field = 'BWPS1'.
          WHEN 'TAXPRICE3INCOCODECRCY'.
            ev_field = 'VJBWS'.
          WHEN 'TAXCLASSIFICATIONCATEGORY'.
            ev_field = 'MLMAA'.
          WHEN 'FUTURECOSTESTIMATEFISCALPERIOD'.
            ev_field = 'PPRDZ'.
          WHEN 'FUTURECOSTESTFISCALYEAR'.
            ev_field = 'PDATZ'.

          WHEN OTHERS.
*            CALL METHOD get_extended_field
*              EXPORTING
*                iv_cdsview_name = '/SIMPLE/APRDVAL'
*                iv_field        = iv_fieldname
*              RECEIVING
*                rt_field_name   = ev_field.
        ENDCASE.

      WHEN gc_entity-valuationaccount.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'VALUATIONAREA'.
            ev_field = 'BWKEY'.
          WHEN 'VALUATIONTYPE'.
            ev_field = 'BWTAR'.
          WHEN  'COMMERCIALPRICE1INCOCODECRCY'.
            ev_field = 'BWPRH'.
          WHEN  'COMMERCIALPRICE2INCOCODECRCY'.
            ev_field = 'BWPH1'.
          WHEN  'COMMERCIALPRICE3INCOCODECRCY'.
            ev_field = 'VJBWH'.
          WHEN  'DEVALUATIONYEARCOUNT'.
            ev_field = 'ABWKZ'.
          WHEN  'FUTUREEVALUATEDAMOUNTVALUE'.
            ev_field = 'ZKPRS'.
          WHEN  'FUTUREPRICEVALIDITYSTARTDATE'.
            ev_field = 'ZKDAT'.
          WHEN  'ISLIFOANDFIFORELEVANT'.
            ev_field = 'XLIFO'.
          WHEN  'LIFOVALUATIONPOOLNUMBER'.
            ev_field = 'MYPOL'.
          WHEN  'TAXPRICEL1INCOCODECRCY'.
            ev_field = 'BWPRS'.
          WHEN  'TAXPRICE2INCOCODECRCY'.
            ev_field = 'BWPS1'.
          WHEN  'TAXPRICE3INCOCODECRCY'.
            ev_field = 'VJBWS'.
*          WHEN   'TAXBASEDPRICESPRICEUNITQTY'.         EV_FIELD = 'BWPEI'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-mlaccount.
        CASE iv_fieldname.

          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'VALUATIONAREA'.
            ev_field = 'BWKEY'.
          WHEN 'VALUATIONTYPE'.
            ev_field = 'BWTAR'.
*          WHEN 'PRODCOSTESTNUMBER'.   EV_FIELD = 'KALNR'.
          WHEN 'CURRENCYROLE'.
            ev_field = 'CURTP'.
          WHEN 'CURRENCY'.
            ev_field = 'WAERS'.
          WHEN 'PRODUCTPRICECONTROL'.
            ev_field = 'VPRSV'.
          WHEN 'PRICEUNITQTY'.
            ev_field = 'PEINH'.
          WHEN 'MOVINGAVERAGEPRICE'.
            ev_field = 'PVPRS'.
          WHEN 'STANDARDPRICE'.
            ev_field = 'STPRS'.

          WHEN OTHERS.

        ENDCASE.

      WHEN gc_entity-mlprices.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'VALUATIONAREA'.
            ev_field = 'BWKEY'.
          WHEN 'VALUATIONTYPE'.
            ev_field = 'BWTAR'.
*          WHEN 'PRODCOSTESTNUMBER'.            EV_FIELD = 'KALNR'.
          WHEN 'CURRENCYROLE'.
            ev_field = 'CURTP'.
          WHEN 'FUTUREPRICE'.
            ev_field = 'ZKPRS'   .
          WHEN 'FUTUREPRICEVALIDITYSTARTDATE'.
            ev_field = 'ZPRSDAT'.
          WHEN 'PLANNEDPRICE'.
            ev_field = 'ZPLPR'.
          WHEN 'PRICEUNITQTY'.
            ev_field = 'PEINH'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-insptypesttng.
        CASE iv_fieldname.
          WHEN 'INSPECTIONLOTTYPE'.
            ev_field = 'ART'.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'INSPLOTISTASKLISTREQUIRED'.
            ev_field = 'PPL'.
          WHEN 'INSPLOTHASMATERIALSPEC'.
            ev_field = 'SPEZUEBER'.
          WHEN 'INSPLOTHASCONFIGNSPECIFICATION'.
            ev_field = 'CONF'.
          WHEN 'INSPLOTHASBATCHCHARC'.
            ev_field = 'TLS'.
          WHEN 'INSPLOTHASAUTOMSPECASSGMT'.
            ev_field = 'APP'.
          WHEN 'INSPLOTHASCHARC'.
            ev_field = 'MER'.
          WHEN 'HASPOSTTOINSPECTIONSTOCK'.
            ev_field = 'INSMK'.
          WHEN 'INSPLOTISAUTOMUSGEDCSNPOSSIBLE'.
            ev_field = 'AVE'.
          WHEN 'SAMPLINGPROCEDURE'.
            ev_field = 'STICHPRVER'.
          WHEN 'INSPLOTDYNAMICRULE'.
            ev_field = 'DYNREGEL'.
          WHEN 'INSPLOTSAMPLEQUANTITYINPERCENT'.
            ev_field = 'SPROZ'.
          WHEN 'INSPECTIONLOTISFULLINSPECTION'.
            ev_field = 'HPZ'.
          WHEN 'INSPLOTSKIPISALLOWED'.
            ev_field = 'DYN'.
          WHEN 'INSPLOTHASMANUALSAMPLESIZE'.
            ev_field = 'MPB'.
          WHEN 'INSPLOTISSMPLCALCMNLTRIGGERED'.
            ev_field = 'MST'.
          WHEN 'INSPLOTISSERIALNMBRPOSSIBLE'.
            ev_field = 'EIN'.
          WHEN 'INSPLOTDURATIONINDAYS'.
            ev_field = 'MPDAU'.
          WHEN 'INSPLOTSUMMARYCONTROL'.
            ev_field = 'CHG'.
          WHEN 'INSPQUALITYSCOREPROCEDURE'.
            ev_field = 'QKZVERF'.
          WHEN 'INSPLOTACCEPTEDSCRAPRATIOINPCT'.
            ev_field = 'QPMAT'.
          WHEN 'INSPECTIONLOTHASAPPRAISALCOSTS'.
            ev_field = 'KZPRFKOST'.
          WHEN 'QUALITYCOSTCOLLECTOR'.
            ev_field = 'AUFNR_CO'.
          WHEN 'PRODINSPTYPESETTINGISACTIVE'.
            ev_field = 'AKTIV'.
          WHEN 'INSPTYPEISPRFRD'.
            ev_field = 'APA'.
          WHEN 'INSPLOTHASHANDLINGUNIT'.
            ev_field = 'AFR'.
          WHEN 'INSPLOTHASMULTIPLESPEC'.
            ev_field = 'MS_FLAG'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-prodplntfcstparam.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PRODPLNTFCSTPARAMETERSPOINTER'.
            ev_field = 'PNUM1'.
          WHEN 'PRODPLNTFCSTPROFILE'.
            ev_field = 'PROPR'.
          WHEN 'PRODPLNTFCSTBSCVALALPHAFACTOR'.
            ev_field = 'ALPHA'.
          WHEN 'PRODPLNTNUMBEROFFORECASTPERIOD'.
            ev_field = 'ANZPR'.
          WHEN 'PRODPLNTFCSTTRENDVALBETAFACTOR'.
            ev_field = 'BETA1'.
          WHEN 'PRODPLNTMEANABSLTDVTNDELTAFCTR'.
            ev_field = 'DELTA'.
          WHEN 'PRODPLNTFCSTNMBROFFIXEDPERIOD'.
            ev_field = 'FIMON'.
          WHEN 'PRODPLNTFCSTSEASNLIDXGAMMAFCTR'.
            ev_field = 'GAMMA'.
          WHEN 'PRODPLNTFCSTEPSILONFCTR'.
            ev_field = 'EPSIL'.
          WHEN 'PRODPLNTFCSTWEIGHTINGGROUP'.
            ev_field = 'GEWGR'.
          WHEN 'FCSTMODELINITIALIZATIONMETHOD'.
            ev_field = 'KZINI'.
          WHEN 'PRODPLNTFCSTPARAMISOPTIMIZED'.
            ev_field = 'KZPAR'.
          WHEN 'PRODPLNTFCSTMODSELPROCEDURE'.
            ev_field = 'MODAV'.
          WHEN 'PRODPLNTFCSTMODSELMETHOD'.
            ev_field = 'MODAW'.
          WHEN 'OPTIMIZATIONLEVEL'.
            ev_field = 'OPGRA'.
          WHEN 'HISTLPERIODCOUNTFORFORECAST'.
            ev_field = 'PERAN'.
          WHEN 'PERDSCNTFORFCSTINITIALIZATION'.
            ev_field = 'PERIN'.
          WHEN 'FCSTPERDCNTPERSEASNCYC'.
            ev_field = 'PERIO'.
          WHEN 'DATEOFLASTFORECAST'.
            ev_field = 'PRDAT'.
          WHEN 'PERDSCNTFOREXPOSTFORECAST'.
            ev_field = 'PEREX'.
          WHEN 'FORECASTMODEL'.
            ev_field = 'PRMOD'.
          WHEN 'FORECASTVALUETRACKINGLIMIT'.
            ev_field = 'SIGGR'.
          WHEN 'BASICVALUE'.
            ev_field = 'GWERT'.
          WHEN 'BASICVALUEOF2NDORDER1'.
            ev_field = 'GWER1'.
          WHEN 'BASICVALUEOF2NDORDER2'.
            ev_field = 'GWER2'.
          WHEN 'BASICVALUEPREV'.
            ev_field = 'VMGWE'.
          WHEN 'BASICVALUEOF2NDORDERPREV1'.
            ev_field = 'VMGW1'.
          WHEN 'BASICVALUEOF2NDORDERPREV2'.
            ev_field = 'VMGW2'.
          WHEN 'TRENDVALUE'.
            ev_field = 'TWERT'.
          WHEN 'TRENDVALUEPREV'.
            ev_field = 'VMTWE'.
          WHEN 'MEANABSOLUTEDEVIATION'.
            ev_field = 'PRMAD'.
          WHEN 'MEANABSOLUTEDEVIATIONPREV'.
            ev_field = 'VMMAD'.
          WHEN 'ERRORTOTAL'.
            ev_field = 'FSUMM'.
          WHEN 'ERRORTOTALPREV'.
            ev_field = 'VMFSU'.
          WHEN 'WEIGHTINGGROUP'.
            ev_field = 'GEWGR'.
          WHEN 'THEILCOEFFICIENT'.
            ev_field = 'THKOF'.
          WHEN 'EXCEPTIONMESSAGEBAR'.
            ev_field = 'AUSNA'.
          WHEN 'FORECASTFLOWCONTROL'.
            ev_field = 'PROAB'.
          WHEN OTHERS.
        ENDCASE.

      WHEN gc_entity-productionresourcetool.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PRTUSAGE'.
            ev_field ='PLANV' .
          WHEN 'GROUPINGKEY1'.
            ev_field ='FGRU1'.
          WHEN 'GROUPINGKEY2'.
            ev_field ='FGRU2'.
          WHEN 'PRTCONTROLPROFILE'.
            ev_field ='STEUF'.
          WHEN 'REFERINDPRTCONTROLPROFILE'.
            ev_field ='STEUF_REF'.
          WHEN 'STANDARDTEXTKEY'.
            ev_field ='KTSCH'.
          WHEN 'REFERINDSTANDARDTEXTKEY'.
            ev_field ='KTSCH_REF'.
          WHEN 'QUANTITYFORMULA'.
            ev_field ='MGFORM'.
          WHEN 'REFERINDQUANTITYFORMULA'.
            ev_field ='MGFORM_REF'.
          WHEN 'USAGEVALUEFORMULA'.
            ev_field ='EWFORM'.
          WHEN 'REFERINDUSAGEVALUEFORMULA'.
            ev_field ='EWFORM_REF'.
          WHEN 'REFDATEFORSTART'.
            ev_field ='BZOFFB'.
          WHEN 'REFINDREFDATEFORSTART'.
            ev_field ='BZOFFB_REF'.
          WHEN 'OFFSETTOSTART'.
            ev_field ='OFFSTB'.
          WHEN 'STARTOFFSETUNIT'.
            ev_field ='EHOFFB'.
          WHEN 'REFINDOFFSETTOSTART'.
            ev_field ='OFFSTB_REF'.
          WHEN 'REFDATEFORFINISH'.
            ev_field ='BZOFFE'.
          WHEN 'REFINDREFDATEFORFINISH'.
            ev_field ='BZOFFE_REF'.
          WHEN 'OFFSETTOFINISH'.
            ev_field ='OFFSTE'.
          WHEN 'OFFSETENDUNIT'.
            ev_field ='EHOFFE'.
          WHEN 'REFINDOFFSETTOEND'.
            ev_field ='OFFSTE_REF'.
        ENDCASE.
      WHEN gc_entity-productplanning.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'PLANT'.
            ev_field = 'WERKS'.
          WHEN 'PLANNINGMATERIAL'.
            ev_field = 'PRGRP'.
          WHEN 'PLANNINGPLANT'.
            ev_field = 'PRWRK'.
          WHEN 'PLNGCONVFACTOR'.
            ev_field = 'UMREF'.
        ENDCASE.
        "" JHOANG add on 20/10/2023 - start
      WHEN gc_entity-prdextendwarehouse.
        CASE iv_fieldname.
          WHEN 'PRODUCT'.
            ev_field = 'MATNR'.
          WHEN 'EXTENDWHNUMBER'.
            ev_field = 'LGNUM'.
          WHEN 'ENTITLEDDISPOSE'.
            ev_field = 'PARTNER'.
          WHEN 'MATID'.
            ev_field = 'MATID'.
          WHEN 'SCUGUID'.
            ev_field = 'SCUGUID'.
          WHEN 'PARTNER_GUID'.
            ev_field = 'ENTITLED_ID'.
          WHEN 'PROCTYPEINDICATOR'.
            ev_field = 'PTDETIND'.
          WHEN 'COUNTINGINDICATOR'.
            ev_field = 'CCIND'.
          WHEN 'PUTAWAYCONTROL'.
            ev_field = 'PUT_STRA'.
          WHEN 'STOCKREMOVALCONTROL'.
            ev_field = 'REM_STRA'.
        ENDCASE.
      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.


  METHOD _map_messages.
    DATA msgvx TYPE symsgv.
*   DATA MSGV2 TYPE SYMSGV.
    DATA : lv_fieldtext    TYPE msgv1,
           lv_fieldname    TYPE fname_full,
           lv_tablefield   TYPE char30,
           lv_tablefield_d TYPE char30.
*            LV_FIELDNAME2   TYPE fname_full.
    DATA: lo_pmd TYPE REF TO cl_cmd_product_maint_api.

*    create object msg.
*    cl_cmd_product_maint_api=>get_instance(
*      IMPORTING
*        eo_cmd_product_maint_api = lo_pmd                 " Product Maintain API
*    ).

    CALL METHOD cl_prd_draft_helper=>replace_msg
      EXPORTING
        imp_msgid = is_msg-msgid   " Message Class
        imp_msgno = is_msg-msgno  " Message Number
      IMPORTING
        ex_msgno  = DATA(msgno_exp).  " Message Number


    IF msgno_exp IS NOT INITIAL.
      es_msg-msgno = msgno_exp .
      es_msg-msgid =  'CI_DRAFTPRD_MESSAGE'.
      es_msg-msgty = is_msg-msgty.
      IF is_msg-msgv1 IS NOT INITIAL.
*   ES_MSG-MSGV1 = IS_MSG-MSGV1.
        msgvx = is_msg-msgv1.
        TRANSLATE msgvx TO UPPER CASE.
        REPLACE ALL OCCURRENCES OF 'MATERIAL' IN msgvx WITH 'Product' IGNORING CASE.
        IF sy-subrc <> 0.
          lv_tablefield = is_msg-msgv1.
          lv_tablefield_d = _map_fieldname_ext( lv_tablefield ).
          IF lv_tablefield_d IS NOT INITIAL.
            lv_fieldtext = _get_tablefield_info( lv_tablefield_d ).
          ELSE.
            lv_fieldtext = _get_tablefield_info( lv_tablefield ).
          ENDIF.
          IF lv_fieldtext IS NOT INITIAL.
            es_msg-msgv1 = lv_fieldtext.
          ELSE.
            es_msg-msgv1 = msgvx.
          ENDIF.
        ELSE.
          es_msg-msgv1 = msgvx.
        ENDIF.
      ELSE.
        es_msg-msgv1 = is_msg-msgv1.
      ENDIF.
      es_msg-msgv2 = is_msg-msgv2.
      es_msg-msgv3 = is_msg-msgv3.
      es_msg-msgv4 = is_msg-msgv4.

    ELSE.

      es_msg-msgno = is_msg-msgno.
      es_msg-msgty = is_msg-msgty.
      es_msg-msgid = is_msg-msgid.

*     LV_FIELDNAME1 = IS_MSG-MSGV1.
      SEARCH is_msg-msgv1 FOR '-'.
      IF sy-subrc = 0.
        lv_fieldname = is_msg-msgv1.
        lv_fieldtext = _get_field_info( lv_fieldname ).
        IF lv_fieldtext IS NOT INITIAL.
          REPLACE ALL OCCURRENCES OF 'Material' IN lv_fieldtext WITH 'Product' IGNORING CASE.
          es_msg-msgv1 = lv_fieldtext.
        ELSE.
          es_msg-msgv1 = is_msg-msgv1.
        ENDIF.
      ELSE.
********    GET INFORMATION ABOUT TABLE AND FIELD
        lv_tablefield = is_msg-msgv1.
        lv_tablefield_d = _map_fieldname_ext( lv_tablefield ).
        IF lv_tablefield_d IS NOT INITIAL.
          lv_fieldtext = _get_tablefield_info( lv_tablefield_d ).
        ELSE.
          lv_fieldtext = _get_tablefield_info( lv_tablefield ).
        ENDIF.
        IF lv_fieldtext IS NOT INITIAL.
          es_msg-msgv1 = lv_fieldtext.
        ELSE.
***********************
          msgvx = is_msg-msgv1.
          REPLACE ALL OCCURRENCES OF 'Material' IN msgvx WITH 'Product' IGNORING CASE.
          es_msg-msgv1 = msgvx.
        ENDIF.
      ENDIF.

*     LV_FIELDNAME2 = IS_MSG-MSGV2.
      SEARCH is_msg-msgv2 FOR '-'.
      IF sy-subrc = 0.
        lv_fieldname = is_msg-msgv2.
        lv_fieldtext = _get_field_info( lv_fieldname ).
        IF lv_fieldtext IS NOT INITIAL.
          REPLACE ALL OCCURRENCES OF 'Material' IN lv_fieldtext WITH 'Product' IGNORING CASE.
          es_msg-msgv2 = lv_fieldtext.
        ELSE.
          es_msg-msgv2 = is_msg-msgv2.
        ENDIF.
      ELSE.
*       *** *******    GET INFORMATION ABOUT TABLE AND FIELD
        lv_tablefield = is_msg-msgv2.
        lv_tablefield_d = _map_fieldname_ext( lv_tablefield ).
        IF lv_tablefield_d IS NOT INITIAL.
          lv_fieldtext = _get_tablefield_info( lv_tablefield_d ).
        ELSE.
          lv_fieldtext = _get_tablefield_info( lv_tablefield ).
        ENDIF.
*       LV_FIELDTEXT = GET_TABLEFIELD_INFO( LV_TABLEFIELD ).
        IF lv_fieldtext IS NOT INITIAL.
          es_msg-msgv2 = lv_fieldtext.
        ELSE.
*  ***********************
          msgvx = is_msg-msgv2.
          REPLACE ALL OCCURRENCES OF 'Material' IN msgvx WITH 'Product' IGNORING CASE.
          es_msg-msgv2 = msgvx.
        ENDIF.
      ENDIF.

      SEARCH is_msg-msgv3 FOR '-'.
      IF sy-subrc = 0.
        lv_fieldname = is_msg-msgv3.
        lv_fieldtext = _get_field_info( lv_fieldname ).
        IF lv_fieldtext IS NOT INITIAL.
          REPLACE ALL OCCURRENCES OF 'Material' IN lv_fieldtext WITH 'Product' IGNORING CASE.
          es_msg-msgv3 = lv_fieldtext.
        ELSE.
          es_msg-msgv3 = is_msg-msgv3.
        ENDIF.
      ELSE.

*         *** *******    GET INFORMATION ABOUT TABLE AND FIELD
        lv_tablefield = is_msg-msgv3.
        lv_tablefield_d = _map_fieldname_ext( lv_tablefield ).
        IF lv_tablefield_d IS NOT INITIAL.
          lv_fieldtext = _get_tablefield_info( lv_tablefield_d ).
        ELSE.
          lv_fieldtext = _get_tablefield_info( lv_tablefield ).
        ENDIF.
*       LV_FIELDTEXT = GET_TABLEFIELD_INFO( LV_TABLEFIELD ).
        IF lv_fieldtext IS NOT INITIAL.
          es_msg-msgv3 = lv_fieldtext.
        ELSE.
*  ***********************
          msgvx = is_msg-msgv3.
          REPLACE ALL OCCURRENCES OF 'Material' IN msgvx WITH 'Product'.
          es_msg-msgv3 =  msgvx.
        ENDIF.
      ENDIF.


      SEARCH is_msg-msgv4 FOR '-'.
      IF sy-subrc = 0.
        lv_fieldname = is_msg-msgv4.
        lv_fieldtext = _get_field_info( lv_fieldname ).
        IF lv_fieldtext IS NOT INITIAL.
          REPLACE ALL OCCURRENCES OF 'Material' IN lv_fieldtext WITH 'Product' IGNORING CASE.
          es_msg-msgv4 = lv_fieldtext.
        ELSE.

          es_msg-msgv4 = is_msg-msgv4.
        ENDIF.
      ELSE.

**** *******    GET INFORMATION ABOUT TABLE AND FIELD
        lv_tablefield = is_msg-msgv4.
        lv_tablefield_d = _map_fieldname_ext( lv_tablefield ).
        IF lv_tablefield_d IS NOT INITIAL.
          lv_fieldtext = _get_tablefield_info( lv_tablefield_d ).
        ELSE.
          lv_fieldtext = _get_tablefield_info( lv_tablefield ).
        ENDIF.
        IF lv_fieldtext IS NOT INITIAL.
          es_msg-msgv4 = lv_fieldtext.
        ELSE.
*  ***********************
          msgvx = is_msg-msgv4.
          REPLACE ALL OCCURRENCES OF 'Material' IN msgvx WITH 'Product' IGNORING CASE.
          es_msg-msgv4 = msgvx.
        ENDIF.
      ENDIF.


    ENDIF.
  ENDMETHOD.


  METHOD _map_revision_level.

    CLEAR gs_revisionlevel.

    IF gs_data-engineeringchangemanagement IS NOT INITIAL AND
       gs_data-generaterevisionlevel IS NOT INITIAL.

      gs_revisionlevel-aennr = gs_data-engineeringchangemanagement.
      gs_revisionlevel-revlv = gs_data-materialrevisionlevel.

    ENDIF.

  ENDMETHOD.


  METHOD _execute_revision_level.

    CHECK gs_revisionlevel IS NOT INITIAL .

    DATA lv_matnr TYPE mara-matnr.
    IF gv_product IS INITIAL.
      TRY .
          lv_matnr = gs_mat-mara_tab[ 1 ]-matnr.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ELSE.
      lv_matnr = gv_product.
    ENDIF.

    CALL FUNCTION 'REVISION_LEVEL_INSERT'
      EXPORTING
        aennr                         = gs_revisionlevel-aennr
        matnr                         = lv_matnr
        revlv                         = gs_revisionlevel-revlv
        flg_api                       = 'X'
        flg_ale                       = 'X'
        skip_check                    = 'X'
      EXCEPTIONS
        authority_check               = 1
        document_for_ecn_impossible   = 2
        input_incomplete              = 3
        material_for_ecn_impossible   = 4
        new_revision_impossible       = 5
        no_suggestion                 = 6
        revision_exists               = 7
        revision_for_ecn_exists       = 8
        revision_not_defined          = 9
        version_with_revision         = 10
        revision_to_small             = 11
        revision_not_active_in_client = 12
        revision_not_max              = 13
        OTHERS                        = 14.

*    CALL FUNCTION 'REVISION_LEVEL_UPDATE'
*      EXPORTING
*        aennr                         = gs_revisionlevel-aennr
*        matnr                         = gv_product
*        revlv                         = gs_revisionlevel-revlv
*      EXCEPTIONS
*        authority_check               = 1
*        document_for_ecn_impossible   = 2
*        input_incomplete              = 3
*        material_for_ecn_impossible   = 4
*        revision_exists               = 5
*        revision_not_defined          = 6
*        revision_not_active_in_client = 7
*        revision_not_max              = 8
*        version_with_revision         = 9
*        OTHERS                        = 10.
    IF sy-subrc <> 0.

      gt_message = VALUE #( BASE gt_message (
                                            type       = sy-msgty
                                            id         = sy-msgid
                                            number     = sy-msgno
                                            message_v1 = sy-msgv1
                                            message_v2 = sy-msgv2
                                            message_v3 = sy-msgv3
                                            message_v4 = sy-msgv4 ) ).

    ENDIF.

  ENDMETHOD.


  METHOD _execute_product_warehouse.
    DATA: lv_matnr                  TYPE mara-matnr,
          lv_vb                     TYPE char1,
          " JHOANG adds mapping structure declaration for Product Warehouse - 27/10/2023 - start
          ls_matlwh                 TYPE /sapapo/matlwh,
          lt_prdextendwarehouse     TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse,
          lt_prdextendwarehouse_ins TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse,
          lt_prdextendwarehouse_upd TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse,
          lt_prdextendwarehouse_del TYPE STANDARD TABLE OF /simple/c_prdextendwarehouse.
    " JHOANG adds mapping structure declaration for Product Warehouse - 27/10/2023 - end
    IF gv_product IS INITIAL.
      TRY .
          lv_matnr = gs_mat-mara_tab[ 1 ]-matnr.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.
    ELSE.
      lv_matnr = gv_product.
    ENDIF.
    lt_prdextendwarehouse = CORRESPONDING #( gs_data-to_prdextendwarehouse ).
    LOOP AT lt_prdextendwarehouse ASSIGNING FIELD-SYMBOL(<fs_prdextendwarehouse>).
      IF lv_matnr IS NOT INITIAL.
        <fs_prdextendwarehouse>-product = lv_matnr.
      ENDIF.
    ENDLOOP.
    " JHOANG add mapping for extend Product Ware House - 20/10/2023 - start
    IF to_upper( gs_data-actionmode ) = 'BACKGROUNDVALIDATION'
      OR to_upper( gs_data-actionmode ) = 'BACKGROUND'.
      CASE to_upper( gs_data-action ).
        WHEN '' OR 'CREATE'.
          lt_prdextendwarehouse_ins = CORRESPONDING #( lt_prdextendwarehouse ).
        WHEN 'CHANGE'.
          LOOP AT lt_prdextendwarehouse INTO DATA(ls_prdextendwarehouse_chg) WHERE action NE ''.
            CASE to_upper( ls_prdextendwarehouse_chg-action ).
              WHEN 'INSERT'.
                APPEND ls_prdextendwarehouse_chg TO lt_prdextendwarehouse_ins.
              WHEN 'CHANGE'.
                APPEND ls_prdextendwarehouse_chg TO lt_prdextendwarehouse_upd.
              WHEN 'DELETE'.
                APPEND ls_prdextendwarehouse_chg TO lt_prdextendwarehouse_del.
              WHEN OTHERS.
            ENDCASE.
          ENDLOOP.
        WHEN OTHERS.
      ENDCASE.
      SELECT prdextendwarehouse~product,
             matkey~matid,
             prdextendwarehouse~extendwhnumber,
             t300_md~scuguid,
             prdextendwarehouse~entitleddispose,
             but000~partner_guid,
            proctypeindicator,
            prdextendwarehouse~countingindicator,
            prdextendwarehouse~putawaycontrol,
            prdextendwarehouse~stockremovalcontrol
      FROM @lt_prdextendwarehouse     AS prdextendwarehouse
      INNER JOIN   /sapapo/matkey AS matkey   ON prdextendwarehouse~product = matkey~matnr
      INNER JOIN   /scwm/t300_md AS t300_md   ON prdextendwarehouse~extendwhnumber = t300_md~lgnum
      INNER JOIN   but000  AS but000          ON prdextendwarehouse~entitleddispose = but000~partner
      INTO TABLE @DATA(lt_matlwh_id).
      " CREATE
      LOOP AT lt_prdextendwarehouse_ins INTO DATA(ls_prdextendwarehouse_ins).
        READ TABLE lt_matlwh_id INTO DATA(ls_matlwh_id) WITH KEY product          = ls_prdextendwarehouse_ins-product
                                                                 extendwhnumber   = ls_prdextendwarehouse_ins-extendwhnumber
                                                                 entitleddispose  = ls_prdextendwarehouse_ins-entitleddispose.
        IF sy-subrc = 0.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name = gc_entity-prdextendwarehouse
              iv_input_stru  = ls_matlwh_id
            CHANGING
              ev_output_stru = ls_matlwh.
*          ev_output_stru_x = ls_matlwh_x.
          APPEND ls_matlwh TO gt_matlwh.
        ENDIF.
      ENDLOOP.
      "" JHOANG add mapping for extend Product Ware House - 20/10/2023 - end
      CALL FUNCTION '/SAPAPO/DM_PRODUCTS_POST'
        EXPORTING
          iv_vb             = 'I'
          iv_check_clean_up = 'X'
        TABLES
          it_matlwh         = gt_matlwh
        EXCEPTIONS
          not_qualified     = 1
          insert_failed     = 2
          update_failed     = 3
          insert_duprec     = 4
          deadlock          = 5
          OTHERS            = 6.
      IF sy-subrc <> 0 OR gv_testrun = 'X'.
        gt_message = VALUE #( BASE gt_message (
                                              type       = sy-msgty
                                              id         = sy-msgid
                                              number     = sy-msgno
                                              message_v1 = sy-msgv1
                                              message_v2 = sy-msgv2
                                              message_v3 = sy-msgv3
                                              message_v4 = sy-msgv4 ) ).
        ROLLBACK WORK.
      ENDIF.
      " CHANGE
      CLEAR: gt_matlwh, ls_matlwh, ls_matlwh_id,lt_matlwh_id.
      LOOP AT lt_prdextendwarehouse_upd INTO DATA(ls_prdextendwarehouse_upd).
        READ TABLE lt_matlwh_id INTO ls_matlwh_id WITH KEY product          = ls_prdextendwarehouse_upd-product
                                                           extendwhnumber   = ls_prdextendwarehouse_upd-extendwhnumber
                                                           entitleddispose  = ls_prdextendwarehouse_upd-entitleddispose.
        IF sy-subrc = 0.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name = gc_entity-prdextendwarehouse
              iv_input_stru  = ls_matlwh_id
            CHANGING
              ev_output_stru = ls_matlwh.
*          ev_output_stru_x = ls_matlwh_x.
          APPEND ls_matlwh TO gt_matlwh.
        ENDIF.
      ENDLOOP.
      "" JHOANG add mapping for extend Product Ware House - 20/10/2023 - end
      CALL FUNCTION '/SAPAPO/DM_PRODUCTS_POST'
        EXPORTING
          iv_vb             = 'U'
          iv_check_clean_up = 'X'
        TABLES
          it_matlwh         = gt_matlwh
        EXCEPTIONS
          not_qualified     = 1
          insert_failed     = 2
          update_failed     = 3
          insert_duprec     = 4
          deadlock          = 5
          OTHERS            = 6.
      IF sy-subrc <> 0 OR gv_testrun = 'X'.
        gt_message = VALUE #( BASE gt_message (
                                              type       = sy-msgty
                                              id         = sy-msgid
                                              number     = sy-msgno
                                              message_v1 = sy-msgv1
                                              message_v2 = sy-msgv2
                                              message_v3 = sy-msgv3
                                              message_v4 = sy-msgv4 ) ).
        ROLLBACK WORK.
      ENDIF.
      " DELETE
      CLEAR: gt_matlwh, ls_matlwh, ls_matlwh_id,lt_matlwh_id.
      LOOP AT lt_prdextendwarehouse_del INTO DATA(ls_prdextendwarehouse_del).
        READ TABLE lt_matlwh_id INTO ls_matlwh_id WITH KEY product          = ls_prdextendwarehouse_del-product
                                                           extendwhnumber   = ls_prdextendwarehouse_del-extendwhnumber
                                                           entitleddispose  = ls_prdextendwarehouse_del-entitleddispose.
        IF sy-subrc = 0.
          CALL METHOD map_fields
            EXPORTING
              iv_entity_name = gc_entity-prdextendwarehouse
              iv_input_stru  = ls_matlwh_id
            CHANGING
              ev_output_stru = ls_matlwh.
*          ev_output_stru_x = ls_matlwh_x.
          APPEND ls_matlwh TO gt_matlwh.
        ENDIF.
      ENDLOOP.
      "" JHOANG add mapping for extend Product Ware House - 20/10/2023 - end
      CALL FUNCTION '/SAPAPO/DM_PRODUCTS_POST'
        EXPORTING
          iv_vb             = 'D'
          iv_check_clean_up = 'X'
        TABLES
          it_matlwh         = gt_matlwh
        EXCEPTIONS
          not_qualified     = 1
          insert_failed     = 2
          update_failed     = 3
          insert_duprec     = 4
          deadlock          = 5
          OTHERS            = 6.
      IF sy-subrc <> 0 OR gv_testrun = 'X'.
        gt_message = VALUE #( BASE gt_message (
                                              type       = sy-msgty
                                              id         = sy-msgid
                                              number     = sy-msgno
                                              message_v1 = sy-msgv1
                                              message_v2 = sy-msgv2
                                              message_v3 = sy-msgv3
                                              message_v4 = sy-msgv4 ) ).
        ROLLBACK WORK.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _plant_necessary.

  ENDMETHOD.


  METHOD _process_change_price.
    data:
      lt_allcurr       type gty_t_allcurr,
      lt_allcurr_temp  type gty_t_allcurr,
      lt_return        type bapiret2_t,
      lt_onecurr       type standard table of cki_mr21_input,
      ls_onecurr       type cki_mr21_input,
      ls_mr21_change   type gty_mr21_change,
      lt_markforchange type table of string,
      lt_data_post     type standard table of gty_str_price_change,
      lt_matcb         type gty_matcb_tbl,
      lt_kekocb        type gty_kekocb_tbl,
      ls_wa_marc       type marc.

    loop at it_valuation into data(ls_valuation) where mdgmarkforchange <> ''
     group by ( valuationarea = ls_valuation-valuationarea
                postingdate   = ls_valuation-postingdate )
      into data(wa_group).
      clear lt_allcurr_temp.
      try.
          data(ls_t001wk) = gt_t001wk[ bwkey = wa_group-valuationarea ].
        catch cx_sy_itab_line_not_found.
      endtry.
      try.
          data(ls_conv_period) = gt_conv_period[ bukrs = ls_t001wk-bukrs
                                                 budat = wa_group-postingdate ].
        catch cx_sy_itab_line_not_found.
      endtry.

      me->_get_all_curtp(
        exporting
          iv_bukrs    = ls_t001wk-bukrs
          iv_bwkey    = ls_t001wk-bwkey
        importing
          et_allcurtp = lt_allcurr
          et_return   = lt_return ).
      clear lt_allcurr_temp.
      lt_allcurr_temp = lt_allcurr.
      loop at group wa_group into ls_valuation where mdgmarkforchange <> ''.

        read table lt_allcurr_temp assigning field-symbol(<fs_temp>)
         with key icurtp = '10'.
        if sy-subrc = 0.
          clear <fs_temp>-one_curr.
        endif.
        read table lt_allcurr_temp assigning <fs_temp>
         with key icurtp = '30'.
        if sy-subrc = 0.
          clear <fs_temp>-one_curr.
        endif.

        me->_check_material(
          exporting
            iv_bwkey   = ls_t001wk-bwkey
            iv_matnr   = ls_valuation-product "not yet convert
            iv_bukrs   = ls_t001wk-bukrs
            iv_bdatj   = ls_conv_period-gjahr
            iv_poper   = ls_conv_period-poper
          importing
*            es_matpr   = DATA(ls_matpr)
            et_return  = lt_return

          changing
            ct_allcurr = lt_allcurr_temp
            ct_kekocb  = lt_kekocb
            ct_matcb   = lt_matcb
        ).

        if lt_return is not initial.
          append lines of lt_return to et_return.
          clear lt_return.
          continue.
        endif.
*
        loop at lt_allcurr_temp into data(ls_allcurr_temp).
          clear ls_mr21_change.
          read table ls_valuation-to_mlaccount into data(ls_mlaccount)
            with key currencyrole = ls_allcurr_temp-icurtp.
          if sy-subrc = 0 and ls_mlaccount-mdgmarkforchange is not initial.
            read table ls_allcurr_temp-one_curr
             assigning field-symbol(<fs_onecurr>) index 1.

            split ls_mlaccount-mdgmarkforchange at ',' into table lt_markforchange.
            if to_upper( ls_mlaccount-mdgmarkforchange ) cs 'STANDARDPRICE'.
              ls_mr21_change = value #(
                                fieldchange    = 'STANDARDPRICE'
                                price          = ls_mlaccount-standardprice ).
              if <fs_onecurr>-ierzkalk = 'X' or <fs_onecurr>-lfdkalk = 'X'.
                et_return = value #( base et_return
                                      ( type   = 'E'
                                        id     = 'CKPRCH'
                                        number = '025' ) ).
                continue.
              endif.

            elseif to_upper( ls_mlaccount-mdgmarkforchange ) cs 'MOVINGAVERAGEPRICE'.
              ls_mr21_change = value #(
                                fieldchange    = 'MOVINGAVERANGEPRICE'
                                price          = ls_mlaccount-movingaverageprice ).
              if <fs_onecurr>-ierzkalk = 'X' or <fs_onecurr>-lfdkalk = 'X'.
                et_return = value #( base et_return
                                      ( type   = 'E'
                                        id     = 'CKPRCH'
                                        number = '025' ) ).
                continue.
              endif.
            endif.

            if ls_mr21_change is not initial.
              me->_update_changed_value(
              exporting
                is_mr21_change = ls_mr21_change
              changing
                cs_onecurr     = <fs_onecurr> ).
            endif.

            if to_upper( ls_mlaccount-mdgmarkforchange ) cs 'PRICEUNITQTY'.
              ls_mr21_change = value #(
                                fieldchange    = 'PRICEUNITQTY'
                                priceunit      = ls_mlaccount-priceunitqty ).
              "check price unit new
              if ls_mlaccount-priceunitqty = 0.
                et_return = value #( base et_return
                                      ( type   = 'E'
                                        id     = 'M8'
                                        number = '304' ) ).
                continue.
              endif.

              call function 'MARC_SINGLE_READ'
                exporting
                  matnr             = <fs_onecurr>-matnr
                  werks             = <fs_onecurr>-bwkey
                importing
                  wmarc             = ls_wa_marc
                exceptions
                  lock_on_marc      = 1
                  lock_system_error = 2
                  wrong_call        = 3
                  not_found         = 4
                  others            = 5.

*  IF sy-subrc <> 0 OR lf_marc-losgr IS INITIAL.
              if sy-subrc <> 0 or ls_wa_marc-losgr is initial
                                      or not ls_wa_marc-pstat ca 'G'.
              else.
                if ls_mlaccount-priceunitqty > ls_wa_marc-losgr.
                  et_return = value #( base et_return
                                      ( type   = 'E'
                                        id     = 'M3'
                                        number = '406' ) ).
                  continue.
* Die Kalkulationslosgröße darf nicht kleiner als die Preiseinheit sein
                endif.
              endif.
              me->_update_changed_value(
                exporting
                  is_mr21_change = ls_mr21_change
                changing
                  cs_onecurr     = <fs_onecurr> ).
            endif.


            read table lt_allcurr assigning field-symbol(<fs_allcurr>)
              with key icurtp = ls_allcurr_temp-icurtp.
            if sy-subrc = 0.
              append <fs_onecurr> to <fs_allcurr>-one_curr.
            endif.


          endif.

        endloop.

      endloop.
      lt_data_post = value #( base lt_data_post
                                ( bukrs     = ls_t001wk-bukrs
                                  budat     = wa_group-postingdate
                                  bdatj     = ls_conv_period-gjahr
                                  poper     = ls_conv_period-poper
                                  t_allcurr = lt_allcurr ) ).
    endloop.

    if et_return is initial.



      me->_save_price_change(
        exporting
          it_data_post = lt_data_post
          it_matcb     = lt_matcb
          it_kekocb    = lt_kekocb
        importing
          et_return    = lt_return
      ).
    else.
*      et_return = lt_return.
    endif.


  ENDMETHOD.


  METHOD _replace_temp_matnr_ckml.

    DATA:
      lr_data  TYPE REF TO data,
      lv_bwkey TYPE bwkey,
      lv_bwtar TYPE bwtar_d.

    IF it_tmp_key_map IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      ASSIGN COMPONENT 'MATNR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_matnr>).
      IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
      READ TABLE it_tmp_key_map ASSIGNING FIELD-SYMBOL(<ls_tmp_key_map>) WITH KEY matnr_tmp = <lv_matnr>.
      IF sy-subrc IS INITIAL.
        ASSIGN COMPONENT 'BWKEY' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_bwkey>).
        IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
        lv_bwkey = <lv_bwkey>.
        ASSIGN COMPONENT 'BWTAR' OF STRUCTURE <ls_data> TO FIELD-SYMBOL(<lv_bwtar>).
        IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
        lv_bwtar = <lv_bwtar>.
        CREATE DATA lr_data LIKE <ls_data>.
        ASSIGN lr_data->* TO FIELD-SYMBOL(<ls_data_new>).
        <ls_data_new> = <ls_data>.
        ASSIGN COMPONENT 'MATNR' OF STRUCTURE <ls_data_new> TO FIELD-SYMBOL(<lv_matnr_new>).
        IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
        <lv_matnr_new> = <ls_tmp_key_map>-matnr_int.
        INSERT <ls_data_new> INTO TABLE ct_data.
        DELETE TABLE ct_data FROM <ls_data>.

        LOOP AT ct_data_x ASSIGNING FIELD-SYMBOL(<ls_data_x>).
          ASSIGN COMPONENT 'MATNR' OF STRUCTURE <ls_data_x> TO FIELD-SYMBOL(<lv_matnr_x>).
          IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
          ASSIGN COMPONENT 'BWKEY' OF STRUCTURE <ls_data_x> TO FIELD-SYMBOL(<lv_bwkey_x>).
          IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
          ASSIGN COMPONENT 'BWTAR' OF STRUCTURE <ls_data_x> TO FIELD-SYMBOL(<lv_bwtar_x>).
          IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
          IF <lv_matnr_x> NE <ls_tmp_key_map>-matnr_tmp OR
             <lv_bwkey_x> NE lv_bwkey OR
             <lv_bwtar_x> NE lv_bwtar.
            CONTINUE.
          ENDIF.
          CREATE DATA lr_data LIKE <ls_data_x>.
          ASSIGN lr_data->* TO FIELD-SYMBOL(<ls_data_x_new>).
          <ls_data_x_new> = <ls_data_x>.
          ASSIGN COMPONENT 'MATNR' OF STRUCTURE <ls_data_x_new> TO FIELD-SYMBOL(<lv_matnr_x_new>).
          IF sy-subrc IS NOT INITIAL. CONTINUE. ENDIF.
          <lv_matnr_x_new> = <ls_tmp_key_map>-matnr_int.
          INSERT <ls_data_x_new> INTO TABLE ct_data_x.
          DELETE TABLE ct_data_x FROM <ls_data_x>.
        ENDLOOP.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD _save_log.
    CALL FUNCTION 'LOG_SAVE'
      EXPORTING
        is_log        = gs_log
        iv_log_handle = gv_log_handle.

*    IF gs_log-cr_number IS NOT INITIAL.
*      /simple/cl_mdg_gw_core_dpc_ext=>update_log_table( is_log = gs_log ).
*      IF gv_log_handle IS NOT INITIAL.
*        /simple/cl_mdg_gw_core_dpc_ext=>save_appl_log( iv_log_handle = gv_log_handle ).
*      ENDIF.
*      IF gs_log-status CA 'EAX'.
*        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' DESTINATION 'NONE'. " 'H18CLNT110'.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD _save_price_change.
    DATA:
      lt_matpr TYPE STANDARD TABLE OF ckmpr_f_mat_price WITH DEFAULT KEY,
      ls_matpr TYPE ckmpr_f_mat_price,
      ls_matcr TYPE cki_pae_cr,
      lv_index TYPE sy-index.

    LOOP AT it_data_post INTO DATA(ls_data).
      LOOP AT ls_data-t_allcurr INTO DATA(ls_allcurr).
        LOOP AT ls_allcurr-one_curr INTO DATA(ls_onecurr).
          READ TABLE lt_matpr INTO ls_matpr
            WITH KEY pp-matnr = ls_onecurr-matnr
                     pp-bwkey = ls_onecurr-bwkey
                     pp-bwtar = ls_onecurr-bwtar
                     pp-vbeln = ls_onecurr-vbeln
                     pp-posnr = ls_onecurr-posnr
                     pp-pspnr = ls_onecurr-pspnr.
          IF sy-subrc <> 0.
            MOVE-CORRESPONDING ls_onecurr TO ls_matpr-pp.
            ls_matpr-pp-poper = ls_data-poper.
            ls_matpr-pp-bdatj = ls_data-bdatj.
            CLEAR lv_index.
            CLEAR ls_matpr-cr.
          ELSE.
            lv_index = sy-tabix.
          ENDIF.
          MOVE-CORRESPONDING ls_onecurr TO ls_matcr.
          IF ls_onecurr-vprsv = 'V'.
            ls_matcr-newstprs = ls_onecurr-newstapr.
            ls_matcr-stprs    = ls_onecurr-stapr.
            ls_matcr-newpvprs = ls_onecurr-newvalpr.
            ls_matcr-pvprs    = ls_onecurr-valpr.
          ELSE.
            ls_matcr-newstprs = ls_onecurr-newvalpr.
            ls_matcr-stprs    = ls_onecurr-valpr.
            ls_matcr-newpvprs = ls_onecurr-newstapr.
            ls_matcr-pvprs    = ls_onecurr-stapr.
          ENDIF.

          APPEND ls_matcr TO ls_matpr-cr.
          IF lv_index IS INITIAL.
            APPEND ls_matpr TO lt_matpr.
          ELSE.
            MODIFY lt_matpr FROM ls_matpr INDEX lv_index.
          ENDIF.
        ENDLOOP.
      ENDLOOP.

      me->_kalk_enrich(
        EXPORTING
          it_matcb  = it_matcb
          it_kekocb = it_kekocb
        CHANGING
          ct_matpr  = lt_matpr
      ).


      DATA:
        lv_belnr TYPE  mlhd-belnr,
        lv_kjahr TYPE  mlhd-kjahr.
      CALL FUNCTION 'PRICES_CHANGE'
        EXPORTING
          actual_bdatj = ls_data-bdatj
          actual_poper = ls_data-poper
          bukrs        = ls_data-bukrs
          budat        = ls_data-budat
        TABLES
          t_matpr      = lt_matpr.

      READ TABLE lt_matpr WITH KEY pp-xerror = ' '
                               TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
* Es wurden keine Preisänderungen durchgeführt
      ELSE.
        CALL FUNCTION 'PRICES_POST'
          EXPORTING
            i_bktxt    = ''
            bukrs      = ls_data-bukrs
            lis_update = 'X'
            no_message = 'X'
*          IMPORTING
*           o_belnr    = lv_belnr
*           o_kjahr    = lv_kjahr
          TABLES
            t_matpr    = lt_matpr.


      ENDIF.
      COMMIT WORK AND WAIT.
      CLEAR lt_matpr.
    ENDLOOP.

  ENDMETHOD.


  METHOD _update_changed_value.
    ASSIGN cs_onecurr TO FIELD-SYMBOL(<fs_onecurr>).
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    IF is_mr21_change-fieldchange = 'PRICEUNITQTY'.
      IF is_mr21_change-priceunit <> <fs_onecurr>-peinh.
        <fs_onecurr>-newpeinh = is_mr21_change-priceunit.

        IF <fs_onecurr>-is_no_auto_curr_conv = ''.
          <fs_onecurr>-newvalpr = <fs_onecurr>-newvalpr * is_mr21_change-priceunit
                                  / <fs_onecurr>-newpeinh.

          <fs_onecurr>-newstapr = <fs_onecurr>-newstapr * is_mr21_change-priceunit
                                  / <fs_onecurr>-newpeinh.

          <fs_onecurr>-manpae_v = 'X'.
          <fs_onecurr>-manpae_s = 'X'.
        ENDIF.
        CLEAR: <fs_onecurr>-zukbew, <fs_onecurr>-erzkalk.
      ENDIF.
    ELSEIF is_mr21_change-fieldchange = 'STANDARDPRICE'.
      <fs_onecurr>-newvalpr             = is_mr21_change-price.
      <fs_onecurr>-manpae_s             = 'X'.
      <fs_onecurr>-is_no_auto_curr_conv = 'X'.
      CLEAR:
        <fs_onecurr>-zukbew,
        <fs_onecurr>-erzkalk.
    ELSEIF is_mr21_change-fieldchange = 'MOVINGAVERANGEPRICE'.
      <fs_onecurr>-newvalpr             = is_mr21_change-price.
      <fs_onecurr>-manpae_v             = 'X'.
      <fs_onecurr>-is_no_auto_curr_conv = 'X'.
      CLEAR:
        <fs_onecurr>-zukbew,
        <fs_onecurr>-erzkalk.
    ENDIF.
  ENDMETHOD.


  method _validate_price_change.
    data lt_valuation_comb type gty_valuation_tab.
    data:
      ls_mr21_header type mr21head,
      lt_message     type bapiret2_t.
    clear lt_valuation_comb[].
    lt_valuation_comb = it_valuation.

    select distinct
           t1~werks,
           t1~bwkey,
           t3~bukrs
      from t001w as t1
     inner join @lt_valuation_comb as t2
        on t1~bwkey = t2~valuationarea
     inner join t001k as t3
        on t1~bwkey = t3~bwkey
      into table @data(lt_t001wk).

    loop at lt_t001wk into data(ls_t001wk).
      gt_t001wk = value #( base gt_t001wk
                             ( bukrs = ls_t001wk-bukrs
                               werks = ls_t001wk-werks
                               bwkey = ls_t001wk-bwkey ) ).
    endloop.

    loop at lt_valuation_comb into data(ls_valuation_comb).
      if ls_valuation_comb-mdgmarkforchange is initial.
        continue.
      endif.
      read table gt_t001wk into data(ls_t001w)
        with key bwkey = ls_valuation_comb-valuationarea.
      if sy-subrc = 0.
        if not line_exists( gt_conv_period[ bukrs = ls_t001w-bukrs
                                            budat = ls_valuation_comb-postingdate ] ).


          me->_check_period(
            exporting
              iv_budat   = ls_valuation_comb-postingdate
              iv_bukrs   = ls_t001w-bukrs
            importing
              et_message = data(lt_return)
          ).
          append lines of lt_return to lt_message.
        endif.
      endif.
    endloop.
    gt_message = lt_message.

  endmethod.


  METHOD _map_view_extend.

*   LD-0099 - 20231030 - Kenny Bui - Start++
    DATA:
      lv_pstat TYPE mara-pstat.

    CHECK gs_mat-mara_tab IS NOT INITIAL AND gs_mat-mara_x_tab IS NOT INITIAL.

    READ TABLE gs_mat-mara_tab INDEX 1 ASSIGNING FIELD-SYMBOL(<fs_mara>).
    READ TABLE gs_mat-mara_x_tab INDEX 1 ASSIGNING FIELD-SYMBOL(<fs_mara_x>).
    IF sy-subrc = 0.
      lv_pstat = <fs_mara>-pstat.

      IF NOT <fs_mara>-pstat CS 'E' AND
         NOT gs_data-to_productstorage IS INITIAL.
        CONCATENATE <fs_mara>-pstat 'E' INTO <fs_mara>-pstat.
      ENDIF.
    ENDIF.

    IF <fs_mara>-pstat NE lv_pstat.
      <fs_mara_x>-pstat = 'X'.
    ENDIF.

*   LD-0099 - 20231030 - Kenny Bui - End++
  ENDMETHOD.


  METHOD check_ml_data.

*    select
    SELECT bwkey,
           curtp
      FROM ckmlct AS t1
     INNER JOIN @it_valuation AS t2
        ON t1~bwkey = t2~valuationarea
      INTO TABLE @DATA(lt_ckmlct).

    IF gs_data-action = ''.
      LOOP AT it_ckmlhd INTO DATA(ls_ckmlhd).
        IF ls_ckmlhd-mlast IS INITIAL.
          et_message = VALUE #( BASE et_message (
                                 msgty = 'E'
                                 msgv1 = ls_ckmlhd-bwkey
                                         && ': Material Ledger Data is not fully maintained'
                               ) ).
          CONTINUE.
        ENDIF.
        LOOP AT lt_ckmlct INTO DATA(ls_ckmlct) WHERE bwkey = ls_ckmlhd-bwkey.
          IF NOT line_exists( it_ckmlcr[ curtp = ls_ckmlct-curtp ] ).
            et_message = VALUE #( BASE et_message (
                                 msgty = 'E'
                                 msgv1 = ls_ckmlhd-bwkey
                                         && ': Material Ledger Data is not fully maintained'
                               ) ).
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ELSEIF gs_data-action = 'Change'.
      LOOP AT it_valuation INTO DATA(ls_valuation).
        IF ls_valuation-action = ''.
          CONTINUE.
        ENDIF.

        LOOP AT it_ckmlhd INTO ls_ckmlhd.
          IF ls_ckmlhd-mlast IS INITIAL.
            et_message = VALUE #( BASE et_message (
                       msgty = 'E'
                       msgv1 = ls_ckmlhd-bwkey
                               && ': Material Ledger Data is not fully maintained'
                     ) ).
            CONTINUE.
          ENDIF.
          LOOP AT lt_ckmlct INTO ls_ckmlct WHERE bwkey = ls_ckmlhd-bwkey.
            IF NOT line_exists( it_ckmlcr[ curtp = ls_ckmlct-curtp ] ).
              et_message = VALUE #( BASE et_message (
                       msgty = 'E'
                       msgv1 = ls_ckmlhd-bwkey
                               && ': Material Ledger Data is not fully maintained'
                     ) ).
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDLOOP.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
