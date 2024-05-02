@AbapCatalog.sqlViewName: '/SIMPLE/IEBLINK'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@EndUserText.label: 'Equipment to BOM Link'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_EquipmentBOMLink
  as select from eqst
{
  
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
  key equnr                                   as Equipment,
  key werks                                   as Plant,
  key stlan                                   as BillOfMaterialVariantUsage,
      cast ('E' as stlty preserving type)     as BillOfMaterialCategory
      
} 
 