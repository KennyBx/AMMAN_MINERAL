@AbapCatalog.sqlViewName: '/SIMPLE/CPRDEAN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductUnitsOfMeasureEAN'
define view /SIMPLE/C_PrdUnitsOfMeasureEAN
  as select from I_ProductUnitOfMeasureEAN 
  association to parent /SIMPLE/C_PrdUnitsOfMeasure as _ProductUnitsOfMeasure on  $projection.product         = _ProductUnitsOfMeasure.product
                                                                              and $projection.alternativeUnit = _ProductUnitsOfMeasure.alternativeUnit
{
  key Product                        as product, 
  key AlternativeUnit                as alternativeUnit,
  key ConsecutiveNumber              as consecutiveNumber,
      ProductStandardID              as productStandardID,
      InternationalArticleNumberCat  as internationalArticleNumberCat,
      IsMainGlobalTradeItemNumber    as isMainGlobalTradeItemNumber,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _ProductUnitsOfMeasure
}
