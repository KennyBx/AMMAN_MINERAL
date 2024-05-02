@AbapCatalog.sqlViewName: '/SIMPLE/MDCUOR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Customer Company & Sales Org data2'
define view /SIMPLE/MDCUSTOMERORGDATA2 as select from /SIMPLE/MDCUSTOMERORGDATA {
    key Customer as customer,
    key SalesOrganization as salesOrganization,
    key DistributionChannel as distributionChannel,
    key Division as division,
    CustomerName as customerName
}
