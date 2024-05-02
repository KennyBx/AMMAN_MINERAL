@AbapCatalog.sqlViewName: '/SIMPLE/MDPOAG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 -Purchase Outline Agreement'
define view /SIMPLE/MDPOAGREEMENT
  as select from ekko
{
  key ekko.ebeln as poAgreement

}
where
     ekko.bstyp = 'L'
  or ekko.bstyp = 'K'
