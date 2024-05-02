@AbapCatalog.sqlViewName: '/SIMPLE/IBOOOPR'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BOOOperationInternalID'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Operation'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER }
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true 

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BOOOPERATION
  as select distinct from I_BillOfOperationsOpBasic as plpo
    inner join            plas on  plas.plnty    =  plpo.BillOfOperationsType
                               and plas.plnnr    =  plpo.BillOfOperationsGroup
                               and plas.plnkn    =  plpo.BOOOperationInternalID
                               and plas.datuv    <= plpo.ValidityEndDate
                               and plas.valid_to >= plpo.ValidityStartDate

//  association [1..1] to /SIMPLE/I_BillOfOperationType         as _BillOfOperationsType         on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup        as _BillOfOperationsGroup        on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//
//  -- to root
//  association [1..1] to /SIMPLE/I_BillOfOperation             as _BillOfOperations             on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
//  -- to parent
//  association [1..1] to I_BillOfOperationsSequence     as _BillOfOperationsSequence     on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence
//  -- to child
//  association [1..*] to I_BOOOperationChangeState      as _BOOOperationChangeState      on  $projection.BillOfOperationsType     = _BOOOperationChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOperationChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOperationChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOperationChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOperationChangeState.BOOOperationInternalID
//
//  association [0..*] to I_BOOOpBOMItemChangeState      as _BOOOpBOMItemChangeState      on  $projection.BillOfOperationsType     = _BOOOpBOMItemChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOpBOMItemChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOpBOMItemChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOpBOMItemChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOpBOMItemChangeState.BOOOperationInternalID
//
//  association [0..*] to I_BOOOpMaterialPRTChangeState  as _BOOOpMaterialPRTChangeState  on  $projection.BillOfOperationsType     = _BOOOpMaterialPRTChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOpMaterialPRTChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOpMaterialPRTChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOpMaterialPRTChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOpMaterialPRTChangeState.BOOOperationInternalID
//
//  association [0..*] to I_BOOOpEquipmentPRTChangeState as _BOOOpEquipmentPRTChangeState on  $projection.BillOfOperationsType     = _BOOOpEquipmentPRTChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOpEquipmentPRTChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOpEquipmentPRTChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOpEquipmentPRTChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOpEquipmentPRTChangeState.BOOOperationInternalID
//
//  association [0..*] to I_BOOOpMiscPRTChangeState      as _BOOOpMiscPRTChangeState      on  $projection.BillOfOperationsType     = _BOOOpMiscPRTChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOpMiscPRTChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOpMiscPRTChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOpMiscPRTChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOpMiscPRTChangeState.BOOOperationInternalID
//
//  association [0..*] to I_BOOOpDocumentPRTChangeState  as _BOOOpDocumentPRTChangeState  on  $projection.BillOfOperationsType     = _BOOOpDocumentPRTChangeState.BillOfOperationsType
//                                                                                        and $projection.BillOfOperationsGroup    = _BOOOpDocumentPRTChangeState.BillOfOperationsGroup
//                                                                                        and $projection.BillOfOperationsVariant  = _BOOOpDocumentPRTChangeState.BillOfOperationsVariant
//                                                                                        and $projection.BillOfOperationsSequence = _BOOOpDocumentPRTChangeState.BillOfOperationsSequence
//                                                                                        and $projection.BOOOperationInternalID   = _BOOOpDocumentPRTChangeState.BOOOperationInternalID

{
//      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plas.plnty                                           as BillOfOperationsType,

//      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key plas.plnnr                                           as BillOfOperationsGroup,

//      @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plas.plnal                                           as BillOfOperationsVariant,

//      @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key plas.plnfl                                           as BillOfOperationsSequence,

  key plas.plnkn                                           as BOOOperationInternalID

//
//      _BillOfOperationsType,
//      _BillOfOperationsGroup,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT ]
//      _BillOfOperations,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_PARENT ]
//      _BillOfOperationsSequence,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOperationChangeState,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOpBOMItemChangeState,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOpMaterialPRTChangeState,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOpEquipmentPRTChangeState,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOpMiscPRTChangeState,
//
//      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
//      _BOOOpDocumentPRTChangeState
}
