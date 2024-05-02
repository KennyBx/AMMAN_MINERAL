@AbapCatalog.sqlViewName: '/SIMPLE/MDVENDO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Vendor'
define view /SIMPLE/MDVENDOR
  as select from lfa1
{
  key lifnr as vendor,
      sortl as searchTerm,
      land1 as country,
      pstlz as postalCode,
      ort01 as city,
      name1 as name
}
