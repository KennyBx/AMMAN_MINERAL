@AbapCatalog.sqlViewName: '/SIMPLE/IPPCOST'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@EndUserText.label: 'Core view for Product Plant Costing'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
define view /SIMPLE/I_ProductPlantCosting 
  as select from nsdm_e_marc as Costing 
  association [0..1] to E_Productplant as _ProdPlantCostingExt on  $projection.Product = _ProdPlantCostingExt.Product
                                                               and $projection.Plant   = _ProdPlantCostingExt.Plant

  association [1..1] to /SIMPLE/I_Product      as _Product             on  $projection.Product = _Product.Product
{
  key Costing.matnr                                        as Product,
  key Costing.werks                                        as Plant,
      Costing.kzkup                                        as IsCoProduct,

      // New fields from MDG model, as part of unified API development
      Costing.losgr                                        as CostingLotSize,
      Costing.plnnr                                        as TaskListGroup,
      Costing.plnty                                        as TaskListType,
      Costing.sobsk                                        as CostingSpecialProcurementType,
      Costing.stlal                                        as SourceBOMAlternative,
      Costing.stlan                                        as ProductBOMUsage,
      Costing.ncost                                        as ProductIsCostingRelevant,
      Costing.aplal                                        as TaskListGroupCounter,
      Costing.awsls                                        as VarianceKey,
      Costing.fvidk                                        as CostingProductionVersion,
      Costing.fxpru                                        as IsFixedPriceCoProduct,

      _Product
}
