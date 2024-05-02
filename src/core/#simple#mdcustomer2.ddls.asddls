@AbapCatalog.sqlViewName: '/SIMPLE/MDC2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Customer Master Data2'
define view /SIMPLE/MDCUSTOMER2 as select from /SIMPLE/MDCUSTOMER {
    key Customer as customer,
    CustomerName as customerName,
    BusinessPartner as businessPartner
}
