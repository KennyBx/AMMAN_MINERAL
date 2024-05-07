CLASS /simple/cl_getpricechangedoc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /simple/cl_getpricechangedoc IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      lt_valuation TYPE STANDARD TABLE OF /simple/c_productvaluation WITH DEFAULT KEY.
    MOVE-CORRESPONDING it_original_data TO lt_valuation.

    SELECT t1~belnr,
           t1~matnr,
           t1~bwtar,
           t1~bwkey,
           t1~budat,
           t1~cpudt,
           t1~cputm
      FROM /simple/mldoc AS t1
     INNER JOIN @lt_valuation AS t2
        ON t1~matnr = t2~product
       AND t1~bwtar = t2~valuationtype
       AND t1~bwkey = t2~valuationarea
      INTO TABLE @DATA(lt_pricechangedoc).

    SORT lt_pricechangedoc DESCENDING BY cpudt
                                         cputm.

    IF lt_pricechangedoc IS NOT INITIAL.
      LOOP AT lt_valuation ASSIGNING FIELD-SYMBOL(<fs_valuation>).
        READ TABLE lt_pricechangedoc INTO DATA(ls_pricechangedoc)
          WITH KEY matnr = <fs_valuation>-product
                   bwtar = <fs_valuation>-valuationtype
                   bwkey = <fs_valuation>-valuationarea.
        IF sy-subrc = 0.
          <fs_valuation>-postingdate         = ls_pricechangedoc-budat.
          <fs_valuation>-pricechangedocument = ls_pricechangedoc-belnr.
        ENDIF.
      ENDLOOP.
    ENDIF.
    MOVE-CORRESPONDING lt_valuation TO ct_calculated_data.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
