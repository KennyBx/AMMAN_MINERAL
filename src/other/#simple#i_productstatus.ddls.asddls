@AbapCatalog.sqlViewName: '/SIMPLE/IPSTT'
//@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@EndUserText.label: 'Value Help For Cross-Plant Product Status'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@ObjectModel.representativeKey: 'Status'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER
//@ObjectModel.resultSet.sizeCategory: #XS
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductStatus
  as select from t141
  association [0..*] to /SIMPLE/I_ProductStatusText as _Text on $projection.Status = _Text.Status
{
      @ObjectModel.text.association: '_Text'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key cast(t141.mmsta as profilecode) as Status,
      //      @Search.defaultSearchElement: true
      //      @Search.fuzzinessThreshold: 0.8
      //      @Search.ranking: #HIGH
      _Text
}
