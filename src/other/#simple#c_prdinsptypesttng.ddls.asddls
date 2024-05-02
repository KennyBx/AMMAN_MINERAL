@AbapCatalog.sqlViewName: '/SIMPLE/CPRDITS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'InspTypeSttng'
define view /SIMPLE/C_PrdInspTypeSttng 
  as select from /SIMPLE/I_ProductInspTypeSttng as InspTypeSttng
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key InspectionLotType              as inspectionLotType,
  key Product                        as product,
  key Plant                          as plant,
      InspLotIsTaskListRequired      as inspLotIsTaskListRequired,
      InspLotHasMaterialSpec         as inspLotHasMaterialSpec,
      InspLotHasConfignSpecification as inspLotHasConfignSpecification,
      InspLotHasBatchCharc           as inspLotHasBatchCharc,
      InspLotHasAutomSpecAssgmt      as inspLotHasAutomSpecAssgmt,
      InspLotHasCharc                as inspLotHasCharc,
      HasPostToInspectionStock       as hasPostToInspectionStock,
      InspLotIsAutomUsgeDcsnPossible as inspLotIsAutomUsgeDcsnPossible,
      SamplingProcedure              as samplingProcedure,
      InspLotDynamicRule             as inspLotDynamicRule,
      InspLotSampleQuantityInPercent as inspLotSampleQuantityInPercent,
      InspectionLotIsFullInspection  as inspectionLotIsFullInspection,
      InspLotSkipIsAllowed           as inspLotSkipIsAllowed,
      InspLotHasManualSampleSize     as inspLotHasManualSampleSize,
      InspLotIsSmplCalcMnlTriggered  as inspLotIsSmplCalcMnlTriggered,
      InspLotIsSerialNmbrPossible    as inspLotIsSerialNmbrPossible,
      InspLotDurationInDays          as inspLotDurationInDays,
      InspLotSummaryControl          as inspLotSummaryControl,
      InspQualityScoreProcedure      as inspQualityScoreProcedure,
      InspLotAcceptedScrapRatioInPct as inspLotAcceptedScrapRatioInPct,
      InspectionLotHasAppraisalCosts as inspectionLotHasAppraisalCosts,
      QualityCostCollector           as qualityCostCollector,
      ProdInspTypeSettingIsActive    as prodInspTypeSettingIsActive,
      InspTypeIsPrfrd                as inspTypeIsPrfrd,
      InspLotHasHandlingUnit         as inspLotHasHandlingUnit,
      InspLotHasMultipleSpec         as inspLotHasMultipleSpec,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
