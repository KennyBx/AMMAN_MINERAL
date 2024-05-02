@AbapCatalog.sqlViewName: '/SIMPLE/MDMALGNO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material for Each Warehouse No.'
define view /SIMPLE/MDMATLWAREHOUSENUMBER
  as select from mlgn as MLGN 
{
  key mlgn.matnr as material,
  key mlgn.lgnum as warehouseNumber
}
