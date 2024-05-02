@AbapCatalog.sqlViewName: '/SIMPLE/IPRDEX'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Extend WareHouse'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_Prdextendwarehouse
  as select from /sapapo/matlwh
    inner join   prdscmmatkey  on /sapapo/matlwh.matid = prdscmmatkey.matid
    inner join   /scwm/t300_md on /sapapo/matlwh.scuguid = /scwm/t300_md.scuguid
    inner join   but000        on /sapapo/matlwh.entitled_id = but000.partner_guid
{
  key prdscmmatkey.matnr      as ProductNumber,
  key /scwm/t300_md.lgnum     as WarehouseNumber,
  key but000.partner          as EntitledDispose,
      /sapapo/matlwh.ptdetind as ProcTypeIndicator,
      /sapapo/matlwh.ccind    as CountingIndicator,
      /sapapo/matlwh.put_stra as PutawayControl,
      /sapapo/matlwh.rem_stra as StockRemovalControl
}
