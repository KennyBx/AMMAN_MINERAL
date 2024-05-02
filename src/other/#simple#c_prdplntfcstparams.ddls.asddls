@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPFP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProdPlntFcstParam'
define view /SIMPLE/C_PrdPlntFcstParams 
  as select from /SIMPLE/I_ProdPlntFcstParams as ForecastParameters
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product,
  key Plant                          as plant,
      ProdPlntFcstParametersPointer  as prodPlntFcstParametersPointer,
      ProdPlntFcstProfile            as prodPlntFcstProfile,
      ProdPlntFcstBscValAlphaFactor  as prodPlntFcstBscValAlphaFactor,
      ProdPlntNumberOfForecastPeriod as prodPlntNumberOfForecastPeriod,
      ProdPlntFcstTrendValBetaFactor as prodPlntFcstTrendValBetaFactor,
      ProdPlntMeanAbsltDvtnDeltaFctr as prodPlntMeanAbsltDvtnDeltaFctr,
      ProdPlntFcstNmbrOfFixedPeriod  as prodPlntFcstNmbrOfFixedPeriod,
      ProdPlntFcstSeasnlIdxGammaFctr as prodPlntFcstSeasnlIdxGammaFctr,
      ProdPlntFcstEpsilonFctr        as prodPlntFcstEpsilonFctr,
      ProdPlntFcstWeightingGroup     as prodPlntFcstWeightingGroup,
      FcstModelInitializationMethod  as fcstModelInitializationMethod,
      ProdPlntFcstParamIsOptimized   as prodPlntFcstParamIsOptimized,
      ProdPlntFcstModSelProcedure    as prodPlntFcstModSelProcedure,
      ProdPlntFcstModSelMethod       as prodPlntFcstModSelMethod,
      OptimizationLevel              as optimizationLevel,
      HistlPeriodCountForForecast    as histlPeriodCountForForecast,
      PerdsCntForFcstInitialization  as perdsCntForFcstInitialization,
      FcstPerdCntPerSeasnCyc         as fcstPerdCntPerSeasnCyc,
      DateOfLastForecast             as dateOfLastForecast,
      PerdsCntForExPostForecast      as perdsCntForExPostForecast,
      ForecastModel                  as forecastModel,
      ForecastValueTrackingLimit     as forecastValueTrackingLimit,
      BasicValue                     as basicValue,
      BasicValueOf2ndOrder1          as basicValueOf2ndOrder1,
      BasicValueOf2ndOrder2          as basicValueOf2ndOrder2,
      BasicValuePrev                 as basicValuePrev,
      BasicValueOf2ndOrderPrev1      as basicValueOf2ndOrderPrev1,
      BasicValueOf2ndOrderPrev2      as basicValueOf2ndOrderPrev2,
      TrendValue                     as trendValue,
      TrendValuePrev                 as trendValuePrev,
      MeanAbsoluteDeviation          as meanAbsoluteDeviation,
      MeanAbsoluteDeviationPrev      as meanAbsoluteDeviationPrev,
      ErrorTotal                     as errorTotal,
      ErrorTotalPrev                 as errorTotalPrev,
      WeightingGroup                 as weightingGroup,
      TheilCoefficient               as theilCoefficient,
      ExceptionMessageBar            as exceptionMessageBar,
      ForecastFlowControl            as forecastFlowControl,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
