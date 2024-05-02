@AbapCatalog.sqlViewName: '/SIMPLE/I_WRKCTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'WorkCenterTypeCode'
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #META}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Type'

define view /SIMPLE/I_WorkCenterType
  as select from /SIMPLE/I_PrdResourceType as typ
  association [0..*] to /SIMPLE/I_WorkCenterTypeText as _Text on $projection.WorkCenterTypeCode = _Text.WorkCenterTypeCode
{
      @ObjectModel.text.association: '_Text'
  key typ.ProductionResourceType as WorkCenterTypeCode,

      // Associations
      _Text
}
  where typ.ProductionResourceType = 'A';
