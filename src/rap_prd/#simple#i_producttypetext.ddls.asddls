@AbapCatalog.sqlViewName: '/SIMPLE/IPTYPET'
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@ObjectModel.dataCategory: #TEXT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'ProductType'
@EndUserText.label: 'Product Type Text'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductTypeText
  as select from t134t

     association [0..1] to /SIMPLE/I_Producttype as _ProductType           on $projection.ProductType = _ProductType.ProductType
     association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language

{
      @ObjectModel.foreignKey.association: '_ProductType'
  key cast(t134t.mtart as producttype preserving type )     as ProductType,
      @Semantics.language: true
  key t134t.spras                                           as Language,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      cast(t134t.mtbez as producttypename)                  as MaterialTypeName,
      
      _Language,
      _ProductType
}
