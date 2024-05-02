INTERFACE /simple/if_mdg_api
  PUBLIC .


  TYPES:
    BEGIN OF ts_field,
      fuzzysearch TYPE flag,
      name        TYPE string,
      value       TYPE string,
      dummykey    TYPE string,
      isdisplay   TYPE flag,
      type        TYPE string,
      from        TYPE string,
      to          TYPE string,
      navpath     TYPE string,
    END OF ts_field .
  TYPES:
    BEGIN OF ts_searchfield_deep,
      navpath  TYPE string,
      fields   TYPE STANDARD TABLE OF ts_field WITH DEFAULT KEY,
      dummykey TYPE string,
    END OF ts_searchfield_deep .
  TYPES:
    BEGIN OF ts_searchresult,
      value    TYPE string,
      dummykey TYPE string,
    END OF ts_searchresult .
  TYPES:
    BEGIN OF ts_searchsetting_deep.
  TYPES:
    maxhit           TYPE /iwbep/sb_odata_ty_int2,
    iscontainssearch TYPE flag,
    objecttype       TYPE string,
    dummykey         TYPE string,
    fuzzyvalues      TYPE string,
    fuzzysearch      TYPE flag,
    searchfields     TYPE STANDARD TABLE OF ts_searchfield_deep WITH DEFAULT KEY,
    searchresults    TYPE STANDARD TABLE OF ts_searchresult WITH DEFAULT KEY,
    END OF ts_searchsetting_deep .

*  TYPES:
*    BEGIN OF salesareatax,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
**      INCLUDE TYPE /simple/afipctrt.
*      INCLUDE TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_customersalesare.
*  TYPES: END OF salesareatax.
*
*  TYPES:
*    BEGIN OF partnerfucntion,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_custsalespartnerf.
*
*  TYPES: END OF partnerfucntion .
*
*  TYPES:
*    BEGIN OF customer_sales_struc,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_customersalesarea.
*
*  TYPES: to_salesareatax  TYPE TABLE OF salesareatax WITH DEFAULT KEY.
*  TYPES: to_partnerfunction TYPE TABLE OF partnerfucntion WITH DEFAULT KEY.
*  TYPES: END OF customer_sales_struc .
*
*  TYPES:
*    BEGIN OF customerdunning,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_customerdunningty.
*  TYPES: END OF customerdunning .
*
*  TYPES:
*    BEGIN OF withholdingtax,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_custwithholdingta.
*
*  TYPES: END OF withholdingtax .
*
*  TYPES:
*    BEGIN OF customer_company_struc,
*      action             TYPE string,
*      mdgmarkforchange   TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_customercompanyty.
*
*  TYPES: to_customerdunning TYPE TABLE OF customerdunning WITH DEFAULT KEY.
*  TYPES: to_withholdingtax  TYPE TABLE OF withholdingtax WITH DEFAULT KEY.
*  TYPES: END OF customer_company_struc .
*
*  TYPES:
*    BEGIN OF customer_struc,
*      action             TYPE string,
*      mdgmarkforchange   TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_customertype.
*
*  TYPES: to_customercompany TYPE STANDARD TABLE OF customer_company_struc WITH DEFAULT KEY.
*  TYPES: to_customersalesarea TYPE STANDARD TABLE OF customer_sales_struc WITH DEFAULT KEY.
*  TYPES: END OF customer_struc .
*
*  TYPES:
*    BEGIN OF supplierdunning,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_supplierdunningty.
*
*  TYPES: END OF supplierdunning .
*
*  TYPES:
*    BEGIN OF supplierwithholdingtax,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_supwithholdingtax.
*
*  TYPES: END OF supplierwithholdingtax .
*
*  TYPES:
*    BEGIN OF supplier_company_struc,
*      action             TYPE string,
*      mdgmarkforchange   TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_suppliercompanyty.
*  TYPES: to_supplierdunning TYPE TABLE OF supplierdunning WITH DEFAULT KEY.
*  TYPES: to_supplierwithholdingtax TYPE TABLE OF supplierwithholdingtax WITH DEFAULT KEY.
*  TYPES:      END OF supplier_company_struc .
*
*  TYPES:
*    BEGIN OF supplierpartnerfucntion,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_suppartnerfunctyp.
*
*  TYPES: END OF supplierpartnerfucntion .
*
*  TYPES:
*    BEGIN OF supplier_purchasing_struc,
*      action             TYPE string,
*      mdgmarkforchange   TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_suppurchasingorgt.
*  TYPES: to_partnerfunction TYPE TABLE OF supplierpartnerfucntion WITH DEFAULT KEY.
*  TYPES: END OF supplier_purchasing_struc .
*
*  TYPES:
*    BEGIN OF supplier_struc,
*      action             TYPE string,
*      mdgmarkforchange   TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_suppliertype.
*  TYPES: to_suppliercompany TYPE STANDARD TABLE OF supplier_company_struc WITH DEFAULT KEY.
*  TYPES: to_supplierpurchasingorg TYPE STANDARD TABLE OF supplier_purchasing_struc WITH DEFAULT KEY.
*  TYPES:        END OF supplier_struc .
*
*  TYPES:
*    BEGIN OF addressusage,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bupaaddressusaget.
*
*  TYPES: END OF addressusage .
*
*  TYPES:
*    BEGIN OF phonenumber,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_addressphonenumbe.
*
*  TYPES:  END OF phonenumber .
*
*  TYPES:
*    BEGIN OF faxnumber,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_addressfaxnumbert.
*
*  TYPES: END OF faxnumber .
*
*  TYPES:
*    BEGIN OF emailaddress,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_addressemailaddre.
*
*  TYPES: END OF emailaddress .
*
*  TYPES:
*    BEGIN OF urladdress,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_addresshomepageur.
*
*  TYPES: END OF urladdress .
*
*  TYPES:
*    BEGIN OF bupa_address_struc,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_buspartaddresstyp.
*  TYPES: to_addressusage  TYPE TABLE OF addressusage WITH DEFAULT KEY.
*  TYPES: to_phonenumber       TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_mobilephonenumber TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_faxnumber         TYPE TABLE OF faxnumber WITH DEFAULT KEY.
*  TYPES: to_emailaddress      TYPE TABLE OF emailaddress WITH DEFAULT KEY.
*  TYPES: to_urladdress        TYPE TABLE OF urladdress WITH DEFAULT KEY.
*  TYPES: END OF bupa_address_struc .
*
*  TYPES:
*    BEGIN OF contact_addr_struc,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttoaddresstype.
*  TYPES: to_phonenumber   TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_mobilephonenumber TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_faxnumber         TYPE TABLE OF faxnumber WITH DEFAULT KEY.
*  TYPES: to_emailaddress      TYPE TABLE OF emailaddress WITH DEFAULT KEY.
*  TYPES: to_urladdress        TYPE TABLE OF urladdress WITH DEFAULT KEY.
*  TYPES: END OF contact_addr_struc .
*
*  TYPES:
*    BEGIN OF businesspartnerrole,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_businesspartnerro.
*
*  TYPES: END OF businesspartnerrole.
*
*  TYPES:
*    BEGIN OF businesspartnertax,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bptaxnumbertype.
*
*  TYPES: END OF businesspartnertax.
*
*  TYPES:
*    BEGIN OF businesspartnerindustry,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bupaindustrytype.
*
*  TYPES:  END OF businesspartnerindustry .
*
*  TYPES:
*    BEGIN OF bupaidentification,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bupaidentificatio.
*
*  TYPES:  END OF bupaidentification .
*
*  TYPES:
*    BEGIN OF businesspartnerbank,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_businesspartnerba.
*
*  TYPES: END OF businesspartnerbank .
*
*  TYPES:
*    BEGIN OF businesspartnercard,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_businesspartnerca.
*
*  TYPES:  END OF businesspartnercard .
*
*  TYPES:
*    BEGIN OF bpcreditprofile,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bpcreditprofilety.
*
*  TYPES: END OF bpcreditprofile .
*
*  TYPES:
*    BEGIN OF bpcreditsegment,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bpcreditsegmentty.
*
*  TYPES: END OF bpcreditsegment .
*
*  TYPES:
*    BEGIN OF bprelationship,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bprelationshiptyp.
*
*  TYPES:  END OF bprelationship .
*
*  TYPES:
*    BEGIN OF contact_struc,
*      action            TYPE string,
*      mdgmarkforchange  TYPE string.
*      INCLUDE TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bpcontacttype.
*  TYPES: to_contactaddress TYPE STANDARD TABLE OF contact_addr_struc WITH DEFAULT KEY.
*  TYPES: to_contactrelationship TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttofuncanddepttyp.
*
*  TYPES END OF contact_struc .
*
*
*  TYPES:
*    BEGIN OF deep_businessparnter,
*      cid                    TYPE string,
*      action                 TYPE string,
*      actionmode             TYPE string,
*      crnumber               TYPE string,
*      critem                 TYPE string,
*      mdgmarkforchange       TYPE string.
*      INCLUDE          TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_businesspartnerty.
*  TYPES: to_businesspartnerbank TYPE STANDARD TABLE OF businesspartnerbank WITH DEFAULT KEY.
*  TYPES: to_businesspartnercard    TYPE STANDARD TABLE OF businesspartnercard WITH DEFAULT KEY.
*  TYPES: to_bupaidentification     TYPE STANDARD TABLE OF bupaidentification WITH DEFAULT KEY.
*  TYPES: to_bupaindustry           TYPE STANDARD TABLE OF businesspartnerindustry WITH DEFAULT KEY.
*  TYPES: to_businesspartnerrole    TYPE STANDARD TABLE OF businesspartnerrole WITH DEFAULT KEY.
*  TYPES: to_businesspartnertax     TYPE STANDARD TABLE OF businesspartnertax WITH DEFAULT KEY.
*  TYPES: to_businesspartneraddress TYPE STANDARD TABLE OF bupa_address_struc WITH DEFAULT KEY.
*  TYPES: to_customer               TYPE customer_struc.
*  TYPES: to_supplier               TYPE supplier_struc.
*  TYPES: to_bpcreditprofile        TYPE bpcreditprofile.
*  TYPES: to_businesspartnercontact TYPE STANDARD TABLE OF contact_struc WITH DEFAULT KEY.
*  TYPES: to_bpcreditsegment        TYPE STANDARD TABLE OF bpcreditsegment WITH DEFAULT KEY.
*  TYPES: to_businesspartnerrelationship TYPE STANDARD TABLE OF bprelationship WITH DEFAULT KEY.
*  TYPES: END OF deep_businessparnter .

*  TYPES:
*    BEGIN OF salesareatax.
*      INCLUDE TYPE /simple/rap_custsalesareatax.
*  TYPES: END OF salesareatax.
*
*  TYPES:
*    BEGIN OF partnerfucntion.
*      INCLUDE          TYPE /SIMPLE/RAP_CustSalesPartFunc.
*  TYPES: END OF partnerfucntion .
*
*  TYPES:
*    BEGIN OF customer_sales_struc.
*      INCLUDE          TYPE /simple/rap_customersalesarea.
*  TYPES: to_salesareatax TYPE TABLE OF salesareatax WITH DEFAULT KEY.
*  TYPES: to_partnerfunction TYPE TABLE OF partnerfucntion WITH DEFAULT KEY.
*  TYPES: END OF customer_sales_struc .
*
*  TYPES:
*    BEGIN OF customerdunning.
*      INCLUDE          TYPE /simple/rap_customerdunning.
*  TYPES: END OF customerdunning .
*
*  TYPES:
*    BEGIN OF withholdingtax.
*      INCLUDE          TYPE /SIMPLE/RAP_CustWithHoldingTax.
*  TYPES: END OF withholdingtax .
*
*  TYPES:
*    BEGIN OF customer_company_struc.
*      INCLUDE          TYPE /simple/rap_customercompany.
*  TYPES: to_customerdunning TYPE TABLE OF customerdunning WITH DEFAULT KEY.
*  TYPES: to_withholdingtax  TYPE TABLE OF withholdingtax WITH DEFAULT KEY.
*  TYPES: END OF customer_company_struc .
*
*  TYPES:
*    BEGIN OF customer_struc.
*      INCLUDE          TYPE /simple/rap_customer.
*
*  TYPES: to_customercompany TYPE STANDARD TABLE OF customer_company_struc WITH DEFAULT KEY.
*  TYPES: to_customersalesarea TYPE STANDARD TABLE OF customer_sales_struc WITH DEFAULT KEY.
*  TYPES: END OF customer_struc .
*
*  TYPES:
*    BEGIN OF supplierdunning.
*      INCLUDE          TYPE /simple/rap_supplierdunning.
*  TYPES: END OF supplierdunning .
*
*  TYPES:
*    BEGIN OF supplierwithholdingtax.
*      INCLUDE          TYPE /simple/rap_supwithholdingtax.
*  TYPES: END OF supplierwithholdingtax .
*
*  TYPES:
*    BEGIN OF supplier_company_struc.
*      INCLUDE          TYPE /simple/rap_suppliercompany.
*  TYPES: to_supplierdunning TYPE TABLE OF supplierdunning WITH DEFAULT KEY.
*  TYPES: to_supplierwithholdingtax TYPE TABLE OF supplierwithholdingtax WITH DEFAULT KEY.
*  TYPES:      END OF supplier_company_struc .
*
*  TYPES:
*    BEGIN OF supplierpartnerfucntion.
*      INCLUDE          TYPE /simple/rap_suppartnerfunc.
*  TYPES: END OF supplierpartnerfucntion .
*
*  TYPES:
*    BEGIN OF supplier_purchasing_struc.
*      INCLUDE          TYPE /simple/rap_suppurchasingorg.
*  TYPES: to_partnerfunction TYPE TABLE OF supplierpartnerfucntion WITH DEFAULT KEY.
*  TYPES: END OF supplier_purchasing_struc .
*
*  TYPES:
*    BEGIN OF supplier_struc.
*      INCLUDE          TYPE /SIMPLE/RAP_Supplier.
*  TYPES: to_suppliercompany TYPE STANDARD TABLE OF supplier_company_struc WITH DEFAULT KEY.
*  TYPES: to_supplierpurchasingorg TYPE STANDARD TABLE OF supplier_purchasing_struc WITH DEFAULT KEY.
*  TYPES:        END OF supplier_struc .
*
*  TYPES:
*    BEGIN OF addressusage.
*      INCLUDE          TYPE /simple/rap_bupaaddressusage.
*  TYPES: END OF addressusage .
*
*  TYPES:
*    BEGIN OF phonenumber.
*      INCLUDE          TYPE /simple/rap_addressphonenumber.
*  TYPES:  END OF phonenumber .
*
*  TYPES:
*    BEGIN OF faxnumber.
*      INCLUDE          TYPE /simple/rap_addressfaxnumber.
*  TYPES: END OF faxnumber .
*
*  TYPES:
*    BEGIN OF emailaddress.
*      INCLUDE          TYPE /simple/rap_emailaddress.
*  TYPES: END OF emailaddress .
*
*  TYPES:
*    BEGIN OF urladdress.
*      INCLUDE          TYPE /simple/rap_addresshomepageurl.
*  TYPES: END OF urladdress .
*
*  TYPES:
*    BEGIN OF bupa_address_struc.
*      INCLUDE          TYPE /simple/rap_buspartaddress.
*  TYPES: to_addressusage TYPE TABLE OF addressusage WITH DEFAULT KEY.
*  TYPES: to_phonenumber       TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_mobilephonenumber TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_faxnumber         TYPE TABLE OF faxnumber WITH DEFAULT KEY.
*  TYPES: to_emailaddress      TYPE TABLE OF emailaddress WITH DEFAULT KEY.
*  TYPES: to_urladdress        TYPE TABLE OF urladdress WITH DEFAULT KEY.
*  TYPES: END OF bupa_address_struc .
*
*  TYPES:
*    BEGIN OF contact_addr_struc,
*      action           TYPE string,
*      mdgmarkforchange TYPE string.
*      INCLUDE          TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttoaddresstype.
*  TYPES: to_phonenumber   TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_mobilephonenumber TYPE TABLE OF phonenumber WITH DEFAULT KEY.
*  TYPES: to_faxnumber         TYPE TABLE OF faxnumber WITH DEFAULT KEY.
*  TYPES: to_emailaddress      TYPE TABLE OF emailaddress WITH DEFAULT KEY.
*  TYPES: to_urladdress        TYPE TABLE OF urladdress WITH DEFAULT KEY.
*  TYPES: END OF contact_addr_struc .
*
*  TYPES:
*    BEGIN OF businesspartnerrole.
*      INCLUDE          TYPE /simple/rap_bprole.
*
*  TYPES: END OF businesspartnerrole.
*
*  TYPES:
*    BEGIN OF businesspartnertax.
*      INCLUDE          TYPE /SIMPLE/RAP_BPTaxNumber.
*
*  TYPES: END OF businesspartnertax.
*
*  TYPES:
*    BEGIN OF businesspartnerindustry.
*      INCLUDE          TYPE /simple/rap_bupaindustry.
*
*  TYPES:  END OF businesspartnerindustry .
*
*  TYPES:
*    BEGIN OF bupaidentification.
*      INCLUDE          TYPE /simple/rap_bupaidentification.
*  TYPES:  END OF bupaidentification .
*
*  TYPES:
*    BEGIN OF businesspartnerbank.
*      INCLUDE          TYPE /SIMPLE/RAP_BPBank.
*  TYPES: END OF businesspartnerbank .
*
*  TYPES:
*    BEGIN OF businesspartnercard.
*      INCLUDE          TYPE /simple/rap_bpcard.
*
*  TYPES:  END OF businesspartnercard .
*
*  TYPES:
*    BEGIN OF bpcreditprofile.
*      INCLUDE          TYPE /simple/rap_bpcreditprofile.
*
*  TYPES: END OF bpcreditprofile .
*
*  TYPES:
*    BEGIN OF bpcreditsegment.
*      INCLUDE          TYPE /simple/rap_bpcreditsegment.
*
*  TYPES: END OF bpcreditsegment .
*
*  TYPES:
*    BEGIN OF bprelationship.
*      INCLUDE          TYPE /SIMPLE/RAP_BPRelationship.
*
*  TYPES:  END OF bprelationship .
*
*  TYPES:
*    BEGIN OF contact_struc,
*      action            TYPE string,
*      mdgmarkforchange  TYPE string.
*      INCLUDE TYPE /simple/cl_mdg_bp_mpc_ext=>ts_xsimplexa_bpcontacttype.
*  TYPES: to_contactaddress TYPE STANDARD TABLE OF contact_addr_struc WITH DEFAULT KEY.
*  TYPES: to_contactrelationship TYPE cl_api_business_partne_mpc=>ts_a_bpcontacttofuncanddepttyp.
*
*  TYPES END OF contact_struc .
*
*
*  TYPES:
*    BEGIN OF deep_businessparnter,
*      cid                    TYPE string.
*      INCLUDE          TYPE /simple/rap_businesspartner.
*  TYPES: to_businesspartnerbank TYPE STANDARD TABLE OF businesspartnerbank WITH DEFAULT KEY.
*  TYPES: to_businesspartnercard    TYPE STANDARD TABLE OF businesspartnercard WITH DEFAULT KEY.
*  TYPES: to_bupaidentification     TYPE STANDARD TABLE OF bupaidentification WITH DEFAULT KEY.
*  TYPES: to_bupaindustry           TYPE STANDARD TABLE OF businesspartnerindustry WITH DEFAULT KEY.
*  TYPES: to_businesspartnerrole    TYPE STANDARD TABLE OF businesspartnerrole WITH DEFAULT KEY.
*  TYPES: to_businesspartnertax     TYPE STANDARD TABLE OF businesspartnertax WITH DEFAULT KEY.
*  TYPES: to_businesspartneraddress TYPE STANDARD TABLE OF bupa_address_struc WITH DEFAULT KEY.
*  TYPES: to_customer               TYPE customer_struc.
*  TYPES: to_supplier               TYPE supplier_struc.
*  TYPES: to_bpcreditprofile        TYPE bpcreditprofile.
*  TYPES: to_businesspartnercontact TYPE STANDARD TABLE OF contact_struc WITH DEFAULT KEY.
*  TYPES: to_bpcreditsegment        TYPE STANDARD TABLE OF bpcreditsegment WITH DEFAULT KEY.
*  TYPES: to_businesspartnerrelationship TYPE STANDARD TABLE OF bprelationship WITH DEFAULT KEY.
*  TYPES: END OF deep_businessparnter .

  METHODS search
    IMPORTING
      !is_deep_data   TYPE any
      !it_key_tab     TYPE /iwbep/t_mgw_tech_pairs OPTIONAL
    EXPORTING
      !eo_deep_entity TYPE REF TO data
      !et_message     TYPE bapiret2_t .
  METHODS create
    IMPORTING
      !is_deep_data   TYPE any
      !it_key_tab     TYPE /iwbep/t_mgw_tech_pairs
      !iv_mode        TYPE string DEFAULT 'C'
    EXPORTING
      !eo_deep_entity TYPE REF TO data
      !et_message     TYPE bapiret2_t .
  METHODS update
    IMPORTING
      !is_deep_data   TYPE any
      !it_key_tab     TYPE /iwbep/t_mgw_tech_pairs
      !iv_mode        TYPE string DEFAULT 'C'
    EXPORTING
      !eo_deep_entity TYPE REF TO data
      !et_message     TYPE bapiret2_t .
  METHODS verify_data
    IMPORTING
      !is_deep_data TYPE any
      !iv_action    TYPE glaccount_action OPTIONAL
    EXPORTING
      !et_message   TYPE bapiret2_t .
ENDINTERFACE.
