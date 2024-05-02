@AbapCatalog.sqlViewName: '/SIMPLE/PWCCAPIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM: {
  private: true,
  viewType: #COMPOSITE
}
@ClientHandling.algorithm: #SESSION_VARIABLE
//@EndUserText.label: 'Work Center Active Capacity Interval'

define view /SIMPLE/P_WRKCTRAVAILABLECAPIN as select from /SIMPLE/I_AVAILABLECAPINTERVAL as kazy_end

    left outer join /SIMPLE/I_AVAILABLECAPINTERVAL as kazy_begin on  kazy_end.CapacityInternalID = kazy_begin.CapacityInternalID
                                                              and kazy_end.ValidityEndDate    > kazy_begin.ValidityEndDate
                                                              and kazy_end.AvailableCapacityType = kazy_begin.AvailableCapacityType

{

  key   kazy_end.CapacityInternalID                as CapacityInternalID,
  key   kazy_end.AvailableCapacityType             as AvailableCapacityType,
  key   kazy_end.ValidityEndDate                   as ValidityEndDate,

        //      determines the begin date of all capacity intervals. The result could be null:
        //        --> this is handled in calling view, which falls back on '00.00.0000'.
        case when kazy_begin.CapacityInternalID is null
             then cast('00000000' as dats)
             else //max(kazy_begin.ValidityEndDate) 
             
      cast(dats_add_days(cast( max(kazy_begin.ValidityEndDate)  as datuv ) ,1,'NULL')   as datuv preserving type ) 
        end                                        as ValidityBeginDate,
       
      //cast(dats_add_days(cast( max(kazy_begin.ValidityEndDate)  AS datuv ) ,1,'FAIL')   as datuv preserving type )      as IntervalStartDate1,
        kazy_end.WorkDayRule,
        kazy_end.CapacityNumberOfCapacities,
        kazy_end.AvailableCapacityIntervalDurn,
        kazy_end.CapacityPlanUtilizationPercent,
        kazy_end.StdAvailableCapacityIsValid,
        kazy_end.ShiftSequence,
        kazy_end.CapacityNumberOfShifts,
        kazy_end.LengthOfCycle
}
group by
  kazy_end.CapacityInternalID,
  kazy_begin.CapacityInternalID,
  kazy_end.ValidityEndDate,
  kazy_end.AvailableCapacityType,
  kazy_end.WorkDayRule,
  kazy_end.CapacityNumberOfCapacities,
  kazy_end.AvailableCapacityIntervalDurn,
  kazy_end.CapacityPlanUtilizationPercent,
  kazy_end.StdAvailableCapacityIsValid,
  kazy_end.ShiftSequence,
  kazy_end.CapacityNumberOfShifts,
  kazy_end.LengthOfCycle
