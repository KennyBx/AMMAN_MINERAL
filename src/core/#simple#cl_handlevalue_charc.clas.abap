CLASS /simple/cl_handlevalue_charc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /simple/cl_handlevalue_charc IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      lt_calculated_data TYPE STANDARD TABLE OF /simple/mdarticlecharctvalue WITH DEFAULT KEY,
      numvalue_i         TYPE i,
      numvalue_p1        TYPE p LENGTH 16 DECIMALS 3,
      numvalue_p2        TYPE p LENGTH 16,
      numvalue_f         TYPE f,
      ls_output_data     TYPE /simple/c_prdcharacteristic.

    MOVE-CORRESPONDING it_original_data TO lt_calculated_data.
    SELECT t1~atinn,
           t1~atzhl,
           t1~adzhl,
           t1~atwrt,
           t1~atflv,
           t2~atnam,
           t2~msehi
      FROM cawn       AS t1
     INNER JOIN cabn  AS t2
        ON t1~atinn = t2~atinn
       AND t1~adzhl = t2~adzhl
      INTO TABLE @DATA(lt_charvalue)
      .

    LOOP AT lt_calculated_data ASSIGNING FIELD-SYMBOL(<ls_calculated_data>).
      TRY.
          DATA(ls_charc) = lt_charvalue[ atinn   = <ls_calculated_data>-internalcharacteristic
                                         atzhl   = <ls_calculated_data>-counter
                                         adzhl   = <ls_calculated_data>-counterarchivingobject
                                        ].
        CATCH cx_sy_itab_line_not_found.
          CLEAR ls_charc.
      ENDTRY.
      IF ls_charc IS NOT INITIAL AND ls_charc-atflv IS NOT INITIAL.

        numvalue_p1 = ls_charc-atflv.
        numvalue_p2 = ls_charc-atflv.
        numvalue_f = numvalue_p1 - numvalue_p2.
        IF numvalue_f IS INITIAL.
          <ls_calculated_data>-value = numvalue_p2.
          CONDENSE <ls_calculated_data>-value.
        ELSE.
          <ls_calculated_data>-value = numvalue_p1.
          CONDENSE <ls_calculated_data>-value.
        ENDIF.
      ELSE.
        <ls_calculated_data>-value = ls_charc-atwrt.
      ENDIF.
    ENDLOOP.



    MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
  ENDMETHOD.
  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
