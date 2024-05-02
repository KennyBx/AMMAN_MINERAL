// active core entity
@AbapCatalog.sqlViewName: '/SIMPLE/IPRDRET'
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }   //addedforVH
@VDM.viewType: #BASIC

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_ProductRetail'
@ObjectModel.representativeKey: 'Product'


@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true

//@Search.searchable: true    //added for VH
//@ObjectModel:{
//lifecycle : {
//     enqueue : {
//        expiryBehavior :
//           #RELATIVE_TO_LAST_CHANGE,
//        expiryInterval : 'PT15M',
//       notificationBeforeExpiryInterval : 'PT2M'},
//     processing : {
//        expiryBehavior :
//            #RELATIVE_TO_LAST_CHANGE,
//        expiryInterval : 'PT30M',
//        notificationBeforeExpiryInterval :  'PT4M' }
//         }
//
//}

define view /SIMPLE/I_ProductRetail
  as select from maw1
//  association [0..1] to /SIMPLE/I_Country                   as _CountryOfOrigin               on  $projection.CountryOfOrigin = _CountryOfOrigin.Country
//  association [0..*] to /SIMPLE/I_CountryText               as _CountryText                   on  $projection.CountryOfOrigin = _CountryText.Country
  association [0..1] to /SIMPLE/I_Region                    as _RegionOfOrigin                on  $projection.RegionOfOrigin  = _RegionOfOrigin.Region
                                                                                      and $projection.CountryOfOrigin = _RegionOfOrigin.Country
  association [0..1] to /SIMPLE/I_UnitOfMeasure             as _GoodsIssueUnit                on  $projection.GoodsIssueUnit = _GoodsIssueUnit.UnitOfMeasure
  association [0..*] to /SIMPLE/I_UnitOfMeasureText         as _GoodsIssueText                on  $projection.GoodsIssueUnit = _GoodsIssueText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_Matlabcclassif            as _ConsumptionValueCategory      on  $projection.ConsumptionValueCategory = _ConsumptionValueCategory.MaterialABCClassification
//  association [0..*] to /SIMPLE/I_Matlabcclassiftext        as _ConsumptionValueCategoryText  on  $projection.ConsumptionValueCategory = _ConsumptionValueCategoryText.MaterialABCClassification

  association [0..1] to /SIMPLE/I_PurchasingGroup           as _PurchasingGroup               on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup
  association [0..1] to /SIMPLE/I_LoadingGroup              as _LoadingGroup                  on  $projection.LoadingGroup = _LoadingGroup.LoadingGroup
  association [0..*] to /SIMPLE/I_LoadingGroupText          as _LoadingGroupText              on  $projection.LoadingGroup = _LoadingGroupText.LoadingGroup

  association [0..1] to /SIMPLE/I_PrdExAsstmtPriority       as _ProdExtAssortmentPriority     on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriority.ProdExtAssortmentPriority
  association [0..*] to /SIMPLE/I_PrdExAsstmtPriorityT      as _ProdExtAssortmentPriorityText on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriorityText.ProdExtAssortmentPriority

  association [0..1] to /SIMPLE/I_UnitOfMeasure             as _SalesUnit                     on  $projection.SalesUnit = _SalesUnit.UnitOfMeasure
  association [0..*] to /SIMPLE/I_UnitOfMeasureText         as _SalesUnitText                 on  $projection.SalesUnit = _SalesUnitText.UnitOfMeasure

{ // root node fields

  key cast (maw1.matnr as productnumber preserving type ) as Product,

      maw1.servv                                          as ServiceAgreement,
//      @ObjectModel.foreignKey.association: '_ConsumptionValueCategory'
//      @ObjectModel.text.association: '_ConsumptionValueCategoryText'
      maw1.wmaab                                          as ConsumptionValueCategory, // ref. handling for MARC
//      _ConsumptionValueCategory,
//      _ConsumptionValueCategoryText,
      @ObjectModel.foreignKey.association: '_GoodsIssueUnit'
      @ObjectModel.text.association: '_GoodsIssueText'
      maw1.wausm                                          as GoodsIssueUnit, // ref. handling for MARC
      _GoodsIssueText,
      _GoodsIssueUnit,
      @ObjectModel.foreignKey.association: '_CountryOfOrigin'
      @ObjectModel.text.association: '_CountryText'
      maw1.wherl                                          as CountryOfOrigin, // ref. handling for MARC
//      _CountryText,
      @ObjectModel.foreignKey.association: '_RegionOfOrigin'
      maw1.wherr                                          as RegionOfOrigin, // ref. handling for MARC
      maw1.sstuf                                          as AssortmentGrade,
      maw1.lstfl                                          as StoreListingProcedure,
      maw1.lstvz                                          as DistrCntrListingProcedure,
      cast(maw1.ldvfl as storelistingstartdate )          as StoreListingStartDate,
      cast(maw1.ldbfl as storelistingenddate )            as StoreListingEndDate,
      cast(maw1.ldvzl as distrcntrlistingstartdate )      as DistrCntrListingStartDate,
      cast(maw1.ldbzl as  distrcntrlistingenddate )       as DistrCntrListingEndDate,
      cast(maw1.vdvfl as  storesalestartdate )            as StoreSaleStartDate,
      cast(maw1.vdbfl as  storesaleenddate  )             as StoreSaleEndDate,
      cast(maw1.vdvzl as  distrcntrsalestartdate )        as DistrCntrSaleStartDate,
      cast(maw1.vdbzl as  distrcntrsaleenddate )          as DistrCntrSaleEndDate,
      maw1.wbkla                                          as ValuationClass, // ref. handling for MBEW
      maw1.wstaw                                          as CommodityCode,
      maw1.wbwsp                                          as ValuationMargin, // ref. handling for MBEW
      maw1.wexpm                                          as CommoditiyCodeNumberUnit,
      @ObjectModel.foreignKey.association: '_SalesUnit'
      @ObjectModel.text.association: '_SalesUnitText'
      maw1.wvrkm                                          as SalesUnit,

      @ObjectModel.foreignKey.association: '_PurchasingGroup'
      maw1.wekgr                                          as PurchasingGroup,
//
      @ObjectModel.foreignKey.association: '_LoadingGroup'
      @ObjectModel.text.association:'_LoadingGroupText'
      maw1.wladg                                          as LoadingGroup,
      @ObjectModel.foreignKey.association: '_ProdExtAssortmentPriority'
      @ObjectModel.text.association: '_ProdExtAssortmentPriorityText'
      maw1.pflks                                          as ProdExtAssortmentPriority,
      maw1.bbtyp                                          as AssortmentListType,

      _PurchasingGroup,

//      _CountryOfOrigin,
      _RegionOfOrigin,
      _LoadingGroup,
      _LoadingGroupText,

      _ProdExtAssortmentPriority,
      _ProdExtAssortmentPriorityText,
      _SalesUnit,
      _SalesUnitText
}
