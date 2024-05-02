@AbapCatalog.sqlViewName: '/SIMPLE/MDASSM'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Activity Type'
define view /SIMPLE/MDAssortment
  as select from    wrs1
    left outer join wrst on wrs1.asort = wrst.asort
{
  key wrs1.asort as assortment,
  key wrst.spras as locale,
      wrst.name1 as Description
}
