@AbapCatalog.sqlViewName: '/SIMPLE/MDCOSTE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Cost Element'
define view /SIMPLE/MDCOSTELEMENT
  as select from    cska as c1
    left outer join csku as c2 on  c1.ktopl = c2.ktopl
                               and c1.kstar = c2.kstar
{
  key c1.kstar as costElement,
  key c1.ktopl as chartOfAccount,
  key c2.spras as locale,
      c2.ltext as description
}
