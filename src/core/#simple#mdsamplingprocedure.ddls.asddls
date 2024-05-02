@AbapCatalog.sqlViewName: '/SIMPLE/MDSP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDSAMPLINGPROCEDURE'
define view /SIMPLE/MDSAMPLINGPROCEDURE
  as select from    qdsv  as t1
    left outer join qdsvt as t2 on t1.stichprver = t2.stichprver
{
  key t1.stichprver as samplingProcedure,
  key t2.sprache    as locale,
      t2.kurztext   as description
}
