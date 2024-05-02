@AbapCatalog.sqlViewName: '/SIMPLE/IEQST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'Equipment to BOM Link'
define view /SIMPLE/I_Eqst
  as select from eqst
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
      werks                                   as Plant,
      stlan                                   as BillOfMaterialVariantUsage,
      cast ('E' as stlty preserving type)     as BillOfMaterialCategory,
      equnr                                   as Equipment

} 
  
 