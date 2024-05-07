@AbapCatalog.sqlViewName: '/SIMPLE/IPRCAT'
@EndUserText.label: 'Product Category Type'

@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductCategory'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductCategory
  as select from dd07l

  association [0..*] to /SIMPLE/I_ProductCategoryText as _Text on $projection.ProductCategory = _Text.ProductCategory

{

       @ObjectModel.text.association: '_Text'
  key  cast ( domvalue_l as articlecategory ) as ProductCategory,

       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @Consumption.hidden: true
       domvalue_l                             as DomainValue,

       _Text

}
where
  domname = 'ATTYP'
