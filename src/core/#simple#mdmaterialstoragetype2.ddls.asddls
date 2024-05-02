@AbapCatalog.sqlViewName: '/SIMPLE/MDMALGT2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Data for Each Storage Type2'
define view /SIMPLE/MDMATERIALSTORAGETYPE2 as select from /SIMPLE/MDMATERIALSTORAGETYPE {
    key Material as material,
    key WarehouseNumber as warehouseNumber,
    key StorageType as storageType
}
