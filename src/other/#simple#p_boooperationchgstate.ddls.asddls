@AbapCatalog.sqlViewName: '/SIMPLE/PBOOPCHS'
@AbapCatalog.compiler.compareFilter:true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
@VDM.viewType: #BASIC
@VDM.private: true

// This view delivers Operations only
// Due to join on PLAS SubOperations are not selected
// This view is different than P_BOOOperationChangeState

define view /SIMPLE/P_BOOOperationChgState
  as select from /SIMPLE/I_BOOOperationBasic    as plpo
  //    inner join   /SIMPLE/I_BOOSqncOpAssgmtChgSt as plas on  plas.BillOfOperationsType   =  plpo.BillOfOperationsType
  //                                                        and plas.BillOfOperationsGroup  =  plpo.BillOfOperationsGroup
  //                                                        and plas.BOOOperationInternalID =  plpo.BOOOperationInternalID
  //                                                        and plas.ValidityStartDate      <= plpo.ValidityEndDate
  //                                                        and plas.ValidityEndDate        >= plpo.ValidityStartDate

    inner join   /SIMPLE/I_BOOSqncOpAssgmtChgSt as plas on  plas.BillOfOperationsType     = plpo.BillOfOperationsType
                                                        and plas.BillOfOperationsGroup    = plpo.BillOfOperationsGroup
                                                        and (
                                                           plas.BOOOperationInternalID    = plpo.BOOOperationMainInternalID
                                                           or plas.BOOOperationInternalID = plpo.BOOOperationInternalID
                                                         )
  //                                                        and plas.ValidityStartDate      <= plpo.ValidityEndDate
  //                                                        and plas.ValidityEndDate        >= plpo.ValidityStartDate
  //  -- Application is always '*' in T430
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [1..1] to /SIMPLE/I_OpControlProfile    as _OperationControlProfile       on  $projection.OperationControlProfile = _OperationControlProfile.OperationControlProfile
  //
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [1..1] to /SIMPLE/I_OpStandardText      as _OperationStandardText         on  $projection.OperationStandardTextCode = _OperationStandardText.OperationStandardTextCode
  //
  //
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to /SIMPLE/I_EmployeeWageGroup   as _EmployeeWageGroup             on  $projection.EmployeeWageGroup = _EmployeeWageGroup.EmployeeWageGroup
  //                                                                                        and $projection.Plant             = _EmployeeWageGroup.Plant
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to /SIMPLE/I_EmployeeSuitability as _EmployeeSuitability           on  $projection.EmployeeSuitability = _EmployeeSuitability.EmployeeSuitability
  //                                                                                        and $projection.Plant               = _EmployeeSuitability.Plant
  //  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
  //  association [0..1] to /SIMPLE/I_OperationSetupType  as _OperationSetupType            on  $projection.OperationSetupType = _OperationSetupType.OperationSetupType
  //                                                                                        and $projection.Plant              = _OperationSetupType.Plant
  //
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter1 on  $projection.standardworkformulaparam1 = _StandardWorkFormulaParameter1.StandardWorkFormulaParameter
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter2 on  $projection.standardworkformulaparam2 = _StandardWorkFormulaParameter2.StandardWorkFormulaParameter
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter3 on  $projection.standardworkformulaparam3 = _StandardWorkFormulaParameter3.StandardWorkFormulaParameter
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter4 on  $projection.standardworkformulaparam4 = _StandardWorkFormulaParameter4.StandardWorkFormulaParameter
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter5 on  $projection.standardworkformulaparam5 = _StandardWorkFormulaParameter5.StandardWorkFormulaParameter
  //  association [0..1] to /SIMPLE/I_StdWorkFP           as _StandardWorkFormulaParameter6 on  $projection.standardworkformulaparam6 = _StandardWorkFormulaParameter6.StandardWorkFormulaParameter

{
      //  key plas.BillOfOperationsType,
      //  key plas.BillOfOperationsGroup,
      //  key plas.BillOfOperationsVariant,
      //  key plas.BillOfOperationsSequence,
      //  key plpo.BOOOperationInternalID,
      //  key plas.BOOSqncOpAssgmtIntVersionCntr,
      //  key plpo.BOOOpInternalVersionCounter,

  key plas.BillOfOperationsType,
  key plas.BillOfOperationsGroup,
  key plpo.BOOOperationInternalID,
  key plpo.BOOOpInternalVersionCounter,

      plas.BillOfOperationsVariant,
      plas.BillOfOperationsSequence,
      plas.BOOSqncOpAssgmtIntVersionCntr,

      plpo.BillOfOperationsVersion, // NOT a key field in THIS view !

      // ***************** Technical fields not on the CEWB-UI *****************

      WorkCenterInternalID,
      WorkCenterTypeCode,

      case when plpo.IsDeleted = ' ' then plas.IsDeleted
      else plpo.IsDeleted end                               as IsDeleted,
      case when plpo.IsImplicitlyDeleted = ' ' then plas.IsImplicitlyDeleted
      else plpo.IsImplicitlyDeleted end                     as IsImplicitlyDeleted,

      // ************************** Operation Header ***************************

      OperationExternalID,
      Operation,

      // ************************** Operation General **************************

      -- Operation
      OperationText,

      Plant,

      //      @ObjectModel.foreignKey.association: '_OperationControlProfile'
      case _WorkCenter.OpControlProfileIsReferenced
        when 'X' then _WorkCenter.OperationControlProfile
        else OperationControlProfile end                    as OperationControlProfile,

      //      @ObjectModel.foreignKey.association: '_OperationStandardText'
      case _WorkCenter.StandardTextIDIsReferenced
        when 'X' then _WorkCenter.StandardTextInternalID
        else OperationStandardTextCode end                  as OperationStandardTextCode,

      -- Origin
      BillOfOperationsRefType,
      BillOfOperationsRefGroup,
      BillOfOperationsRefVariant,

      -- Production Line
      LineSegmentTakt,

      -- Transfer to Orders     (-> Suboperations)
      OperationStdWorkQtyGrpgCat,

      OrderHasNoSubOperations,

      // ************************** Processing Times ***************************

      -- Standard Values
      OperationReferenceQuantity,
      OperationUnit,

      OpQtyToBaseQtyNmrtr,
      OpQtyToBaseQtyDnmntr,

      BillOfOperationsBreakDuration,
      BillOfOperationsBreakDurnUnit,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam1,
      StandardWorkQuantity1,
      StandardWorkQuantityUnit1,
      CostCtrActivityType1,
      PerfEfficiencyRatioCode1,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam2,
      StandardWorkQuantity2,
      StandardWorkQuantityUnit2,
      CostCtrActivityType2,
      PerfEfficiencyRatioCode2,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam3,
      StandardWorkQuantity3,
      StandardWorkQuantityUnit3,
      CostCtrActivityType3,
      PerfEfficiencyRatioCode3,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam4,
      StandardWorkQuantity4,
      StandardWorkQuantityUnit4,
      CostCtrActivityType4,
      PerfEfficiencyRatioCode4,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam5,
      StandardWorkQuantity5,
      StandardWorkQuantityUnit5,
      CostCtrActivityType5,
      PerfEfficiencyRatioCode5,

      _WorkCenter._StandardWorkFmlaParamGroup.StandardWorkFormulaParam6,
      StandardWorkQuantity6,
      StandardWorkQuantityUnit6,
      CostCtrActivityType6,
      PerfEfficiencyRatioCode6,

      BusinessProcess,

      // ************************ Interoperation Times *************************

      -- Interoperation Times
      LeadTimeReductionStrategy,

      TeardownAndWaitIsParallel,

      MaximumWaitDuration,
      MaximumWaitDurationUnit,

      MinimumWaitDuration,
      MinimumWaitDurationUnit,

      StandardQueueDuration,
      StandardQueueDurationUnit,

      MinimumQueueDuration,
      MinimumQueueDurationUnit,

      StandardMoveDuration,
      StandardMoveDurationUnit,

      MinimumMoveDuration,
      MinimumMoveDurationUnit,

      // **************************** Control Data *****************************

      --- Splitting
      OperationSplitIsRequired,

      MaximumNumberOfSplits,

      MinProcessingDurationPerSplit,
      MinProcessingDurnPerSplitUnit,

      --- Overlapping
      OperationOverlappingIsRequired,
      OperationOverlappingIsPossible,
      OperationsIsAlwaysOverlapping,

      OverlapMinimumDuration,
      OverlapMinimumDurationUnit,

      OverlapMinimumTransferQty,
      OverlapMinimumTransferQtyUnit,

      // ********************* Additional Operation Data ***********************

      --- General Data
      OperationScrapPercent,

      case _WorkCenter.NmbrOfTimeTicketsIsReferenced
        when 'X' then _WorkCenter.NumberOfTimeTickets
        else NumberOfTimeTickets end                        as NumberOfTimeTickets,
      case _WorkCenter.NumberOfConfSlipsIsReferenced
        when 'X' then _WorkCenter.NumberOfConfirmationSlips
        else NumberOfConfirmationSlips end                  as NumberOfConfirmationSlips,

      //      @ObjectModel.foreignKey.association: '_EmployeeWageGroup'
      case _WorkCenter.EmployeeWageGroupIsReferenced
        when 'X' then _WorkCenter.EmployeeWageGroup
        else EmployeeWageGroup end                          as EmployeeWageGroup,
      case _WorkCenter.EmployeeWageTypeIsReferenced
        when 'X' then _WorkCenter.EmployeeWageType
        else EmployeeWageType end                           as EmployeeWageType,

      //      @ObjectModel.foreignKey.association: '_EmployeeSuitability'
      case _WorkCenter.EmplSuitabilityIsReferenced
        when 'X' then _WorkCenter.EmployeeSuitability
        else EmployeeSuitability end                        as EmployeeSuitability,

      NumberOfEmployees,

      -- Setup
      //      @ObjectModel.foreignKey.association: '_OperationSetupType'
      case _WorkCenter.WorkCenterSetpTypeIsReferenced
        when 'X' then _WorkCenter.WorkCenterSetupType
        else OperationSetupType end                         as OperationSetupType,
      OperationSetupGroupCategory,
      OperationSetupGroup,

      OperationCostingRelevancyType,

      IsNonValueAddedOperation, //visible only in CA02

      // ************************ External Processing **************************

      -- External Processing
      OpIsExtlyProcdWithSubcontrg,

      PurchasingInfoRecord,

      PurchasingOrganization,

      PurchaseContract,
      PurchaseContractItem,

      PurchasingInfoRecdAddlGrpgName,

      MaterialGroup,

      PurchasingGroup,

      Supplier,

      PlannedDeliveryDuration,

      NumberOfOperationPriceUnits,

      OpExternalProcessingPrice,

      InspectionLotType,

      CostElement,

      OpExternalProcessingCurrency,

      // ************************* Process Control Data ************************

      BOOOperationIsPhase,
      BOOPhaseSuperiorOpInternalID,

      ControlRecipeDestination,

      // ************************* Qualification Data **************************

      CapacityCategoryCode,

      // ************************* Quality Management **************************

      -- Quality management: general
      InspResultRecordingView,

      -- Quality management: inspection points
      InspSbstCompletionConfirmation,
      InspSbstHasNoTimeOrQuantity,

      // ***************************** User Fields *****************************

      FreeDefinedTableFieldSemantic,
      FreeDefinedAttribute01,
      FreeDefinedAttribute02,
      FreeDefinedAttribute03,
      FreeDefinedAttribute04,
      FreeDefinedQuantity1,
      FreeDefinedQuantity1Unit,
      FreeDefinedQuantity2,
      FreeDefinedQuantity2Unit,
      FreeDefinedAmount1,
      FreeDefinedAmount1Currency,
      FreeDefinedAmount2,
      FreeDefinedAmount2Currency,
      FreeDefinedDate1,
      FreeDefinedDate2,
      FreeDefinedIndicator1,
      FreeDefinedIndicator2,

      // *************************** Administration ****************************

      -- Administrative Data
      plpo.CreationDate,
      plpo.CreatedByUser,

      plpo.LastChangeDate,
      plpo.LastChangedByUser,

      -- Validity
      plpo.ChangeNumber,

      cast(case when plpo.ValidityStartDate > plas.ValidityStartDate then plpo.ValidityStartDate
      else plas.ValidityStartDate
      end as pph_begda preserving type)                     as ValidityStartDate,
      cast(case when plpo.ValidityEndDate < plas.ValidityEndDate then plpo.ValidityEndDate
      else plas.ValidityEndDate
      end as pph_endda preserving type)                     as ValidityEndDate,

      // **************************** Associations *****************************
      plas.BOOOperationInternalID                           as BOOOperationSelectInternalID,
      plas._BillOfOperationsType,
      plas._BillOfOperationsGroup,
      plas._BillOfOperations,
      plas._BillOfOperationsSequence,
      plas._BOOOperationInternalID,

      PurchasingInfoRecordCategory,
      OperationStandardDuration,
      OperationStandardDurationUnit,
      MinimumDuration,
      MinimumDurationUnit,
      OperationWorkPercent,
      CapRqmtsDistributionFunction,
      CompanyCode,
      OperationCalculationControl,
      CostCtrActivityType,
      OperationSystemCondition,
      Assembly,
      FactoryCalendar,
      CapacityRequirementDistrKey,
      PurchaseOrderQuantityUnit,
      PurchaseOrderQty,
      FunctionalLocation,
      Equipment,

      SuperiorOperationInternalID,
      LongTextLanguageCode,
      OpPlannedWorkQuantity,
      OpWorkQuantityUnit,
      NumberOfCapacities,

      //Start adding missing field
      plpo.WorkCenterOpSetIndicator,
      plpo.ReferenceElementPMPS,
      plpo.RequestingCostCenter,
      plpo.COAreaRequestCostCenter,
      plpo.ExecutionFactor,
      plpo.RefDateForStartOfSubOp,
      plpo.RefDateForFinishOfSubOp,
      plpo.TypeOfCAPPOrderOpening,
      plpo.InternalClassNumber,
      plpo.AggregationWeightPOC,
      plpo.AverageExecFactor,
      plpo.FlexibleDurationIndicator,
      plpo.InstallationPointForSubitem,
      @Semantics.unitOfMeasure: true
      plpo.UnitOffsetToStart,
      @Semantics.unitOfMeasure: true
      plpo.UnitOffsetToEnd,
      plpo.ConstraintOfStartDate,
      plpo.ConstraintOfEndDate,
      plpo.AggregationWeightPOC2,
      plpo.CAPPTextExistsIndicator,
      plpo.IsGroupOperation,
      plpo.EarlyLatePossibleActivity,
      plpo.BillOfMaterialItemNodeNumber,
      plpo.BillOfMaterialNumber,
      plpo.BOMItemInternalChangeCount,
      plpo.BillOfMaterialCategory,
      plpo.BOMSubItem,
      plpo.BillOfOperationCost,
      plpo.CapacityCategory,
      plpo.ObjectDependencyAssignmentNumb,
      plpo.PlanningObject,
      plpo.LotSizeIndepntExternalProcess,
      plpo.OperationText2,
      plpo.ManufacturingProcess,
      plpo.ModelID,
      plpo. MESOperationNumber,
      plpo.MESStepID,
      plpo.MilestoneUsage,
      plpo.PSPriority,
      plpo.OffsetToSubOperationStart,
      plpo.OffsetToSubOperationEnd,
      plpo.PackageNumber,
      plpo.InactiveChangesIndicator,
      plpo.PrinterForShopPaper,
      plpo.OperationPriority,
      plpo.CostsInActivity,
      plpo.StandardWBSElement,
      plpo.InspQuantityReference,
      plpo.InspTimeRelatedInterval,
      plpo.InspLastPartialLotAssignment,
      plpo.InspQuantityConfirmEPartialLot,
      plpo.InspectionObjectID,
      plpo.InspectionObjectType,
      @Semantics.unitOfMeasure: true
      plpo.InspGridUnitOfMeasure,
      plpo.InspGridQuantity,
      plpo.QuantityBetweenTwoInspections,
      plpo.InspectionTimeUnit,
      plpo.InspectionTimeFactor,
      plpo.RefPointBOMTransfer,
      plpo.RoundingNAdditionalValues,
      plpo.ReworkFactor,
      plpo.SubGroupCounter,
      plpo.SubGroup,
      plpo.SubType,
      plpo.TechnicalStatusFrom,
      plpo.OperationIncrement,
      plpo.RefSequenceRouting,
      plpo.ExcludeSub,
      plpo.ReferenceNumberSVCode,
      plpo.TypeOfStdValueDetermin,
      plpo.DateOfStdValueCalculate,
      plpo.CalculationBasis,
      //      plpo.BOOOperationMainInternalID,
      case
        when plpo.BOOOperationMainInternalID is initial
            then Operation
            else plas._BOOOperationInternalID.Operation end as ActivityOperation,
      case
        when plpo.BOOOperationMainInternalID is initial
            then '    '
            else plpo.Operation end                         as SubOperation,
      //End adding missing field



      //      _BillOfOperationsBreakDurnUnit,
      //      _CapacityCategory,
      plpo._ChangeMaster
      //      _ControlRecipeDestination,
      //      _EmployeeSuitability,
      //      _EmployeeWageGroup,
      //      _FreeDefinedAmount1Currency,
      //      _FreeDefinedAmount2Currency,
      //      _FreeDfndTableFieldSemantic,
      //      _InspResultRecordingView,
      //      _InspectionLotType,
      //      _LeadTimeReductionStrategy,
      //      _MaterialGroup,
      //      _MaximumWaitDurationUnit,
      //      _MinProcessingDurnPerSplitUnit,
      //      _MinimumMoveDurationUnit,
      //      _MinimumQueueDurationUnit,
      //      _MinimumWaitDurationUnit,
      //      _OpExternalProcessingCurrency,
      //      _OperationControlProfile,
      //      _OperationSetupGroup,
      //      _OperationSetupGroupCategory,
      //      _OperationSetupType,
      //      _OperationStandardText,
      //      _OperationStdWorkQtyGrpgCat,
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
      //      _PurchasingGroup,
      //      _PurchasingInfoRecord,
      //      _PurchasingOrganization,
      //      _StandardMoveDurationUnit,
      //      _StandardQueueDurationUnit,
      //      _StandardWorkFormulaParameter1,
      //      _StandardWorkFormulaParameter2,
      //      _StandardWorkFormulaParameter3,
      //      _StandardWorkFormulaParameter4,
      //      _StandardWorkFormulaParameter5,
      //      _StandardWorkFormulaParameter6,
      //      _StandardWorkQuantityUnit1,
      //      _StandardWorkQuantityUnit2,
      //      _StandardWorkQuantityUnit3,
      //      _StandardWorkQuantityUnit4,
      //      _StandardWorkQuantityUnit5,
      //      _StandardWorkQuantityUnit6,
      //      _Supplier,
      //      _WorkCenter,
      //      _WorkCenterType
}

//where
//  SuperiorOperationInternalID = '00000000'
