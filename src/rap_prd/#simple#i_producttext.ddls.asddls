@AbapCatalog.sqlViewName: '/SIMPLE/IPRDTXT'
@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Text'
@ObjectModel.representativeKey: 'Product'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductText  
  as select from makt 
  association [1..1] to /SIMPLE/I_Product as _Product on $projection.Product = _Product.Product 
{
  key makt.matnr                                              as Product,
      @Semantics.language: true
  key makt.spras                                              as Language,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH 
      cast(makt.maktx as productdescription preserving type ) as ProductName,
      _Product
}
