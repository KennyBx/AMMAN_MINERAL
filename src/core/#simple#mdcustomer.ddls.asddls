@AbapCatalog.sqlViewName: '/SIMPLE/MDCU'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Customer Master Data'
define view /SIMPLE/MDCUSTOMER
  as select from A_Customer        as CU
    inner join   A_BusinessPartner as BP on BP.Customer = CU.Customer
{
  key     CU.Customer        as customer,
          CustomerName       as customerName,
          BP.BusinessPartner as businessPartner
}
