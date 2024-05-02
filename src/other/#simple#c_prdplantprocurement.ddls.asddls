@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPPR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantProcurement'
define view /SIMPLE/C_PrdPlantProcurement
  as select from I_Productplantprocurement as plant
      inner join       t001w on plant.Plant   = t001w.werks
       left outer join mlan  on t001w.land1   = mlan.aland
                            and plant.Product = mlan.matnr
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant

{ 
  key Product                        as product,
  key Plant                          as plant,
      IsAutoPurOrdCreationAllowed    as isAutoPurOrdCreationAllowed,
      IsSourceListRequired           as isSourceListRequired,
      // IsPurgAcrossPurgGroup,
      SourceOfSupplyCategory         as sourceOfSupplyCategory,
      mlan.taxim                     as taxIndicator,
      // PurchasingGroup,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
