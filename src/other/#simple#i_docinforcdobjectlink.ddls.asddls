@AbapCatalog.sqlViewName: '/SIMPLE/IDIRO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document Info Record Object Link'
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL}


define view /SIMPLE/I_DocInfoRcdObjectLink
  as select from /SIMPLE/P_DocInfoRcdObjectLink as ObjLink

  --Get Linked object description
  association [0..*] to /SIMPLE/I_DocInfoRcdObjLinkT  as _Text                   on  $projection.LinkedSAPObject = _Text.LinkedSAPObject

  --Get DocumentInfoRecord created user full name
  association [1..1] to /SIMPLE/I_DocInfoRecordUserVH as _CreatedUser            on  $projection.DocumentInfoRecordDocType    = _CreatedUser.DocumentInfoRecordDocType
                                                                                 and $projection.DocumentInfoRecordDocPart    = _CreatedUser.DocumentInfoRecordDocPart
                                                                                 and $projection.DocumentInfoRecordDocNumber  = _CreatedUser.DocumentInfoRecordDocNumber
                                                                                 and $projection.DocumentInfoRecordDocVersion = _CreatedUser.DocumentInfoRecordDocVersion
                                                                                 and $projection.CreatedByUser                = _CreatedUser.ResponsiblePersonName
  --Get DocumentInfoRecord changed user full name
  association [1..1] to /SIMPLE/I_DocInfoRecordUserVH as _ChangedUser            on  $projection.DocumentInfoRecordDocType    = _ChangedUser.DocumentInfoRecordDocType
                                                                                 and $projection.DocumentInfoRecordDocPart    = _ChangedUser.DocumentInfoRecordDocPart
                                                                                 and $projection.DocumentInfoRecordDocNumber  = _ChangedUser.DocumentInfoRecordDocNumber
                                                                                 and $projection.DocumentInfoRecordDocVersion = _ChangedUser.DocumentInfoRecordDocVersion
                                                                                 and $projection.LastChangedByUser            = _ChangedUser.LastChangedByUser

  association [0..*] to /SIMPLE/I_DocInfoRecordDesc   as _DocumentInfoRecordDesc on  $projection.DocumentInfoRecordDocNumber = _DocumentInfoRecordDesc.DocumentInfoRecordDocNumber

  association [0..1] to /SIMPLE/I_DocInfoRecordDesc   as _DocumentDescClient     on  $projection.DocumentInfoRecordDocNumber  = _DocumentDescClient.DocumentInfoRecordDocNumber
                                                                                 and $projection.DocumentInfoRecordDocType    = _DocumentDescClient.DocumentInfoRecordDocType
                                                                                 and $projection.DocumentInfoRecordDocVersion = _DocumentDescClient.DocumentInfoRecordDocVersion
                                                                                 and $projection.DocumentInfoRecordDocPart    = _DocumentDescClient.DocumentInfoRecordDocPart
                                                                                 and _DocumentDescClient.Language             = $session.system_language
{
      /*  Document Info Record key Details */
  key ObjLink.DocumentInfoRecordDocType      as DocumentInfoRecordDocType,
  key ObjLink.DocumentInfoRecordDocNumber    as DocumentInfoRecordDocNumber,
  key ObjLink.DocumentInfoRecordDocVersion   as DocumentInfoRecordDocVersion,
  key ObjLink.DocumentInfoRecordDocPart      as DocumentInfoRecordDocPart,

      /*  Object Type and Object Key Details */
  key ObjLink.LinkedSAPObject                as LinkedSAPObject,
  key ObjLink.LinkedSAPObjectKey             as LinkedSAPObjectKey,
  key ObjLink.DocObjectLinkCounter           as DocObjectLinkCounter,

      /* DIR Administrative Data */
      //@Semantics.businessDate.at: true
      //@Semantics.businessDate.createdAt: true
      ObjLink.CreationDateTime               as CreationDateTime,

      //      @Consumption.valueHelpDefinition.association: '_CreatedUser'
      //      @Semantics.user.createdBy: true
      ObjLink.CreatedByUser                  as CreatedByUser,

      //@Semantics.businessDate.at: true
      //@Semantics.businessDate.lastChangedAt: true
      ObjLink.ChangedDateTime                as ChangedDateTime,

      //      @Consumption.valueHelpDefinition.association: '_ChangedUser'
      //      @Semantics.user.lastChangedBy: true
      ObjLink.LastChangedByUser              as LastChangedByUser,

      ObjLink.DocInfoRecdLinkStatus          as DocInfoRecdLinkStatus,
      ObjLink.DocInfoRecdObjectLinkStatus    as DocInfoRecdObjectLinkStatus,
      ObjLink.ObjectTypeDatabaseTable        as ObjectTypeDatabaseTable,
      ObjLink.DocInfoRecdAdditionalObjectKey as DocInfoRecdAdditionalObjectKey,
      ObjLink.DocLinkDirectionIsActive       as DocLinkDirectionIsActive,
      ObjLink.IsDefaultDocument              as IsDefaultDocument,
      ObjLink.DocInfoRecdIsMarkedForDeletion as DocInfoRecdIsMarkedForDeletion,
      ObjLink.DocInfoRecdLongTextUUID        as DocInfoRecdLongTextUUID,
      ObjLink.IsDocInfoRecdCreatedFromCAD    as IsDocInfoRecdCreatedFromCAD,
      ObjLink.DocInfoRecdConfignMgmtFixed    as DocInfoRecdConfignMgmtFixed,

      //Associations
      _CreatedUser,
      _ChangedUser,
      _Text,
      _DocumentInfoRecordDesc,
      _DocumentDescClient
}
