@AbapCatalog.sqlViewName: '/SIMPLE/CPRDWS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductWorkScheduling'
define view /SIMPLE/C_PrdWorkScheduling
  as select from /SIMPLE/I_PrdWorkScheduling 
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{
  key Product                        as product,
  key Plant                          as plant,
      MaterialBaseQuantity           as materialBaseQuantity,
      UnlimitedOverDelivIsAllowed    as unlimitedOverDelivIsAllowed,
      OverDelivToleranceLimit        as overDelivToleranceLimit,
      UnderDelivToleranceLimit       as underDelivToleranceLimit,
      //      GoodsIssueUnit,
      //      StockDeterminationGroup,
      //      DistrCntrDistributionProfile,
      //      ProductCFOPCategory,
      ProductionInvtryManagedLoc     as productionInvtryManagedLoc,
      //     ProductUnitGroup,
      //      ProfileCode,
      //      ProfileValidityStartDate,
      //      FiscalYearVariant,
      //      PeriodType,
      //      ProfitCenter,
      //      SerialNumberProfile,
      //      ConfigurableProduct,
      //      IsBatchManagementRequired,
      //      IsNegativeStockAllowed,
      //      ProductProductionQuantityUnit,
      //      TransitionMatrixProductsGroup,
      //      OrderChangeManagementProfile,
      //     SetupAndTeardownTime,
      //      ProductProcessingTime,
      //      TransitionTime,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant
}
