@AbapCatalog.sqlViewName: '/SIMPLE/MDPSUPAR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Production Supply Area'
define view /SIMPLE/MDPRODUCTSUPPLYAREA
  as select from pvbe as PVBE 
  left outer join pvkt as PVKT on pvbe.werks = pvkt.werks
                              and pvbe.prvbe = pvkt.prvbe
{
  key pvbe.werks as plantID,
  key pvbe.prvbe as supplyArea,
  key pvkt.spras as locale,
      pvkt.pvbtx as description
}
