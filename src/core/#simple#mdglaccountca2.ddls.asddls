@AbapCatalog.sqlViewName: '/SIMPLE/MDGLACC2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - GL Account2'
define view /SIMPLE/MDGLACCOUNTCA2 as select from /SIMPLE/MDGLACCOUNTCA {
    key ChartOfAccount as chartOfAccount,
    key GLAccount as glAccount,
    key Locale as locale,
    Description as description
}
