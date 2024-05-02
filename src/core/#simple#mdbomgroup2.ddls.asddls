@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMGR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - BoM Group2'
define view /SIMPLE/MDBOMGROUP2 as select from /SIMPLE/MDBOMGROUP {
    key BOMGroup as bomGroup,
    Description as description
}
