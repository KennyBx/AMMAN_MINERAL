@AbapCatalog.sqlViewName: '/SIMPLE/MDCUREA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Customer Reconciliation Acc2'
define view /SIMPLE/MDCURECONCILIATIONACC2 as select from /SIMPLE/MDCURECONCILIATIONACC {
    key ReconciliationAccount  as reconciliationAccount,
    key CompanyCode as companyCode,
    key Locale  as locale,
    Description as description
}
