@AbapCatalog.sqlViewName: '/SIMPLE/MDSTUNUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - STORAGE UNIT NUMBER'
define view /SIMPLE/MDSTORAGEUNITNUMBER
  as select from lein
{
  key cast( lenum as abap.char( 20 ) ) as storageUnit,
      lgnum as warehouseNumber,
      letyp as storageUnitType,
      lgtyp as storageType,
      lgpla as storageBin
}
