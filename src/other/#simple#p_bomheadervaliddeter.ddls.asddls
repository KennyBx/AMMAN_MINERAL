@AbapCatalog.sqlViewName: '/SIMPLE/PBOHVLDE'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@VDM.private: true
@VDM.lifecycle.contract.type: #NONE
define view /SIMPLE/P_BOMHeaderValidDeter
  as select distinct from /SIMPLE/P_BOMHeaderValid as header
    inner join            stzu                     as stzu on  stzu.stlty = header.BillOfMaterialCategory
                                                           and stzu.stlnr = header.BillOfMaterial
{
  key header.BillOfMaterialCategory as BillOfMaterialCategory,
  key header.BillOfMaterial         as BillOfMaterial,
  key header.BillOfMaterialVariant  as BillOfMaterialVariant,
  
      //MNGUYEN03 Validity Date from header 05/09/2022
      header.HeaderValidityStartDate  as HeaderValidityStartDate,
        
      stzu.stlan                    as BillOfMaterialVariantUsage
}
