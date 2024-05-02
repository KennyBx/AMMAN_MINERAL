@AbapCatalog.sqlViewName: '/SIMPLE/IMAST'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material to BOM Link'


define view /SIMPLE/I_Mast
  as select from mast
{
  key stlnr                                    as BillOfMaterial,
  key stlal                                    as BillOfMaterialVariant,
  key cast ('M' as stlty preserving type)      as BillOfMaterialCategory,
      matnr                                    as Material,
      werks                                    as Plant,
      stlan                                    as BillOfMaterialVariantUsage,
      losvn                                    as MatFromLotSizeQuantity,
      losbs                                    as MaterialToLotSizeQuantity,
      cslty                                    as IsConfiguredMaterial
} 
 