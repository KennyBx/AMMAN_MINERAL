@AbapCatalog.sqlViewName: '/SIMPLE/CHARACT2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Characteristic Configuration Table'
define view /SIMPLE/MDCHARACTERISTIC2
  as select from /SIMPLE/MDCHARACTERISTIC
{
  key InternalCharacteristic as internalCharacteristic,
  key InternalCounter        as internalCounter,
  key Characteristic         as characteristic,
  key InternalClassification as internalClassification,
  key Classification         as classification,
  key Locale                 as locale,
      Description            as description

}
