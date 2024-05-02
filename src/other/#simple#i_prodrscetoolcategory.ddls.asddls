@AbapCatalog.sqlViewName: '/SIMPLE/IPRTCATE'
@AbapCatalog.buffering: {status: #ACTIVE, type: #FULL, numberOfKeyFields: 000}
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'ProdnRsceToolCategory'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING }
@Metadata.ignorePropagatedAnnotations:true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Category'

define view /SIMPLE/I_ProdRsceToolCategory
  as select from tcf02

//  association [0..*] to /SIMPLE/I_PRTCategoryText as _Text on $projection.ProdnRsceToolCategory = _Text.ProdnRsceToolCategory

{
//      @ObjectModel.text.association: '_Text'
  key fhmar as ProdnRsceToolCategory

//      _Text
};
