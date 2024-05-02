@AbapCatalog.sqlViewName: '/SIMPLE/MDMCS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Cost Split'
define view /SIMPLE/MDMATERIALCOSTSPLIT
  as select from makv
{
  key matnr  as material,
  key werks  as plant,
  key csplit as apportionment,
      sctyp  as structureType,
      scnam  as structureName,
      ktext  as description
}
