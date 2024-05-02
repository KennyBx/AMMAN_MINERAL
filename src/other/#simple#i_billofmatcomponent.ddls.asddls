@AbapCatalog.sqlViewName: '/SIMPLE/IBOMCOMP'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Components'
@ObjectModel.createEnabled: true
@Search.searchable: false
@AbapCatalog.preserveKey:true


define view /SIMPLE/I_BillOfMatComponent
  as select from /SIMPLE/P_BOMItems as valid_items
  association [1..1] to /SIMPLE/I_BOMItemCategory   as _BOMItemCategory     on  $projection.BillOfMaterialItemCategory = _BOMItemCategory.BillOfMaterialItemCategory
  association [0..1] to /SIMPLE/I_BomItemCatText    as _BOMItemCategoryText on  $projection.BillOfMaterialItemCategory = _BOMItemCategoryText.BillOfMaterialItemCategory
                                                                            and _BOMItemCategoryText.Language          = $session.system_language
  //association [0..1] to I_Material                   as _Material        on  $projection.BillOfMaterialComponent = _Material.Material
  association [1..1] to /SIMPLE/I_UnitOfMeasure     as _UnitOfMeasure       on  $projection.BillOfMaterialItemUnit = _UnitOfMeasure.UnitOfMeasure
  //association [1..1] to I_BillOfMaterialUsage        as _BillOfMaterialVariantUsage on  $projection.billofmaterialvariantusage = _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage
  association [1..1] to /SIMPLE/I_Currency          as _Currency            on  $projection.Currency = _Currency.Currency
  association [0..*] to /SIMPLE/I_MaterialBOMLink   as _Mast                on  $projection.BillOfMaterialCategory = _Mast.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Mast.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Mast.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_DocumentBOMLink   as _Dost                on  $projection.BillOfMaterialCategory = _Dost.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Dost.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Dost.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_Prst              as _Prst                on  $projection.BillOfMaterialCategory = _Prst.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Prst.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Prst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_SalesOrderBOMLink as _Kdst                on  $projection.BillOfMaterialCategory = _Kdst.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Kdst.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Kdst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_Eqst              as _Eqst                on  $projection.BillOfMaterialCategory = _Eqst.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Eqst.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Eqst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_Tpst              as _Tpst                on  $projection.BillOfMaterialCategory = _Tpst.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Tpst.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Tpst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_STST              as _Stst                on  $projection.BillOfMaterialCategory = _Stst.BillOfMaterialCategory
                                                                            and $projection.BillOfMaterial         = _Stst.BillOfMaterial
                                                                            and $projection.BillOfMaterialVariant  = _Stst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_Material          as _Material            on  $projection.BillOfMaterialComponent = _Material.Material
  association [0..1] to /SIMPLE/I_MaterialText      as _MaterialText        on  $projection.BillOfMaterialComponent = _MaterialText.Material
                                                                            and _MaterialText.Language              = $session.system_language
  association [0..1] to /SIMPLE/I_MaterialText      as _MaterialTextEN      on  $projection.BillOfMaterialComponent = _MaterialTextEN.Material
                                                                            and _MaterialTextEN.Language            = 'E'

  association [0..1] to /SIMPLE/I_DocInfoRecordDesc as _DocumentText        on  $projection.DocumentType    = _DocumentText.DocumentInfoRecordDocType
                                                                            and $projection.DocNumber       = _DocumentText.DocumentInfoRecordDocNumber
                                                                            and $projection.DocumentPart    = _DocumentText.DocumentInfoRecordDocPart
                                                                            and $projection.DocumentVersion = _DocumentText.DocumentInfoRecordDocVersion
                                                                            and _DocumentText.Language      = $session.system_language

  association [0..1] to /SIMPLE/I_DocInfoRecordDesc as _DocumentTextEN      on  $projection.DocumentType    = _DocumentTextEN.DocumentInfoRecordDocType
                                                                            and $projection.DocNumber       = _DocumentTextEN.DocumentInfoRecordDocNumber
                                                                            and $projection.DocumentPart    = _DocumentTextEN.DocumentInfoRecordDocPart
                                                                            and $projection.DocumentVersion = _DocumentTextEN.DocumentInfoRecordDocVersion
                                                                            and _DocumentTextEN.Language    = 'E'
  //association [0..1] to I_ClfnClassVH                 as _Class                       on  $projection.ClassNumber = _Class.Class
  //                                                                                   and $projection.ClassType   = _Class.ClassType
  association [0..1] to /SIMPLE/I_ChangeMaster      as _DeleteChangeNumber  on  $projection.ChgToEngineeringChgDocument = _DeleteChangeNumber.ChangeNumber

  association [0..1] to /SIMPLE/I_Producttexts        as _ProductText       on  $projection.BillOfMaterialComponent = _ProductText.Product
    
{
  key valid_items.BillOfMaterialCategory,
      //@ObjectModel.readOnly: true
  key cast( valid_items.BillOfMaterial  as /simple/stnum preserving type ) as BillOfMaterial,
      //@ObjectModel.readOnly: true
  key valid_items.BillOfMaterialVariant,
//      @ObjectModel.readOnly: true
  key valid_items.BillOfMaterialItemNodeNumber,
//      @ObjectModel.readOnly: true
  key valid_items.BillOfMaterialItemUUID,

      valid_items.BillOfMaterialVersion,
//      @ObjectModel.readOnly: true
      --@EndUserText.label: ''
      valid_items.BOMItemInternalChangeCount,
      //@ObjectModel.readOnly: true
      @Semantics.businessDate.from: true
      valid_items.ValidityStartDate,
      //@ObjectModel.readOnly: true
      @Semantics.businessDate.to: true
      /*     case when valid_items.BillOfMaterialVersion = ''  or valid_items.ValidityStartDate = '00000000'
           then
           cast( valid_items.ValidityEndDate as datub preserving type )
           else cast('99991231' as datub )
           end as ValidityEndDate, */
//      case
//        when valid_items.ChangeNumberTo is initial then valid_items.ValidityEndDate
//        else cast ( _DeleteChangeNumber.ChangeNumberValidFromDate as datub preserving type ) end as ValidityEndDate,
      case 
        when valid_items.ValidityEndDate != '' 
          then  valid_items.ValidityEndDate
        else cast('99991231' as datub ) 
      end as ValidityEndDate,
      //@ObjectModel.readOnly: true
      valid_items.ChangeNumberFrom                                as EngineeringChangeDocument,
//      @ObjectModel.readOnly: true
      cast( valid_items.ChangeNumberTo as aenra preserving type ) as ChgToEngineeringChgDocument,
//      @ObjectModel.readOnly: true
      valid_items.InheritedNodeNumberForBOMItem,
//      @ObjectModel.readOnly: true
      valid_items.InheritedNodeNumberVersionBOM,
      --@ObjectModel.readOnly: true
      //valid_items.BOMItemNodeCount,
//      @ObjectModel.readOnly: true
      valid_items.BOMItemRecordCreationDate,
//      @ObjectModel.readOnly: true
      valid_items.BOMItemCreatedByUser,
      valid_items.BOMItemLastChangeDate,
      valid_items.BOMItemLastChangedByUser,
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      valid_items.BillOfMaterialComponent,
      ' '                                                         as MaterialName, // To be removed
      @ObjectModel.foreignKey.association: '_BOMItemCategory'
      valid_items.BillOfMaterialItemCategory,
      valid_items.BillOfMaterialItemNumber,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_UnitOfMeasure'
      case when _BOMItemCategory.FixedItemCategory = 'R'
      then UnitOfMeasureForVarSizeItem
      else valid_items.BillOfMaterialItemUnit
      end                                                         as BillOfMaterialItemUnit,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      @DefaultAggregation :#NONE
      case when _BOMItemCategory.FixedItemCategory = 'R'
      then NumberOfVariableSizeItem
      else valid_items.BillOfMaterialItemQuantity
      end                                                         as BillOfMaterialItemQuantity,
      cast( valid_items.IsAssembly as stlkz preserving type )     as IsAssembly,
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
      valid_items.MaterialComponentPrice,
      valid_items.IdentifierBOMItem,
      valid_items.MaterialPriceUnitQty,
      valid_items.ComponentScrapInPercent,
      valid_items.OperationScrapInPercent,
      valid_items.IsNetScrap,
      valid_items.NumberOfVariableSizeItem,
      case when _BOMItemCategory.FixedItemCategory = 'R'
      then BillOfMaterialItemUnit
      else valid_items.UnitOfMeasureForVarSizeItem
      end                                                         as VariableSizeCompUnitOfMeasure,
      valid_items.QuantityVariableSizeItem,
      valid_items.UnitOfMeasureForVarSizeItem,
      valid_items.FormulaKey,
      //valid_items.BOMItemDescription,
      case
            when _BOMItemCategory.FixedItemCategory = 'L' or _BOMItemCategory.FixedItemCategory = 'C'
               then
               case when _MaterialText.MaterialName is not null or _MaterialText.MaterialName <> ''
               then _MaterialText.MaterialName
               else _MaterialTextEN.MaterialName
               end
            when _BOMItemCategory.FixedItemCategory = 'T'
               then valid_items.BOMItemDescription
            when _BOMItemCategory.FixedItemCategory = 'R' and  (valid_items.BillOfMaterialComponent is not null)
               then
               case when _MaterialText.MaterialName is not null or _MaterialText.MaterialName <> ''
               then _MaterialText.MaterialName
               else _MaterialTextEN.MaterialName
               end
            when _BOMItemCategory.FixedItemCategory = 'R' and  (valid_items.BillOfMaterialComponent = '')
               then valid_items.BOMItemDescription
            when _BOMItemCategory.FixedItemCategory = 'D'
               then
               case when _DocumentText.DocumentDescription is not null or _DocumentText.DocumentDescription <> ''
               then _DocumentText.DocumentDescription
               else _DocumentTextEN.DocumentDescription
               end
      //when _BOMItemCategory.FixedItemCategory = 'K'
      //then
      //case when _Class._ClassDescription[1:Language = $session.system_language].ClassDescription is not null
      //         or _Class._ClassDescription[1:Language = $session.system_language].ClassDescription <> ''
      //     then _Class._ClassDescription[1:Language = $session.system_language].ClassDescription
      //     else _Class._ClassDescription[1:Language = 'E'].ClassDescription
      //end
            when _BOMItemCategory.FixedItemCategory = 'N' and (valid_items.BillOfMaterialComponent <> '')
               then
               case when _MaterialText.MaterialName is not null or _MaterialText.MaterialName <> ''
               then _MaterialText.MaterialName
               else _MaterialTextEN.MaterialName
               end
            when _BOMItemCategory.FixedItemCategory = 'N' and  (valid_items.BillOfMaterialComponent = '')
               then valid_items.BOMItemDescription
       end                                                        as ComponentDescription,
      valid_items.BOMItemDescription,
      valid_items.BOMItemText2,
      valid_items.MaterialGroup,
      valid_items.DocumentType,
      valid_items.DocNumber,
      valid_items.DocumentVersion,
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
      valid_items.AlternativeItemGroup,
      valid_items.AlternativeItemPriority,
      valid_items.AlternativeItemStrategy,
      valid_items.UsageProbabilityPercent,
      _BOMItemCategoryText.BillOfMaterialItemCategoryDesc         as BillOfMaterialItemCategoryDesc,
      cast ( valid_items.IsPhantomItem as dumps preserving type ) as MaterialComponentIsPhantomItem,
      cast ( valid_items.IsPhantomItem as dumps preserving type ) as IsPhantomItem,
      valid_items.LastChangeDateTime                              as LastChangeDateTime,
      valid_items.IsPMAssemblyRelevant,
      valid_items.SortString                                      as SortString,
      valid_items.LongItemTextLanguage                            as LongItemTextLanguage,
      _ProductText.LongText                                       as LongItemText,
      _BOMItemCategory,
      //_Material,
      _UnitOfMeasure,
      _Currency,
      //_BillOfMaterialVariantUsage,
      _Mast,
      _Dost,
      _Prst,
      _Kdst,
      _Eqst,
      _Tpst,
      _Stst

}
