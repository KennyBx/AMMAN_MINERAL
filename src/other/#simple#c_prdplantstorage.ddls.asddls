@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPSTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantStorage'
define view /SIMPLE/C_PrdPlantStorage
  as select from I_Productplantstorage
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product, 
  key Plant                          as plant,
      InventoryForCycleCountInd      as inventoryForCycleCountInd,
      /// MaximumStoragePeriod,  not in c view
      // ProvisioningServiceLevel,    removing as it has no functional usage and not visible in Product Master App
      // IsActiveEntity

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant

}
