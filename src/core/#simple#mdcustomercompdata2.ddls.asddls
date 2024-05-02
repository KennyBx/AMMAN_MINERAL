@AbapCatalog.sqlViewName: '/SIMPLE/MDCUCOM2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Customer Company data2'
define view /SIMPLE/MDCUSTOMERCOMPDATA2 as select from /SIMPLE/MDCUSTOMERCOMPDATA {
    key Customer  as customer,
    key CompanyCode as companyCode,
    CustomerName as customerName
}
