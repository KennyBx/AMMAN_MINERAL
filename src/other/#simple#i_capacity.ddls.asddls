@AbapCatalog.sqlViewName: '/SIMPLE/ICAPAPT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
// BEN @ObjectModel.representativeKey: 'CapacityInternalID'
// BEN @ObjectModel.semanticKey: 'Capacity'
// BEN @ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Capacity Header'
@Analytics.dataExtraction.enabled: true

define view /SIMPLE/I_Capacity
  as select from kako as kako
  //  association [1..1] to /SIMPLE/I_Plant               as _Plant                      on  $projection.Plant = _Plant.Plant
  //  association [0..*] to /SIMPLE/I_CapacityText        as _Text                       on  $projection.CapacityInternalID = _Text.CapacityInternalID
  //  association [1..1] to /SIMPLE/I_CapacityCategory    as _CapacityCategory           on  $projection.CapacityCategoryCode = _CapacityCategory.CapacityCategoryCode
  //  association [0..1] to /SIMPLE/I_CapacityRespPlanner as _CapacityResponsiblePlanner on  $projection.CapacityResponsiblePlanner = _CapacityResponsiblePlanner.CapacityResponsiblePlanner
  //  association [0..1] to /SIMPLE/I_FactoryCalendar     as _FactoryCalendar            on  $projection.FactoryCalendar = _FactoryCalendar.FactoryCalendar
  //  association [0..1] to /SIMPLE/I_ShiftGrouping       as _ShiftGrouping              on  $projection.ShiftGroup = _ShiftGrouping.ShiftGrouping
  //  association [0..1] to /SIMPLE/I_UnitOfMeasure       as _CapacityQuantityUnit       on  $projection.CapacityQuantityUnit = _CapacityQuantityUnit.UnitOfMeasure
  //  association [0..1] to /SIMPLE/I_UnitOfMeasure       as _CapacityBaseQtyUnit        on  $projection.CapacityBaseQtyUnit = _CapacityBaseQtyUnit.UnitOfMeasure
  //  association [0..1] to /SIMPLE/I_Capacity            as _Capacity                   on  $projection.ReferencedCapacityInternalID = _Capacity.CapacityInternalID
  association [0..1] to /SIMPLE/I_CapacityText as _TextSysLanguage on  $projection.CapacityInternalID = _TextSysLanguage.CapacityInternalID
                                                                   and _TextSysLanguage.Language      = $session.system_language
    association [0..1] to /SIMPLE/I_CapacityText        as _TextENLanguage             on  $projection.CapacityInternalID = _TextENLanguage.CapacityInternalID
                                                                                       and _TextENLanguage.Language       = 'E'
    association [1..*] to /SIMPLE/I_WorkCenterCapacity  as _MainCapacity               on  $projection.CapacityInternalID = _MainCapacity.CapacityInternalID
{
      //      // BEN @ObjectModel.text.association: '_Text'
      // Key
  key kako.kapid                                      as CapacityInternalID,

      // Attributes
      kako.name                                       as Capacity,
      // BEN @ObjectModel.foreignKey.association: '_CapacityCategory'
      cast(kako.kapar as pph_kapart preserving type)  as CapacityCategoryCode,
      kako.versa                                      as CapacityActiveVersion,
      kako.kapter                                     as CapacityIsFinite,
      kako.poolk                                      as CapacityIsPooled,
      kako.mehr                                       as CapacityHasIndivCapacities,
      kako.kaplpl                                     as CapacityIsExcldFrmLongTermPlng,
      kako.aznor                                      as CapacityNumberOfCapacities,
      // BEN @ObjectModel.foreignKey.association: '_CapacityResponsiblePlanner'
      kako.planr                                      as CapacityResponsiblePlanner,
      kako.ngrad                                      as CapacityPlanUtilizationPercent,
      kako.pause                                      as CapacityBreakDuration,
      kako.pause                                      as CapacityBreakDurationSeconds,
      cast(kako.kapavo  as pph_kzavo preserving type) as CapIsUsedInMultiOperations,
      // BEN @ObjectModel.text.association: '_Text'
      // BEN @ObjectModel.foreignKey.association: '_Capacity'
      cast(kako.refid  as pph_refid preserving type)  as ReferencedCapacityInternalID,
      kako.ueberlast                                  as CapOverloadThresholdInPercent,

      // Assignments
      // BEN @ObjectModel.foreignKey.association: '_Plant'
      kako.werks                                      as Plant,
      // BEN @ObjectModel.foreignKey.association: '_FactoryCalendar'
      kako.kalid                                      as FactoryCalendar,
      --    // BEN @ObjectModel.foreignKey.association: '_AuthorizationGroup'
      kako.brgru                                      as AuthorizationGroup,
      // BEN @ObjectModel.foreignKey.association: '_ShiftGrouping'
      kako.mosid                                      as ShiftGroup,

      // Times (internal in seconds)
      kako.begzt                                      as CapacityStartTime,
      kako.endzt                                      as CapacityEndTime,
      kako.begzt                                      as CapacityStartTimeSeconds,
      kako.endzt                                      as CapacityEndTimeSeconds,


      // Unit of Measures
      @Semantics.unitOfMeasure: true
      kako.kapeh                                      as CapacityQuantityUnit,
      @Semantics.unitOfMeasure: true
      kako.meins                                      as CapacityBaseQtyUnit,

      @Semantics.systemDateTime.lastChangedAt: true
      case when kako.lastchange_datetime = 0 or kako.lastchange_datetime is null then
           cast('20190101120000' as kap_lastchange_datetime)
      else kako.lastchange_datetime end               as CapacityLastChangeDateTime,

      //Missing field
      //24/05/2021
      case when _TextSysLanguage.CapacityText is not initial
      then _TextSysLanguage.CapacityText
      else _TextENLanguage.CapacityText
      end                                             as CapacityName,
      //
      //      //Associations
      //      _CapacityCategory,
      //      _FactoryCalendar,
      //      _Plant,
      //      _Text,
      //      _CapacityResponsiblePlanner,
      //      _ShiftGrouping,
      //      _CapacityQuantityUnit,
      //      _CapacityBaseQtyUnit,
      //      _Capacity,
            _MainCapacity
};
