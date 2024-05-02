@AbapCatalog.sqlViewName: '/SIMPLE/MDMARC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Plant data'
define view /SIMPLE/MDMATERIALPLANT
  as select from marc as t1
{
  key   t1.matnr as   material,
  key   t1.werks as   plant
}
