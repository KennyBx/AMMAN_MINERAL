@AbapCatalog.sqlViewName: '/SIMPLE/MDCCG2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Group'
define view /SIMPLE/MDCOSTCENTERGROUP2
  as select from /SIMPLE/MDCOSTCENTERGROUP
{
  key COArea            as coArea,
  key StandardHierarchy as standardHierarchy,
  key CostCenterGroup   as costCenterGroup,
  key Locale            as locale,
      Description       as description
}
