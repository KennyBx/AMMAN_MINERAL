@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'Region'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@AbapCatalog.sqlViewName: '/SIMPLE/IREGION'
@AbapCatalog.preserveKey:true 
@EndUserText.label: 'Region'
@Analytics : {dataCategory: #DIMENSION, dataExtraction.enabled : true}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations:true

define view /SIMPLE/I_Region
  as select from t005s
//  association [0..*] to /SIMPLE/I_RegionText as _RegionText on  $projection.Region  = _RegionText.Region
//                                                    and $projection.Country = _RegionText.Country
//  association [1..1] to /SIMPLE/I_Country    as _Country    on  $projection.Country = _Country.Country
{
      @ObjectModel.foreignKey.association: '_Country'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key t005s.land1 as Country,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.text.association: '_RegionText'
  key t005s.bland as Region,
  
  t005s.fprcd as ProvincialTaxCode

//      _RegionText,
//      _Country
}   
  
  
  
  
  
  
  
  
 