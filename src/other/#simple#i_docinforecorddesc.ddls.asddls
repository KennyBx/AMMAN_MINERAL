@AbapCatalog.sqlViewName:'/SIMPLE/IDIRD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
// @ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey:'DocumentInfoRecordDocType'
// @ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL }
@EndUserText.label: 'Document Info Record Description'
@Metadata.ignorePropagatedAnnotations: true
@VDM.lifecycle: {
  contract: {
    type:#PUBLIC_LOCAL_API
  }
}


define view /SIMPLE/I_DocInfoRecordDesc
  as select from drat as documentdesc

//  --Get Document Type Association
//  association [1..1] to /SIMPLE/I_DocInfoRcrdDocType    as _DocType    on  $projection.DocumentInfoRecordDocType = _DocType.DocumentInfoRecordDocType

  --Get Document Number Association
//  association [0..1] to /SIMPLE/I_DocInfoRecordDocNum  as _DocNumber  on  $projection.DocumentInfoRecordDocType   = _DocNumber.DocumentInfoRecordDocType
//                                                                      and $projection.DocumentInfoRecordDocNumber = _DocNumber.DocumentInfoRecordDocNumber
  --Get Document Part Association
//  association [0..1] to /SIMPLE/I_DocInfoRecordDocPrt     as _DocPart    on  $projection.DocumentInfoRecordDocType    = _DocPart.DocumentInfoRecordDocType
//                                                                      and $projection.DocumentInfoRecordDocPart    = _DocPart.DocumentInfoRecordDocPart
//                                                                      and $projection.DocumentInfoRecordDocNumber  = _DocPart.DocumentInfoRecordDocNumber
//                                                                      and $projection.DocumentInfoRecordDocVersion = _DocPart.DocumentInfoRecordDocVersion

//  --Get Document Version Association
//  association [0..1] to /SIMPLE/I_DocInfoRecordDocVer as _DocVersion on  $projection.DocumentInfoRecordDocType    = _DocVersion.DocumentInfoRecordDocType
//                                                                      and $projection.DocumentInfoRecordDocNumber  = _DocVersion.DocumentInfoRecordDocNumber
//                                                                      and $projection.DocumentInfoRecordDocVersion = _DocVersion.DocumentInfoRecordDocVersion

//  association [0..1] to /SIMPLE/I_Language                     as _Language   on  $projection.Language = _Language.Language

{
            // @ObjectModel.foreignKey.association: '_DocType'
  key       documentdesc.dokar    as DocumentInfoRecordDocType,

            // @ObjectModel.foreignKey.association: '_DocNumber'
  key       documentdesc.doknr    as DocumentInfoRecordDocNumber,

            // @ObjectModel.foreignKey.association: '_DocVersion'
  key       documentdesc.dokvr    as DocumentInfoRecordDocVersion,

            // @ObjectModel.foreignKey.association: '_DocPart'
  key       documentdesc.doktl    as DocumentInfoRecordDocPart,

            @Semantics.language: true
            // @ObjectModel.foreignKey.association: '_Language'
  key       documentdesc.langu    as Language,

            @Semantics.text: true
            @EndUserText.label:'Document Description'
            documentdesc.dktxt    as DocumentDescription,

            documentdesc.ltxin    as LongTextExists,

            // DMS: short texts in capital letters
            @EndUserText.label:'Document Short Description'
            documentdesc.dktxt_uc as DocInfoRecdShortText

            // Associations
            // @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
//            _Language,
            // @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
//            _DocType,
//            _DocVersion
//            _DocPart
//            _DocNumber
            
}
