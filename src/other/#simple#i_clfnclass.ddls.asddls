@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLFNCL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.privilegedAssociations: ['_CreatedByUser', '_LastChangedByUser']
@EndUserText.label: 'Classification Class'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ClassInternalID'
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClass
  as select from klah as Class
  association [0..*] to /SIMPLE/I_ClfnClassDesc      as _ClassDescription    on  $projection.ClassInternalID = _ClassDescription.ClassInternalID
  association [0..*] to /SIMPLE/I_ClfnClassKeyword   as _ClassKeyword        on  $projection.ClassInternalID = _ClassKeyword.ClassInternalID
//  association [0..1] to /SIMPLE/I_ClfnClassStatus    as _ClassStatus         on  $projection.ClassStatus = _ClassStatus.ClassStatus
//                                                                             and $projection.ClassType   = _ClassStatus.ClassType
//  association [0..1] to /SIMPLE/I_ClfnClassGroup     as _ClassGroup          on  $projection.ClassGroup = _ClassGroup.ClassGroup
//  association [0..1] to /SIMPLE/I_ClfnClassTypeBasic as _ClassType           on  $projection.ClassType = _ClassType.ClassType
  association [0..1] to /SIMPLE/I_User               as _CreatedByUser       on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to /SIMPLE/I_User               as _LastChangedByUser   on  $projection.LastChangedByUser = _LastChangedByUser.UserID
  association [0..*] to /SIMPLE/I_ClfnClassCharc     as _ClassCharacteristic on  $projection.ClassInternalID = _ClassCharacteristic.ClassInternalID
{
  key Class.clint                                                   as ClassInternalID,
      Class.klart                                                   as ClassType,
      Class.class                                                   as Class,
      Class.statu                                                   as ClassStatus,
      Class.klagr                                                   as ClassGroup,
      Class.bgrse                                                   as ClassSearchAuthGrp,
      Class.bgrkl                                                   as ClassClassfctnAuthGrp,
      Class.bgrkp                                                   as ClassMaintAuthGrp,
      Class.aname                                                   as CreatedByUser,
      Class.adatu                                                   as CreationDate,
      Class.vname                                                   as LastChangedByUser,
      Class.vdatu                                                   as LastChangeDate,
      @Semantics.businessDate.from: true
      Class.vondt                                                   as ValidityStartDate,
      @Semantics.businessDate.to: true
      Class.bisdt                                                   as ValidityEndDate,
      //      Class.anzou,
      cast( Class.praus as char1 preserving type )                  as SameClassfctnReaction,
      cast( Class.sicht as clfnorganizationalarea preserving type ) as ClfnOrganizationalArea,
      Class.doknr                                                   as DocumentInfoRecordDocNumber,
      Class.dokar                                                   as DocumentInfoRecordDocType,
      Class.doktl                                                   as DocumentInfoRecordDocPart,
      Class.dokvr                                                   as DocumentInfoRecordDocVersion,
      // Class.kdokaz                                                  as AlwaysDisplayDocumentInd,
      //      Class.dinkz           as ClassDINCode,
      Class.nnorm                                                   as ClassStandardOrgName,
      Class.normn                                                   as ClassStandardNumber,
      Class.ausgd                                                   as ClassStandardStartDate,
      Class.versd                                                   as ClassStandardVersionStartDate,
      Class.versi                                                   as ClassStandardVersion,
      Class.leist                                                   as ClassStandardCharcTable,
      //      Class.verwe,
      //      Class.spart,
      Class.meins                                                   as ClassBaseUnit,
      Class.vwstl                                                   as ClassIsUsableInBOM,
      Class.locla                                                   as ClassIsLocal,
      Class.lastchangeddatetime                                     as ClassLastChangedDateTime,

      Class.wwskz                                                   as MMSClassType,
      Class.wwssi                                                   as MMSView,

      _ClassDescription,
      _ClassKeyword,
//      _ClassStatus,
//      _ClassGroup,
//      _ClassType,
      _CreatedByUser,
      _LastChangedByUser,
      _ClassCharacteristic

}
