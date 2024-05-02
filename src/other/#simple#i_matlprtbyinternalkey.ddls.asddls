@AbapCatalog.sqlViewName: '/SIMPLE/IMPRTIK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@ObjectModel.semanticKey: 'Material'
@Analytics.dataCategory: #DIMENSION
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material PRT by internal key'
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions:true

define view /SIMPLE/I_MatlPRTByInternalKey
  as select from /SIMPLE/I_PRTMasterData as PRT
    inner join   crvm_a on  crvm_a.objty = PRT.ProductionResourceType
                        and crvm_a.objid = PRT.ProductionResourceInternalID

  association [1..1] to /SIMPLE/I_Material             as _Material              on  $projection.Material = _Material.Material

  association [1..1] to /SIMPLE/I_Plant                as _Plant                 on  $projection.Plant = _Plant.Plant

//  association [1..1] to /SIMPLE/I_MaterialProdRsceTool as _MaterialProdnRsceTool on  $projection.Plant    = _MaterialProdnRsceTool.Plant
//                                                                                 and $projection.Material = _MaterialProdnRsceTool.Material

{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key PRT.ProductionResourceType,
  key PRT.ProductionResourceInternalID,
      // Assignments
//      @ObjectModel.foreignKey.association: '_ProdnRsceToolCategory'
      PRT.ProdnRsceToolCategory,
      @ObjectModel.foreignKey.association: '_Plant'
      @Search: {defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8}
      crvm_a.werks as Plant,
//      @ObjectModel.foreignKey.association: '_MaterialProdnRsceTool'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      crvm_a.matnr as Material,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      PRT.ProductionResourceToolGroup1,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      PRT.ProductionResourceToolGroup2,
      PRT.ProductionResourceUsage,
      ProdnRsceToolControlProfile,
      PRT.ChangeNumber,
      ProdnRsceToolStandardTextCode,
      ProdnRsceToolTotQtyCalcFormula,
      ProdnRsceToolUsageQtyCalcFmla,
      StartDateOffsetReferenceCode,
      EndDateOffsetReferenceCode,

      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      StartDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      StartDateOffsetDurationUnit,
      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      EndDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      EndDateOffsetDurationUnit,

      // Admin
      @Semantics.businessDate.createdAt: true
      CreationDate,
      @Semantics.user.createdBy: true
      CreatedByUser,
      @Semantics.businessDate.lastChangedAt: true
      LastChangeDate,
      @Semantics.user.lastChangedBy: true
      LastChangedByUser,

      _ProductionResourceType,
      _Material,
      _Plant,
      _ProdnRsceToolGroup1,
      _ProdnRsceToolGroup2,
      _ProductionResourceUsage,
      _ProdnRsceToolControlProfile,
      _ProdnRsceToolStandardText,
      _ProdnRsceToolTotQtyCalcFmla,
      _ProdnRsceToolUsageQtyCalcFmla,
      _StartDateOffsetReferenceCode,
      _EndDateOffsetReferenceCode,
      _StartDateOffsetDurationUnit,
      _EndDateOffsetDurationUnit,

//      _MaterialProdnRsceTool,

      _CreatedByUser,
      _LastChangedByUser,
      _ChangeMaster,
      _ProdnRsceToolCategory
}
where
  PRT.ProdnRsceToolCategory = 'M' // Material
