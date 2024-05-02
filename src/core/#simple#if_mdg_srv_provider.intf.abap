interface /SIMPLE/IF_MDG_SRV_PROVIDER
  public .


  class-methods CLEAN_UP .
  methods CREATE
    importing
      !IS_DATA type ANY optional
    exporting
      !ES_DATA type ANY
      !ET_MESSAGE type BAPIRET2_T
    changing
      value(EO_DEEP_ENTITY) type ref to DATA optional .
  methods CHANGE
    importing
      !IS_DATA type ANY optional
    exporting
      !ES_DATA type ANY
      !ET_MESSAGE type BAPIRET2_T
    changing
      value(EO_DEEP_ENTITY) type ref to DATA optional .
  methods DELETE
    importing
      !IS_DATA type ANY optional
    exporting
      !ES_DATA type ANY
      !ET_MESSAGE type BAPIRET2_T
    changing
      value(EO_DEEP_ENTITY) type ref to DATA optional .
  methods DO_MAPPING_CREATE
    importing
      !IS_DATA type ANY optional .
  methods DO_MAPPING_CHANGE
    importing
      !IS_DATA type ANY optional .
  methods DO_MAPPING_DELETE
    importing
      !IS_DATA type ANY optional .
  methods VALIDATE_CREATE
    importing
      !IS_DATA type ANY optional
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods VALIDATE_CHANGE
    importing
      !IS_DATA type ANY optional
    exporting
      !ET_MESSAGE type BAPIRET2_T .
  methods VALIDATE_DELETE
    importing
      !IS_DATA type ANY optional
    exporting
      !ET_MESSAGE type BAPIRET2_T .
endinterface.
