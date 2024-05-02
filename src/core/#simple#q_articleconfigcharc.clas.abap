CLASS /simple/q_articleconfigcharc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF gty_charvalue,
        charct TYPE cabn-atnam,
        value  TYPE cawn-atwrt,
      END   OF gty_charvalue.
    TYPES:
      gty_t_charvalue TYPE STANDARD TABLE OF gty_charvalue WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_combine,
        charct_1 TYPE cabn-atnam,
        value_1  TYPE cawn-atwrt,
        charct_2 TYPE cabn-atnam,
        value_2  TYPE cawn-atwrt,
      END   OF gty_combine.
    TYPES:
      gty_t_combine TYPE STANDARD TABLE OF gty_combine WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_combine1,
        charct_1 TYPE cabn-atnam,
        value_1  TYPE cawn-atwrt,
        charct_2 TYPE cabn-atnam,
        value_2  TYPE cawn-atwrt,
        charct_3 TYPE cabn-atnam,
        value_3  TYPE cawn-atwrt,
      END   OF gty_combine1.
    TYPES:
      gty_t_combine1 TYPE STANDARD TABLE OF gty_combine1 WITH DEFAULT KEY.
ENDCLASS.



CLASS /simple/q_articleconfigcharc IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    FIELD-SYMBOLS:
      <ft_charvalue> TYPE gty_t_charvalue.
    DATA:
      lt_data         TYPE STANDARD TABLE OF /simple/mdarticleconfigcharc,
*      lt_charvalue1
      lr_class        TYPE RANGE OF klah-class,
      lr_classtype    TYPE RANGE OF klah-klart,
      lr_material     TYPE RANGE OF matnr,
      lt_charvalue1   TYPE gty_t_charvalue,
      lt_charvalue2   TYPE gty_t_charvalue,
      lt_charvalue3   TYPE gty_t_charvalue,
      lt_combine      TYPE gty_t_combine,
      lt_combine1     TYPE gty_t_combine1,
      lt_combinefn    TYPE gty_t_combine1,
      lt_charassigned TYPE gty_t_combine1,
      lv_numvalue_i   TYPE i,
      lv_numvalue_p1  TYPE p LENGTH 16 DECIMALS 3,
      lv_numvalue_p2  TYPE p LENGTH 16,
      lv_numvalue_f   TYPE f,
      lv_tablename    TYPE c LENGTH 13,
      lv_charcname    TYPE c LENGTH 8,
      lv_charcvalue   TYPE c LENGTH 7.

    DATA(lv_entity_id) = io_request->get_entity_id( ).
    DATA(lo_filter) = io_request->get_filter( ).
    DATA(lo_paging) = io_request->get_paging( ).
    "Handle paging
    DATA(lv_offset) = lo_paging->get_offset( ).
    DATA(lv_page_size) = lo_paging->get_page_size( ).
    DATA(lt_sorting) = io_request->get_sort_elements( ).

    TRY.
        DATA(lt_ranges) = lo_filter->get_as_ranges( ).
        READ TABLE lt_ranges INTO DATA(ls_filter) WITH KEY name = 'CLASS'.
        IF sy-subrc = 0.
          lr_class = CORRESPONDING #( ls_filter-range ).
        ELSE.
          EXIT.
        ENDIF.

        READ TABLE lt_ranges INTO ls_filter WITH KEY name = 'CLASSTYPE'.
        IF sy-subrc = 0.
          lr_classtype = CORRESPONDING #( ls_filter-range ).
        ELSE.
          EXIT.
        ENDIF.

        READ TABLE lt_ranges INTO ls_filter WITH KEY name = 'VARIANTNUMBER'.
        IF sy-subrc = 0.
          lr_material = CORRESPONDING #( ls_filter-range ).
        ENDIF.



        "Get characteristic name
        SELECT t1~class,
               t1~klart,
               t3~atinn,
               t3~atnam,
               t3~atfor
          FROM klah AS t1
         INNER JOIN ksml AS t2
            ON t1~clint = t2~clint
         INNER JOIN cabn AS t3
            ON t2~imerk = t3~atinn
         WHERE t1~class IN @lr_class
           AND t1~klart IN @lr_classtype
          INTO TABLE @DATA(lt_charc).

        "Get value predefined of characteristic
        SELECT t1~atnam,
               t1~atfor,
               t2~atwrt,
               t2~atflv
          FROM @lt_charc AS t1
         INNER JOIN cawn AS t2
            ON t1~atinn = t2~atinn
          INTO TABLE @DATA(lt_charcvalue).

        IF lr_material IS NOT INITIAL.
          SELECT matnr AS article,
                 matnr AS variant
            FROM mara
           WHERE satnr = ''
           UNION ALL
          SELECT matnr AS article,
                 matnr AS variant
            FROM mara
           WHERE satnr <> ''
           UNION ALL
          SELECT satnr AS article,
                 matnr AS variant
            FROM mara
           WHERE satnr <> ''
            INTO TABLE @DATA(lt_articlevariant) .

          "Characteristic
          SELECT t1~article,
                 t1~variant,
                 t9~class,
                 t8~klart AS classType,
                 t6~atnam AS charc,
                 t5~atwrt AS charcValue,
                 t5~atflv AS valueFrom,
                 t5~atflb AS valueTo
            FROM @lt_articlevariant AS t1
           INNER JOIN   ibinown    AS t2
              ON t1~variant = t2~objkey
           INNER JOIN   ibin       AS t3
              ON t2~instance = t3~instance
           INNER JOIN   ibinvalues AS t4
              ON t3~in_recno = t4~in_recno
           INNER JOIN   ibsymbol AS t5
              ON t4~symbol_id = t5~symbol_id
           INNER JOIN   cabn AS t6
              ON t5~atinn = t6~atinn
           INNER JOIN   inob AS t7
              ON t2~objkey = t7~objek
           INNER JOIN   kssk AS t8
              ON t7~cuobj     = t8~objek
           INNER JOIN   klah AS t9
              ON t8~clint     = t9~clint
           WHERE t9~class IN @lr_class
             AND t8~klart IN @lr_classtype
             AND t1~article IN @lr_material
            INTO TABLE @DATA(lt_variantcharac).



*          SELECT *
*            FROM /simple/c_variantcharac
*           WHERE article   IN @lr_material
**             AND class     IN @lr_class
**             AND classtype IN @lr_classtype
*            INTO TABLE @DATA(lt_variantcharac).
          IF lt_variantcharac IS NOT INITIAL.
            LOOP AT lt_variantcharac ASSIGNING FIELD-SYMBOL(<fs_variantcharac>).
              READ TABLE lt_charc INTO DATA(ls_charc)
                WITH KEY atnam = <fs_variantcharac>-charc.
              IF sy-subrc <> 0.
                CONTINUE.
              ENDIF.
              IF ls_charc-atfor = 'NUM'.
                lv_numvalue_p1 = <fs_variantcharac>-valuefrom.
                lv_numvalue_p2 = <fs_variantcharac>-valuefrom.
                lv_numvalue_f = lv_numvalue_p1 - lv_numvalue_p2.
                IF lv_numvalue_f IS INITIAL.
                  <fs_variantcharac>-charcvalue = lv_numvalue_p2.
                  CONDENSE <fs_variantcharac>-charcvalue.
                ELSE.
                  <fs_variantcharac>-charcvalue = lv_numvalue_p1.
                  CONDENSE <fs_variantcharac>-charcvalue.
                ENDIF.
              ENDIF.
            ENDLOOP.

            LOOP AT lt_variantcharac INTO DATA(ls_variantcharac)
              GROUP BY ( variant = ls_variantcharac-variant )
               INTO DATA(wa_group).
              DATA(lv_index) = 0.
              APPEND INITIAL LINE TO lt_charassigned ASSIGNING FIELD-SYMBOL(<fs_charassigned>).
              LOOP AT GROUP wa_group INTO ls_variantcharac.
                lv_index = lv_index + 1.
                lv_charcname  = 'CHARCT_' && lv_index.
                lv_charcvalue = 'VALUE_'  && lv_index.
                ASSIGN COMPONENT lv_charcname OF STRUCTURE <fs_charassigned>
                    TO FIELD-SYMBOL(<fs_value>).
                IF sy-subrc = 0.
                  <fs_value> = ls_variantcharac-charc.
                ENDIF.
                ASSIGN COMPONENT lv_charcvalue OF STRUCTURE <fs_charassigned>
                    TO <fs_value>.
                IF sy-subrc = 0.
                  <fs_value> = ls_variantcharac-charcvalue.
                ENDIF.
              ENDLOOP.

            ENDLOOP.
          ENDIF.
        ENDIF.

        DATA(lv_count) = lines( lt_charc ).

        lv_index = 0.
        DO lv_count TIMES.
          lv_tablename = 'LT_CHARVALUE'.
          lv_index = lv_index + 1.
          lv_tablename = lv_tablename && lv_index.
          TRY.
              ASSIGN (lv_tablename) TO <ft_charvalue>.
              IF sy-subrc <> 0.
                CONTINUE.
              ENDIF.
              DATA(lv_charc) = lt_charc[ lv_index ].
              LOOP AT lt_charcvalue INTO DATA(ls_charcvalue)
                WHERE atnam = lv_charc-atnam.
                IF ls_charcvalue-atfor = 'NUM'.
                  lv_numvalue_p1 = ls_charcvalue-atflv.
                  lv_numvalue_p2 = ls_charcvalue-atflv.
                  lv_numvalue_f = lv_numvalue_p1 - lv_numvalue_p2.
                  IF lv_numvalue_f IS INITIAL.
                    ls_charcvalue-atwrt = lv_numvalue_p2.
                    CONDENSE ls_charcvalue-atwrt.
                  ELSE.
                    ls_charcvalue-atwrt = lv_numvalue_p1.
                    CONDENSE ls_charcvalue-atwrt.
                  ENDIF.
                ENDIF.
                APPEND INITIAL LINE TO <ft_charvalue> ASSIGNING FIELD-SYMBOL(<fs>).
                <fs>-charct = ls_charcvalue-atnam.
                <fs>-value  = ls_charcvalue-atwrt.
              ENDLOOP.
              UNASSIGN <ft_charvalue>.

            CATCH cx_sy_itab_line_not_found.
          ENDTRY.

        ENDDO.

        IF lt_charvalue2 IS NOT INITIAL.
          lt_combine = VALUE #( BASE lt_combine
                                  FOR ls_charvalue1 IN lt_charvalue1
                                  FOR ls_charvalue2 IN lt_charvalue2
                                  ( charct_1 = ls_charvalue1-charct
                                    value_1  = ls_charvalue1-value
                                    charct_2 = ls_charvalue2-charct
                                    value_2  = ls_charvalue2-value ) ).
          lt_combinefn = CORRESPONDING #( lt_combine ).
        ENDIF.
        IF lt_charvalue3 IS NOT INITIAL.
          lt_combine1 = VALUE #( BASE lt_combine1
                                FOR ls_combine    IN lt_combine
                                FOR ls_charvalue3 IN lt_charvalue3
                                ( charct_1 = ls_combine-charct_1
                                  value_1  = ls_combine-value_1
                                  charct_2 = ls_combine-charct_2
                                  value_2  = ls_combine-value_2
                                  charct_3 = ls_charvalue3-charct
                                  value_3  = ls_charvalue3-value )  ).
          CLEAR lt_combinefn.
          lt_combinefn = CORRESPONDING #( lt_combine1 ).
        ENDIF.

        READ TABLE lt_charc INTO ls_charc INDEX 1.
        IF sy-subrc <> 0.

        ENDIF.
        IF lt_combinefn IS NOT INITIAL.
          lv_index = 1.
          LOOP AT lt_combinefn INTO DATA(ls_combinefn).
            IF NOT line_exists( lt_charassigned[
                                  charct_1 = ls_combinefn-charct_1
                                  value_1  = ls_combinefn-value_1
                                  charct_2 = ls_combinefn-charct_2
                                  value_2  = ls_combinefn-value_2
                                  charct_3 = ls_combinefn-charct_3
                                  value_3  = ls_combinefn-value_3 ] ).


              lt_data = VALUE #( BASE lt_data
                   ( variantid        = lv_index
                     class            = ls_charc-class
                     classtype        = ls_charc-klart
                     characteristic_1 = ls_combinefn-charct_1
                     value_1          = ls_combinefn-value_1
                     characteristic_2 = ls_combinefn-charct_2
                     value_2          = ls_combinefn-value_2
                     characteristic_3 = ls_combinefn-charct_3
                     value_3          = ls_combinefn-value_3 ) ).

              lv_index = lv_index + 1.
            ENDIF.
          ENDLOOP.

        ENDIF.

        IF lv_page_size > 0 AND lv_offset >= 0 .

          SELECT *
          FROM @lt_data AS data

          ORDER BY variantnumber, variantid
          INTO TABLE @DATA(lt_result)
          UP TO @lv_page_size ROWS OFFSET @lv_offset.

        ELSE.
          SELECT *
          FROM @lt_data AS data
          ORDER BY variantnumber, variantid
          INTO TABLE @lt_result.
        ENDIF.
        .
        io_response->set_data( it_data = lt_result ).
        io_response->set_total_number_of_records( iv_total_number_of_records = lines( lt_result ) ).



      CATCH cx_static_check INTO DATA(lx_exception).
    ENDTRY.

  ENDMETHOD.

  METHOD if_rap_query_provider~get_sort_elements.

  ENDMETHOD.
ENDCLASS.
