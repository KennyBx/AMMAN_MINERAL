@AbapCatalog.sqlViewName: '/SIMPLE/MDPUDO2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Purchasing Document2'
define view /SIMPLE/MDPURCHASINGDOCUMENT2 as select from /SIMPLE/MDPURCHASINGDOCUMENT {
    key PurchasingDocument as purchasingDocument,
    PurchasingOrg as purchasingOrg,
    PurchasingGroup as purchasingGroup,
    DocumentDate as documentDate
}
