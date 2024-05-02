@AbapCatalog.sqlViewName: '/SIMPLE/MDPOAGI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 -Purchase Outline Agreement Item'
define view /SIMPLE/MDPOAGREEMENTITEM
  as select from ekpo
    inner join   ekko on ekpo.ebeln = ekko.ebeln
{
  key ekpo.ebeln as poAgreement,
  key ekpo.ebelp as poItem

}
where
     ekpo.bstyp = 'L'
  or ekpo.bstyp = 'K'
