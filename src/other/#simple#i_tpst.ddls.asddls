@AbapCatalog.sqlViewName: '/SIMPLE/ITPST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'Link Between Functional Location and BOM'
define view /SIMPLE/I_Tpst
  as select from tpst
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
      werks                                   as Plant,
      stlan                                   as BillOfMaterialVariantUsage,
      cast ('T' as stlty preserving type)     as BillOfMaterialCategory,
      tplnr                                   as FunctionalLocation

} 
  
 