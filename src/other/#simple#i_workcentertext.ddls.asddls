@AbapCatalog.sqlViewName: '/SIMPLE/IWCTTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'WorkCenterInternalID'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER}
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Text'
@Analytics.dataExtraction.enabled: true

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_WorkCenterText
  as select from /SIMPLE/I_PrdResourceText as text

//  association [1..1] to /SIMPLE/I_WorkCenterType as _WorkCenterType on $projection.WorkCenterTypeCode = _WorkCenterType.WorkCenterTypeCode
//  association [1..1] to /SIMPLE/I_Language       as _Language       on $projection.Language = _Language.Language
{
      // Key
//      @ObjectModel.foreignKey.association: '_WorkCenterType'
  key text.ProductionResourceType                  as WorkCenterTypeCode,
      @ObjectModel.text.element: 'WorkCenterText'
  key text.ProductionResourceInternalID            as WorkCenterInternalID,
//      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key cast(text.Language as spras preserving type) as Language,

      // Text
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      @Semantics.text: true
      cast(text.ProductionResourceText as workcentertext preserving type) as WorkCenterText

      // Associations
//      _WorkCenterType,
//      _Language
}
  where ProductionResourceType = 'A'; // only Work Center Texts
