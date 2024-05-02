INTERFACE /simple/if_mdg_search_provider
  PUBLIC .
  METHODS search IMPORTING is_data TYPE any EXPORTING es_data TYPE any et_message TYPE bapiret2_t.
ENDINTERFACE.
