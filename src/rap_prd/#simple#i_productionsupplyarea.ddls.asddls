@AbapCatalog.sqlViewName: '/SIMPLE/PRDSPA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.privilegedAssociations: ['_ResponsiblePerson', '_Address']
@AccessControl.personalData.blocking: #REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true
@Metadata.allowExtensions: true
//  @ObjectModel.representativeKey: 'ProductionSupplyArea'
//  @ObjectModel.semanticKey: 'ProductionSupplyArea'
//  @ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@Search.searchable: true
@EndUserText.label: 'Production Supply Area'

define view /SIMPLE/I_PrdSupplyArea
  as select from pvbe as pvbe
//  association [1..1] to /SIMPLE/I_Plant                    as _Plant             on  $projection.Plant = _Plant.Plant
//  association [0..1] to /SIMPLE/I_StorageLocation          as _StorageLocation   on  $projection.Plant           = _StorageLocation.Plant
//                                                                         and $projection.StorageLocation = _StorageLocation.StorageLocation
//  association [0..1] to /SIMPLE/I_MRPController            as _ResponsiblePerson on  $projection.Plant                          = _ResponsiblePerson.Plant
//                                                                         and $projection.ProductionSupplyAreaRespPerson = _ResponsiblePerson.MRPController
//  association [0..*] to /SIMPLE/I_PrdSupplyAreaText as _Text              on  $projection.Plant                = _Text.Plant
//                                                                         and $projection.ProductionSupplyArea = _Text.ProductionSupplyArea
//  association [0..1] to /SIMPLE/I_Address                  as _Address           on  $projection.AddressID = _Address.AddressID
//  association [0..1] to /SIMPLE/I_FactoryCalendar          as _FactoryCalendar   on  $projection.FactoryCalendar = _FactoryCalendar.FactoryCalendar
//  association [0..1] to /SIMPLE/I_ShiftGrouping            as _ShiftGrouping     on  $projection.ShiftGrouping = _ShiftGrouping.ShiftGrouping
//  association [0..1] to /SIMPLE/I_ShiftSquence            as _ShiftSequence     on  $projection.ShiftSequence = _ShiftSequence.ShiftSequence 
//                                                                         and $projection.ShiftGrouping = _ShiftSequence.ShiftGrouping
{
      // Key
      //  @ObjectModel.text.association: '_Text'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key cast(pvbe.prvbe as vdm_prvbe preserving type)       as ProductionSupplyArea,
      //  @ObjectModel.foreignKey.association: '_Plant'
  key pvbe.werks                                          as Plant,

      // Attributes
      //  @ObjectModel.foreignKey.association: '_StorageLocation'
      cast(pvbe.lgort as pph_lgort preserving type)       as StorageLocation,
      @Semantics.text: true
      pvbe.ablad                                          as UnloadingPointName,
      //  @ObjectModel.foreignKey.association: '_Address'
      pvbe.pvadr                                          as AddressID,
      //  @ObjectModel.foreignKey.association: '_ResponsiblePerson'
      pvbe.rgver                                          as ProductionSupplyAreaRespPerson,
//      //  @ObjectModel.foreignKey.association: '_FactoryCalendar'
      cast(pvbe.fabklv as fabkl preserving type)          as FactoryCalendar,
      //  @ObjectModel.foreignKey.association: '_ShiftGrouping'
      pvbe.schgrupv                                       as ShiftGrouping,
//      //  @ObjectModel.foreignKey.association: '_ShiftSequence'
      pvbe.sprogv                                         as ShiftSequence,
      pvbe.pintvd                                         as PullIntervalInWorkdays,
   // pvbe.pintvm                                         as PullIntervalInHoursAndMinutes,
      cast(pvbe.pintvm as pintv_hrs_min)                  as PullIntervalInHoursAndMinutes,  // cast to identical type to avoid conversion exit      
      pvbe.lgbzo                                          as UnloadingWarehouseStagingArea,
      pvbe.lastchange_datetime                            as LastChangeDateTime

      // Associations
//      _Plant,
//      _Text,
//      _StorageLocation,
//      _Address,
//      _ResponsiblePerson,
////      _FactoryCalendar,
//      _ShiftGrouping,
//      _ShiftSequence
      
};
