FUNCTION /simple/fm_prd_execute2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_MESSAGE) TYPE  BAPIRET2_T
*"  EXCEPTIONS
*"      ERROR_MESSAGE
*"----------------------------------------------------------------------

  "Get instance object
  DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).

  CASE to_upper( lo_object->get_action( ) ).
    WHEN 'CREATE' OR ''.
      lo_object->/simple/if_mdg_srv_provider~create( IMPORTING et_message = et_message ).
    WHEN 'CHANGE'.
      lo_object->/simple/if_mdg_srv_provider~change( IMPORTING et_message = et_message ).
    WHEN 'DELETE'.
      lo_object->/simple/if_mdg_srv_provider~delete( IMPORTING et_message = et_message ).
    WHEN OTHERS.
  ENDCASE.

  CLEAR sy-subrc.
ENDFUNCTION.
