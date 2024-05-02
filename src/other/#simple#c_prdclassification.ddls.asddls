@AbapCatalog.sqlViewName: '/SIMPLE/CPRDC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductClassification'
define view /SIMPLE/C_PrdClassification
  as select from /SIMPLE/I_PrdClassification 
  composition [0..*] of /SIMPLE/C_PrdCharacteristic as _Characteristic
  association to parent /SIMPLE/C_Product           as _Product on $projection.product = _Product.product
{
  key Product                        as product,
  key Class                          as class,
  key ClassType                      as classType,
      Status                         as status,         --Add field 2022-03-06
      StandardClass                  as standardClass,  --Add field 2022-03-06

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Characteristic,
      _Product
}
