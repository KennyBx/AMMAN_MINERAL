// Interface view for Material BOM
@AbapCatalog.sqlViewName: '/SIMPLE/IMATBOM'
@AbapCatalog.preserveKey:true
@EndUserText.label: 'Interface view to expose material and plant with header data'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #CHECK
--@ObjectModel.writeEnabled: true


define view /SIMPLE/I_MaterialBOM
  as select from /SIMPLE/I_BillOfMaterial as bom_header
  association [0..1] to /SIMPLE/I_VersionStatus       as _VersionStatus              on  $projection.BOMVersionStatus = _VersionStatus.BOMVersionStatus
                                                                                     and _VersionStatus.Language      = $session.system_language
 association [0..1] to /SIMPLE/I_Material            as _Material                   on  $projection.Material = _Material.Material
//  association [0..1] to /SIMPLE/I_BillOfMaterialUsage as _BillOfMaterialVariantUsage on  $projection.BillOfMaterialVariantUsage = _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage
//                                                                                     and _BillOfMaterialVariantUsage.Language   = $session.system_language
//  association [0..1] to /SIMPLE/I_Plant               as _Plant                      on  $projection.Plant = _Plant.Plant
//  association [0..1] to /SIMPLE/I_UnitOfMeasure       as _UnitOfMeasure              on  $projection.BOMHeaderBaseUnit = _UnitOfMeasure.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_BomChanges          as _BOMChangeNumbers           on  $projection.BillOfMaterial             = _BOMChangeNumbers.BillOfMaterial
//                                                                                     and $projection.BillOfMaterialCategory     = _BOMChangeNumbers.BillOfMaterialCategory
//                                                                                     and $projection.BillOfMaterialVariant      = _BOMChangeNumbers.BillOfMaterialVariant
//                                                                                     and $projection.BillOfMaterialVersion      = _BOMChangeNumbers.BillOfMaterialVersion
//                                                                                     and $projection.Material                   = _BOMChangeNumbers.Material
//                                                                                     and $projection.Plant                      = _BOMChangeNumbers.Plant
//                                                                                     and $projection.BillOfMaterialVariantUsage = _BOMChangeNumbers.BillOfMaterialVariantUsage
  association [0..1] to I_ChangeMaster        as _ChangeNumbers              on  $projection.EngineeringChangeDocument = _ChangeNumbers.ChangeNumber

//  association [0..1] to /SIMPLE/I_Product             as _Product                    on  $projection.Material = _Product.Product
//
  association [0..1] to /SIMPLE/I_Producttexts        as _ProductText                on  $projection.Material = _ProductText.Product
                                                                                     and $projection.LongAlterTextLanguage = _ProductText.Language
{
  key bom_header.BillOfMaterialCategory       as BillOfMaterialCategory,
  key bom_header.BillOfMaterial               as BillOfMaterial,
  key bom_header.BillOfMaterialVariant        as BillOfMaterialVariant,
  key bom_header.BillOfMaterialVersion        as BillOfMaterialVersion,
  key bom_header.EngineeringChangeDocument    as EngineeringChangeDocument,
  key _Mast.Material                          as Material,
  key _Mast.Plant                             as Plant,
      //@ObjectModel.readOnly: true
      bom_header.BOMHeaderInternalChangeCount as BOMHeaderInternalChangeCount,
      bom_header.BillOfMaterialVariantUsage   as BillOfMaterialVariantUsage,
//      bom_header.EngineeringChangeDocument    as EngineeringChangeDocument,
      bom_header.BillOfMaterialHeaderUUID     as BillOfMaterialHeaderUUID,
      --      bintohex( bom_header.BillOfMaterialHeaderUUID )                                                                                                                            as BOMCharUUID,
      bom_header.BillOfMaterialUUID           as BillOfMaterialUUID,
      bom_header.IsMultipleBOMAlt             as IsMultipleBOMAlt,
      //@ObjectModel.readOnly: true
      bom_header.BOMPrioritizedVersion        as BOMPrioritizedVersion,
      @Consumption.hidden: true
      //@ObjectModel.readOnly: true
      bom_header.BOMExplosionApplication      as BOMExplosionApplication,
      //@ObjectModel.readOnly: true
      bom_header.BOMUsagePriority             as BOMUsagePriority,
      bom_header.BillOfMaterialAuthsnGrp      as BillOfMaterialAuthsnGrp,
      bom_header.BOMVersionStatus             as BOMVersionStatus,
      _Mast.MaterialToLotSizeQuantity         as MaterialToLotSizeQuantity,
      _Mast.MatFromLotSizeQuantity            as MatFromLotSizeQuantity,
      bom_header.IsVersionBillOfMaterial      as IsVersionBillOfMaterial,
      bom_header.IsLatestBOMVersion           as IsLatestBOMVersion,
      bom_header.BOMTechnicalType             as BOMTechnicalType,
      bom_header.BOMGroup                     as BOMGroup,
      bom_header.BOMHeaderText                as BOMHeaderText,
      bom_header.BOMAlternativeText           as BOMAlternativeText,
      bom_header.BillOfMaterialStatus         as BillOfMaterialStatus,
      //@ObjectModel.readOnly: true
      @Semantics.businessDate.to: true
      bom_header.HeaderValidityEndDate,
      @Semantics.businessDate.from: true
      bom_header.HeaderValidityStartDate,
      bom_header.ChgToEngineeringChgDocument  as ChgToEngineeringChgDocument,
      bom_header.IsMarkedForDeletion          as IsMarkedForDeletion,
      bom_header.BOMIsArchivedForDeletion,
      bom_header.IsConfiguredMaterial         as IsConfiguredMaterial, -- MAST-KZKFG
      bom_header.BOMIsConfigurable            as BOMIsConfigurable, -- MAST-KZKFG
      //@ObjectModel.readOnly: true
      bom_header.IsALE                        as IsALE,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_UnitOfMeasure'
      bom_header.BOMHeaderBaseUnit            as BOMHeaderBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
      @DefaultAggregation :#NONE
      bom_header.BOMHeaderQuantityInBaseUnit  as BOMHeaderQuantityInBaseUnit,
      bom_header.RecordCreationDate           as RecordCreationDate,
      bom_header.LastChangeDate               as LastChangeDate,
      bom_header.LastChangedByUser            as LastChangedByUser,
      bom_header.CreatedByUser                as CreatedByUser,
      bom_header.BOMIsToBeDeleted             as BOMIsToBeDeleted,
      bom_header.DocumentIsCreatedByCAD       as DocumentIsCreatedByCAD,
      bom_header.LaboratoryOrDesignOffice     as LaboratoryOrDesignOffice,
      bom_header.LastChangeDateTime           as LastChangeDateTime,
      bom_header.BOMAssetNtwkHndovrIsRelevant as BOMAssetNtwkHndovrIsRelevant,
      _Mast.MaterialBOMObjectID               as MaterialBOMObjectID,

      --   '' as BOMPredecessorVersion,
      bom_header.BOMPredecessorVersion,
      bom_header.LongAlterTextLanguage,
      _Material,
      _BillOfMaterialItem,
      _BillOfMaterialVariantUsage,
      _VersionStatus,
      _UnitOfMeasure,
//      _Plant,
//      _BOMChangeNumbers,
//      _Product,
      _ProductText
}
where
  bom_header.BillOfMaterialCategory = 'M'
