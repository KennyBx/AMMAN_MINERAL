@AbapCatalog.sqlViewName: '/SIMPLE/CPRDUOM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductUnitsOfMeasure'
define view /SIMPLE/C_PrdUnitsOfMeasure
  as select from /SIMPLE/I_PrdUnitsOfMeasure  
  composition [0..*] of /SIMPLE/C_PrdUnitsOfMeasureEAN as _InternationalArticleNumber
  association to parent /SIMPLE/C_Product              as _Product on $projection.product = _Product.product
{

  key Product                        as product,
  key AlternativeUnit                as alternativeUnit,
      QuantityNumerator              as quantityNumerator, 
      QuantityDenominator            as quantityDenominator,
      MaterialVolume                 as materialVolume,
      VolumeUnit                     as volumeUnit,
      GrossWeight                    as grossWeight,
      WeightUnit                     as weightUnit,
      GlobalTradeItemNumber          as globalTradeItemNumber,
      GlobalTradeItemNumberCategory  as globalTradeItemNumberCategory,
      UnitSpecificProductLength      as unitSpecificProductLength,
      UnitSpecificProductWidth       as unitSpecificProductWidth,
      UnitSpecificProductHeight      as unitSpecificProductHeight,
      ProductMeasurementUnit         as productMeasurementUnit,
      LowerLevelPackagingUnit        as lowerLevelPackagingUnit,
      RemainingVolumeAfterNesting    as remainingVolumeAfterNesting,
      MaximumStackingFactor          as maximumStackingFactor,
      CapacityUsage                  as capacityUsage,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _InternationalArticleNumber, //danh123,
      _Product
      //   IsActiveEntity,

}
