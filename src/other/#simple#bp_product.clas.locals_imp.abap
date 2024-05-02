**********************************************************************
*
* Message helper class
*
**********************************************************************
CLASS lcl_message_helper DEFINITION
INHERITING FROM cl_abap_behv.

  PUBLIC SECTION.
    TYPES tt_failed   TYPE TABLE FOR FAILED   /simple/c_product.
    TYPES tt_mapped   TYPE TABLE FOR MAPPED   /simple/c_product.
    TYPES tt_reported TYPE TABLE FOR REPORTED /simple/c_product.

    CLASS-METHODS handle_messages
      IMPORTING
        iv_cid      TYPE string OPTIONAL
        iv_product  TYPE /simple/c_product-product
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

CLASS lcl_message_helper IMPLEMENTATION.

  METHOD handle_messages.

    LOOP AT it_messages INTO DATA(ls_message) WHERE type = 'E' OR type = 'A'.
      APPEND VALUE #( %cid = iv_cid  product = iv_product )
             TO failed.

      APPEND VALUE #(
        %msg = get_message_object( )->new_message(
                                 id       = ls_message-id
                                 number   = ls_message-number
                                 severity = if_abap_behv_message=>severity-error
                                 v1       = ls_message-message_v1
                                 v2       = ls_message-message_v2
                                 v3       = ls_message-message_v3
                                 v4       = ls_message-message_v4 )
       %key-product = iv_product
       %cid               = iv_cid
       product      = iv_product )
     TO reported.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_message_object.
    IF go_object IS INITIAL.
      CREATE OBJECT go_object.
    ENDIF.
    r_result = go_object.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
*
* Handler class
*
**********************************************************************
CLASS lhc_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
                            it_product                     FOR CREATE product
                            it_description                 FOR CREATE product\_description
                            it_plant                       FOR CREATE product\_plant
                            it_salesdelivery               FOR CREATE product\_salesdelivery
                            it_productsalestax             FOR CREATE product\_productsalestax
                            it_productsales                FOR CREATE product\_productsales
                            it_productqualitymgmt          FOR CREATE product\_productqualitymgmt
                            it_productprocurement          FOR CREATE product\_productprocurement
                            it_productbasictext            FOR CREATE product\_productbasictext
                            it_productunitsofmeasure       FOR CREATE product\_productunitsofmeasure
                            it_productstorage              FOR CREATE product\_productstorage
                            it_productinspectiontext       FOR CREATE product\_productinspectiontext
                            it_productpurchasetext         FOR CREATE product\_productpurchasetext
                            it_valuation                   FOR CREATE product\_valuation
                            it_productwarehouse            FOR CREATE product\_productwarehouse
                            it_classification              FOR CREATE product\_classification
                            it_storagelocation             FOR CREATE productplant\_storagelocation
                            it_productplantprocurement     FOR CREATE productplant\_productplantprocurement
                            it_productworkscheduling       FOR CREATE productplant\_productworkscheduling
                            it_productsupplyplanning       FOR CREATE productplant\_productsupplyplanning
                            it_prodplantinternationaltrade FOR CREATE productplant\_prodplantinternationaltrade
                            it_productplantcosting         FOR CREATE productplant\_productplantcosting
                            it_productplantforecast        FOR CREATE productplant\_productplantforecast
                            it_plantqualitymgmt            FOR CREATE productplant\_plantqualitymgmt
                            it_plantsales                  FOR CREATE productplant\_plantsales
                            it_plantstorage                FOR CREATE productplant\_plantstorage
                            it_planttext                   FOR CREATE productplant\_planttext
                            it_plantmrparea                FOR CREATE productplant\_plantmrparea
                            it_insptypesttng               FOR CREATE productplant\_insptypesttng
                            it_prodplntfcstparam           FOR CREATE productplant\_prodplntfcstparam
                            it_productresoucetool          FOR CREATE productplant\_productresourcetool
                            it_salestext                   FOR CREATE productsalesdelivery\_salestext
                            it_internationalarticlenumber  FOR CREATE prdtunitsofmeasure\_internationalarticlenumber
                            it_valuationaccount            FOR CREATE productvaluation\_valuationaccount
                            it_mlaccount                   FOR CREATE productvaluation\_mlaccount
                            it_mlprices                    FOR CREATE productvaluation\_mlprices
                            it_productstoragetype          FOR CREATE productwarehouse\_productstoragetype
                            it_characteristic              FOR CREATE classification\_characteristic
                            it_revisionlevel               FOR CREATE product\_revisionlevel
                            it_prdextendwarehouse          FOR CREATE product\_prdextendwarehouse.
    METHODS: map_deep_str
      IMPORTING it_source TYPE ANY TABLE
      CHANGING  ct_dest   TYPE ANY TABLE.
    DATA:
      gt_product                     TYPE TABLE FOR CREATE /simple/c_product,
      gt_description                 TYPE TABLE FOR CREATE /simple/c_product\_description,
      gt_plant                       TYPE TABLE FOR CREATE /simple/c_product\_plant,
      gt_salesdelivery               TYPE TABLE FOR CREATE /simple/c_product\_salesdelivery,
      gt_productsalestax             TYPE TABLE FOR CREATE /simple/c_product\_productsalestax,
      gt_productsales                TYPE TABLE FOR CREATE /simple/c_product\_productsales,
      gt_productqualitymgmt          TYPE TABLE FOR CREATE /simple/c_product\_productqualitymgmt,
      gt_productprocurement          TYPE TABLE FOR CREATE /simple/c_product\_productprocurement,
      gt_productbasictext            TYPE TABLE FOR CREATE /simple/c_product\_productbasictext,
      gt_productunitsofmeasure       TYPE TABLE FOR CREATE /simple/c_product\_productunitsofmeasure,
      gt_productstorage              TYPE TABLE FOR CREATE /simple/c_product\_productstorage,
      gt_productinspectiontext       TYPE TABLE FOR CREATE /simple/c_product\_productinspectiontext,
      gt_productpurchasetext         TYPE TABLE FOR CREATE /simple/c_product\_productpurchasetext,
      gt_valuation                   TYPE TABLE FOR CREATE /simple/c_product\_valuation,
      gt_productwarehouse            TYPE TABLE FOR CREATE /simple/c_product\_productwarehouse,
      gt_storagelocation             TYPE TABLE FOR CREATE /simple/c_productplant\_storagelocation,
      gt_productplantprocurement     TYPE TABLE FOR CREATE /simple/c_productplant\_productplantprocurement,
      gt_productworkscheduling       TYPE TABLE FOR CREATE /simple/c_productplant\_productworkscheduling,
      gt_productsupplyplanning       TYPE TABLE FOR CREATE /simple/c_productplant\_productsupplyplanning,
      gt_prodplantinternationaltrade TYPE TABLE FOR CREATE /simple/c_productplant\_prodplantinternationaltrade,
      gt_productplantcosting         TYPE TABLE FOR CREATE /simple/c_productplant\_productplantcosting,
      gt_productplantforecast        TYPE TABLE FOR CREATE /simple/c_productplant\_productplantforecast,
      gt_plantqualitymgmt            TYPE TABLE FOR CREATE /simple/c_productplant\_plantqualitymgmt,
      gt_plantsales                  TYPE TABLE FOR CREATE /simple/c_productplant\_plantsales,
      gt_plantstorage                TYPE TABLE FOR CREATE /simple/c_productplant\_plantstorage,
      gt_planttext                   TYPE TABLE FOR CREATE /simple/c_productplant\_planttext,
      gt_plantmrparea                TYPE TABLE FOR CREATE /simple/c_productplant\_plantmrparea,
      gt_insptypesttng               TYPE TABLE FOR CREATE /simple/c_productplant\_insptypesttng,
      gt_prodplntfcstparam           TYPE TABLE FOR CREATE /simple/c_productplant\_prodplntfcstparam,
      gt_salestext                   TYPE TABLE FOR CREATE /simple/c_productsalesdelivery\_salestext,
      gt_internationalarticlenumber  TYPE TABLE FOR CREATE /simple/c_prdunitsofmeasure\_internationalarticlenumber,
      gt_valuationaccount            TYPE TABLE FOR CREATE /simple/c_productvaluation\_valuationaccount,
      gt_mlaccount                   TYPE TABLE FOR CREATE /simple/c_productvaluation\_mlaccount,
      gt_mlprices                    TYPE TABLE FOR CREATE /simple/c_productvaluation\_mlprices,
      gt_productstoragetype          TYPE TABLE FOR CREATE /simple/c_productwarehouse\_productstoragetype,
      gt_classification              TYPE TABLE FOR CREATE /simple/c_product\_classification,
      gt_characteristic              TYPE TABLE FOR CREATE /simple/c_prdclassification\_characteristic,
      gt_productresourcetool         TYPE TABLE FOR CREATE /simple/c_productplant\_productresourcetool,
      gt_revisionlevel               TYPE TABLE FOR CREATE /simple/c_product\_revisionlevel,
      gt_prdextendwarehouse          TYPE TABLE FOR CREATE /simple/c_product\_prdextendwarehouse.


ENDCLASS.
CLASS lhc_handler IMPLEMENTATION.
  METHOD modify.
    " Get BO instance
    DATA ls_data TYPE /simple/prd_service_provider=>gty_deep_data.
    DATA lt_data TYPE STANDARD TABLE OF /simple/prd_service_provider=>gty_deep_data WITH DEFAULT KEY.
    DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Map importing tables to deep structure
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    gt_product                     = it_product                     .
    gt_description                 = it_description                 .
    gt_plant                       = it_plant                       .
    gt_salesdelivery               = it_salesdelivery               .
    gt_productsalestax             = it_productsalestax             .
    gt_productsales                = it_productsales                .
    gt_productqualitymgmt          = it_productqualitymgmt          .
    gt_productprocurement          = it_productprocurement          .
    gt_productbasictext            = it_productbasictext            .
    gt_productunitsofmeasure       = it_productunitsofmeasure       .
    gt_productstorage              = it_productstorage              .
    gt_productinspectiontext       = it_productinspectiontext       .
    gt_productpurchasetext         = it_productpurchasetext         .
    gt_valuation                   = it_valuation                   .
    gt_productwarehouse            = it_productwarehouse            .
    gt_storagelocation             = it_storagelocation             .
    gt_productplantprocurement     = it_productplantprocurement     .
    gt_productworkscheduling       = it_productworkscheduling       .
    gt_productsupplyplanning       = it_productsupplyplanning       .
    gt_prodplantinternationaltrade = it_prodplantinternationaltrade .
    gt_productplantcosting         = it_productplantcosting         .
    gt_productplantforecast        = it_productplantforecast        .
    gt_plantqualitymgmt            = it_plantqualitymgmt            .
    gt_plantsales                  = it_plantsales                  .
    gt_plantstorage                = it_plantstorage                .
    gt_planttext                   = it_planttext                   .
    gt_plantmrparea                = it_plantmrparea                .
    gt_insptypesttng               = it_insptypesttng               .
    gt_prodplntfcstparam           = it_prodplntfcstparam           .
    gt_salestext                   = it_salestext                   .
    gt_internationalarticlenumber  = it_internationalarticlenumber  .
    gt_valuationaccount            = it_valuationaccount            .
    gt_mlaccount                   = it_mlaccount                   .
    gt_mlprices                    = it_mlprices                    .
    gt_productstoragetype          = it_productstoragetype          .
    gt_classification              = it_classification              .
    gt_characteristic              = it_characteristic              .
    gt_productresourcetool         = it_productresoucetool          .
    gt_revisionlevel               = it_revisionlevel.
    gt_prdextendwarehouse          = it_prdextendwarehouse.

    me->map_deep_str(
      EXPORTING
        it_source = gt_product
      CHANGING
        ct_dest = lt_data ).

    READ TABLE lt_data INDEX 1 INTO ls_data.
    ls_data-cid = gt_product[ 1 ]-%cid.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_object->set_data( is_data = ls_data ).
    lo_object->create_appl_log( ).

    INSERT VALUE #( %cid = ls_data-cid ) INTO TABLE mapped-product.

  ENDMETHOD.

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
            OR type_kind = cl_abap_typedescr=>typekind_struct1
            OR type_kind = cl_abap_typedescr=>typekind_struct2.
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
ENDCLASS.

**********************************************************************
*
* Saver class implements the save sequence for data persistence
*
**********************************************************************
CLASS lsc_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS adjust_numbers    REDEFINITION.
    METHODS cleanup           REDEFINITION.

  PRIVATE SECTION.
    DATA:
         lt_mapped TYPE /simple/prd_service_provider=>t_mapped_late.

ENDCLASS.

CLASS lsc_saver IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
*    DATA:
*      lt_message  TYPE bapiret2_t,
*      lt_failed   TYPE lcl_message_helper=>tt_failed,
*      lt_reported TYPE lcl_message_helper=>tt_reported.
*
*    DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).
*
*    CASE lo_object->get_action( ).
*      WHEN 'Create' OR ''.
*        lo_object->/simple/if_mdg_srv_provider~create( IMPORTING et_message = lt_message ).
*      WHEN 'Change'.
*        lo_object->/simple/if_mdg_srv_provider~change( IMPORTING et_message = lt_message ).
*      WHEN 'Delete'.
*        lo_object->/simple/if_mdg_srv_provider~delete( IMPORTING et_message = lt_message ).
*      WHEN OTHERS.
*    ENDCASE.
*
*    lo_object->get_object_key(
*        IMPORTING
*        ev_cid = DATA(lv_cid)
*        ev_product = DATA(lv_product)
*        ev_background = DATA(lv_background)  ).
*
*    IF lv_background IS INITIAL.
*      IF line_exists( lt_message[ type = 'E' ] ) " Error
*        OR line_exists( lt_message[ type = 'A' ] )
*        OR line_exists( lt_message[ type = 'X' ] ).
*        lcl_message_helper=>handle_messages(
*          EXPORTING
*            iv_cid           = lv_cid
*            iv_product       = lv_product
*            it_messages      = lt_message
*            CHANGING
*            failed           = lt_failed
*            reported         = lt_reported ).
*        failed-product   = CORRESPONDING #( lt_failed ).
*        reported-product = CORRESPONDING #( lt_reported ).
*
*        " update api log step = B - before save
*        lo_object->update_log_table(
*          EXPORTING
*            iv_save   = 'X'
*            iv_status = 'E'
*            iv_step   = 'B'
*        ).
*      ENDIF.
*    ENDIF.
    DATA :
      lt_message  TYPE bapiret2_t,
      lt_failed   TYPE lcl_message_helper=>tt_failed,
      lt_reported TYPE lcl_message_helper=>tt_reported.

    DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).
*Start of Insert 26072023
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
*End of Insert 26072023
    IF to_upper( lo_object->get_action_mode( ) ) NS 'BACKGROUND'.
      CALL FUNCTION '/SIMPLE/FM_PRD_EXECUTE'
        EXPORTING
          iv_raw     = lo_object->get_raw_data( )
          it_header  = lt_header "BEN 30052023
        IMPORTING
          et_message = lt_message.
    ENDIF.

    lo_object->get_object_key(
        IMPORTING
        ev_cid = DATA(lv_cid)
        ev_product = DATA(lv_product)  ).

    APPEND VALUE #( product = lv_product
                    ) TO lt_mapped.

    IF line_exists( lt_message[ type = 'E' ] ) " Error
      OR line_exists( lt_message[ type = 'A' ] )
      OR line_exists( lt_message[ type = 'X' ] ).

      lcl_message_helper=>handle_messages(
        EXPORTING
          iv_cid           = lv_cid
          iv_product           = lv_product
          it_messages      = lt_message
        CHANGING
          failed           = lt_failed
          reported         = lt_reported ).
      failed-product   = CORRESPONDING #( lt_failed ).
      reported-product = CORRESPONDING #( lt_reported ).
    ENDIF.

  ENDMETHOD.

  METHOD save.
*    /simple/prd_service_provider=>get_instance( )->update_log_table(
*      EXPORTING
*        iv_save   = 'X'
*        iv_status = 'S'
*        iv_step   = 'S'
*    ).

    DATA :
      lt_message  TYPE bapiret2_t,
      lt_failed   TYPE lcl_message_helper=>tt_failed,
      lt_reported TYPE lcl_message_helper=>tt_reported.

    DATA: my_destination TYPE REF TO if_bgrfc_destination_inbound,
          my_unit        TYPE REF TO if_qrfc_unit_inbound,
          queue_name     TYPE qrfc_queue_name.

*Start of Insert 26072023
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
*End of Insert 26072023
    DATA(lo_object) = /simple/prd_service_provider=>get_instance( ).

    IF to_upper( lo_object->get_action_mode( ) ) CS 'BACKGROUND'.

      "20.11.2023 elsa update - start
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
      "20.11.2023 elsa update - end

      TRY .

*          my_destination = cl_bgrfc_destination_inbound=>create( 'BGRFC_SUPERVISOR' ).
*          my_unit = my_destination->create_qrfc_unit( ).
*          my_unit->if_bgrfc_unit~disable_commit_checks( ).

          CALL FUNCTION '/SIMPLE/FM_PRD_EXECUTE' IN BACKGROUND UNIT my_unit
            EXPORTING
              iv_raw    = lo_object->get_raw_data( )
              it_header = lt_header. "BEN 30052023


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
        ev_product = DATA(lv_product)  ).

    APPEND VALUE #( product = lv_product ) TO lt_mapped.

  ENDMETHOD.

  METHOD cleanup.
    " clear buffer instance
    /simple/prd_service_provider=>/simple/if_mdg_srv_provider~clean_up( ).
  ENDMETHOD.

  METHOD adjust_numbers.
    /simple/prd_service_provider=>get_instance( )->adjust_number(
      IMPORTING
        et_mapped = DATA(lt_mapped) ).
    mapped-product = lt_mapped.
  ENDMETHOD.

  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).
      "get and add filter
      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).
        CATCH cx_rap_query_filter_no_range.
      ENDTRY.

    ENDIF.

    DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
    DATA(lt_fields)  = io_request->get_requested_elements( ).
    DATA(lt_sort)    = io_request->get_sort_elements( ).
  ENDMETHOD.

ENDCLASS.
