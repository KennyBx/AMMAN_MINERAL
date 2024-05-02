@AbapCatalog.sqlViewName: '/SIMPLE/IPPSALES'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product: Draft node for plant sales'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE


define view /SIMPLE/I_Productplantsales
  as select from nsdm_e_marc as PlantSales  
  association [1..1] to /SIMPLE/I_Product      as _Product           on  $projection.Product = _Product.Product
  association [0..1] to E_Productplant as _ProdPlantSalesExt on  $projection.Product = _ProdPlantSalesExt.Product
                                                             and $projection.Plant   = _ProdPlantSalesExt.Plant
{

  key PlantSales.matnr                                                        as Product,
  key PlantSales.werks                                                        as Plant,
      PlantSales.ladgr                                                        as LoadingGroup,
      cast( 'X' as sdraft_is_active preserving type )                         as IsActiveEntity, // to enbale extensibility in Draft 2.0

      // New fields from MDG model, as part of unified API development
      PlantSales.vbamg                                                        as CapPlanningQuantityInBaseUoM,
      PlantSales.vbeaz                                                        as ProductShippingProcessingTime,
      PlantSales.vrvez                                                        as WrkCentersShipgSetupTimeInDays,
      PlantSales.atpkz                                                        as ReplacementPartType,
      PlantSales.mtvfp                                                        as AvailabilityCheckType,

      _Product
}
