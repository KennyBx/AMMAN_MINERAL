@AbapCatalog.sqlViewName: '/SIMPLE/CMPOINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MeasuringPoint'
define root view /SIMPLE/C_MeasuringPoint as select from /SIMPLE/I_MeasuringPoint 
    association [1..1] to /SIMPLE/C_ControllingObject        as _ControllingObject               on    $projection.measuringPointObjectIdentifier = _ControllingObject.controllingObject 
    association [0..1] to /SIMPLE/C_MeasuringPointCat        as _MeasuringPointCategory          on    $projection.measuringPointCategory = _MeasuringPointCategory.measuringPointCategory
//    association [0..1] to /SIMPLE/C_Equipment                as _Equipment                       on    $projection.measuringPointObjectIdentifier = _Equipment.maintObjectInternalID
//    association [0..1] to /SIMPLE/C_FunctionalLocation       as _FunctionalLocation              on    $projection.measuringPointObjectIdentifier = _FunctionalLocation.maintObjectInternalID

{
    key MeasuringPoint                  as measuringPoint,  
    MeasuringPointObjectType            as measuringPointObjectType,
    
    @ObjectModel.foreignKey.association: '_ControllingObject'
    MeasuringPointObjectIdentifier      as measuringPointObjectIdentifier,
    MeasuringPointPositionNumber        as measuringPointPositionNumber,
    
    @ObjectModel.foreignKey.association: '_MeasuringPointCategory'
    MeasuringPointCategory              as measuringPointCategory,
    
//    @ObjectModel.readOnly: true
    @ObjectModel.virtualElement : true
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/MPOI_FIELDCONVERSION'
    cast( '' as abap.char( 18 ) )       as equipment,
    
//    @ObjectModel.readOnly: true
    @ObjectModel.virtualElement : true
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/MPOI_FIELDCONVERSION'
    cast( '' as abap.char( 30 ) )       as functionalLocation,
    
    MeasuringPointDescription           as measuringPointDescription,
    CreationDate                        as creationDate,
    LastChangeDate                      as lastChangeDate,
    AuthorizationGroup                  as authorizationGroup,
    MeasuringPointIsInactive            as measuringPointIsInactive,
    
    --IEQ_IDNCT_X
    MeasuringPointIsCounter             as measuringPointIsCounter,
    CounterOverflowRdngThreshold        as counterOverflowRdngThreshold,
    MeasuringPointAnnualEstimate        as measuringPointAnnualEstimate,
    Characteristic                      as characteristic,
    cast( MsrgPtInternalCharacteristic as /simple/atinn preserving type )        as msrgPtInternalCharacteristic,
    
    --IEQ_IDNCT_Blank
    MeasuringPointTargetValue           as measuringPointTargetValue,
    MeasuringPointMinimumThreshold      as measuringPointMinimumThreshold,
    MeasuringPointMaximumThreshold      as measuringPointMaximumThreshold,
    MeasurementRangeUnit                as measurementRangeUnit,
    
    MeasuringPointExponent              as measuringPointExponent,
    MeasuringPointDecimalPlaces         as measuringPointDecimalPlaces,
    MultiLevelDeletionLogicStatus       as multiLevelDeletionLogicStatus,
    Assembly                            as assembly,
    ReferenceMeasuringPoint             as referenceMeasuringPoint,
    MsrgPtIsCountingBackwards           as msrgPtIsCountingBackwards,
    MsmtRdngSourceMeasuringPoint        as msmtRdngSourceMeasuringPoint,
    MeasuringPointCatalogType           as measuringPointCatalogType,
    MeasuringPointCodeGroup             as measuringPointCodeGroup,
    ValuationCodeIsSufficient           as valuationCodeIsSufficient,
    Language                            as language,
    MeasuringPointShortText             as measuringPointShortText,
    MeasuringPointIsReference           as measuringPointIsReference,
    MeasurementTransferIsSupported      as measurementTransferIsSupported,
    ModeOfCounterReadingTransfer        as modeOfCounterReadingTransfer,
    CreatedByUser                       as createdByUser,
    LastChangedByUser                   as lastChangedByUser,
    MeasuringPointHasLongText           as measuringPointHasLongText,
    
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 50 ) )       as action,
      cast( '' as abap.char( 1333 ) )     as mdgMarkForChange,
      cast( '' as abap.char( 36 ) )       as mdgLogID,
      cast( '' as abap.char( 50 ) )       as actionMode,
      cast( '' as abap.char( 20 ) )       as activateID,
      cast( '' as abap.char( 20 ) )       as activateItemID,
      cast( '' as abap.char( 100 ) )      as crNumber,
      cast( '' as abap.char( 100 ) )      as crItem,

    _ControllingObject,
    _MeasuringPointCategory,
    _Characteristic
//    _Equipment,
//    _FunctionalLocation


} where MeasuringPointObjectType = 'IE' or
        MeasuringPointObjectType = 'IF';
