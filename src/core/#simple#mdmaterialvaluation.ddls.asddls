@AbapCatalog.sqlViewName: '/SIMPLE/MDMATVAL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Valuation Data'
define view /SIMPLE/MDMATERIALVALUATION
  //  as select from mbew as M
  //  inner join t001w as T on M.bwkey = T.bwkey
  //{
  //  key M.matnr as Material,
  //  key T.werks   as PlantID,
  //      T.bwkey   as ValuationArea,
  //      case M.vprsv
  //      when 'S' then M.stprs
  //      when 'V' then M.verpr
  //      end as Price,
  //      M.peinh as PriceUnitQty
  ////      M.Currency as Currency,
  ////      T.name1   as Description
  //}
  //where M.bwtar = ' '
  as select from /SIMPLE/I_ProductValuation as M
    inner join   t001w                      as T on M.ValuationArea = T.bwkey
{
  key M.Product      as material,
  key T.werks        as plantID,
      T.bwkey        as valuationArea,
      @EndUserText.label:'Price'
      case M.InventoryValuationProcedure
      when 'S' then M.StandardPrice
      when 'V' then M.MovingAveragePrice
      end            as price,
      M.PriceUnitQty as priceUnitQty,
      M.Currency     as currency,
      T.name1        as description
}
where
  M.ValuationType = ' '
