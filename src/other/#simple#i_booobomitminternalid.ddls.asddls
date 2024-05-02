@AbapCatalog.sqlViewName: '/SIMPLE/IBOBOMID'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BOOOpBOMItemInternalID'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Operation BOM Item Internal ID'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Search.searchable: true
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BOOOBOMItmInternalID
  as select distinct from plmz

//  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType     on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup    on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                                    and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//
//  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations         on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                                    and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                                    and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant

//  association [1..1] to /SIMPLE/I_BOOSequence          as _BillOfOperationsSequence on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
//                                                                                    and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
//                                                                                    and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
//                                                                                    and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence

//  association [1..1] to /SIMPLE/I_BOOOpInternalID      as _BOOOperationInternalID   on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
//                                                                                    and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
//                                                                                    and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID

{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plmz.plnty as BillOfOperationsType,

//      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key plmz.plnnr as BillOfOperationsGroup,

//      @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plmz.plnal as BillOfOperationsVariant,

      @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key plmz.plnfl as BillOfOperationsSequence,

      @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key plmz.plnkn as BOOOperationInternalID,

  key plmz.zuonr as BOOOpBOMItemInternalID

//      _BillOfOperationsType,
//      _BillOfOperationsGroup,
//      _BillOfOperations
//      _BOOOperationInternalID
//      _BillOfOperationsSequence

}
