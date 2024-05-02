@AbapCatalog.sqlViewName: '/SIMPLE/MDISSP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDINSPECTIONSEVERITYSP'
define view /SIMPLE/MDINSPECTIONSEVERITYSP
  as select distinct from qdpk as t1
    left outer join       qdpp as t2 on t1.stprplan = t2.stprplan
    left outer join       qdpa as t3 on  t2.stprplan = t3.stprplan
                                     and t2.zaehlpos = t3.zaehlpos
{
  key t1.stprplan   as samplingScheme,
  key t2.zaehlpos   as sequentialCounterItems,
      t3.prschaerfe as inspectionSeverity,
      t2.aqlwert    as aqlValue
}
