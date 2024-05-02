CLASS /simple/cl_classification DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS save
      IMPORTING
        iv_object         TYPE any
        iv_operation      TYPE char1
        it_classification TYPE /simple/clfn_t
      EXPORTING
        et_message        TYPE bapiret2_t.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /SIMPLE/CL_CLASSIFICATION IMPLEMENTATION.


  METHOD save.
    DATA:
      lv_object_type           TYPE tcla-obtab,
      lv_object                TYPE kssk-objek,
      lv_class_type            TYPE kssk-klart,
      lv_class                 TYPE klah-class,
      lt_return                TYPE TABLE OF bapiret2,
      lt_charact_values        TYPE STANDARD TABLE OF api_val_r,
      lt_object_identification TYPE STANDARD TABLE OF api_ob_key.

    LOOP AT it_classification INTO DATA(ls_classification).
      ls_classification-object = iv_object.
      IF iv_operation = 'I' AND ls_classification-action = ''.
        ls_classification-action = 'Insert'.
      ENDIF.

      " Check existence of allocation
      IF ls_classification-action = 'Change' OR ls_classification-action = 'Delete'.
        CALL FUNCTION 'BAPI_OBJCL_EXISTENCECHECK'
          EXPORTING
            classnum    = ls_classification-classnum
            classtype   = ls_classification-classtype
            objectkey   = ls_classification-object
            objecttable = ls_classification-objecttable
          TABLES
            return      = lt_return.
        READ TABLE lt_return WITH KEY type = 'S' TRANSPORTING NO FIELDS.
        IF sy-subrc = 0. " Allocation exists and is valid
          DATA(lv_exist) = abap_true.
        ELSE.
          APPEND VALUE #( type = 'E' id = 'CL' number = 732 message_v1 = |{ sy-datum DATE = USER }| )
          TO et_message.
        ENDIF.
        CLEAR: lt_return.
      ENDIF.

      CASE ls_classification-action.
        WHEN 'Insert'.
          CALL FUNCTION 'BAPI_OBJCL_CREATE'
            EXPORTING
              objectkeynew    = ls_classification-object
              objecttablenew  = ls_classification-objecttable
              classnumnew     = ls_classification-classnum
              classtypenew    = ls_classification-classtype
            TABLES
              allocvaluesnum  = ls_classification-allocvaluesnum
              allocvalueschar = ls_classification-allocvalueschar
              allocvaluescurr = ls_classification-allocvaluescurr
              return          = lt_return.

        WHEN 'Change'.
          IF lv_exist = abap_true.
            lv_object      = ls_classification-object.
            lv_object_type = ls_classification-objecttable.
            lv_class_type  = ls_classification-classtype.
            lv_class       = ls_classification-classnum.

            CALL FUNCTION 'CACL_OBJECT_READ_VALIDATION'
              EXPORTING
                object                = lv_object
                object_type           = lv_object_type
                class_type            = lv_class_type
                class                 = lv_class
              TABLES
                charact_values        = lt_charact_values
                object_identification = lt_object_identification
              EXCEPTIONS
                error                 = 1
                warning               = 2
                OTHERS                = 3.

            IF lt_charact_values IS NOT INITIAL.
              LOOP AT lt_charact_values INTO DATA(ls_charact) WHERE val_assign = 'X'.
                READ TABLE ls_classification-allocvalueschar TRANSPORTING NO FIELDS WITH KEY charact = ls_charact-charact.
                IF sy-subrc <> 0.
                  APPEND VALUE #( charact = ls_charact-charact value_char = ls_charact-value_neutral )
                  TO  ls_classification-allocvalueschar.
                ENDIF.
              ENDLOOP.
            ENDIF.

            CALL FUNCTION 'BAPI_OBJCL_CHANGE'
              EXPORTING
                objectkey          = ls_classification-object
                objecttable        = ls_classification-objecttable
                classnum           = ls_classification-classnum
                classtype          = ls_classification-classtype
              TABLES
                allocvaluesnumnew  = ls_classification-allocvaluesnum
                allocvaluescharnew = ls_classification-allocvalueschar
                allocvaluescurrnew = ls_classification-allocvaluescurr
                return             = lt_return.
          ENDIF.
        WHEN 'Delete'.
          IF lv_exist = abap_true.
            CALL FUNCTION 'BAPI_OBJCL_DELETE'
              EXPORTING
                objectkey   = ls_classification-object
                objecttable = ls_classification-objecttable
                classnum    = ls_classification-classnum
                classtype   = ls_classification-classtype
              TABLES
                return      = lt_return.
          ENDIF.
      ENDCASE.

      APPEND LINES OF lt_return TO et_message.
      CLEAR lt_return.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
