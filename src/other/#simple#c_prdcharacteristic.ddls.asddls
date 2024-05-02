@AbapCatalog.sqlViewName: '/SIMPLE/CPRDCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductCharacteristic'
define view /SIMPLE/C_PrdCharacteristic
  as select distinct from /SIMPLE/I_PrdCharacteristic
  association to parent /SIMPLE/C_PrdClassification as _Classification on  _Classification.product   = $projection.product
                                                                       and _Classification.class     = $projection.class
                                                                       and _Classification.classType = $projection.classType
{
  key Product                        as product,
  key Class                          as class,
  key ClassType                      as classType,
  key Charc                          as charc,
  key Counter                        as counter,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_HANDLE_CHARACT'
      CharcValue                     as charcValue,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Classification
}
