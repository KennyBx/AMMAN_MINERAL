@AbapCatalog.sqlViewName: '/SIMPLE/IAHNPPGR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Node PricePoint Group'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHNODEPPGR
  as select from wrf_wppgrhier
{
  key hier_id,
  key node,
  key date_from,
  key eptyp,
  key rktyp,
      eprgr
}
