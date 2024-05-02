@AbapCatalog.sqlViewName: '/SIMPLE/IBOMUSG'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Usage'
@Search.searchable: true
@ObjectModel.dataCategory:#TEXT
@ObjectModel.representativeKey: 'BillOfMaterialVariantUsage'
define view /SIMPLE/I_BillOfMaterialUsage
  as select from t416t
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
  key stlan   as BillOfMaterialVariantUsage,
      @Semantics.language: true
  key t416t.spras as Language,
      @Semantics.text: true     
      t416t.antxt    as BillOfMaterialVariantUsageDesc
} 
where spras = $session.system_language 
