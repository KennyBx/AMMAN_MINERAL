@AbapCatalog.sqlViewName: '/SIMPLE/IDBLINK'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@VDM.viewType: #BASIC
@EndUserText.label: 'DOST interface view'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_DocumentBOMLink
  as select from dost
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
  key dokar                                   as DocumentType,
  key doknr                                   as DocNumber,
  key dokvr                                   as DocumentVersion,
  key doktl                                   as DocumentPart,
  cast ('D' as stlty preserving type)     as BillOfMaterialCategory
}
