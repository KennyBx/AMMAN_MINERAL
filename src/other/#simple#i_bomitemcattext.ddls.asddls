@AbapCatalog.sqlViewName: '/SIMPLE/IBICATTE'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'BillOfMaterialItemCategory'
@ObjectModel.dataCategory:#TEXT
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #S, dataClass: #CUSTOMIZING}
@EndUserText.label: 'Bill Of Material Item Category Text'
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_BomItemCatText
  as select from t418t
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language

{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key spras     as Language,
      _Language,

  key postp     as BillOfMaterialItemCategory,
      @Semantics.text: true
      ptext     as BillOfMaterialItemCategoryDesc

}   
  
 