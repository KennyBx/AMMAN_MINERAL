@AbapCatalog.sqlViewName: '/SIMPLE/IBOMAIN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill of Material Main'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}

@AbapCatalog.preserveKey: true
define root view /SIMPLE/I_BOMMainAPITP
  as select from /SIMPLE/I_MaterialBOMMain as bom_main
   //danh123composition [0..*] of /SIMPLE/I_BillOfMatItemAPITP as _BillOfMaterialItem
   //danh123composition [0..*] of /SIMPLE/I_BillOfMatAPITP     as _BillOfMaterialHeader
{
  key bom_main.BillOfMaterial                as BillOfMaterial,
  key bom_main.BillOfMaterialVariant         as BillOfMaterialVariant,
  key bom_main.Material                      as Material,
  key bom_main.Plant                         as Plant,
  key bom_main.BillOfMaterialVariantUsage    as BillOfMaterialVariantUsage,
  key bom_main.BillOfMaterialCategory        as BillOfMaterialCategory,
      bom_main.BillOfMaterialAuthsnGrp       as BillOfMaterialAuthsnGrp,
      bom_main.BOMIsConfigurable             as BOMIsConfigurable,
      bom_main.IsConfiguredMaterial          as IsConfiguredMaterial,
      bom_main.IsVersionBillOfMaterial       as IsVersionBillOfMaterial,
      bom_main.BOMTechnicalType              as BOMTechnicalType,
      bom_main.DeletionIndicator             as DeletionIndicator,
      bom_main.BOMGroup                      as BOMGroup,
      bom_main.BOMIsToBeDeleted              as BOMIsToBeDeleted,
      bom_main.RecordCreationDate            as RecordCreationDate,
      bom_main.LastChangeDate                as LastChangeDate,
      bom_main.CreatedByUser                 as CreatedByUser,
      bom_main.LastChangedByUser             as LastChangedByUser,
      bom_main.LongTextLanguage              as LongTextLanguage,
      bom_main.LongText                      as LongText,
      //Change 24/05/2021
      bom_main.BOMHeaderText                 as BOMHeaderText,   
      
      cast('            ' as aennr )         as EngineeringChangeDocForEdit,
      cast( $session.system_date as datub  ) as ValidityDate //danh123,

       //danh123_BillOfMaterialItem,
       //danh123_BillOfMaterialHeader
}
