@AbapCatalog.sqlViewName: '/SIMPLE/IMEBLINK'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Equipment to BOM Link'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_MATERIALEQUIPBOMLINK
  as select from eqst
{

  key equnr                               as EquipmentNumber,
  key werks                               as Plant,
  key stlan                               as BillOfMaterialVariantUsage,
  key stlnr                               as BillOfMaterial,
  key cast ('E' as stlty preserving type) as BillOfMaterialCategory,
  key stlal                               as BillOfMaterialVariant,
      andat                               as RecordCreationDate,
      aedat                               as LastChangeDate,
      annam                               as CreatedByUser,
      aenam                               as LastChangedByUser
}
