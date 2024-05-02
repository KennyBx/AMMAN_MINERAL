@AbapCatalog.sqlViewName: '/SIMPLE/MDBUPROC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Business Process'
define view /SIMPLE/MDBUSINESSPROCESS
  as select from    cbpr as c1
    left outer join cbpt as c2 on  c1.kokrs = c2.kokrs
                               and c1.prznr = c2.prznr
                               and c1.datbi = c2.datbi
{
  key c1.prznr as businessProc,
  key c1.kokrs as coArea,
  key c1.datbi as validTo,
  key c2.spras as locale,
      c2.ltext as description
}
