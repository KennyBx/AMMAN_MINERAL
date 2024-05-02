@AbapCatalog.sqlViewName: '/SIMPLE/IBOGROUP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #NOT_REQUIRED
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #M, dataClass: #MASTER }
@ObjectModel.representativeKey: 'BillOfOperationsGroup'
@ObjectModel.semanticKey: ['BillOfOperationsType', 'BillOfOperationsGroup']
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Bill of Operations Group'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BillOfOperationGroup
  as select distinct from plko

//  association [1..1] to /SIMPLE/I_BillOfOperationType as _BillOfOperationsType on $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType

{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key cast(plnty as billofoperationstype preserving type)  as BillOfOperationsType,
  key cast(plnnr as billofoperationsgroup preserving type) as BillOfOperationsGroup,

      plko.versn                                           as BillOfOperationsVersion

      // Associations
//      _BillOfOperationsType
};
