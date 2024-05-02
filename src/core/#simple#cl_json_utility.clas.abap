class /SIMPLE/CL_JSON_UTILITY definition
  public
  final
  create public .

  public section.

    constants CO_FTYPE_UPPERCASE type I value 1 ##NO_TEXT.
    constants CO_FTYPE_LOWERCASE type I value 2 ##NO_TEXT.
    constants CO_FTYPE_CAMELCASE type I value 3 ##NO_TEXT.
    constants CO_FTYPE_CAMELCASE_UPPER type I value 4 ##NO_TEXT.

    class-methods CONVERT_STUCT_TO_JSON
      importing
        !IM_S_DATA       type ANY
        !IM_V_CASE       type I default '4'
      returning
        value(RT_V_JSON) type STRING
      raising
        /SIMPLE/CX_JSON_CONVERSION_ERR .
    class-methods CONVERT_ITAB_TO_JSON
      importing
        !IM_T_TABLE      type standard table
        !IM_V_CASE       type I default '4'
      returning
        value(RT_V_JSON) type STRING
      raising
        /SIMPLE/CX_JSON_CONVERSION_ERR .
    class-methods CONVERT_FNAME_CASE
      importing
        !IM_V_FNAME       type STRING
        !IM_V_CASE        type STRING
      returning
        value(RT_V_FNAME) type STRING
      raising
        /SIMPLE/CX_JSON_CONVERSION_ERR .
  protected section.
  private section.
ENDCLASS.



CLASS /SIMPLE/CL_JSON_UTILITY IMPLEMENTATION.


  method CONVERT_FNAME_CASE.
    data:
      LV_STR type STRING.

    clear RT_V_FNAME.

    check IM_V_FNAME is not initial.

    case IM_V_CASE.

      when CO_FTYPE_LOWERCASE.
        RT_V_FNAME = TO_LOWER( IM_V_FNAME ).

      when CO_FTYPE_UPPERCASE.
        RT_V_FNAME = TO_UPPER( IM_V_FNAME ).

      when CO_FTYPE_CAMELCASE_UPPER.

        LV_STR     = TO_MIXED( IM_V_FNAME ).
        RT_V_FNAME = TO_UPPER( IM_V_FNAME(1) ) && LV_STR+1.

      when CO_FTYPE_CAMELCASE.
        LV_STR     = TO_MIXED( IM_V_FNAME ).
        RT_V_FNAME = TO_LOWER( IM_V_FNAME(1) ) && LV_STR+1.

    endcase.

    replace all occurrences of '"' in RT_V_FNAME with ''.
  endmethod.


  method CONVERT_ITAB_TO_JSON.
    data:
        LO_STRING_WRITER  type ref to CL_SXML_STRING_WRITER.

    data:
      LV_DATA       type XSTRING,
      LV_ARR_TEXTIN type STRING,
      LV_ARR_TEXTOT type STRING,
      LV_LEN        type I.

    try.

        "Create string writer for JSON
        LO_STRING_WRITER = CL_SXML_STRING_WRITER=>CREATE( TYPE = IF_SXML=>CO_XT_JSON ).

        "Call transformation
        call transformation ID source ARRAY = IM_T_TABLE result xml LO_STRING_WRITER.

        LV_DATA = LO_STRING_WRITER->GET_OUTPUT( ).

        free LO_STRING_WRITER.

        "Create string writer for JSON
        LO_STRING_WRITER = CL_SXML_STRING_WRITER=>CREATE( TYPE = IF_SXML=>CO_XT_JSON ).

        "Call transformation
        call transformation /SIMPLE/JSON_XML_TO_DIFF_CASE
                 parameters MODE = IM_V_CASE
                     source xml LV_DATA
                     result xml LO_STRING_WRITER.

        "Get JSON
        RT_V_JSON = CL_ABAP_CODEPAGE=>CONVERT_FROM( LO_STRING_WRITER->GET_OUTPUT( ) ).

        LV_ARR_TEXTIN = 'Array'.

        /SIMPLE/CL_JSON_UTILITY=>CONVERT_FNAME_CASE(
          exporting
            IM_V_FNAME = LV_ARR_TEXTIN
            IM_V_CASE  = |{ IM_V_CASE }|
          receiving
            RT_V_FNAME = LV_ARR_TEXTOT
        ).

        if RT_V_JSON cs LV_ARR_TEXTOT.

          LV_ARR_TEXTOT = `{"` && LV_ARR_TEXTOT && '":'.

          replace first occurrence of LV_ARR_TEXTOT in RT_V_JSON with ''.

          LV_LEN = STRLEN( RT_V_JSON ) - 1.

          if LV_LEN gt 0.
            RT_V_JSON = RT_V_JSON+0(LV_LEN).
          endif.

        endif.

      catch CX_ROOT.
*        RAISE EXCEPTION TYPE zcx_json_conversion_error.
    endtry.
  endmethod.


  method CONVERT_STUCT_TO_JSON.
    data:
        LO_STRING_WRITER  type ref to CL_SXML_STRING_WRITER.

    data:
      LV_DATA       type XSTRING,
      LV_ARR_TEXTIN type STRING,
      LV_ARR_TEXTOT type STRING,
      LV_LEN        type I.

    try.

        "Create string writer for JSON
        LO_STRING_WRITER = CL_SXML_STRING_WRITER=>CREATE( TYPE = IF_SXML=>CO_XT_JSON ).

        "Call transformation
        call transformation ID source STRUCTURE = IM_S_DATA result xml LO_STRING_WRITER.

        LV_DATA = LO_STRING_WRITER->GET_OUTPUT( ).

        free LO_STRING_WRITER.

        "Create string writer for JSON
        LO_STRING_WRITER = CL_SXML_STRING_WRITER=>CREATE( TYPE = IF_SXML=>CO_XT_JSON ).

        "Call transformation
        call transformation /SIMPLE/JSON_XML_TO_DIFF_CASE
                 parameters MODE = IM_V_CASE
                     source xml LV_DATA
                     result xml LO_STRING_WRITER.

        "Get JSON in string format
        RT_V_JSON = CL_ABAP_CODEPAGE=>CONVERT_FROM( LO_STRING_WRITER->GET_OUTPUT( ) ).

        LV_ARR_TEXTIN = 'structure'.

        /SIMPLE/CL_JSON_UTILITY=>CONVERT_FNAME_CASE(
          exporting
            IM_V_FNAME = LV_ARR_TEXTIN
            IM_V_CASE  = |{ IM_V_CASE }|
          receiving
            RT_V_FNAME = LV_ARR_TEXTOT
        ).

        if RT_V_JSON cs LV_ARR_TEXTOT.

          LV_ARR_TEXTOT = `{"` && LV_ARR_TEXTOT && '":'.

          replace first occurrence of LV_ARR_TEXTOT in RT_V_JSON with ''.

          LV_LEN = STRLEN( RT_V_JSON ) - 1.

          if LV_LEN gt 0.
            RT_V_JSON = RT_V_JSON+0(LV_LEN).
          endif.

        endif.
      catch CX_ROOT.
*      RAISE EXCEPTION TYPE zcx_json_conversion_error.
    endtry.
  endmethod.
ENDCLASS.
