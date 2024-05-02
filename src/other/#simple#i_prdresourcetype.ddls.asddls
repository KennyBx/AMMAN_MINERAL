@AbapCatalog.sqlViewName: '/SIMPLE/IPRDRST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProductionResourceType'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #META }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Type'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view /SIMPLE/I_PrdResourceType
  as select from dd07l as typ
  association [0..*] to /SIMPLE/I_PrdResourceTypeText as _Text on $projection.ProductionResourceType = _Text.ProductionResourceType
{
      @ObjectModel.text.association: '_Text'
      // cast to data element
  key cast(substring(typ.domvalue_l, 1, 2) as productionresourcetype preserving type) as ProductionResourceType,

      // Associations
      _Text
}
where
      typ.domname  = 'CR_OBJTY'
  and typ.as4local = 'A';
