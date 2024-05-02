@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductSalesDelivery'
define view /SIMPLE/C_ProductSalesDelivery 
  as select from /SIMPLE/I_ProductSalesDelivery as SalesDelivery
  composition [0..*] of /SIMPLE/C_ProductSalesText as _SalesText 
  association to parent /SIMPLE/C_Product          as _Product on $projection.product = _Product.product
{
  key  Product                        as product,
  key  ProductSalesOrg                as productSalesOrg,
  key  ProductDistributionChnl        as productDistributionChnl,
       MinimumOrderQuantity           as minimumOrderQuantity,
       SupplyingPlant                 as supplyingPlant,
       PriceSpecificationProductGroup as priceSpecificationProductGroup,
       AccountDetnProductGroup        as accountDetnProductGroup,
       DeliveryNoteProcMinDelivQty    as deliveryNoteProcMinDelivQty,
       ItemCategoryGroup              as itemCategoryGroup,
       DeliveryQuantityUnit           as deliveryQuantityUnit,
       DeliveryQuantity               as deliveryQuantity,
       ProductSalesStatus             as productSalesStatus,
       ProductSalesStatusValidityDate as productSalesStatusValidityDate,
       SalesMeasureUnit               as salesMeasureUnit,
       IsMarkedForDeletion            as isMarkedForDeletion,
       ProductHierarchy               as productHierarchy,
       FirstSalesSpecProductGroup     as firstSalesSpecProductGroup,
       SecondSalesSpecProductGroup    as secondSalesSpecProductGroup,
       ThirdSalesSpecProductGroup     as thirdSalesSpecProductGroup,
       FourthSalesSpecProductGroup    as fourthSalesSpecProductGroup,
       FifthSalesSpecProductGroup     as fifthSalesSpecProductGroup,
       MinimumMakeToOrderOrderQty     as minimumMakeToOrderOrderQty,
       ProductHasAttributeID01        as productHasAttributeID01,
       ProductHasAttributeID02        as productHasAttributeID02,
       ProductHasAttributeID03        as productHasAttributeID03,
       ProductHasAttributeID04        as productHasAttributeID04,
       ProductHasAttributeID05        as productHasAttributeID05,
       ProductHasAttributeID06        as productHasAttributeID06,
       ProductHasAttributeID07        as productHasAttributeID07,
       ProductHasAttributeID08        as productHasAttributeID08,
       ProductHasAttributeID09        as productHasAttributeID09,
       ProductHasAttributeID10        as productHasAttributeID10,
       ProductUnitGroup               as productUnitGroup,
       CashDiscountIsDeductible       as cashDiscountIsDeductible,
       VariableSalesUnitIsNotAllowed  as variableSalesUnitIsNotAllowed,
       RoundingProfile                as roundingProfile,
       LogisticsStatisticsGroup       as logisticsStatisticsGroup,
       VolumeRebateGroup              as volumeRebateGroup,
       PricingReferenceProduct        as pricingReferenceProduct,
       ProductCommissionGroup         as productCommissionGroup,

       /* SimpleMDG specific fields for integration */
       cast( '' as abap.char( 10 ) )  as action,
       cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

       /* Associations */
       _SalesText,
       _Product

}
