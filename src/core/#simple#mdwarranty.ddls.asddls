@AbapCatalog.sqlViewName: '/SIMPLE/MDWA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Warranty'
define view /SIMPLE/MDWARRANTY
  as select from bgmk
{
  key mganr as warrantyNumber,
      datab as validFrom,
      datbi as validTo,
      lvorm as deleted
}
