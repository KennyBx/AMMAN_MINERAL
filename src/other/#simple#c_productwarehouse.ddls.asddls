@AbapCatalog.sqlViewName: '/SIMPLE/CPRDWH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductWareHouse'
define view /SIMPLE/C_ProductWareHouse
  as select from /SIMPLE/I_PRODUCTWAREHOUSE 
  composition [0..*] of /SIMPLE/C_ProductStorageType as _ProductStorageType
  association to parent /SIMPLE/C_Product            as _Product on $projection.product = _Product.product
{
  key Product                        as product,
  key WareHouseNumber                as wareHouseNumber,
      DeletionFlag                   as deletionFlag,
      StorageSectionIndicator        as storageSectionIndicator,
      StockPlacementIndicator        as stockPlacementIndicator,
      StockRemovalIndicator          as stockRemovalIndicator,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDWAREHOUSE'
      LoadingQuantity1               as loadingQuantity1,
      @Consumption.hidden: true
      LoadingQuantity1               as LoadingQuantity1_raw,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDWAREHOUSE'
      LoadingQuantity2               as loadingQuantity2,
      @Consumption.hidden: true
      LoadingQuantity2               as loadingQuantity2_raw,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDWAREHOUSE'
      LoadingQuantity3               as loadingQuantity3,
      @Consumption.hidden: true
      LoadingQuantity3               as loadingQuantity3_raw,
      LoadingUnit1                   as loadingUnit1,
      LoadingUnit2                   as loadingUnit2,
      LoadingUnit3                   as loadingUnit3,
      StorageTypeUnit1               as storageTypeUnit1,
      StorageTypeUnit2               as storageTypeUnit2,
      StorageTypeUnit3               as storageTypeUnit3,
      WareHouseUnitOfMeasure         as wareHouseUnitOfMeasure,
      ExistingStockIndicator         as existingStockIndicator,
      BulkStorageIndicator           as bulkStorageIndicator,
      InventoryMessageIndicator      as inventoryMessageIndicator,
      SpecialMovementIndicator       as specialMovementIndicator,
      CapacityUsage                  as capacityUsage,
      UOMCapacityConsumption         as uomCapacityConsumption,
      PickingStorageType             as pickingStorageType,
      MaterialUOM                    as materialUOM,
      MaterialRelevance              as materialRelevance,


      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /*Association*/
      _ProductStorageType,
      _Product
}
