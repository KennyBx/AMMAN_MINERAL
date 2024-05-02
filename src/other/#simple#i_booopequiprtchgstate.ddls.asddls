@AbapCatalog.sqlViewName: '/SIMPLE/IBEPRTCS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #COMPOSITE
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'BOOOpEquipPRTIntVersCounter'
@AbapCatalog.compiler.compareFilter: true
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Search.searchable: true
@EndUserText.label: 'BOO Operation Equipment Prod. Resource/Tool Change State'
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true 

define view /SIMPLE/I_BOOOpEquiPRTChgState
  as select from /SIMPLE/I_BOOOpPRTChangeState as I_BOOOperationPRTChangeState
    inner join   /SIMPLE/I_EquiPRTByInternalKey as I_EquipmentPRTByInternalKey
     on  I_BOOOperationPRTChangeState.ProductionResourceType       = I_EquipmentPRTByInternalKey.ProductionResourceType
                                             and I_BOOOperationPRTChangeState.ProductionResourceInternalID = I_EquipmentPRTByInternalKey.ProductionResourceInternalID

  association [1..1] to /SIMPLE/I_EquiPRTByInternalKey as _EquipmentPRTByInternalKey on  $projection.ProductionResourceType       = _EquipmentPRTByInternalKey.ProductionResourceType
                                                                                  and $projection.ProductionResourceInternalID = _EquipmentPRTByInternalKey.ProductionResourceInternalID

{
      // @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key I_BOOOperationPRTChangeState.BillOfOperationsType,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key I_BOOOperationPRTChangeState.BillOfOperationsGroup,

      // @ObjectModel.foreignKey.association: '_BillOfOperations'
  key I_BOOOperationPRTChangeState.BillOfOperationsVariant,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key I_BOOOperationPRTChangeState.BillOfOperationsSequence,

      // @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key I_BOOOperationPRTChangeState.BOOOperationInternalID,

      // @ObjectModel.foreignKey.association:  '_BOOOperationPRTInternalID'
  key I_BOOOperationPRTChangeState.BOOOperationPRTInternalID     as   BOOOpEquipmentPRTInternalID,

  key I_BOOOperationPRTChangeState.BOOOperationPRTIntVersCounter as   BOOOpEquipPRTIntVersCounter,

      // @ObjectModel.foreignKey.association: '_ProductionResourceType'
      I_BOOOperationPRTChangeState.ProductionResourceType,

//      // @ObjectModel.foreignKey.association: '_ProdnRsceToolMasterData'
      I_BOOOperationPRTChangeState.ProductionResourceInternalID,

      @Semantics.businessDate.from: true
      I_BOOOperationPRTChangeState.ValidityStartDate,
      @Semantics.businessDate.to: true
      ValidityEndDate,

      // @ObjectModel.foreignKey.association: '_ChangeMaster'
      I_BOOOperationPRTChangeState.ChangeNumber,
      I_BOOOperationPRTChangeState.ProdnRsceToolItemNumber,

      // @ObjectModel.foreignKey.association: '_ProdnRsceToolControlProfile'
      I_BOOOperationPRTChangeState.ProdnRsceToolControlProfile,

      // @ObjectModel.foreignKey.association: '_ProdnRsceToolStandardText'
      I_BOOOperationPRTChangeState.ProdnRsceToolStandardTextCode,

      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      @Semantics.text: true
      I_BOOOperationPRTChangeState.ProdnRsceToolText,

      // Admin
      @Semantics.businessDate.createdAt: true
      I_BOOOperationPRTChangeState.CreationDate,
      //      // @ObjectModel.foreignKey.association: '_CreatedByUser'
      @Semantics.user.createdBy: true
      I_BOOOperationPRTChangeState.CreatedByUser,
      @Semantics.businessDate.lastChangedAt: true
      I_BOOOperationPRTChangeState.LastChangeDate,
      //      // @ObjectModel.foreignKey.association: '_LastChangedByUser'
      @Semantics.user.lastChangedBy: true
      I_BOOOperationPRTChangeState.LastChangedByUser,

      IsDeleted,
      IsImplicitlyDeleted,

      // @ObjectModel.foreignKey.association: '_ProductionResourceToolUnit'
      @Semantics.unitOfMeasure: true
      I_BOOOperationPRTChangeState.ProdnRsceToolStdWorkQtyUnit,
      @Semantics.quantity.unitOfMeasure: 'ProdnRsceToolStdWorkQtyUnit'
      @DefaultAggregation: #NONE
      I_BOOOperationPRTChangeState.ProdnRsceToolStandardWorkQty,
      // @ObjectModel.foreignKey.association: '_ProdnRsceToolTotQtyCalcFmla'
      I_BOOOperationPRTChangeState.ProdnRsceToolTotQtyCalcFormula,

      // @ObjectModel.foreignKey.association: '_ProdnResourceToolUsageUnit'
      @Semantics.unitOfMeasure: true
      I_BOOOperationPRTChangeState.ProdnRsceToolUsageQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'ProdnRsceToolUsageQuantityUnit'
      @DefaultAggregation: #NONE
      I_BOOOperationPRTChangeState.ProdnRsceToolUsageQuantity,
      // @ObjectModel.foreignKey.association: '_ProdnRsceToolUsageQtyCalcFmla'
      I_BOOOperationPRTChangeState.ProdnRsceToolUsageQtyCalcFmla,

      // @ObjectModel.foreignKey.association: '_StartDateOffsetReferenceCode'
      I_BOOOperationPRTChangeState.StartDateOffsetReferenceCode,
      // @ObjectModel.foreignKey.association: '_StartDateOffsetDurationUnit'
      @Semantics.unitOfMeasure: true
      I_BOOOperationPRTChangeState.StartDateOffsetDurationUnit,
      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      I_BOOOperationPRTChangeState.StartDateOffsetDuration,

      // @ObjectModel.foreignKey.association: '_EndDateOffsetReferenceCode'
      I_BOOOperationPRTChangeState.EndDateOffsetReferenceCode,
      // @ObjectModel.foreignKey.association: '_EndDateOffsetDurationUnit'
      @Semantics.unitOfMeasure: true
      I_BOOOperationPRTChangeState.EndDateOffsetDurationUnit,
      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      I_BOOOperationPRTChangeState.EndDateOffsetDuration,

      I_BOOOperationPRTChangeState.BillOfOperationsVersion,

      _EquipmentPRTByInternalKey
//
//      I_BOOOperationPRTChangeState._BillOfOperationsType,
//      I_BOOOperationPRTChangeState._BillOfOperationsGroup,
//      // !! DO NOT USE // @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT ]
//      I_BOOOperationPRTChangeState._BillOfOperations,
//      // !! DO NOT USE // @ObjectModel.association.type: [ #TO_COMPOSITION_PARENT ]
//      I_BOOOperationPRTChangeState._BillOfOperationsOperation,
//      I_BOOOperationPRTChangeState._BOOOperationInternalID,
//      I_BOOOperationPRTChangeState._BillOfOperationsSequence,
//      I_BOOOperationPRTChangeState._BOOOperationPRTInternalID,
//
//      I_BOOOperationPRTChangeState._ProductionResourceType,
//      I_BOOOperationPRTChangeState._ProdnRsceToolMasterData,
//      I_BOOOperationPRTChangeState._ProdnRsceToolControlProfile,
//      I_BOOOperationPRTChangeState._ProdnRsceToolTotQtyCalcFmla,
//      I_BOOOperationPRTChangeState._ProdnRsceToolUsageQtyCalcFmla,
//      I_BOOOperationPRTChangeState._ProdnRsceToolStandardText,
//      I_BOOOperationPRTChangeState._ProductionResourceToolUnit,
//      I_BOOOperationPRTChangeState._ProdnResourceToolUsageUnit,
//      I_BOOOperationPRTChangeState._StartDateOffsetReferenceCode,
//      I_BOOOperationPRTChangeState._StartDateOffsetDurationUnit,
//      I_BOOOperationPRTChangeState._EndDateOffsetReferenceCode,
//      I_BOOOperationPRTChangeState._EndDateOffsetDurationUnit,
//      I_BOOOperationPRTChangeState._CreatedByUser,
//      I_BOOOperationPRTChangeState._LastChangedByUser,
//      I_BOOOperationPRTChangeState._ChangeMaster
} 
  
  
 