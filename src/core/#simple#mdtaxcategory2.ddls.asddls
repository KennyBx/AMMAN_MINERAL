@AbapCatalog.sqlViewName: '/SIMPLE/MDTAXCA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Tax Category'
define view /SIMPLE/MDTAXCATEGORY2 as select from /SIMPLE/MDTAXCATEGORY {
    key ProcedureID as procedureID,
    key TaxCode as taxCode,
    key Locale as locale,
    CompanyCode as companyCode,
    Description as description
}
