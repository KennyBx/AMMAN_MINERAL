@AbapCatalog.sqlViewName: '/SIMPLE/PSUBITMS'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@VDM.private: true
@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.lifecycle.contract.type: #NONE
--@EndUserText.label: 'Get Valid BOM Subitems for BOM items'
define view /SIMPLE/P_BOMSUBITEMS
  as select distinct from stpu as STPU
      inner join stas as stas on stpu.stlty = stas.stlty
                             and stpu.stlnr = stas.stlnr
                             and stpu.stlkn = stas.stlkn
                             and stas.lkenz = ' '
      inner join stpo as stpo on stpu.stlty = stpo.stlty
                             and stpu.stlnr = stpo.stlnr
                             and stpu.stlkn = stpo.stlkn 
                             and stpu.stpoz = stpo.stpoz
{
  key stpu.stlty    as    BillOfMaterialCategory,
  key stpu.stlnr    as    BillOfMaterial,
  key stas.stlal    as    BillOfMaterialVariant,
  key stpu.stlkn    as    BillOfMaterialItemNodeNumber,
  key stpu.stpoz    as    BOMItemInternalChangeCount,
  key stpu.uposz    as    BOMSubItem,
  @Semantics.unitOfMeasure: true
      stpo.meins    as    BillOfMaterialItemUnit,
  @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      stpu.upmng    as    BillOfMaterialSubItemQuantity,
      stpu.ebort    as    InstallationPoint,
      stpu.uptxt    as    SubItemText

} 
