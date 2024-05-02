@AbapCatalog.sqlViewName: '/SIMPLE/IMFLLINK'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Link Between Functional Location and BOM'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_MATERIALFLOCBOMLINK
  as select from    tpst
    left outer join iflos on tpst.tplnr = iflos.tplnr
{

  key tpst.tplnr                          as FunctionalLocation,
  key werks                               as Plant,
  key stlan                               as BillOfMaterialVariantUsage,
  key stlnr                               as BillOfMaterial,
  key cast ('T' as stlty preserving type) as BillOfMaterialCategory,
  key stlal                               as BillOfMaterialVariant,
      andat                               as RecordCreationDate,
      aedat                               as LastChangeDate,
      annam                               as CreatedByUser,
      aenam                               as LastChangedByUser,
      strno                               as FunctionalLocationText
}
