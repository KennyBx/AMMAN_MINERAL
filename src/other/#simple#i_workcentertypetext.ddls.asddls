@AbapCatalog.sqlViewName: '/SIMPLE/IWORKTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'WorkCenterTypeCode'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #META}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Type Text'

define view /SIMPLE/I_WorkCenterTypeText
  as select from /SIMPLE/I_PrdResourceTypeText as txt
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
  {
    @ObjectModel.text.element: 'WorkCenterTypeName'
    key txt.ProductionResourceType as WorkCenterTypeCode,
    @ObjectModel.foreignKey.association: '_Language'
    @Semantics.language: true
    key txt.Language as Language,
    @Semantics.text: true
    txt.ProductionResourceTypeName as WorkCenterTypeName,
    
    // Associations
    _Language
  }
  where txt.ProductionResourceType = 'A';
