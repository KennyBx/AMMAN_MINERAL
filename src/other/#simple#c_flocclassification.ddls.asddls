@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FlocClassification'
define view /SIMPLE/C_FLOCCLASSIFICATION
  as select from /SIMPLE/I_FLOCCLASSIFICATION as _Classification
  association to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation on $projection.functionalLocation = _FunctionalLocation.functionalLocation

  composition [0..*] of /SIMPLE/C_FLOCCHARACTERISTIC as _FlocCharacteristic
  //  on  $projection.functionalLocation = _FlocCharacteristic.functionalLocation
  //                                                                            and $projection.class              = _FlocCharacteristic.class
  //                                                                            and $projection.classType          = _FlocCharacteristic.classType
{
  key FunctionalLocation               as functionalLocation,
  key Class                            as class,
  key ClassType                        as classType,
      Status                           as status, --Add field 2022-03-06
      cast( StandardClass as boolean ) as standardClass, --Add field 2022-03-06

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )    as action,
      cast( '' as abap.char( 1333 ) )  as mdgMarkForChange,

      /* Associations */
      _FlocCharacteristic,
      _FunctionalLocation
}
