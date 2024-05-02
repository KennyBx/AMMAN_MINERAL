@AbapCatalog.sqlViewName: '/SIMPLE/MDGLAC2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - G/L account (company code)2'
define view /SIMPLE/MDGLACCOUNTCOMPANYCOD2 as select from /SIMPLE/MDGLACCOUNTCOMPANYCODE {
    key CompanyCode as companyCode,
    key GLAccount as glAccount,
    key ChartOfAccounts as chartOfAccounts
}
