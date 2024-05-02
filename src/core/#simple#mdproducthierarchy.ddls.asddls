@AbapCatalog.sqlViewName: '/SIMPLE/MDPROHIE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Product Hierarchy'
define view /SIMPLE/MDPRODUCTHIERARCHY
  as select from    t179
    left outer join t179t on t179.prodh = t179t.prodh
{
  key t179.prodh as ProductHierarchy,
  key spras      as Locale,
      stufe      as NumberOfLevel,
      vtext      as Description
}
