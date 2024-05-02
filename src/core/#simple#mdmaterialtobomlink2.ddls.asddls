@AbapCatalog.sqlViewName: '/SIMPLE/MDMABOL2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material to BOM Link2'
define view /SIMPLE/MDMATERIALTOBOMLINK2
  as select from /SIMPLE/MDMATERIALTOBOMLINK
{
  key material                    as material,
  key plant                       as plant,
  key billOfMaterialVariantUsage  as billOfMaterialVariantUsage,
  key billOfMaterial              as billOfMaterial,
  key billOfMaterialVariant       as billOfMaterialVariant,
  key headerValidityEndDate       as headerValidityEndDate,
      billOfMaterialCategory      as billOfMaterialCategory,
      materialFromLotZise         as materialFromLotZise,
      materialToLotSize           as materialToLotSize,
      billOfMaterialStatus        as billOfMaterialStatus,
      bomIsArchivedForDeletion    as bomIsArchivedForDeletion,
      bomAlternativeText          as bomAlternativeText,
      bomHeaderQuantityInBaseUnit as bomHeaderQuantityInBaseUnit,
      bomHeaderBaseUnit           as bomHeaderBaseUnit,
      headerValidityStartDate     as headerValidityStartDate
}
