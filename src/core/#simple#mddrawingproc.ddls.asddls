@AbapCatalog.sqlViewName: '/SIMPLE/MDDRAWPR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Business Process'
define view /SIMPLE/MDDRAWINGPROC
  as select from    qprvk  as q1
    left outer join qprvkt as q2 on  q1.prziehverf = q2.prziehverf
                                 and q1.version    = q2.version
{
  key q1.prziehverf as drawingProc,
  key q1.version    as version,
  key q2.sprache    as locale,
      q2.kurztext   as description
}
