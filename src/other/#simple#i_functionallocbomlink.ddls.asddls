@AbapCatalog.sqlViewName: '/SIMPLE/FLBLINK'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET]
@EndUserText.label: 'Link Between Functional Location and BOM'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_FunctionalLocBOMLink
  as select from tpst
{
  key tplnr                                   as FunctionalLocation,
  key werks                                   as Plant,
  key stlan                                   as BillOfMaterialVariantUsage,
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
  cast ('T' as stlty preserving type)         as BillOfMaterialCategory

}
