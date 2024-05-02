@AbapCatalog.sqlViewName: '/SIMPLE/IBICAT'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Item Category'
@Search.searchable: true
@ObjectModel.representativeKey: 'BillOfMaterialItemCategory'
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BOMItemCategory
  as select from t418 as ItemCategory
  association [0..*] to /SIMPLE/I_BomItemCatText as _ItemCategoryT on ItemCategory.postp = _ItemCategoryT.BillOfMaterialItemCategory
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
  key ItemCategory.postp  as BillOfMaterialItemCategory,
        
      _ItemCategoryT[1: Language = $session.system_language].BillOfMaterialItemCategoryDesc,

      @UI.hidden: true
      case when ItemCategory.dkpos = 'X' then cast( 'D' as postp preserving type)
       when ItemCategory.klpos = 'X' then cast( 'K' as postp preserving type)
       when ItemCategory.matin <> '-'          and
         ItemCategory.rtpos = ''   and
         ItemCategory.inpos = ''  and
         ItemCategory.btpos = ''  and
         ItemCategory.txpos = ''   and
         ItemCategory.dkpos = ''   and                  
         ItemCategory.kzbsf = 'X' then cast( 'L' as postp preserving type)
       when ItemCategory.inpos = 'X' and
       ItemCategory.matin = '+' and
       ItemCategory.kzups <> 'X' then cast( 'M' as postp preserving type)
       when ItemCategory.txpos = 'X' then cast('T' as postp preserving type)
       when ItemCategory.rtpos = 'X' and
       ItemCategory.matin = '+' and
       ItemCategory.kzbsf = 'X' and
       ItemCategory.mngvz = '+'
       then cast ('R' as postp preserving type)
       when ItemCategory.btpos = 'X' and
       ItemCategory.matin = '+' and
       ItemCategory.mngvz = '+' then cast ('I' as postp preserving type)
       when ItemCategory.matin <> '-' and
         ItemCategory.rtpos = ''   and
         ItemCategory.inpos = ''   and
         ItemCategory.btpos = ''   and                
         ItemCategory.txpos = ''   and
         ItemCategory.dkpos = ''   and
         ItemCategory.kzbsf = '' then cast( 'N' as postp preserving type)
       when ItemCategory.rtpos = ''   and
         ItemCategory.inpos = ''   and
         ItemCategory.btpos = ''   and                
         ItemCategory.txpos = ''   and
         ItemCategory.dkpos = ''   and
         ItemCategory.kzbsf = ''   and 
         ItemCategory.klpos = ''   and 
         ItemCategory.matin = '+' then cast ('E' as postp preserving type) //Material Required
       when ItemCategory.rtpos = ''   and
         ItemCategory.inpos = ''   and
         ItemCategory.btpos = ''   and                
         ItemCategory.txpos = ''   and
         ItemCategory.dkpos = ''   and
         ItemCategory.kzbsf = ''   and 
         ItemCategory.klpos = ''   and 
         ItemCategory.matin = '-' then cast ('V' as postp preserving type) //Material Void 
        when  ItemCategory.rtpos = ''   and
         ItemCategory.inpos = ''   and
         ItemCategory.btpos = ''   and                
         ItemCategory.txpos = ''   and
         ItemCategory.dkpos = ''   and
         ItemCategory.kzbsf = ''   and 
         ItemCategory.klpos = ''   and 
         ItemCategory.matin = '.' then cast ('O' as postp preserving type) // Material Optional

       end                as FixedItemCategory,
      _ItemCategoryT
}
