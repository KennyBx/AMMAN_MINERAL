@AbapCatalog.sqlViewName: '/SIMPLE/IMCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Merchandise Category Hierarchy'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_MCHierarchy
  //  as select from /SIMPLE/I_MCHAssignment as ClassificationClass
  as select from /SIMPLE/I_ClfnClass as ClassificationClass
//  association [0..1] to /SIMPLE/I_ClfnClassStatus    as _ClassStatus       on  $projection.ClassStatus = _ClassStatus.ClassStatus
//                                                                           and $projection.ClassType   = _ClassStatus.ClassType
//  association [0..1] to /SIMPLE/I_ClfnClassGroup     as _ClassGroup        on  $projection.ClassGroup = _ClassGroup.ClassGroup
//  association [0..1] to /SIMPLE/I_ClfnClassTypeBasic as _ClassType         on  $projection.ClassType = _ClassType.ClassType

  association [0..1] to /SIMPLE/I_User               as _CreatedByUser     on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to /SIMPLE/I_User               as _LastChangedByUser on  $projection.LastChangedByUser = _LastChangedByUser.UserID
{
  key ClassInternalID,
      ClassType,
      Class,
      ClassStatus,
      ClassGroup,
      ClassSearchAuthGrp,
      ClassClassfctnAuthGrp,
      ClassMaintAuthGrp,
      CreatedByUser,
      CreationDate,
      LastChangedByUser,
      LastChangeDate,
      ValidityStartDate,
      ValidityEndDate,
      SameClassfctnReaction,
      ClfnOrganizationalArea,
      DocumentInfoRecordDocNumber,
      DocumentInfoRecordDocType,
      DocumentInfoRecordDocPart,
      DocumentInfoRecordDocVersion,
      //AlwaysDisplayDocumentInd,
      ClassStandardOrgName,
      ClassStandardNumber,
      ClassStandardStartDate,
      ClassStandardVersionStartDate,
      ClassStandardVersion,
      ClassStandardCharcTable,
      ClassBaseUnit,
      ClassIsUsableInBOM,
      ClassIsLocal,
      ClassLastChangedDateTime,
      MMSClassType,
      MMSView,
      _CreatedByUser,
      _LastChangedByUser
//      _ClassStatus,
//      _ClassGroup,
//      _ClassType
}
where
      ClassType    = '026' // Retail class
  and MMSClassType = '0' // Merchandise Category Hierarchy Level
