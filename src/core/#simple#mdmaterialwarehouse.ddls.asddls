@AbapCatalog.sqlViewName: '/SIMPLE/MDMLGN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Warehouse data'
define view /SIMPLE/MDMATERIALWAREHOUSE
  as select from mlgn
{
  key matnr as   material,
  key lgnum as   warehouseNumber

}
