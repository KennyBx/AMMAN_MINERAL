// Product Sales Delivery (active)
@AbapCatalog.sqlViewName: '/SIMPLE/IPRSDLV'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Sales Delivery Core Entity'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #M
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductSalesDelivery  
  as select from mvke 

  association [1..1] to /SIMPLE/I_Product                  as _Product                       on  $projection.Product = _Product.Product
//  association [1..1] to /SIMPLE/I_SalesOrganization        as _SalesOrganization             on  $projection.ProductSalesOrg = _SalesOrganization.SalesOrganization
//  association [1..1] to /SIMPLE/I_DistributionChannel      as _DistributionChannel           on  $projection.ProductDistributionChnl = _DistributionChannel.DistributionChannel

  association [0..1] to E_Productsalesdelivery     as _ProdSalesDeliveryExt          on  mvke.matnr                          = _ProdSalesDeliveryExt.Product
                                                                                     and $projection.ProductSalesOrg         = _ProdSalesDeliveryExt.ProductSalesOrganization
                                                                                     and $projection.ProductDistributionChnl = _ProdSalesDeliveryExt.ProductDistributionChannel

//  association [0..1] to /SIMPLE/I_ItemCategoryGroup        as _ItemCategoryGroup             on  $projection.ItemCategoryGroup = _ItemCategoryGroup.ItemCategoryGroup
//  association [0..*] to /SIMPLE/I_ItemCategoryGroupT       as _ItemCategoryGroupText         on  $projection.ItemCategoryGroup = _ItemCategoryGroupText.ItemCategoryGroup

//  association [0..1] to /SIMPLE/I_PrdExAsstmtPriority    as _ProdExtAssortmentPriority     on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriority.ProdExtAssortmentPriority
//  association [0..*] to /SIMPLE/I_PrdExAsstmtPriorityT   as _ProdExtAssortmentPriorityText on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriorityText.ProdExtAssortmentPriority

{
      @ObjectModel.foreignKey.association: '_Product'
  key cast (mvke.matnr  as productnumber)                      as Product,
      @ObjectModel.foreignKey.association: '_SalesOrganization'
  key mvke.vkorg                                               as ProductSalesOrg,
      @ObjectModel.foreignKey.association: '_DistributionChannel'
  key mvke.vtweg                                               as ProductDistributionChnl,
      mvke.aumng                                               as MinimumOrderQuantity,
      mvke.dwerk                                               as SupplyingPlant,
      cast (mvke.kondm      as pricespecificationproductgroup) as PriceSpecificationProductGroup,
      mvke.ktgrm                                               as AccountDetnProductGroup,
      mvke.lfmng                                               as DeliveryNoteProcMinDelivQty,
      @ObjectModel.foreignKey.association: '_ItemCategoryGroup'
      @ObjectModel.text.association: '_ItemCategoryGroupText'
      mvke.mtpos                                               as ItemCategoryGroup,
      mvke.schme                                               as DeliveryQuantityUnit,
      mvke.scmng                                               as DeliveryQuantity,
      mvke.vmsta                                               as ProductSalesStatus,
      mvke.vmstd                                               as ProductSalesStatusValidityDate,
      mvke.vrkme                                               as SalesMeasureUnit,
      mvke.lvorm                                               as IsMarkedForDeletion,
      -- New Fields
      mvke.prodh                                               as ProductHierarchy,
      cast (mvke.mvgr1      as firstsalesspecproductgroup)     as FirstSalesSpecProductGroup,
      cast (mvke.mvgr2      as secondsalesspecproductgroup)    as SecondSalesSpecProductGroup,
      cast (mvke.mvgr3      as thirdsalesspecproductgroup)     as ThirdSalesSpecProductGroup,
      cast (mvke.mvgr4      as fourthsalesspecproductgroup)    as FourthSalesSpecProductGroup,
      cast (mvke.mvgr5      as fifthsalesspecproductgroup)     as FifthSalesSpecProductGroup,
      mvke.efmng                                               as MinimumMakeToOrderOrderQty,

      //RETAIL FIELDS ADDED ON 25.4.16
      mvke.versg                                               as LogisticsStatisticsGroup,
      mvke.bonus                                               as VolumeRebateGroup,
      mvke.provg                                               as ProductCommissionGroup,
      mvke.sktof                                               as CashDiscountIsDeductible,
      mvke.pmatn                                               as PricingReferenceProduct,
      mvke.sstuf                                               as AssortmentGrade,
      mvke.lstfl                                               as StoreListingProcedure,
      mvke.lstvz                                               as DistrCntrListingProcedure,
      cast(mvke.ldvfl  as storelistingstartdate )              as StoreListingStartDate,
      cast(mvke.ldbfl as storelistingenddate )                 as StoreListingEndDate,
      cast(mvke.ldvzl as distrcntrlistingstartdate  )          as DistrCntrListingStartDate,
      cast(mvke.ldbzl as  distrcntrlistingenddate )            as DistrCntrListingEndDate,
      cast (mvke.vdvfl as  storesalestartdate )                as StoreSaleStartDate,
      cast(mvke.vdbfl as  storesaleenddate  )                  as StoreSaleEndDate,
      cast (mvke.vdvzl as  distrcntrsalestartdate )            as DistrCntrSaleStartDate,
      cast(mvke.vdbzl as  distrcntrsaleenddate )               as DistrCntrSaleEndDate,
      mvke.rdprf                                               as RoundingProfile,
      mvke.megru                                               as ProductUnitGroup,
      mvke.lfmax                                               as MaxDeliveryQtyStoreOrder,
      mvke.pbind                                               as PriceFixingCategory,
      mvke.vavme                                               as VariableSalesUnitIsNotAllowed,
      mvke.matkc                                               as CompetitionPressureCategory,
      mvke.prat1                                               as ProductHasAttributeID01,
      mvke.prat2                                               as ProductHasAttributeID02,
      mvke.prat3                                               as ProductHasAttributeID03,
      mvke.prat4                                               as ProductHasAttributeID04,
      mvke.prat5                                               as ProductHasAttributeID05,
      mvke.prat6                                               as ProductHasAttributeID06,
      mvke.prat7                                               as ProductHasAttributeID07,
      mvke.prat8                                               as ProductHasAttributeID08,
      mvke.prat9                                               as ProductHasAttributeID09,
      mvke.prata                                               as ProductHasAttributeID10,
      cast( 'X' as sdraft_is_active preserving type )          as IsActiveEntity, // to enbale extensibility in Draft 2.0
      @ObjectModel.foreignKey.association: '_ProdExtAssortmentPriority'
      @ObjectModel.text.association: '_ProdExtAssortmentPriorityText'
      mvke.pflks                                               as ProdExtAssortmentPriority,
      _Product
//      _SalesOrganization
//      _DistributionChannel,
//      _ItemCategoryGroup,
//      _ItemCategoryGroupText,
//      _ProdExtAssortmentPriority,
//      _ProdExtAssortmentPriorityText
}
