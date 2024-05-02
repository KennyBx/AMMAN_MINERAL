@AbapCatalog.sqlViewName: '/SIMPLE/MDGRECHR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Goods receiving hours'
define view /SIMPLE/MDGOODSRECEIVINGHOUR
  as select from tvwa as TVWA 
  left outer join tvwat as TVWAT on tvwa.wanid = tvwat.wanid 
{
  key tvwa.wanid as goodsReceivingHour,
  key tvwat.spras as locale,
      tvwat.vtext as description
}
