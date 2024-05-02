@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCMEA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FlocMeasuringPoint'
define view /SIMPLE/C_FLOCMEASURING
  as select from imptt
    inner join   iflo on iflo.objnr = imptt.mpobj
  association to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation on $projection.functionalLocation = _FunctionalLocation.functionalLocation
{
  key imptt.point                    as measuringPoint,
      imptt.mpobj                    as objectNumMeasurePoint,
      imptt.psort                    as measurementPosition,
      imptt.psortr                   as refMeasPosition,
      imptt.pttxt                    as description,
      //      mlang                          as languageKey,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      cast( '' as abap.char( 2 ))    as languageKey,
      imptt.kzltx                    as longTextExists,
      imptt.mptyp                    as measPointCategory,
      imptt.irfmp                    as indicatorRefMeasPoint,
      imptt.erdat                    as createOn,
      imptt.ernam                    as createBy,
      imptt.aedat                    as changeOn,
      imptt.aenam                    as changeBy,
      imptt.begru                    as authorizGroup,
      imptt.inact                    as measPointInactive,
      imptt.lvorm                    as delFlag,
      cast( imptt.locas as abap.char( 40 ) )                    as assembly,
      imptt.refmp                    as referenceMeasPt,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      cast( '' as abap.char( 30 ))   as internalChar,
      imptt.atinnr                   as indicatorRefChar,
      imptt.expon                    as floatPointExp,
      imptt.decim                    as decimalsPlaces,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      imptt.desir                    as targetValue,
      imptt.desiri                   as indicatorContValueD,
      imptt.desirr                   as indicatorRefTargVal,
      imptt.dstxt                    as aditionalShortTxt,
      imptt.dstxtr                   as indicatorRefTxt,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      imptt.mrmin                    as lowerRangeLimit,
      imptt.mrmini                   as indicatorContValueMin,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      imptt.mrmax                    as upperRangeLimit,
      imptt.mrmaxi                   as indicatorContValueMax,
      imptt.mrngu                    as measRangeUnit,
      imptt.indct                    as measPointIsCounter,
      imptt.indrv                    as counterBackwards,
      imptt.indtr                    as transferSupported,
      imptt.trans                    as readingWasTransferred,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      imptt.cjump                    as countOverflwReadg,
      imptt.cjumpi                   as indicatorContValueC,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/FLOC_MEASURINGPOINT'
      imptt.pyear                    as annualEstimate,
      imptt.pyeari                   as indicatorContValueP,
      imptt.codct                    as catalogType,
      imptt.codgr                    as codeGroup,
      imptt.codgrr                   as refCodeGroup,
      imptt.cdsuf                    as valCodeSufficient,
      imptt.modtr                    as transferMode,
      imptt.indtrr                   as refTargetVal,
      imptt.logsys                   as logicalSystem,
      imptt.logsys_chg               as shortTime,

      cast( iflo.tplnr as /simple/tplnr preserving type )                 as functionalLocation,
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      _FunctionalLocation

}
