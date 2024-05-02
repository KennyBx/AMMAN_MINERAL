@AbapCatalog.sqlViewName: '/SIMPLE/IMBLINK'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Link between Material and BOM'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_MaterialBOMLink
  as select from mast
{

  key stlnr                               as BillOfMaterial,
  key stlal                               as BillOfMaterialVariant,
  key matnr                               as Material,
  key werks                               as Plant,
  key stlan                               as BillOfMaterialVariantUsage,
      cast ('M' as stlty preserving type) as BillOfMaterialCategory,
      losvn                               as MatFromLotSizeQuantity,
      losbs                               as MaterialToLotSizeQuantity,
      cslty                               as IsConfiguredMaterial,
      material_bom_key                    as MaterialBOMObjectID,
      annam                               as CreatedByUser,
      aenam                               as LastChangedByUser,
      andat                               as RecordCreationDate,
      aedat                               as LastChangeDate
}
