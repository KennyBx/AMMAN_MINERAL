@AbapCatalog.sqlViewName: '/SIMPLE/IEQPRTIK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@ObjectModel.semanticKey: 'Equipment'
@Analytics.dataCategory: #DIMENSION
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Equipment PRT by internal key'
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions:true

define view /SIMPLE/I_EquiPRTByInternalKey
  as select from /SIMPLE/I_PRTMasterData as PRT
    inner join   crve_a on  crve_a.objty = PRT.ProductionResourceType
                        and crve_a.objid = PRT.ProductionResourceInternalID

  association [1..1] to I_Equipment              as _Equipment              on $projection.Equipment = _Equipment.Equipment

  association [1..1] to I_EquipmentProdnRsceTool as _EquipmentProdnRsceTool on $projection.Equipment = _EquipmentProdnRsceTool.Equipment

{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key PRT.ProductionResourceType,
  key PRT.ProductionResourceInternalID,
      @ObjectModel.foreignKey.association: '_EquipmentProdnRsceTool'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      crve_a.equnr as Equipment,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      PRT.ProductionResourceToolGroup1,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      PRT.ProductionResourceToolGroup2,
      PRT.ProductionResourceUsage,
      ProdnRsceToolControlProfile,
      @ObjectModel.foreignKey.association: '_ChangeMaster'
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
      _Equipment,
      _EquipmentProdnRsceTool,
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

      _CreatedByUser,
      _LastChangedByUser,
      _ChangeMaster
}
where
  PRT.ProdnRsceToolCategory = 'E' // Equipment
