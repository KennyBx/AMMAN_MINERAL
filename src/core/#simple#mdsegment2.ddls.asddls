@AbapCatalog.sqlViewName: '/SIMPLE/MDSEG2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Segments'
define view /SIMPLE/MDSEGMENT2
  as select from /SIMPLE/MDSEGMENT
{
  key Segment     as segment,
  key Locale      as locale,
      Description as description
}
