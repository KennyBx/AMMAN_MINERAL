@AbapCatalog.sqlViewName: '/SIMPLE/MDQMCOS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SH for Quality Cost Collector2'
define view /SIMPLE/MDQUALITYCOSTC2 as select from /SIMPLE/MDQUALITYCOSTC {
    key OrderID as orderID,
    OrderType as orderType,
    ControllingArea as controllingArea,
    OrderDescription as orderDescription
}
