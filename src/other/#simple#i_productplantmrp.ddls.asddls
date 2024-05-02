@AbapCatalog.sqlViewName: '/SIMPLE/IPPLMRP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MRP area data of a Product'
@ObjectModel: {
 usageType.serviceQuality: #A,
  usageType.sizeCategory : #L,
  usageType.dataClass: #TRANSACTIONAL}
@VDM.viewType : #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE

@AccessControl.privilegedAssociations: ['_MRPResponsible']
define view /SIMPLE/I_ProductPlantMRP
  as select from mdma as MRPAreaData

  association [0..1] to I_MRPType                    as _MRPType                 on  $projection.MRPType = _MRPType.MRPType
  association [0..*] to I_MRPTypeText                as _MRPTypeName             on  $projection.MRPType = _MRPTypeName.MRPType
  association [0..1] to I_Mrplotsizgprctemp          as _LotSizingProcedure      on  $projection.LotSizingProcedure = _LotSizingProcedure.MaterialLotSizingProcedure
  association [0..1] to I_StorageLocation            as _PlantInvtryManagedLoc   on  $projection.StorageLocation = _PlantInvtryManagedLoc.StorageLocation
                                                                                 and $projection.Plant           = _PlantInvtryManagedLoc.Plant
  association [1..1] to I_Product                    as _Product                 on  $projection.Product = _Product.Product
  association [0..1] to I_MRPController              as _MRPResponsible          on  $projection.MRPResponsible = _MRPResponsible.MRPController
                                                                                 and $projection.Plant          = _MRPResponsible.Plant
  association [0..1] to I_UnitOfMeasure              as _LotSizeUnit             on  $projection.LotSizeUnit = _LotSizeUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure              as _GRHandlingCapacityUnit  on  $projection.GRHandlingCapacityUnit = _GRHandlingCapacityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure              as _GIHandlingCapacityUnit  on  $projection.GIHandlingCapacityUnit = _GIHandlingCapacityUnit.UnitOfMeasure

  association [0..1] to I_ProductHeuristic           as _ProdnPlngHeuristic      on  $projection.ProdnPlngHeuristic = _ProdnPlngHeuristic.ProdnPlngHeuristic
  association [0..1] to I_ProdnPlanningProcedure     as _PPPlanningProcedure     on  $projection.PPPlanningProcedure = _PPPlanningProcedure.ProdnPlanningProcedure
  association [0..1] to I_PlanningPackage            as _ProductPlanningPackage  on  $projection.ProductPlanningPackage = _ProductPlanningPackage.PlanningPackage
  association [0..1] to I_RangeOfCoverageProfile     as _RangeOfCvrgPrflCode     on  $projection.Plant               = _RangeOfCvrgPrflCode.Plant
                                                                                 and $projection.RangeOfCvrgPrflCode = _RangeOfCvrgPrflCode.RangeOfCoverageProfile

  association [0..*] to I_RangeOfCoverageProfileText as _RangeOfCvrgPrflCodeText on  $projection.Plant               = _RangeOfCvrgPrflCodeText.Plant
                                                                                 and $projection.RangeOfCvrgPrflCode = _RangeOfCvrgPrflCodeText.RangeOfCoverageProfile
  //  association [0..1] to E_ProductPlantMRP            as _ProductPlantMRPExt      on  $projection.Product = _ProductPlantMRPExt.Product
  //                                                                                 and $projection.MRPArea = _ProductPlantMRPExt.MRPArea
  //                                                                                 and $projection.Plant   = _ProductPlantMRPExt.Plant
{
  key matnr                                                                                   as     Product,
  key berid                                                                                   as     MRPArea,
  key werks                                                                                   as     Plant,

      @ObjectModel.foreignKey.association: '_MRPType'
      @ObjectModel.text.association: '_MRPTypeName'
      dismm                                                                                   as     MRPType,
      @ObjectModel.foreignKey.association: '_MRPResponsible'
      dispo                                                                                   as     MRPResponsible,
      disgr                                                                                   as     MRPGroup,

      minbe                                                                                   as     ReorderThresholdQuantity,
      lfrhy                                                                                   as     PlanAndOrderDayDetermination,
      fxhor                                                                                   as     PlanningTimeFence,
      @ObjectModel.foreignKey.association: '_LotSizingProcedure'
      disls                                                                                   as     LotSizingProcedure,
      rdprf                                                                                   as     RoundingProfile,
      bstrf                                                                                   as     LotSizeRoundingQuantity,
      bstmi                                                                                   as     MinimumLotSizeQuantity,
      bstma                                                                                   as     MaximumLotSizeQuantity,
      mabst                                                                                   as     MaximumStockQuantity,
      ausss                                                                                   as     AssemblyScrapPercent,
      sobsl                                                                                   as     ProcurementSubType,
      @ObjectModel.foreignKey.association: '_PlantInvtryManagedLoc'
      lgpro                                                                                   as     StorageLocation,
      lgfsb                                                                                   as     DfltStorageLocationExtProcmt,
      mrppp                                                                                   as     MRPPlanningCalendar,
      eisbe                                                                                   as     SafetyStockQuantity,
      @ObjectModel.foreignKey.association: '_RangeOfCvrgPrflCode'
      @ObjectModel.text.association:'_RangeOfCvrgPrflCodeText'
      rwpro                                                                                   as     RangeOfCvrgPrflCode,
      shzet                                                                                   as     SafetyDuration,
      bstfe                                                                                   as     FixedLotSizeQuantity,
      losfx                                                                                   as     LotSizeIndependentCosts,
      lagpr                                                                                   as     IsStorageCosts,
      lgrad                                                                                   as     SrvcLvl,
      vrbdt                                                                                   as     CreationDate,
      loekz                                                                                   as     IsMarkedForDeletion,
      shpro                                                                                   as     PerdPrflForSftyTme,
      ahdis                                                                                   as     IsMRPDependentRqmt,
      pstat                                                                                   as     MaintenanceStatusName,
      shflg                                                                                   as     IsSafetyTime,
      plifz                                                                                   as     PlannedDeliveryDurationInDays,
      cast(plifzx as isplanneddeliverytime preserving type )                                  as     IsPlannedDeliveryTime,
      //takzt                                                      as     TaktTime,
      takzt                                                                                   as     RqmtQtyRcptTaktTmeInWrkgDays,
      // proc / ppds fields for MRP Area
      @ObjectModel.foreignKey.association: '_PPPlanningProcedure'
      scm_rrp_type                                                                            as     PPPlanningProcedure,
      @ObjectModel.foreignKey.association: '_ProdnPlngHeuristic'
      scm_heur_id                                                                             as     ProdnPlngHeuristic,

      scm_rrp_sel_group                                                                       as     ProductPlanningGroup,
      @ObjectModel.foreignKey.association: '_ProductPlanningPackage'
      scm_package_id                                                                          as     ProductPlanningPackage,

      //lot size fields
      @ObjectModel.foreignKey.association: '_LotSizeUnit'
      scm_lsuom                                                                               as     LotSizeUnit,
      cast (scm_target_dur as cmd_prd_target_dur_n preserving type )                          as     TargetDaysSupplyInWorkDays,
      cast (scm_reord_dur as cmd_prd_reord_dur_n preserving type )                            as     ReorderDaysSupplyInWorkDays,
      //   @ObjectModel.foreignKey.association: '_PlngCalendarPerdcLotSizing'
      scm_tstrid                                                                              as     PlngCalendarPerdcLotSizing,

      // GR/GI fields
      cast (scm_grprt as cmd_prd_good_rcpt_proc_time_n preserving type )                      as     LocProdGoodsReceiptProcHours,
      cast (scm_giprt as cmd_prd_good_issue_proc_time_n preserving type )                     as     LocProdGoodsIssueProcHours,
      scm_conhap                                                                              as     GRHandlingCapacityQuantity,
      @ObjectModel.foreignKey.association: '_GRHandlingCapacityUnit'
      scm_hunit                                                                               as     GRHandlingCapacityUnit,
      scm_conhap_out                                                                          as     GIHandlingCapacityQuantity,
      @ObjectModel.foreignKey.association: '_GIHandlingCapacityUnit'
      scm_hunit_out                                                                           as     GIHandlingCapacityUnit,
      
      //Missing Fields 200812
      vrbmt                                                                              as RefMatlConsumption,         
      vrbdb                                                                              as ReferenceMRPAreaConsumption,
      vrbfk                                                                              as Multiplier,                 
      kzkfk                                                                              as CorrectionFactors,          
      scm_target_dur                                                                     as TargetDaySupply,            
      scm_grprt                                                                          as GRProcessngTime,            
      scm_giprt                                                                          as GIProcessngTime,            

      _MRPType,
      _MRPTypeName,
      _MRPResponsible,
      _LotSizingProcedure,
      _PlantInvtryManagedLoc,
      _Product,
      _LotSizeUnit,
      _GRHandlingCapacityUnit,
      _GIHandlingCapacityUnit,
      _ProdnPlngHeuristic,
      _PPPlanningProcedure,
      _ProductPlanningPackage,
      _RangeOfCvrgPrflCode,
      _RangeOfCvrgPrflCodeText


}
