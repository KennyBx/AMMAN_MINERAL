@AbapCatalog.sqlViewName: '/SIMPLE/ISTST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'Standard BOM Link'
define view /SIMPLE/I_STST
  as select from stst
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
      werks                                   as Plant,
      stlan                                   as BillOfMaterialVariantUsage,
      cast ('S' as stlty preserving type)     as BillOfMaterialCategory,
      stobj                                   as StandardObject

} 
