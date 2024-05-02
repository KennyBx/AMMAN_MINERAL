// active core entity
@AbapCatalog: {
  sqlViewName: '/SIMPLE/IPRODUCT',
  preserveKey: true
}
@VDM.viewType: #BASIC

@AccessControl: {
  authorizationCheck: #CHECK,
//As I_TextObjectPlainLongText has a DCL0,
//the following annotation is required for enterprise search "Products"
  privilegedAssociations: ['_ESHTextObjectPlainLongText']
}
@EndUserText.label: 'Product active core entity'
@ObjectModel.representativeKey: 'Product'
//@Analytics.dataCategory: #DIMENSION
//@ObjectModel.entityChangeStateId: 'LastChangeDateTime'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.allowExtensions:true
@Metadata.ignorePropagatedAnnotations: true


define view /SIMPLE/I_Product  
  as select from mara  
//  //    left outer join maw1 on mara.matnr = maw1.matnr //moved to _ProductRetail
//  association [0..*] to /SIMPLE/I_ProductText          as _Text                          on  $projection.Product = _Text.Product
//  association [0..1] to /SIMPLE/I_ProductGroup         as _ProductGroup                  on  $projection.ProductGroup = _ProductGroup.MaterialGroup
//  association [0..*] to /SIMPLE/I_ProductGroupText     as _ProductGroupText              on  $projection.ProductGroup = _ProductGroupText.MaterialGroup
//  association [0..1] to /SIMPLE/I_ProductRetail        as _ProductRetail                 on  $projection.Product = _ProductRetail.Product //added for VH
//  association [0..1] to /SIMPLE/I_Division             as _Division                      on  $projection.Division = _Division.Division
//  association [0..*] to /SIMPLE/I_DivisionText         as _DivisionText                  on  $projection.Division = _DivisionText.Division
//  association [0..1] to /SIMPLE/I_ExtProdGrp           as _ExternalProductGroup          on  $projection.ExternalProductGroup = _ExternalProductGroup.ExternalProductGroup
//  association [0..*] to /SIMPLE/I_ExtProdGrpText       as _ExtProdGrpText                on  $projection.ExternalProductGroup = _ExtProdGrpText.ExternalProductGroup
//  association [0..1] to /SIMPLE/I_ProductHierarchy     as _ProductHierarchy              on  $projection.ProductHierarchy = _ProductHierarchy.ProductHierarchy
//  association [0..*] to /SIMPLE/I_ProductHierarchyText as _ProductHierarchyText          on  $projection.ProductHierarchy = _ProductHierarchyText.ProductHierarchy
//  association [1..1] to /SIMPLE/I_Producttype          as _ProductType                   on  $projection.ProductType = _ProductType.ProductType
//  association [0..*] to /SIMPLE/I_ProductTypeText      as _ProductTypeName               on  $projection.ProductType = _ProductTypeName.ProductType
//  association [0..1] to /SIMPLE/I_Intntnlartnmbcat     as _InternationalArticleNumberCat on  $projection.InternationalArticleNumberCat = _InternationalArticleNumberCat.InternationalArticleNumberCat
//  association [0..*] to /SIMPLE/I_Intntnlartnmbcattext as _IntArticleNumberText          on  $projection.InternationalArticleNumberCat = _IntArticleNumberText.InternationalArticleNumberCat
//  association [1..1] to /SIMPLE/I_ProductCategory      as _ProductCategory               on  $projection.ProductCategory = _ProductCategory.ProductCategory
//  association [0..*] to /SIMPLE/I_ProductCategoryText  as _ProductCategoryText           on  $projection.ProductCategory = _ProductCategoryText.ProductCategory
//  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _BaseUnitOfMeasure             on  $projection.BaseUnit = _BaseUnitOfMeasure.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _BaseUnitOfMeasureText         on  $projection.BaseUnit = _BaseUnitOfMeasureText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_Product              as _CrossPlantConfigurableProduct on  $projection.CrossPlantConfigurableProduct = _CrossPlantConfigurableProduct.Product
//  association [0..1] to /SIMPLE/I_Brand                as _Brand                         on  $projection.Brand = _Brand.Brand
//  association [0..1] to /SIMPLE/I_User                 as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
//  association [0..1] to /SIMPLE/I_User                 as _LastChangedByUser             on  $projection.LastChangedByUser = _LastChangedByUser.UserID
//  association [1..1] to /SIMPLE/I_UserContactCard      as _CreatedByUserContactCard      on  $projection.CreatedByUser = _CreatedByUserContactCard.ContactCardID
//  association [0..1] to /SIMPLE/I_UserContactCard      as _LastChangedByUserContactCard  on  $projection.LastChangedByUser = _LastChangedByUserContactCard.ContactCardID
//
//  association [0..1] to E_Product                      as _ProductExt                    on  mara.matnr = _ProductExt.Product
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _ContentUnit                   on  $projection.ContentUnit = _ContentUnit.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _ContentUnitText               on  $projection.ContentUnit = _ContentUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _ProductMeasurementUnit        on  $projection.ProductMeasurementUnit = _ProductMeasurementUnit.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _ProductMeasurementUnitText    on  $projection.ProductMeasurementUnit = _ProductMeasurementUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_Productprocurement   as _ProductProcurement            on  $projection.Product = _ProductProcurement.Product
//  association [0..1] to /SIMPLE/I_ProductSales         as _ProductSales                  on  $projection.Product = _ProductSales.Product
//  association [0..1] to /SIMPLE/I_ProductStatus        as _ProductStatus                 on  $projection.CrossPlantStatus = _ProductStatus.Status
//  association [0..*] to /SIMPLE/I_ProductStatusText    as _ProductStatusText             on  $projection.CrossPlantStatus = _ProductStatusText.Status
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _WeightUnitValueHelp           on  $projection.WeightUnit = _WeightUnitValueHelp.UnitOfMeasure
//
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _WeightUnitText                on  $projection.WeightUnit = _WeightUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _QuantityUnitValueHelp         on  $projection.VolumeUnit = _QuantityUnitValueHelp.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _QuantityUnitText              on  $projection.VolumeUnit = _QuantityUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _UnitForMaxPackaging           on  $projection.UnitForMaxPackagingDimensions = _UnitForMaxPackaging.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _UnitForMaxPackagingText       on  $projection.UnitForMaxPackagingDimensions = _UnitForMaxPackagingText.UnitOfMeasure
//
//  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _TimeUnitForQuarantinePeriod   on  $projection.TimeUnitForQuarantinePeriod = _TimeUnitForQuarantinePeriod.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _TimeUnitQuarantinePeriodText  on  $projection.TimeUnitForQuarantinePeriod = _TimeUnitQuarantinePeriodText.UnitOfMeasure
//  //  association [0..1] to I_Productvh            as _CrossPlantConfigurableProduct on  $projection.CrossPlantConfigurableProduct = _CrossPlantConfigurableProduct.Product
//  association [0..*] to /SIMPLE/I_ProductDescription   as _MaterialText                  on  $projection.CrossPlantConfigurableProduct = _MaterialText.Product
//
//  association [0..*] to /SIMPLE/I_MDPrdHierarchyNode   as _MDProductHierarchyNode -- Not part of 1705 [Pushing down from I_ProductWD to I_Product Applegreen ticket]
//                                                                                         on  $projection.Product = _MDProductHierarchyNode.Product
//
//
//  association [0..1] to /SIMPLE/I_ChmclComplianceRlvt  as _ChemicalComplianceRelevant    on  $projection.IsChemicalComplianceRelevant = _ChemicalComplianceRelevant.IsChemicalComplianceRelevant
//  association [0..*] to /SIMPLE/I_ChmclComplianceRlvtT as _ChemicalComplianceRlvtText    on  $projection.IsChemicalComplianceRelevant = _ChemicalComplianceRlvtText.IsChemicalComplianceRelevant
//
//  association [0..1] to /SIMPLE/I_ItemCategoryGroup    as _ItemCategoryGroup             on  $projection.ItemCategoryGroup = _ItemCategoryGroup.ItemCategoryGroup
//  association [0..*] to /SIMPLE/I_ItemCategoryGroupT   as _ItemCategoryGroupText         on  $projection.ItemCategoryGroup = _ItemCategoryGroupText.ItemCategoryGroup
//
//  association [0..*] to /SIMPLE/I_BrandText            as _BrandText                     on  $projection.Brand = _BrandText.Brand
//
//  //Start: enterprise search help (ESH) related associations----------------------------------------------------------------------------------------------------------------------
//  association [0..*] to /SIMPLE/I_ProductSalesDelivery as _ESHProductSalesDelivery       on  $projection.Product = _ESHProductSalesDelivery.Product
//  association [0..*] to /SIMPLE/I_SrcOfSupplyCategoryT as _ESHSourceOfSupply             on  $projection.SourceOfSupply = _ESHSourceOfSupply.SourceOfSupplyCategory
//  association [0..1] to /SIMPLE/I_Supplier             as _ESHSupplier                   on  $projection.ManufacturerNumber = _ESHSupplier.Supplier
//  association [0..*] to /SIMPLE/I_TextObjPlainLongText as _ESHTextObjectPlainLongText    on  $projection.Product                            = _ESHTextObjectPlainLongText.TextObjectKey
//                                                                                         and _ESHTextObjectPlainLongText.TextObjectCategory = 'MATERIAL'
//  association [0..*] to /SIMPLE/I_DocInfoRcrdObjLink   as _ESHDocInfoRecordObjectLink    on  $projection.Product                         = _ESHDocInfoRecordObjectLink.LinkedSAPObjectKey
//                                                                                         and _ESHDocInfoRecordObjectLink.LinkedSAPObject = 'MARA'
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText    as _ESHPurOrderQuantityUnitText   on  $projection.PurchaseOrderQuantityUnit = _ESHPurOrderQuantityUnitText.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_ProductPlant         as _ESHProductPlant               on  $projection.Product = _ESHProductPlant.Product
//
//  //In 1905 Classification related associations are added to get classification related fields into the
//  //search model
//  association [0..*] to /SIMPLE/I_ClfnObjCharValForKD  as _ESHCharValueAssignment        on  $projection.Product                     = _ESHCharValueAssignment.ClfnObjectID
//                                                                                         and _ESHCharValueAssignment.ClfnObjectTable = 'MARA'
//  association [0..*] to /SIMPLE/I_ClfnObjectClassForKD as _ESHClassAssignment            on  $projection.Product                 = _ESHClassAssignment.ClfnObjectID
//                                                                                         and _ESHClassAssignment.ClfnObjectTable = 'MARA'
//  //End of ESH related associations-----------------------------------------------------------------------------------------------------------------------------------------------

{ // root node fields

      @ObjectModel.text.association: '_Text'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key cast (mara.matnr as productnumber preserving type )                  as Product,
//      _Text,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      mara.matnr_external                                                  as ProductExternalID,
      @ObjectModel.foreignKey.association: '_ProductType'
      @ObjectModel.text.association: '_ProductTypeName'
      cast (mara.mtart as producttype preserving type )                    as ProductType,
//      _ProductType,
      @Semantics.systemDate.createdAt: true
      mara.ersda                                                           as CreationDate,
      @Semantics.systemTime.createdAt: true
      mara.created_at_time                                                 as CreationTime,

      @Semantics.systemDateTime.createdAt: true
      cast ( dats_tims_to_tstmp( mara.ersda,
                                 mara.created_at_time,
                                 'UTC',
                                 $session.client,
                                 'NULL' ) as cmd_prd_creation_date_time  ) as CreationDateTime,
      @ObjectModel.foreignKey.association: '_CreatedByUserContactCard'
      mara.ernam                                                           as CreatedByUser,
//      _CreatedByUser,
//      _CreatedByUserContactCard,
      @Semantics.systemDate.lastChangedAt: true
      mara.laeda                                                           as LastChangeDate,
      @ObjectModel.foreignKey.association: '_LastChangedByUserContactCard'
      //case when mara.aenam <> '' then mara.aenam
      //                           else cast( mara.ernam as aenam preserving type )
      //end                                                                  as LastChangedByUser,
      mara.aenam                                                           as LastChangedByUser,
//      _LastChangedByUser,
//      _LastChangedByUserContactCard,
      cast (mara.lvorm as ismarkedfordeletion)                             as IsMarkedForDeletion,
      @ObjectModel.foreignKey.association: '_ProductStatus'
      @ObjectModel.text.association: '_ProductStatusText'
      cast (mara.mstae as crossplantstatus)                                as CrossPlantStatus,
//      _ProductStatus,
//      _ProductStatusText,
      mara.mstde                                                           as CrossPlantStatusValidityDate,
      // common node fields -> no common node
      cast (mara.bismt as productoldid)                                    as ProductOldID,
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @Analytics.hidden: true
      mara.brgew                                                           as GrossWeight,
      mara.bstme                                                           as PurchaseOrderQuantityUnit,
      mara.bwscl                                                           as SourceOfSupply,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association:'_WeightUnitValueHelp'
      @ObjectModel.text.association: '_WeightUnitText'
      mara.gewei                                                           as WeightUnit,
//      _WeightUnitValueHelp,
//      _WeightUnitText,
      mara.herkl                                                           as CountryOfOrigin,
      mara.kunnr                                                           as CompetitorID,
      @ObjectModel.foreignKey.association: '_ProductGroup'
      @ObjectModel.text.association: '_ProductGroupText'
      cast (mara.matkl as productgroup)                                    as ProductGroup,
//      _ProductGroup,
//      _ProductGroupText,
      @ObjectModel.foreignKey.association: '_BaseUnitOfMeasure'
      @ObjectModel.text.association: '_BaseUnitOfMeasureText'
      mara.meins                                                           as BaseUnit,
//      _BaseUnitOfMeasure,
//      _BaseUnitOfMeasureText,
      @ObjectModel.foreignKey.association: '_ItemCategoryGroup'
      @ObjectModel.text.association: '_ItemCategoryGroupText'
      mara.mtpos_mara                                                      as ItemCategoryGroup,
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @Analytics.hidden: true
      mara.ntgew                                                           as NetWeight,
      @ObjectModel.foreignKey.association: '_ProductHierarchy'
      @ObjectModel.text.association: '_ProductHierarchyText'
      mara.prdha                                                           as ProductHierarchy,
//      _ProductHierarchy,
//      _ProductHierarchyText,
      @ObjectModel.foreignKey.association: '_Division'
      @ObjectModel.text.association: '_DivisionText'
      mara.spart                                                           as Division,
//      _Division,
//      _DivisionText,
      mara.vabme                                                           as VarblPurOrdUnitIsActive,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association:'_QuantityUnitValueHelp'
      @ObjectModel.text.association: '_QuantityUnitText'
      mara.voleh                                                           as VolumeUnit,
//      _QuantityUnitValueHelp,
//      _QuantityUnitText,
      @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
      @Analytics.hidden: true
      cast (mara.volum as materialvolume)                                  as MaterialVolume,
      mara.mstav                                                           as SalesStatus, -- added on 12.08.2015
      mara.tragr                                                           as TransportationGroup,
      mara.mstdv                                                           as SalesStatusValidityDate,
      mara.begru                                                           as AuthorizationGroup,
      // NEW FIELDS

      mara.anp                                                             as ANPCode,
      @ObjectModel.foreignKey.association: '_ProductCategory'
      @ObjectModel.text.association: '_ProductCategoryText'
      cast (mara.attyp as prodcategory preserving type )                   as ProductCategory,
//      _ProductCategory,
//      _ProductCategoryText,
      @ObjectModel.foreignKey.association: '_Brand'
      @ObjectModel.text.association: '_BrandText'
      mara.brand_id                                                        as Brand,
//      _Brand,
      mara.bwvor                                                           as ProcurementRule,
      mara.datab                                                           as ValidityStartDate,
      mara.disst                                                           as LowLevelCode,
      mara.gennr                                                           as ProdNoInGenProdInPrepackProd,
      mara.serial                                                          as SerialIdentifierAssgmtProfile,
      mara.groes                                                           as SizeOrDimensionText,
      mara.normt                                                           as IndustryStandardName,
      cast( mara.ean11 as globaltradeitemnumber)                           as ProductStandardID,
      @ObjectModel.foreignKey.association: '_InternationalArticleNumberCat'
      @ObjectModel.text.association:'_IntArticleNumberText'
      mara.numtp                                                           as InternationalArticleNumberCat,
//      _InternationalArticleNumberCat,
//      _IntArticleNumberText,
      mara.kzkfg                                                           as ProductIsConfigurable,
      mara.xchpf                                                           as IsBatchManagementRequired,
      mara.mlgut                                                           as HasEmptiesBOM,
      @ObjectModel.foreignKey.association: '_ExternalProductGroup'
      @ObjectModel.text.association: '_ExtProdGrpText'
      cast (mara.extwg as externalproductgroup preserving type )           as ExternalProductGroup,
//      _ExternalProductGroup,
//      _ExtProdGrpText,
//      //--[ GENERATED:012:GFBfhxvv7jY4jTYbPy8kum
//      @Consumption.valueHelpDefinition: [
//        { entity:  { name:    'I_ProductVH',
//                     element: 'Product' }
//        }]
//      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CrossPlantConfigurableProduct'
      @ObjectModel.text.association: '_MaterialText'
      cast (mara.satnr as crossplantconfigurableproduct preserving type )  as CrossPlantConfigurableProduct,
//      _CrossPlantConfigurableProduct,
//      _MaterialText,
      mara.serlv                                                           as SerialNoExplicitnessLevel,
      mara.mfrpn                                                           as ProductManufacturerNumber,
      mara.mfrnr                                                           as ManufacturerNumber,
      mara.mprof                                                           as ManufacturerPartProfile,
      mara.qmpur                                                           as QltyMgmtInProcmtIsActive,
      // _Text  //added for VH

      -- Added on 21.4.16 not releven for Product Master

      mara.xgchp                                                           as IsApprovedBatchRecordReqd,

      //EWM fields------------------------------
      //for EWM............
      mara.hndlcode                                                        as HandlingIndicator,
      mara.whmatgr                                                         as WarehouseProductGroup,
      mara.whstc                                                           as WarehouseStorageCondition,
      mara.hutyp_dflt                                                      as StandardHandlingUnitType,
      mara.serial                                                          as SerialNumberProfile,
      mara.adprof                                                          as AdjustmentProfile,
      mara.scm_puom                                                        as PreferredUnitOfMeasure,
      mara.pilferable                                                      as IsPilferable,
      mara.hazmat                                                          as IsRelevantForHzdsSubstances,
      @Semantics.quantity.unitOfMeasure : 'TimeUnitForQuarantinePeriod'
      @Analytics.hidden: true
      mara.qqtime                                                          as QuarantinePeriod,
      @ObjectModel.foreignKey.association:'_TimeUnitForQuarantinePeriod'
      @Semantics.unitOfMeasure : true
      @ObjectModel.text.association: '_TimeUnitQuarantinePeriodText'
      mara.qqtimeuom                                                       as TimeUnitForQuarantinePeriod,
//      _TimeUnitForQuarantinePeriod,
//      _TimeUnitQuarantinePeriodText,
      mara.qgrp                                                            as QualityInspectionGroup,
      //WM packaging fields
      mara.hutyp                                                           as HandlingUnitType,
      //    mara.hutyp_dflt,
      mara.tare_var                                                        as HasVariableTareWeight,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      @Analytics.hidden: true
      mara.maxl                                                            as MaximumPackagingLength,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      @Analytics.hidden: true
      mara.maxb                                                            as MaximumPackagingWidth,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      @Analytics.hidden: true
      mara.maxh                                                            as MaximumPackagingHeight,
      @Analytics.hidden: true
      mara.maxc                                                            as MaximumCapacity,
      @Analytics.hidden: true
      mara.maxc_tol                                                        as OvercapacityTolerance,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_UnitForMaxPackaging'
      @ObjectModel.text.association: '_UnitForMaxPackagingText'
      mara.maxdim_uom                                                      as UnitForMaxPackagingDimensions,
//      _UnitForMaxPackaging,
//      _UnitForMaxPackagingText,

      //      Retail Fields

      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      @Analytics.hidden: true
      mara.laeng                                                           as BaseUnitSpecificProductLength,
      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      @Analytics.hidden: true
      mara.breit                                                           as BaseUnitSpecificProductWidth,
      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      @Analytics.hidden: true
      mara.hoehe                                                           as BaseUnitSpecificProductHeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ProductMeasurementUnit'
      @ObjectModel.text.association: '_ProductMeasurementUnitText'
      mara.meabm                                                           as ProductMeasurementUnit,
//      _ProductMeasurementUnit,
//      _ProductMeasurementUnitText,
      mara.datab                                                           as ProductValidStartDate,
      cast (mara.attyp as prodcategory preserving type )                   as ArticleCategory,
      @ObjectModel.foreignKey.association: '_ContentUnit'
      @ObjectModel.text.association: '_ContentUnitText'
      @Semantics.unitOfMeasure: true
      mara.inhme                                                           as ContentUnit,
//      _ContentUnit,
//      _ContentUnitText,
      @Semantics.quantity.unitOfMeasure: 'ContentUnit'
      @Analytics.hidden: true
      mara.inhal                                                           as NetContent,
      mara.vpreh                                                           as ComparisonPriceQuantity,
      @Semantics.quantity.unitOfMeasure: 'ContentUnit'
      @Analytics.hidden: true
      mara.inhbr                                                           as GrossContent,
      mara.liqdt                                                           as ProductValidEndDate,
      mara.bbtyp                                                           as AssortmentListType,
      mara.animal_origin                                                   as HasTextilePartsWthAnimalOrigin,
      mara.fsh_sealv                                                       as ProductSeasonUsageCategory,

      // moved to _ProductRetail
      //      maw1.servv                                         as ServiceAgreement,
      //      maw1.wmaab                                         as ConsumptionValueCategory, // ref. handling for MARC
      //      maw1.wausm                                         as GoodsIssueUnit, // ref. handling for MARC
      //      maw1.wherl                                         as CountryOfOrigin, // ref. handling for MARC
      //      maw1.wherr                                         as RegionOfOrigin, // ref. handling for MARC
      //      maw1.sstuf                                         as AssortmentGrade,
      //      maw1.lstfl                                         as StoreListingProcedure,
      //      maw1.lstvz                                         as DistrCntrListingProcedure,
      //      maw1.ldvfl                                         as StoreListingStartDate,
      //      maw1.ldbfl                                         as StoreListingEndDate,
      //      maw1.ldvzl                                         as DistrCntrListingStartDate,
      //      maw1.ldbzl                                         as DistrCntrListingEndDate,
      //      maw1.vdvfl                                         as StoreSaleStartDate,
      //      maw1.vdbfl                                         as StoreSaleEndDate,
      //      maw1.vdvzl                                         as DistrCntrSaleStartDate,
      //      maw1.vdbzl                                         as DistrCntrSaleEndDate,
      //      maw1.wbkla                                         as ValuationClass, // ref. handling for MBEW
      //      maw1.wstaw                                         as CommodityCode,
      //      maw1.wbwsp                                         as ValuationMargin, // ref. handling for MBEW
      //      maw1.wexpm                                         as CommoditiyCodeNumberUnit,

      //
      mara.mbrsh                                                           as IndustrySector, //added for external VH request'
      cast('' as changenumber )                                            as ChangeNumber,
      cast('' as productrevisionlevel)                                     as MaterialRevisionLevel,
      cast( 'X' as sdraft_is_active preserving type )                      as IsActiveEntity,

      @Semantics.systemDateTime.lastChangedAt: true
      case when mara.aenam <> '' then cast(dats_tims_to_tstmp(mara.laeda, mara.last_changed_time, 'UTC', $session.client, 'NULL') as changedatetime )
        else cast(dats_tims_to_tstmp(mara.ersda, mara.last_changed_time, 'UTC', $session.client, 'NULL') as changedatetime )
      end                                                                  as LastChangeDateTime,


      //new fields
      @Semantics.systemTime.lastChangedAt: true
      mara.last_changed_time                                               as LastChangeTime,
      mara.profl                                                           as DangerousGoodsIndProfile,
      mara.scm_matid_guid16                                                as ProductUUID,
      mara.scm_matid_guid22                                                as ProdSupChnMgmtUUID22,
      //new fields- Unified API
      mara.aeszn                                                           as ProductDocumentChangeNumber,
      mara.blanz                                                           as ProductDocumentPageCount,
      mara.blatt                                                           as ProductDocumentPageNumber,
      mara.bmatn                                                           as OwnInventoryManagedProduct,
      mara.cadkz                                                           as DocumentIsCreatedByCAD,
      mara.ferth                                                           as ProductionOrInspectionMemoTxt,
      mara.formt                                                           as ProductionMemoPageFormat,
      mara.gtin_variant                                                    as GlobalTradeItemNumberVariant,
      mara.ihivi                                                           as ProductIsHighlyViscous,
      mara.iloos                                                           as TransportIsInBulk,
      mara.kosch                                                           as ProdAllocDetnProcedure,
      mara.kzeff                                                           as ProdEffctyParamValsAreAssigned,
      mara.kzumw                                                           as ProdIsEnvironmentallyRelevant,
      mara.labor                                                           as LaboratoryOrDesignOffice,
      mara.magrv                                                           as PackagingMaterialGroup,
      mara.matfi                                                           as ProductIsLocked,
      mara.nrfhg                                                           as DiscountInKindEligibility,
      mara.ps_smartform                                                    as SmartFormName,
      mara.rmatp                                                           as PackingReferenceProduct,
      mara.wrkst                                                           as BasicMaterial,
      mara.zeinr                                                           as ProductDocumentNumber,
      mara.zeivr                                                           as ProductDocumentVersion,
      mara.zeiar                                                           as ProductDocumentType,
      mara.zeifo                                                           as ProductDocumentPageFormat,
      mara.cuobf                                                           as ProductConfiguration,

      mara.sgt_covsa                                                       as SegmentationStrategy,
      mara.sgt_rel                                                         as SegmentationIsRelevant,
      @ObjectModel.foreignKey.association: '_ChemicalComplianceRelevant'
      @ObjectModel.text.association: '_ChemicalComplianceRlvtText'
      mara.chml_cmplnc_rlvnce_ind                                          as IsChemicalComplianceRelevant,

      //      The below fields are requested by Retail Colleagues.
      mara.logistical_mat_category                                         as LogisticalProductCategory,
      mara.sales_material                                                  as SalesProduct,

      //Add Missisng Fields 200812
      mara.przus                                                           as ProductComposition,
      mara.msbookpartno                                                    as MsBookPartNumber,
      mara.medium                                                          as Medium,
      mara.sgt_csgr                                                        as SegmentationStructure,
      mara.rmatp_pb                                                        as ReferencePrdForPackageBuilding,
      mara.prod_shape                                                      as ProductShape,
      mara.mo_profile_id                                                   as ProductOrientationProfile,
      mara.overhang_tresh                                                  as OverhangThreshold,
      mara.bridge_tresh                                                    as BridgeThreshold,
      mara.bridge_max_slope                                                as MaximumSlopeForBridges,
      mara.height_nonflat                                                  as AbsoluteHeightThreshold,
      mara.height_nonflat_uom                                              as UomOfAbsHeightThreshold,
      mara.vhart                                                           as PackagingMaterialType,
      mara.ergew                                                           as AllowedPkgWeight,
      mara.ergei                                                           as UnitOfWeight,
      mara.ervol                                                           as AllowedPkgVolume,
      mara.ervoe                                                           as PackagingVolumeUnit,
      mara.fuelg                                                           as MaximumLevel,
      mara.stfak                                                           as StackabilityFactor,
      mara.gewto                                                           as ExcessWtTolerance,
      mara.volto                                                           as ExcessVolumeTol,
      mara.kzgvh                                                           as ClosedPackagMaterial,
      mara.scm_maturity_dur                                                as MaturationTime,
      //mara.scm_shlf_lfe_req_max                                             as ReqMaxShLife,
      cast( mara.scm_shlf_lfe_req_max as abap.char( 20 ) )                 as ReqMaxShLife,
      mara.rbnrm                                                           as CatalogProfile,
      mara.logunit                                                         as LogisticsUom,
      mara.cwqrel                                                          as CatchweightRelevant,
      mara.cwqproc                                                         as CwProfileForCwQty,
      mara.cwqtolgr                                                        as CatchWtToleranceGroup
//      mara.zprd_brand                                                      as PrdBrand,       
//      mara.zprd_form                                                       as PrdForm,         
//      mara.zprd_segment                                                    as PrdSegment,     
//      _ProductTypeName,
//      _ProductRetail,
//      _ProductProcurement,
//      _ProductSales,
//      _MDProductHierarchyNode,
//      _ChemicalComplianceRlvtText,
//      _ChemicalComplianceRelevant,
//      _ItemCategoryGroupText,
//      _ItemCategoryGroup,
//      _BrandText,
//      //Start of ESH related associations---------------------------
//      _ESHProductSalesDelivery,
//      _ESHSourceOfSupply,
//      _ESHSupplier,
//      _ESHTextObjectPlainLongText,
//      _ESHDocInfoRecordObjectLink,
//      _ESHPurOrderQuantityUnitText,
//      _ESHProductPlant,
//      _ESHCharValueAssignment,
//      _ESHClassAssignment
      //End of ESH related associations------------------------------
}
