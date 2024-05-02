class /SIMPLE/CL_MDG_SEARCH_DPC_EXT definition
  public
  inheriting from /SIMPLE/CL_MDG_SEARCH_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /SIMPLE/CL_MDG_SEARCH_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

    DATA:
      ls_data TYPE /simple/cl_search=>gty_search.

    " Read payload
    io_data_provider->read_entry_data( IMPORTING es_data = ls_data ).
    DATA(lv_entity_type_name) = io_tech_request_context->get_entity_type_name( ).

    " Instantiate object
    DATA(lo_object) = NEW /simple/cl_search( ).

    " Set attributes
    lo_object->set_search_criteria( is_data = ls_data ).

    DATA(gt_result) = lo_object->get_search_result( ).
    ls_data-to_searchresults = gt_result.

    FIELD-SYMBOLS: <lf_data> TYPE any.
    CREATE DATA er_deep_entity LIKE ls_data.
    ASSIGN er_deep_entity->* TO <lf_data>.
    <lf_data> = ls_data.
  ENDMETHOD.
ENDCLASS.
