@AbapCatalog.sqlViewName: '/SIMPLE/MDOD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Order'
define view /SIMPLE/MDORDER
  as select from aufk
{
  key aufnr as orderNumber,
      auart as orderType,
      autyp as orderCategory,
      ktext as description,
      kokrs as controllingArea,
      bukrs as companyCode,
      werks as plant
}
