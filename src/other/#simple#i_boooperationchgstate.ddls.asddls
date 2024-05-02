@AbapCatalog.sqlViewName: '/SIMPLE/IBOOPCHS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@Analytics: {dataCategory: #DIMENSION}
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'BOOOpInternalVersionCounter'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Operation Change State'
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER }
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BOOOperationChgState
  as select from /SIMPLE/P_BOOOperationChgState
  //
  //  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType        on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
  //
  //  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup       on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
  //                                                                                       and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
  //
  //  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations            on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
  //                                                                                       and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
  //                                                                                       and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
  //
  //  association [1..1] to /SIMPLE/I_BOOOpInternalID      as _BOOOperationInternalID      on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
  //                                                                                       and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
  //                                                                                       and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID
  //
  //  association [1..1] to /SIMPLE/I_BOOSequence          as _BillOfOperationsSequence    on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
  //                                                                                       and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
  //                                                                                       and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
  //                                                                                       and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence
  //
  //  association [1..1] to /SIMPLE/I_BOOSqncOpAssgmtChgSt as _BOOSqncOperationAssgmtChgSt on  $projection.BillOfOperationsType          = _BOOSqncOperationAssgmtChgSt.BillOfOperationsType
  //                                                                                       and $projection.BillOfOperationsGroup         = _BOOSqncOperationAssgmtChgSt.BillOfOperationsGroup
  //                                                                                       and $projection.BillOfOperationsVariant       = _BOOSqncOperationAssgmtChgSt.BillOfOperationsVariant
  //                                                                                       and $projection.BillOfOperationsSequence      = _BOOSqncOperationAssgmtChgSt.BillOfOperationsSequence
  //                                                                                       and $projection.BOOOperationInternalID        = _BOOSqncOperationAssgmtChgSt.BOOOperationInternalID
  //                                                                                       and $projection.BOOSqncOpAssgmtIntVersionCntr = _BOOSqncOperationAssgmtChgSt.BOOSqncOpAssgmtIntVersionCntr

{
      // @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key BillOfOperationsType,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key BillOfOperationsGroup,

      // @ObjectModel.foreignKey.association: '_BillOfOperations'
  key BillOfOperationsVariant,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key BillOfOperationsSequence,

      // @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key BOOOperationInternalID,

      // @ObjectModel.foreignKey.association: '_BOOSqncOperationAssgmtChgSt'
      BOOSqncOpAssgmtIntVersionCntr,

      // @ObjectModel.text.element: 'OperationText'
      BOOOpInternalVersionCounter,

      BillOfOperationsVersion, // NOT a key field in THIS view !

      // ***************** Technical fields not on the CEWB-UI *****************

      WorkCenterInternalID,
      WorkCenterTypeCode,

      IsDeleted,
      IsImplicitlyDeleted,

      // ************************** Operation Header ***************************

      OperationExternalID,
      Operation,

      // ************************** Operation General **************************

      -- Operation
      OperationText,

      Plant,

      OperationControlProfile,

      OperationStandardTextCode,

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

      StandardWorkFormulaParam1,
      StandardWorkQuantity1,
      StandardWorkQuantityUnit1,
      CostCtrActivityType1,
      PerfEfficiencyRatioCode1,

      StandardWorkFormulaParam2,
      StandardWorkQuantity2,
      StandardWorkQuantityUnit2,
      CostCtrActivityType2,
      PerfEfficiencyRatioCode2,

      StandardWorkFormulaParam3,
      StandardWorkQuantity3,
      StandardWorkQuantityUnit3,
      CostCtrActivityType3,
      PerfEfficiencyRatioCode3,

      StandardWorkFormulaParam4,
      StandardWorkQuantity4,
      StandardWorkQuantityUnit4,
      CostCtrActivityType4,
      PerfEfficiencyRatioCode4,

      StandardWorkFormulaParam5,
      StandardWorkQuantity5,
      StandardWorkQuantityUnit5,
      CostCtrActivityType5,
      PerfEfficiencyRatioCode5,

      StandardWorkFormulaParam6,
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

      NumberOfTimeTickets,
      NumberOfConfirmationSlips,

      EmployeeWageGroup,
      EmployeeWageType,

      EmployeeSuitability,

      NumberOfEmployees,

      -- Setup
      OperationSetupType,

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
      CreationDate,
      CreatedByUser,

      LastChangeDate,
      LastChangedByUser,

      -- Validity
      ChangeNumber,

      ValidityStartDate,
      ValidityEndDate,

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
      WorkCenterOpSetIndicator,
      ReferenceElementPMPS,
      RequestingCostCenter,
      COAreaRequestCostCenter,
      ExecutionFactor,
      RefDateForStartOfSubOp,
      RefDateForFinishOfSubOp,
      TypeOfCAPPOrderOpening,
      InternalClassNumber,
      AggregationWeightPOC,
      AverageExecFactor,
      FlexibleDurationIndicator,
      InstallationPointForSubitem,
      @Semantics.unitOfMeasure: true
      UnitOffsetToStart,
      @Semantics.unitOfMeasure: true
      UnitOffsetToEnd,
      ConstraintOfStartDate,
      ConstraintOfEndDate,
      AggregationWeightPOC2,
      CAPPTextExistsIndicator,
      IsGroupOperation,
      EarlyLatePossibleActivity,
      BillOfMaterialItemNodeNumber,
      BillOfMaterialNumber,
      BOMItemInternalChangeCount,
      BillOfMaterialCategory,
      BOMSubItem,
      BillOfOperationCost,
      CapacityCategory,
      ObjectDependencyAssignmentNumb,
      PlanningObject,
      LotSizeIndepntExternalProcess,
      OperationText2,
      ManufacturingProcess,
      ModelID,
      MESOperationNumber,
      MESStepID,
      MilestoneUsage,
      PSPriority,
      OffsetToSubOperationStart,
      OffsetToSubOperationEnd,
      PackageNumber,
      InactiveChangesIndicator,
      PrinterForShopPaper,
      OperationPriority,
      CostsInActivity,
      StandardWBSElement,
      InspQuantityReference,
      InspTimeRelatedInterval,
      InspLastPartialLotAssignment,
      InspQuantityConfirmEPartialLot,
      InspectionObjectID,
      InspectionObjectType,
      @Semantics.unitOfMeasure: true
      InspGridUnitOfMeasure,
      InspGridQuantity,
      QuantityBetweenTwoInspections,
      InspectionTimeUnit,
      InspectionTimeFactor,
      RefPointBOMTransfer,
      RoundingNAdditionalValues,
      ReworkFactor,
      SubGroupCounter,
      SubGroup,
      SubType,
      TechnicalStatusFrom,
      OperationIncrement,
      RefSequenceRouting,
      ExcludeSub,
      ReferenceNumberSVCode,
      TypeOfStdValueDetermin,
      DateOfStdValueCalculate,
      CalculationBasis,
      ActivityOperation,
      SubOperation,
      //End adding missing field

      // **************************** Associations *****************************

      //      _BOOOperationInternalID,
      //      _BOOSqncOperationAssgmtChgSt,
      _BillOfOperations,
      //      _BillOfOperationsBreakDurnUnit,
      _BillOfOperationsGroup,
      _BillOfOperationsSequence,
      _BillOfOperationsType,
      //      _CapacityCategory,
      _ChangeMaster
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
