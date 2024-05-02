@AbapCatalog.sqlViewName: '/SIMPLE/IBOSEQUE'
@AccessControl.authorizationCheck: #CHECK
//@VDM.viewType: #BASIC
//@Analytics.dataCategory: #DIMENSION
//@ClientHandling.algorithm: #SESSION_VARIABLE
//@ObjectModel.representativeKey: 'BillOfOperationsSequence'
//@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Sequence'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
//@Search.searchable: true
//@Metadata.allowExtensions:true
//@AbapCatalog.preserveKey:true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BOOSequence
  as select distinct from plfl

  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType      on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup     on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
                                                                                     and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
  --  to root, to parent
  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations          on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
                                                                                     and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
                                                                                     and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
  -- to child
  association [1..*] to /SIMPLE/I_BOOSequenceChgState  as _BOOSequenceChangeState    on  $projection.BillOfOperationsType     = _BOOSequenceChangeState.BillOfOperationsType
                                                                                     and $projection.BillOfOperationsGroup    = _BOOSequenceChangeState.BillOfOperationsGroup
                                                                                     and $projection.BillOfOperationsVariant  = _BOOSequenceChangeState.BillOfOperationsVariant
                                                                                     and $projection.BillOfOperationsSequence = _BOOSequenceChangeState.BillOfOperationsSequence
  -- to child
  association [1..*] to /SIMPLE/I_BOOOPERATION         as _BillOfOperationsOperation on  $projection.BillOfOperationsType     = _BillOfOperationsOperation.BillOfOperationsType
                                                                                     and $projection.BillOfOperationsGroup    = _BillOfOperationsOperation.BillOfOperationsGroup
                                                                                     and $projection.BillOfOperationsVariant  = _BillOfOperationsOperation.BillOfOperationsVariant
                                                                                     and $projection.BillOfOperationsSequence = _BillOfOperationsOperation.BillOfOperationsSequence

{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plfl.plnty as BillOfOperationsType,
//      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key plfl.plnnr as BillOfOperationsGroup,
//      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillOfOperationsStdVH', element: 'BillOfOperationsVariant' } } ]
//      @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plfl.plnal as BillOfOperationsVariant,
      // representative key BillOfOperationsSequence
  key plfl.plnfl as BillOfOperationsSequence,

      // Associations
      _BillOfOperationsType,
      _BillOfOperationsGroup,
      // !! DO NOT USE @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT ]
      _BillOfOperations,
      // !! DO NOT USE @ObjectModel.association.type: #TO_COMPOSITION_CHILD
      _BOOSequenceChangeState,
      // !! DO NOT USE @ObjectModel.association.type: #TO_COMPOSITION_CHILD
      _BillOfOperationsOperation
}
