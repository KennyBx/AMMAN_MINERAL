class /SIMPLE/CL_MDG_SEARCH_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
  begin of TS_SEARCHFIELDTYPE,
     DUMMYKEY type C length 20,
     NAVPATH type string,
  end of TS_SEARCHFIELDTYPE .
  types:
TT_SEARCHFIELDTYPE type standard table of TS_SEARCHFIELDTYPE .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
  begin of TS_SEARCHRESULTTYPE,
     DUMMYKEY type C length 20,
     VALUE type string,
  end of TS_SEARCHRESULTTYPE .
  types:
TT_SEARCHRESULTTYPE type standard table of TS_SEARCHRESULTTYPE .
  types:
  begin of TS_SEARCHSETTINGTYPE,
     DUMMYKEY type C length 20,
     MAXHIT type /IWBEP/SB_ODATA_TY_INT2,
     ISCONTAINSSEARCH type FLAG,
     OBJECTTYPE type string,
     FUZZYVALUES type string,
     FUZZYSEARCH type FLAG,
  end of TS_SEARCHSETTINGTYPE .
  types:
TT_SEARCHSETTINGTYPE type standard table of TS_SEARCHSETTINGTYPE .
  types:
  begin of TS_SEARCHVALUETYPE,
     DUMMYKEY type C length 20,
     FUZZYSEARCH type FLAG,
     NAME type string,
     VALUE type string,
     ISDISPLAY type FLAG,
     TYPE type string,
  end of TS_SEARCHVALUETYPE .
  types:
TT_SEARCHVALUETYPE type standard table of TS_SEARCHVALUETYPE .

  constants GC_SEARCHFIELDTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'SearchFieldType' ##NO_TEXT.
  constants GC_SEARCHRESULTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'SearchResultType' ##NO_TEXT.
  constants GC_SEARCHSETTINGTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'SearchSettingType' ##NO_TEXT.
  constants GC_SEARCHVALUETYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'SearchValueType' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  constants GC_INCL_NAME type STRING value '/SIMPLE/CL_MDG_SEARCH_MPC=====CP' ##NO_TEXT.

  methods DEFINE_SEARCHFIELDTYPE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_SEARCHRESULTTYPE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_SEARCHSETTINGTYPE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_SEARCHVALUETYPE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ASSOCIATIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS /SIMPLE/CL_MDG_SEARCH_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'cds_xsimplexsearchsetting' ).

define_searchfieldtype( ).
define_searchresulttype( ).
define_searchsettingtype( ).
define_searchvaluetype( ).
define_associations( ).
  endmethod.


  method DEFINE_ASSOCIATIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*




data:
lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                   "#EC NEEDED
lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                   "#EC NEEDED
lo_association    type ref to /iwbep/if_mgw_odata_assoc,                        "#EC NEEDED
lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr,                   "#EC NEEDED
lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set,                    "#EC NEEDED
lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop.                     "#EC NEEDED

***********************************************************************************************************************************
*   ASSOCIATIONS
***********************************************************************************************************************************

 lo_association = model->create_association(
                            iv_association_name = 'assoc_3C5E429A04F583CE7C610F96FAAAC60F' "#EC NOTEXT
                            iv_left_type        = 'SearchSettingType' "#EC NOTEXT
                            iv_right_type       = 'SearchFieldType' "#EC NOTEXT
                            iv_right_card       = 'M' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
* Referential constraint for association - assoc_3C5E429A04F583CE7C610F96FAAAC60F
lo_ref_constraint = lo_association->create_ref_constraint( ).
lo_ref_constraint->add_property( iv_principal_property = 'dummyKey'   iv_dependent_property = 'dummyKey' ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_3C5E429A04F583CE7C610F96FAAAC60F'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchSetting'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchField'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_3C5E429A04F583CE7C610F96FAAAC60F' ).                                 "#EC NOTEXT

 lo_association = model->create_association(
                            iv_association_name = 'assoc_F8A8E04A72886F8260161C5E90949E32' "#EC NOTEXT
                            iv_left_type        = 'SearchSettingType' "#EC NOTEXT
                            iv_right_type       = 'SearchResultType' "#EC NOTEXT
                            iv_right_card       = 'M' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
* Referential constraint for association - assoc_F8A8E04A72886F8260161C5E90949E32
lo_ref_constraint = lo_association->create_ref_constraint( ).
lo_ref_constraint->add_property( iv_principal_property = 'dummyKey'   iv_dependent_property = 'dummyKey' ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_F8A8E04A72886F8260161C5E90949E32'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchSetting'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchResult'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_F8A8E04A72886F8260161C5E90949E32' ).                                 "#EC NOTEXT

 lo_association = model->create_association(
                            iv_association_name = 'assoc_F4489311EA14524BA314FB70D10AD9FD' "#EC NOTEXT
                            iv_left_type        = 'SearchValueType' "#EC NOTEXT
                            iv_right_type       = 'SearchFieldType' "#EC NOTEXT
                            iv_right_card       = '1' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_F4489311EA14524BA314FB70D10AD9FD'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchValue'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchField'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_F4489311EA14524BA314FB70D10AD9FD' ).                                 "#EC NOTEXT

 lo_association = model->create_association(
                            iv_association_name = 'assoc_60BEEF34A370A85D47B78E8FF9FA20A3' "#EC NOTEXT
                            iv_left_type        = 'SearchFieldType' "#EC NOTEXT
                            iv_right_type       = 'SearchValueType' "#EC NOTEXT
                            iv_right_card       = 'M' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
* Referential constraint for association - assoc_60BEEF34A370A85D47B78E8FF9FA20A3
lo_ref_constraint = lo_association->create_ref_constraint( ).
lo_ref_constraint->add_property( iv_principal_property = 'dummyKey'   iv_dependent_property = 'dummyKey' ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_60BEEF34A370A85D47B78E8FF9FA20A3'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchField'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchValue'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_60BEEF34A370A85D47B78E8FF9FA20A3' ).                                 "#EC NOTEXT

 lo_association = model->create_association(
                            iv_association_name = 'assoc_71E9520F777430B8DEA7072BA866DC45' "#EC NOTEXT
                            iv_left_type        = 'SearchFieldType' "#EC NOTEXT
                            iv_right_type       = 'SearchSettingType' "#EC NOTEXT
                            iv_right_card       = '1' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_71E9520F777430B8DEA7072BA866DC45'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchField'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchSetting'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_71E9520F777430B8DEA7072BA866DC45' ).                                 "#EC NOTEXT

 lo_association = model->create_association(
                            iv_association_name = 'assoc_8ECA88B28E9C3F39E0E20C13F866FB56' "#EC NOTEXT
                            iv_left_type        = 'SearchResultType' "#EC NOTEXT
                            iv_right_type       = 'SearchSettingType' "#EC NOTEXT
                            iv_right_card       = '1' "#EC NOTEXT
                            iv_left_card        = '1'  "#EC NOTEXT
                            iv_def_assoc_set    = abap_false ). "#EC NOTEXT
lo_assoc_set = model->create_association_set( iv_association_set_name  = 'assoc_8ECA88B28E9C3F39E0E20C13F866FB56'                         "#EC NOTEXT
                                              iv_left_entity_set_name  = 'SearchResult'              "#EC NOTEXT
                                              iv_right_entity_set_name = 'SearchSetting'             "#EC NOTEXT
                                              iv_association_name      = 'assoc_8ECA88B28E9C3F39E0E20C13F866FB56' ).                                 "#EC NOTEXT


***********************************************************************************************************************************
*   NAVIGATION PROPERTIES
***********************************************************************************************************************************

* Navigation Properties for entity - SearchFieldType
lo_entity_type = model->get_entity_type( iv_entity_name = 'SearchFieldType' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchValues' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHVALUES' "#EC NOTEXT
                                                              iv_association_name = 'assoc_60BEEF34A370A85D47B78E8FF9FA20A3' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchSetting' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHSETTING' "#EC NOTEXT
                                                              iv_association_name = 'assoc_71E9520F777430B8DEA7072BA866DC45' ). "#EC NOTEXT
* Navigation Properties for entity - SearchResultType
lo_entity_type = model->get_entity_type( iv_entity_name = 'SearchResultType' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchSetting' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHSETTING' "#EC NOTEXT
                                                              iv_association_name = 'assoc_8ECA88B28E9C3F39E0E20C13F866FB56' ). "#EC NOTEXT
* Navigation Properties for entity - SearchSettingType
lo_entity_type = model->get_entity_type( iv_entity_name = 'SearchSettingType' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchResults' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHRESULTS' "#EC NOTEXT
                                                              iv_association_name = 'assoc_F8A8E04A72886F8260161C5E90949E32' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchFields' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHFIELDS' "#EC NOTEXT
                                                              iv_association_name = 'assoc_3C5E429A04F583CE7C610F96FAAAC60F' ). "#EC NOTEXT
* Navigation Properties for entity - SearchValueType
lo_entity_type = model->get_entity_type( iv_entity_name = 'SearchValueType' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'to_SearchField' "#EC NOTEXT
                                                              iv_abap_fieldname = 'TO_SEARCHFIELD' "#EC NOTEXT
                                                              iv_association_name = 'assoc_F4489311EA14524BA314FB70D10AD9FD' ). "#EC NOTEXT
  endmethod.


  method DEFINE_SEARCHFIELDTYPE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - SearchFieldType
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'SearchFieldType' iv_def_entity_set = abap_false ). "#EC NOTEXT
lo_entity_type->set_label_from_text_element( iv_text_element_symbol = '001' iv_text_element_container = gc_incl_name ).   "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'dummyKey' iv_abap_fieldname = 'DUMMYKEY' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'navPath' iv_abap_fieldname = 'NAVPATH' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/SIMPLE/CL_MDG_SEARCH_MPC=>TS_SEARCHFIELDTYPE' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'SearchField' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_SEARCHRESULTTYPE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - SearchResultType
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'SearchResultType' iv_def_entity_set = abap_false ). "#EC NOTEXT
lo_entity_type->set_label_from_text_element( iv_text_element_symbol = '002' iv_text_element_container = gc_incl_name ).   "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'dummyKey' iv_abap_fieldname = 'DUMMYKEY' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'value' iv_abap_fieldname = 'VALUE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/SIMPLE/CL_MDG_SEARCH_MPC=>TS_SEARCHRESULTTYPE' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'SearchResult' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_SEARCHSETTINGTYPE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - SearchSettingType
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'SearchSettingType' iv_def_entity_set = abap_false ). "#EC NOTEXT
lo_entity_type->set_label_from_text_element( iv_text_element_symbol = '003' iv_text_element_container = gc_incl_name ).   "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'dummyKey' iv_abap_fieldname = 'DUMMYKEY' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'maxHit' iv_abap_fieldname = 'MAXHIT' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '004' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_int16( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'isContainsSearch' iv_abap_fieldname = 'ISCONTAINSSEARCH' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '005' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'objectType' iv_abap_fieldname = 'OBJECTTYPE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'fuzzyValues' iv_abap_fieldname = 'FUZZYVALUES' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'fuzzySearch' iv_abap_fieldname = 'FUZZYSEARCH' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '006' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/SIMPLE/CL_MDG_SEARCH_MPC=>TS_SEARCHSETTINGTYPE' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'SearchSetting' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_SEARCHVALUETYPE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - SearchValueType
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'SearchValueType' iv_def_entity_set = abap_false ). "#EC NOTEXT
lo_entity_type->set_label_from_text_element( iv_text_element_symbol = '007' iv_text_element_container = gc_incl_name ).   "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'dummyKey' iv_abap_fieldname = 'DUMMYKEY' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'fuzzySearch' iv_abap_fieldname = 'FUZZYSEARCH' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '008' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'name' iv_abap_fieldname = 'NAME' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'value' iv_abap_fieldname = 'VALUE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'isDisplay' iv_abap_fieldname = 'ISDISPLAY' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '009' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'type' iv_abap_fieldname = 'TYPE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_true ).
lo_property->set_updatable( abap_true ).
lo_property->set_sortable( abap_true ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/SIMPLE/CL_MDG_SEARCH_MPC=>TS_SEARCHVALUETYPE' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'SearchValue' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_true ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_true ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20220222095757'.                  "#EC NOTEXT
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED

clear ls_text_element.
ls_text_element-artifact_name          = 'SearchFieldType'.                            "#EC NOTEXT
ls_text_element-artifact_type          = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'MODL'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '001'.                         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.


clear ls_text_element.
ls_text_element-artifact_name          = 'SearchResultType'.                            "#EC NOTEXT
ls_text_element-artifact_type          = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'MODL'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '002'.                         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.


clear ls_text_element.
ls_text_element-artifact_name          = 'SearchSettingType'.                            "#EC NOTEXT
ls_text_element-artifact_type          = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'MODL'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '003'.                         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.

clear ls_text_element.
ls_text_element-artifact_name          = 'maxHit'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'SearchSettingType'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '004'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'isContainsSearch'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'SearchSettingType'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '005'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'fuzzySearch'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'SearchSettingType'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '006'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.

clear ls_text_element.
ls_text_element-artifact_name          = 'SearchValueType'.                            "#EC NOTEXT
ls_text_element-artifact_type          = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'MODL'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '007'.                         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.

clear ls_text_element.
ls_text_element-artifact_name          = 'fuzzySearch'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'SearchValueType'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '008'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'isDisplay'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'SearchValueType'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '009'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
  endmethod.
ENDCLASS.
