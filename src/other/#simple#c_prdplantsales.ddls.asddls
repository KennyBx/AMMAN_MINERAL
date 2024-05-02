@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantSales'
define view /SIMPLE/C_PrdPlantSales
  as select from I_Productplantsales
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant

{ 
  key Product                        as product,
  key Plant                          as plant,
      LoadingGroup                   as loadingGroup,
      // IsActiveEntity, // to enbale extensibility in Draft 2.0
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
