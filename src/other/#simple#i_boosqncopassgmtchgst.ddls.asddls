@AbapCatalog.sqlViewName: '/SIMPLE/IBOSOACS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'BOOSqncOpAssgmtIntVersionCntr'
@AbapCatalog.compiler.compareFilter: true
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER }
@EndUserText.label: 'Bill of Operations Sequence Operation Assignment Chg State'
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true 

define view /SIMPLE/I_BOOSqncOpAssgmtChgSt
  as select from plas

  association [1..1] to /SIMPLE/I_BillOfOperationType       as _BillOfOperationsType     on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
  association [1..1] to /SIMPLE/I_BillOfOperationGroup      as _BillOfOperationsGroup    on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
                                                                                and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
  association [1..1] to /SIMPLE/I_BillOfOperation           as _BillOfOperations         on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
                                                                                and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
                                                                                and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
  association [1..1] to /SIMPLE/I_BOOSequence               as _BillOfOperationsSequence on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
                                                                                and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
                                                                                and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
                                                                                and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence
  association [1..1] to /SIMPLE/I_BOOOpInternalID           as _BOOOperationInternalID   on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
                                                                                and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
                                                                                and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID
  association [0..1] to I_ChangeMaster              as _ChangeMaster             on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber


{
      // @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plas.plnty                                                     as   BillOfOperationsType,
      // @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key plas.plnnr                                                     as   BillOfOperationsGroup,
      // @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plas.plnal                                                     as   BillOfOperationsVariant,
      // @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key plas.plnfl                                                     as   BillOfOperationsSequence,
      // @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key plas.plnkn                                                     as   BOOOperationInternalID,
  key plas.zaehl                                                     as   BOOSqncOpAssgmtIntVersionCntr,

      @Semantics.businessDate.from: true
      cast(plas.datuv as vdm_v_validity_start_date preserving type)  as   ValidityStartDate,
      @Semantics.businessDate.to: true
      cast(plas.valid_to as vdm_v_validity_end_date preserving type) as   ValidityEndDate,

      plas.loekz                                                     as   IsDeleted,
      plas.loekz_inherited                                           as   IsImplicitlyDeleted,

      // @ObjectModel.foreignKey.association: '_ChangeMaster'
      cast (plas.aennr as changenumber preserving type)              as   ChangeNumber,

      // Administration Data
      @Semantics.systemDate.createdAt: true
      cast (plas.andat as creationdate preserving type)              as   CreationDate,
      cast (plas.annam as vdm_createdbyuserid preserving type)       as   CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      cast (plas.aedat as lastchangedate preserving type)            as   LastChangeDate,
      cast (plas.aenam as vdm_lastchangedbyuserid preserving type)   as   LastChangedByUser,

      plas.versn                                                     as   BillOfOperationsVersion,

      _BillOfOperationsType,
      _BillOfOperationsGroup,
      _BillOfOperations,
      _BillOfOperationsSequence,
      _BOOOperationInternalID,
      _ChangeMaster

}
