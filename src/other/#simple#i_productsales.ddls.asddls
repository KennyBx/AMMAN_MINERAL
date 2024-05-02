@AbapCatalog.sqlViewName: '/SIMPLE/IPSALES'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Sales active core entity'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductSales
  as select from mara
  //    left outer join maw1 on mara.matnr = maw1.matnr
  association [0..1] to /SIMPLE/I_ProductRetail               as _ProductRetail               on $projection.Product = _ProductRetail.Product //added for VH "PSTAT Changes
  association [0..1] to E_Product                     as _ProdSalesExt                on $projection.Product = _ProdSalesExt.Product
//  association [0..1] to /SIMPLE/I_SalesDistStatusVH   as _SalesStatus                 on $projection.SalesStatus = _SalesStatus.ProductSalesStatus
//  association [0..*] to /SIMPLE/I_SalesDistStatusTxt  as _SalesStatusText             on $projection.SalesStatus = _SalesStatusText.ProductSalesStatus
  association [0..1] to /SIMPLE/I_Product                     as _PricingReferenceProduct     on $projection.PricingReferenceProduct = _PricingReferenceProduct.Product
  association [0..*] to /SIMPLE/I_ProductDescription          as _PricingReferenceProductText on $projection.PricingReferenceProduct = _PricingReferenceProductText.Product
  //  association [0..1] to I_LoadingGroup                as _LoadingGroup                on  $projection.LoadingGroup = _LoadingGroup.LoadingGroup
  //  association [0..*] to I_LoadingGroupText            as _LoadingGroupText            on  $projection.LoadingGroup = _LoadingGroupText.LoadingGroup
  association [0..1] to /SIMPLE/I_UnitOfMeasure               as _Weight                      on $projection.AllowedPackagingWeightQtyUnit = _Weight.UnitOfMeasure

  association [0..*] to /SIMPLE/I_UnitOfMeasureText           as _WeightText                  on $projection.AllowedPackagingWeightQtyUnit = _WeightText.UnitOfMeasure
  association [0..1] to /SIMPLE/I_UnitOfMeasure               as _Volume                      on $projection.AllowedPackagingVolumeQtyUnit = _Volume.UnitOfMeasure

  association [0..*] to /SIMPLE/I_UnitOfMeasureText           as _VolumeText                  on $projection.AllowedPackagingVolumeQtyUnit = _VolumeText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_TransportationGroup         as _TransportationGroup         on $projection.TransportationGroup = _TransportationGroup.TransportationGroup
//  association [0..*] to /SIMPLE/I_TransportationGroupT        as _TransportationGroupText     on $projection.TransportationGroup = _TransportationGroupText.TransportationGroup

{
  key mara.matnr                                      as Product,
      @ObjectModel.foreignKey.association: '_SalesStatus'
      @ObjectModel.text.association:'_SalesStatusText'
      mara.mstav                                      as SalesStatus,
//      _SalesStatus,
//      _SalesStatusText,
      mara.mstdv                                      as SalesStatusValidityDate,
      mara.taklv                                      as TaxClassification,
      @ObjectModel.foreignKey.association: '_TransportationGroup'
      @ObjectModel.text.association:'_TransportationGroupText'
      mara.tragr                                      as TransportationGroup,
//      _TransportationGroup,
//      _TransportationGroupText,
      //Retail Fields
      @Semantics.quantity.unitOfMeasure: 'AllowedPackagingWeightQtyUnit'
      mara.ergew                                      as AllowedPackagingWeightQty,
      @ObjectModel.foreignKey.association: '_Weight'
      @ObjectModel.text.association:'_WeightText'
      @Semantics.unitOfMeasure:true
      mara.ergei                                      as AllowedPackagingWeightQtyUnit,
      _Weight,
      _WeightText,
      @Semantics.quantity.unitOfMeasure: 'AllowedPackagingVolumeQtyUnit'
      mara.ervol                                      as AllowedPackagingVolumeQty,
      @ObjectModel.foreignKey.association: '_Volume'
      @ObjectModel.text.association:'_VolumeText'
      @Semantics.unitOfMeasure:true
      mara.ervoe                                      as AllowedPackagingVolumeQtyUnit,
      _Volume,
      _VolumeText,
      @ObjectModel.foreignKey.association: '_PricingReferenceProduct'
      @ObjectModel.text.association:'_PricingReferenceProductText'
      mara.pmata                                      as PricingReferenceProduct,
      _PricingReferenceProduct,
      _PricingReferenceProductText,
      mara.sprof                                      as VariantsPricingProfile,
      mara.allow_pmat_igno                            as IsVariantPriceAllowed,
      //      maw1.wvrkm                                      as SalesUnit, //Copy Value for MARC  "PSTAT Move to I_ProductWD
      //      @ObjectModel.foreignKey.association: '_LoadingGroup'
      //      @ObjectModel.text.association:'_LoadingGroupText'
      _ProductRetail.LoadingGroup                     as LoadingGroup, //Copy Value for MARC
      _ProductRetail._LoadingGroup,
      _ProductRetail._LoadingGroupText,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0

      //new fields


      mara.gewto                                      as ExcessWeightTolerance,     //Excess Weight Tolerance for Handling unit
      mara.volto                                      as ExcessVolumeTolerance,     //Excess Volume Tolerance of the Handling Unit,
      mara.vhart                                      as PackagingMaterialType,     //Packaging Material Type
      mara.kzgvh                                      as IsClosedPackagingMaterial, //Packaging Material is Closed Packaging
      mara.fuelg                                      as VolumeMaximumLevel,        //Maximum level (by volume)
      mara.begru                                      as AuthorizationGroup,
      mara.mfrgr                                      as MaterialFreightGroup,
      // New fields for unified api
      mara.stfak                                      as StackingFactor,

      _ProductRetail

}
