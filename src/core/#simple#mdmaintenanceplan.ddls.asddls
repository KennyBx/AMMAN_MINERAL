@AbapCatalog.sqlViewName: '/SIMPLE/MDMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Maintenance Plan'
define view /SIMPLE/MDMAINTENANCEPLAN
  as select from mpla
{
  key warpl as maintenancePlan,
      wptxt as description,
      strat as strategy
}
