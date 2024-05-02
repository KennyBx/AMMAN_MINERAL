@AbapCatalog.sqlViewName: '/SIMPLE/MDPLTSO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Delivery plant links to sales org'
define view /SIMPLE/MDDELPLANTSALESORG
  as select from tvkwz
{
  key vkorg as salesOrganization,
  key vtweg as distributionChannel,
  key werks as plantID
}
