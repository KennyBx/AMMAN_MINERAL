@AbapCatalog.sqlViewName: '/SIMPLE/MDMALGTY'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Data for Each Storage Type'
define view /SIMPLE/MDMATERIALSTORAGETYPE
  as select from mlgt as MLGT 
{
  key mlgt.matnr as material,
  key mlgt.lgnum as warehouseNumber,
  key mlgt.lgtyp as storageType
}
