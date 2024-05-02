@AbapCatalog.sqlViewName: '/SIMPLE/IBOSQCHS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Sequence Change State'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true 

define view /SIMPLE/I_BOOSequenceChgState
  as select from plfl

  association [1..1] to /SIMPLE/I_BillOfOperationType        as _BillOfOperationsType         on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType

  association [1..1] to /SIMPLE/I_BillOfOperationGroup       as _BillOfOperationsGroup        on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
                                                                                              and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup

  association [1..1] to /SIMPLE/I_BillOfOperation            as _BillOfOperations             on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
  association [1..1] to /SIMPLE/I_BOOSequence    as _BillOfOperationsSequence     on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence

  association [1..1] to I_BillOfOperationsSequenceCat as _BillOfOperationsSequenceCat  on  $projection.BillOfOperationsSequenceCat = _BillOfOperationsSequenceCat.BillOfOperationsSequenceCat

  association [0..1] to I_SequenceSchedulingAlignment as _SequenceSchedulingAlignment  on  $projection.SequenceSchedulingAlignment = _SequenceSchedulingAlignment.SequenceSchedulingAlignment

  association [1..1] to /SIMPLE/I_BOOSequence    as _BillOfOperationsRefSequence  on  $projection.BillOfOperationsType        = _BillOfOperationsRefSequence.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup       = _BillOfOperationsRefSequence.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant     = _BillOfOperationsRefSequence.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsRefSequence = _BillOfOperationsRefSequence.BillOfOperationsSequence

  association [0..1] to /SIMPLE/I_BOOOPERATION   as _BOOOperationsBranchOperation on  $projection.BillOfOperationsType        = _BOOOperationsBranchOperation.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup       = _BOOOperationsBranchOperation.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant     = _BOOOperationsBranchOperation.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsRefSequence = _BOOOperationsBranchOperation.BillOfOperationsSequence
                                                                                       and $projection.BOOSqncBranchOpInternalID   = _BOOOperationsBranchOperation.BOOOperationInternalID

  association [0..1] to /SIMPLE/I_BOOOPERATION   as _BOOOperationsReturnOperation on  $projection.BillOfOperationsType        = _BOOOperationsReturnOperation.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup       = _BOOOperationsReturnOperation.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant     = _BOOOperationsReturnOperation.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsRefSequence = _BOOOperationsReturnOperation.BillOfOperationsSequence
                                                                                       and $projection.BOOSqncReturnOpInternalID   = _BOOOperationsReturnOperation.BOOOperationInternalID

  association [0..1] to I_ChangeMaster                as _ChangeMaster                 on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber

{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plfl.plnty                                                     as   BillOfOperationsType,
  key plfl.plnnr                                                     as   BillOfOperationsGroup,
  key plfl.plnal                                                     as   BillOfOperationsVariant,
  key plfl.plnfl                                                     as   BillOfOperationsSequence,
  key plfl.zaehl                                                     as   BOOSqncInternalVersionCounter,

      // NOT a key field in THIS view !
      plfl.versn                                                     as   BillOfOperationsVersion,

      // ***************** Technical fields not on the CEWB-UI *****************

      plfl.loekz                                                     as   IsDeleted,
      plfl.loekz_inherited                                           as   IsImplicitlyDeleted,

      // *************************** Sequence Detail ***************************

      -- Sequence
      @ObjectModel.foreignKey.association: '_BillOfOperationsSequenceCat'
      plfl.flgat                                                     as   BillOfOperationsSequenceCat,

      @Semantics.text: true
      plfl.ltxa1                                                     as   SequenceText,

      @ObjectModel.foreignKey.association: '_SequenceSchedulingAlignment'
      plfl.auschl                                                    as   SequenceSchedulingAlignment,

      -- Reference
      @ObjectModel.foreignKey.association: '_BillOfOperationsRefSequence'
      plfl.bezfl                                                     as   BillOfOperationsRefSequence,

      @ObjectModel.foreignKey.association: '_BOOOperationsBranchOperation'
      plfl.bknt1                                                     as   BOOSqncBranchOpInternalID,
      @ObjectModel.foreignKey.association: '_BOOOperationsReturnOperation'
      plfl.bknt2                                                     as   BOOSqncReturnOpInternalID,

      -- Alternative Sequence
      plfl.losvn                                                     as   MinimumLotSizeQuantity,
      plfl.losbs                                                     as   MaximumLotSizeQuantity,

      -- Administrative Data
      @ObjectModel.foreignKey.association: '_ChangeMaster'
      plfl.aennr                                                     as   ChangeNumber,

      @Semantics.businessDate.from: true
      cast(plfl.datuv  as pph_begda preserving type)  as   ValidityStartDate,
      @Semantics.businessDate.to: true
      cast(plfl.valid_to as pph_endda preserving type) as   ValidityEndDate,

      @Semantics.systemDate.createdAt: true
      plfl.andat                                                     as   CreationDate,
      cast(plfl.annam as vdm_createdbyuserid preserving type)        as   CreatedByUser,
      
      @Semantics.systemDate.lastChangedAt: true
      plfl.aedat                                                     as   LastChangeDate,
      cast(plfl.aenam as vdm_lastchangedbyuserid preserving type)    as   LastChangedByUser,

      // Start adding missing fields
      bschl1 as RelationshipBranchOp,
      bschl2 as RelationshipReturnOp,
      knobj as ObjDependencyAssignmentNumber,
      parkz as InactiveChangesIndicator,
      techv as TechnicalStatusFrom,
      txtsp as LanguageKey,
      // End adding missing fields
      // **************************** Associations *****************************

      _BOOOperationsBranchOperation,
      _BOOOperationsReturnOperation,
      _BillOfOperations,
      _BillOfOperationsGroup,
      _BillOfOperationsRefSequence,
      _BillOfOperationsSequence,
      _BillOfOperationsSequenceCat,
      _BillOfOperationsType,
      _ChangeMaster,
      _SequenceSchedulingAlignment
}
