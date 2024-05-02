@AbapCatalog.sqlViewName: '/SIMPLE/CPRDV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductValuation'
define view /SIMPLE/C_ProductValuation
  as select from /SIMPLE/I_ProductValuation
  composition [0..1] of /SIMPLE/C_PrdValuationAccount as _ValuationAccount
  composition [0..*] of /SIMPLE/C_ProductMLAccount    as _MLAccount
  composition [0..*] of /SIMPLE/C_ProductMLPrices     as _MLPrices
  association to parent /SIMPLE/C_Product             as _Product on $projection.product = _Product.product
{
  key Product                         as product,
  key ValuationArea                   as valuationArea,
  key ValuationType                   as valuationType,
      ValuationClass                  as valuationClass,
      PriceDeterminationControl       as priceDeterminationControl,
      StandardPrice                   as standardPrice,
      PriceUnitQty                    as priceUnitQty,
      InventoryValuationProcedure     as inventoryValuationProcedure,
      IsMarkedForDeletion             as isMarkedForDeletion,
      MovingAveragePrice              as movingAveragePrice,
      ValuationCategory               as valuationCategory,
      ProductUsageType                as productUsageType,
      ProductOriginType               as productOriginType,
      IsProducedInhouse               as isProducedInhouse,
      ProdCostEstNumber               as prodCostEstNumber,
      ProjectStockValuationClass      as projectStockValuationClass,
      ValuationClassSalesOrderStock   as valuationClassSalesOrderStock,
      PlannedPrice1InCoCodeCrcy       as plannedPrice1InCoCodeCrcy,
      PlannedPrice2InCoCodeCrcy       as plannedPrice2InCoCodeCrcy,
      PlannedPrice3InCoCodeCrcy       as plannedPrice3InCoCodeCrcy,
      FuturePlndPrice1ValdtyDate      as futurePlndPrice1ValdtyDate,
      FuturePlndPrice2ValdtyDate      as futurePlndPrice2ValdtyDate,
      FuturePlndPrice3ValdtyDate      as futurePlndPrice3ValdtyDate,
      TaxBasedPricesPriceUnitQty      as taxBasedPricesPriceUnitQty,
      PriceLastChangeDate             as priceLastChangeDate,
      PlannedPrice                    as plannedPrice,
      PrevInvtryPriceInCoCodeCrcy     as prevInvtryPriceInCoCodeCrcy,
      ValuatedUoM                     as valuatedUoM,
      WithQtyStructure                as withQtyStructure,
      MaterialOrigin                  as materialOrigin,
      OriginGroup                     as originGroup,
      OverheadGroup                   as overheadGroup,
      CurrentPeriod                   as currentPeriod,
      CurrentFiscalYear               as currentFiscalYear,
      PreviousPeriod                  as previousPeriod,
      PreviousFiscalYear              as previousFiscalYear,
      PreviousPlannedPrice            as previousPlannedPrice,
      FutureCostEstimateFiscalPeriod  as futureCostEstimateFiscalPeriod,
      FutureCostEstFiscalYear         as futureCostEstFiscalYear,
      TaxClassificationCategory       as taxClassificationCategory,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_GETPRICECHANGEDOC'
      cast( '' as abap.char( 10 ) )   as priceChangeDocument,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_GETPRICECHANGEDOC'
      cast( '00000000' as abap.dats ) as postingDate,
      cast( '' as abap_boolean )      as priceChange,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )   as action,
      cast( '' as abap.char( 999 ) )  as mdgMarkForChange,

      /* Associations */
      _ValuationAccount,
      _MLAccount,
      _MLPrices,
      _Product
}
