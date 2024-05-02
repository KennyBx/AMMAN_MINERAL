@AbapCatalog.sqlViewName: '/SIMPLE/MDBPSTLP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - BP:Status of Legal Proceeding'
define view /SIMPLE/MDBPSTATUSLEGALPROCEED
  as select from fsbpcc_lgl_proc as SLP 
  left outer join fsbpcc_lgl_proct as SLPT on SLP.lgl_proc = SLPT.lgl_proc 
{
  key SLP.lgl_proc      as statusLegalProceeding,
  key SLPT.langu        as locale,
      SLPT.lgl_proc_t   as description
}
