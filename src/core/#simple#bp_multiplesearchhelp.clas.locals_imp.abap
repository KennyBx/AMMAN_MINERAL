 CLASS lcl_service_provider DEFINITION.
   PUBLIC SECTION.
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
       IMPORTING it_multiplesearch    FOR CREATE multiplesearch
                 it_searchhelprequest FOR CREATE multiplesearch\_searchrequest
                 it_searchhelp        FOR CREATE searchrequest\_searchhelp
                 it_searchhelpfield   FOR CREATE searchhelp\_searchfield
                 it_searchhelpresult  FOR CREATE searchrequest\_searchresult.

     METHODS read FOR READ
       IMPORTING it_multiplesearch    FOR READ multiplesearch RESULT et_multiplesearch
                 it_searchhelprequest FOR READ multiplesearch\_searchrequest FULL field1_requested RESULT et_request LINK link1
                 it_searchhelp        FOR READ searchrequest\_searchhelp FULL field2_requested RESULT et_searchhelp LINK link2
                 it_searchhelpfield   FOR READ searchhelp\_searchfield FULL field3_requested RESULT et_field LINK link3
                 it_searchhelpresult  FOR READ searchrequest\_searchresult FULL field4_requested RESULT et_result LINK link4.

 ENDCLASS.

 CLASS lhc_handler IMPLEMENTATION.
   METHOD modify.
     DATA:
       ls_data            TYPE /simple/cl_multiplesearchhelp=>gty_multiplesearchhelp,
       ls_request_data    TYPE /simple/cl_multiplesearchhelp=>gty_searchhelprequest,
       ls_searchhelp_data TYPE /simple/cl_multiplesearchhelp=>gty_searchhelp.

     "Multiple Search Help
     TRY.
         DATA(ls_multiplesearch) = it_multiplesearch[ 1 ].
         DATA(lt_request_link) = it_searchhelprequest[ %cid_ref = ls_multiplesearch-%cid ]-%target.
       CATCH cx_sy_itab_line_not_found.
         RETURN.
     ENDTRY.
     ls_data = CORRESPONDING #( ls_multiplesearch ).
     ls_data-multiplekey = ls_multiplesearch-%cid.

     "Insert to Mapped table
     INSERT VALUE #(
            %cid = ls_multiplesearch-%cid
            multiplekey = ls_data-multiplekey
     ) INTO TABLE mapped-multiplesearch.

     "Search Help Request
     LOOP AT lt_request_link INTO DATA(ls_request_link).
       TRY.
           DATA(lt_searchhelp) = it_searchhelp[ %cid_ref = ls_request_link-%cid ]-%target.
         CATCH cx_sy_itab_line_not_found.
           CONTINUE.
       ENDTRY.

       ls_request_data = CORRESPONDING #( ls_request_link ).
       ls_request_data-multiplekey = ls_data-multiplekey.
       ls_request_data-requestkey = ls_request_link-%cid.

       "Insert to Mapped table
       INSERT VALUE #(
              %cid = ls_request_link-%cid
              multiplekey = ls_request_data-multiplekey
              requestkey = ls_request_data-requestkey
       ) INTO TABLE mapped-searchrequest.

       "Search Help
       LOOP AT lt_searchhelp INTO DATA(ls_searchhelp).
         TRY.
             DATA(lt_searchfield) = it_searchhelpfield[ %cid_ref = ls_searchhelp-%cid ]-%target.
           CATCH cx_sy_itab_line_not_found.
             CONTINUE.
         ENDTRY.

         ls_searchhelp_data = CORRESPONDING #( ls_searchhelp ).
         ls_searchhelp_data-multiplekey = ls_request_data-multiplekey.
         ls_searchhelp_data-requestkey = ls_request_data-requestkey.
         ls_searchhelp_data-dummykey = ls_searchhelp-%cid.

         "Insert to Mapped table
         INSERT VALUE #(
                %cid = ls_searchhelp-%cid
                multiplekey = ls_searchhelp_data-multiplekey
                requestkey = ls_searchhelp_data-requestkey
                dummykey = ls_searchhelp_data-dummykey
         ) INTO TABLE mapped-searchhelp.

         "Search Help Field
         LOOP AT lt_searchfield ASSIGNING FIELD-SYMBOL(<fs_searchfield>).
           <fs_searchfield>-multiplekey = ls_searchhelp_data-multiplekey.
           <fs_searchfield>-requestkey = ls_searchhelp_data-requestkey.
           <fs_searchfield>-dummykey = ls_searchhelp_data-dummykey.
         ENDLOOP.
         ls_searchhelp_data-to_searchhelpfield = CORRESPONDING #( lt_searchfield ).
         APPEND ls_searchhelp_data TO ls_request_data-to_searchhelp.
       ENDLOOP.

       APPEND ls_request_data TO ls_data-to_searchhelprequest.
     ENDLOOP.

     lcl_service_provider=>get_instance( )->set_multiple_search_help( it_multiplesearch = ls_data ).
   ENDMETHOD.

   METHOD read.
     IF it_multiplesearch IS NOT INITIAL.
       et_multiplesearch = CORRESPONDING #( lcl_service_provider=>get_instance( )->get_multiple_data( ) ).
     ELSEIF it_searchhelprequest IS NOT INITIAL.
       et_request = CORRESPONDING #( lcl_service_provider=>get_instance( )->get_request_data( ) ).
     ELSEIF it_searchhelp IS NOT INITIAL.
       et_searchhelp = CORRESPONDING #( it_searchhelp ).
     ELSEIF it_searchhelpfield IS NOT INITIAL.
       et_field = CORRESPONDING #( it_searchhelpfield ).
     ELSEIF field4_requested IS NOT INITIAL.
       et_result = CORRESPONDING #( lcl_service_provider=>get_instance( )->get_multiple_search_help( ) ).
     ENDIF.
   ENDMETHOD.
 ENDCLASS.

 CLASS lsc_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
   PROTECTED SECTION.
     METHODS check_before_save REDEFINITION.
     METHODS finalize          REDEFINITION.
     METHODS save              REDEFINITION.
 ENDCLASS.

 CLASS lsc_saver IMPLEMENTATION.

   METHOD check_before_save.
   ENDMETHOD.

   METHOD finalize.
   ENDMETHOD.

   METHOD save.
   ENDMETHOD.

 ENDCLASS.
