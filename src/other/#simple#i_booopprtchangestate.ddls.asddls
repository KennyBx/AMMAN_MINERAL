@AbapCatalog.sqlViewName: '/SIMPLE/IBOPRTCS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
//@Analytics: {dataCategory: #DIMENSION}
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'BOOOperationPRTIntVersCounter'
@AbapCatalog.compiler.compareFilter: true
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Search.searchable: true
@EndUserText.label: 'BOO Operation Production Resource/Tool Change State'
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BOOOpPRTChangeState
  as select from plfh

//  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType          on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup         on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//
//  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations              on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                                         and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
//
//  association [1..1] to /SIMPLE/I_BOOOpInternalID      as _BOOOperationInternalID        on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
//                                                                                         and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID
//
//  association [1..1] to /SIMPLE/I_BOOSequence          as _BillOfOperationsSequence      on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
//                                                                                         and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
//                                                                                         and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence
//
//  association [1..1] to /SIMPLE/I_BOOOPERATION         as _BillOfOperationsOperation     on  $projection.BillOfOperationsType     = _BillOfOperationsOperation.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup    = _BillOfOperationsOperation.BillOfOperationsGroup
//                                                                                         and $projection.BillOfOperationsVariant  = _BillOfOperationsOperation.BillOfOperationsVariant
//                                                                                         and $projection.BillOfOperationsSequence = _BillOfOperationsOperation.BillOfOperationsSequence
//                                                                                         and $projection.BOOOperationInternalID   = _BillOfOperationsOperation.BOOOperationInternalID
//
//  association [1..1] to /SIMPLE/I_BOOOprPRTInternalID  as _BOOOperationPRTInternalID     on  $projection.BillOfOperationsType      = _BOOOperationPRTInternalID.BillOfOperationsType
//                                                                                         and $projection.BillOfOperationsGroup     = _BOOOperationPRTInternalID.BillOfOperationsGroup
//                                                                                         and $projection.BillOfOperationsVariant   = _BOOOperationPRTInternalID.BillOfOperationsVariant
//                                                                                         and $projection.BillOfOperationsSequence  = _BOOOperationPRTInternalID.BillOfOperationsSequence
//                                                                                         and $projection.BOOOperationInternalID    = _BOOOperationPRTInternalID.BOOOperationInternalID
//                                                                                         and $projection.BOOOperationPRTInternalID = _BOOOperationPRTInternalID.BOOOperationPRTInternalID
//
//  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _ProductionResourceToolUnit    on  $projection.ProdnRsceToolStdWorkQtyUnit = _ProductionResourceToolUnit.UnitOfMeasure
//  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _ProdnResourceToolUsageUnit    on  $projection.ProdnRsceToolUsageQuantityUnit = _ProdnResourceToolUsageUnit.UnitOfMeasure
//
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
//  association [1..1] to /SIMPLE/I_ProductionRsceType   as _ProductionResourceType        on  $projection.ProductionResourceType = _ProductionResourceType.ProductionResourceType
  association [1..1] to /SIMPLE/I_PRTMasterData        as _ProdnRsceToolMasterData       on  $projection.ProductionResourceType       = _ProdnRsceToolMasterData.ProductionResourceType
                                                                                         and $projection.ProductionResourceInternalID = _ProdnRsceToolMasterData.ProductionResourceInternalID

//  association [1..1] to /SIMPLE/I_PRTStandardText      as _ProdnRsceToolStandardText     on  $projection.ProdnRsceToolStandardTextCode = _ProdnRsceToolStandardText.ProdnRsceToolStandardTextCode
//
//  association [0..1] to /SIMPLE/I_PRTControlProfile    as _ProdnRsceToolControlProfile   on  $projection.ProdnRsceToolControlProfile = _ProdnRsceToolControlProfile.ProdnRsceToolControlProfile
//  association [1..1] to /SIMPLE/I_PRTQtyCalcFormula    as _ProdnRsceToolTotQtyCalcFmla   on  $projection.ProdnRsceToolTotQtyCalcFormula = _ProdnRsceToolTotQtyCalcFmla.ProdnRsceToolQtyCalcFormula
//  association [1..1] to /SIMPLE/I_PRTQtyCalcFormula    as _ProdnRsceToolUsageQtyCalcFmla on  $projection.ProdnRsceToolUsageQtyCalcFmla = _ProdnRsceToolUsageQtyCalcFmla.ProdnRsceToolQtyCalcFormula
//
//  association [1..1] to /SIMPLE/I_OpDateOffsetRefCode  as _StartDateOffsetReferenceCode  on  $projection.StartDateOffsetReferenceCode = _StartDateOffsetReferenceCode.OperationDateOffsetRefCode
//  association [1..1] to /SIMPLE/I_OpDateOffsetRefCode  as _EndDateOffsetReferenceCode    on  $projection.EndDateOffsetReferenceCode = _EndDateOffsetReferenceCode.OperationDateOffsetRefCode
//
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _StartDateOffsetDurationUnit   on  $projection.StartDateOffsetDurationUnit = _StartDateOffsetDurationUnit.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _EndDateOffsetDurationUnit     on  $projection.EndDateOffsetDurationUnit = _EndDateOffsetDurationUnit.UnitOfMeasure
//
//  association [1..1] to /SIMPLE/I_User                 as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
//  association [0..1] to /SIMPLE/I_User                 as _LastChangedByUser             on  $projection.LastChangedByUser = _LastChangedByUser.UserID
//  association [0..1] to /SIMPLE/I_ChangeMaster         as _ChangeMaster                  on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber

{
           // @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key      plfh.plnty                                                  as BillOfOperationsType,

           // @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
           @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key      plfh.plnnr                                                  as BillOfOperationsGroup,

           // @ObjectModel.foreignKey.association: '_BillOfOperations'
  key      plfh.plnal                                                  as BillOfOperationsVariant,

           // @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key      plfh.plnfl                                                  as BillOfOperationsSequence,

           // @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key      plfh.plnkn                                                  as BOOOperationInternalID,

           // @ObjectModel.foreignKey.association:  '_BOOOperationPRTInternalID'
  key      plfh.pzlfh                                                  as BOOOperationPRTInternalID,

  key      plfh.zaehl                                                  as BOOOperationPRTIntVersCounter,

           // @ObjectModel.foreignKey.association: '_ProductionResourceType'
           plfh.objty                                                  as ProductionResourceType,

           // @ObjectModel.foreignKey.association: '_ProdnRsceToolMasterData'
           plfh.objid                                                  as ProductionResourceInternalID,

           @Semantics.businessDate.from: true
           plfh.datuv                                                  as ValidityStartDate,
           @Semantics.businessDate.to: true
           plfh.valid_to                                               as ValidityEndDate,

           // @ObjectModel.foreignKey.association: '_ChangeMaster'
           plfh.aennr                                                  as ChangeNumber,
           plfh.psnfh                                                  as ProdnRsceToolItemNumber,

           // @ObjectModel.foreignKey.association: '_ProdnRsceToolControlProfile'
           plfh.steuf                                                  as ProdnRsceToolControlProfile,

           // @ObjectModel.foreignKey.association: '_ProdnRsceToolStandardText'
           plfh.ktsch                                                  as ProdnRsceToolStandardTextCode,

           @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
           @Semantics.text: true
           plfh.txtz1                                                  as ProdnRsceToolText,

           // Admin
           @Semantics.systemDate.createdAt: true
           datui                                                       as CreationDate,
           //      // @ObjectModel.foreignKey.association: '_CreatedByUser'
           @Semantics.user.createdBy: true
           cast(plfh.useri as vdm_createdbyuserid preserving type)     as CreatedByUser,
           @Semantics.systemDate.lastChangedAt: true
           datuc                                                       as LastChangeDate,
           //      // @ObjectModel.foreignKey.association: '_LastChangedByUser'
           @Semantics.user.lastChangedBy: true
           cast(plfh.userc as vdm_lastchangedbyuserid preserving type) as LastChangedByUser,

           plfh.loekz                                                  as IsDeleted,
           plfh.loekz_inherited                                        as IsImplicitlyDeleted,

           // @ObjectModel.foreignKey.association: '_ProductionResourceToolUnit'
           @Semantics.unitOfMeasure: true
           plfh.mgeinh                                                 as ProdnRsceToolStdWorkQtyUnit,
           @Semantics.quantity.unitOfMeasure: 'ProdnRsceToolStdWorkQtyUnit'
           @DefaultAggregation: #NONE
           plfh.mgvgw                                                  as ProdnRsceToolStandardWorkQty,
           // @ObjectModel.foreignKey.association: '_ProdnRsceToolTotQtyCalcFmla'
           plfh.mgform                                                 as ProdnRsceToolTotQtyCalcFormula,

           // @ObjectModel.foreignKey.association: '_ProdnResourceToolUsageUnit'
           @Semantics.unitOfMeasure: true
           plfh.eweinh                                                 as ProdnRsceToolUsageQuantityUnit,
           @Semantics.quantity.unitOfMeasure: 'ProdnRsceToolUsageQuantityUnit'
           @DefaultAggregation: #NONE
           plfh.ewvgw                                                  as ProdnRsceToolUsageQuantity,
           // @ObjectModel.foreignKey.association: '_ProdnRsceToolUsageQtyCalcFmla'
           plfh.ewform                                                 as ProdnRsceToolUsageQtyCalcFmla,

           // @ObjectModel.foreignKey.association: '_StartDateOffsetReferenceCode'
           plfh.bzoffb                                                 as StartDateOffsetReferenceCode,
           // @ObjectModel.foreignKey.association: '_StartDateOffsetDurationUnit'
           @Semantics.unitOfMeasure: true
           plfh.ehoffb                                                 as StartDateOffsetDurationUnit,
           @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
           @DefaultAggregation: #SUM
           plfh.offstb                                                 as StartDateOffsetDuration,

           // @ObjectModel.foreignKey.association: '_EndDateOffsetReferenceCode'
           plfh.bzoffe                                                 as EndDateOffsetReferenceCode,
           // @ObjectModel.foreignKey.association: '_EndDateOffsetDurationUnit'
           @Semantics.unitOfMeasure: true
           plfh.ehoffe                                                 as EndDateOffsetDurationUnit,
           @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
           @DefaultAggregation: #SUM
           plfh.offste                                                 as EndDateOffsetDuration,

           plfh.versn                                                  as BillOfOperationsVersion,

//           _BillOfOperationsType,
//           _BillOfOperationsGroup,
//           _BillOfOperations,
//           _BOOOperationInternalID,
//           _BillOfOperationsOperation,
//           _BillOfOperationsSequence,
//           _BOOOperationPRTInternalID,
//
//           _ProductionResourceType,
           _ProdnRsceToolMasterData
//           _ProdnRsceToolControlProfile,
//           _ProdnRsceToolTotQtyCalcFmla,
//           _ProdnRsceToolUsageQtyCalcFmla,
//           _ProdnRsceToolStandardText,
//           _ProductionResourceToolUnit,
//           _ProdnResourceToolUsageUnit,
//           _StartDateOffsetReferenceCode,
//           _StartDateOffsetDurationUnit,
//           _EndDateOffsetReferenceCode,
//           _EndDateOffsetDurationUnit,
//           _CreatedByUser,
//           _LastChangedByUser,
//           _ChangeMaster
}
