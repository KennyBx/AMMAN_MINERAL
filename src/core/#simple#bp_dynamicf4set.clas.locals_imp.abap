 CLASS lcl_service_provider DEFINITION.
   PUBLIC SECTION.
     CLASS-DATA gs_data TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4.
     CLASS-METHODS get_instance RETURNING VALUE(ro_object) TYPE REF TO /simple/cl_multiplesearchhelp.

   PROTECTED SECTION.
   PRIVATE SECTION.
     CLASS-DATA go_object TYPE REF TO /simple/cl_multiplesearchhelp.
 ENDCLASS.

 CLASS lcl_service_provider IMPLEMENTATION.
   METHOD get_instance.
     IF go_object IS INITIAL.
       go_object = NEW #( ).
     ENDIF.
     ro_object = go_object.
   ENDMETHOD.
 ENDCLASS.

 CLASS lhc_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
   PRIVATE SECTION.

     METHODS modify FOR MODIFY
       IMPORTING it_dynamicf4set FOR CREATE dynamicf4set
                 it_mddynamic    FOR CREATE dynamicf4set\_mddynamic.

     METHODS read FOR READ
       IMPORTING it_dynamicf4set FOR READ dynamicf4set RESULT et_dynamicf4set
                 it_mddynamic    FOR READ dynamicf4set\_mddynamic FULL field1_requested RESULT et_mddynamic LINK link1.

     METHODS: map_deep_str
       IMPORTING it_source TYPE ANY TABLE
       CHANGING  ct_dest   TYPE ANY TABLE.
     DATA:
       gt_dynamicf4set TYPE TABLE FOR CREATE /simple/dynamicf4set,
       gt_mddynamic    TYPE TABLE FOR CREATE /simple/dynamicf4set\_mddynamic.
 ENDCLASS.

 CLASS lhc_handler IMPLEMENTATION.
   METHOD modify.

     DATA:
       ls_data TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4,
       lt_data TYPE STANDARD TABLE OF /simple/cl_multiplesearchhelp=>gty_dynamicf4.


     gt_dynamicf4set = it_dynamicf4set.
     gt_mddynamic = it_mddynamic.

     me->map_deep_str(
       EXPORTING
         it_source = gt_dynamicf4set
       CHANGING
         ct_dest = lt_data ).


     READ TABLE lt_data INDEX 1 INTO ls_data.
     ls_data-cid = gt_dynamicf4set[ 1 ]-%cid.

*     INSERT VALUE #(
*        %cid = ls_data-cid
*        tableName = ls_data-tableName
*        fieldName = ls_data-fieldName
*        language = ls_data-language
*        filter = ls_data-filter
*        )
*         INTO TABLE mapped-dynamicf4set.


     DATA ls_dynamic_data TYPE /simple/cl_multiplesearchhelp=>gty_dynamicf4.
*    DATA LS_DYNAMIC_DATA TYPE /SIMPLE/CL_MDG_F4_MPC=>TT_DYNAMICF4.

*    io_data_provider->read_entry_data( IMPORTING es_data = ls_dynamic_data ).
     IF   gt_dynamicf4set IS NOT INITIAL.
       MOVE-CORRESPONDING  gt_dynamicf4set[ 1 ] TO  ls_dynamic_data.
     ENDIF.

     DATA(lo_object) = lcl_service_provider=>get_instance( ).

     IF lo_object IS BOUND.
       ls_dynamic_data-fieldname = to_upper( ls_dynamic_data-fieldname  ).
       DATA(ls_dynamic_data_t) = ls_dynamic_data.
*--------------------------------------------------------------------*
       "Search with table /SIMPLE/DYNAMICF
*--------------------------------------------------------------------*
       SELECT *
         INTO TABLE @DATA(lt_dynamicf)
         FROM /simple/dynamicf
         WHERE tablename_input = @ls_dynamic_data-tablename
           AND fieldname_input = @ls_dynamic_data-fieldname.
       IF lt_dynamicf IS NOT INITIAL.
         LOOP AT lt_dynamicf[] INTO DATA(ls_dynamicf).
           ls_dynamic_data-tablename = ls_dynamicf-tablename_output.
           ls_dynamic_data-fieldname = ls_dynamicf-fieldname_output.

           lo_object->get_dynamicf4(
             CHANGING
               cs_data = ls_dynamic_data
           ).
         ENDLOOP.

       ELSE.
         lo_object->get_dynamicf4(
           CHANGING
             cs_data = ls_dynamic_data
         ).
       ENDIF.

*--------------------------------------------------------------------*
       "Search from table T682Z
*--------------------------------------------------------------------*
       IF  ls_dynamic_data-to_mddynamic[]  IS INITIAL
       AND ls_dynamic_data-tablename       IS INITIAL.
         ls_dynamic_data-fieldname = to_upper( ls_dynamic_data-fieldname  ).
         SELECT DISTINCT t682z~qustr, t682z~qufna
           FROM t682z
           WHERE upper( t682z~zifna ) = @ls_dynamic_data-fieldname
             AND t682z~qustr <> ''
             AND t682z~qufna <> ''
           INTO TABLE @DATA(lt_t682z).
         LOOP AT lt_t682z INTO DATA(ls_t682z).
           ls_dynamic_data-tablename = ls_t682z-qustr.
           ls_dynamic_data-fieldname = ls_t682z-qufna.
           lo_object->get_dynamicf4(
             CHANGING
               cs_data = ls_dynamic_data
           ).
           IF ls_dynamic_data-to_mddynamic[] IS NOT INITIAL.
             EXIT.
           ENDIF.
         ENDLOOP.
       ENDIF.

       LOOP AT ls_dynamic_data-to_mddynamic[] ASSIGNING FIELD-SYMBOL(<lfs_mddynamic>).
         <lfs_mddynamic>-tablename = ls_dynamic_data_t-tablename.
         <lfs_mddynamic>-fieldname = ls_dynamic_data_t-fieldname.
       ENDLOOP.
       ls_dynamic_data-tablename = ls_dynamic_data_t-tablename.
       ls_dynamic_data-fieldname = ls_dynamic_data_t-fieldname.
     ENDIF.

     "LD-0116  - 20231114   - Danh Tran - Start -Ins
*     if ls_dynamic_data-to_mddynamic  is not initial.
*        ls_data-language    =   ls_dynamic_data-to_mddynamic[ 1 ]-language.
*     endif.

     ls_data-cid = gt_dynamicf4set[ 1 ]-%cid.

     INSERT VALUE #(
        %cid = ls_data-cid
        tableName = ls_data-tableName
        fieldName = ls_data-fieldName
*        language = ls_data-language
        filter = ls_data-filter
        )
         INTO TABLE mapped-dynamicf4set.
     "LD-0116  - 20231114   - Danh Tran - Start -Ins

     lcl_service_provider=>gs_data = ls_dynamic_data.


   ENDMETHOD.

   METHOD read.
     IF it_dynamicf4set IS NOT INITIAL.
       APPEND INITIAL LINE TO et_dynamicf4set ASSIGNING FIELD-SYMBOL(<LFS_dynamicf4set>).
       <LFS_dynamicf4set> = CORRESPONDING #( lcl_service_provider=>gs_data ).
     ELSEIF field1_requested IS NOT INITIAL.
       et_mddynamic = CORRESPONDING #( lcl_service_provider=>gs_data-to_mddynamic[] ).
     ENDIF.
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

 CLASS lsc_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
   PROTECTED SECTION.
     METHODS check_before_save REDEFINITION.
     METHODS finalize          REDEFINITION.
     METHODS save              REDEFINITION.
     METHODS adjust_numbers    REDEFINITION.

    DATA:
        lt_mapped TYPE /simple/cl_multiplesearchhelp=>t_DynamicF4Set_mapped_late.
 ENDCLASS.

 CLASS lsc_saver IMPLEMENTATION.

   METHOD check_before_save.
*    APPEND INITIAL LINE TO lt_mapped ASSIGNING FIELD-SYMBOL(<LFS_MAPPED>).
*    MOVE-CORRESPONDING lcl_service_provider=>gs_data TO <LFS_MAPPED> EXPANDING NESTED TABLES.
*
**        APPEND VALUE #( businessPartner = lv_businessparnter
**                    ) TO lt_mapped.

   ENDMETHOD.

   METHOD finalize.
   ENDMETHOD.

   METHOD save.
   ENDMETHOD.

  METHOD adjust_numbers.
*    /simple/bp_service_provider=>get_instance( )->adjust_number(
*      IMPORTING
*        et_mapped = DATA(lt_mapped) ).

*    mapped-dynamicf4set = lt_mapped.
  ENDMETHOD.
 ENDCLASS.
