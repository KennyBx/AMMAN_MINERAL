@AbapCatalog.sqlViewName: '/SIMPLE/IBIAPITP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Item (Transactional Processing)'

@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@AbapCatalog.preserveKey: true

define view /SIMPLE/I_BillOfMatItemAPITP  
  as select from /SIMPLE/I_BOMItemHChangeState
//  association to parent /SIMPLE/I_BillOfMatAPITP as _BillOfMaterial on  $projection.BillOfMaterial         = _BillOfMaterial.BillOfMaterial
//                                                                 and $projection.BillOfMaterialCategory = _BillOfMaterial.BillOfMaterialCategory
//                                                                 and $projection.BillOfMaterialVariant  = _BillOfMaterial.BillOfMaterialVariant
//                                                                 and $projection.BillOfMaterialVersion  = _BillOfMaterial.BillOfMaterialVersion
//                                                                 and $projection.HeaderChangeDocument   = _BillOfMaterial.EngineeringChangeDocument
//                                                                 and $projection.Material               = _BillOfMaterial.Material
//                                                                 and $projection.Plant                  = _BillOfMaterial.Plant
  association to parent /SIMPLE/I_BOMMainAPITP as _BillOfMaterial on  $projection.BillOfMaterial         = _BillOfMaterial.BillOfMaterial
                                                                 and  $projection.BillOfMaterialCategory = _BillOfMaterial.BillOfMaterialCategory
                                                                 and  $projection.BillOfMaterialVariant  = _BillOfMaterial.BillOfMaterialVariant
                                                                 and  $projection.Material               = _BillOfMaterial.Material
                                                                 and  $projection.Plant                  = _BillOfMaterial.Plant
                                                                 and  $projection.BillOfMaterialVariantUsage = _BillOfMaterial.BillOfMaterialVariantUsage
  association [0..1] to /SIMPLE/I_MaterialPlant  as _ComponentPlant   on  $projection.BillOfMaterialComponent = _ComponentPlant.Material
                                                                     and $projection.Plant = _ComponentPlant.Plant
  association [0..1] to /SIMPLE/I_BOMCOMPVALUATION as comp on $projection.BillOfMaterialComponent = comp.Material
                                                          and $projection.Plant = comp.PlantID
{

       key BillOfMaterial,
       key BillOfMaterialCategory,
       key BillOfMaterialVariant,
//       key BillOfMaterialVersion,
       key BillOfMaterialItemNodeNumber,
       key BOMItemInternalChangeCount,
//       key HeaderChangeDocument,
       key Material,
       key Plant,
       key BillOfMaterialVariantUsage,
       BillOfMaterialItemUUID,
       ValidityStartDate,
       ValidityEndDate,
       EngineeringChangeDocument as EngineeringChangeDocForEdit,
       EngineeringChangeDocument,
       ChgToEngineeringChgDocument,
       InheritedNodeNumberForBOMItem,
       BOMItemRecordCreationDate,
       BOMItemCreatedByUser,
       BOMItemLastChangeDate,
       BOMItemLastChangedByUser,
       BillOfMaterialComponent,
       BillOfMaterialItemCategory,
       BillOfMaterialItemNumber,
       @Semantics.unitOfMeasure: true
       BillOfMaterialItemUnit,
       @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
       BillOfMaterialItemQuantity,
       IsAssembly,
       IsSubItem,
       BOMItemSorter,
       FixedQuantity,
       PurchasingGroup,
       @Semantics.currencyCode: true
       Currency,
       @Semantics.amount.currencyCode : 'Currency'
//       MaterialComponentPrice,
       comp.Price as MaterialComponentPrice,
       IdentifierBOMItem,
       MaterialPriceUnitQty,
       ComponentScrapInPercent,
       OperationScrapInPercent,
       IsNetScrap,
       NumberOfVariableSizeItem,
       QuantityVariableSizeItem,
       FormulaKey,
       ComponentDescription,
       BOMItemDescription,
       BOMItemText2,
       MaterialGroup,
       DocumentType,
       DocNumber,
       DocumentVersion,
       DocumentPart,
       ClassNumber,
       ClassType,
       ResultingItemCategory,
       DependencyObjectNumber,
       ObjectType,
       IsClassificationRelevant,
       IsBulkMaterial,
       BOMItemIsSparePart,
       BOMItemIsSalesRelevant,
       IsProductionRelevant,
       BOMItemIsPlantMaintRelevant,
       BOMItemIsCostingRelevant,
       IsEngineeringRelevant,
       SpecialProcurementType,
       IsBOMRecursiveAllowed,
       OperationLeadTimeOffset,
       OpsLeadTimeOffsetUnit,
       IsMaterialProvision,
       BOMIsRecursive,
       DocumentIsCreatedByCAD,
       DistrKeyCompConsumption,
       DeliveryDurationInDays,
       Creditor,
       CostElement,
       Size1,
       Size2,
       Size3,
       UnitOfMeasureForSize1To3,
       GoodsReceiptDuration,
       PurchasingOrganization,
       RequiredComponent,
       MultipleSelectionAllowed,
       ProdOrderIssueLocation,
       MaterialIsCoProduct,
       ExplosionType,
       AlternativeItemGroup,
       FollowUpGroup,
       DiscontinuationGroup,
       IsConfigurableBOM,
       ReferencePoint,
       LeadTimeOffset,
       ProductionSupplyArea,
       IsDeleted,
       IsALE,

      case
        when LastChangeDateTime = fltp_to_dec( 0.0 as timestampl )
        then fltp_to_dec( 19720401000000.0 as timestampl )
        else LastChangeDateTime
      end as LastChangeDateTime,
       UnitOfMeasureForVarSizeItem,
       VariableSizeCompUnitOfMeasure,
       AlternativeItemPriority,
       AlternativeItemStrategy,
       UsageProbabilityPercent,
       SortString,
       LongItemTextLanguage,
       LongItemText,        
       _ComponentPlant,
       @ObjectModel.association.type:  [ #TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT ]
       _BillOfMaterial


}
//  as select from /SIMPLE/I_BOMItemHChangeState
//  association to parent /SIMPLE/I_BillOfMatAPITP as _BillOfMaterial on  $projection.BillOfMaterial         = _BillOfMaterial.BillOfMaterial
//                                                                 and $projection.BillOfMaterialCategory = _BillOfMaterial.BillOfMaterialCategory
//                                                                 and $projection.BillOfMaterialVariant  = _BillOfMaterial.BillOfMaterialVariant
//                                                                 and $projection.BillOfMaterialVersion  = _BillOfMaterial.BillOfMaterialVersion
//                                                                 and $projection.HeaderChangeDocument   = _BillOfMaterial.EngineeringChangeDocument
//                                                                 and $projection.Material               = _BillOfMaterial.Material
//                                                                 and $projection.Plant                  = _BillOfMaterial.Plant
//  association [0..1] to /SIMPLE/I_MaterialPlant  as _ComponentPlant   on  $projection.BillOfMaterialComponent = _ComponentPlant.Material
//                                                                     and $projection.Plant = _ComponentPlant.Plant
//  association [0..1] to /SIMPLE/I_BOMCOMPVALUATION as comp on $projection.BillOfMaterialComponent = comp.Material
//                                                          and $projection.Plant = comp.PlantID
//{ 
//
//       key BillOfMaterial,
//       key BillOfMaterialCategory,
//       key BillOfMaterialVariant,
//       key BillOfMaterialVersion,
//       key BillOfMaterialItemNodeNumber,
//       key HeaderChangeDocument,
//       key Material,
//       key Plant,
//       BillOfMaterialVariantUsage,
//       BillOfMaterialItemUUID,
//       BOMItemInternalChangeCount,
//       ValidityStartDate,
//       ValidityEndDate, 
//       EngineeringChangeDocument as EngineeringChangeDocForEdit,
//       EngineeringChangeDocument,
//       ChgToEngineeringChgDocument,
//       InheritedNodeNumberForBOMItem,
//       BOMItemRecordCreationDate,
//       BOMItemCreatedByUser,
//       BOMItemLastChangeDate,
//       BOMItemLastChangedByUser,
//       BillOfMaterialComponent,
//       BillOfMaterialItemCategory,
//       BillOfMaterialItemNumber,
//       @Semantics.unitOfMeasure: true
//       BillOfMaterialItemUnit,
//       @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
//       BillOfMaterialItemQuantity,
//       IsAssembly,
//       IsSubItem,
//       BOMItemSorter,
//       FixedQuantity,
//       PurchasingGroup,
//       @Semantics.currencyCode: true
//       Currency,
//       @Semantics.amount.currencyCode : 'Currency'
////       MaterialComponentPrice,
//       comp.Price as MaterialComponentPrice,
//       IdentifierBOMItem,
//       MaterialPriceUnitQty,
//       ComponentScrapInPercent,
//       OperationScrapInPercent,
//       IsNetScrap,
//       NumberOfVariableSizeItem,
//       QuantityVariableSizeItem,
//       FormulaKey,
//       ComponentDescription,
//       BOMItemDescription,
//       BOMItemText2,
//       MaterialGroup,
//       DocumentType,
//       DocNumber,
//       DocumentVersion,
//       DocumentPart,
//       ClassNumber,
//       ClassType,
//       ResultingItemCategory,
//       DependencyObjectNumber,
//       ObjectType,
//       IsClassificationRelevant,
//       IsBulkMaterial,
//       BOMItemIsSparePart,
//       BOMItemIsSalesRelevant,
//       IsProductionRelevant,
//       BOMItemIsPlantMaintRelevant,
//       BOMItemIsCostingRelevant,
//       IsEngineeringRelevant,
//       SpecialProcurementType,
//       IsBOMRecursiveAllowed,
//       OperationLeadTimeOffset,
//       OpsLeadTimeOffsetUnit,
//       IsMaterialProvision,
//       BOMIsRecursive,
//       DocumentIsCreatedByCAD,
//       DistrKeyCompConsumption,
//       DeliveryDurationInDays,
//       Creditor,
//       CostElement,
//       Size1,
//       Size2,
//       Size3,
//       UnitOfMeasureForSize1To3,
//       GoodsReceiptDuration,
//       PurchasingOrganization,
//       RequiredComponent,
//       MultipleSelectionAllowed,
//       ProdOrderIssueLocation,
//       MaterialIsCoProduct,
//       ExplosionType,
//       AlternativeItemGroup,
//       FollowUpGroup,
//       DiscontinuationGroup,
//       IsConfigurableBOM,
//       ReferencePoint,
//       LeadTimeOffset,
//       ProductionSupplyArea,
//       IsDeleted,
//       IsALE,
//
//      case
//        when LastChangeDateTime = fltp_to_dec( 0.0 as timestampl )
//        then fltp_to_dec( 19720401000000.0 as timestampl )
//        else LastChangeDateTime
//      end as LastChangeDateTime,
//       UnitOfMeasureForVarSizeItem,
//       VariableSizeCompUnitOfMeasure,
//       AlternativeItemPriority,
//       AlternativeItemStrategy,
//       UsageProbabilityPercent,
//       SortString,       
//       _ComponentPlant,
//       @ObjectModel.association.type:  [ #TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT ]
//       _BillOfMaterial
//
//
//}
