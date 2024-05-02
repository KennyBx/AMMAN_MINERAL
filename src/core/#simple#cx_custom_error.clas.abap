class /SIMPLE/CX_CUSTOM_ERROR definition
  public
  inheriting from /SIMPLE/CX_CMD_QRY_ERROR
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  data IT_RETURN type BAPIRET2_T .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !IT_RETURN type BAPIRET2_T optional .
protected section.
private section.
ENDCLASS.



CLASS /SIMPLE/CX_CUSTOM_ERROR IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->IT_RETURN = IT_RETURN .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
