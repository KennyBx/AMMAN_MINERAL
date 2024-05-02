@AbapCatalog.sqlViewName: '/SIMPLE/IBOINTID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true 
@AccessControl.authorizationCheck: #NOT_REQUIRED
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
@ObjectModel.representativeKey: 'BOOOperationInternalID'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #L, dataClass: #MASTER }
@Search.searchable: true
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Bill of Operations Operation Internal ID'
@Metadata.allowExtensions:true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BOOOpInternalID
  as select distinct from plpo
//
//  association [1..1] to /SIMPLE/I_BillOfOperationType    as _BillOfOperationsType  on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup   as _BillOfOperationsGroup on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                          and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup

{
      // Key
//      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plpo.plnty                                           as BillOfOperationsType,
//      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key plpo.plnnr                                           as BillOfOperationsGroup,

  key plpo.plnkn                                           as BOOOperationInternalID,
      plpo.vornr                                           as Operation
      // Associations
//      _BillOfOperationsType,
//      _BillOfOperationsGroup
};
