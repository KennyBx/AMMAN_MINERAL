@AbapCatalog.sqlViewName: '/SIMPLE/MDDYMORU'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for DynModRule'
define view /SIMPLE/MDDYNMODRULE
  as select from    qddr  as q1
    left outer join qddrt as q2 on q1.dynregel = q2.dynregel
{
  key q1.dynregel as dynModRule,
  key q2.sprache  as locale,
      q2.kurztext as description
}
