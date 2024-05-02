@AbapCatalog.sqlViewName: '/SIMPLE/IPRDRTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProductionResourceType'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #L, dataClass: #META }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Type Text'

define view /SIMPLE/I_PrdResourceTypeText
  as select from dd07t as txt
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
  key cast(substring(txt.domvalue_l, 1, 2) as productionresourcetype preserving type) as ProductionResourceType,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key cast(txt.ddlanguage as spras preserving type)                                   as Language,
      @Semantics.text: true
      cast(txt.ddtext as productionresourcetypename preserving type)                  as ProductionResourceTypeName,

      // Associations
      _Language
}
where
      txt.domname  = 'CR_OBJTY'
  and txt.as4local = 'A';
