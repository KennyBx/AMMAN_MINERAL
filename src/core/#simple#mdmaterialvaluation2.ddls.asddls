@AbapCatalog.sqlViewName: '/SIMPLE/MDMATVA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Valuation Data2'
define view /SIMPLE/MDMATERIALVALUATION2 as select from /SIMPLE/MDMATERIALVALUATION {
    key Material as material,
    key PlantID as plantID,
    ValuationArea as valuationArea,
    Price as price,
    PriceUnitQty as priceUnitQty,
    Currency as currency,
    Description as description
}
