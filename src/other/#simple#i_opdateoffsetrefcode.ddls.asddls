@AbapCatalog.sqlViewName: '/SIMPLE/IODREFCD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true 
@AbapCatalog.buffering: {status: #ACTIVE, type: #FULL, numberOfKeyFields: 000}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true 
@ObjectModel.representativeKey: 'OperationDateOffsetRefCode'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING }
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Operation Date Offset Reference Code'

define view /SIMPLE/I_OpDateOffsetRefCode
  as select from tca54
//  association [0..*] to /SIMPLE/I_OpDateOffstRefCodeTe as _Text on $projection.OperationDateOffsetRefCode = _Text.OperationDateOffsetRefCode
{
      @ObjectModel.text.association: '_Text'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key bzoff as OperationDateOffsetRefCode

      // Associations
//      _Text
};
