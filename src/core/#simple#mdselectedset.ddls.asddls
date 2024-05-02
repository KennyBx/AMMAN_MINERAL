@AbapCatalog.sqlViewName: '/SIMPLE/MDSS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Selected Set Master Data'
define view /SIMPLE/MDSELECTEDSET
  as select from qpam
{
  key werks      as plant,
  key katalogart as catalogue,
  key auswahlmge as selectedSet,
  key ksp01      as locale,
      ktx01      as shortText
}
