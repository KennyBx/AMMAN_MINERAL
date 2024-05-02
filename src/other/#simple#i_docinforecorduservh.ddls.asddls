@AbapCatalog.sqlViewName: '/SIMPLE/ICDIRUVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document Info Record User Value Help'
@VDM.viewType: #BASIC
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'ResponsiblePersonName'
@Analytics: { dataCategory: #DIMENSION }
@Metadata.allowExtensions: true
// @ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
// @ObjectModel.dataCategory: #VALUE_HELP
@Metadata.ignorePropagatedAnnotations: true
@VDM.lifecycle: {
  contract: {
    type:#PUBLIC_LOCAL_API
  }
}

//--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
@AccessControl.privilegedAssociations: ['_DocTypeText']
// ]--GENERATED

define view /SIMPLE/I_DocInfoRecordUserVH
  as select from    P_DocumentInfoRecord as document

    left outer join usr21                as RespUser    on document.ResponsiblePersonName = RespUser.bname

    left outer join usr21                as ChangedUser on document.LastChangedByUser = ChangedUser.bname
    
    inner join adrp                      as UserDetail  on UserDetail.persnumber  = RespUser.persnumber

  --Get Document Type Association

//  //--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
//  association [0..*] to /SIMPLE/I_DocInfoRcrdDocTypeT   as _DocTypeText on  $projection.DocumentInfoRecordDocType = _DocTypeText.DocumentInfoRecordDocType
//  // ]--GENERATED
//  association [1..1] to /SIMPLE/I_DocInfoRcrdDocType    as _DocType     on  $projection.DocumentInfoRecordDocType = _DocType.DocumentInfoRecordDocType
  
  --Get Document Number Association
//  association [0..1] to /SIMPLE/I_DocInfoRecordDocNum   as _DocNumber  on  $projection.DocumentInfoRecordDocType   = _DocNumber.DocumentInfoRecordDocType
//                                                                      and $projection.DocumentInfoRecordDocNumber = _DocNumber.DocumentInfoRecordDocNumber

//  --Get Document Version Association
//  association [1..1] to /SIMPLE/I_DocInfoRecordDocVer as _DocVersion  on  $projection.DocumentInfoRecordDocType    = _DocVersion.DocumentInfoRecordDocType
//                                                                       and $projection.DocumentInfoRecordDocNumber  = _DocVersion.DocumentInfoRecordDocNumber
//                                                                       and $projection.DocumentInfoRecordDocVersion = _DocVersion.DocumentInfoRecordDocVersion

//  --Get Document Part Association
//  association [1..1] to /SIMPLE/I_DocInfoRecordDocPrt     as _DocPart     on  $projection.DocumentInfoRecordDocType    = _DocPart.DocumentInfoRecordDocType
//                                                                       and $projection.DocumentInfoRecordDocPart    = _DocPart.DocumentInfoRecordDocPart
//                                                                       and $projection.DocumentInfoRecordDocNumber  = _DocPart.DocumentInfoRecordDocNumber
//                                                                       and $projection.DocumentInfoRecordDocVersion = _DocPart.DocumentInfoRecordDocVersion

{     
      
      //--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_DocInfoRecdDocTypeStdVH',
                     element: 'DocumentInfoRecordDocType' }
        }]       
      // @ObjectModel.text.association: '_DocTypeText'
      // @ObjectModel.text.control: #('ASSOCIATED_TEXT_UI_HIDDEN') 
      // ]--GENERATED
      // @ObjectModel.foreignKey.association: '_DocType'
      @EndUserText.label:'Document Type'
  key document.DocumentInfoRecordDocType            as  DocumentInfoRecordDocType,
     //  @Consumption.valueHelpDefinition: [
    //    { entity:  { name:    'I_DocInfoRecdDocNmbrStdVH',
     //                element: 'DocumentInfoRecordDocNumber' }
     //   }]       
     
      
   // @ObjectModel.foreignKey.association: '_DocNumber'      
      @EndUserText.label:'Document Number'
  key document.DocumentInfoRecordDocNumber          as  DocumentInfoRecordDocNumber,
            
      //--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_DocInfoRecdDocVersStdVH',
                     element: 'DocumentInfoRecordDocVersion' },
          additionalBinding: [{ localElement: 'DocumentInfoRecordDocType',
                                element: 'DocumentInfoRecordDocType' },
                              { localElement: 'DocumentInfoRecordDocNumber',
                                element: 'DocumentInfoRecordDocNumber' }]
        }]
      // ]--GENERATED
      // @ObjectModel.foreignKey.association: '_DocVersion'
      @EndUserText.label:'Document Version'
  key document.DocumentInfoRecordDocVersion         as  DocumentInfoRecordDocVersion,
      
      //--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_DocInfoRecdDocPrtStdVH',
                     element: 'DocumentInfoRecordDocPart' },
          additionalBinding: [{ localElement: 'DocumentInfoRecordDocType',
                                element: 'DocumentInfoRecordDocType' },
                              { localElement: 'DocumentInfoRecordDocNumber',
                                element: 'DocumentInfoRecordDocNumber' },
                              { localElement: 'DocumentInfoRecordDocVersion',
                                element: 'DocumentInfoRecordDocVersion' }]
        }]
      // ]--GENERATED
      // @ObjectModel.foreignKey.association: '_DocPart'
      @EndUserText.label:'Document Part'
  key document.DocumentInfoRecordDocPart            as  DocumentInfoRecordDocPart,
    
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label:'Created By'
      @Semantics.user.createdBy: true
    key  document.ResponsiblePersonName                as  ResponsiblePersonName,

      @UI.hidden: true
      UserDetail.name_first as FirstName,
      
      @UI.hidden: true
      UserDetail.name_last  as LastName,
            
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label:'Created By User Name'
      RespUser.techdesc                             as  ResponsiblePersonFullName,
            
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label:'Last Changed By'
      @Semantics.user.lastChangedBy: true
      document.LastChangedByUser                    as  LastChangedByUser,

      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label:'Last Changed By User Name'
      ChangedUser.techdesc                          as  LastChangedByUserFullName,
      
      @UI.hidden: true
      RespUser.persnumber as PersonNumber

      //Associations
//      _DocType,
//      _DocNumber,
//      _DocVersion
//      _DocPart           
      //--[ GENERATED:012:E6ExH29r7kY4mpuAYoLAbW
//      @Consumption.hidden: true
//      _DocTypeText
      // ]--GENERATED

}
