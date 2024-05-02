@AbapCatalog.sqlViewName: '/SIMPLE/IDOST'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@VDM.viewType: #BASIC
@EndUserText.label: 'Document to BOM Link'


define view /SIMPLE/I_Dost
  as select from dost
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
      cast ('D' as stlty preserving type)     as BillOfMaterialCategory,
      dokar                                   as DocumentType,
      doknr                                   as DocNumber,
      dokvr                                   as DocumentVersion,
      doktl                                   as DocumentPart
} 
 