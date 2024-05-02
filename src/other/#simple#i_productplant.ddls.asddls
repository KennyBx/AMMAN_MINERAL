@AbapCatalog.sqlViewName: '/SIMPLE/IPPLANT'
@VDM.viewType: #BASIC
@EndUserText.label: 'Product Plant Active Core Entity'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
//@AccessControl: {
//    authorizationCheck: #CHECK,
//    privilegedAssociations: [ '_MRPController' ]
//}
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations:true

define view /SIMPLE/I_ProductPlant
  as select from nsdm_e_marc as Plant

  association [1..1] to /SIMPLE/I_Product              as _Product                     on  $projection.Product = _Product.Product
  //  association [0..1] to /SIMPLE/I_MRPController        as _MRPController               on  $projection.Plant          = _MRPController.Plant
  //                                                                                       and $projection.MRPResponsible = _MRPController.MRPController

  association [0..1] to /SIMPLE/I_ProductStatus        as _ProductStatus               on  $projection.ProfileCode = _ProductStatus.Status
  association [0..*] to /SIMPLE/I_ProductStatusText    as _ProductStatusText           on  $projection.ProfileCode = _ProductStatusText.Status
  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _GoodsIssueUnit              on  $projection.GoodsIssueUnit = _GoodsIssueUnit.UnitOfMeasure
  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _UnitOfMeasureText           on  $projection.GoodsIssueUnit = _UnitOfMeasureText.UnitOfMeasure
  //  association [0..1] to /SIMPLE/I_FiscalYearVariant        as _FiscalYearVariant            on  $projection.FiscalYearVariant = _FiscalYearVariant.FiscalYearVariant
  //  association [0..*] to /SIMPLE/I_FiscalYearVariantTxt     as _FiscalYearVariantDescription on  $projection.FiscalYearVariant = _FiscalYearVariantDescription.FiscalYearVariant

  association [0..1] to /SIMPLE/I_Product              as _ConfigurableProduct         on  $projection.ConfigurableProduct = _ConfigurableProduct.Product
  association [0..*] to /SIMPLE/I_ProductDescription   as _ConfigurableProductName     on  $projection.ConfigurableProduct = _ConfigurableProductName.Product

  association [0..*] to /SIMPLE/I_ProductDescription   as _Text                        on  $projection.Product = _Text.Product
  //  association [0..1] to /SIMPLE/I_Prodabclassfctn      as _ABCIndicator                on  $projection.ABCIndicator = _ABCIndicator.MaterialABCClassification
  //  association [0..*] to /SIMPLE/I_Prodabclassfctntxt   as _ABCIndicatorDesc            on  $projection.ABCIndicator = _ABCIndicatorDesc.MaterialABCClassification

  association [1..1] to /SIMPLE/I_Plant                as _Plant                       on  $projection.Plant = _Plant.Plant
  association [0..1] to I_Site                         as _Site                        on  $projection.Plant = _Site.Site
  //  association [0..1] to /SIMPLE/I_MRPType              as _MRPType                     on  $projection.MRPType = _MRPType.MRPType
  //  association [0..1] to /SIMPLE/I_SrcOfSupplyCategory  as _SourceOfSupplyCategory      on  $projection.SourceOfSupplyCategory = _SourceOfSupplyCategory.SourceOfSupplyCategory
  //  association [0..1] to /SIMPLE/I_PurchasingGroup      as _PurchasingGroup             on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup

  // Update 12/07/2023 - Martin - Product Planning

  association [0..1] to iprdplntplanning               as _iprdplntplanning            on  $projection.Product = _iprdplntplanning.product
                                                                                       and $projection.Plant   = _iprdplntplanning.plant

  // Update 12/07/2023 - Martin - Product Planning

  association [0..1] to /SIMPLE/I_PrdWorkScheduling    as _GoodsMovementQuantity       on  $projection.Product = _GoodsMovementQuantity.Product
                                                                                       and $projection.Plant   = _GoodsMovementQuantity.Plant

  association [0..1] to /SIMPLE/I_Prdplantprocurement  as _PlantProcurement            on  $projection.Product = _PlantProcurement.Product
                                                                                       and $projection.Plant   = _PlantProcurement.Plant

  association [0..1] to /SIMPLE/I_ProductPlantIntlTrd  as _ProdPlantInternationalTrade on  $projection.Product = _ProdPlantInternationalTrade.Product
                                                                                       and $projection.Plant   = _ProdPlantInternationalTrade.Plant

  association [0..1] to /SIMPLE/I_ProductPlantCosting  as _ProductPlantCosting         on  $projection.Product = _ProductPlantCosting.Product
                                                                                       and $projection.Plant   = _ProductPlantCosting.Plant

  association [0..1] to /SIMPLE/I_ProductPlantForecast as _ProductPlantForecast        on  $projection.Product = _ProductPlantForecast.Product
                                                                                       and $projection.Plant   = _ProductPlantForecast.Plant

  association [0..1] to /SIMPLE/I_Prdplantqtmanagement as _PlantQualityMgmt            on  $projection.Product = _PlantQualityMgmt.Product
                                                                                       and $projection.Plant   = _PlantQualityMgmt.Plant

  association [0..1] to /SIMPLE/I_Productplantsales    as _PlantSales                  on  $projection.Product = _PlantSales.Product
                                                                                       and $projection.Plant   = _PlantSales.Plant

  association [1..1] to /SIMPLE/I_PrdSupplyPlanning    as _MaterialLotSizingProcedure  on  $projection.Product = _MaterialLotSizingProcedure.Product
                                                                                       and $projection.Plant   = _MaterialLotSizingProcedure.Plant



  association [0..1] to E_Productplant                 as _ProductPlantExt             on  $projection.Product = _ProductPlantExt.Product
                                                                                       and $projection.Plant   = _ProductPlantExt.Plant

  //  association [0..*] to /SIMPLE/I_MaterialStock        as _Stock                       on  $projection.Product = _Stock.Material
  //                                                                                       and $projection.Plant   = _Stock.Plant

  //  //Start: enterprise search help (ESH) related associations------------------------------------------------------------------------------------
  //  //These associations are required in I_ProductPlant as N_ProductPlant has these associations
  //  //There can be no associations in N_ProductPlant which are not present in I_ProductPlant
  //  association [0..*] to /SIMPLE/I_CountryText              as _CountryOfOriginText          on  $projection.CountryOfOrigin = _CountryOfOriginText.Country
  //  association [0..*] to /SIMPLE/I_RegionText               as _RegionText                   on  $projection.CountryOfOrigin = _RegionText.Country
  association [0..*] to /SIMPLE/I_PrdStorageLocation   as _ProductStorageLocation      on  $projection.Product = _ProductStorageLocation.Product
                                                                                       and $projection.Plant   = _ProductStorageLocation.Plant

  //End of ESH related associations-------------------------------------------------------------------------------------------------------------


{
  key    Plant.matnr                                      as Product,
         @ObjectModel.foreignKey.association: '_Plant'
  key    Plant.werks                                      as Plant,
         @ObjectModel.foreignKey.association: '_PurchasingGroup'
         Plant.ekgrp                                      as PurchasingGroup,
         Plant.herkl                                      as CountryOfOrigin,
         Plant.herkr                                      as RegionOfOrigin,

         Plant.lgpro                                      as ProductionInvtryManagedLoc,


         @ObjectModel : {
            foreignKey.association: '_ProductStatus',
            text.association: '_ProductStatusText'
         }
         Plant.mmsta                                      as ProfileCode,
         Plant.mmstd                                      as ProfileValidityStartDate,
         Plant.mtvfp                                      as AvailabilityCheckType,

         @ObjectModel:{
          foreignKey.association: '_FiscalYearVariant',
          text.association: '_FiscalYearVariantDescription'
         }
         Plant.periv                                      as FiscalYearVariant,

         Plant.perkz                                      as PeriodType,

         Plant.prctr                                      as ProfitCenter,

         cast (Plant.stawn as stawn)                      as Commodity,
         Plant.webaz                                      as GoodsReceiptDuration,
         Plant.pstat                                      as MaintenanceStatusName,
         Plant.lvorm                                      as IsMarkedForDeletion,


         @ObjectModel.foreignKey.association: '_MRPType'
         Plant.dismm                                      as MRPType,
         @ObjectModel.foreignKey.association: '_MRPController'
         Plant.dispo                                      as MRPResponsible,
         Plant.maabc                                      as ABCIndicator,
         Plant.bstmi                                      as MinimumLotSizeQuantity,
         Plant.bstma                                      as MaximumLotSizeQuantity,
         Plant.bstfe                                      as FixedLotSizeQuantity,


         Plant.steuc                                      as ConsumptionTaxCtrlCode,
         Plant.kzkup                                      as IsCoProduct,

         cast (Plant.stdpd as configurableproduct )       as ProductIsConfigurable,
         //         //--[ GENERATED:012:29JlHNUf7jY4nhtQM3fYJ0
         //         @Consumption.valueHelpDefinition: [
         //           { entity:  { name:    'I_ProductVH',
         //                        element: 'Product' }
         //           }]
         //         // ]--GENERATED
         @ObjectModel:{
           foreignKey.association: '_ConfigurableProduct',
           text.association: '_ConfigurableProductName'
         }
         Plant.stdpd                                      as ConfigurableProduct,

         Plant.eprio                                      as StockDeterminationGroup,
         Plant.umlmc                                      as StockInTransferQuantity,
         Plant.trame                                      as StockInTransitQuantity,

         cast (Plant.insmk  as hasposttoinspectionstock ) as HasPostToInspectionStock,
         Plant.xchpf                                      as IsBatchManagementRequired,

         Plant.sernp                                      as SerialNumberProfile,
         Plant.xmcng                                      as IsNegativeStockAllowed,
         Plant.bwesb                                      as GoodsReceiptBlockedStockQty,

         Plant.cons_procg                                 as HasConsignmentCtrl,
         //Plant.glgmg                    as TiedEmptiesStockQuantity,

         Plant.lfgja                                      as FiscalYearCurrentPeriod,
         Plant.lfmon                                      as FiscalMonthCurrentPeriod,
         Plant.multiple_ekgrp                             as IsPurgAcrossPurgGroup,
         Plant.xchar                                      as IsInternalBatchManaged,
         Plant.indus                                      as ProductCFOPCategory,

         //Excise Tax Relevance Indicator "15.4.2019
         Plant.excise_tax_rlvnce                          as ProductIsExciseTaxRelevant,

         -- Added on 21.4.16 not relevent for Product master

         Plant.uneto                                      as UnderDelivToleranceLimit,
         Plant.ueeto                                      as OverDelivToleranceLimit,
         Plant.beskz                                      as ProcurementType,
         Plant.sobsl                                      as SpecialProcurementType,
         Plant.sfcpf                                      as ProductionSchedulingProfile,
         Plant.fevor                                      as ProductionSupervisor,
         Plant.eisbe                                      as SafetyStockQuantity,
         //
         //         --Retail fields Addd on 21.4.16

         @Semantics.unitOfMeasure: true
         @ObjectModel.foreignKey.association: '_GoodsIssueUnit'
         @ObjectModel.text.association: '_UnitOfMeasureText'
         Plant.ausme                                      as GoodsIssueUnit,
         @ObjectModel.foreignKey.association: '_SourceOfSupplyCategory'
         Plant.bwscl                                      as SourceOfSupplyCategory,
         Plant.vrbmt                                      as ConsumptionReferenceProduct,
         Plant.vrbwk                                      as ConsumptionReferencePlant,
         Plant.vrbdt                                      as ConsumptionRefUsageEndDate,
         Plant.vrbfk                                      as ConsumptionQtyMultiplier,
         Plant.megru                                      as ProductUnitGroup,
         Plant.fprfm                                      as DistrCntrDistributionProfile,
         Plant.cons_procg                                 as ConsignmentControl,
         Plant.gi_pr_time                                 as GoodIssueProcessingDays,
         Plant.plifz                                      as PlannedDeliveryDurationInDays,
         cast( 'X' as sdraft_is_active preserving type )  as IsActiveEntity, // to enbale extensibility in Draft 2.0

         // New fields from MDG model, as part of unified API development
         Plant.kzkri                                      as ProductIsCriticalPrt,
         Plant.loggr                                      as ProductLogisticsHandlingGroup,
         Plant.mfrgr                                      as MaterialFreightGroup,
         Plant.ucmat                                      as OriginalBatchReferenceMaterial,
         Plant.uchkz                                      as OriglBatchManagementIsRequired,
         // added on CRM request
         Plant.cuobj                                      as ProductConfiguration,

         //Missing Fields 200812
         Plant.atpkz                                      as ReplacementPart,
         Plant.vrvez                                      as SetupTime,
         Plant.vbeaz                                      as ProcessingTime,
         Plant.vbamg                                      as BaseQty,
         Plant.iuid_relevant                              as IUIDRelevant,
         Plant.uid_iea                                    as ExternalAllocationOfUII,
         Plant.iuid_type                                  as IUIDType,
         Plant.fabkz                                      as JITSchedIndicator,
         Plant.losfx                                      as LSIndependentCosts,
         Plant.diber                                      as MRPAreasExist,
         Plant.kzech                                      as BatchEntry,
         Plant.verkz                                      as VersionIndicator,
         Plant.ppskz                                      as AdvancedPlanningIndicator,
         Plant.scm_whatbom                                as PlanExplosion,
         Plant.scm_prio                                   as Priority,
         Plant.scm_rrp_type                               as PPPlngProcedure,
         Plant.scm_rrp_sel_group                          as PlanningGroup,
         Plant.scm_scost                                  as ProdStorageCost,
         Plant.scm_sspen                                  as SafetyStockPenalty,
         Plant.scm_heur_id                                as ProductHeuristic,
         Plant.scm_package_id                             as PlanningPackage,
         Plant.scm_intsrc_prof                            as IntSourcingProfile,
         Plant.scm_profid                                 as ConversionRule,
         Plant.scm_peg_wo_alert_fst                       as AvoidAlerts,
         Plant.scm_peg_strategy                           as PeggingStrategy,
         Plant.scm_min_pass_amount                        as MinPassingAmt,
         Plant.scm_fixpeg_prod_set                        as FixedPegging,
         Plant.scm_stra1                                  as ProposedStrategy,
         Plant.scm_peg_future_alert                       as AlertThresholdForEarliness,
         Plant.scm_peg_past_alert                         as AlertThresholdForLateness,
         Plant.scm_res_net_name                           as ResNetworkName,
         Plant.scm_get_alerts                             as ProductAlerts,
         Plant.scm_ges_mng_use                            as UseTotalReceipts,
         Plant.scm_ges_bst_use                            as UseTotalStock,
         Plant.scm_lsuom                                  as LotSizeUnit,
         Plant.scm_target_dur                             as TargetDaySupply,
         Plant.scm_tstrid                                 as PlanningCalendar,
         Plant.scm_reord_dur                              as ReorderDaySupply,
         Plant.scm_reldt                                  as ReplenishmentLeadTime,
         Plant.scm_grprt                                  as GrProcessngTime,
         Plant.scm_conhap                                 as GrHandlgCapCons,
         Plant.scm_hunit                                  as UoMGrHandlgCap,
         Plant.scm_giprt                                  as GIProcessngTime,
         Plant.scm_conhap_out                             as GIHandlgCapCons,
         Plant.scm_hunit_out                              as UomGIHandlgCap,
         Plant.scm_shelf_life_loc                         as ShelfLife,
         Plant.scm_shelf_life_dur                         as LocShelfLife,
         Plant.scm_maturity_dur                           as LocMaturTime,
         Plant.scm_shlf_lfe_req_min                       as MinShelfLife,
         Plant.scm_shlf_lfe_req_max                       as MaxShelfLife,
         Plant.ccfix                                      as CCFixed,
         Plant.lzeih                                      as TimeUnit,
         Plant.sgt_covs                                   as SegmentationStrategy,
         Plant.sgt_mrpsi                                  as SortStkBasedOnSeg,
         Plant.sgt_defsc                                  as DefaultStockSegment,
         Plant.qmatv                                      as InspectionSetupInd,
         Plant.ncost                                      as DoNotCost,
         Plant.awsls                                      as VarianceKey,
         Plant.stlal                                      as AlternativeBOM,
         Plant.stlan                                      as BOMUsage,
         Plant.plnnr                                      as TaskListGroup,
         Plant.aplal                                      as GroupCounter,
         Plant.sobsk                                      as SpecialProcuremCosting,
         Plant.losgr                                      as CostingLotSize,
         Plant.fxpru                                      as FixedPriceCoProduct,
         Plant.fvidk                                      as ProductVersion,

         Plant.basmg                                      as MaterialBaseQuantity,
         Plant.ueetk                                      as UnlimitedOverDelivIsAllowed,
         Plant.frtme                                      as ProductProductionQuantityUnit,
         Plant.matgr                                      as TransitionMatrixProductsGroup,
         Plant.ocmpf                                      as OrderChangeManagementProfile,
         Plant.ruezt                                      as SetupAndTeardownTime,
         Plant.bearz                                      as ProductProcessingTime,
         Plant.tranz                                      as TransitionTime,

         // Update 12/07/2023 - Martin - ProductPlanning
         _iprdplntplanning.planningmaterial               as PlanningProduct,
         _iprdplntplanning.planningplant                  as PlanningPlant,
         _iprdplntplanning.prodplntplngmatlconversionfctr as PlngConvFactor,
         // Update 12/07/2023 - Martin - Vicor field only

         /*,_PlantText,
          _MRPTypeText,
          _SrlNmbPrfText*/
         _Product,
         _Plant,
         _Site,
         //         _MRPController,
         //         _MRPType,
         //         _SourceOfSupplyCategory,
         //         _PurchasingGroup,
         _Text,
         //         _ABCIndicator,
         //         _ABCIndicatorDesc,
         _GoodsMovementQuantity,
         _PlantProcurement,
         _ProdPlantInternationalTrade,
         _ProductPlantCosting,
         _ProductPlantForecast,
         _PlantQualityMgmt,
         _PlantSales,
         _MaterialLotSizingProcedure,
         _GoodsIssueUnit,
         _UnitOfMeasureText,
         _ProductStatus,
         _ProductStatusText,
         //         _FiscalYearVariant,
         //         _FiscalYearVariantDescription,
         _ConfigurableProduct,
         _ConfigurableProductName,
         //         _Stock,

         //         //Start of ESH related associations---------------------------
         //         _CountryOfOriginText,
         //         _RegionText,
         _ProductStorageLocation
         //End of ESH related associations------------------------------

}
