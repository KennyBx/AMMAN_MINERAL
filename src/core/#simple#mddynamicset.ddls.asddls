@EndUserText.label: '/SIMPLE/MDDYNAMICSET'
//@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_DYNAMICSET'
define custom entity /SIMPLE/MDDYNAMICSET
{
      @EndUserText.label: 'Structure'
  key tableName     : char30;
      @EndUserText.label: 'Field'
  key fieldName     : char30;
      @EndUserText.label: 'Filter'
  key filter        : char255;
      @EndUserText.label: 'Value'
  key value         : char255;
      @EndUserText.label: 'Language'
  key language      : spras;
      @EndUserText.label: 'Description'
      description   : char255;
      _DynamicF4Set : association to parent /SIMPLE/DynamicF4Set on  _DynamicF4Set.tableName = $projection.tableName
                                                                 and _DynamicF4Set.fieldName = $projection.fieldName
//                                                                 and _DynamicF4Set.language  = $projection.language
                                                                 and _DynamicF4Set.filter    = $projection.filter


  ;
}
