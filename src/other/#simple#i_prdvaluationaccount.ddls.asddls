@AbapCatalog.sqlViewName: '/SIMPLE/IPRDVAC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@EndUserText.label: 'Core view for Product Valuation Account'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true

define view /SIMPLE/I_PrdValuationAcct
  as select from Mbv_Mbew as ValuationAccount

  association [1..1] to I_Product          as _Product          on  $projection.Product = _Product.Product
  association [0..1] to E_Productvaluation as _ProdValuationExt on  $projection.Product       = _ProdValuationExt.Product
                                                                and $projection.ValuationArea = _ProdValuationExt.ValuationArea
                                                                and $projection.ValuationType = _ProdValuationExt.ValuationType

{

  key ValuationAccount.matnr                                    as Product,

  key ValuationAccount.bwkey                                    as ValuationArea,

  key ValuationAccount.bwtar                                    as ValuationType,
      ValuationAccount.bwprh                                    as CommercialPrice1InCoCodeCrcy,
      ValuationAccount.bwph1                                    as CommercialPrice2InCoCodeCrcy,
      ValuationAccount.vjbwh                                    as CommercialPrice3InCoCodeCrcy,
      ValuationAccount.abwkz                                    as DevaluationYearCount,
      ValuationAccount.zkprs                                    as FutureEvaluatedAmountValue,
      ValuationAccount.zkdat                                    as FuturePriceValidityStartDate,
      cast (ValuationAccount.xlifo  as boole_d preserving type) as IsLIFOAndFIFORelevant,
      ValuationAccount.mypol                                    as LIFOValuationPoolNumber,
      //      ValuationAccount.vmvpr                                        as PriceCtrlInPrevPeriodInd,  // Previous period read only PSTAT
      //      ValuationAccount.vmpei                                        as PriceUnitPrevPeriod, // Previous period read only PSTAT
      //      ValuationAccount.vjpei                                        as PriceUnitPrevYear, // Previous year read only PSTAT
      ValuationAccount.vjstp                                    as StandardPricePrevYear,
      //      ValuationAccount.mlmaa                                        as TaxClassificationCategory,  // PSTAT Changes Read Only
      ValuationAccount.bwprs                                    as TaxPricel1InCoCodeCrcy,
      ValuationAccount.bwps1                                    as TaxPrice2InCoCodeCrcy,
      ValuationAccount.vjbws                                    as TaxPrice3InCoCodeCrcy,
      ValuationAccount.bwpei                                    as TaxBasedPricesPriceUnitQty,

      _Product

}
