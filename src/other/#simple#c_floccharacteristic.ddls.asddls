@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FlocCharacteristic'
define view /SIMPLE/C_FLOCCHARACTERISTIC
  as select from /SIMPLE/I_FLOCCHARACTERISTIC

  association to parent /SIMPLE/C_FLOCCLASSIFICATION as _Classification on  $projection.functionalLocation = _Classification.functionalLocation
                                                                        and $projection.class              = _Classification.class
                                                                        and $projection.classType          = _Classification.classType
{
  key FunctionalLocation              as functionalLocation,
  key Class                           as class,
  key ClassType                       as classType,
  key Charc                           as charc,
  key Counter                         as counter,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_HANDLE_EQUICHARACT'
      CharcValue                      as charcValue,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )   as action,
      cast( '' as abap.char( 1333 ) ) as mdgMarkForChange,

      _Classification
}
