@AbapCatalog.sqlViewName: '/SIMPLE/IWRKCCC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'CostCenterAllocation'
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #S, dataClass: #MASTER}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Cost Center'
@Analytics.dataExtraction.enabled: true

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_WorkCenterCostCenter
  as select from crco as crco

  association [1..1] to /SIMPLE/I_WorkCenter                  as _WorkCenter                 on  $projection.WorkCenterTypeCode   = _WorkCenter.WorkCenterTypeCode
                                                                                     and $projection.WorkCenterInternalID = _WorkCenter.WorkCenterInternalID
//  association [1..1] to /SIMPLE/I_WorkCenterType              as _WorkCenterTypeCode         on  $projection.WorkCenterTypeCode = _WorkCenterTypeCode.WorkCenterTypeCode
//  association [1..1] to /SIMPLE/I_WorkCenterCategory          as _WorkCenterCategory         on  $projection.workcentercategorycode = _WorkCenterCategory.WorkCenterCategoryCode
//  association [1..1] to /SIMPLE/I_Plant                       as _Plant                      on  $projection.plant = _Plant.Plant
//  association [0..1] to /SIMPLE/I_CalendarDate                as _StartDate                  on  $projection.ValidityStartDate = _StartDate.CalendarDate
//  association [1..1] to /SIMPLE/I_CalendarDate                as _EndDate                    on  $projection.ValidityEndDate = _EndDate.CalendarDate
//  association [0..1] to /SIMPLE/I_User                        as _LastChangedByUser          on  $projection.LastChangedByUser = _LastChangedByUser.UserID
//  association [1..1] to /SIMPLE/I_ControllingArea             as _ControllingArea            on  $projection.ControllingArea = _ControllingArea.ControllingArea
//  association [1..1] to /SIMPLE/I_CostCenter                  as _CostCenter                 on  $projection.ControllingArea = _CostCenter.ControllingArea
//                                                                                     and $projection.CostCenter      = _CostCenter.CostCenter
//                                                                                     and $projection.ValidityEndDate = _CostCenter.ValidityEndDate
//  association [0..1] to /SIMPLE/I_CostCenterAT      as _ActivityType               on  $projection.ControllingArea     = _ActivityType.ControllingArea
//                                                                                     and $projection.CostCtrActivityType = _ActivityType.CostCtrActivityType
//                                                                                     and $projection.ValidityEndDate     = _ActivityType.ValidityEndDate
//  association [0..1] to /SIMPLE/I_UnitOfMeasure               as _UnitOfMeasure              on  $projection.CostCtrActivityTypeQtyUnit = _UnitOfMeasure.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_BusinessProcss             as _BusinessProcess            on  $projection.ControllingArea = _BusinessProcess.ControllingArea
//                                                                                     and $projection.BusinessProcess = _BusinessProcess.BusinessProcess
//  association [0..1] to /SIMPLE/I_ActDescOriginType      as _ActivityDescOriginType     on  $projection.ActivityDescOriginType = _ActivityDescOriginType.ActivityDescOriginType
//  //  association [0..*] to /SIMPLE/I_ActAlternativeText     as _ActivityAlternativeText    on  $projection.CostCenterActivityAltvDescID = _ActivityAlternativeText.CostCenterActivityAltvDescID
  association [0..1] to /SIMPLE/I_ActAlternativeText   as _ActivityAlternativeText    on  $projection.CostCenterActivityAltvDescID = _ActivityAlternativeText.CostCenterActivityAltvDescID
                                                                                      and _ActivityAlternativeText.Language        = $session.system_language
  association [0..1] to /SIMPLE/I_ActAlternativeText   as _ActivityAlternativeTextEN  on  $projection.CostCenterActivityAltvDescID = _ActivityAlternativeTextEN.CostCenterActivityAltvDescID
                                                                                      and _ActivityAlternativeTextEN.Language      = 'E'
//  association [0..*] to /SIMPLE/I_CostCenterText              as _CostCenterText             on  $projection.CostCenter      = _CostCenterText.CostCenter
//                                                                                     and $projection.ControllingArea = _CostCenterText.ControllingArea
//                                                                                     and $projection.ValidityEndDate = _CostCenterText.ValidityEndDate
//  association [0..1] to /SIMPLE/I_PrdnRsceTQtyCalcForm as _CostCtrActivityTypeFormula on  $projection.CostCenterActivityTypeFormula = _CostCtrActivityTypeFormula.ProdnRsceToolQtyCalcFormula
{
//      // Key
//      @ObjectModel.foreignKey.association: '_WorkCenter'
  key crco.objid                                     as  WorkCenterInternalID,
//      @ObjectModel.foreignKey.association: '_WorkCenterTypeCode'
  key crco.objty                                     as  WorkCenterTypeCode,
  key cast(crco.lanum as pph_lanum preserving type)  as  CostCenterAllocation,
//      @ObjectModel.foreignKey.association: '_EndDate'
  key crco.endda                                     as  ValidityEndDate,
//      @ObjectModel.foreignKey.association: '_StartDate'
      crco.begda                                     as  ValidityStartDate,

      // Admin
      @Semantics.systemDate.lastChangedAt: true
      crco.aedat_kost                                as  LastChangeDate,
      @Semantics.user.lastChangedBy: true
      crco.aenam_kost                                as  LastChangedByUser,

      // Plant and Category for DCLS
//      @ObjectModel.foreignKey.association: '_Plant'
      _WorkCenter.Plant,
//      @ObjectModel.foreignKey.association: '_WorkCenterCategory'
      _WorkCenter.WorkCenterCategoryCode,

      //CO Data
//      @ObjectModel.foreignKey.association: '_ControllingArea'
      cast(crco.kokrs as fis_kokrs preserving type)  as  ControllingArea,
//      @ObjectModel.foreignKey.association: '_CostCenter'
      crco.kostl                                     as  CostCenter,
//      @ObjectModel.foreignKey.association: '_ActivityType'
      crco.lstar                                     as  CostCtrActivityType,
//      @Semantics.unitOfMeasure: true
      crco.leinh                                     as  CostCtrActivityTypeQtyUnit,
//      @ObjectModel.foreignKey.association: '_BusinessProcess'
      crco.prz                                       as  BusinessProcess,

      // Alternative description
//      @ObjectModel.foreignKey.association: '_ActivityDescOriginType'
      cast(crco.actxy as pph_actxy preserving type)  as  ActivityDescOriginType,
      cast(crco.actxk as pph_actxk preserving type)  as  CostCenterActivityAltvDescID,

//      @ObjectModel.foreignKey.association: '_CostCtrActivityTypeFormula'
      cast(crco.forml as ap_form_c1 preserving type) as  CostCenterActivityTypeFormula,

      crco.lstar_ref                                 as  CostCtrActyTypeIsReferenced,
      crco.bde                                       as  CostCtrActyTypeIncntvWageCode,
      crco.sakl                                      as  CostCtrActyTypeRecdTypeGrpCode,

      //Missing field
      //Change 24/05/2021
      case 
        when _ActivityAlternativeText.CostCenterActivityAltvDesc is not initial
             then _ActivityAlternativeText.CostCenterActivityAltvDesc
        else _ActivityAlternativeTextEN.CostCenterActivityAltvDesc
      end                                            as AlterActivityText


//      // Associations
//      _WorkCenter,
//      _WorkCenterTypeCode,
//      _WorkCenterCategory,
//      _Plant,
//      _EndDate,
//      _StartDate,
//      _LastChangedByUser,
//      _ControllingArea,
//      _CostCenter,
//      _CostCenterText,
//      _ActivityType,
//      _UnitOfMeasure,
//      _BusinessProcess,
//      _ActivityDescOriginType,
//      _ActivityAlternativeText,
//      _CostCtrActivityTypeFormula,
//      _ActivityAlternativeTextEN
}
where
  (
        crco.objty = 'A'
    and crco.laset = '    1'
  );
