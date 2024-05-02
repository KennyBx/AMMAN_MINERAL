@AbapCatalog.sqlViewName: '/SIMPLE/MDCUCOMP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Customer Company data'
define view /SIMPLE/MDCUSTOMERCOMPDATA
  as select from A_Customer as CU
  association [0..*] to A_CustomerCompany as _CustomerCompany on $projection.customer = _CustomerCompany.Customer
{
  key     CU.Customer                  as customer,
  key     _CustomerCompany.CompanyCode as companyCode,
          CustomerName                 as customerName
}
