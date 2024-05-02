@AbapCatalog.sqlViewName: '/SIMPLE/IPRTCPFL'
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@ObjectModel.representativeKey: 'ProdnRsceToolControlProfile'
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Control Profile'

define view /SIMPLE/I_PRTControlProfile
  as select from tcf10 as prfl

//  association [0..*] to /SIMPLE/I_PRTControlPrflText as _Text on $projection.ProdnRsceToolControlProfile = _Text.ProdnRsceToolControlProfile
{
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      @ObjectModel.text.association: '_Text'
  key prfl.steuf as ProdnRsceToolControlProfile

      // Associations
//      _Text
};
