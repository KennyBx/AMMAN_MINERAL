@AbapCatalog.sqlViewName: '/SIMPLE/MDSC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Sampling Scheme'
define view /SIMPLE/MDSamplingScheme
  as select from    qdpk  as t1
    left outer join qdpkt as t2 on t1.stprplan = t2.stprplan
{
  key t1.stprplan as samplingScheme,
  key t2.sprache  as locale,
      t1.kzvwpksv as usedInProcedure,
      t2.kurztext as description
}
