@AbapCatalog.sqlViewName: '/SIMPLE/CPRDEX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ProducExtendWareHouse'
define view /SIMPLE/C_Prdextendwarehouse
  as select from /SIMPLE/I_Prdextendwarehouse
  //  as select from /sapapo/matlwh
  //    inner join   /sapapo/matkey on /sapapo/matlwh.matid = /sapapo/matkey.matid
  //    inner join   /scwm/t300_md  on /sapapo/matlwh.scuguid = /scwm/t300_md.scuguid
  //    inner join   but000         on /sapapo/matlwh.entitled_id = but000.partner_guid

  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key ProductNumber                  as product,
  key WarehouseNumber                as extendWHNumber,
  key EntitledDispose                as entitledDispose,
      ProcTypeIndicator              as procTypeIndicator,
      CountingIndicator              as countingIndicator,
      PutawayControl                 as putawayControl,
      StockRemovalControl            as stockRemovalControl,

      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      _Product

}
