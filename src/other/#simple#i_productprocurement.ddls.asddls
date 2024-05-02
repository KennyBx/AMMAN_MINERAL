@AbapCatalog.sqlViewName: '/SIMPLE/IPPROC'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product: Draft node for material proc'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_Productprocurement
  as select from mara
  //    left outer join maw1 on mara.matnr = maw1.matnr
  association [0..1] to /SIMPLE/I_ProductRetail           as _ProductRetail              on $projection.Product = _ProductRetail.Product //added for VH "PSTAT Changes
  association [0..1] to E_Product                         as _ProdProcExt                on $projection.Product = _ProdProcExt.Product
  association [0..1] to /SIMPLE/I_UnitOfMeasure           as _PurchaseOrderQuantityUnit  on $projection.PurchaseOrderQuantityUnit = _PurchaseOrderQuantityUnit.UnitOfMeasure
  association [0..*] to /SIMPLE/I_UnitOfMeasureText       as _PurchaseOrderUnitText      on $projection.PurchaseOrderQuantityUnit = _PurchaseOrderUnitText.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_SrcOfSupplyCategory     as _SourceOfSupplyCategory     on $projection.SourceOfSupplyCategory = _SourceOfSupplyCategory.SourceOfSupplyCategory
//  association [0..*] to /SIMPLE/I_SrcOfSupplyCategoryT    as _SourceOfSupplyCategoryText on $projection.SourceOfSupplyCategory = _SourceOfSupplyCategoryText.SourceOfSupplyCategory
  // The association is present in the I_ProductRetail and is directly added to I_ProductProcurementWD
  //    association [0..1] to I_PurchasingGroup   as _PurchasingGroup           on $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup

{
  key mara.matnr                                                          as  Product,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association:'_PurchaseOrderQuantityUnit'
      @ObjectModel.text.association: '_PurchaseOrderUnitText'
      mara.bstme                                                          as  PurchaseOrderQuantityUnit,
      _PurchaseOrderUnitText,
      _PurchaseOrderQuantityUnit,
      mara.vabme                                                          as  VarblPurOrdUnitStatus,
      mara.ekwsl                                                          as  PurchasingAcknProfile,
      //      mara.mfrnr  as ManufacturerNumber,  Moved to I_ProductWD
      mara.bwvor                                                          as  ProcurementRule, //pstat changes

      //        Retail Fields
      @ObjectModel.foreignKey.association:'_SourceOfSupplyCategory'
      @ObjectModel.text.association: '_SourceOfSupplyCategoryText'
      mara.bwscl                                                          as  SourceOfSupplyCategory, // Ref Handling fields  for MARC
//      _SourceOfSupplyCategory,
//      _SourceOfSupplyCategoryText,
      //********************************************************************************//
      // The association is present in the I_ProductRetail and is directly added to I_ProductProcurementWD
      //            @ObjectModel.foreignKey.association:'_PurchasingGroup'
      _ProductRetail.PurchasingGroup                                      as  PurchasingGroup, // ref. handling for MARC

      _ProductRetail._PurchasingGroup,
      //********************************************************************************//
      cast( 'X' as sdraft_is_active preserving type )                     as  IsActiveEntity, // to enbale extensibility in Draft 2.0
      mara.begru                                                          as  AuthorizationGroup,

      _ProductRetail //PSTAT Changes



}
