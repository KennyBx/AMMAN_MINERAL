// Product Sales Tax Classification
@AbapCatalog.sqlViewName: '/SIMPLE/IPSTRT'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Storage type entity'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MIXED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_PRODUCTSTORAGETYPE
  as select from mlgt
  association [1..1] to /SIMPLE/I_Product     as _Product     on $projection.Product = _Product.Product
{
  key matnr      as Product,
  key lgnum      as WareHouseNumber,
  key lgtyp      as StorageType,
  lvorm          as DeletionFlag,
  lgpla          as StorageBin,
  lpmax          as MaxStorageBinQty,
  lpmin          as MinStorageBinQty,
  mamng          as ControlQuantity,
  nsmng          as ReplenishMentQty,
  kober          as PickingArea,
  rdmng          as RoundingQty
}
