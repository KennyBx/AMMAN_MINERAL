@AbapCatalog.sqlViewName: '/SIMPLE/IBOMCVAL'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Components'
@ObjectModel.createEnabled: true
@Search.searchable: false
@AbapCatalog.preserveKey:true


define view /SIMPLE/I_BOMCOMPVALUATION
  as select distinct from /SIMPLE/I_ProductValuation as _Valuation
  inner join t001w as T on _Valuation.ValuationArea = T.bwkey
{
  key _Valuation.Product as Material,
  key T.werks   as PlantID,
      T.bwkey   as ValuationArea,
      case _Valuation.InventoryValuationProcedure 
      when 'S' then _Valuation.StandardPrice
      when 'V' then _Valuation.MovingAveragePrice
      end as Price,
      _Valuation.PriceUnitQty as PriceUnitQty,
      _Valuation.Currency as Currency,
      T.name1   as Description
}
where _Valuation.ValuationType = ' '

