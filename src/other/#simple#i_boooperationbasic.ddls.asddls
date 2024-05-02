@AbapCatalog.sqlViewName: '/SIMPLE/IBOOPBAS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
//@Analytics: {dataCategory: #DIMENSION}
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BOOOpInternalVersionCounter'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Operation Basic'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER }
@AbapCatalog.preserveKey:true
@Metadata.allowExtensions:true

define view /SIMPLE/I_BOOOperationBasic
  as select from plpo


  //  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType          on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
  //  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup         on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
  //                                                                                         and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
  //  association [1..1] to /SIMPLE/I_BOOOpInternalID      as _BOOOperationInternalID        on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
  //                                                                                         and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
  //                                                                                         and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID
  //
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to /SIMPLE/I_WorkCenterType       as _WorkCenterType                on  $projection.WorkCenterTypeCode = _WorkCenterType.WorkCenterTypeCode
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  association [0..1] to /SIMPLE/I_WorkCenter   as _WorkCenter   on  $projection.WorkCenterTypeCode   = _WorkCenter.WorkCenterTypeCode
                                                                and $projection.WorkCenterInternalID = _WorkCenter.WorkCenterInternalID
  //  association [1..1] to /SIMPLE/I_Plant                as _Plant                         on  $projection.Plant = _Plant.Plant
  //
  association [0..1] to I_ChangeMaster as _ChangeMaster on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber

  //  association [1..1] to /SIMPLE/I_OpControlProfile     as _OperationControlProfile       on  $projection.OperationControlProfile = _OperationControlProfile.OperationControlProfile
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _OperationUnit                 on  $projection.OperationUnit = _OperationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_OpStandardText       as _OperationStandardText         on  $projection.OperationStandardTextCode = _OperationStandardText.OperationStandardTextCode
  //
  //  association [0..1] to I_InspResultRecordingView      as _InspResultRecordingView       on  $projection.InspResultRecordingView = _InspResultRecordingView.InspResultRecordingView
  //
  //  association [1..1] to I_OperationStdWorkQtyGrpgCat   as _OperationStdWorkQtyGrpgCat    on  $projection.OperationStdWorkQtyGrpgCat = _OperationStdWorkQtyGrpgCat.OperationStdWorkQtyGrpgCat
  //
  //  association [0..1] to I_CapacityCategory             as _CapacityCategory              on  $projection.CapacityCategoryCode = _CapacityCategory.CapacityCategoryCode
  //
  //  association [0..1] to I_PurchasingInfoRecordApi01    as _PurchasingInfoRecord          on  $projection.PurchasingInfoRecord = _PurchasingInfoRecord.PurchasingInfoRecord
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to I_PurchasingOrganization       as _PurchasingOrganization        on  $projection.PurchasingOrganization = _PurchasingOrganization.PurchasingOrganization
  //  association [0..1] to I_PurchaseContract             as _PurchaseContract              on  $projection.PurchaseContract = _PurchaseContract.PurchaseContract
  //  association [0..1] to I_PurchaseContractItem         as _PurchaseContractItem          on  $projection.PurchaseContract     = _PurchaseContractItem.PurchaseContract
  //                                                                                         and $projection.PurchaseContractItem = _PurchaseContractItem.PurchaseContractItem
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to /SIMPLE/I_MaterialGroup        as _MaterialGroup                 on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup
  //  association [0..1] to /SIMPLE/I_PurchasingGroup      as _PurchasingGroup               on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup
  //  association [0..1] to /SIMPLE/I_Supplier             as _Supplier                      on  $projection.Supplier = _Supplier.Supplier
  //  association [0..1] to /SIMPLE/I_Currency             as _OpExternalProcessingCurrency  on  $projection.OpExternalProcessingCurrency = _OpExternalProcessingCurrency.Currency
  //
  //  association [0..1] to /SIMPLE/I_InspectionLotType    as _InspectionLotType             on  $projection.InspectionLotType = _InspectionLotType.InspectionLotType
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _BillOfOperationsBreakDurnUnit on  $projection.BillOfOperationsBreakDurnUnit = _BillOfOperationsBreakDurnUnit.UnitOfMeasure
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit1     on  $projection.StandardWorkQuantityUnit1 = _StandardWorkQuantityUnit1.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit2     on  $projection.StandardWorkQuantityUnit2 = _StandardWorkQuantityUnit2.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit3     on  $projection.StandardWorkQuantityUnit3 = _StandardWorkQuantityUnit3.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit4     on  $projection.StandardWorkQuantityUnit4 = _StandardWorkQuantityUnit4.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit5     on  $projection.StandardWorkQuantityUnit5 = _StandardWorkQuantityUnit5.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardWorkQuantityUnit6     on  $projection.StandardWorkQuantityUnit6 = _StandardWorkQuantityUnit6.UnitOfMeasure
  //
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio1   on  $projection.PerfEfficiencyRatioCode1 = _PerformanceEfficiencyRatio1.PerformanceEfficiencyRatioCode
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio2   on  $projection.PerfEfficiencyRatioCode2 = _PerformanceEfficiencyRatio2.PerformanceEfficiencyRatioCode
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio3   on  $projection.PerfEfficiencyRatioCode3 = _PerformanceEfficiencyRatio3.PerformanceEfficiencyRatioCode
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio4   on  $projection.PerfEfficiencyRatioCode4 = _PerformanceEfficiencyRatio4.PerformanceEfficiencyRatioCode
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio5   on  $projection.PerfEfficiencyRatioCode5 = _PerformanceEfficiencyRatio5.PerformanceEfficiencyRatioCode
  //  association [1..1] to I_PerformanceEfficiencyRatio   as _PerformanceEfficiencyRatio6   on  $projection.PerfEfficiencyRatioCode6 = _PerformanceEfficiencyRatio6.PerformanceEfficiencyRatioCode
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MaximumWaitDurationUnit       on  $projection.MaximumWaitDurationUnit = _MaximumWaitDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MinimumWaitDurationUnit       on  $projection.MinimumWaitDurationUnit = _MinimumWaitDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardMoveDurationUnit      on  $projection.StandardMoveDurationUnit = _StandardMoveDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MinimumMoveDurationUnit       on  $projection.MinimumMoveDurationUnit = _MinimumMoveDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _StandardQueueDurationUnit     on  $projection.StandardQueueDurationUnit = _StandardQueueDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MinimumQueueDurationUnit      on  $projection.MinimumQueueDurationUnit = _MinimumQueueDurationUnit.UnitOfMeasure
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MinProcessingDurnPerSplitUnit on  $projection.MinProcessingDurnPerSplitUnit = _MinProcessingDurnPerSplitUnit.UnitOfMeasure
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _OverlapMinimumDurationUnit    on  $projection.OverlapMinimumDurationUnit = _OverlapMinimumDurationUnit.UnitOfMeasure
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _OverlapMinimumTransferQtyUnit on  $projection.OverlapMinimumTransferQtyUnit = _OverlapMinimumTransferQtyUnit.UnitOfMeasure
  //
  //  -- Belongs to CAPP which is deprecated
  //  //  association [0..1] to I_StandardWorkQtyDetnType     as _StandardWorkQtyDetnType       on  $projection.standardworkqtydetntype = _StandardWorkQtyDetnType.StandardWorkQtyDetnType
  //  //                                                                                        and $projection.Plant                   = _StandardWorkQtyDetnType.Plant
  //
  //  association [0..1] to I_LeadTimeReductionStrategy    as _LeadTimeReductionStrategy     on  $projection.LeadTimeReductionStrategy = _LeadTimeReductionStrategy.LeadTimeReductionStrategy
  //                                                                                         and $projection.Plant                     = _LeadTimeReductionStrategy.Plant
  //
  //  association [0..1] to I_EmployeeWageGroup            as _EmployeeWageGroup             on  $projection.EmployeeWageGroup = _EmployeeWageGroup.EmployeeWageGroup
  //                                                                                         and $projection.Plant             = _EmployeeWageGroup.Plant
  //  association [0..1] to I_EmployeeSuitability          as _EmployeeSuitability           on  $projection.EmployeeSuitability = _EmployeeSuitability.EmployeeSuitability
  //                                                                                         and $projection.Plant               = _EmployeeSuitability.Plant
  //  association [0..1] to /SIMPLE/I_OperationSetupType   as _OperationSetupType            on  $projection.OperationSetupType = _OperationSetupType.OperationSetupType
  //                                                                                         and $projection.Plant              = _OperationSetupType.Plant
  //  association [0..1] to /SIMPLE/I_OpSetupGroupCategory as _OperationSetupGroupCategory   on  $projection.OperationSetupGroupCategory = _OperationSetupGroupCategory.OperationSetupGroupCategory
  //                                                                                         and $projection.Plant                       = _OperationSetupGroupCategory.Plant
  //  association [0..1] to /SIMPLE/I_OperationSetupGroup  as _OperationSetupGroup           on  $projection.OperationSetupGroup         = _OperationSetupGroup.OperationSetupGroup
  //                                                                                         and $projection.OperationSetupGroupCategory = _OperationSetupGroup.OperationSetupGroupCategory
  //                                                                                         and $projection.Plant                       = _OperationSetupGroup.Plant
  //  association [0..1] to I_ControlRecipeDestination     as _ControlRecipeDestination      on  $projection.Plant                    = _ControlRecipeDestination.Plant
  //                                                                                         and $projection.ControlRecipeDestination = _ControlRecipeDestination.ControlRecipeDestination
  //  association [0..1] to I_Currency                     as _FreeDefinedAmount1Currency    on  $projection.FreeDefinedAmount1Currency = _FreeDefinedAmount1Currency.Currency
  //  association [0..1] to I_Currency                     as _FreeDefinedAmount2Currency    on  $projection.FreeDefinedAmount2Currency = _FreeDefinedAmount2Currency.Currency
  //
  //  association [1..1] to I_FreeDfndTableFieldSemantic   as _FreeDfndTableFieldSemantic    on  $projection.FreeDefinedTableFieldSemantic = _FreeDfndTableFieldSemantic.FreeDefinedTableFieldSemantic
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _OperationStandardDurationUnit on  $projection.OperationStandardDurationUnit = _OperationStandardDurationUnit.UnitOfMeasure
  //  association [0..1] to I_MaintOperationSystCondition  as _OperationSystemCondition      on  $projection.OperationSystemCondition = _OperationSystemCondition.OperationSystemCondition
  //  association [0..1] to /SIMPLE/I_Material             as _Assembly                      on  $projection.Assembly = _Assembly.Material
  //  association [0..1] to I_OperationCalculationControl  as _OperationCalculationControl   on  $projection.OperationCalculationControl = _OperationCalculationControl.OperationCalculationControl
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _PurchaseOrderQtyUnit          on  $projection.PurchaseOrderQuantityUnit = _PurchaseOrderQtyUnit.UnitOfMeasure
  //  association [0..1] to I_FunctionalLocation           as _FunctionalLocation            on  $projection.FunctionalLocation = _FunctionalLocation.FunctionalLocation
  //  association [0..1] to I_Equipment                    as _Equipment                     on  $projection.Equipment = _Equipment.Equipment
  //
  //  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _MinimumDurationUnit           on  $projection.MinimumDurationUnit = _MinimumDurationUnit.UnitOfMeasure
  //  association [1..1] to /SIMPLE/I_CompanyCode          as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  //  association [1..1] to I_FactoryCalendar              as _FactoryCalendar               on  $projection.FactoryCalendar = _FactoryCalendar.FactoryCalendar
  //  association [0..1] to /SIMPLE/I_Language             as _LongTextLanguage              on  $projection.LongTextLanguageCode = _LongTextLanguage.Language
  //
  //  association [0..1] to /SIMPLE/I_BOOOperationBasic as _SupperOperation on  $projection.BillOfOperationsType = _SupperOperation.BillOfOperationsType
  //                                                                        and $projection.BillOfOperationsGroup = _SupperOperation.BillOfOperationsGroup
  //                                                                        and $projection.SuperiorOperationInternalID = _SupperOperation.BOOOperationInternalID
{
      //      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plnty                                                           as BillOfOperationsType,
      //      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key plnnr                                                           as BillOfOperationsGroup,
      //      @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key plnkn                                                           as BOOOperationInternalID,
      //      @ObjectModel.text.element: 'OperationText'
  key zaehl                                                           as BOOOpInternalVersionCounter,

      // NOT a key field in THIS view !
      versn                                                           as BillOfOperationsVersion,

      // ***************** Technical fields not on the CEWB-UI *****************

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_WorkCenterStdVH', element: 'WorkCenterInternalID' } } ]
      //      @ObjectModel.foreignKey.association: '_WorkCenter'
      arbid                                                           as WorkCenterInternalID,
      //      @ObjectModel.foreignKey.association: '_WorkCenterType'
      case when objty = '  ' and arbid <> '00000000' then 'A '
      else objty end                                                  as WorkCenterTypeCode,

      loekz                                                           as IsDeleted,
      loekz_inherited                                                 as IsImplicitlyDeleted,

      sumnr                                                           as SuperiorOperationInternalID,

      // ************************** Operation Header ***************************

      oprid                                                           as OperationExternalID,
      vornr                                                           as Operation,

      // ************************** Operation General **************************

      -- Operation
      @Semantics.text: true
      ltxa1                                                           as OperationText,

      //      @ObjectModel.foreignKey.association: '_LongTextLanguage'
      txtsp                                                           as LongTextLanguageCode,

      //      @ObjectModel.foreignKey.association: '_Plant'
      werks                                                           as Plant,

      //      @ObjectModel.foreignKey.association: '_OperationControlProfile'
      steus                                                           as OperationControlProfile,

      //      @ObjectModel.foreignKey.association: '_OperationStandardText'
      ktsch                                                           as OperationStandardTextCode,

      -- Origin
      vplty                                                           as BillOfOperationsRefType,
      cast (vplnr as billofoperationsrefgroup preserving type)        as BillOfOperationsRefGroup,
      cast (vplal as billofoperationsrefvariant preserving type)      as BillOfOperationsRefVariant,

      -- Production Line
      cast (takt as linesegmenttakt preserving type)                  as LineSegmentTakt,

      -- Transfer to Orders     (-> Suboperations)
      //      @ObjectModel.foreignKey.association: '_OperationStdWorkQtyGrpgCat'
      cast (verdart as operationstdworkqtygrpgcat preserving type)    as OperationStdWorkQtyGrpgCat,
      uavo_aufl                                                       as OrderHasNoSubOperations,

      // ************************** Processing Times ***************************

      -- Standard Values
      //      @Semantics.quantity.unitOfMeasure: 'OperationUnit'
      //      @DefaultAggregation: #NONE
      bmsch                                                           as OperationReferenceQuantity,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_OperationUnit'
      meinh                                                           as OperationUnit,

      umrez                                                           as OpQtyToBaseQtyNmrtr,
      umren                                                           as OpQtyToBaseQtyDnmntr,

      zmerh                                                           as BillOfOperationsBreakDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_BillOfOperationsBreakDurnUnit'
      zeier                                                           as BillOfOperationsBreakDurnUnit,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit1'
      //      @DefaultAggregation: #NONE
      vgw01                                                           as StandardWorkQuantity1,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit1'
      vge01                                                           as StandardWorkQuantityUnit1,
      lar01                                                           as CostCtrActivityType1,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio1'
      zgr01                                                           as PerfEfficiencyRatioCode1,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit2'
      //      @DefaultAggregation: #NONE
      vgw02                                                           as StandardWorkQuantity2,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit2'
      vge02                                                           as StandardWorkQuantityUnit2,
      lar02                                                           as CostCtrActivityType2,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio2'
      zgr02                                                           as PerfEfficiencyRatioCode2,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit3'
      //      @DefaultAggregation: #NONE
      vgw03                                                           as StandardWorkQuantity3,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit3'
      vge03                                                           as StandardWorkQuantityUnit3,
      lar03                                                           as CostCtrActivityType3,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio3'
      zgr03                                                           as PerfEfficiencyRatioCode3,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit4'
      //      @DefaultAggregation: #NONE
      vgw04                                                           as StandardWorkQuantity4,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit4'
      vge04                                                           as StandardWorkQuantityUnit4,
      lar04                                                           as CostCtrActivityType4,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio4'
      zgr04                                                           as PerfEfficiencyRatioCode4,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit5'
      //      @DefaultAggregation: #NONE
      vgw05                                                           as StandardWorkQuantity5,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit5'
      vge05                                                           as StandardWorkQuantityUnit5,
      lar05                                                           as CostCtrActivityType5,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio5'
      zgr05                                                           as PerfEfficiencyRatioCode5,

      //      @Semantics.quantity.unitOfMeasure: 'StandardWorkQuantityUnit6'
      //      @DefaultAggregation: #NONE
      vgw06                                                           as StandardWorkQuantity6,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardWorkQuantityUnit6'
      vge06                                                           as StandardWorkQuantityUnit6,
      lar06                                                           as CostCtrActivityType6,
      //      @ObjectModel.foreignKey.association: '_PerformanceEfficiencyRatio6'
      zgr06                                                           as PerfEfficiencyRatioCode6,

      // The ControllingArea is not known at this point and thus a foreign key relation can't be provided (for performance reasons).
      // A higher level view needs to get the ControllingArea using P_BOOPlantControllingArea which then the consumption view
      // can use to establish a foreign key relation to I_BusinessProcess
      prz01                                                           as BusinessProcess,

      -- (Start) Determination of Standard Values is used for CAPP which is deprecated
      //      @ObjectModel.foreignKey.association: '_StandardWorkQtyDetnType'
      //      cast (zerma as standardworkqtydetntype preserving type)          as   StandardWorkQtyDetnType,
      //      cast (zgdat as standardworkqtydetnyear preserving type)          as   StandardWorkQtyDetnYear,
      //      cast (zcode as standardworkqtyreferenceid preserving type)       as   StandardWorkQtyReferenceID,
      //      cast (zulnr as standardworkqtycalcbasisid preserving type)       as   StandardWorkQuantityCalcBasis,
      //      capoc                                                            as   CAPPCalculationType,
      //      flg_captxt                                                       as   HasCAPPText,
      -- (End) Determination of Standard Values

      // ************************ Interoperation Times *************************

      -- Interoperation Times
      //      @ObjectModel.foreignKey.association: '_LeadTimeReductionStrategy'
      rstra                                                           as LeadTimeReductionStrategy,

      ablipkz                                                         as TeardownAndWaitIsParallel,

      //      @Semantics.quantity.unitOfMeasure: 'MaximumWaitDurationUnit'
      //      @DefaultAggregation: #NONE
      zlmax                                                           as MaximumWaitDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_MaximumWaitDurationUnit'
      zeilm                                                           as MaximumWaitDurationUnit,

      //      @Semantics.quantity.unitOfMeasure: 'MinimumWaitDurationUnit'
      //      @DefaultAggregation: #NONE
      zlpro                                                           as MinimumWaitDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_MinimumWaitDurationUnit'
      zeilp                                                           as MinimumWaitDurationUnit,

      //      @Semantics.quantity.unitOfMeasure: 'StandardQueueDurationUnit'
      //      @DefaultAggregation: #NONE
      zwnor                                                           as StandardQueueDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardQueueDurationUnit'
      zeiwn                                                           as StandardQueueDurationUnit,

      //      @Semantics.quantity.unitOfMeasure: 'MinimumQueueDurationUnit'
      //      @DefaultAggregation: #NONE
      zwmin                                                           as MinimumQueueDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_MinimumQueueDurationUnit'
      zeiwm                                                           as MinimumQueueDurationUnit,

      //      @Semantics.quantity.unitOfMeasure: 'StandardMoveDurationUnit'
      //      @DefaultAggregation: #NONE
      ztnor                                                           as StandardMoveDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_StandardMoveDurationUnit'
      zeitn                                                           as StandardMoveDurationUnit,
      //      @Semantics.quantity.unitOfMeasure: 'MinimumMoveDurationUnit'
      //      @DefaultAggregation: #NONE
      ztmin                                                           as MinimumMoveDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_MinimumMoveDurationUnit'
      zeitm                                                           as MinimumMoveDurationUnit,

      // **************************** Control Data *****************************

      --- Splitting
      spmus                                                           as OperationSplitIsRequired,

      cast (splim as maximumnumberofsplits preserving type)           as MaximumNumberOfSplits,

      //      @Semantics.quantity.unitOfMeasure: 'MinProcessingDurnPerSplitUnit'
      zminb                                                           as MinProcessingDurationPerSplit,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_MinProcessingDurnPerSplitUnit'
      zeimb                                                           as MinProcessingDurnPerSplitUnit,

      --- Overlapping
      cast (uemus as operationoverlappingisrequired preserving type)  as OperationOverlappingIsRequired,
      cast (uekan as operationoverlappingispossible preserving type)  as OperationOverlappingIsPossible,
      flies                                                           as OperationsIsAlwaysOverlapping,

      //      @Semantics.quantity.unitOfMeasure: 'OverlapMinimumDurationUnit'
      //      @DefaultAggregation: #NONE
      zminu                                                           as OverlapMinimumDuration,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_OverlapMinimumDurationUnit'
      zeimu                                                           as OverlapMinimumDurationUnit,

      //      @Semantics.quantity.unitOfMeasure: 'OverlapMinimumTransferQtyUnit'
      //      @DefaultAggregation: #NONE
      minwe                                                           as OverlapMinimumTransferQty,
      //      @Semantics.unitOfMeasure: true
      //      @ObjectModel.foreignKey.association: '_OverlapMinimumTransferQtyUnit'
      meinh                                                           as OverlapMinimumTransferQtyUnit,

      // ********************* Additional Operation Data ***********************

      --- General Data
      aufak                                                           as OperationScrapPercent,

      loanz                                                           as NumberOfTimeTickets,
      rsanz                                                           as NumberOfConfirmationSlips,

      //      @ObjectModel.foreignKey.association: '_EmployeeWageGroup'
      logrp                                                           as EmployeeWageGroup,
      loart                                                           as EmployeeWageType,

      //      @ObjectModel.foreignKey.association: '_EmployeeSuitability'
      qualf                                                           as EmployeeSuitability,

      anzma                                                           as NumberOfEmployees,

      //      @ObjectModel.foreignKey.association: '_OperationSetupType'
      rasch                                                           as OperationSetupType,
      //      @ObjectModel.foreignKey.association: '_OperationSetupGroupCategory'
      rfgrp                                                           as OperationSetupGroupCategory,
      //      @ObjectModel.foreignKey.association: '_OperationSetupGroup'
      rfsch                                                           as OperationSetupGroup,

      cast (ckselkz as operationcostingrelevancytype preserving type) as OperationCostingRelevancyType,

      //visible only in CA02
      nvadd                                                           as IsNonValueAddedOperation,

      // ************************ External Processing **************************

      -- External Processing
      frdlb                                                           as OpIsExtlyProcdWithSubcontrg,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchasingInfoRecordStdVH', element: 'PurchasingInfoRecord' } } ]
      //      @ObjectModel.foreignKey.association: '_PurchasingInfoRecord'
      infnr                                                           as PurchasingInfoRecord,

      //      @ObjectModel.foreignKey.association: '_PurchasingOrganization'
      ekorg                                                           as PurchasingOrganization,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchaseContractStdVH', element: 'PurchaseContract' } } ]
      //      @ObjectModel.foreignKey.association: '_PurchaseContract'
      ebeln                                                           as PurchaseContract,
      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchaseContractItemStdVH', element: 'PurchaseContractItem' } } ]
      //      @ObjectModel.foreignKey.association: '_PurchaseContractItem'
      ebelp                                                           as PurchaseContractItem,

      sortl                                                           as PurchasingInfoRecdAddlGrpgName,

      //      @ObjectModel.foreignKey.association: '_MaterialGroup'
      matkl                                                           as MaterialGroup,

      //      @ObjectModel.foreignKey.association: '_PurchasingGroup'
      ekgrp                                                           as PurchasingGroup,

      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Supplier_VH', element: 'Supplier' } } ]
      //      @ObjectModel.foreignKey.association: '_Supplier'
      lifnr                                                           as Supplier,

      plifz                                                           as PlannedDeliveryDuration,

      peinh                                                           as NumberOfOperationPriceUnits,

      //      @Semantics.amount.currencyCode: 'OpExternalProcessingCurrency'
      //      @DefaultAggregation: #NONE
      preis                                                           as OpExternalProcessingPrice,

      //      @ObjectModel.foreignKey.association: '_InspectionLotType'
      qpart                                                           as InspectionLotType,
      // The ControllingArea is not known at this point and thus a foreign key relation can't be provided (for performance reasons).
      // A higher level view needs to get the ControllingArea using P_BOOPlantControllingArea which then the consumption view
      // can use to establish a foreign key relation to I_CostElement
      sakto                                                           as CostElement,

      //      @Semantics.currencyCode: true
      //      @ObjectModel.foreignKey.association: '_OpExternalProcessingCurrency'
      waers                                                           as OpExternalProcessingCurrency,

      // ************************* Qualification Data **************************

      //      @ObjectModel.foreignKey.association: '_CapacityCategory'
      qlkapar                                                         as CapacityCategoryCode,

      // ************************* Process Control Data **************************

      phflg                                                           as BOOOperationIsPhase,
      pvzkn                                                           as BOOPhaseSuperiorOpInternalID,
      //      @ObjectModel.foreignKey.association: '_ControlRecipeDestination'
      phseq                                                           as ControlRecipeDestination,

      // ************************* Quality Management **************************

      -- Quality management: general
      //      @ObjectModel.foreignKey.association: '_InspResultRecordingView'
      erfsicht                                                        as InspResultRecordingView,
      //      @Semantics.quantity.unitOfMeasure: 'MinimumDurationUnit'
      daumi                                                           as MinimumDuration,
      //      @ObjectModel.foreignKey.association: '_MinimumDurationUnit'
      //      @Semantics.unitOfMeasure: true
      daume                                                           as MinimumDurationUnit,
      prznt                                                           as OperationWorkPercent,
      vertl                                                           as CapRqmtsDistributionFunction,
      //      @ObjectModel.foreignKey.association: '_CompanyCode'
      bukrs                                                           as CompanyCode,
      //      @ObjectModel.foreignKey.association: '_FactoryCalendar'
      kalid                                                           as FactoryCalendar,
      vertn                                                           as CapacityRequirementDistrKey,

      -- Quality management: inspection points
      qppktabs                                                        as InspSbstCompletionConfirmation,
      qkzprfrei                                                       as InspSbstHasNoTimeOrQuantity,

      //      @Semantics.quantity.unitOfMeasure: 'OperationStandardDurationUnit'
      plpo.dauno                                                      as OperationStandardDuration,
      //      @ObjectModel.foreignKey.association: '_OperationStandardDurationUnit'
      //      @Semantics.unitOfMeasure: true
      plpo.daune                                                      as OperationStandardDurationUnit,
      plpo.anzzl                                                      as NumberOfCapacities,
      //      @ObjectModel.foreignKey.association: '_OperationSystemCondition'
      plpo.anlzu                                                      as OperationSystemCondition,
      plpo.larnt                                                      as CostCtrActivityType,
      //      @ObjectModel.foreignKey.association: '_OperationCalculationControl'
      plpo.indet                                                      as OperationCalculationControl,
      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialStdVH', element: 'Material' } } ]
      //      @ObjectModel.foreignKey.association: '_Assembly'
      plpo.istru                                                      as Assembly,
      //      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      plpo.bmvrg                                                      as PurchaseOrderQty,
      //      @ObjectModel.foreignKey.association: '_PurchaseOrderQtyUnit'
      //      @Semantics.unitOfMeasure: true
      plpo.bmeih                                                      as PurchaseOrderQuantityUnit,
      plpo.esokz                                                      as PurchasingInfoRecordCategory,
      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_FunctionalLocationStdVH', element: 'FunctionalLocation' } } ]
      //      @ObjectModel.foreignKey.association: '_FunctionalLocation'
      plpo.tplnr                                                      as FunctionalLocation,
      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_EquipmentStdVH', element: 'Equipment' } } ]
      //      @ObjectModel.foreignKey.association: '_Equipment'
      plpo.equnr                                                      as Equipment,

      // ***************************** User Fields *****************************
      //      @ObjectModel.foreignKey.association: '_FreeDfndTableFieldSemantic'
      slwid                                                           as FreeDefinedTableFieldSemantic,
      usr00                                                           as FreeDefinedAttribute01,
      usr01                                                           as FreeDefinedAttribute02,
      usr02                                                           as FreeDefinedAttribute03,
      usr03                                                           as FreeDefinedAttribute04,
      //      @Semantics.quantity.unitOfMeasure: 'FreeDefinedQuantity1Unit'
      //      @DefaultAggregation: #NONE
      usr04                                                           as FreeDefinedQuantity1,
      //      @Semantics.unitOfMeasure: true
      use04                                                           as FreeDefinedQuantity1Unit,
      //      @Semantics.quantity.unitOfMeasure: 'FreeDefinedQuantity2Unit'
      //      @DefaultAggregation: #NONE
      usr05                                                           as FreeDefinedQuantity2,
      //      @Semantics.unitOfMeasure: true
      use05                                                           as FreeDefinedQuantity2Unit,
      //      @Semantics.amount.currencyCode: 'FreeDefinedAmount1Currency'
      //      @DefaultAggregation: #NONE
      usr06                                                           as FreeDefinedAmount1,
      //      @Semantics.currencyCode: true
      //      @ObjectModel.foreignKey.association: '_FreeDefinedAmount1Currency'
      use06                                                           as FreeDefinedAmount1Currency,
      //      @Semantics.amount.currencyCode: 'FreeDefinedAmount2Currency'
      //      @DefaultAggregation: #NONE
      usr07                                                           as FreeDefinedAmount2,
      //      @Semantics.currencyCode: true
      //      @ObjectModel.foreignKey.association: '_FreeDefinedAmount2Currency'
      use07                                                           as FreeDefinedAmount2Currency,
      usr08                                                           as FreeDefinedDate1,
      usr09                                                           as FreeDefinedDate2,
      usr10                                                           as FreeDefinedIndicator1,
      usr11                                                           as FreeDefinedIndicator2,

      // *************************** Administration ****************************

      -- Administrative Data
      @Semantics.systemDate.createdAt: true
      andat                                                           as CreationDate,
      @Semantics.user.createdBy: true
      cast (annam as vdm_createdbyuserid preserving type)             as CreatedByUser,

      @Semantics.systemDate.lastChangedAt: true
      aedat                                                           as LastChangeDate,
      @Semantics.user.lastChangedBy: true
      cast (aenam as vdm_lastchangedbyuserid preserving type)         as LastChangedByUser,

      //       Validity
      //      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ChangeMasterStdVH', element: 'ChangeNumber' } } ]
      //      @ObjectModel.foreignKey.association: '_ChangeMaster'
      cast (aennr as changenumber preserving type)                    as ChangeNumber,

      @Semantics.businessDate.from: true
      cast(datuv as pph_begda preserving type)                        as ValidityStartDate,
      @Semantics.businessDate.to: true
      cast(valid_to as pph_endda preserving type)                     as ValidityEndDate,

      // ******************* Fields of other task list types *******************

      arbei                                                           as OpPlannedWorkQuantity,
      arbeh                                                           as OpWorkQuantityUnit,

      //Start adding missing field
      aaufg                                                           as WorkCenterOpSetIndicator,
      adpsp                                                           as ReferenceElementPMPS,
      anfko                                                           as RequestingCostCenter,
      anfkokrs                                                        as COAreaRequestCostCenter,
      aufkt                                                           as ExecutionFactor,
      bzoffb                                                          as RefDateForStartOfSubOp,
      bzoffe                                                          as RefDateForFinishOfSubOp,
      capoc                                                           as TypeOfCAPPOrderOpening,
      classid                                                         as InternalClassNumber,
      cn_weight                                                       as AggregationWeightPOC,
      dafkt                                                           as AverageExecFactor,
      ddehn                                                           as FlexibleDurationIndicator,
      ebort                                                           as InstallationPointForSubitem,
      @Semantics.unitOfMeasure: true
      ehoffb                                                          as UnitOffsetToStart,
      @Semantics.unitOfMeasure: true
      ehoffe                                                          as UnitOffsetToEnd,
      einsa                                                           as ConstraintOfStartDate,
      einse                                                           as ConstraintOfEndDate,
      evgew                                                           as AggregationWeightPOC2,
      flg_captxt                                                      as CAPPTextExistsIndicator,
      flg_tsk_group                                                   as IsGroupOperation,
      frsp                                                            as EarlyLatePossibleActivity,
      istkn                                                           as BillOfMaterialItemNodeNumber,
      istnr                                                           as BillOfMaterialNumber,
      istpo                                                           as BOMItemInternalChangeCount,
      istty                                                           as BillOfMaterialCategory,
      iupoz                                                           as BOMSubItem,
      kalkz                                                           as BillOfOperationCost,
      kapar                                                           as CapacityCategory,
      knobj                                                           as ObjectDependencyAssignmentNumb,
      krit1                                                           as PlanningObject,
      kzlgf                                                           as LotSizeIndepntExternalProcess,
      ltxa2                                                           as OperationText2,
      manu_proc                                                       as ManufacturingProcess,
      mdlid                                                           as ModelID,
      mes_operid                                                      as MESOperationNumber,
      mes_stepid                                                      as MESStepID,
      mlstn                                                           as MilestoneUsage,
      nprio                                                           as PSPriority,
      offstb                                                          as OffsetToSubOperationStart,
      offste                                                          as OffsetToSubOperationEnd,
      packno                                                          as PackageNumber,
      parkz                                                           as InactiveChangesIndicator,
      pdest                                                           as PrinterForShopPaper,
      pprio                                                           as OperationPriority,
      prkst                                                           as CostsInActivity,
      pspnr                                                           as StandardWBSElement,
      qkzprmeng                                                       as InspQuantityReference,
      qkzprzeit                                                       as InspTimeRelatedInterval,
      qkztlsbest                                                      as InspLastPartialLotAssignment,
      qkzztmg1                                                        as InspQuantityConfirmEPartialLot,
      qlobjektid                                                      as InspectionObjectID,
      qlotype                                                         as InspectionObjectType,
      @Semantics.unitOfMeasure: true
      qrastereh                                                       as InspGridUnitOfMeasure,
      qrastermng                                                      as InspGridQuantity,
      qrastmeng                                                       as QuantityBetweenTwoInspections,
      qrastzeht                                                       as InspectionTimeUnit,
      qrastzfak                                                       as InspectionTimeFactor,
      rfpnt                                                           as RefPointBOMTransfer,
      ruzus                                                           as RoundingNAdditionalValues,
      rwfak                                                           as ReworkFactor,
      subplnal                                                        as SubGroupCounter,
      subplnnr                                                        as SubGroup,
      subplnty                                                        as SubType,
      techv                                                           as TechnicalStatusFrom,
      vintv                                                           as OperationIncrement,
      vplfl                                                           as RefSequenceRouting,
      xexcltl                                                         as ExcludeSub,
      zcode                                                           as ReferenceNumberSVCode,
      zerma                                                           as TypeOfStdValueDetermin,
      zgdat                                                           as DateOfStdValueCalculate,
      zulnr                                                           as CalculationBasis,
      //      case
      //        when sumnr is initial
      //          then plnkn
      //          else sumnr
      //          end as BOOOperationMainInternalID,
      sumnr                                                           as BOOOperationMainInternalID,
      //End adding missing field
      // **************************** Associations *****************************

      //      _Assembly,
      //      _BOOOperationInternalID,
      //      _BillOfOperationsBreakDurnUnit,
      //      _BillOfOperationsGroup,
      //      _BillOfOperationsType,
      //      _CapacityCategory,
      _ChangeMaster,
      //      _CompanyCode,
      //      _ControlRecipeDestination,
      //      _EmployeeSuitability,
      //      _EmployeeWageGroup,
      //      _Equipment,
      //      _FactoryCalendar,
      //      _FreeDefinedAmount1Currency,
      //      _FreeDefinedAmount2Currency,
      //      _FreeDfndTableFieldSemantic,
      //      _FunctionalLocation,
      //      _InspResultRecordingView,
      //      _InspectionLotType,
      //      _LeadTimeReductionStrategy,
      //      _LongTextLanguage,
      //      _MaterialGroup,
      //      _MaximumWaitDurationUnit,
      //      _MinimumDurationUnit,
      //      _MinimumMoveDurationUnit,
      //      _MinimumQueueDurationUnit,
      //      _MinimumWaitDurationUnit,
      //      _MinProcessingDurnPerSplitUnit,
      //      _OpExternalProcessingCurrency,
      //      _OperationCalculationControl,
      //      _OperationControlProfile,
      //      _OperationSetupGroup,
      //      _OperationSetupGroupCategory,
      //      _OperationSetupType,
      //      _OperationStandardDurationUnit,
      //      _OperationStandardText,
      //      _OperationStdWorkQtyGrpgCat,
      //      _OperationSystemCondition,
      //      _OperationUnit,
      //      _OverlapMinimumDurationUnit,
      //      _OverlapMinimumTransferQtyUnit,
      //      _PerformanceEfficiencyRatio1,
      //      _PerformanceEfficiencyRatio2,
      //      _PerformanceEfficiencyRatio3,
      //      _PerformanceEfficiencyRatio4,
      //      _PerformanceEfficiencyRatio5,
      //      _PerformanceEfficiencyRatio6,
      //      _Plant,
      //      _PurchaseContract,
      //      _PurchaseContractItem,
      //      _PurchaseOrderQtyUnit,
      //      _PurchasingGroup,
      //      _PurchasingInfoRecord,
      //      _PurchasingOrganization,
      //      _StandardMoveDurationUnit,
      //      _StandardQueueDurationUnit,
      //      _StandardWorkQuantityUnit1,
      //      _StandardWorkQuantityUnit2,
      //      _StandardWorkQuantityUnit3,
      //      _StandardWorkQuantityUnit4,
      //      _StandardWorkQuantityUnit5,
      //      _StandardWorkQuantityUnit6,
      //      _Supplier,
      _WorkCenter
      //      _WorkCenterType,
      //      _SupperOperation
}
