@AbapCatalog.sqlViewName: '/SIMPLE/CPRDMLP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductMLPrice'
define view /SIMPLE/C_ProductMLPrices
  as select from I_CurrentMatlValnPrice 
  association to parent /SIMPLE/C_ProductValuation as _Valuation on  $projection.product       = _Valuation.product
                                                                 and $projection.valuationArea = _Valuation.valuationArea
                                                                 and $projection.valuationType = _Valuation.valuationType
{
  key Material                       as product,
  key ValuationArea                  as valuationArea,
  key InventoryValuationType         as valuationType,
  key CurrencyRole                   as currencyRole,  
      FuturePrice                    as futurePrice,
      FuturePriceValidityStartDate   as futurePriceValidityStartDate,
      PlannedPrice                   as plannedPrice,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Valuation
}
where
  InvtryValnSpecialStockType = ''
