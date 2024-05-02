@AbapCatalog.sqlViewName: '/SIMPLE/IBHAPI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Header(Transactional Processing)'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AbapCatalog.preserveKey: true
define view /SIMPLE/I_BillOfMatAPITP
  as select from /SIMPLE/I_MaterialBOM as bom_header
  association to parent /SIMPLE/I_BOMMainAPITP as _BillOfMaterial on  $projection.BillOfMaterial             = _BillOfMaterial.BillOfMaterial
                                                                  and $projection.BillOfMaterialCategory     = _BillOfMaterial.BillOfMaterialCategory
                                                                  and $projection.BillOfMaterialVariant      = _BillOfMaterial.BillOfMaterialVariant
                                                                  and $projection.BillOfMaterialVariantUsage = _BillOfMaterial.BillOfMaterialVariantUsage
                                                                  and $projection.Material                   = _BillOfMaterial.Material
                                                                  and $projection.Plant                      = _BillOfMaterial.Plant
  //danh123composition [0..*] of /SIMPLE/I_BOMHeaderLnkDocAPITP as _BOMHeaderLinkedDocument
{
  key bom_header.BillOfMaterial                                      as BillOfMaterial,
  key bom_header.BillOfMaterialCategory                              as BillOfMaterialCategory,
  key bom_header.BillOfMaterialVariant                               as BillOfMaterialVariant,
  key bom_header.BillOfMaterialVersion                               as BillOfMaterialVersion,
  key bom_header.Material                                            as Material,
  key bom_header.Plant                                               as Plant,
  key bom_header.BillOfMaterialVariantUsage                          as BillOfMaterialVariantUsage,
  key bom_header.BOMHeaderInternalChangeCount                        as BOMHeaderInternalChangeCount,
      bom_header.EngineeringChangeDocument                           as EngineeringChangeDocument,
      bom_header.BillOfMaterialHeaderUUID                            as BillOfMaterialHeaderUUID,
      bom_header.EngineeringChangeDocument                           as EngineeringChangeDocForEdit,
      bom_header.IsMultipleBOMAlt                                    as IsMultipleBOMAlt,
      bom_header.BOMUsagePriority                                    as BOMUsagePriority,
      bom_header.BillOfMaterialAuthsnGrp                             as BillOfMaterialAuthsnGrp,
      bom_header.BOMVersionStatus                                    as BOMVersionStatus,
      bom_header.IsVersionBillOfMaterial                             as IsVersionBillOfMaterial,
      bom_header.IsLatestBOMVersion                                  as IsLatestBOMVersion,
      bom_header.IsConfiguredMaterial                                as IsConfiguredMaterial,
      cast ( bom_header.BOMTechnicalType as tetyp_d preserving type) as BOMTechnicalType,
      bom_header.BOMGroup                                            as BOMGroup,
      bom_header.BOMHeaderText                                       as BOMHeaderText,
      bom_header.BOMAlternativeText                                  as BOMAlternativeText,
      bom_header.BillOfMaterialStatus                                as BillOfMaterialStatus,
      bom_header.HeaderValidityStartDate                             as HeaderValidityStartDate,
      bom_header.HeaderValidityEndDate                               as HeaderValidityEndDate,
      bom_header.ChgToEngineeringChgDocument                         as ChgToEngineeringChgDocument,
      bom_header.IsMarkedForDeletion                                 as IsMarkedForDeletion,
      bom_header.IsALE                                               as IsALE,
      @Semantics.unitOfMeasure: true
      bom_header.BOMHeaderBaseUnit                                   as BOMHeaderBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
      bom_header.BOMHeaderQuantityInBaseUnit                         as BOMHeaderQuantityInBaseUnit,
      bom_header.RecordCreationDate                                  as RecordCreationDate,
      bom_header.LastChangeDate                                      as LastChangeDate,
      bom_header.CreatedByUser                                       as CreatedByUser,
      bom_header.LastChangedByUser                                   as LastChangedByUser,
      bom_header.BOMIsToBeDeleted                                    as BOMIsToBeDeleted,
      bom_header.BOMIsArchivedForDeletion                            as BOMIsArchivedForDeletion,
      bom_header.DocumentIsCreatedByCAD                              as DocumentIsCreatedByCAD,
      bom_header.LaboratoryOrDesignOffice,
      @ObjectModel.readOnly: true
      case
        when bom_header.LastChangeDateTime = fltp_to_dec( 0.0 as timestampl )
        then fltp_to_dec( 19720401000000.0 as timestampl )
        else bom_header.LastChangeDateTime
      end                                                            as LastChangeDateTime,
      //Version BOM
      cast(' ' as abap.char( 4 ) )                                   as SelectedBillOfMaterialVersion,
      bom_header.MatFromLotSizeQuantity                              as MatFromLotSizeQuantity,
      bom_header.MaterialToLotSizeQuantity                           as MaterialToLotSizeQuantity,
      _Material.SizeDimension                                        as SizeDimension,
      bom_header.LongAlterTextLanguage                               as LongAlterTextLanguage,
      _ProductText.LongText                                          as LongAlternativeText,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _BillOfMaterial //danh123,
      //danh123_BOMHeaderLinkedDocument
}
