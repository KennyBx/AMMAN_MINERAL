@AbapCatalog.sqlViewName: '/SIMPLE/IWORKCA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'CapacityCategoryAllocation'
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #S, dataClass: #MASTER}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Capacity'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_WorkCenterCapacity
  as select from crca as crca

  association [1..1] to /SIMPLE/I_Plant                   as _Plant                   on  $projection.Plant = _Plant.Plant
  association [1..1] to /SIMPLE/I_WorkCenter              as _WorkCenter              on  $projection.WorkCenterTypeCode   = _WorkCenter.WorkCenterTypeCode
                                                                              and $projection.WorkCenterInternalID = _WorkCenter.WorkCenterInternalID
//  association [0..1] to /SIMPLE/I_WCBySemanticKey as _WorkCenterBySemanticKey on  $projection.Plant      = _WorkCenterBySemanticKey.Plant
//                                                                              and $projection.WorkCenter = _WorkCenterBySemanticKey.WorkCenter
//  association [1..1] to /SIMPLE/I_WorkCenterType          as _WorkCenterTypeCode      on  $projection.WorkCenterTypeCode = _WorkCenterTypeCode.WorkCenterTypeCode
//  association [1..1] to /SIMPLE/I_WorkCenterCategory      as _WorkCenterCategory      on  $projection.WorkCenterCategoryCode = _WorkCenterCategory.WorkCenterCategoryCode
  association [1..1] to /SIMPLE/I_Capacity                as _Capacity                on  $projection.CapacityInternalID = _Capacity.CapacityInternalID
//  association [1..1] to /SIMPLE/I_CapacityCategory        as _CapacityCategory        on  $projection.CapacityCategoryCode = _CapacityCategory.CapacityCategoryCode
  association [0..1] to /SIMPLE/I_User                    as _LastChangedByUser       on  $projection.LastChangedByUser = _LastChangedByUser.UserID
  association [0..1] to /SIMPLE/I_UnitOfMeasure           as _CapacityQuantityUnit    on  $projection.CapacityQuantityUnit = _CapacityQuantityUnit.UnitOfMeasure
{
      // Key
      @ObjectModel.foreignKey.association: '_WorkCenter'
  key crca.objid                                        as WorkCenterInternalID,
//      @ObjectModel.foreignKey.association: '_WorkCenterTypeCode'
  key crca.objty                                        as WorkCenterTypeCode,
  key cast(crca.canum as pph_cr_capnum preserving type) as CapacityCategoryAllocation,

      // Admin
      @Semantics.systemDate.lastChangedAt: true
      crca.aedat_kapa                                   as LastChangeDate,
      @Semantics.user.lastChangedBy: true
      crca.aenam_kapa                                   as LastChangedByUser,

      // Assignments
      @ObjectModel.foreignKey.association: '_Plant'
      _WorkCenter.Plant                                 as Plant,
      @ObjectModel.foreignKey.association: '_WorkCenterBySemanticKey'
      _WorkCenter.WorkCenter                            as WorkCenter,
      @ObjectModel.foreignKey.association: '_WorkCenterCategory'
      _WorkCenter.WorkCenterCategoryCode                as WorkCenterCategoryCode,
      @ObjectModel.foreignKey.association: '_Capacity'
      crca.kapid                                        as CapacityInternalID,
//      @ObjectModel.foreignKey.association: '_CapacityCategory'
      _Capacity.CapacityCategoryCode                    as CapacityCategoryCode,
      _Capacity.Capacity                                as Capacity,

      // Formula IDs
      crca.fork1                                        as SetupCapRequirementFormula,
      crca.fork2                                        as ProcgCapRequirementFormula,
      crca.fork3                                        as TeardownCapRequirementFormula,
      crca.forkn                                        as OtherCapRequirementFormula,
      
      crca.vert1                                        as DistributionOfCapRequ,
      crca.vertn                                        as DistributionKeyForWkC,

      // Dates
      @Semantics.businessDate.from
      crca.begda                                        as ValidityStartDate,
      @Semantics.businessDate.to
      crca.endda                                        as ValidityEndDate,

      // UoM
      @Semantics.unitOfMeasure: true
      _Capacity.CapacityQuantityUnit                    as CapacityQuantityUnit,

      case when _WorkCenter.WorkCenterLastChangeDateTime is null then
      cast(dats_tims_to_tstmp(cast('20190101' as dats), cast('120000'as tims), 'UTC', $session.client, 'NULL') as cr_lastchange_datetime)
      else _WorkCenter.WorkCenterLastChangeDateTime end as WorkCenterLastChangeDateTime,

      //Missing field
      //24/05/2021
      crca.cap_backflush_pr as CtrlCapRedctnPR,
      crca.cap_backflush_su as CtrlCapRedctnSU,
      crca.cap_backflush_td as CtrlCapRedctnTD,
      //07/06/2021
      crca.carol            as WorkCenterCapacityRole,
      crca.istbed_kz        as CalculateActualCapRequirement,
      crca.vgwt1            as ActualCapReqSetup,
      crca.vgwt2            as ActualCapReqProcessing,
      crca.vgwt3            as ActualCapReqTeardown,
      crca.vgwtn            as ActualCapReqInHseProcessing,

      // Associations
      _Plant,
      _WorkCenter,
//      _WorkCenterBySemanticKey,
//      _WorkCenterTypeCode,
//      _WorkCenterCategory,
      _Capacity,
//      _CapacityCategory,
      _CapacityQuantityUnit,
      _LastChangedByUser
};
