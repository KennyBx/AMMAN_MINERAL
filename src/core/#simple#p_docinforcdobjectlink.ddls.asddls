@AbapCatalog.sqlViewName: '/SIMPLE/PDIRO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@VDM.viewType: #BASIC
@VDM.private: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/P_DocInfoRcdObjectLink
  as select from    drad             as obj_links
    left outer join drad_last_change as LastChange on  obj_links.dokar = LastChange.dokar
                                                   and obj_links.doknr = LastChange.doknr
                                                   and obj_links.dokvr = LastChange.dokvr
                                                   and obj_links.doktl = LastChange.doktl
                                                   and obj_links.dokob = LastChange.dokob
                                                   and obj_links.objky = LastChange.objky

{
      /*  Document Info Record key Details */
  key obj_links.dokar       as  DocumentInfoRecordDocType,
  key obj_links.doknr       as  DocumentInfoRecordDocNumber,
  key obj_links.dokvr       as  DocumentInfoRecordDocVersion,
  key obj_links.doktl       as  DocumentInfoRecordDocPart,

      /*  Object Type and Object Key Details */
  key obj_links.dokob       as  LinkedSAPObject,
  key obj_links.objky       as  LinkedSAPObjectKey,
  key obj_links.obzae       as  DocObjectLinkCounter,

     /* DIR Administrative Data */
      //@Semantics.businessDate.at: true
      //@Semantics.businessDate.createdAt: true
      //@Semantics.systemDateTime.createdAt: true
      LastChange.created_at as  CreationDateTime,

      @Semantics.user.createdBy: true
      LastChange.created_by as  CreatedByUser,

      //@Semantics.businessDate.at: true
      //@Semantics.businessDate.lastChangedAt: true
      //@Semantics.systemDateTime.lastChangedAt: true
      LastChange.changed_at as  ChangedDateTime,

      @Semantics.user.lastChangedBy: true
      LastChange.changed_by as  LastChangedByUser,
      
      obj_links.vrkstat     as  DocInfoRecdLinkStatus,
      obj_links.vrkstat1    as  DocInfoRecdObjectLinkStatus,
      obj_links.vobj        as  ObjectTypeDatabaseTable,
      obj_links.vkey        as  DocInfoRecdAdditionalObjectKey,
      obj_links.vdir        as  DocLinkDirectionIsActive,
      obj_links.viewflag    as  IsDefaultDocument,
      obj_links.delflag     as  DocInfoRecdIsMarkedForDeletion,
      obj_links.longtext_id as  DocInfoRecdLongTextUUID,
      obj_links.cad_pos     as  IsDocInfoRecdCreatedFromCAD,
      obj_links.cm_fixed    as  DocInfoRecdConfignMgmtFixed

 


}
