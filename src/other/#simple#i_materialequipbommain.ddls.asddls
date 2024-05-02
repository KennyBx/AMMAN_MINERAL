// Interface view for Material BOM
@AbapCatalog.sqlViewName: '/SIMPLE/IMAEBAI'
@AbapCatalog.preserveKey:true
@EndUserText.label: 'Material equipment bom main'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #CHECK
--@ObjectModel.writeEnabled: true


define view /SIMPLE/I_MATERIALEQUIPBOMMAIN
  as select from /SIMPLE/P_BOMPermanentDeter as bom_permanent 
  
    inner join   /SIMPLE/I_MATERIALEQUIPBOMLINK as bom_main on bom_main.BillOfMaterial = bom_permanent.BillOfMaterial

  association [0..1] to I_Equipment             as _Equipment                   on  $projection.equipment = _Equipment.Equipment

  association [0..1] to /SIMPLE/I_BillOfMaterialUsage as _BillOfMaterialVariantUsage on  _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage = $projection.BillOfMaterialVariantUsage
                                                                                     and _BillOfMaterialVariantUsage.Language                   = $session.system_language

  association [0..1] to /SIMPLE/I_Plant               as _Plant                      on  $projection.Plant = _Plant.Plant

//  association [0..1] to /SIMPLE/I_Product             as _Product                    on  $projection.Material = _Product.Product
//
//  association [0..1] to /SIMPLE/I_Producttexts        as _ProductText                on  $projection.Material = _ProductText.Product
//                                                                                     //Change 24/05/2021
//                                                                                     and _ProductText.Language = $session.system_language

//  association [0..1] to /SIMPLE/P_BOMHeaderValidDeter as _bom_valid                  on  $projection.BillOfMaterialCategory = _bom_valid.BillOfMaterialCategory
//                                                                                     and $projection.BillOfMaterial         = _bom_valid.BillOfMaterial
//                                                                                     and $projection.BillOfMaterialVariant  = _bom_valid.BillOfMaterialVariant
{
  key bom_permanent.BillOfMaterialCategory  as BillOfMaterialCategory,
  key bom_permanent.BillOfMaterial          as BillOfMaterial,
      bom_main.BillOfMaterialVariant        as BillOfMaterialVariant,
      bom_main.EquipmentNumber              as EquipmentNumber,
      bom_main.Plant                        as Plant,
      bom_main.BillOfMaterialVariantUsage   as BillOfMaterialVariantUsage,
      bom_permanent.BillOfMaterialAuthsnGrp as BillOfMaterialAuthsnGrp,
      bom_permanent.BOMIsConfigurable       as BOMIsConfigurable,
//      bom_main.IsConfiguredMaterial         as IsConfiguredMaterial,
      bom_permanent.IsVersionBillOfMaterial as IsVersionBillOfMaterial,
      bom_permanent.BOMTechnicalType        as BOMTechnicalType,
      bom_permanent.BOMHeaderText           as BOMHeaderText,
      bom_permanent.BOMGroup                as BOMGroup,
      bom_permanent.BOMIsToBeDeleted        as BOMIsToBeDeleted,
      bom_main.RecordCreationDate           as RecordCreationDate,
      bom_main.LastChangeDate               as LastChangeDate,
      bom_main.CreatedByUser                as CreatedByUser,
      bom_main.LastChangedByUser            as LastChangedByUser,

//      case
//        when _bom_valid.BillOfMaterial is not initial
//        then cast (' ' as boole_d )
//        else cast ('X' as boole_d )
//        end                                 as DeletionIndicator,
      bom_permanent.LongTextLanguage        as LongTextLanguage,
//      _ProductText.LongText                 as LongText,
//
//      _Material,
      _BillOfMaterialVariantUsage,
      _Plant
//      _Product,
//      _bom_valid,
//      _ProductText
      
}
where
  bom_permanent.BillOfMaterialCategory = 'E'
