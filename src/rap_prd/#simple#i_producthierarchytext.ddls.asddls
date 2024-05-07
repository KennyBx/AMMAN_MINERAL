@EndUserText.label: 'Product Hierarchy Text' //same as DDL description
@ObjectModel.dataCategory: #TEXT
@Analytics.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED //or #CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/IPHIERT'
@ObjectModel.representativeKey: 'ProductHierarchy'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE 
@Search.searchable: true
define view /SIMPLE/I_ProductHierarchyText //must start with 'I_' and end with 'Text' or 'T'
  as select from t179t
  association [0..1] to /SIMPLE/I_Language         as _Language         on $projection.Language = _Language.Language
  association [1..1] to /SIMPLE/I_ProductHierarchy as _ProductHierarchy on $projection.ProductHierarchy = _ProductHierarchy.ProductHierarchy
{
  key prodh as ProductHierarchy,
      @Semantics.language: true
  key spras as Language, //text views shall always be language dependent
      @Semantics.text: true
      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.7,
        ranking: #HIGH
      }
      cast( vtext as producthierarchytext preserving type )  as ProductHierarchyText,
      _ProductHierarchy,
      _Language
}   
  
 