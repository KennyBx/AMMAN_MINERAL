@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantCosting'
define view /SIMPLE/C_PrdPlantCosting
  as select from /SIMPLE/I_ProductPlantCosting 
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product,
  key Plant                          as plant,
      IsCoProduct                    as isCoProduct,
      TaskListType                   as taskListType,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
