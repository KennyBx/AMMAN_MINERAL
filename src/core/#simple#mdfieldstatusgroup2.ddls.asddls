@AbapCatalog.sqlViewName: '/SIMPLE/MDFSTGR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Field status groups2'
define view /SIMPLE/MDFIELDSTATUSGROUP2 as select from /SIMPLE/MDFIELDSTATUSGROUP {
    key FieldStatusVariant as fieldStatusVariant,
    key FieldStatusGroup as fieldStatusGroup,
    key CompanyCode as companyCode,
    key Locale as locale,
    Description as description
}
