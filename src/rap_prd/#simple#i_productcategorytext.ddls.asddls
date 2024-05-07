@AbapCatalog.sqlViewName: '/SIMPLE/IPRCATT'
@EndUserText.label: 'Product Category Type Text'
@Search: {
  searchable: true
}
@Analytics: { dataCategory: #DIMENSION }
@VDM.viewType: #BASIC
@ObjectModel.dataCategory: #TEXT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'ProductCategory'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductCategoryText
  as select from dd07t

  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language

  //  association [0..1] to I_ProductCategory as _ProductCategory on $projection.ProductCategory = _ProductCategory.ProductCategory

{

      @Semantics.language
  key cast( ddlanguage as spras preserving type ) as Language,

      //      @ObjectModel.foreignKey.association: '_ProductCategory'


      //  key cast ( substring( domvalue_l, 1, 2 ) as articlecategory preserving type )     as ProductCategory,
  key cast ( domvalue_l as articlecategory )      as ProductCategory,

      @Semantics.text
      @Search: {
      defaultSearchElement: true,
      fuzzinessThreshold: 0.8
      }
      //      cast ( substring ( ddtext, 1, 60 ) as val_text )                              as Name,
      cast ( ddtext as val_text )                 as Name,

      //      _ProductCategory,

      _Language



}
where
      domname  = 'ATTYP'
  and as4local = 'A'
