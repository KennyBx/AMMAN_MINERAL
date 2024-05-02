@AbapCatalog.sqlViewName: '/SIMPLE/IBOMITEM'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Items'
@ObjectModel.updateEnabled: true
@ObjectModel.createEnabled: true
@Search.searchable: false

define view /SIMPLE/I_BillOfMaterialItem
  as select from /SIMPLE/P_BOMItems as valid_items
  association [1..1] to /SIMPLE/I_BOMItemCategory as _BOMItemCategory on  $projection.BillOfMaterialItemCategory = _BOMItemCategory.BillOfMaterialItemCategory
  association [0..1] to /SIMPLE/I_BomItemCatText as _BOMItemCategoryText                on  $projection.BillOfMaterialItemCategory = _BOMItemCategoryText.BillOfMaterialItemCategory
                                                                                     and _BOMItemCategoryText.Language = $session.system_language
  //association [0..1] to I_Material                   as _Material        on  $projection.BillOfMaterialComponent = _Material.Material
  association [1..1] to /SIMPLE/I_UnitOfMeasure              as _UnitOfMeasure   on  $projection.BillOfMaterialItemUnit = _UnitOfMeasure.UnitOfMeasure
  //association [1..1] to I_BillOfMaterialUsage        as _BillOfMaterialVariantUsage on  $projection.billofmaterialvariantusage = _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage
  association [1..1] to /SIMPLE/I_Currency                   as _Currency        on  $projection.Currency = _Currency.Currency
  association [0..*] to /SIMPLE/I_MaterialBOMLink            as _Mast            on  $projection.BillOfMaterialCategory = _Mast.BillOfMaterialCategory
                                                                         and $projection.BillOfMaterial         = _Mast.BillOfMaterial
                                                                         and $projection.BillOfMaterialVariant  = _Mast.BillOfMaterialVariant
//  association [0..1] to /SIMPLE/I_DocumentBOMLink            as _Dost            on  $projection.BillOfMaterialCategory = _Dost.BillOfMaterialCategory
//                                                                         and $projection.BillOfMaterial         = _Dost.BillOfMaterial
//                                                                         and $projection.BillOfMaterialVariant  = _Dost.BillOfMaterialVariant
//  association [0..1] to /SIMPLE/I_Prst                       as _Prst            on  $projection.BillOfMaterialCategory = _Prst.BillOfMaterialCategory
//                                                                         and $projection.BillOfMaterial         = _Prst.BillOfMaterial
//                                                                         and $projection.BillOfMaterialVariant  = _Prst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_SalesOrderBOMLink          as _Kdst            on  $projection.BillOfMaterialCategory = _Kdst.BillOfMaterialCategory
                                                                         and $projection.BillOfMaterial         = _Kdst.BillOfMaterial
                                                                         and $projection.BillOfMaterialVariant  = _Kdst.BillOfMaterialVariant
//  association [0..1] to /SIMPLE/I_Eqst                       as _Eqst            on  $projection.BillOfMaterialCategory = _Eqst.BillOfMaterialCategory
//                                                                         and $projection.BillOfMaterial         = _Eqst.BillOfMaterial
//                                                                         and $projection.BillOfMaterialVariant  = _Eqst.BillOfMaterialVariant
//  association [0..1] to /SIMPLE/I_Tpst                       as _Tpst            on  $projection.BillOfMaterialCategory = _Tpst.BillOfMaterialCategory
//                                                                         and $projection.BillOfMaterial         = _Tpst.BillOfMaterial
//                                                                         and $projection.BillOfMaterialVariant  = _Tpst.BillOfMaterialVariant
//  association [0..1] to /SIMPLE/I_STST                       as _Stst            on  $projection.BillOfMaterialCategory = _Stst.BillOfMaterialCategory
//                                                                         and $projection.BillOfMaterial         = _Stst.BillOfMaterial
//                                                                         and $projection.BillOfMaterialVariant  = _Stst.BillOfMaterialVariant
                                                                         
 
 
//                                                                                                                                                            
{
      @ObjectModel.readOnly: true
  key valid_items.BillOfMaterialItemUUID,
      //' '                                          as Material, // To be removed
      //' '                                          as Plant, // To be removed
      //@ObjectModel.foreignKey.association: '_BillOfMaterialVariantUsage'
      //@ObjectModel.updateEnabled: true
      //' ' as BillOfMaterialVariantUsage, // To be removed
      //@ObjectModel.readOnly: true
      valid_items.BillOfMaterialCategory,
      //@ObjectModel.readOnly: true
      valid_items.BillOfMaterial,
      //@ObjectModel.readOnly: true
      valid_items.BillOfMaterialVariant,
      @ObjectModel.readOnly: true
      valid_items.BillOfMaterialItemNodeNumber,
      @ObjectModel.readOnly: true
      --@EndUserText.label: ''
      valid_items.BOMItemInternalChangeCount,
      valid_items.BillOfMaterialVersion, 
      //@ObjectModel.readOnly: true
      @Semantics.businessDate.from: true
      valid_items.ValidityStartDate,
      //@ObjectModel.readOnly: true
      @Semantics.businessDate.to: true
      valid_items.ValidityEndDate,
      //@ObjectModel.readOnly: true
      valid_items.ChangeNumberFrom                                 as EngineeringChangeDocument,
      @ObjectModel.readOnly: true
      cast( valid_items.ChangeNumberTo as aenra preserving type )  as ChgToEngineeringChgDocument,
      @ObjectModel.readOnly: true
      valid_items.InheritedNodeNumberForBOMItem,
      @ObjectModel.readOnly: true
      valid_items.InheritedNodeNumberVersionBOM,
      --@ObjectModel.readOnly: true
      //valid_items.BOMItemNodeCount,
      @ObjectModel.readOnly: true
      @Semantics.businessDate.createdAt: true
      valid_items.BOMItemRecordCreationDate,
      @ObjectModel.readOnly: true
      valid_items.BOMItemCreatedByUser,
      valid_items.BOMItemLastChangeDate,
      valid_items.BOMItemLastChangedByUser,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      valid_items.BillOfMaterialComponent,
      ' '                                                          as MaterialName, // To be removed
      @ObjectModel.foreignKey.association: '_BOMItemCategory'
      valid_items.BillOfMaterialItemCategory,
      valid_items.BillOfMaterialItemNumber,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_UnitOfMeasure'
      case when _BOMItemCategory.FixedItemCategory = 'R'
      then UnitOfMeasureForVarSizeItem
      else valid_items.BillOfMaterialItemUnit
      end                                                          as BillOfMaterialItemUnit,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      @DefaultAggregation :#NONE
     // @ObjectModel.updateEnabled: true
      case when _BOMItemCategory.FixedItemCategory = 'R'
      then NumberOfVariableSizeItem
      else valid_items.BillOfMaterialItemQuantity
      end                                                          as BillOfMaterialItemQuantity,
      cast( valid_items.IsAssembly as stlkz preserving type )      as IsAssembly,
      //'' as AssemblyIndicator,
      valid_items.IsSubItem,

      valid_items.BOMItemSorter,
      valid_items.FixedQuantity,
      valid_items.PurchasingGroup,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_Currency'
      valid_items.Currency,
      @Semantics.amount.currencyCode : 'Currency'
      @DefaultAggregation :#NONE
      //@ObjectModel.updateEnabled: true
      valid_items.MaterialComponentPrice,
      valid_items.IdentifierBOMItem,
     // @ObjectModel.updateEnabled: true
      valid_items.MaterialPriceUnitQty,
      //@ObjectModel.updateEnabled: true
      valid_items.ComponentScrapInPercent,
      //@ObjectModel.updateEnabled: true
      valid_items.OperationScrapInPercent,
     // @ObjectModel.updateEnabled: true
      valid_items.IsNetScrap,
      //@ObjectModel.updateEnabled: true
      valid_items.NumberOfVariableSizeItem,
      --@ObjectModel.updateEnabled: true
      valid_items.QuantityVariableSizeItem,
      //@ObjectModel.updateEnabled: true
      valid_items.FormulaKey,
    //  @ObjectModel.updateEnabled: true
      valid_items.BOMItemDescription,
      //@ObjectModel.updateEnabled: true
      valid_items.BOMItemText2,
      valid_items.MaterialGroup,
     // @ObjectModel.updateEnabled: true
      valid_items.DocumentType,
     // @ObjectModel.updateEnabled: true
      valid_items.DocNumber,
     // @ObjectModel.updateEnabled: true
      valid_items.DocumentVersion,
     // @ObjectModel.updateEnabled: true
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
      valid_items.UnitOfMeasureForSize1To3,
      valid_items.GoodsReceiptDuration,
      valid_items.PurchasingOrganization,
      valid_items.RequiredComponent,
      valid_items.MultipleSelectionAllowed,
      valid_items.ProdOrderIssueLocation,
      valid_items.MaterialIsCoProduct,
      valid_items.ExplosionType,
      valid_items.AlternativeItemGroup,
      valid_items.FollowUpGroup,
      valid_items.DiscontinuationGroup,
      valid_items.IsConfigurableBOM,
      valid_items.ReferencePoint,
      valid_items.LeadTimeOffset,
      valid_items.IsSoftwareComponent,
      valid_items.ProductionSupplyArea,
      valid_items.IsDeleted,
      valid_items.IsALE,
//Alternative Item Fields
/*
      valid_items.AlternativeItemPriority,
      valid_items.AlternativeItemStrategy,
      valid_items.UsageProbabilityPercent, */     
      _BOMItemCategoryText.BillOfMaterialItemCategoryDesc as BillOfMaterialItemCategoryDesc,
      cast ( valid_items.IsPhantomItem as dumps preserving type )  as MaterialComponentIsPhantomItem,
      cast ( valid_items.IsPhantomItem as dumps preserving type )  as IsPhantomItem,
      _BOMItemCategory,
      //_Material,
      _UnitOfMeasure,
      _Currency,
//      _BillOfMaterialVariantUsage,
      _Mast
//      _Dost,
//      _Prst,
//      _Kdst,
//      _Eqst,
//      _Tpst,
//      _Stst
     
}
