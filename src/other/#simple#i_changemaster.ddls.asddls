@AbapCatalog.sqlViewName: '/SIMPLE/ECN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.privilegedAssociations: [
  '_LastChangedByUser'       ,
  '_CreatedByUser'           ,
  '_LogAccMObjectTypeActive' ,
  '_LogAccMObjSecureIDAssgmt',
  '_LogAccMObjectUserAuthzn' ]

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
//@ObjectModel.usageType.dataClass: #MASTER

@ObjectModel: {
   compositionRoot: true,
   semanticKey: ['ChangeNumber'],
   representativeKey: 'ChangeNumber'
  // modelCategory: #BUSINESS_OBJECT
}

@VDM.viewType: #BASIC
//@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API

@EndUserText.label: 'Engineering Change Number'
define view /SIMPLE/I_ChangeMaster
  as select from aenr
  association [0..1] to /SIMPLE/I_ECMStatus          as _ChangeNumberStatus on $projection.ChangeNumberStatus = _ChangeNumberStatus.ChangeNumberStatus
  //  association [0..1] to I_ChangeMasterFunction         as _ChangeNumberFunction         on  $projection.ChangeNumberFunction = _ChangeNumberFunction.ChangeNumberFunction
  //  association [0..1] to I_ChangeMasterReleaseKey       as _ChangeNumberReleaseKey       on  $projection.ChangeNumberReleaseKey = _ChangeNumberReleaseKey.ChangeNumberReleaseKey
  association [0..*] to /SIMPLE/I_ECMObjectType      as _ObjTypeAssignment  on $projection.ChangeNumber = _ObjTypeAssignment.ChangeNumber
  association [0..*] to /SIMPLE/I_ECMAlternativeDate as _AlternativeDate    on $projection.ChangeNumber = _AlternativeDate.ChangeNumber
  association [0..1] to /SIMPLE/I_ECMHierarchy       as _LeadingChangeNumber          on  $projection.ChangeNumber = _LeadingChangeNumber.PackageChangeNumber
  association [0..*] to /SIMPLE/I_ECMObjectMgmtRecord   as _ChangeMstrObjectMgmtRecord   on  $projection.ChangeNumber = _ChangeMstrObjectMgmtRecord.ChangeNumber
  //  association [0..*] to I_ChangeMstrObMgReDocInfoRecd  as _ChangeMstrObMgReDocInfoRecd  on  $projection.ChangeNumber = _ChangeMstrObMgReDocInfoRecd.ChangeNumber
  //  association [0..*] to I_ChangeMstrObMgReMaterial     as _ChangeMstrObMgReMaterial     on  $projection.ChangeNumber = _ChangeMstrObMgReMaterial.ChangeNumber
  //  association [0..*] to I_ChangeMstrObMgReMatlBOM      as _ChangeMstrObMgReMatlBOM      on  $projection.ChangeNumber = _ChangeMstrObMgReMatlBOM.ChangeNumber
  association [0..1] to /SIMPLE/I_User               as _CreatedByUser      on $projection.ChangeNumberCreatedByUser = _CreatedByUser.UserID
  association [0..1] to /SIMPLE/I_User               as _LastChangedByUser  on $projection.ChangeNumberLastChangedByUser = _LastChangedByUser.UserID
  //  association [0..*] to I_ClfnObjectClassForKeyDate    as _ClfnObjectClassForKeyDate    on  $projection.ChangeNumber                   = _ClfnObjectClassForKeyDate.ClfnObjectID
  //                                                                                        and _ClfnObjectClassForKeyDate.ClfnObjectTable = 'AENR'
  //  association [0..*] to I_ClfnObjectCharcValForKeyDate as _ClfnObjectCharcValForKeyDate on  $projection.ChangeNumber                      = _ClfnObjectCharcValForKeyDate.ClfnObjectID
  //                                                                                        and _ClfnObjectCharcValForKeyDate.ClfnObjectTable = 'AENR'
  //  association [0..*] to I_DocumentInfoRecordObjectLink as _DocumentInfoRecordObjectLink on  $projection.ChangeNumber                      = _DocumentInfoRecordObjectLink.LinkedSAPObjectKey
  //                                                                                        and _DocumentInfoRecordObjectLink.LinkedSAPObject = 'AENR'

  //  // Access Control Management integration - target views are not C1 released (kept for historical reason, not used in DCL anymore)
  //  association [0..1] to I_LogAccMObjectTypeActive      as _LogAccMObjectTypeActive      on  _LogAccMObjectTypeActive.LogAccMObjectType = 'PLM_ECN'
  //
  //  association [0..*] to I_LogAccMObjSecureIDAssgmt     as _LogAccMObjSecureIDAssgmt     on  $projection.ChangeNumber                    = _LogAccMObjSecureIDAssgmt.LogAccMObjectID
  //                                                                                        and _LogAccMObjSecureIDAssgmt.LogAccMObjectType = 'PLM_ECN'
  //  association [0..*] to I_LogAccMObjectUserAuthzn      as _LogAccMObjectUserAuthzn      on  $projection.ChangeNumber                              = _LogAccMObjectUserAuthzn.LogAccMObjectID
  //                                                                                        and _LogAccMObjectUserAuthzn.LogAccMObjectType            = 'PLM_ECN'
  //                                                                                        and _LogAccMObjectUserAuthzn.LogAccMUserAuthznObject      = 'PLM_ECN'
  //                                                                                        and _LogAccMObjectUserAuthzn.LogAccMReadActivityIsEnabled = 'X'
  //                                                                                        and _LogAccMObjectUserAuthzn.LogAccMUserAuthznField       = 'ACTVT'
  //                                                                                        and _LogAccMObjectUserAuthzn.LogAccMUserEntityID          = $session.user
  //                                                                                        and _LogAccMObjectUserAuthzn.UserID                       = $session.user //DT2869058
  //
  //  // Access Control Management integration - target views are ECN object specific projection views on ACM, C1 released, used in DCL
  //  association [0..1] to I_ChangeMasterLogAccMActive    as _ChangeMasterLogAccMActive    on  _ChangeMasterLogAccMActive.LogAccMObjectType = 'PLM_ECN'
  //  association [0..*] to I_ChgMstrLogAccMSecureIDAssgmt as _ChgMstrLogAccMSecureIDAssgmt on  _ChgMstrLogAccMSecureIDAssgmt.LogAccMObjectID = $projection.ChangeNumber
  //  association [0..*] to I_ChangeMstrLogAccMUserAuthzn  as _ChangeMstrLogAccMUserAuthzn  on  _ChangeMstrLogAccMUserAuthzn.LogAccMObjectID              = $projection.ChangeNumber
  //                                                                                        and _ChangeMstrLogAccMUserAuthzn.LogAccMUserAuthznField       = 'ACTVT'
  //                                                                                        and _ChangeMstrLogAccMUserAuthzn.LogAccMReadActivityIsEnabled = 'X'
  //                                                                                        and _ChangeMstrLogAccMUserAuthzn.UserID                       = $session.user
  //                                                                                        and _ChangeMstrLogAccMUserAuthzn.LogAccMUserEntityID          = $session.user
{
      @ObjectModel.text.element: 'ChangeNumberDescription'
  key aennr                                             as ChangeNumber,
      _LeadingChangeNumber.LeadingChangeNumber          as LeadingChangeNumber,
      @ObjectModel.foreignKey.association: '_ChangeNumberStatus'
      @Consumption.valueHelpDefinition: [
      { entity:  { name:    'I_ChangeMasterStatusStdVH',
                   element: 'ChangeNumberStatus' }
      }]
      //cast( aenst as /plmb/ecn_status preserving type ) as ChangeNumberStatus,
      cast( aenst as char2 ) as ChangeNumberStatus,

      cast( aenbe as /plmb/aenbe preserving type )      as AuthorizationGroup,

      @ObjectModel.foreignKey.association: '_ChangeNumberFunction'
      @Consumption.valueHelpDefinition: [
      { entity:  { name:    'I_ChangeMasterFunctionStdVH',
                   element: 'ChangeNumberFunction' }
      }]
      aefun                                             as ChangeNumberFunction,

      cast ( terel as boole_d )                         as IsTechnicallyReleased,

      @ObjectModel.foreignKey.association: '_ChangeNumberReleaseKey'
      @Consumption.valueHelpDefinition: [
      { entity:  { name:    'I_ChangeMasterReleaseKeyStdVH',
                   element: 'ChangeNumberReleaseKey' }
      }]
      cast( rlkey as /plmb/cc_rlkey preserving type )   as ChangeNumberReleaseKey,

      @Semantics.text:true
      aegru                                             as ReasonForChangeText,

      ccart                                             as ChangeNumberChangeType,
      uestr                                             as OverridingPossible,
      aerng                                             as ChangeNumberRank,
      erled                                             as IsBasicChanged,
      @Semantics.text:true
      aetxt                                             as ChangeNumberDescription,

      @Semantics.businessDate.from
      datuv                                             as ChangeNumberValidFromDate,

      cast(' ' as ltxss )                               as IsLongTextExisted,
      @Semantics.businessDate.createdAt
      cast ( andat as /plmb/cc_andat preserving type )  as ChangeNumberCreationDate,
      cast ( annam as /plmb/cc_annam preserving type )  as ChangeNumberCreatedByUser,
      @Semantics.businessDate.lastChangedAt
      cast ( aedat as /plmb/aedat preserving type )     as ChangeNumberLastChangedDate,
      cast ( aenam as /plmb/aenam preserving type )     as ChangeNumberLastChangedByUser,

      cast (fluse as /plmb/inuse preserving type)       as IsUsedForDataDefinition,

      cast (lvorm  as /plmb/loekz preserving type)      as ChangeNumberIsMrkdForDeletion,

      lastchangeddatetime                               as ChangeNumberLastChgdDateTime,

      _ChangeNumberStatus,
      //      _ChangeNumberFunction,
      //      _ChangeNumberReleaseKey,
      _ObjTypeAssignment,
      _AlternativeDate,
      _LeadingChangeNumber,
      _ChangeMstrObjectMgmtRecord,
      //      _ChangeMstrObMgReDocInfoRecd,
      //      _DocumentInfoRecordObjectLink,
      //      _ChangeMstrObMgReMaterial,
      //      _ChangeMstrObMgReMatlBOM,
      _CreatedByUser,
      _LastChangedByUser
      //      _ClfnObjectClassForKeyDate,
      //      _ClfnObjectCharcValForKeyDate

      //      // Access Control Management not C1 released, kept for history, not used in DCL anymore
      //      @Consumption.hidden:true
      //      _LogAccMObjectTypeActive,
      //      @Consumption.hidden:true
      //      _LogAccMObjectUserAuthzn,
      //      @Consumption.hidden:true
      //      _LogAccMObjSecureIDAssgmt,

      //      // Access Control Management C1 released, used in DCL
      //      @Consumption.hidden:true
      //      _ChangeMasterLogAccMActive,
      //      @Consumption.hidden:true
      //      _ChgMstrLogAccMSecureIDAssgmt,
      //      @Consumption.hidden:true
      //      _ChangeMstrLogAccMUserAuthzn
}
