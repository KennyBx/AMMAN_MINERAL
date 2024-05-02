CLASS lhc_eventmesh DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE eventmesh.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE eventmesh.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE eventmesh.

    METHODS read FOR READ
      IMPORTING keys FOR READ eventmesh RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK eventmesh.

ENDCLASS.

CLASS lhc_eventmesh IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_c_event_mesh DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_c_event_mesh IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
