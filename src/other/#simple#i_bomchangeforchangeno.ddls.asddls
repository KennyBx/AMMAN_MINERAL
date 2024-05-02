@AbapCatalog.sqlViewName: '/SIMPLE/IBOCHCHN'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@AbapCatalog.compiler.compareFilter: true
@VDM.private: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.lifecycle.contract.type: #NONE
--@EndUserText.label: 'BOO header determination'

define view /SIMPLE/I_BOMChangeForChangeNo
  as select from /SIMPLE/I_BomItemChanges as item
  {
    key item.BillOfMaterial             as BillOfMaterial,
    key item.BillOfMaterialCategory     as BillOfMaterialCategory,
    key item.BillOfMaterialVariant      as BillOfMaterialVariant,
    key item.BillOfMaterialVariantUsage as BillOfMaterialVariantUsage, 
    item.EngineeringChangeDocument      as EngineeringChangeDocument,
    ChangeNumberValidFromDate           as ValidFromDate
  }
  union select from /SIMPLE/P_BomHeaderDeter as header
  {
    key header.BillOfMaterial               as BillOfMaterial,
    key header.BillOfMaterialCategory       as BillOfMaterialCategory,
    key header.BillOfMaterialVariant        as BillOfMaterialVariant,
    key header.BillOfMaterialVariantUsage   as BillOfMaterialVariantUsage,
    HeaderEngineeringChgNmbrDoc as EngineeringChangeDocument,
    HeaderValidityStartDate as ValidFromDate
  }
  union select from /SIMPLE/P_BomHeaderDeter as header
  {
    key header.BillOfMaterial               as BillOfMaterial,
    key header.BillOfMaterialCategory       as BillOfMaterialCategory,
    key header.BillOfMaterialVariant        as BillOfMaterialVariant,
    key header.BillOfMaterialVariantUsage   as BillOfMaterialVariantUsage,
    ChangeNumberTo as EngineeringChangeDocument,
    HeaderValidityStartDate as ValidFromDate
  } where ChangeNumberTo is not initial
