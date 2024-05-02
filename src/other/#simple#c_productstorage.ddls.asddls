@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductStorage'
define view /SIMPLE/C_ProductStorage
  as select from    /SIMPLE/I_Productstorage 
    left outer join prdkzt as PeriodIndicator on  /SIMPLE/I_Productstorage.ShelfLifeExpirationDatePeriod = PeriodIndicator.iprkz
                                              and PeriodIndicator.spras                                  = $session.system_language
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
      StorageConditions              as storageConditions,
      TemperatureConditionInd        as temperatureConditionInd,
      HazardousMaterialNumber        as hazardousMaterialNumber,
      NmbrOfGROrGISlipsToPrintQty    as nmbrOfGROrGISlipsToPrintQty,
      LabelType                      as labelType,
      LabelForm                      as labelForm,
      MinRemainingShelfLife          as minRemainingShelfLife,
      ExpirationDate                 as expirationDate,
      StorageBinInstruction          as storageBinInstruction,
      TotalShelfLifeStoragePercent   as totalShelfLifeStoragePercent,
      PeriodIndicator.eprkz          as shelfLifeExpirationDatePeriod,
      ShelfLifeExprtnDateRndingRule  as shelfLifeExprtnDateRndingRule,
      TotalShelfLife                 as totalShelfLife,
      @Consumption.hidden: true
      AuthorizationGroup             as authorizationGroup,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Product
}
