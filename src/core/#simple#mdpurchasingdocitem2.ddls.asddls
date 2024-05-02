@AbapCatalog.sqlViewName: '/SIMPLE/MDPUITE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Purchasing Document Item2'
define view /SIMPLE/MDPURCHASINGDOCITEM2 as select from /SIMPLE/MDPURCHASINGDOCITEM {
    key PurchasingDocument as purchasingDocument,
    Item as item
}
