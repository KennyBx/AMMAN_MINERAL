@AbapCatalog.sqlViewName: '/SIMPLE/MDSTOBIN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Storage Bins'
define view /SIMPLE/MDSTORAGEBIN
  as select from lagp
{
  key lgtyp as storageType,
  key lgnum as warehouseNumber,
  key lgpla as storageBin,
      lptyp as storageBinType,
      kzler as isEmpty,
      lgber as storageSection,
      kober as pickingArea
}
