@AbapCatalog.sqlViewName: '/SIMPLE/MDCULDP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4-Customer Master Unloading Point'
define view /SIMPLE/MDCUUNLOADINGPOINT
  as select from knva
{
  key kunnr   as customer,
  key ablad   as unloadingPoint
}
