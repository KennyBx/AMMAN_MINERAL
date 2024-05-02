@AbapCatalog.sqlViewName: '/SIMPLE/IBILDAPI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BOM Header Document Assignment'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AbapCatalog.preserveKey: true

define view /SIMPLE/I_BOMItemLnkDocAPITP
  as select from /SIMPLE/I_BOMItemLnkDocChgSt as item_doc
  association to parent /SIMPLE/I_BillOfMatItemAPITP as bom_item 
                                                        on  bom_item.BillOfMaterial               = $projection.BillOfMaterial
                                                        and bom_item.BillOfMaterialCategory       = $projection.BillOfMaterialCategory
                                                        and bom_item.BillOfMaterialVariant        = $projection.BillOfMaterialVariant
                                                        and bom_item.BillOfMaterialItemNodeNumber        = $projection.BillOfMaterialItemNodeNumber
                                                        and bom_item.BOMItemInternalChangeCount        = $projection.BOMItemInternalChangeCount
                                                        and bom_item.Material                     = $projection.Material
                                                        and bom_item.Plant                        = $projection.Plant
                                                        and bom_item.BillOfMaterialVariantUsage   = $projection.BillOfMaterialVariantUsage
{
  key item_doc.BillOfMaterial,
  key item_doc.BillOfMaterialCategory,
  key item_doc.BillOfMaterialVariant,
  key item_doc.BillOfMaterialItemNodeNumber,
  key item_doc.BOMItemInternalChangeCount,
  key item_doc.InheritedNodeNumberForBOMItem,
  key item_doc.Material,
  key item_doc.Plant,
  key item_doc.BillOfMaterialVariantUsage,

  key item_doc.DocumentInfoRecordDocType    as DocumentType,
  key item_doc.DocumentInfoRecordDocNumber  as DocNumber,
  key item_doc.DocumentInfoRecordDocVersion as DocumentVersion,
  key item_doc.DocumentInfoRecordDocPart    as DocumentPart,
  key item_doc.LinkedSAPObject,
  key item_doc.LinkedSAPObjectKey,
  key item_doc.DocObjectLinkCounter,
      item_doc.EngineeringChangeDocument,
      item_doc.EngineeringChangeDocument    as EngineeringChangeDocForEdit,
      item_doc.BillOfMaterialItemUUID,
      item_doc.CreationDateTime,
      item_doc.CreatedByUser,
      item_doc.ChangedDateTime,
      item_doc.LastChangedByUser,
      item_doc.DocInfoRecdLinkStatus,
      item_doc.DocInfoRecdObjectLinkStatus,
      item_doc.ObjectTypeDatabaseTable,
      item_doc.DocInfoRecdAdditionalObjectKey,
      item_doc.DocLinkDirectionIsActive,
      item_doc.IsDefaultDocument,
      item_doc.DocInfoRecdIsMarkedForDeletion,
      item_doc.DocInfoRecdLongTextUUID,
      item_doc.IsDocInfoRecdCreatedFromCAD,
      item_doc.DocInfoRecdConfignMgmtFixed,
      bom_item
}
