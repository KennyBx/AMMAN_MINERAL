// Product Storage Location (active)
@AbapCatalog.sqlViewName: '/SIMPLE/IPSLOC'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Storage Loc Active Core Entity'
// performance related
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_PrdStorageLocation
  as select from nsdm_e_mard as StorageLocation  

  association [1..1] to /SIMPLE/I_Product                as _Product         on  $projection.Product = _Product.Product
  association [0..1] to E_Productstoragelocation as _ActiveExtension on  $projection.Product         = _ActiveExtension.Product
                                                                     and $projection.Plant           = _ActiveExtension.Plant
                                                                     and $projection.StorageLocation = _ActiveExtension.StorageLocation
//  association [0..*] to /SIMPLE/I_MaterialStock          as _Stock           on  $projection.Product         = _Stock.Material
//                                                                     and $projection.Plant           = _Stock.Plant
//                                                                     and $projection.StorageLocation = _Stock.StorageLocation
  //Start: enterprise search help (ESH) related associations------------------------------------------------------------------------------------
  //These associations are required in I_ProductStorageLocation as N_ProductStorageLocation has these associations
  //There can be no associations in N_ProductStorageLocation which are not present in I_ProductStorageLocation
//  association [1..1] to /SIMPLE/I_StorageLocation        as _StorageLocation on  $projection.Plant           = _StorageLocation.Plant
//                                                                     and $projection.StorageLocation = _StorageLocation.StorageLocation
  //End of ESH related associations-------------------------------------------------------------------------------------------------------------

{

  key StorageLocation.matnr                           as Product,
  key StorageLocation.werks                           as Plant,
  key StorageLocation.lgort                           as StorageLocation,
      StorageLocation.lgpbe                           as WarehouseStorageBin,
      StorageLocation.pstat                           as MaintenanceStatus,
      StorageLocation.lvorm                           as IsMarkedForDeletion,
      StorageLocation.sperr                           as PhysicalInventoryBlockInd,
      StorageLocation.ersda                           as CreationDate,
      StorageLocation.dlinl                           as DateOfLastPostedCntUnRstrcdStk,
      StorageLocation.bskrf                           as InventoryCorrectionFactor,
      StorageLocation.kzile                           as InvtryRestrictedUseStockInd,
      StorageLocation.kzill                           as InvtryCurrentYearStockInd,
      StorageLocation.kzilq                           as InvtryQualInspCurrentYrStkInd,
      StorageLocation.kzils                           as InventoryBlockStockInd,
      StorageLocation.kzvle                           as InvtryRestStockPrevPeriodInd,
      StorageLocation.kzvll                           as InventoryStockPrevPeriod,
      StorageLocation.kzvlq                           as InvtryStockQltyInspPrevPeriod,
      StorageLocation.kzvls                           as HasInvtryBlockStockPrevPeriod,
      StorageLocation.lfgja                           as FiscalYearCurrentPeriod,
      StorageLocation.lfmon                           as FiscalMonthCurrentPeriod,
      StorageLocation.mdjin                           as FiscalYearCurrentInvtryPeriod,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0
      //            StorageLocation.labst                     as VltdUnrestrictedUseStkQty -- deprecated field ATC error 26.4.16

      // New fields from MDG model, as part of unified API development
      StorageLocation.lwmkb                           as LeanWrhsManagementPickingArea,

      _Product
//      _Stock,

      //Start of ESH related associations---------------------------
//      _StorageLocation
      //End of ESH related associations------------------------------
}
