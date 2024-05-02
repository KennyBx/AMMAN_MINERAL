@AbapCatalog.sqlViewName: '/SIMPLE/ISOBLINK'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'Sales Order BOM Link'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_SalesOrderBOMLink as select from kdst
{
  key stlnr                                   as BillOfMaterial,
  key stlal                                   as BillOfMaterialVariant,
  key matnr                                   as Material,
  key werks                                   as Plant,
  key stlan                                   as BillOfMaterialVariantUsage,
  key vbeln                                   as SalesOrder,
  key vbpos                                   as SalesOrderItem,
  cast ('K' as stlty preserving type)     as BillOfMaterialCategory
      
} 
