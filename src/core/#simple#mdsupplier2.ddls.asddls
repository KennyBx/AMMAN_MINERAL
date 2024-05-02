@AbapCatalog.sqlViewName: '/SIMPLE/MDVD2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Supplier Master Data2'
define view /SIMPLE/MDSUPPLIER2 as select from /SIMPLE/MDSUPPLIER {
    key Supplier as supplier,
    SupplierName as supplierName,
    BusinessPartner as businessPartner
}
