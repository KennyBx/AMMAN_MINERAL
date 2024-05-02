@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductSupplyPlanning'
define view /SIMPLE/C_PrdSupplyPlanning
  as select from /SIMPLE/I_PrdSupplyPlanning 
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{

  key Product                        as product,
  key Plant                          as plant,
      FixedLotSizeQuantity           as fixedLotSizeQuantity,
      MaximumLotSizeQuantity         as maximumLotSizeQuantity,
      MinimumLotSizeQuantity         as minimumLotSizeQuantity,
      LotSizeRoundingQuantity        as lotSizeRoundingQuantity,
      LotSizingProcedure             as lotSizingProcedure,
      MRPType                        as mrpType,
      MRPResponsible                 as mrpResponsible,
      SafetyStockQuantity            as safetyStockQuantity,
      MinimumSafetyStockQuantity     as minimumSafetyStockQuantity,
      PlanningTimeFence              as planningTimeFence,
      ABCIndicator                   as abcIndicator,
      MaximumStockQuantity           as maximumStockQuantity,
      ReorderThresholdQuantity       as reorderThresholdQuantity,
      PlannedDeliveryDurationInDays  as plannedDeliveryDurationInDays,
      SafetyDuration                 as safetyDuration,
      PlanningStrategyGroup          as planningStrategyGroup,
      TotalReplenishmentLeadTime     as totalReplenishmentLeadTime,
      ProcurementType                as procurementType,
      ProcurementSubType             as procurementSubType,
      AssemblyScrapPercent           as assemblyScrapPercent,
      AvailabilityCheckType          as availabilityCheckType,
      GoodsReceiptDuration           as goodsReceiptDuration,
      MRPGroup                       as mrpGroup,
      PlanAndOrderDayDetermination   as planAndOrderDayDetermination,
      RoundingProfile                as roundingProfile,
      DfltStorageLocationExtProcmt   as dfltStorageLocationExtProcmt,
      StorageCostsPercentageCode     as storageCostsPercentageCode,
      RqmtQtyRcptTaktTmeInWrkgDays   as rqmtQtyRcptTaktTmeInWrkgDays,
      MatlCompIsMarkedForBackflush   as matlCompIsMarkedForBackflush,
      ProposedProductSupplyArea      as proposedProductSupplyArea,
      IsBulkMaterialComponent        as isBulkMaterialComponent,
      InHouseProductionTime          as inHouseProductionTime,
      ProdnPlngAndControlCalendar    as prodnPlngAndControlCalendar,
      SchedulingMarginKey            as schedulingMarginKey,
      SrvcLvl                        as srvcLvl,
      RangeOfCvrgPrflCode            as rangeOfCvrgPrflCode,
      IsSafetyTime                   as isSafetyTime,
      PerdPrflForSftyTme             as perdPrflForSftyTme,
      ForecastRequirementsAreSplit   as forecastRequirementsAreSplit,
      ProdRqmtsConsumptionMode       as prodRqmtsConsumptionMode,
      BackwardCnsmpnPeriodInWorkDays as backwardCnsmpnPeriodInWorkDays,
      FwdConsumptionPeriodInWorkDays as fwdConsumptionPeriodInWorkDays,
      MRPAvailabilityType            as mrpAvailabilityType,
      ProductIsForCrossProject       as productIsForCrossProject,
      DependentRequirementsType      as dependentRequirementsType,
      ComponentScrapInPercent        as componentScrapInPercent,
      ProdRqmtsAreConsolidated       as prodRqmtsAreConsolidated,
      IsMRPDependentRqmt             as isMRPDependentRqmt,
      ProductIsToBeDiscontinued      as productIsToBeDiscontinued,
      EffectiveOutDate               as effectiveOutDate,
      FollowUpProduct                as followUpProduct,
      RepetitiveManufacturingIsAllwd as repetitiveManufacturingIsAllwd,
      RepetitiveManufacturingProfile as repetitiveManufacturingProfile,


      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
