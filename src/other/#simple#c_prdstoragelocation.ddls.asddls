@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductStorageLocation'
define view /SIMPLE/C_PrdStorageLocation 
  as select from /SIMPLE/I_PrdStorageLocation as StorageLocation
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant

{

  key    Product                        as product,
  key    Plant                          as plant,
  key    StorageLocation                as storageLocation,
         WarehouseStorageBin            as warehouseStorageBin,
//         @ObjectModel.readOnly: true
         MaintenanceStatus              as maintenanceStatus,
         PhysicalInventoryBlockInd      as physicalInventoryBlockInd,
//         @ObjectModel.readOnly: true
         CreationDate                   as creationDate,
         IsMarkedForDeletion            as isMarkedForDeletion,
         DateOfLastPostedCntUnRstrcdStk as dateOfLastPostedCntUnRstrcdStk,
         InventoryCorrectionFactor      as inventoryCorrectionFactor,
         InvtryRestrictedUseStockInd    as invtryRestrictedUseStockInd,
         InvtryCurrentYearStockInd      as invtryCurrentYearStockInd,
         InvtryQualInspCurrentYrStkInd  as invtryQualInspCurrentYrStkInd,
         InventoryBlockStockInd         as inventoryBlockStockInd,
         InvtryRestStockPrevPeriodInd   as invtryRestStockPrevPeriodInd,
         InventoryStockPrevPeriod       as inventoryStockPrevPeriod,
         InvtryStockQltyInspPrevPeriod  as invtryStockQltyInspPrevPeriod,
         HasInvtryBlockStockPrevPeriod  as hasInvtryBlockStockPrevPeriod,
         FiscalYearCurrentPeriod        as fiscalYearCurrentPeriod,
         FiscalMonthCurrentPeriod       as fiscalMonthCurrentPeriod,
         FiscalYearCurrentInvtryPeriod  as fiscalYearCurrentInvtryPeriod,
         LeanWrhsManagementPickingArea  as leanWrhsManagementPickingArea,

         /* SimpleMDG specific fields for integration */
         cast( '' as abap.char( 10 ) )  as action,
         cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

         /* Associations */
         _Plant


}
