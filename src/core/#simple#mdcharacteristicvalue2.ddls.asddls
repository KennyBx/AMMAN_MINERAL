@AbapCatalog.sqlViewName: '/SIMPLE/MDCVAL2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Characteristic Values Search Help'
define view /SIMPLE/MDCHARACTERISTICVALUE2
  as select from /SIMPLE/MDCHARACTERISTICVALUE
{
  key InternalCharacteristic as internalCharacteristic,
  key Counter                as counter,
  key CounterArchivingObject as counterArchivingObject,
  key Characteristic         as characteristic,
  key Value                  as value,
  key Locale                 as locale,
      Description            as description
}
