@AbapCatalog.sqlViewName: '/SIMPLE/IAVACAPI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'ValidityEndDate'
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Available Capacity Interval'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_AVAILABLECAPINTERVAL
  as select from kazy as kazy

//  association [1..1] to I_Capacity              as _Capacity              on $projection.CapacityInternalID = _Capacity.CapacityInternalID
//  association [1..1] to I_AvailableCapacityType as _AvailableCapacityType on $projection.AvailableCapacityType = _AvailableCapacityType.AvailableCapacityType
//  association [1..1] to I_CalendarDate          as _EndDate               on $projection.ValidityEndDate = _EndDate.CalendarDate
//  association [0..1] to I_WorkDayRule           as _WorkDayRule           on $projection.WorkDayRule = _WorkDayRule.WorkDayRule 
//  association [0..*] to I_ShiftSequence         as _ShiftSequence         on $projection.ShiftSequence = _ShiftSequence.ShiftSequence 
{
//      @ObjectModel.foreignKey.association: '_Capacity'
  key kazy.kapid as CapacityInternalID,
//      @ObjectModel.foreignKey.association: '_AvailableCapacityType'
  key kazy.versn as AvailableCapacityType,
  key kazy.datub as ValidityEndDate,

      // Attributes
      kazy.anzhl as CapacityNumberOfCapacities,
      kazy.anzsh as CapacityNumberOfShifts, 
      kazy.anztg as LengthOfCycle,
//      @ObjectModel.foreignKey.association: '_WorkDayRule'
      cast(kazy.fabtg as workdayrule preserving type) as WorkDayRule,
      kazy.sprog as ShiftSequence,
      cast(kazy.anztg as availablecapacityintervaldurn preserving type) as AvailableCapacityIntervalDurn,
      kazy.ngrad as CapacityPlanUtilizationPercent,
      kazy.kkopf as StdAvailableCapacityIsValid

//      // Associations
//      _Capacity,
//      _AvailableCapacityType,
//      _EndDate,
//      _WorkDayRule,
//      _ShiftSequence
};
