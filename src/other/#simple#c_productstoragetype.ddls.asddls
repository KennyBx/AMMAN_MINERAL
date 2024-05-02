@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSTOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductStorageType'
define view /SIMPLE/C_ProductStorageType
  as select from /SIMPLE/I_PRODUCTSTORAGETYPE  
  association to parent /SIMPLE/C_ProductWareHouse as _ProductWareHouse on  $projection.product         = _ProductWareHouse.product
                                                                        and $projection.wareHouseNumber = _ProductWareHouse.wareHouseNumber
{
  key Product                        as product,
  key WareHouseNumber                as wareHouseNumber,
  key StorageType                    as storageType,
      DeletionFlag                   as deletionFlag,
      StorageBin                     as storageBin,
      MaxStorageBinQty               as maxStorageBinQty,
      MinStorageBinQty               as minStorageBinQty,
      ControlQuantity                as controlQuantity,
      ReplenishMentQty               as replenishMentQty,
      PickingArea                    as pickingArea,
      RoundingQty                    as roundingQty,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _ProductWareHouse
}
