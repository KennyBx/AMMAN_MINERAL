@AbapCatalog.sqlViewName: '/SIMPLE/MDQMCOST'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SH for Quality Cost Collector'
define view /SIMPLE/MDQUALITYCOSTC
  as select from aufk
{
  key aufk.aufnr as orderID,
      aufk.auart as orderType,
      aufk.kokrs as controllingArea,
      aufk.ktext as orderDescription
}
