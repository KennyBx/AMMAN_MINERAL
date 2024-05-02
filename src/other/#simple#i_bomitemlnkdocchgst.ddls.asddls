@AbapCatalog.sqlViewName: '/SIMPLE/IBIDCST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Header Document Assigment'
@ObjectModel.updateEnabled: true
@ObjectModel.createEnabled: true
//@Search.searchable: true
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_BOMItemLnkDocChgSt
  as select from /SIMPLE/I_DocInfoRcdObjectLink     as valid_docs
    inner join /SIMPLE/TF_DocInfRcdObjectLink(clnt : $session.client)  as doc_link on valid_docs.LinkedSAPObjectKey = doc_link.LinkedSAPObjectKey
    inner join /SIMPLE/I_BOMItemHChangeState as bom_item on doc_link.GUID = bom_item.BillOfMaterialItemUUID
{
  key valid_docs.DocumentInfoRecordDocType,
  key valid_docs.DocumentInfoRecordDocNumber,
  key valid_docs.DocumentInfoRecordDocVersion,
  key valid_docs.DocumentInfoRecordDocPart,
  key valid_docs.LinkedSAPObject,
  key doc_link.LinkedSAPObjectKey,
  key valid_docs.DocObjectLinkCounter,
  
  bom_item.BillOfMaterial,
  bom_item.BillOfMaterialCategory,
  bom_item.BillOfMaterialVariant,
  bom_item.BillOfMaterialItemNodeNumber,
  bom_item.BOMItemInternalChangeCount,
  bom_item.InheritedNodeNumberForBOMItem,
  bom_item._Mast.Material,
  // Begin insert by Doris Dang - 20233011
  bom_item._Eqst.Equipment, 
  bom_item._Tpst.FunctionalLocation, 
  // End insert by Doris Dang - 20233011  
  bom_item._Mast.Plant,
  bom_item.BillOfMaterialVariantUsage,
  bom_item.EngineeringChangeDocument,
  bom_item.BillOfMaterialItemUUID,

  valid_docs.CreationDateTime,
  valid_docs.CreatedByUser,
  valid_docs.ChangedDateTime,
  valid_docs.LastChangedByUser,
  valid_docs.DocInfoRecdLinkStatus,
  valid_docs.DocInfoRecdObjectLinkStatus,
  valid_docs.ObjectTypeDatabaseTable,
  valid_docs.DocInfoRecdAdditionalObjectKey,
  valid_docs.DocLinkDirectionIsActive,
  valid_docs.IsDefaultDocument,
  valid_docs.DocInfoRecdIsMarkedForDeletion,
  valid_docs.DocInfoRecdLongTextUUID,
  valid_docs.IsDocInfoRecdCreatedFromCAD,
  valid_docs.DocInfoRecdConfignMgmtFixed,
  
  _CreatedUser,
  _ChangedUser,
  _Text,
  _DocumentInfoRecordDesc  
  
} where doc_link.LinkedSAPObject = 'STPO_DOC'
