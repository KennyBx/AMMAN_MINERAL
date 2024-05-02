@AbapCatalog.sqlViewName: '/SIMPLE/MDUSRRP2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - User Responsible2'
define view /SIMPLE/MDUSERRESPONSIBLE2 as select from /SIMPLE/MDUSERRESPONSIBLE {
    key UserID as userID,
    Responsible as responsible,
    Description as description
}
