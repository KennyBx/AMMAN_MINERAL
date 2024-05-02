// Interface view for Material BOM
@AbapCatalog.sqlViewName: '/SIMPLE/IMABOMAI'
@AbapCatalog.preserveKey:true
@EndUserText.label: 'Material bom main'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #CHECK
--@ObjectModel.writeEnabled: true


define view /SIMPLE/I_MaterialBOMMain
  as select from /SIMPLE/P_BOMPermanentDeter    as bom_permanent

    left outer join   /SIMPLE/I_MaterialBOMLink      as bom_main       on bom_main.BillOfMaterial = bom_permanent.BillOfMaterial
                                                                      and bom_main.BillOfMaterialCategory = bom_permanent.BillOfMaterialCategory
  // Begin insert by Doris Dang - 20233011
    left outer join   /SIMPLE/I_MATERIALEQUIPBOMLINK as equip_bom_main on equip_bom_main.BillOfMaterial = bom_permanent.BillOfMaterial
                                                                      and equip_bom_main.BillOfMaterialCategory = bom_permanent.BillOfMaterialCategory
    left outer join   /SIMPLE/I_MATERIALFLOCBOMLINK  as floc_bom_main  on floc_bom_main.BillOfMaterial = bom_permanent.BillOfMaterial
                                                                      and floc_bom_main.BillOfMaterialCategory = bom_permanent.BillOfMaterialCategory
  // End insert by Doris Dang - 20233011
       left outer join /SIMPLE/P_BOMHeaderValidDeter as _bom_valid                   on  bom_permanent.BillOfMaterialCategory = _bom_valid.BillOfMaterialCategory
                                                                                     and bom_permanent.BillOfMaterial         = _bom_valid.BillOfMaterial
                                                                                     and bom_permanent.HeaderValidityStartDate = _bom_valid.HeaderValidityStartDate //PESI-84 - Add by Doris Dang - 20243101
                                                                                     //and bom_permanent.BillOfMaterialVariant  = _bom_valid.BillOfMaterialVariant
                                                                                     
  association [0..1] to /SIMPLE/I_Material            as _Material                   on  $projection.Material = _Material.Material

  association [0..1] to /SIMPLE/I_BillOfMaterialUsage as _BillOfMaterialVariantUsage on  _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage = $projection.BillOfMaterialVariantUsage
                                                                                     and _BillOfMaterialVariantUsage.Language                   = $session.system_language

  association [0..1] to /SIMPLE/I_Plant               as _Plant                      on  $projection.Plant = _Plant.Plant

  association [0..1] to /SIMPLE/I_Product             as _Product                    on  $projection.Material = _Product.Product

  association [0..1] to /SIMPLE/I_Producttexts        as _ProductText                on  $projection.Material  = _ProductText.Product
  //Change 24/05/2021
                                                                                     and _ProductText.Language = $session.system_language


{
  key bom_permanent.BillOfMaterialCategory  as BillOfMaterialCategory,
  key bom_permanent.BillOfMaterial          as BillOfMaterial,
      //bom_main.BillOfMaterialVariant        as BillOfMaterialVariant,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.BillOfMaterialVariant
      when 'E' then equip_bom_main.BillOfMaterialVariant
      when 'T' then floc_bom_main.BillOfMaterialVariant 
      end as BillOfMaterialVariant,
      
      bom_main.Material                     as Material,
      // Begin insert by Doris Dang - 20233011
      equip_bom_main.EquipmentNumber        as EquipmentNumber,
      floc_bom_main.FunctionalLocation      as FunctionalLocation,
      // End insert by Doris Dang - 20233011
//      bom_main.Plant                        as Plant,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.Plant
      when 'E' then equip_bom_main.Plant
      when 'T' then floc_bom_main.Plant 
      end as Plant,
      
//      bom_main.BillOfMaterialVariantUsage   as BillOfMaterialVariantUsage,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.BillOfMaterialVariantUsage
      when 'E' then equip_bom_main.BillOfMaterialVariantUsage
      when 'T' then floc_bom_main.BillOfMaterialVariantUsage 
      end as BillOfMaterialVariantUsage,
      
      bom_permanent.BillOfMaterialAuthsnGrp as BillOfMaterialAuthsnGrp,
      bom_permanent.BOMIsConfigurable       as BOMIsConfigurable,
      bom_main.IsConfiguredMaterial         as IsConfiguredMaterial,
      bom_permanent.IsVersionBillOfMaterial as IsVersionBillOfMaterial,
      bom_permanent.BOMTechnicalType        as BOMTechnicalType,
      bom_permanent.BOMHeaderText           as BOMHeaderText,
      bom_permanent.BOMGroup                as BOMGroup,
      bom_permanent.BOMIsToBeDeleted        as BOMIsToBeDeleted,
//      bom_main.RecordCreationDate           as RecordCreationDate,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.RecordCreationDate
      when 'E' then equip_bom_main.RecordCreationDate
      when 'T' then floc_bom_main.RecordCreationDate 
      end as RecordCreationDate,
//      bom_main.LastChangeDate               as LastChangeDate,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.LastChangeDate
      when 'E' then equip_bom_main.LastChangeDate
      when 'T' then floc_bom_main.LastChangeDate 
      end as LastChangeDate,
//      bom_main.CreatedByUser                as CreatedByUser,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.CreatedByUser
      when 'E' then equip_bom_main.CreatedByUser
      when 'T' then floc_bom_main.CreatedByUser 
      end as CreatedByUser,
//      bom_main.LastChangedByUser            as LastChangedByUser,
      case bom_permanent.BillOfMaterialCategory
      when 'M' then bom_main.LastChangedByUser
      when 'E' then equip_bom_main.LastChangedByUser
      when 'T' then floc_bom_main.LastChangedByUser 
      end as LastChangedByUser,
      
      case
        when _bom_valid.BillOfMaterial is not initial
        then cast (' ' as boole_d )
        else cast ('X' as boole_d )
        end                                 as DeletionIndicator,
      bom_permanent.LongTextLanguage        as LongTextLanguage,
      _ProductText.LongText                 as LongText,

      _Material,
      _BillOfMaterialVariantUsage,
      _Plant,
      _Product,
//      _bom_valid,
      _ProductText

}
where
  (
       bom_permanent.BillOfMaterialCategory = 'M'
    or bom_permanent.BillOfMaterialCategory = 'E'
    or bom_permanent.BillOfMaterialCategory = 'T'
  )
