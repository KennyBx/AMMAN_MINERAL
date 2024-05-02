*CLASS lhc_MeasuringPoint DEFINITION INHERITING FROM cl_abap_behavior_handler.
*  PRIVATE SECTION.
*
*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE MeasuringPoint.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE MeasuringPoint.
*
*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE MeasuringPoint.
*
*    METHODS read FOR READ
*      IMPORTING keys FOR READ MeasuringPoint RESULT result.
*
*ENDCLASS.
*
*CLASS lhc_MeasuringPoint IMPLEMENTATION.
*
*  METHOD create.
*  ENDMETHOD.
*
*  METHOD delete.
*  ENDMETHOD.
*
*  METHOD update.
*  ENDMETHOD.
*
*  METHOD read.
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lsc_C_MeasuringPoint DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS check_before_save REDEFINITION.
*
*    METHODS finalize          REDEFINITION.
*
*    METHODS save              REDEFINITION.
*
*    METHODS adjust_numbers    REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_C_MeasuringPoint IMPLEMENTATION.
*
*  METHOD check_before_save.
*  ENDMETHOD.
*
*  METHOD finalize.
*  ENDMETHOD.
*
*  METHOD save.
*  ENDMETHOD.
*
*  METHOD adjust_numbers.
*  ENDMETHOD.
*
*ENDCLASS.
**********************************************************************
* Handler class
*
**********************************************************************
CLASS lcl_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR
        IMPORTING it_measuringpoint FOR CREATE MeasuringPoint.

    METHODS : map_deep_str
      IMPORTING it_source TYPE ANY TABLE
      CHANGING  ct_dest   TYPE ANY TABLE.

    DATA :
      gt_measuringpoint   TYPE TABLE FOR CREATE  /SIMPLE/C_MeasuringPoint.


ENDCLASS.

**********************************************************************
* Saver class
*
**********************************************************************
CLASS lcl_save DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS adjust_numbers    REDEFINITION.
    METHODS cleanup           REDEFINITION.
  PRIVATE SECTION.
    DATA:
     lt_mapped TYPE /simple/mpoi_service_provider=>gty_mapped_late.
ENDCLASS.

**********************************************************************
* Message Helpper class
*
**********************************************************************
CLASS lcl_message_helper DEFINITION
INHERITING FROM cl_abap_behv.

  PUBLIC SECTION.
    TYPES tt_failed   TYPE TABLE FOR FAILED   /SIMPLE/C_measuringpoint.
    TYPES tt_mapped   TYPE TABLE FOR MAPPED   /SIMPLE/C_measuringpoint.
    TYPES tt_reported TYPE TABLE FOR REPORTED /SIMPLE/C_measuringpoint.

    CLASS-METHODS handle_messages
      IMPORTING
        iv_cid      TYPE string OPTIONAL
        iS_key      TYPE /simple/mpoi_service_provider=>gty_mpoi_key_log
        it_messages TYPE bapiret2_t
      CHANGING
        failed      TYPE tt_failed
        reported    TYPE tt_reported.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA go_object TYPE REF TO lcl_message_helper.

    CLASS-METHODS get_message_object
      RETURNING VALUE(r_result) TYPE REF TO lcl_message_helper.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.

  METHOD map_deep_str.
    DATA:
      lo_type_descr TYPE REF TO cl_abap_typedescr,
      lo_tabl_descr TYPE REF TO cl_abap_tabledescr,
      lo_stru_descr TYPE REF TO cl_abap_structdescr,
      lt_fields     TYPE abap_compdescr_tab,
      ls_dest       TYPE REF TO data.

    FIELD-SYMBOLS:
      <fs_tab>      TYPE ANY TABLE,
      <fs_target>   TYPE ANY TABLE,
      <fs_comp_tab> TYPE ANY TABLE,
      <fs_dest>     TYPE any,
      <fs_source>   TYPE any.

    lo_type_descr = cl_abap_typedescr=>describe_by_data( p_data = ct_dest ).
    lo_tabl_descr ?= lo_type_descr.
    lo_stru_descr ?= lo_tabl_descr->get_table_line_type( ).

    lt_fields = lo_stru_descr->components.

    LOOP AT it_source ASSIGNING <fs_source>.
      ASSIGN COMPONENT '%CID' OF STRUCTURE <fs_source> TO FIELD-SYMBOL(<fs_cid>).
      IF <fs_cid> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      CREATE DATA ls_dest LIKE LINE OF ct_dest.
      ASSIGN ls_dest->* TO <fs_dest>.
      IF <fs_dest> IS ASSIGNED.

        <fs_dest> = CORRESPONDING #( <fs_source> ).

        LOOP AT lt_fields INTO DATA(ls_field)
          WHERE type_kind = cl_abap_typedescr=>typekind_table
            OR type_kind = cl_abap_typedescr=>typekind_struct1.
          ASSIGN COMPONENT ls_field-name OF STRUCTURE <fs_dest> TO FIELD-SYMBOL(<fs_comp>).
          IF <fs_comp> IS ASSIGNED.
            DATA(lv_tab_name) = ls_field-name.
            SHIFT lv_tab_name LEFT BY 2 PLACES.
            lv_tab_name = |GT{ lv_tab_name }|.

            ASSIGN (lv_tab_name) TO <fs_tab>.
            IF <fs_tab> IS ASSIGNED.

              LOOP AT <fs_tab> ASSIGNING FIELD-SYMBOL(<fs_line>).
                ASSIGN COMPONENT '%CID_REF' OF STRUCTURE <fs_line> TO FIELD-SYMBOL(<fs_id>).
                IF <fs_id> IS ASSIGNED AND <fs_id> = <fs_cid>.
                  ASSIGN COMPONENT '%TARGET' OF STRUCTURE <fs_line> TO <fs_target>.
                  IF <fs_target> IS ASSIGNED.
                    IF ls_field-type_kind = cl_abap_typedescr=>typekind_table.
                      me->map_deep_str( EXPORTING it_source = <fs_target>
                                        CHANGING  ct_dest   = <fs_comp> ).
                    ELSE.
                      CREATE DATA ls_dest LIKE TABLE OF <fs_comp>.
                      ASSIGN ls_dest->* TO <fs_comp_tab>.
                      me->map_deep_str( EXPORTING it_source = <fs_target>
                                        CHANGING  ct_dest   = <fs_comp_tab> ).
                      LOOP AT <fs_comp_tab> ASSIGNING FIELD-SYMBOL(<fs_tmp>).
                        <fs_comp> = <fs_tmp>.
                        EXIT.
                      ENDLOOP.
                    ENDIF.
                    UNASSIGN: <fs_target>.
                  ENDIF.
                ENDIF.
              ENDLOOP.
              UNASSIGN: <fs_tab>.
            ENDIF.
            UNASSIGN: <fs_comp>.
          ENDIF.
        ENDLOOP.

        INSERT <fs_dest> INTO TABLE ct_dest.
        UNASSIGN: <fs_dest>.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD modify.

    " Get BO instance
    DATA : ls_data TYPE /simple/mpoi_service_provider=>gty_measuringpoint.

    DATA : lt_data    TYPE STANDARD TABLE OF /simple/mpoi_service_provider=>gty_measuringpoint WITH DEFAULT KEY,
           lt_message TYPE bapiret2_t.

    DATA : lo_provider TYPE REF TO /simple/mpoi_service_provider.

    lo_provider = /simple/mpoi_service_provider=>get_instance(  ).

    gt_measuringpoint   = it_measuringpoint.

    map_deep_str( EXPORTING it_source = gt_measuringpoint
                  CHANGING  ct_dest = lt_data ) .

    READ TABLE lt_data INDEX 1 INTO ls_data.
    ls_data-cid = gt_measuringpoint[ 1 ]-%cid.

    lo_provider->set_data( is_data = ls_data ).

*   Create application log
    lo_provider->create_appl_log( ).

    INSERT VALUE #( %cid = ls_data-cid ) INTO TABLE mapped-measuringpoint.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_message_helper IMPLEMENTATION.

  METHOD get_message_object.
    IF go_object IS INITIAL.
      CREATE OBJECT go_object.
    ENDIF.
    r_result = go_object.
  ENDMETHOD.

  METHOD handle_messages.
*    LOOP AT it_messages INTO DATA(ls_message) WHERE type = 'E' OR type = 'A'.
*      APPEND VALUE #( %cid              = iv_cid
*                      measuringpoint     = is_key-measuringpoint )
*                      TO failed.
*
*      APPEND VALUE #(
*        %msg = get_message_object( )->new_message(
*                                 id       = ls_message-id
*                                 number   = ls_message-number
*                                 severity = if_abap_behv_message=>severity-error
*                                 v1       = ls_message-message_v1
*                                 v2       = ls_message-message_v2
*                                 v3       = ls_message-message_v3
*                                 v4       = ls_message-message_v4 )
*       %key-measuringpoint                = is_key-measuringpoint
*       %cid                               = iv_cid
*       measuringpoint                     = is_key-measuringpoint )
*     TO reported.
*    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_save IMPLEMENTATION.

  METHOD adjust_numbers.
*    /simple/mpoi_service_provider=>get_instance( )->adjust_number(
*      IMPORTING
*        et_mapped = DATA(lt_mapped) ).
*    mapped-measuringpoint = lt_mapped.
  ENDMETHOD.

  METHOD check_before_save.
    "Flynn start undim code - 20240313
    DATA :
      lt_message  TYPE bapiret2_t,
      lt_failed   TYPE lcl_message_helper=>tt_failed,
      lt_reported TYPE lcl_message_helper=>tt_reported.
    DATA: lv_deep_mpoi TYPE string.
    DATA(lo_object) = /simple/mpoi_service_provider=>get_instance( ).

    IF lo_object->get_action( ) IS NOT INITIAL.
      DATA(lv_action) = |{ lo_object->get_action( ) CASE = UPPER }|.
    ENDIF.
    IF to_upper( lo_object->get_action_mode( ) ) NS 'BACKGROUND'.
      CALL FUNCTION '/SIMPLE/FM_MPOI_EXCUTE' "DESTINATION 'NONE'
        EXPORTING
          iv_raw       = lo_object->get_raw_data( )
        IMPORTING
          et_message   = lt_message
        CHANGING
          cs_deep_mpoi = lv_deep_mpoi.
    ENDIF.
*    CASE lv_action.
*      WHEN 'CREATE' OR ''.
*        lo_object->/simple/if_mdg_srv_provider~create( IMPORTING et_message = lt_message ).
*      WHEN 'CHANGE'.
*        lo_object->/simple/if_mdg_srv_provider~change( IMPORTING et_message = lt_message ).
*      WHEN 'DELETE'.
*        lo_object->/simple/if_mdg_srv_provider~delete( IMPORTING et_message = lt_message ).
*      WHEN OTHERS.
*    ENDCASE.

*--------------------------------------------------------------------*
    " Handle error
*--------------------------------------------------------------------*
    lo_object->get_object_key(
        IMPORTING
        ev_cid = DATA(lv_cid)
        es_key = DATA(ls_key)  ).
    IF line_exists( lt_message[ type = 'E' ] ) " Error
     OR line_exists( lt_message[ type = 'A' ] )
     OR line_exists( lt_message[ type = 'X' ] ).

      lcl_message_helper=>handle_messages(
        EXPORTING
          iv_cid           = lv_cid
          is_key           = ls_key
          it_messages      = lt_message
   CHANGING
          failed           = lt_failed
          reported         = lt_reported ).
      failed-measuringpoint   = CORRESPONDING #( lt_failed ).
      reported-measuringpoint = CORRESPONDING #( lt_reported ).

      " update API log step = B - before save
      lo_object->update_log_table(
        EXPORTING
          iv_save   = 'X'
          iv_status = 'E'
          iv_step   = 'B'
      ).
    ENDIF.
    "Flynn end undim code - 20240313
  ENDMETHOD.

  METHOD cleanup.
    " clear buffer instance
    /simple/mpoi_service_provider=>/simple/if_mdg_srv_provider~clean_up( ).
  ENDMETHOD.

  METHOD finalize.

  ENDMETHOD.

  METHOD save.

    "Flynn start insert++ - 20240313
    DATA :
      lt_message  TYPE bapiret2_t,
      lt_failed   TYPE lcl_message_helper=>tt_failed,
      lt_reported TYPE lcl_message_helper=>tt_reported.

    DATA: my_destination TYPE REF TO if_bgrfc_destination_inbound,
          my_unit        TYPE REF TO if_qrfc_unit_inbound,
          queue_name     TYPE qrfc_queue_name.
    DATA: my_fieldvalue TYPE bgrfc_dest_name_inbound.
    SELECT *
    FROM /simple/mdg_conf
    INTO TABLE @DATA(lt_mdg_conf).
    READ TABLE lt_mdg_conf INTO DATA(ls_mdg_conf) WITH KEY fieldname = 'BGRFC_DESTINATION'.
    IF sy-subrc = 0.
      my_fieldvalue = ls_mdg_conf-fieldvalue.
      my_destination = cl_bgrfc_destination_inbound=>create( my_fieldvalue ).
      my_unit = my_destination->create_qrfc_unit( ).
      my_unit->if_bgrfc_unit~disable_commit_checks( ).
    ENDIF.
    DATA(lo_object) = /simple/mpoi_service_provider=>get_instance( ).
    DATA: lt_header           TYPE /simple/t_core_http_header.
    TRY .
        FIELD-SYMBOLS <fs_fs_fs> TYPE any.
        ASSIGN ('(SAPLHTTP_RUNTIME)server_accepted_org->request') TO <fs_fs_fs>.
        DATA lo_http_req TYPE REF TO if_http_request.
        lo_http_req ?= <fs_fs_fs>.
        lt_header = VALUE #( (   name   = 'messaging_core'
                                value   = lo_http_req->get_header_field( 'messaging_core' ) )
                             (   name   = 'messaging_object_type'
                                 value  = lo_http_req->get_header_field( 'messaging_object_type'  ) ) ).
      CATCH cx_root INTO DATA(lo_root1).
        DATA(lv_err) = lo_root1->get_text( ) .

    ENDTRY.
    IF to_upper( lo_object->get_action_mode( ) ) CS 'BACKGROUND'.
      TRY .
          CALL FUNCTION '/SIMPLE/FM_MPOI_EXCUTE' IN BACKGROUND UNIT my_unit
            EXPORTING
              iv_raw    = lo_object->get_raw_data( )
              it_header = lt_header.
          /simple/cl_mdg_gw_core_dpc_ext=>handle_queue_rfc(
            EXPORTING
              is_unit      = my_unit
            EXCEPTIONS
              eo_exception = 1
              OTHERS       = 2
          ).
          IF sy-subrc <> 0.
            lt_message = VALUE #( BASE lt_message (
                                       type       = sy-msgty
                                       id         = sy-msgid
                                       number     = sy-msgno
                                       message_v1 = sy-msgv1
                                       message_v2 = sy-msgv2
                                       message_v3 = sy-msgv3
                                       message_v4 = sy-msgv4 ) ).
          ENDIF.
        CATCH cx_root INTO DATA(lo_root).
          lt_message = VALUE #( BASE lt_message (
                                     type       = 'E'
                                     message    =  lo_root->get_text( ) ) ).
      ENDTRY.
    ENDIF.
    lo_object->get_object_key(
        IMPORTING
        ev_cid = DATA(lv_cid)
        es_key = DATA(ls_key)  ).

    APPEND VALUE #(  measuringpoint = ls_key-measuring_point
                    ) TO lt_mapped.
    "Flynn end insert++ - 20240313

    /simple/mpoi_service_provider=>get_instance(  )->update_log_table(
     EXPORTING
       iv_save   = 'X'
       iv_status = 'S'
       iv_step   = 'S' ).


  ENDMETHOD.

ENDCLASS.
