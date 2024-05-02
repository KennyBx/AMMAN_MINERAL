@AbapCatalog.sqlViewName: '/SIMPLE/MDREQORD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDRequestingOrder'
define view /SIMPLE/MDRequestingOrder
  as select from aufk
{
  key aufk.aufnr as orderID,
      aufk.auart as orderType,
      aufk.kokrs as controllingArea,
      aufk.abkrs as processGroup,
      aufk.ktext as orderDescription
}
