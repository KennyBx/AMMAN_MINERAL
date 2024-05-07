CLASS /simple/cl_prdwarehouse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /SIMPLE/CL_PRDWAREHOUSE IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      lv_matnr     TYPE marm-matnr,
      lt_meinh     TYPE STANDARD TABLE OF smeinh,
      lv_lhme1_in  TYPE mlgn-lhme1,
      lv_lhme2_in  TYPE mlgn-lhme2,
      lv_lhme3_in  TYPE mlgn-lhme3,
      lv_lhmg1     TYPE mlgn-lhmg1,
      lv_lhmg2     TYPE mlgn-lhmg1,
      lv_lhmg3     TYPE mlgn-lhmg1,
      lv_lhmg1_out TYPE mlgn-lhmg1,
      lv_lhmg2_out TYPE mlgn-lhmg1,
      lv_lhmg3_out TYPE mlgn-lhmg1.

    " Product number
    ASSIGN it_original_data[ 1 ] TO FIELD-SYMBOL(<fs_orig_data>).
    IF <fs_orig_data> IS NOT ASSIGNED.
      RETURN.
    ENDIF.

    ASSIGN COMPONENT 'PRODUCT' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_product>).
    IF <fs_product> IS NOT ASSIGNED.
      RETURN.
    ENDIF.

    lv_matnr = <fs_product>.

    "Get base UoM
    SELECT SINGLE meins FROM mara INTO @DATA(lv_meins) WHERE matnr = @lv_matnr.

    CALL FUNCTION 'MARM_GENERIC_READ_WITH_MATNR'
      EXPORTING
        matnr  = lv_matnr
      TABLES
*       MARM_TAB   =
        meinh  = lt_meinh
      EXCEPTIONS
        OTHERS = 1.

    " Calculate data
    LOOP AT ct_calculated_data ASSIGNING FIELD-SYMBOL(<fs_calc_data>).
      ASSIGN it_original_data[ sy-tabix ] TO <fs_orig_data>.

      ASSIGN COMPONENT 'LOADINGUNIT1' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldunit1>).
      ASSIGN COMPONENT 'LOADINGUNIT2' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldunit2>).
      ASSIGN COMPONENT 'LOADINGUNIT3' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldunit3>).

      ASSIGN COMPONENT 'LOADINGQUANTITY1_RAW' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldqty_raw_1>).
      ASSIGN COMPONENT 'LOADINGQUANTITY2_RAW' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldqty_raw_2>).
      ASSIGN COMPONENT 'LOADINGQUANTITY3_RAW' OF STRUCTURE <fs_orig_data> TO FIELD-SYMBOL(<fs_ldqty_raw_3>).

      ASSIGN COMPONENT 'LOADINGQUANTITY1' OF STRUCTURE <fs_calc_data> TO FIELD-SYMBOL(<fs_ldqty_1>).
      ASSIGN COMPONENT 'LOADINGQUANTITY2' OF STRUCTURE <fs_calc_data> TO FIELD-SYMBOL(<fs_ldqty_2>).
      ASSIGN COMPONENT 'LOADINGQUANTITY3' OF STRUCTURE <fs_calc_data> TO FIELD-SYMBOL(<fs_ldqty_3>).

      TRY.
          lv_lhme1_in = <fs_ldunit1>    .
          lv_lhme2_in = <fs_ldunit2>    .
          lv_lhme3_in = <fs_ldunit3>    .

          lv_lhmg1    = <fs_ldqty_raw_1>.
          lv_lhmg2    = <fs_ldqty_raw_2>.
          lv_lhmg3    = <fs_ldqty_raw_3>.

          CALL FUNCTION 'LADEHILFSMENGE_PBO'
            EXPORTING
              p_mara_meins = lv_meins
              p_mlgn_lhme1 = lv_lhme1_in
              p_mlgn_lhme2 = lv_lhme2_in
              p_mlgn_lhme3 = lv_lhme3_in
              p_mlgn_lhmg1 = lv_lhmg1
              p_mlgn_lhmg2 = lv_lhmg2
              p_mlgn_lhmg3 = lv_lhmg3
            IMPORTING
              p_mlgn_lhmg1 = lv_lhmg1_out
              p_mlgn_lhmg2 = lv_lhmg2_out
              p_mlgn_lhmg3 = lv_lhmg3_out
            TABLES
              meinh        = lt_meinh.

          <fs_ldqty_1> = lv_lhmg1_out.
          <fs_ldqty_2> = lv_lhmg2_out.
          <fs_ldqty_3> = lv_lhmg3_out.
        CATCH cx_root.

      ENDTRY..
    ENDLOOP.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    et_requested_orig_elements = VALUE #( ( CONV string( 'LOADINGQUANTITY1_RAW' ) )
                                          ( CONV string( 'LOADINGQUANTITY2_RAW' ) )
                                          ( CONV string( 'LOADINGQUANTITY3_RAW' ) ) ) .
  ENDMETHOD.
ENDCLASS.
