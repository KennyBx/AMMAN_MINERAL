@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPMRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantMRPArea'
define view /SIMPLE/C_PrdPlantMRPArea 
  as select from /SIMPLE/I_ProductPlantMRP
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                                                                   as product,
  key Plant                                                                     as plant,
  key MRPArea                                                                   as mrpArea,
      MRPType                                                                   as mrpType,
      MRPResponsible                                                            as mrpResponsible,
      MRPGroup                                                                  as mrpGroup,
      ReorderThresholdQuantity                                                  as reorderThresholdQuantity,
      PlanningTimeFence                                                         as planningTimeFence,
      LotSizingProcedure                                                        as lotSizingProcedure,
      LotSizeRoundingQuantity                                                   as lotSizeRoundingQuantity,
      MinimumLotSizeQuantity                                                    as minimumLotSizeQuantity,
      MaximumLotSizeQuantity                                                    as maximumLotSizeQuantity,
      MaximumStockQuantity                                                      as maximumStockQuantity,
      AssemblyScrapPercent                                                      as assemblyScrapPercent,
      ProcurementSubType                                                        as procurementSubType,
      DfltStorageLocationExtProcmt                                              as dfltStorageLocationExtProcmt,
      MRPPlanningCalendar                                                       as mrpPlanningCalendar,
      SafetyStockQuantity                                                       as safetyStockQuantity,
      RangeOfCvrgPrflCode                                                       as rangeOfCvrgPrflCode,
      SafetyDuration                                                            as safetyDuration,
      FixedLotSizeQuantity                                                      as fixedLotSizeQuantity,
      LotSizeIndependentCosts                                                   as lotSizeIndependentCosts,
      IsStorageCosts                                                            as isStorageCosts,
      RqmtQtyRcptTaktTmeInWrkgDays                                              as rqmtQtyRcptTaktTmeInWrkgDays,
      SrvcLvl                                                                   as srvcLvl,
      IsMarkedForDeletion                                                       as isMarkedForDeletion,
      PerdPrflForSftyTme                                                        as perdPrflForSftyTme,
      IsMRPDependentRqmt                                                        as isMRPDependentRqmt,
      IsSafetyTime                                                              as isSafetyTime,
      PlannedDeliveryDurationInDays                                             as plannedDeliveryDurationInDays,
      IsPlannedDeliveryTime                                                     as isPlannedDeliveryTime,
      PPPlanningProcedure                                                       as ppPlanningProcedure,
      ProdnPlngHeuristic                                                        as prodnPlngHeuristic,
      ProductPlanningGroup                                                      as productPlanningGroup,
      ProductPlanningPackage                                                    as productPlanningPackage,
      LotSizeUnit                                                               as lotSizeUnit,
      PlngCalendarPerdcLotSizing                                                as plngCalendarPerdcLotSizing,
      GRHandlingCapacityUnit                                                    as grHandlingCapacityUnit,
      GIHandlingCapacityUnit                                                    as giHandlingCapacityUnit,
      RefMatlConsumption                                                        as refMatlConsumption,
      ReferenceMRPAreaConsumption                                               as referenceMRPAreaConsumption,
      Multiplier                                                                as multiplier,
      CorrectionFactors                                                         as correctionFactors,

      cast (TargetDaySupply as cmd_prd_target_dur_n preserving type )           as targetDaySupply,
      cast (GRProcessngTime as cmd_prd_good_rcpt_proc_time_n preserving type )  as grProcessngTime,
      cast (GIProcessngTime as cmd_prd_good_issue_proc_time_n preserving type ) as giProcessngTime,
      CreationDate                                                              as creationDate,
      GRHandlingCapacityQuantity                                                as grHandlingCapacityQuantity,
      GIHandlingCapacityQuantity                                                as giHandlingCapacityQuantity,
      StorageLocation                                                           as storageLocation,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )                                             as action,
      cast( '' as abap.char( 999 ) )                                            as mdgMarkForChange,

      /* Associations */
      _Plant
}
