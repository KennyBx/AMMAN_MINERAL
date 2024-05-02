@AbapCatalog.sqlViewName: '/SIMPLE/IDOPRTIK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@VDM.viewType: #BASIC
// @ObjectModel.representativeKey: 'ProductionResourceInternalID'
// @ObjectModel.semanticKey: ['DocumentType', 'DocumentInfoRecord', 'DocumentVersion', 'DocumentPart']
@Analytics.dataCategory: #DIMENSION
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document PRT by internal key'
//@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions:true

define view /SIMPLE/I_DocPRTByInternalKey
  as select from /SIMPLE/I_PRTMasterData as PRT
    inner join   crvd_a on  crvd_a.objty = PRT.ProductionResourceType
                        and crvd_a.objid = PRT.ProductionResourceInternalID
    inner join   draw   on  draw.dokar = crvd_a.dokar
                        and draw.doknr = crvd_a.doknr
                        and draw.dokvr = crvd_a.dokvr
                        and draw.doktl = crvd_a.doktl
  -- (obsolete: I_DocInfoRecdDocumentType, .DocumentType)
//  association [1..1] to /SIMPLE/I_DocInfoRcrdDocType    as _DocumentType          on  $projection.DocumentType = _DocumentType.DocumentInfoRecordDocType
  -- (obsolete: I_DocInfoRecdNumber, .DocumentType, .DocumentInfoRecord)
//  association [1..1] to /SIMPLE/I_DocInfoRecordDocNum  as _DocumentNumber        on  $projection.DocumentType       = _DocumentNumber.DocumentInfoRecordDocType
//                                                                                 and $projection.DocumentInfoRecord = _DocumentNumber.DocumentInfoRecordDocNumber
//  -- (obsolete: I_DocInfoRecdDocumentVersion, .DocumentType, .DocumentInfoRecord, .DocumentVersion)
//  association [1..1] to /SIMPLE/I_DocInfoRecordDocVer as _DocumentVersion       on  $projection.DocumentType       = _DocumentVersion.DocumentInfoRecordDocType
//                                                                                 and $projection.DocumentInfoRecord = _DocumentVersion.DocumentInfoRecordDocNumber
//                                                                                 and $projection.DocumentVersion    = _DocumentVersion.DocumentInfoRecordDocVersion
//   (obsolete: I_DocInfoRecd, .DocumentType, .DocumentInfoRecord, .DocumentVersion, .DocumentPart)
  association [1..1] to I_DocumentInfoRecord           as _DocumentInfoRecord    on  $projection.DocumentType       = _DocumentInfoRecord.DocumentInfoRecordDocType
                                                                                 and $projection.DocumentInfoRecord = _DocumentInfoRecord.DocumentInfoRecordDocNumber
                                                                                 and $projection.DocumentVersion    = _DocumentInfoRecord.DocumentInfoRecordDocVersion
                                                                                 and $projection.DocumentPart       = _DocumentInfoRecord.DocumentInfoRecordDocPart

  association [1..1] to I_DocumentProdnRsceTool        as _DocumentProdnRsceTool on  $projection.DocumentType       = _DocumentProdnRsceTool.DocumentType
                                                                                 and $projection.DocumentInfoRecord = _DocumentProdnRsceTool.DocumentInfoRecord
                                                                                 and $projection.DocumentVersion    = _DocumentProdnRsceTool.DocumentVersion
                                                                                 and $projection.DocumentPart       = _DocumentProdnRsceTool.DocumentPart

{
      // @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key PRT.ProductionResourceType,
  key PRT.ProductionResourceInternalID,
      // @ObjectModel.foreignKey.association: '_ProdnRsceToolCategory'
      PRT.ProdnRsceToolCategory,
//      // @ObjectModel.foreignKey.association: '_DocumentType'
      crvd_a.dokar as DocumentType,
      // @ObjectModel.foreignKey.association: '_DocumentNumber'
      crvd_a.doknr as DocumentInfoRecord,
      // @ObjectModel.foreignKey.association: '_DocumentVersion'
      crvd_a.dokvr as DocumentVersion,
      // @ObjectModel.foreignKey.association: '_DocumentInfoRecord'
      crvd_a.doktl as DocumentPart,

      draw.begru   as AuthorizationGroup,
      draw.dokst   as InternalDocumentStatus,

      // **** The following fields cannot be maintained in CV01N ****
      // **** Therefore they are always empty                    ****
      //      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      //      PRT.ProductionResourceToolGroup1,
      //      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      //      PRT.ProductionResourceToolGroup2,
      //      PRT.ProductionResourceUsage,
      //      ProdnRsceToolControlProfile,
      //      EngineeringChangeOrder,
      //      ProdnRsceToolStandardTextCode,
      //      ProdnRsceToolTotQtyCalcFormula,
      //      ProdnRsceToolUsageQtyCalcFmla,
      //      StartDateOffsetReferenceCode,
      //      EndDateOffsetReferenceCode,
      //
      //      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
      //      @DefaultAggregation: #SUM
      //      StartDateOffsetDuration,
      //      @Semantics.unitOfMeasure: true
      //      StartDateOffsetDurationUnit,
      //      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
      //      @DefaultAggregation: #SUM
      //      EndDateOffsetDuration,
      //      @Semantics.unitOfMeasure: true
      //      EndDateOffsetDurationUnit,
      // **** End of fields that cannot be maintained in CV01N ****

      // Admin
      @Semantics.systemDate.createdAt: true
      CreationDate,
      @Semantics.user.createdBy: true
      PRT.CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      LastChangeDate,
      @Semantics.user.lastChangedBy: true
      PRT.LastChangedByUser,

      _ProductionResourceType,

      //      _ProdnRsceToolGroup1,
      //      _ProdnRsceToolGroup2,
      //      _ProductionResourceUsage,
      //      _ProdnRsceToolControlProfile,
      //      _ProdnRsceToolStandardText,
      //      _ProdnRsceToolTotQtyCalcFmla,
      //      _ProdnRsceToolUsageQtyCalcFmla,
      //      _StartDateOffsetReferenceCode,
      //      _EndDateOffsetReferenceCode,
      //      _StartDateOffsetDurationUnit,
      //      _EndDateOffsetDurationUnit,

//      _DocumentType,
//      _DocumentNumber,
//      _DocumentVersion,
//      _DocumentInfoRecord,

      _DocumentProdnRsceTool,

      _CreatedByUser,
      _LastChangedByUser

}

where
  PRT.ProdnRsceToolCategory = 'D' // Document
