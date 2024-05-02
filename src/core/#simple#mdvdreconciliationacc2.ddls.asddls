@AbapCatalog.sqlViewName: '/SIMPLE/MDVDREA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Vendor Reconciliation Account2'
define view /SIMPLE/MDVDRECONCILIATIONACC2 as select from /SIMPLE/MDVDRECONCILIATIONACC {
    key ReconciliationAccount as reconciliationAccount,
    key CompanyCode as companyCode,
    key Locale as locale,
    Description as description
}
