@AbapCatalog.sqlViewName: '/SIMPLE/MDPDVD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - Vendor PD'
define view /SIMPLE/MDPDVENDOR
  as select from lfa1
{
  key lifnr as supplier,
      werks as plant,
      name1 as supplierName
}
