@AbapCatalog.sqlViewName: '/SIMPLE/CPRDMLA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductMLAccount'
define view /SIMPLE/C_ProductMLAccount
  as select from I_CurrentMatlValnPrice 
  association to parent /SIMPLE/C_ProductValuation as _Valuation on  $projection.product       = _Valuation.product
                                                                 and $projection.valuationArea = _Valuation.valuationArea
                                                                 and $projection.valuationType = _Valuation.valuationType

{  
  key Material                       as product,
  key ValuationArea                  as valuationArea,
  key InventoryValuationType         as valuationType,
  key CurrencyRole                   as currencyRole,
      Currency                       as currency,
      MaterialPriceControl           as productPriceControl,
      MaterialPriceUnitQty           as priceUnitQty,
      MovingAveragePrice             as movingAveragePrice,
      StandardPrice                  as standardPrice,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Valuation
}
where
  InvtryValnSpecialStockType = ''
