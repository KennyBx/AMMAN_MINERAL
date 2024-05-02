// Product Units Of Measure (active)
@AbapCatalog.sqlViewName: '/SIMPLE/IPRDUOM'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Units Of Measure core entity'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true

define view /SIMPLE/I_PrdUnitsOfMeasure 
  as select from marm

//  association [1..1] to /SIMPLE/I_Product               as _Product                    on  $projection.Product = _Product.Product
//
//  association [0..1] to E_Productunitsofmeasure as _ProdUOMExt                 on  $projection.Product         = _ProdUOMExt.Product
//                                                                               and $projection.AlternativeUnit = _ProdUOMExt.AlternativeUnit
//  association [0..1] to /SIMPLE/I_UnitOfMeasure         as _ProductMeasurementUnit     on  $projection.ProductMeasurementUnit = _ProductMeasurementUnit.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText     as _ProductMeasurementUnitText on  $projection.ProductMeasurementUnit = _ProductMeasurementUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure         as _AlternativeUnit            on  $projection.AlternativeUnit = _AlternativeUnit.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_UnitOfMeasureText     as _AlternativeUnitText        on  $projection.AlternativeUnit = _AlternativeUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_Intntnlartnmbcat      as _GlobalTradeItemNumber      on  $projection.GlobalTradeItemNumberCategory = _GlobalTradeItemNumber.InternationalArticleNumberCat
//  association [0..*] to /SIMPLE/I_Intntnlartnmbcattext  as _GlobalTradeItemNumberText  on  $projection.GlobalTradeItemNumberCategory = _GlobalTradeItemNumberText.InternationalArticleNumberCat


{

  key marm.matnr                                      as Product,
  key marm.meinh                                      as AlternativeUnit,
//      _AlternativeUnit,
//      _AlternativeUnitText,
      marm.umrez                                      as QuantityNumerator,
      marm.umren                                      as QuantityDenominator,

      marm.volum                                      as MaterialVolume,

      marm.voleh                                      as VolumeUnit,
      marm.brgew                                      as GrossWeight,
      marm.gewei                                      as WeightUnit,

      //Retail fields

      marm.ean11                                      as GlobalTradeItemNumber,
      marm.numtp                                      as GlobalTradeItemNumberCategory,
//      _GlobalTradeItemNumber,
//      _GlobalTradeItemNumberText,

      marm.laeng                                      as UnitSpecificProductLength,

      marm.breit                                      as UnitSpecificProductWidth,
  
      marm.hoehe                                      as UnitSpecificProductHeight,

      marm.meabm                                      as ProductMeasurementUnit,
//      _ProductMeasurementUnit,
//      _ProductMeasurementUnitText,
      marm.mesub                                      as LowerLevelPackagingUnit,

      //EWM
      marm.nest_ftr                                   as RemainingVolumeAfterNesting,
      marm.max_stack                                  as MaximumStackingFactor,
      marm.capause                                    as CapacityUsage,

      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0

      // New fields from MDG model, as part of unified API development
      marm.ty2tq                                      as UnitOfMeasureCategory,
      marm.gtin_variant                               as ProductGTINVariant

//      _Product

}
