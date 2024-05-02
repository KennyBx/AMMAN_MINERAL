@AbapCatalog.sqlViewName: '/SIMPLE/MDSPREA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Vendor Reconciliation Account2'
define view /SIMPLE/MDSPRECONCILIATIONACC2 as select from /SIMPLE/MDSPRECONCILIATIONACC {
    key ReconciliationAccount as reconciliationAccount,
    key CompanyCode as companyCode,
    key Locale as locale,
    Description as description
}
