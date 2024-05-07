CLASS /simple/cl_handle_charact DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /SIMPLE/CL_HANDLE_CHARACT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      lt_calculated_data TYPE STANDARD TABLE OF /simple/c_prdcharacteristic WITH DEFAULT KEY,
      numvalue_i         TYPE i,
      numvalue_p1        TYPE p LENGTH 16 DECIMALS 3,
      numvalue_p2        TYPE p LENGTH 16,
      numvalue_f         TYPE f,
      ls_output_data     TYPE /simple/c_prdcharacteristic.

    MOVE-CORRESPONDING it_original_data TO lt_calculated_data.
    IF lt_calculated_data IS NOT INITIAL.
      SELECT DISTINCT
             kssk~objek                  AS product,
             klah~class                  AS class,
             kssk~klart                  AS classtype,
             ksml~imerk                  AS characteristc,
             cabn~atnam                  AS charc,
             ausp~atzhl                  AS counter,
             ksml~posnr                  AS charcitem,
             ausp~atwrt                  AS charcvalue,
             ausp~atflv                  AS numvalue
        FROM kssk
       INNER JOIN klah
          ON kssk~clint = klah~clint
         AND kssk~klart = klah~klart
        LEFT JOIN ksml
          ON klah~clint = ksml~clint
        LEFT JOIN ausp
          ON kssk~objek = ausp~objek
         AND kssk~mafid = ausp~mafid
         AND kssk~klart = ausp~klart
         AND ksml~imerk = ausp~atinn
        LEFT JOIN cabn
          ON ksml~imerk = cabn~atinn
       INNER JOIN @lt_calculated_data AS ltab
          ON kssk~objek = ltab~product
         AND klah~class = ltab~class
         AND cabn~atnam = ltab~charc
        INTO TABLE @DATA(lt_characteristic).

      SELECT DISTINCT
             inob~objek                  AS product,
             klah~class                  AS class,
             kssk~klart                  AS classtype,
             ksml~imerk                  AS characteristc,
             cabn~atnam                  AS charc,
             ausp~atzhl                  AS counter,
             ksml~posnr                  AS charcitem,
             ausp~atwrt                  AS charcvalue,
             ausp~atflv                  AS numvalue
        FROM kssk
       INNER JOIN ngc_clhier_idx
          ON kssk~clint = ngc_clhier_idx~node
       INNER JOIN klah
          ON ngc_clhier_idx~ancestor = klah~clint
         AND ngc_clhier_idx~klart    = klah~klart
       INNER JOIN inob
          ON kssk~objek = inob~cuobj
       INNER JOIN ksml
          ON klah~clint = ksml~clint
       INNER JOIN ausp
          ON inob~cuobj = ausp~objek
         AND kssk~mafid = ausp~mafid
         AND kssk~klart = ausp~klart
         AND ksml~imerk = ausp~atinn
        LEFT JOIN cabn
          ON ksml~imerk = cabn~atinn
       INNER JOIN @lt_calculated_data AS ltab
          ON inob~objek = ltab~product
         AND klah~class = ltab~class
         AND cabn~atnam = ltab~charc
       WHERE inob~obtab = 'MARA'
   APPENDING TABLE @lt_characteristic.
    ENDIF.

    LOOP AT lt_calculated_data ASSIGNING FIELD-SYMBOL(<ls_calculated_data>).
      TRY.
          DATA(ls_charc) = lt_characteristic[ product = <ls_calculated_data>-product
                                              class   = <ls_calculated_data>-class
                                              charc   = <ls_calculated_data>-charc ].
        CATCH cx_sy_itab_line_not_found.
          CLEAR ls_charc.
      ENDTRY.
      IF ls_charc IS NOT INITIAL AND ls_charc-numvalue IS NOT INITIAL.

        numvalue_p1 = ls_charc-numvalue.
        numvalue_p2 = ls_charc-numvalue.
        numvalue_f = numvalue_p1 - numvalue_p2.
        IF numvalue_f IS INITIAL.
          <ls_calculated_data>-charcvalue = numvalue_p2.
          CONDENSE <ls_calculated_data>-charcvalue.
        ELSE.
          <ls_calculated_data>-charcvalue = numvalue_p1.
          CONDENSE <ls_calculated_data>-charcvalue.
        ENDIF.
      ELSE.
        <ls_calculated_data>-charcValue = ls_charc-charcvalue.
      ENDIF.
    ENDLOOP.
    MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
