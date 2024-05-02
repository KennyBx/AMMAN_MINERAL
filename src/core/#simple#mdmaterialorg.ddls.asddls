@AbapCatalog.sqlViewName: '/SIMPLE/MDMVKE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Sales Org Data'
define view /SIMPLE/MDMATERIALORG
  as select from mvke as t1
{
  key   t1.matnr as   material,
  key   t1.vkorg as   salesOrganization,
  key   t1.vtweg as   distributionChannel
}
