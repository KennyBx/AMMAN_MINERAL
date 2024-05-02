@AbapCatalog.sqlViewName: '/SIMPLE/IPSPLAN'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product SupPlanning active core entity'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE


define view /SIMPLE/I_PrdSupplyPlanning
  as select from nsdm_e_marc as SupplyPlanning

  association [1..1] to /SIMPLE/I_Product              as _Product                     on  $projection.Product = _Product.Product

  association [0..1] to E_Productplant                 as _ProdSupplyPlanExt           on  $projection.Product = _ProdSupplyPlanExt.Product
                                                                                       and $projection.Plant   = _ProdSupplyPlanExt.Plant
//  association [0..1] to /SIMPLE/I_RangeOfCoveragePrf   as _RangeOfCvrgPrflCode         on  $projection.Plant               = _RangeOfCvrgPrflCode.Plant
//                                                                                       and $projection.RangeOfCvrgPrflCode = _RangeOfCvrgPrflCode.RangeOfCoverageProfile

//  association [0..*] to /SIMPLE/I_RangeOfCoveragePrfT  as _RangeOfCvrgPrflCodeText     on  $projection.Plant               = _RangeOfCvrgPrflCodeText.Plant
//                                                                                       and $projection.RangeOfCvrgPrflCode = _RangeOfCvrgPrflCodeText.RangeOfCoverageProfile

//  association [0..1] to /SIMPLE/I_SafetyTimePeriodPrf  as _SafetyTimePeriodProfile     on  $projection.Plant              = _SafetyTimePeriodProfile.Plant
//                                                                                       and $projection.PerdPrflForSftyTme = _SafetyTimePeriodProfile.SafetyTimePeriodProfile
//  association [0..*] to /SIMPLE/I_SafetyTimePeriodPrfT as _SafetyTimePeriodProfileText on  $projection.Plant              = _SafetyTimePeriodProfileText.Plant
//                                                                                       and $projection.PerdPrflForSftyTme = _SafetyTimePeriodProfileText.SafetyTimePeriodProfile
//  association [0..1] to /SIMPLE/I_ProdAvailCheckGroup  as _AvailabilityCheckType       on  $projection.AvailabilityCheckType = _AvailabilityCheckType.ProdAvailabilityCheckGroup
//  association [0..*] to /SIMPLE/I_ProdAvailCheckGroupT as _AvailabilityCheckTypeText   on  $projection.AvailabilityCheckType = _AvailabilityCheckTypeText.ProdAvailabilityCheckGroup

//  association [0..1] to /SIMPLE/I_MRPPlanningPeriod    as _MRPPlanningCalendar         on  $projection.Plant               = _MRPPlanningCalendar.MRPPlant
//                                                                                       and $projection.MRPPlanningCalendar = _MRPPlanningCalendar.MRPPlanningCalendar
//
//  association [0..*] to /SIMPLE/I_MRPPlanningPeriodT   as _MRPPlanningCalendarText     on  $projection.Plant               = _MRPPlanningCalendarText.MRPPlant
//                                                                                       and $projection.MRPPlanningCalendar = _MRPPlanningCalendarText.MRPPlanningCalendar

//  association [0..1] to /SIMPLE/I_MRPGroup             as _MRPGroup                    on  $projection.Plant    = _MRPGroup.MRPPlant
//                                                                                       and $projection.MRPGroup = _MRPGroup.MRPGroup

//  association [0..*] to /SIMPLE/I_MRPGroupText         as _MRPGroupText                on  $projection.Plant    = _MRPGroupText.MRPPlant
//                                                                                       and $projection.MRPGroup = _MRPGroupText.MRPGroup

{

  key SupplyPlanning.matnr                            as Product,
  key SupplyPlanning.werks                            as Plant,
      SupplyPlanning.bstfe                            as FixedLotSizeQuantity,
      SupplyPlanning.bstma                            as MaximumLotSizeQuantity,
      SupplyPlanning.bstmi                            as MinimumLotSizeQuantity,
      SupplyPlanning.bstrf                            as LotSizeRoundingQuantity,
      SupplyPlanning.disls                            as LotSizingProcedure,
      SupplyPlanning.dismm                            as MRPType,
      SupplyPlanning.dispo                            as MRPResponsible,
      SupplyPlanning.eisbe                            as SafetyStockQuantity,
      SupplyPlanning.eislo                            as MinimumSafetyStockQuantity,
      SupplyPlanning.fxhor                            as PlanningTimeFence,
      SupplyPlanning.maabc                            as ABCIndicator,
      SupplyPlanning.mabst                            as MaximumStockQuantity,
      SupplyPlanning.minbe                            as ReorderThresholdQuantity,
      SupplyPlanning.plifz                            as PlannedDeliveryDurationInDays,
      SupplyPlanning.shzet                            as SafetyDuration,
      SupplyPlanning.strgr                            as PlanningStrategyGroup,
      SupplyPlanning.wzeit                            as TotalReplenishmentLeadTime,
      SupplyPlanning.beskz                            as ProcurementType,
      SupplyPlanning.sobsl                            as ProcurementSubType,
      SupplyPlanning.ausss                            as AssemblyScrapPercent,
      @ObjectModel.foreignKey.association: '_AvailabilityCheckType'
      @ObjectModel.text.association:'_AvailabilityCheckTypeText'
      SupplyPlanning.mtvfp                            as AvailabilityCheckType,
//      _AvailabilityCheckType,
//      _AvailabilityCheckTypeText,
      SupplyPlanning.webaz                            as GoodsReceiptDuration,

      //Retail fields

      SupplyPlanning.lfrhy                            as PlanAndOrderDayDetermination,
      SupplyPlanning.rdprf                            as RoundingProfile,
      SupplyPlanning.lgfsb                            as DfltStorageLocationExtProcmt,
      SupplyPlanning.gi_pr_time                       as GoodIssueProcessingDays,
      SupplyPlanning.cons_procg                       as ConsignmentControl,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0

      //New fields added as part of MRP area to be added at plant level also
      @ObjectModel.foreignKey.association: '_MRPGroup'
      @ObjectModel.text.association:'_MRPGroupText'
      SupplyPlanning.disgr                            as MRPGroup,
      // SupplyPlanning.lfrhy                                        as PlanAndOrderDayDetermination,
      // SupplyPlanning.rdprf                                        as RoundingProfile,
      SupplyPlanning.losfx                            as LotSizeIndependentCosts,
      SupplyPlanning.lagpr                            as IsStorageCosts,
      SupplyPlanning.takzt                            as RqmtQtyRcptTaktTmeInWrkgDays, //to be added
      // SupplyPlanning.takzt                                              as TaktTime,
      @ObjectModel.foreignKey.association: '_MRPPlanningCalendar'
      @ObjectModel.text.association:'_MRPPlanningCalendarText'
      SupplyPlanning.mrppp                            as MRPPlanningCalendar,
      //SupplyPlanning.plifz                                        as PlannedDeliveryDurationInDays,
      @ObjectModel.foreignKey.association: '_RangeOfCvrgPrflCode'
      @ObjectModel.text.association:'_RangeOfCvrgPrflCodeText'
      SupplyPlanning.rwpro                            as RangeOfCvrgPrflCode,
      SupplyPlanning.shflg                            as IsSafetyTime,
      @ObjectModel.foreignKey.association: '_SafetyTimePeriodProfile'
      @ObjectModel.text.association:'_SafetyTimePeriodProfileText'
      SupplyPlanning.shpro                            as PerdPrflForSftyTme,
      SupplyPlanning.ahdis                            as IsMRPDependentRqmt,
      SupplyPlanning.lgrad                            as SrvcLvl,
      SupplyPlanning.dzeit                            as InHouseProductionTime,
      SupplyPlanning.miskz                            as MRPAvailabilityType,

      //New fields from MDG model, as part of unified API development
      SupplyPlanning.kzpsp                            as ProductIsForCrossProject,
      SupplyPlanning.lagpr                            as StorageCostsPercentageCode,
      // SupplyPlanning.lgrad                                              as SrvcLvl,
      // SupplyPlanning.losfx                                              as LotSizeIndependentCosts,
      // SupplyPlanning.MISKZ                                              as MRPAvailabilityType,
      SupplyPlanning.mrppp                            as ProdnPlngAndControlCalendar,
      SupplyPlanning.nfmat                            as FollowUpProduct,
      // SupplyPlanning.rwpro                                              as RangeOfCvrgPrflCode,
      SupplyPlanning.sauft                            as RepetitiveManufacturingIsAllwd,
      SupplyPlanning.sbdkz                            as DependentRequirementsType,
      SupplyPlanning.schgt                            as IsBulkMaterialComponent,
      SupplyPlanning.sfepr                            as RepetitiveManufacturingProfile,
      // SupplyPlanning.shpro                                              as PerdPrflForSftyTme,
      // SupplyPlanning.shflg                                              as IsSafetyTime,
      // SupplyPlanning.takzt                                              as RqmtQtyRcptTaktTmeInWrkgDays,
      SupplyPlanning.vint1                            as BackwardCnsmpnPeriodInWorkDays,
      SupplyPlanning.vint2                            as FwdConsumptionPeriodInWorkDays,
      SupplyPlanning.vrmod                            as ProdRqmtsConsumptionMode,
      SupplyPlanning.auftl                            as ForecastRequirementsAreSplit,
      SupplyPlanning.ausdt                            as EffectiveOutDate,
      SupplyPlanning.dispr                            as MRPProfile,
      SupplyPlanning.fhori                            as SchedulingMarginKey,
      SupplyPlanning.kausf                            as ComponentScrapInPercent,
      SupplyPlanning.kzaus                            as ProductIsToBeDiscontinued,
      SupplyPlanning.kzbed                            as ProdRqmtsAreConsolidated,
      SupplyPlanning.lgpro                            as ProductionInvtryManagedLoc,
      SupplyPlanning.rgekz                            as MatlCompIsMarkedForBackflush,
      SupplyPlanning.vspvb                            as ProposedProductSupplyArea,

      _Product
//      _RangeOfCvrgPrflCode,
//      _RangeOfCvrgPrflCodeText
//      _SafetyTimePeriodProfile,
//      _SafetyTimePeriodProfileText
//      _MRPPlanningCalendar,
//      _MRPPlanningCalendarText
//      _MRPGroup,
//      _MRPGroupText



}
