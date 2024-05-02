@EndUserText.label: 'Internal Order Type'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IIOTYPE'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.representativeKey: 'OrderType'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@AbapCatalog.buffering: {type: #GENERIC, numberOfKeyFields: 1, status: #ACTIVE}
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true


define view /SIMPLE/I_InternalOrderType
  as select from t003o
  association [0..*] to I_InternalOrderTypeText as _Text on $projection.OrderType = _Text.OrderType
{
  @ObjectModel.text.association: '_Text'
  key auart     as OrderType,
      erloese   as RevenuePostingAllowed,
      //    erloese as RevenuePostingIsAllowed,
      //    obligo as CommitmentManagementIsActive,
      _Text

};    
