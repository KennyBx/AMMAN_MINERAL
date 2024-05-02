@AbapCatalog.sqlViewName: '/SIMPLE/IPRDPFCP'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Plant Forecast Parameters'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProdPlntFcstParams
  as select from mapr as material_index
    inner join   prop as forecast_parameters on material_index.pnum1 = forecast_parameters.pnum1

  association [1..1] to I_Product                  as _Product                       on  $projection.Product = _Product.Product
  association [1..1] to I_ProductPlant             as _Plant                         on  $projection.Product = _Plant.Product
                                                                                     and $projection.Plant   = _Plant.Plant

  association [0..1] to I_ProductForecastModel     as _ProductForecastModel          on  $projection.ForecastModel = _ProductForecastModel.ForecastModel
  association [0..1] to I_ProductForecastModelText as _ProductForecastModelText      on  $projection.ForecastModel          = _ProductForecastModelText.ForecastModel
                                                                                     and _ProductForecastModelText.Language = $session.system_language

  association [0..1] to I_ProdPlntFcstWeightingGrp as _ProdPlntFcstWeightingGrp      on  $projection.ProdPlntFcstWeightingGroup = _ProdPlntFcstWeightingGrp.ProdPlntFcstWeightingGroup

  association [0..1] to I_ProdFcstInitializeMeth   as _ProductFcstInitializeMeth     on  $projection.FcstModelInitializationMethod = _ProductFcstInitializeMeth.FcstModelInitializationMethod
  association [0..1] to I_ProdFcstInitializeMethT  as _ProductFcstInitializeMethText on  $projection.FcstModelInitializationMethod = _ProductFcstInitializeMethText.FcstModelInitializationMethod
                                                                                     and _ProductFcstInitializeMethText.Language   = $session.system_language

  association [0..1] to I_ProdPlntFcstSelProced    as _ProdPlntFcstSelProced         on  $projection.ProdPlntFcstModSelProcedure = _ProdPlntFcstSelProced.ProdPlntFcstModSelProcedure
  association [0..1] to I_ProdPlntFcstSelProcedTxt as _ProdPlntFcstSelProcedTxt      on  $projection.ProdPlntFcstModSelProcedure = _ProdPlntFcstSelProcedTxt.ProdPlntFcstModSelProcedure
                                                                                     and _ProdPlntFcstSelProcedTxt.Language      = $session.system_language

  association [0..1] to I_ProdPlntFcstModSelMeth   as _ProdPlntFcstModSelMeth        on  $projection.ProdPlntFcstModSelMethod = _ProdPlntFcstModSelMeth.ProdPlntFcstModSelMethod
  association [0..1] to I_ProdPlntFcstModSelMethT  as _ProdPlntFcstModSelMethText    on  $projection.ProdPlntFcstModSelMethod = _ProdPlntFcstModSelMethText.ProdPlntFcstModSelMethod
                                                                                     and _ProdPlntFcstModSelMethText.Language = $session.system_language

  association [0..1] to I_ProdFcstOptimizationLvl  as _ProdFcstOptimizationLvl       on  $projection.OptimizationLevel = _ProdFcstOptimizationLvl.OptimizationLevel
  association [0..1] to I_ProdFcstOptimizationLvlT as _ProdFcstOptimizationLvlText   on  $projection.OptimizationLevel         = _ProdFcstOptimizationLvlText.OptimizationLevel
                                                                                     and _ProdFcstOptimizationLvlText.Language = $session.system_language

{
      @ObjectModel.foreignKey.association: '_Product'
  key material_index.matnr      as Product,
      @ObjectModel.foreignKey.association: '_Plant'
  key material_index.werks      as Plant,
      forecast_parameters.pnum1 as ProdPlntFcstParametersPointer,
      //  key forecast_parameters.hsnum  as ProdPlntFcstParametersVersHist,
      //  key forecast_parameters.versp  as ProdPlntFcstParametersVersNmbr,
      // non keys

      forecast_parameters.propr as ProdPlntFcstProfile,
      forecast_parameters.alpha as ProdPlntFcstBscValAlphaFactor,
      forecast_parameters.anzpr as ProdPlntNumberOfForecastPeriod,
      forecast_parameters.beta1 as ProdPlntFcstTrendValBetaFactor,
      forecast_parameters.delta as ProdPlntMeanAbsltDvtnDeltaFctr,
      forecast_parameters.fimon as ProdPlntFcstNmbrOfFixedPeriod,
      forecast_parameters.gamma as ProdPlntFcstSeasnlIdxGammaFctr,
      forecast_parameters.epsil as ProdPlntFcstEpsilonFctr,

      @ObjectModel.foreignKey.association: '_ProdPlntFcstWeightingGrp'
      forecast_parameters.gewgr as ProdPlntFcstWeightingGroup,

      @ObjectModel:{
      foreignKey.association: '_ProductFcstInitializeMeth',
      text.association: '_ProductFcstInitializeMethText'
      }
      forecast_parameters.kzini as FcstModelInitializationMethod,

      forecast_parameters.kzpar as ProdPlntFcstParamIsOptimized,

      @ObjectModel:{
      foreignKey.association: '_ProdPlntFcstSelProced',
      text.association: '_ProdPlntFcstSelProcedTxt'
      }
      forecast_parameters.modav as ProdPlntFcstModSelProcedure,

      @ObjectModel:{
      foreignKey.association: '_ProdPlntFcstModSelMeth',
      text.association: '_ProdPlntFcstModSelMethText'
      }
      forecast_parameters.modaw as ProdPlntFcstModSelMethod,

      @ObjectModel:{
      foreignKey.association: '_ProdFcstOptimizationLvl',
      text.association: '_ProdFcstOptimizationLvlText'
      }
      forecast_parameters.opgra as OptimizationLevel,
      forecast_parameters.peran as HistlPeriodCountForForecast,
      forecast_parameters.perin as PerdsCntForFcstInitialization,
      forecast_parameters.perio as FcstPerdCntPerSeasnCyc,
      forecast_parameters.prdat as DateOfLastForecast,
      forecast_parameters.perex as PerdsCntForExPostForecast,

      @ObjectModel:{
      foreignKey.association: '_ProductForecastModel',
      text.association: '_ProductForecastModelText'
      }
      forecast_parameters.prmod as ForecastModel,
      forecast_parameters.siggr as ForecastValueTrackingLimit,
      forecast_parameters.gwert as BasicValue,
      forecast_parameters.gwer1 as BasicValueOf2ndOrder1,
      forecast_parameters.gwer2 as BasicValueOf2ndOrder2,
      forecast_parameters.vmgwe as BasicValuePrev,
      forecast_parameters.vmgw1 as BasicValueOf2ndOrderPrev1,
      forecast_parameters.vmgw2 as BasicValueOf2ndOrderPrev2,
      forecast_parameters.twert as TrendValue,
      forecast_parameters.vmtwe as TrendValuePrev,
      forecast_parameters.prmad as MeanAbsoluteDeviation,
      forecast_parameters.vmmad as MeanAbsoluteDeviationPrev,
      forecast_parameters.fsumm as ErrorTotal,
      forecast_parameters.vmfsu as ErrorTotalPrev,
      forecast_parameters.gewgr as WeightingGroup,
      forecast_parameters.thkof as TheilCoefficient,
      forecast_parameters.ausna as ExceptionMessageBar,
      forecast_parameters.proab as ForecastFlowControl,

      //forecast_parameters.PERKZ as PeriodIndicator,

      _ProductForecastModel,
      _ProductForecastModelText,
      _ProdPlntFcstWeightingGrp,
      _ProductFcstInitializeMeth,
      _ProductFcstInitializeMethText,
      _ProdPlntFcstSelProced,
      _ProdPlntFcstSelProcedTxt,
      _ProdPlntFcstModSelMeth,
      _ProdPlntFcstModSelMethText,
      _ProdFcstOptimizationLvl,
      _ProdFcstOptimizationLvlText,
      _Product,
      _Plant

}
where
      forecast_parameters.hsnum = '00'
  and forecast_parameters.versp = '00'
