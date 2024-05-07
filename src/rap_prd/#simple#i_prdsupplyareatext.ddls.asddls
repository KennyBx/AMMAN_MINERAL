@AbapCatalog.sqlViewName: '/SIMPLE/IPRDSPAT'
@AbapCatalog.preserveKey: true
@EndUserText.label: 'Production Supply Area Text'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'ProductionSupplyArea'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER }
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations:true

@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC

define view /SIMPLE/I_PrdSupplyAreaText
  as select from pvkt as pvkt

  association [1..1] to /SIMPLE/I_Plant    as _Plant    on $projection.Plant = _Plant.Plant
  association [1..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
      @ObjectModel.text.element: 'ProductionSupplyAreaName'
  key pvkt.prvbe                                    as ProductionSupplyArea,
      @ObjectModel.foreignKey.association: '_Plant'
  key pvkt.werks                                    as Plant,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key pvkt.spras                                    as Language,

      // Text
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      @Semantics.text: true
      cast(pvkt.pvbtx as vdm_pvbtx preserving type) as ProductionSupplyAreaName,

      // Associations
      _Plant,
      _Language
};
