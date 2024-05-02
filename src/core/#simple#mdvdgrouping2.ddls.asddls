@AbapCatalog.sqlViewName: '/SIMPLE/MDVDGR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Vendor Grouping'
define view /SIMPLE/MDVDGROUPING2 as select from /SIMPLE/MDVDGROUPING {
    key Grouping as grouping,
    key AccountGroup as accountGroup,
    key Locale as locale,
    Description as description
}
