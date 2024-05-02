@AbapCatalog.sqlViewName: '/SIMPLE/MDCUORG'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Customer Company & Sales Org data'
define view /SIMPLE/MDCUSTOMERORGDATA
  as select from A_Customer as CU
  association [0..*] to A_CustomerSalesArea as _CustomerSalesArea on $projection.customer = _CustomerSalesArea.Customer
{
  key     CU.Customer                            as customer,
  key     _CustomerSalesArea.SalesOrganization   as salesOrganization,
  key     _CustomerSalesArea.DistributionChannel as distributionChannel,
  key     _CustomerSalesArea.Division            as division,
          CustomerName                           as customerName
}
