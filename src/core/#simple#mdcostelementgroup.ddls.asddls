@AbapCatalog.sqlViewName: '/SIMPLE/MDCEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDCostElementGroup'
define view /SIMPLE/MDCOSTELEMENTGROUP
  as select from setheadert
{
  key subclass as orgUnit,
  key setname  as setName,
  key setclass as setClass,
  key langu    as language,
      descript as description
}
where setclass = '0102'
