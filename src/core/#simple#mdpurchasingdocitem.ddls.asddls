@AbapCatalog.sqlViewName: '/SIMPLE/MDPUITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Purchasing Document Item'
define view /SIMPLE/MDPURCHASINGDOCITEM 
  as select from ekpo {
    key ebeln as purchasingDocument,
    key ebelp as item
}
