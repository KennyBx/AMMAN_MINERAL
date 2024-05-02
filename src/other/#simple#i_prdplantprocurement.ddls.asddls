@AbapCatalog.sqlViewName: '/SIMPLE/IPPLPR'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product: Draft node for Plant proc'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_Prdplantprocurement
  as select from nsdm_e_marc as PlantProc  

  association [0..1] to E_Productplant           as _ProdPlantProcExt       on  $projection.Product = _ProdPlantProcExt.Product
                                                                            and $projection.Plant   = _ProdPlantProcExt.Plant
  association [1..1] to /SIMPLE/I_Product                as _Product                on  $projection.Product = _Product.Product

//  association [0..1] to /SIMPLE/I_SrcOfSupplyCategory as _SourceOfSupplyCategory on  $projection.SourceOfSupplyCategory = _SourceOfSupplyCategory.SourceOfSupplyCategory
//  association [0..1] to /SIMPLE/I_PurchasingGroup        as _PurchasingGroup        on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup
{
  key PlantProc.matnr                                      as Product,
  key PlantProc.werks                                      as Plant,
      //      PlantProc.maxlz                                 as MaximumStoragePeriod,
      PlantProc.kautb                                      as IsAutoPurOrdCreationAllowed,
      PlantProc.kordb                                      as IsSourceListRequired,
      PlantProc.multiple_ekgrp                             as IsPurgAcrossPurgGroup,
      @ObjectModel.foreignKey.association: '_SourceOfSupplyCategory'
      PlantProc.bwscl                                      as SourceOfSupplyCategory,
      @ObjectModel.foreignKey.association: '_PurchasingGroup'
      PlantProc.ekgrp                                      as PurchasingGroup,
      cast( 'X' as sdraft_is_active preserving type )      as IsActiveEntity, // to enbale extensibility in Draft 2.0

      // New fields from MDG model, as part of unified API development
      // PlantProc.usequ                                      as QuotaArrangementUsage,
      PlantProc.vspvb                                      as ProposedProductSupplyArea,
      PlantProc.fabkz                                      as ItmIsRlvtToJITDelivSchedules,

//      _SourceOfSupplyCategory,
//      _PurchasingGroup,
      _Product

}
