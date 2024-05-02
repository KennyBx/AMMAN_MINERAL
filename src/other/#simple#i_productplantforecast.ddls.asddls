@AbapCatalog.sqlViewName: '/SIMPLE/IPPFC'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Plant Forecasting View'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_ProductPlantForecast
 
  as select from nsdm_e_marc as Forecast 
  association [0..1] to E_Productplant       as _ProdPlantForecastExt        on  $projection.Product = _ProdPlantForecastExt.Product
                                                                             and $projection.Plant   = _ProdPlantForecastExt.Plant


  association [1..1] to /SIMPLE/I_Product            as _Product                     on  $projection.Product = _Product.Product
  association [1..1] to /SIMPLE/I_Product            as _ConsumptionReferenceProduct on  $projection.ConsumptionReferenceProduct = _ConsumptionReferenceProduct.Product
  association [0..*] to /SIMPLE/I_ProductDescription as _ConsumptionRefProductName   on  $projection.ConsumptionReferenceProduct = _ConsumptionRefProductName.Product
  association [1..1] to /SIMPLE/I_Plant              as _ConsumptionReferencePlant   on  $projection.ConsumptionReferencePlant = _ConsumptionReferencePlant.Plant
{
  key Forecast.matnr                                        as Product,
  key Forecast.werks                                        as Plant,
      Forecast.vrbdt                                        as ConsumptionRefUsageEndDate,
      Forecast.vrbfk                                        as ConsumptionQtyMultiplier,
      @ObjectModel.foreignKey.association: '_ConsumptionReferenceProduct'
      @ObjectModel.text.association: '_ConsumptionRefProductName'
      Forecast.vrbmt                                        as ConsumptionReferenceProduct,
      @ObjectModel.foreignKey.association: '_ConsumptionReferencePlant'
      Forecast.vrbwk                                        as ConsumptionReferencePlant,

      // New fields from MDG model, as part of unified API development
      Forecast.kzkfk                                        as CorrectionFactorIsRequired,
      Forecast.autru                                        as ForecastModelIsReset,


      _Product,
      _ConsumptionReferenceProduct,
      _ConsumptionRefProductName,
      _ConsumptionReferencePlant

}
