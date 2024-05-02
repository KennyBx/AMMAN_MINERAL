@AbapCatalog.sqlViewName: '/SIMPLE/IBOMICHG'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'BOM Item Changes'
define view /SIMPLE/I_BomItemChanges
  as select distinct from stas                      as ItemHistory
    inner join            /SIMPLE/I_MaterialBOMLink as mast        on  ItemHistory.stlal = mast.BillOfMaterialVariant
                                                                   and ItemHistory.stlnr = mast.BillOfMaterial
    inner join            stpo                      as ItemChanges on  ItemChanges.stlnr = ItemHistory.stlnr
                                                                   and ItemChanges.stlkn = ItemHistory.stlkn
                                                                   and ItemChanges.stlty = ItemHistory.stlty
    inner join            I_ChangeMaster    as aenr        on ItemHistory.aennr = aenr.ChangeNumber
{
  key cast( ItemChanges.stlnr  as /simple/stnum preserving type )       as BillOfMaterial,
  key ItemChanges.stlty     as BillOfMaterialCategory,
  key ItemHistory.stlal     as BillOfMaterialVariant,
  key ItemHistory.aennr     as EngineeringChangeDocument,
  key ItemHistory.bom_versn as BillOfMaterialVersion,
  key mast.Material,
  key mast.Plant,
  key mast.BillOfMaterialVariantUsage,
      aenr.ChangeNumberStatus,
      aenr.ChangeNumberValidFromDate,
      aenr.ChangeNumberCreatedByUser,
      aenr.ChangeNumberCreationDate
}
where
      ItemChanges.stlty = 'M'
  and ItemHistory.stlty = 'M'

union all select distinct from stpo_draft_v2          as ItemDraftChanges
  inner join                   I_ChangeMaster as aenr               on ItemDraftChanges.engineeringchangedocument = aenr.ChangeNumber
  inner join                   stko_draft_v2          as HeaderDraftChanges on ItemDraftChanges.parentdraftuuid = HeaderDraftChanges.draftuuid
{
  key ItemDraftChanges.billofmaterial               as BillOfMaterial,
  key ItemDraftChanges.billofmaterialcategory       as BillOfMaterialCategory,
  key ItemDraftChanges.billofmaterialvariantforedit as BillOfMaterialVariant,
  key ItemDraftChanges.engineeringchangedocument    as EngineeringChangeDocument,
  key ItemDraftChanges.billofmaterialversionforedit as BillOfMaterialVersion,
  key HeaderDraftChanges.materialforedit            as Material,
  key HeaderDraftChanges.plantforedit               as Plant,
  key HeaderDraftChanges.billofmaterialvariantusage as BillOfMaterialVariantUsage,
      aenr.ChangeNumberStatus,
      aenr.ChangeNumberValidFromDate,
      aenr.ChangeNumberCreatedByUser,
      aenr.ChangeNumberCreationDate
}

where
     HeaderDraftChanges.material <> ''
  or HeaderDraftChanges.material is not null
