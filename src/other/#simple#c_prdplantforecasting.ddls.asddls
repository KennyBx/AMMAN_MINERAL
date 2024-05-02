@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantForecasting'
define view /SIMPLE/C_PrdPlantForecasting
  as select from /SIMPLE/I_ProductPlantForecast 
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product,
  key Plant                          as plant,
      ConsumptionRefUsageEndDate     as consumptionRefUsageEndDate,
      ConsumptionQtyMultiplier       as consumptionQtyMultiplier,
      ConsumptionReferenceProduct    as consumptionReferenceProduct,
      ConsumptionReferencePlant      as consumptionReferencePlant,
      ForecastModelIsReset           as forecastModelIsReset,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
