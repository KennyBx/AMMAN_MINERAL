@AbapCatalog.sqlViewName: '/SIMPLE/IPDRSTE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Text'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_PrdResourceText
  as select from crtx as crtx
  
  association [1..1] to /SIMPLE/I_PrdResourceType        as _ProductionResourceType on $projection.ProductionResourceType = _ProductionResourceType.ProductionResourceType
  association [1..1] to /SIMPLE/I_Language               as _Language               on $projection.Language = _Language.Language
{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key cast(crtx.objty as productionresourcetype preserving type)  as ProductionResourceType,
  key crtx.objid                                                  as ProductionResourceInternalID,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key cast(crtx.spras as spras preserving type)                   as Language,

      // Text
      @Semantics.text: true
      cast (crtx.ktext as productionresourcetext preserving type) as ProductionResourceText,

      // Associations
      _ProductionResourceType,
      _Language
}; 
