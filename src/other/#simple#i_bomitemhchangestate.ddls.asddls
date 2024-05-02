@AbapCatalog.sqlViewName: '/SIMPLE/IBIHCHST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Item with Header Changes'
@ObjectModel.updateEnabled: true
@ObjectModel.createEnabled: true
@Search.searchable: true
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_BOMItemHChangeState
  as select from /SIMPLE/I_BillOfMatComponent as valid_items
  //                 inner join /SIMPLE/I_BillOfMaterial as stko on
  //                            valid_items.BillOfMaterial = stko.BillOfMaterial and
  //                            valid_items.BillOfMaterialCategory = stko.BillOfMaterialCategory and
  //                            valid_items.BillOfMaterialVariant = stko.BillOfMaterialVariant and
  //                            valid_items.BillOfMaterialVersion = stko.BillOfMaterialVersion
    inner join   /SIMPLE/I_MaterialBOMMain    as stko on  valid_items.BillOfMaterial         = stko.BillOfMaterial
                                                      and valid_items.BillOfMaterialCategory = stko.BillOfMaterialCategory
                                                      and valid_items.BillOfMaterialVariant  = stko.BillOfMaterialVariant
{
  key    cast( valid_items.BillOfMaterial as /simple/stnum preserving type ) as BillOfMaterial,
         //@ObjectModel.readOnly: true
  key    valid_items.BillOfMaterialCategory,
         //@ObjectModel.readOnly: true
  key    valid_items.BillOfMaterialVariant,
         //  key    valid_items.BillOfMaterialVersion,
         --stko.Plant,
         //@ObjectModel.readOnly: true
  key    valid_items.BillOfMaterialItemNodeNumber,
         //@ObjectModel.readOnly: true
         --@EndUserText.label: ''
  key    valid_items.BOMItemInternalChangeCount,
         //@ObjectModel.readOnly: true
  key    valid_items.BillOfMaterialItemUUID,
         //  key stko.EngineeringChangeDocument as HeaderChangeDocument,
         stko.Material                                                       as Material,
         // Begin insert bye Doris Dang - 20230112
         stko.EquipmentNumber                                                as EquipmentNumber,
         stko.FunctionalLocation                                             as FunctionalLocation,
         // Begin insert bye Doris Dang - 20230112
         stko.Plant                                                          as Plant,
         stko.BillOfMaterialVariantUsage,
         //      stko.BillOfMaterialHeaderUUID as BillOfMaterialHeaderUUID,
         //      stko.IsVersionBillOfMaterial,

         //@ObjectModel.readOnly: true
         @Semantics.businessDate.from: true
         valid_items.ValidityStartDate,
         //@ObjectModel.readOnly: true
         @Semantics.businessDate.to: true
         valid_items.ValidityEndDate,
         //@ObjectModel.readOnly: true
         valid_items.EngineeringChangeDocument,
         //@ObjectModel.readOnly: true
         valid_items.ChgToEngineeringChgDocument,
         //@ObjectModel.readOnly: true
         valid_items.InheritedNodeNumberForBOMItem,
         //@ObjectModel.readOnly: true
         valid_items.InheritedNodeNumberVersionBOM,
         --@ObjectModel.readOnly: true
         //valid_items.BOMItemNodeCount,
         //@ObjectModel.readOnly: true
         -- @Semantics.businessDate.createdAt: true
         valid_items.BOMItemRecordCreationDate,
         //@ObjectModel.readOnly: true
         valid_items.BOMItemCreatedByUser,
         valid_items.BOMItemLastChangeDate,
         valid_items.BOMItemLastChangedByUser,
         @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
         valid_items.BillOfMaterialComponent,
         @ObjectModel.foreignKey.association: '_BOMItemCategory'
         valid_items.BillOfMaterialItemCategory,
         valid_items.BillOfMaterialItemNumber,
         @Semantics.unitOfMeasure: true
         //         @ObjectModel.foreignKey.association: '_UnitOfMeasure'
         valid_items.BillOfMaterialItemUnit,
         @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
         @DefaultAggregation :#NONE
         --  @ObjectModel.updateEnabled: true
         valid_items.BillOfMaterialItemQuantity,
         cast( valid_items.IsAssembly as stlkz preserving type )             as IsAssembly,
         //'' as AssemblyIndicator,
         valid_items.IsSubItem,
         valid_items.BOMItemSorter,
         valid_items.FixedQuantity,
         valid_items.PurchasingGroup,
         @Semantics.currencyCode: true
         //         @ObjectModel.foreignKey.association: '_Currency'
         valid_items.Currency,
         @Semantics.amount.currencyCode : 'Currency'
         @DefaultAggregation :#NONE
         -- @ObjectModel.updateEnabled: true
         valid_items.MaterialComponentPrice,
         valid_items.IdentifierBOMItem,
         --  @ObjectModel.updateEnabled: true
         valid_items.MaterialPriceUnitQty,
         --  @ObjectModel.updateEnabled: true
         valid_items.ComponentScrapInPercent,
         --  @ObjectModel.updateEnabled: true
         valid_items.OperationScrapInPercent,
         --   @ObjectModel.updateEnabled: true
         valid_items.IsNetScrap,
         --   @ObjectModel.updateEnabled: true
         valid_items.NumberOfVariableSizeItem,
         -- @ObjectModel.updateEnabled: true
         valid_items.QuantityVariableSizeItem,
         --   @ObjectModel.updateEnabled: true
         valid_items.FormulaKey,
         --   @ObjectModel.updateEnabled: true
         valid_items.BOMItemDescription,
         --    @ObjectModel.updateEnabled: true
         valid_items.BOMItemText2,
         valid_items.ComponentDescription,
         valid_items.MaterialGroup,
         --   @ObjectModel.updateEnabled: true
         valid_items.DocumentType,
         --  @ObjectModel.updateEnabled: true
         valid_items.DocNumber,
         --  @ObjectModel.updateEnabled: true
         valid_items.DocumentVersion,
         --  @ObjectModel.updateEnabled: true
         valid_items.DocumentPart,
         valid_items.ClassNumber,
         valid_items.ClassType,
         valid_items.ResultingItemCategory,
         valid_items.DependencyObjectNumber,
         valid_items.ObjectType,
         valid_items.IsClassificationRelevant,
         valid_items.IsBulkMaterial,
         valid_items.BOMItemIsSparePart,
         valid_items.BOMItemIsSalesRelevant,
         valid_items.IsProductionRelevant,
         valid_items.BOMItemIsPlantMaintRelevant,
         valid_items.BOMItemIsCostingRelevant,
         valid_items.IsEngineeringRelevant,
         valid_items.SpecialProcurementType,
         valid_items.IsBOMRecursiveAllowed,
         valid_items.OperationLeadTimeOffset,
         valid_items.OpsLeadTimeOffsetUnit,
         valid_items.IsMaterialProvision,
         valid_items.BOMIsRecursive,
         valid_items.DocumentIsCreatedByCAD,
         valid_items.DistrKeyCompConsumption,
         valid_items.DeliveryDurationInDays,
         valid_items.Creditor,
         valid_items.CostElement,
         valid_items.Size1,
         valid_items.Size2,
         valid_items.Size3,
         valid_items.VariableSizeCompUnitOfMeasure,
         valid_items.UnitOfMeasureForVarSizeItem,
         valid_items.UnitOfMeasureForSize1To3,
         valid_items.GoodsReceiptDuration,
         valid_items.PurchasingOrganization,
         valid_items.RequiredComponent,
         valid_items.MultipleSelectionAllowed,
         valid_items.ProdOrderIssueLocation,
         valid_items.MaterialIsCoProduct,
         valid_items.ExplosionType,
         valid_items.FollowUpGroup,
         valid_items.DiscontinuationGroup,
         valid_items.IsConfigurableBOM,
         valid_items.ReferencePoint,
         valid_items.LeadTimeOffset,
         valid_items.IsSoftwareComponent,
         valid_items.ProductionSupplyArea,
         valid_items.IsDeleted,
         valid_items.IsALE,
         valid_items.MaterialComponentIsPhantomItem,
         valid_items.IsPhantomItem,
         valid_items.BillOfMaterialItemCategoryDesc                          as BillOfMaterialItemCategoryDesc,
         valid_items.LastChangeDateTime                                      as LastChangeDateTime,
         //Alternative Item Fields
         valid_items.AlternativeItemGroup,
         valid_items.AlternativeItemPriority,
         valid_items.AlternativeItemStrategy,
         valid_items.UsageProbabilityPercent,
         valid_items.IsPMAssemblyRelevant,
         valid_items.SortString,
         valid_items.LongItemTextLanguage,
         valid_items.LongItemText,
         _BOMItemCategory,
         //_Material,
         valid_items._UnitOfMeasure,
         _Currency,
         //_BillOfMaterialVariantUsage,
         valid_items._Mast,
         valid_items._Dost,
         valid_items._Prst,
         valid_items._Kdst,
         valid_items._Eqst,
         valid_items._Tpst,
         valid_items._Stst

}
//  as select from /SIMPLE/I_BillOfMatComponent as valid_items
//                 inner join /SIMPLE/I_BillOfMaterial as stko on
//                            valid_items.BillOfMaterial = stko.BillOfMaterial and
//                            valid_items.BillOfMaterialCategory = stko.BillOfMaterialCategory and
//                            valid_items.BillOfMaterialVariant = stko.BillOfMaterialVariant and
//                            valid_items.BillOfMaterialVersion = stko.BillOfMaterialVersion
//{
//  key    valid_items.BillOfMaterial,
//     //@ObjectModel.readOnly: true
//  key  valid_items.BillOfMaterialCategory,
//      //@ObjectModel.readOnly: true
//  key    valid_items.BillOfMaterialVariant,
//  key    valid_items.BillOfMaterialVersion,
//      --stko.Plant,
//      @ObjectModel.readOnly: true
//  key    valid_items.BillOfMaterialItemNodeNumber,
//      @ObjectModel.readOnly: true
//  key valid_items.BillOfMaterialItemUUID,
//  key stko.EngineeringChangeDocument as HeaderChangeDocument,
//   stko._Mast.Material                   as Material,
//   stko._Mast.Plant                      as Plant,
//      stko.BillOfMaterialVariantUsage,
//      stko.BillOfMaterialHeaderUUID as BillOfMaterialHeaderUUID,
//      stko.IsVersionBillOfMaterial,
//      @ObjectModel.readOnly: true
//      --@EndUserText.label: ''
//      valid_items.BOMItemInternalChangeCount,
//      //@ObjectModel.readOnly: true
//      @Semantics.businessDate.from: true
//      valid_items.ValidityStartDate,
//      //@ObjectModel.readOnly: true
//      @Semantics.businessDate.to: true
//      valid_items.ValidityEndDate,
//      //@ObjectModel.readOnly: true
//      valid_items.EngineeringChangeDocument,
//      @ObjectModel.readOnly: true
//      valid_items.ChgToEngineeringChgDocument,
//      @ObjectModel.readOnly: true
//      valid_items.InheritedNodeNumberForBOMItem,
//      @ObjectModel.readOnly: true
//      valid_items.InheritedNodeNumberVersionBOM,
//      --@ObjectModel.readOnly: true
//      //valid_items.BOMItemNodeCount,
//      @ObjectModel.readOnly: true
//     -- @Semantics.businessDate.createdAt: true
//      valid_items.BOMItemRecordCreationDate,
//      @ObjectModel.readOnly: true
//      valid_items.BOMItemCreatedByUser,
//      valid_items.BOMItemLastChangeDate,
//      valid_items.BOMItemLastChangedByUser,
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
//      valid_items.BillOfMaterialComponent,
//      @ObjectModel.foreignKey.association: '_BOMItemCategory'
//      valid_items.BillOfMaterialItemCategory,
//      valid_items.BillOfMaterialItemNumber,
//      @Semantics.unitOfMeasure: true
//      @ObjectModel.foreignKey.association: '_UnitOfMeasure'
//      valid_items.BillOfMaterialItemUnit,
//      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
//      @DefaultAggregation :#NONE
//    --  @ObjectModel.updateEnabled: true
//      valid_items.BillOfMaterialItemQuantity,
//      cast( valid_items.IsAssembly as stlkz preserving type )      as IsAssembly,
//      //'' as AssemblyIndicator,
//      valid_items.IsSubItem,
//      valid_items.BOMItemSorter,
//      valid_items.FixedQuantity,
//      valid_items.PurchasingGroup,
//      @Semantics.currencyCode: true
//      @ObjectModel.foreignKey.association: '_Currency'
//      valid_items.Currency,
//      @Semantics.amount.currencyCode : 'Currency'
//      @DefaultAggregation :#NONE
//     -- @ObjectModel.updateEnabled: true
//      valid_items.MaterialComponentPrice,
//      valid_items.IdentifierBOMItem,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.MaterialPriceUnitQty,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.ComponentScrapInPercent,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.OperationScrapInPercent,
//   --   @ObjectModel.updateEnabled: true
//      valid_items.IsNetScrap,
//   --   @ObjectModel.updateEnabled: true
//      valid_items.NumberOfVariableSizeItem,
//     -- @ObjectModel.updateEnabled: true
//      valid_items.QuantityVariableSizeItem,
//   --   @ObjectModel.updateEnabled: true
//      valid_items.FormulaKey,
//   --   @ObjectModel.updateEnabled: true
//      valid_items.BOMItemDescription,
//  --    @ObjectModel.updateEnabled: true
//      valid_items.BOMItemText2,
//      valid_items.ComponentDescription,
//      valid_items.MaterialGroup,
//   --   @ObjectModel.updateEnabled: true
//      valid_items.DocumentType,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.DocNumber,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.DocumentVersion,
//    --  @ObjectModel.updateEnabled: true
//      valid_items.DocumentPart,
//      valid_items.ClassNumber,
//      valid_items.ClassType,
//      valid_items.ResultingItemCategory,
//      valid_items.DependencyObjectNumber,
//      valid_items.ObjectType,
//      valid_items.IsClassificationRelevant,
//      valid_items.IsBulkMaterial,
//      valid_items.BOMItemIsSparePart,
//      valid_items.BOMItemIsSalesRelevant,
//      valid_items.IsProductionRelevant,
//      valid_items.BOMItemIsPlantMaintRelevant,
//      valid_items.BOMItemIsCostingRelevant,
//      valid_items.IsEngineeringRelevant,
//      valid_items.SpecialProcurementType,
//      valid_items.IsBOMRecursiveAllowed,
//      valid_items.OperationLeadTimeOffset,
//      valid_items.OpsLeadTimeOffsetUnit,
//      valid_items.IsMaterialProvision,
//      valid_items.BOMIsRecursive,
//      valid_items.DocumentIsCreatedByCAD,
//      valid_items.DistrKeyCompConsumption,
//      valid_items.DeliveryDurationInDays,
//      valid_items.Creditor,
//      valid_items.CostElement,
//      valid_items.Size1,
//      valid_items.Size2,
//      valid_items.Size3,
//      valid_items.VariableSizeCompUnitOfMeasure,
//      valid_items.UnitOfMeasureForVarSizeItem,
//      valid_items.UnitOfMeasureForSize1To3,
//      valid_items.GoodsReceiptDuration,
//      valid_items.PurchasingOrganization,
//      valid_items.RequiredComponent,
//      valid_items.MultipleSelectionAllowed,
//      valid_items.ProdOrderIssueLocation,
//      valid_items.MaterialIsCoProduct,
//      valid_items.ExplosionType,
//      valid_items.FollowUpGroup,
//      valid_items.DiscontinuationGroup,
//      valid_items.IsConfigurableBOM,
//      valid_items.ReferencePoint,
//      valid_items.LeadTimeOffset,
//      valid_items.IsSoftwareComponent,
//      valid_items.ProductionSupplyArea,
//      valid_items.IsDeleted,
//      valid_items.IsALE,
//      valid_items.MaterialComponentIsPhantomItem,
//      valid_items.IsPhantomItem,
//      valid_items.BillOfMaterialItemCategoryDesc as BillOfMaterialItemCategoryDesc,
//      valid_items.LastChangeDateTime             as LastChangeDateTime,
////Alternative Item Fields
//      valid_items.AlternativeItemGroup,
//      valid_items.AlternativeItemPriority,
//      valid_items.AlternativeItemStrategy,
//      valid_items.UsageProbabilityPercent,
//      valid_items.IsPMAssemblyRelevant,
//      valid_items.SortString,
//      _BOMItemCategory,
//      //_Material,
//      valid_items._UnitOfMeasure,
//      _Currency,
//      //_BillOfMaterialVariantUsage,
//      valid_items._Mast,
//      valid_items._Dost,
//      valid_items._Prst,
//      valid_items._Kdst,
//      valid_items._Eqst,
//      valid_items._Tpst,
//      valid_items._Stst
//
//  }
