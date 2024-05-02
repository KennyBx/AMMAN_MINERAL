@AbapCatalog.sqlViewName: '/SIMPLE/IWRKCCI2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Work Center Capacity Intervals 2'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #XL, dataClass: #MIXED}
@VDM.viewType: #COMPOSITE
define view /SIMPLE/I_WorkCenterCapIn_2
  as select from /simple/pwccapin
  association [1..1] to /SIMPLE/I_Capacity              as _Capacity              on $projection.CapacityInternalID = _Capacity.CapacityInternalID
  association [1..1] to I_AvailableCapacityType as _AvailableCapacityType on $projection.CapacityActiveVersion = _AvailableCapacityType.AvailableCapacityType
  association [0..1] to I_WorkDayRule           as _WorkDayRule           on $projection.WorkDayRule = _WorkDayRule.WorkDayRule
{
  key capacityinternalid                                                              as CapacityInternalID,
  key availablecapacitytype                                                           as CapacityActiveVersion,
  key validityenddate                                                                 as IntervalEndDate,
     
       //case when validitybegindate is null
       //      then validitybegindate
             //when validitybegindate is not null
             //then dats_add_days(validitybegindate,1, '')
        //     else cast(dats_add_days(validitybegindate,1,'NULL')   as datuv preserving type ) 
             
       //end                                        as IntervalStartDate1,
         
      validitybegindate  as  IntervalStartDate,
      //cast(dats_add_days(validitybegindate,1,'FAIL')   as datuv preserving type )      as IntervalStartDate1,

      stdavailablecapacityisvalid                                                      as StdavailableCapacityIsValid,

      shiftsequence                                                                    as ShiftSequence,

      workdayrule                                                                      as WorkDayRule,

      capacitynumberofshifts                                                           as CapacityNumberOfShifts,

      lengthofcycle                                                                    as LengthOfCycle,
      
      case when availablecapacityintervaldurn is initial
      then '01'
      else
      availablecapacityintervaldurn
      end                                                                             as AvailableCapacityIntervalDurn,

      case
      when stdavailablecapacityisvalid is initial
      then
      cast(capacitynumberofcapacities as kapanzahl preserving type)
      else
      cast(_Capacity.CapacityNumberOfCapacities as kapanzahl preserving type)
      end                                                                             as CapacityNumberOfCapacities,

      case
      when stdavailablecapacityisvalid is initial
      then
      capacityplanutilizationpercent
      else
       _Capacity.CapacityPlanUtilizationPercent
      end                                                                             as CapacityPlanUtilizationPercent,

      _Capacity,
      _AvailableCapacityType,
      _WorkDayRule
}
