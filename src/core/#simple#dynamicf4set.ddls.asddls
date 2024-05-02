@EndUserText.label: 'DynamicF4Set'
//@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_DYNAMICSET'
define root custom entity /SIMPLE/DynamicF4Set
{
      @EndUserText.label: 'Structure'
  key tableName  : char30;
      @EndUserText.label: 'Field'
  key fieldName  : char30;
      @EndUserText.label: 'Filter'
  key filter     : char255;
      @EndUserText.label: 'Language'
      language   : spras;
      @EndUserText.label: 'Top'
      top        : abap.int8;
      @EndUserText.label: 'Skip'
      skip       : abap.int8;
      _MDDYNAMIC : composition [0..*] of /SIMPLE/MDDYNAMICSET;
}
