@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantIntlTrd'
define view /SIMPLE/C_PrdPlantIntlTrd
  as select from /SIMPLE/I_ProductPlantIntlTrd 
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product,
  key Plant                          as plant,
      CountryOfOrigin                as countryOfOrigin,
      RegionOfOrigin                 as regionOfOrigin,
      ConsumptionTaxCtrlCode         as consumptionTaxCtrlCode,
      ExportAndImportProductGroup    as exportAndImportProductGroup,
      ProductCASNumber               as productCASNumber,
      CommoditiyCodeNumberUnit       as commoditiyCodeNumberUnit,
      ProdIntlTradeClassification    as prodIntlTradeClassification,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
