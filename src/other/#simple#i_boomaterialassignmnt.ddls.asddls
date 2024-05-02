@AbapCatalog.sqlViewName: '/SIMPLE/IBOMATAS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
//  @ObjectModel.representativeKey: 'BOOToMaterialInternalID'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Material assgmt. to Bill of Operations'
//  @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Search.searchable: true
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true 

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view /SIMPLE/I_BOOMaterialAssignmnt
  as select distinct from mapl

//  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType  on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                          and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations      on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                          and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                          and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
//  association [1..1] to /SIMPLE/I_Plant                 as _Plant                 on  $projection.Plant = _Plant.Plant
//  association [1..1] to /SIMPLE/I_Material              as _Material              on  $projection.Material = _Material.Material

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialStdVH', element: 'Material' } } ]
      //  @ObjectModel.foreignKey.association: '_Material'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key mapl.matnr                    as   Material,
      //  @ObjectModel.foreignKey.association: '_Plant'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key mapl.werks                    as   Plant,
      //  @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key mapl.plnty                    as   BillOfOperationsType,

      //  @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key mapl.plnnr                    as   BillOfOperationsGroup,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillOfOperationsStdVH', element: 'BillOfOperationsVariant' } } ]
      //  @ObjectModel.foreignKey.association: '_BillOfOperations'
  key mapl.plnal                    as   BillOfOperationsVariant,
  key mapl.zkriz                    as   BOOToMaterialInternalID

//      _Material,
//      _Plant,
//      _BillOfOperationsType,
//      _BillOfOperationsGroup,
//      // !! DO NOT USE //  @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT ]
//      _BillOfOperations
}
