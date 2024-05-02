// Product Sales Tax Classification
@AbapCatalog.sqlViewName: '/SIMPLE/IPWAREH'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product ware house entity'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MIXED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_PRODUCTWAREHOUSE
  as select from mlgn
  association [1..1] to /SIMPLE/I_Product     as _Product     on $projection.Product = _Product.Product

{
  key matnr      as Product,
  key lgnum      as WareHouseNumber,
  lvorm          as DeletionFlag,
  lgbkz          as StorageSectionIndicator,
  ltkze          as StockPlacementIndicator,
  ltkza          as StockRemovalIndicator,
  lhmg1          as LoadingQuantity1,
  lhmg2          as LoadingQuantity2,
  lhmg3          as LoadingQuantity3,
  lhme1          as LoadingUnit1,
  lhme2          as LoadingUnit2,
  lhme3          as LoadingUnit3,
  lety1          as StorageTypeUnit1,
  lety2          as StorageTypeUnit2,
  lety3          as StorageTypeUnit3,
  lvsme          as WareHouseUnitOfMeasure,
  kzzul          as ExistingStockIndicator,
  block          as BulkStorageIndicator,
  kzmbf          as InventoryMessageIndicator,
  bsskz          as SpecialMovementIndicator,
  mkapv          as CapacityUsage,
  bezme          as UOMCapacityConsumption,
  plkpt          as PickingStorageType,
  vomem          as MaterialUOM,
  l2skr          as MaterialRelevance
}
