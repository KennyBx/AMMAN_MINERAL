@AbapCatalog.sqlViewName: '/SIMPLE/IPINTPST' 
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Settings for inspection type in product'
@VDM: {
    viewType: #BASIC,
    lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_ProductInspTypeSttng
  as select from qmat 
  
    association [1..1] to I_InspectionLotType as _InspectionLotType   on  $projection.InspectionLotType = _InspectionLotType.InspectionLotType
    association [1..1] to I_Product           as _Product             on  $projection.Product = _Product.Product
    association [1..1] to I_Plant             as _Plant               on  $projection.Plant = _Plant.Plant
  
{
  key art   as InspectionLotType, //old:ProductInspectionType
  key matnr as Product,
  key werks as Plant,
      ppl as InspLotIsTaskListRequired,
      spezueber as InspLotHasMaterialSpec,
      conf as InspLotHasConfignSpecification,
      tls  as InspLotHasBatchCharc,//new, old:IsProdInspSpecBatchDetermined,
      app as InspLotHasAutomSpecAssgmt, //new,old: ProdInspHasAutomSpecAssgmt,
      mer as InspLotHasCharc, //new,old:IsProdInspByCharacteristics,
      insmk as HasPostToInspectionStock,
      ave as InspLotIsAutomUsgeDcsnPossible,
      stichprver as SamplingProcedure,
      dynregel as InspLotDynamicRule,
      sproz as InspLotSampleQuantityInPercent, // old:ProductInspectionPercentage,
      hpz as InspectionLotIsFullInspection,
      dyn as InspLotSkipIsAllowed, //new, old:IsProductInspectionSkipAllowed,
      mpb as InspLotHasManualSampleSize, //old: IsProdInspSmplEnteredManually,
      mst as InspLotIsSmplCalcMnlTriggered,
      ein as InspLotIsSerialNmbrPossible,
      mpdau as InspLotDurationInDays,  //new, old:ProdAverageInspectionDuration,
      chg as InspLotSummaryControl, //new, old: CtrlProdInspectionLotCreation,
      qkzverf as InspQualityScoreProcedure,
      qpmat as InspLotAcceptedScrapRatioInPct, //new, old ProdInspLotAllwdShrOfScrapPct,
      kzprfkost as InspectionLotHasAppraisalCosts,
      aufnr_co as QualityCostCollector,
      aktiv as ProdInspTypeSettingIsActive, //new, old: ProdInspTypeMatlCombnIsActive,
      apa as InspTypeIsPrfrd, //new, old: IsPrfrdProductInspectionType,
      afr as InspLotHasHandlingUnit, //new, old: ProdInspLotIsForHandlingUnit,
//MMA
//FEH
//PRFRQ
//NKMPR
     ms_flag as InspLotHasMultipleSpec, //new, old: ProdInspTypeHasMltplSpec,
//CHG_ORIG_17  
  
  //Association
  _InspectionLotType,
  _Product,
  _Plant
}
