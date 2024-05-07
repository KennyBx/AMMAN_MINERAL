@EndUserText.label: 'Product Hierarchy' //same as DDL description
@Analytics.dataCategory: #DIMENSION //or #CUBE or #FACT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/IPHIER' //must start with "I"
@Search.searchable: true
@ObjectModel.representativeKey:'ProductHierarchy'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_ProductHierarchy //must start with "I_"; same as DDL source name in upper-camelcase notation
  as select from t179
  association [0..*] to /SIMPLE/I_ProductHierarchyText as _Text on $projection.ProductHierarchy = _Text.ProductHierarchy
{
      //key cast (${DatabaseFieldName} as ${DataElementWithProperLabel}) as ${GlobalFieldName},
      //_${TargetPublicBasicViewNameWithoutPrefix} //expose the association for use by consumers
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @ObjectModel.text.association: '_Text'
  key t179.prodh as ProductHierarchy,
      t179.stufe as ProductHierarchyLevel,
      //      @Search.defaultSearchElement: true
      //      @Search.fuzzinessThreshold: 0.8
      //      @Search.ranking: #HIGH
      _Text
}
