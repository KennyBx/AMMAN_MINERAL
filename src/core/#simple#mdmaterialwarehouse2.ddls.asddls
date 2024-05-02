@AbapCatalog.sqlViewName: '/SIMPLE/MDMLG2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Warehouse data2'
define view /SIMPLE/MDMATERIALWAREHOUSE2 as select from /SIMPLE/MDMATERIALWAREHOUSE {
    key Material as   material,
    key WarehouseNumber as   warehouseNumber
}
