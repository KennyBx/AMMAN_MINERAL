@AbapCatalog.sqlViewName: '/SIMPLE/MDACTTYP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Activity Type'
define view /SIMPLE/MDACTIVITYTYPE
  as select from    csla as c1
    left outer join cslt as c2 on  c1.kokrs = c2.kokrs
                               and c1.lstar = c2.lstar
                               and c1.datbi = c2.datbi
{
  key c1.lstar as activityType,
  key c1.kokrs as coArea,
  key c1.datbi as validTo,
  key c2.spras as locale,
      c1.datab as validFrom,
      c2.ltext as description
}
