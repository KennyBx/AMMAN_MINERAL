// Product description active table
@AbapCatalog:{
  sqlViewName: '/SIMPLE/IPDESC',
  preserveKey: true
}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Description Active Core Entity'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Product'
@ObjectModel: {
    usageType.serviceQuality: #A,
    usageType.sizeCategory : #L,
    usageType.dataClass: #MASTER
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductDescription  
  as select from makt
  association [1..1] to /SIMPLE/I_Product as _Product on $projection.Product = _Product.Product
{

  key cast(makt.matnr as productnumber preserving type )             as Product,
      @Semantics.language: true
  key makt.spras                                                     as Language,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      cast(makt.maktx as productdescription preserving type )        as ProductDescription,

      cast('' as languageisocode)                                    as LanguageISOCode,
      _Product
}
