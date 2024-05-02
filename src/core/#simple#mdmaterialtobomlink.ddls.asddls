@AbapCatalog.sqlViewName: '/SIMPLE/MDMABOLK'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material to BOM Link'
define view /SIMPLE/MDMATERIALTOBOMLINK
  as select distinct from mast                     as mast
    inner join            stzu                     as STZU on stzu.stlnr = mast.stlnr
    left outer join       /SIMPLE/P_BomHeaderDeter as stko on  stko.BillOfMaterialCategory     = stzu.stlty
                                                           and stko.BillOfMaterial             = mast.stlnr
                                                           and stko.BillOfMaterialVariant      = mast.stlal
                                                           and stko.BillOfMaterialVariantUsage = mast.stlan
{
  key   mast.matnr                                            as material,
  key   mast.werks                                            as plant,
  key   mast.stlan                                            as billOfMaterialVariantUsage,
  key   cast( mast.stlnr   as /simple/stnum preserving type ) as billOfMaterial,
  key   mast.stlal                                            as billOfMaterialVariant,
  key   case
    when stko.HeaderValidityEndDate < '19700101' or stko.HeaderValidityEndDate is null then '19700101'
    else stko.HeaderValidityEndDate
               end                                            as headerValidityEndDate, 
        stzu.stlty                                            as billOfMaterialCategory,
        mast.losvn                                            as materialFromLotZise,
        mast.losbs                                            as materialToLotSize,
        stko.BillOfMaterialStatus                             as billOfMaterialStatus,
        stko.BOMIsArchivedForDeletion                         as bomIsArchivedForDeletion,
        stko.BOMAlternativeText                               as bomAlternativeText,
        stko.BOMHeaderQuantityInBaseUnit                      as bomHeaderQuantityInBaseUnit,
        stko.BOMHeaderBaseUnit                                as bomHeaderBaseUnit,
        stko.HeaderValidityStartDate                          as headerValidityStartDate

}
