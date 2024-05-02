@AbapCatalog.sqlViewName: '/SIMPLE/MDVEND2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Vendor2'
define view /SIMPLE/MDVENDOR2 as select from /SIMPLE/MDVENDOR {
    key Vendor as vendor,
    SearchTerm as searchTerm,
    Country as country,
    PostalCode as postalCode,
    City as city,
    Name as name
}
