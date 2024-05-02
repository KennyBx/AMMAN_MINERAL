@AbapCatalog.sqlViewName: '/SIMPLE/IMPOINT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MeasuringPoint'
@ObjectModel.representativeKey: 'MeasuringPoint'

@Search.searchable: true
@VDM.viewType: #BASIC

@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M

define view /SIMPLE/I_MeasuringPoint
  as select from imptt
  association [0..1] to /SIMPLE/C_ClfnCharcBasicCsm as _Characteristic on $projection.MsrgPtInternalCharacteristic = _Characteristic.charcInternalID

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key point                                   as MeasuringPoint,
      mpobj                                   as MeasuringPointObjectIdentifier,
      psort                                   as MeasuringPointPositionNumber,
      mptyp                                   as MeasuringPointCategory,
      @Semantics.systemDate.createdAt: true
      erdat                                   as CreationDate,
      @Semantics.systemDate.lastChangedAt: true
      aedat                                   as LastChangeDate,
      begru                                   as AuthorizationGroup,
      inact                                   as MeasuringPointIsInactive,
      indct                                   as MeasuringPointIsCounter,
      lvorm                                   as MultiLevelDeletionLogicStatus,
      locas                                   as Assembly,
      refmp                                   as ReferenceMeasuringPoint,

      @ObjectModel.foreignKey.association: '_Characteristic'
      atinn                                   as MsrgPtInternalCharacteristic,
      _Characteristic.characteristic          as Characteristic,
      desir                                   as MeasuringPointTargetValue,
      //cast(desir as abap.dec(9, 2) )          as MeasuringPointTargetValue,
      expon                                   as MeasuringPointExponent,
      decim                                   as MeasuringPointDecimalPlaces,
      mrmin                                   as MeasuringPointMinimumThreshold,
      mrmax                                   as MeasuringPointMaximumThreshold,
      mrngu                                   as MeasurementRangeUnit,
      indrv                                   as MsrgPtIsCountingBackwards,
      trans                                   as MsmtRdngSourceMeasuringPoint,
      cjump                                   as CounterOverflowRdngThreshold,
      pyear                                   as MeasuringPointAnnualEstimate,
      codct                                   as MeasuringPointCatalogType,
      codgr                                   as MeasuringPointCodeGroup,
      cdsuf                                   as ValuationCodeIsSufficient,
      mlang                                   as Language,
      pttxt                                   as MeasuringPointDescription,
      dstxt                                   as MeasuringPointShortText,
      irfmp                                   as MeasuringPointIsReference,
      indtr                                   as MeasurementTransferIsSupported,
      modtr                                   as ModeOfCounterReadingTransfer,
      @Semantics.user.createdBy: true
      ernam                                   as CreatedByUser,
      @Semantics.user.lastChangedBy: true
      aenam                                   as LastChangedByUser,
      kzltx                                   as MeasuringPointHasLongText,
      cast(substring(mpobj, 1, 2) as j_obart) as MeasuringPointObjectType,
      cast( '' as abap.char( 10 ) )           as action,
      cast( '' as abap.char( 999 ) )          as mdgMarkForChange,

      /*Expose Association*/
      _Characteristic
};
