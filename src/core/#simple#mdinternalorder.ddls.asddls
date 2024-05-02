@AbapCatalog.sqlViewName: '/SIMPLE/MDIO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MD Internal Order'
define view /SIMPLE/MDINTERNALORDER
  as select from aufk
{
  key aufnr       as internalOrder,
      auart       as orderType,
      kokrs       as controllingArea,
      ktext       as description
}
