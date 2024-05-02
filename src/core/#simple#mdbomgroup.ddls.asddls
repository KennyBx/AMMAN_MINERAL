@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMGRO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - BoM Group'
define view /SIMPLE/MDBOMGROUP
  as select from stzu as STZU
{
  key stzu.exstl as bomGroup,
      stzu.ztext as description
}
where exstl is not initial
