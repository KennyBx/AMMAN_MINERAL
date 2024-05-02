// Interface view for Bill of Material maintenance
@AbapCatalog.sqlViewName: '/SIMPLE/IBOMDTLS'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill of Material'
@AbapCatalog.preserveKey:true
--@ObjectModel.writeEnabled: true

define view /SIMPLE/I_BillOfMaterial
  as select from /SIMPLE/P_BomHeaderDeter as bom_header
  association [0..*] to /SIMPLE/I_BillOfMaterialItem   as _BillOfMaterialItem         on  $projection.BillOfMaterialCategory = _BillOfMaterialItem.BillOfMaterialCategory
                                                                                      and $projection.BillOfMaterial         = _BillOfMaterialItem.BillOfMaterial
                                                                                      and $projection.BillOfMaterialVariant  = _BillOfMaterialItem.BillOfMaterialVariant
  association [0..*] to /SIMPLE/I_MaterialBOMLink      as _Mast                       on  $projection.BillOfMaterialCategory     = _Mast.BillOfMaterialCategory
                                                                                      and $projection.BillOfMaterial             = _Mast.BillOfMaterial
                                                                                      and $projection.BillOfMaterialVariant      = _Mast.BillOfMaterialVariant
                                                                                      and $projection.BillOfMaterialVariantUsage = _Mast.BillOfMaterialVariantUsage

  //  association [0..1] to /SIMPLE/I_DocumentBOMLink     as _Dost                       on  $projection.BillOfMaterialCategory = _Dost.BillOfMaterialCategory
  //                                                                             and $projection.BillOfMaterial         = _Dost.BillOfMaterial
  //                                                                             and $projection.BillOfMaterialVariant  = _Dost.BillOfMaterialVariant
  //  association [0..1] to /SIMPLE/I_Prst                as _Prst                       on  $projection.BillOfMaterialCategory = _Prst.BillOfMaterialCategory
  //                                                                             and $projection.BillOfMaterial         = _Prst.BillOfMaterial
  //                                                                             and $projection.BillOfMaterialVariant  = _Prst.BillOfMaterialVariant
  //  association [0..1] to /SIMPLE/I_SalesOrderBOMLink   as _Kdst                       on  $projection.BillOfMaterialCategory = _Kdst.BillOfMaterialCategory
  //                                                                             and $projection.BillOfMaterial         = _Kdst.BillOfMaterial
  //                                                                             and $projection.BillOfMaterialVariant  = _Kdst.BillOfMaterialVariant
  // Begin uncomment by Doris Dang - 20233011
  association [0..1] to /SIMPLE/I_MATERIALEQUIPBOMLINK as _Eqst                       on  $projection.BillOfMaterialCategory = _Eqst.BillOfMaterialCategory
                                                                                      and $projection.BillOfMaterial         = _Eqst.BillOfMaterial
                                                                                      and $projection.BillOfMaterialVariant  = _Eqst.BillOfMaterialVariant
  association [0..1] to /SIMPLE/I_MATERIALFLOCBOMLINK  as _Tpst                       on  $projection.BillOfMaterialCategory = _Tpst.BillOfMaterialCategory
                                                                                      and $projection.BillOfMaterial         = _Tpst.BillOfMaterial
                                                                                      and $projection.BillOfMaterialVariant  = _Tpst.BillOfMaterialVariant
  // End uncomment by Doris Dang - 20233011
  //  association [0..1] to /SIMPLE/I_STST                as _Stst                       on  $projection.BillOfMaterialCategory = _Stst.BillOfMaterialCategory
  //                                                                             and $projection.BillOfMaterial         = _Stst.BillOfMaterial
  //                                                                             and $projection.BillOfMaterialVariant  = _Stst.BillOfMaterialVariant
  //association [0..1] to I_Material            as _Material                   on  $projection.Material = _Material.Material
  association [0..1] to /SIMPLE/I_BillOfMaterialUsage  as _BillOfMaterialVariantUsage on  $projection.BillOfMaterialVariantUsage = _BillOfMaterialVariantUsage.BillOfMaterialVariantUsage
                                                                                      and _BillOfMaterialVariantUsage.Language   = $session.system_language
  //association [0..1] to I_Plant               as _Plant                      on  $projection.Plant = _Plant.Plant
  association [0..1] to /SIMPLE/I_UnitOfMeasure        as _UnitOfMeasure              on  $projection.BOMHeaderBaseUnit = _UnitOfMeasure.UnitOfMeasure

{


  key     bom_header.guidx                                                                                                                                           as BillOfMaterialHeaderUUID,
  key     bom_header.BillOfMaterialCategory                                                                                                                          as BillOfMaterialCategory,
          --   @ObjectModel.updateEnabled: true
          @ObjectModel.foreignKey.association: '_BillOfMaterialVariantUsage'
  key     bom_header.BillOfMaterialVariantUsage                                                                                                                      as BillOfMaterialVariantUsage,
          --  @ObjectModel.updateEnabled: true

          //@ObjectModel.readOnly: true
  key     bom_header.BillOfMaterial                                                                                                                                  as BillOfMaterial,
          --    @ObjectModel.updateEnabled: true
  key     bom_header.BillOfMaterialVariant                                                                                                                           as BillOfMaterialVariant,
  key     bom_header.BillOfMaterialVersion                                                                                                                           as BillOfMaterialVersion,
          bom_header.mandt                                                                                                                                           as SAPClient,
          concat(concat(concat(bom_header.BillOfMaterial,bom_header.BillOfMaterialCategory),bom_header.BillOfMaterialVariantUsage),bom_header.BillOfMaterialVariant) as BillOfMaterialUUID,
          //bom_header.matfromlotsizequantity                                                                                                                           as MatFromLotSizeQuantity,
          //cast( bom_header.materialtolotsizequantity as losbs )                                                                                                       as MatToLotSizeQuantity,
          //' '                                                                                                                                                         as MatFromLotSizeQuantity, // To be removed
          //' '                                                                                                                                                         as MatToLotSizeQuantity, // To be removed
          --bom_header.MultipleBomAltInd                as MultipleBomAltInd,
          bom_header.IsMultipleBOMAlt                                                                                                                                as IsMultipleBOMAlt,
          //@ObjectModel.readOnly: true
          bom_header.BOMHeaderInternalChangeCount                                                                                                                    as BOMHeaderInternalChangeCount,
          //@ObjectModel.readOnly: true
          //bom_header.isconfiguredmaterial
          //' '                                                                                                                                                         as IsConfiguredMaterial, // To be removed                                                                                                                           as IsConfiguredMaterial,
          @ObjectModel.readOnly: true
          bom_header.BOMPrioritizedVersion                                                                                                                           as BOMPrioritizedVersion,
          @Consumption.hidden: true
          //@ObjectModel.readOnly: true
          bom_header.BOMExplosionApplication                                                                                                                         as BOMExplosionApplication,
          //@ObjectModel.readOnly: true
          bom_header.BOMUsagePriority                                                                                                                                as BOMUsagePriority,
          bom_header.BillOfMaterialAuthsnGrp                                                                                                                         as BillOfMaterialAuthsnGrp,
          bom_header.BOMVersionStatus                                                                                                                                as BOMVersionStatus,
          bom_header.IsVersionBillOfMaterial                                                                                                                         as IsVersionBillOfMaterial,
          bom_header.IsLatestBOMVersion                                                                                                                              as IsLatestBOMVersion,
          bom_header.BOMIsConfigurable                                                                                                                               as BOMIsConfigurable,    -- MAST-KZKFG
          bom_header.IsConfiguredMaterial                                                                                                                            as IsConfiguredMaterial, -- MAST-KZKFG
          cast ( bom_header.BOMTechnicalType as tetyp_d preserving type)                                                                                             as BOMTechnicalType,
          bom_header.BOMGroup                                                                                                                                        as BOMGroup,
          bom_header.BOMHeaderText                                                                                                                                   as BOMHeaderText,
          bom_header.BOMAlternativeText                                                                                                                              as BOMAlternativeText,
          bom_header.BillOfMaterialStatus                                                                                                                            as BillOfMaterialStatus,
          bom_header.HeaderValidityStartDate                                                                                                                         as HeaderValidityStartDate,
          //@ObjectModel.readOnly: true
          bom_header.HeaderValidityEndDate                                                                                                                           as HeaderValidityEndDate,
          bom_header.HeaderEngineeringChgNmbrDoc                                                                                                                     as EngineeringChangeDocument,
          bom_header.ChangeNumberTo                                                                                                                                  as ChgToEngineeringChgDocument,
          bom_header.DeletionIndicator                                                                                                                               as IsMarkedForDeletion,
          bom_header.BOMIsArchivedForDeletion,
          //@ObjectModel.readOnly: true
          --bom_header.deletionindicatorbom             as DeletionIndicatorBOM,
          --             ' ' as IndicatorALE, //Space to be deleted
          bom_header.IsALE                                                                                                                                           as IsALE,
          @Semantics.unitOfMeasure: true
          @ObjectModel.foreignKey.association: '_UnitOfMeasure'
          --   @ObjectModel.updateEnabled: true
          bom_header.BOMHeaderBaseUnit                                                                                                                               as BOMHeaderBaseUnit,
          @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
          @DefaultAggregation :#NONE
          --      @ObjectModel.updateEnabled: true
          bom_header.BOMHeaderQuantityInBaseUnit                                                                                                                     as BOMHeaderQuantityInBaseUnit,
          bom_header.RecordCreationDate                                                                                                                              as RecordCreationDate,
          bom_header.LastChangeDate                                                                                                                                  as LastChangeDate,
          bom_header.CreatedByUser                                                                                                                                   as CreatedByUser,
          bom_header.LastChangedByUser                                                                                                                               as LastChangedByUser,
          bom_header.BOMIsToBeDeleted                                                                                                                                as BOMIsToBeDeleted,
          /*  cast (1 as abap.int4 ) as                  NumberOfBOMHeaderChanges,
            case when bom_header.BOMHeaderInternalChangeCount = '00000001' then cast (1 as abap.int4 )
            else cast (0 as abap.int4)
            end as CountOfBOMByCategory , */
          //bom_header.salesorder                                                                                                                                       as SalesOrder,
          //bom_header.salesorderitem                                                                                                                                   as SalesOrderItem,
          //bom_header.wbselementinternalid                                                                                                                             as WBSElementInternalID,
          bom_header.DocumentIsCreatedByCAD                                                                                                                          as DocumentIsCreatedByCAD,
          bom_header.LaboratoryOrDesignOffice                                                                                                                        as LaboratoryOrDesignOffice,
          bom_header.LastChangeDateTime                                                                                                                              as LastChangeDateTime,
          bom_header.BOMAssetNtwkHndovrIsRelevant                                                                                                                    as BOMAssetNtwkHndovrIsRelevant,
          bom_header.BOMPredecessorVersion                                                                                                                           as BOMPredecessorVersion,
          bom_header.LongAlterTextLanguage,
          // _Mast.MaterialBOMObjectID as MaterialBOMObjectID,
          _BillOfMaterialItem,
          _BillOfMaterialVariantUsage,
          _UnitOfMeasure,
          _Mast,
          //      _Dost,
          //      _Prst,
          //      _Kdst,
          // Begin uncomment by Doris Dang - 20233011
          _Eqst,
          _Tpst
          // End uncomment by Doris Dang - 20233011
          //      _Stst
}
