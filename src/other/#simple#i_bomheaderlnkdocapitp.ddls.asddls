@AbapCatalog.sqlViewName: '/SIMPLE/IBHLDAPI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BOM Header Document Assignment'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AbapCatalog.preserveKey: true

define view /SIMPLE/I_BOMHeaderLnkDocAPITP
  as select from /SIMPLE/I_BOMHeaderLnkDocChgSt as header_doc
  association to parent /SIMPLE/I_BillOfMatAPITP as bom on  bom.BillOfMaterial               = $projection.BillOfMaterial
                                                        and bom.BillOfMaterialCategory       = $projection.BillOfMaterialCategory
                                                        and bom.BillOfMaterialVariant        = $projection.BillOfMaterialVariant
                                                        and bom.BillOfMaterialVersion        = $projection.BillOfMaterialVersion
                                                        and bom.Material                     = $projection.Material
                                                        and bom.Plant                        = $projection.Plant
                                                        and bom.BillOfMaterialVariantUsage   = $projection.BillOfMaterialVariantUsage
                                                        and bom.BOMHeaderInternalChangeCount = $projection.BOMHeaderInternalChangeCount
{
  key header_doc.BillOfMaterial,
  key header_doc.BillOfMaterialCategory,
  key header_doc.BillOfMaterialVariant,
  key header_doc.BillOfMaterialVersion,
  key header_doc.Material,
  key header_doc.Plant,
  key header_doc.BillOfMaterialVariantUsage,
  key header_doc.BOMHeaderInternalChangeCount,
  key header_doc.DocumentInfoRecordDocType    as DocumentType,
  key header_doc.DocumentInfoRecordDocNumber  as DocNumber,
  key header_doc.DocumentInfoRecordDocVersion as DocumentVersion,
  key header_doc.DocumentInfoRecordDocPart    as DocumentPart,
  key header_doc.LinkedSAPObject,
  key header_doc.LinkedSAPObjectKey,
  key header_doc.DocObjectLinkCounter,
      header_doc.EngineeringChangeDocument,
      header_doc.EngineeringChangeDocument    as EngineeringChangeDocForEdit,
      header_doc.BillOfMaterialHeaderUUID,
      header_doc.DocumentDescription,
      header_doc.CreationDateTime,
      header_doc.CreatedByUser,
      header_doc.ChangedDateTime,
      header_doc.LastChangedByUser,
      header_doc.DocInfoRecdLinkStatus,
      header_doc.DocInfoRecdObjectLinkStatus,
      header_doc.ObjectTypeDatabaseTable,
      header_doc.DocInfoRecdAdditionalObjectKey,
      header_doc.DocLinkDirectionIsActive,
      header_doc.IsDefaultDocument,
      header_doc.DocInfoRecdIsMarkedForDeletion,
      header_doc.DocInfoRecdLongTextUUID,
      header_doc.IsDocInfoRecdCreatedFromCAD,
      header_doc.DocInfoRecdConfignMgmtFixed,
      bom
}
