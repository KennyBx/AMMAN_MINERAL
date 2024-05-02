@AbapCatalog.sqlViewName: '/SIMPLE/IPRST'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'Project - BOM link'
define view /SIMPLE/I_Prst
  as select from prst
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
      matnr                                   as Material,
      werks                                   as Plant,
      stlan                                   as BillOfMaterialVariantUsage,
      cast ('P' as stlty preserving type)     as BillOfMaterialCategory,
      pspnr                                   as WBSElementInternalID
} 
  
 