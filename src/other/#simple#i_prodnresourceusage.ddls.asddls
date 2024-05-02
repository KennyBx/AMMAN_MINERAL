@AbapCatalog.sqlViewName: '/SIMPLE/IPRTUSG'
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'ProductionResourceUsage'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Usage'

define view /SIMPLE/I_ProdnResourceUsage
  as select from tc23

//  association [0..*] to /SIMPLE/I_ProdnRsceUsageText as _Text on $projection.ProductionResourceUsage = _Text.ProductionResourceUsage
{
       @ObjectModel.text.association: '_Text'
       @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key  planv as ProductionResourceUsage

       // Associations
//       _Text
};
