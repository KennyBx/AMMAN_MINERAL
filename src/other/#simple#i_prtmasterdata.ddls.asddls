@AbapCatalog.sqlViewName: '/SIMPLE/IPRTMADA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #M, dataClass: #MASTER}
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Production Resource/Tool Master Data'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK"]  } */
define view /SIMPLE/I_PRTMasterData
  as select from crfh

  association [1..1] to /SIMPLE/I_ProductionRsceType   as _ProductionResourceType        on $projection.ProductionResourceType = _ProductionResourceType.ProductionResourceType
  association [1..1] to /SIMPLE/I_ProdRsceToolCategory as _ProdnRsceToolCategory         on $projection.ProdnRsceToolCategory = _ProdnRsceToolCategory.ProdnRsceToolCategory
  association [1..1] to /SIMPLE/I_ProdnRsceToolGroup   as _ProdnRsceToolGroup1           on $projection.ProductionResourceToolGroup1 = _ProdnRsceToolGroup1.ProductionResourceToolGroup
  association [1..1] to /SIMPLE/I_ProdnRsceToolGroup   as _ProdnRsceToolGroup2           on $projection.ProductionResourceToolGroup2 = _ProdnRsceToolGroup2.ProductionResourceToolGroup
  association [1..1] to /SIMPLE/I_ProdnResourceUsage   as _ProductionResourceUsage       on $projection.ProductionResourceUsage = _ProductionResourceUsage.ProductionResourceUsage
  association [0..1] to /SIMPLE/I_PRTControlProfile    as _ProdnRsceToolControlProfile   on $projection.ProdnRsceToolControlProfile = _ProdnRsceToolControlProfile.ProdnRsceToolControlProfile
  association [1..1] to /SIMPLE/I_PRTStandardText      as _ProdnRsceToolStandardText     on $projection.ProdnRsceToolStandardTextCode = _ProdnRsceToolStandardText.ProdnRsceToolStandardTextCode
  association [0..1] to I_ChangeMaster                 as _ChangeMaster                  on $projection.ChangeNumber = _ChangeMaster.ChangeNumber

  association [1..1] to /SIMPLE/I_PRTQtyCalcFormula    as _ProdnRsceToolTotQtyCalcFmla   on $projection.ProdnRsceToolTotQtyCalcFormula = _ProdnRsceToolTotQtyCalcFmla.ProdnRsceToolQtyCalcFormula
  association [1..1] to /SIMPLE/I_PRTQtyCalcFormula    as _ProdnRsceToolUsageQtyCalcFmla on $projection.ProdnRsceToolUsageQtyCalcFmla = _ProdnRsceToolUsageQtyCalcFmla.ProdnRsceToolQtyCalcFormula

  association [1..1] to /SIMPLE/I_OpDateOffsetRefCode  as _StartDateOffsetReferenceCode  on $projection.StartDateOffsetReferenceCode = _StartDateOffsetReferenceCode.OperationDateOffsetRefCode
  association [1..1] to /SIMPLE/I_OpDateOffsetRefCode  as _EndDateOffsetReferenceCode    on $projection.EndDateOffsetReferenceCode = _EndDateOffsetReferenceCode.OperationDateOffsetRefCode

  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _StartDateOffsetDurationUnit   on $projection.StartDateOffsetDurationUnit = _StartDateOffsetDurationUnit.UnitOfMeasure
  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _EndDateOffsetDurationUnit     on $projection.EndDateOffsetDurationUnit = _EndDateOffsetDurationUnit.UnitOfMeasure

  association [1..1] to /SIMPLE/I_User                 as _CreatedByUser                 on $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to /SIMPLE/I_User                 as _LastChangedByUser             on $projection.LastChangedByUser = _LastChangedByUser.UserID

{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key cast(crfh.objty as productionresourcetype preserving type)        as ProductionResourceType,
      // Representative Key
  key cast(crfh.objid as pph_fhmid preserving type)                     as ProductionResourceInternalID,

      // Assignments
      @ObjectModel.foreignKey.association: '_ProdnRsceToolCategory'
      crfh.fhmar                                                        as ProdnRsceToolCategory,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolGroup1'
      crfh.fgru1                                                        as ProductionResourceToolGroup1,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolGroup2'
      crfh.fgru2                                                        as ProductionResourceToolGroup2,
      @ObjectModel.foreignKey.association: '_ProductionResourceUsage'
      crfh.planv                                                        as ProductionResourceUsage,
      // Technical field, used for Miscellaneous Production Resource Tool only !
      crfh.brgru                                                        as MiscPRTAuthorizationGroup,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolControlProfile'
      crfh.steuf                                                        as ProdnRsceToolControlProfile,
      @ObjectModel.foreignKey.association: '_ChangeMaster'
      cast(crfh.aennr as changenumber preserving type)                  as ChangeNumber,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolStandardText'
      crfh.ktsch                                                        as ProdnRsceToolStandardTextCode,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolTotQtyCalcFmla'
      crfh.mgform                                                       as ProdnRsceToolTotQtyCalcFormula,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolUsageQtyCalcFmla'
      crfh.ewform                                                       as ProdnRsceToolUsageQtyCalcFmla,

      // Administrative Data
      @Semantics.systemDate.createdAt: true
      crfh.andat                                                        as CreationDate,
      @Semantics.user.createdBy: true
      cast(crfh.annam as vdm_createdbyuserid preserving type)           as CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      crfh.aedat                                                        as LastChangeDate,
      @Semantics.user.lastChangedBy: true
      crfh.aenam                                                        as LastChangedByUser,

      // Offset
      @ObjectModel.foreignKey.association: '_StartDateOffsetReferenceCode'
      cast(crfh.bzoffb as startdateoffsetreferencecode preserving type) as StartDateOffsetReferenceCode,
      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      cast(crfh.offstb as startdateoffsetduration preserving type)      as StartDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      crfh.ehoffb                                                       as StartDateOffsetDurationUnit,

      @ObjectModel.foreignKey.association: '_EndDateOffsetReferenceCode'
      cast(crfh.bzoffe as enddateoffsetreferencecode preserving type)   as EndDateOffsetReferenceCode,
      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      cast(crfh.offste as enddateoffsetduration preserving type)        as EndDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      crfh.ehoffe                                                       as EndDateOffsetDurationUnit,

      // Reference Indicators
      cast(crfh.offste_ref as vdm_oekzr preserving type)                as EndDateOffsetDurnIsReferenced,
      cast(crfh.offstb_ref as vdm_obkzr preserving type)                as StartDateOffstDurnIsReferenced,
      cast(crfh.bzoffe_ref as vdm_bekzr preserving type)                as EndDteOffstRefCodeIsReferenced,
      cast(crfh.bzoffb_ref as vdm_bbkzr preserving type)                as StartDateOffsetRefCodeIsRefcd,
      cast(crfh.mgform_ref as vdm_mfkzr preserving type)                as PRTTotQtyCalcFmlaIsReferenced,
      cast(crfh.ewform_ref as vdm_efkzr preserving type)                as PRTUsgeQtyCalcFmlaIsReferenced,
      cast(crfh.steuf_ref as vdm_stkzr preserving type)                 as PRTControlProfileIsReferenced,
      cast(crfh.ktsch_ref as vdm_ktkzr preserving type)                 as PRTStdTextCodeIsReferenced,

      //PRT can be Registered at Production Execution
      crfh.registrable                                                  as ShopFloorRtgPRTIsRegistrable,

      // Associations
      _ProductionResourceType,
      _ProdnRsceToolCategory,
      _ProdnRsceToolGroup1,
      _ProdnRsceToolGroup2,
      _ProductionResourceUsage,
      _ProdnRsceToolControlProfile,
      _ProdnRsceToolStandardText,
      _ProdnRsceToolTotQtyCalcFmla,
      _ProdnRsceToolUsageQtyCalcFmla,
      _StartDateOffsetReferenceCode,
      _EndDateOffsetReferenceCode,
      _StartDateOffsetDurationUnit,
      _EndDateOffsetDurationUnit,
      _CreatedByUser,
      _LastChangedByUser,
      _ChangeMaster
}
where
      crfh.objty = 'FH' // Production Resource Tool
  and crfh.zaehl = '00000000'
  and crfh.loekz = ' '  // not deleted
