@AbapCatalog.sqlViewName: '/SIMPLE/IPRTSTTE'
@AbapCatalog.compiler.compareFilter:true 
@AbapCatalog.preserveKey:true 
@AbapCatalog.buffering: {status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING}
@ObjectModel.representativeKey: 'ProdnRsceToolStandardTextCode'
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Standard Text'

define view /SIMPLE/I_PRTStandardText
  as select from t435
//  association [0..*] to /SIMPLE/I_PRTStandardTextText as _Text on $projection.ProdnRsceToolStandardTextCode = _Text.ProdnRsceToolStandardTextCode
{
      @ObjectModel.text.association: '_Text'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key cast(t435.vlsch as cf_ktsch preserving type) as ProdnRsceToolStandardTextCode

      // Associations
//      _Text
};
