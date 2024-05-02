@AbapCatalog.sqlViewName: '/SIMPLE/CPRDVA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductValuationAccount'
define view /SIMPLE/C_PrdValuationAccount
  as select from /SIMPLE/I_PrdValuationAcct  
  association to parent /SIMPLE/C_ProductValuation as _Valuation on  $projection.product       = _Valuation.product
                                                                 and $projection.valuationArea = _Valuation.valuationArea
                                                                 and $projection.valuationType = _Valuation.valuationType
{
  key Product                        as product,
  key ValuationArea                  as valuationArea, 
  key ValuationType                  as valuationType,
      CommercialPrice1InCoCodeCrcy   as commercialPrice1InCoCodeCrcy,
      CommercialPrice2InCoCodeCrcy   as commercialPrice2InCoCodeCrcy,
      CommercialPrice3InCoCodeCrcy   as commercialPrice3InCoCodeCrcy,
      DevaluationYearCount           as devaluationYearCount,
      FutureEvaluatedAmountValue     as futureEvaluatedAmountValue,
      FuturePriceValidityStartDate   as futurePriceValidityStartDate,
      IsLIFOAndFIFORelevant          as isLIFOAndFIFORelevant,
      LIFOValuationPoolNumber        as lifoValuationPoolNumber,
      TaxPricel1InCoCodeCrcy         as taxPricel1InCoCodeCrcy,
      TaxPrice2InCoCodeCrcy          as taxPrice2InCoCodeCrcy,
      TaxPrice3InCoCodeCrcy          as taxPrice3InCoCodeCrcy,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Valuation
}
