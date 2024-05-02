@AbapCatalog.sqlViewName: '/SIMPLE/MDMARD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Storage Location data'
define view /SIMPLE/MDMATERIALSTOLOC
  as select from mard
{
  key    matnr as material,
  key    werks as plant,
  key    lgort as storageLocation
}
