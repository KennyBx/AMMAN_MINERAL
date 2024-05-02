// Product Work scheduling (active)
@AbapCatalog.sqlViewName: '/SIMPLE/IPWSCH'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product WorkScheduling core entity'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_PrdWorkScheduling
  as select from nsdm_e_marc as WorkScheduling 


  association [1..1] to /SIMPLE/I_Product      as _Product               on  $projection.Product = _Product.Product
  association [0..1] to E_Productplant as _ProdWorkSchedulingExt on  $projection.Product = _ProdWorkSchedulingExt.Product
                                                                 and $projection.Plant   = _ProdWorkSchedulingExt.Plant

    association [0..1] to I_UnitOfMeasure         as _GoodsIssueUnit               on  $projection.GoodsIssueUnit = _GoodsIssueUnit.UnitOfMeasure    //PSTAT Revert : back to productplant
    association [0..*] to I_UnitOfMeasureText     as _UnitOfMeasureText            on  $projection.GoodsIssueUnit = _UnitOfMeasureText.UnitOfMeasure  //PSTAT Revert : back to productplant
    association [0..1] to I_ProductStatus         as _ProductStatus                on  $projection.ProfileCode = _ProductStatus.Status  //PSTAT Revert : back to productplant
    association [0..*] to I_ProductStatusText     as _ProductStatusText            on  $projection.ProfileCode = _ProductStatusText.Status
    association [0..1] to I_FiscalYearVariant     as _FiscalYearVariant            on  $projection.FiscalYearVariant = _FiscalYearVariant.FiscalYearVariant  //PSTAT Revert
    association [0..*] to I_FiscalYearVariantText as _FiscalYearVariantDescription on  $projection.FiscalYearVariant = _FiscalYearVariantDescription.FiscalYearVariant
    association [0..1] to I_Product               as _ConfigurableProduct          on  $projection.ConfigurableProduct = _ConfigurableProduct.Product  //PSTAT Revert
    association [0..*] to I_ProductDescription    as _ConfigurableProductName      on  $projection.ConfigurableProduct = _ConfigurableProductName.Product  //PSTAT Revert
{
  key    WorkScheduling.matnr                                         as Product,
  key    WorkScheduling.werks                                         as Plant,
         WorkScheduling.basmg                                         as MaterialBaseQuantity,
         WorkScheduling.ueetk                                         as UnlimitedOverDelivIsAllowed,
         WorkScheduling.ueeto                                         as OverDelivToleranceLimit,
         WorkScheduling.uneto                                         as UnderDelivToleranceLimit,

                  @Semantics.unitOfMeasure: true                            //PSTAT Revert : back to productplant
                  @ObjectModel.foreignKey.association: '_GoodsIssueUnit'
                  @ObjectModel.text.association: '_UnitOfMeasureText'
                  WorkScheduling.ausme                                        as GoodsIssueUnit,

                  WorkScheduling.eprio                                        as StockDeterminationGroup,   //PSTAT Revert : back to productplant
                  WorkScheduling.fprfm                                        as DistrCntrDistributionProfile,   //PSTAT Revert : back to productplant
                  WorkScheduling.indus                                        as ProductCFOPCategory,  //PSTAT Revert
                  WorkScheduling.lgpro                                         as ProductionInvtryManagedLoc, //PSTAT Revert
                  WorkScheduling.megru                                        as ProductUnitGroup,  //PSTAT Revert (Delete)


                  @ObjectModel : {
                     foreignKey.association: '_ProductStatus',
                     text.association: '_ProductStatusText'
                  }
                  WorkScheduling.mmsta                                        as ProfileCode,
                  WorkScheduling.mmstd                                        as ProfileValidityStartDate,

                  @ObjectModel:{   //PSTAT Revert
                     foreignKey.association: '_FiscalYearVariant',
                     text.association: '_FiscalYearVariantDescription'
                  }
                  WorkScheduling.periv                                        as FiscalYearVariant,
                  WorkScheduling.perkz                                        as PeriodType,  //PSTAT Revert
                  WorkScheduling.prctr                                        as ProfitCenter,  //PSTAT Revert
                  WorkScheduling.sernp                                        as SerialNumberProfile,  //PSTAT Revert
                  @ObjectModel:{   //PSTAT Revert
                     foreignKey.association: '_ConfigurableProduct',
                     text.association: '_ConfigurableProductName'
                  }
                  WorkScheduling.stdpd                                        as ConfigurableProduct,
                  WorkScheduling.xchpf                                        as IsBatchManagementRequired,  //PSTAT Revert
                  WorkScheduling.xmcng                                        as IsNegativeStockAllowed,  //PSTAT Revert
         cast( 'X' as sdraft_is_active preserving type )              as IsActiveEntity, // to enbale extensibility in Draft 2.0
                  _GoodsIssueUnit,   //PSTAT Revert : back to productplant
                  _UnitOfMeasureText, //"PSTAT Revert : back to productplant
                  _ProductStatus,  //"PSTAT Revert : back to productplant
                  _ProductStatusText,  //"PSTAT revert : back to productplant
                  _FiscalYearVariant,  //"PSTAT Revert
                  _FiscalYearVariantDescription,  //"PSTAT Revert
                  _ConfigurableProduct,
                  _ConfigurableProductName,


         // New fields from MDG model, as part of unified API development
         WorkScheduling.kzech                                         as ProdnOrderIsBatchRequired,
         WorkScheduling.kzpro                                         as ProdIsWithdrawnFrmProdnBin,
         WorkScheduling.matgr                                         as TransitionMatrixProductsGroup,
         WorkScheduling.ocmpf                                         as OrderChangeManagementProfile,
         WorkScheduling.rgekz                                         as MatlCompIsMarkedForBackflush,
         WorkScheduling.ruezt                                         as SetupAndTeardownTime,
         WorkScheduling.sfcpf                                         as ProductionSchedulingProfile,
         WorkScheduling.tranz                                         as TransitionTime,
         WorkScheduling.bearz                                         as ProductProcessingTime,
         WorkScheduling.fevor                                         as ProductionSupervisor,
         WorkScheduling.frtme                                         as ProductProductionQuantityUnit,
         WorkScheduling.verkz                                         as HasProductionVersion, //calculated field  pstat A

         _Product

}
