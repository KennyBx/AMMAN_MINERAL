@AbapCatalog.sqlViewName: '/SIMPLE/MDMALGN2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material for Each Warehouse No.2'
define view /SIMPLE/MDMATLWAREHOUSENUMBER2 as select from /SIMPLE/MDMATLWAREHOUSENUMBER {
    key Material as material,
    key WarehouseNumber as warehouseNumber
}
