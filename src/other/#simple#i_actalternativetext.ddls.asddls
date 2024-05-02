@AbapCatalog.sqlViewName: '/SIMPLE/IACTALTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.buffering: {status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'CostCenterActivityAltvDescID'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING}
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Activity Alternative Text'

define view /SIMPLE/I_ActAlternativeText
  as select from tcrcot as txt
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
      @ObjectModel.text.element: 'CostCenterActivityAltvDesc'
  key cast(txt.actxk as pph_actxk preserving type)   as CostCenterActivityAltvDescID,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key cast(txt.spras as spras preserving type)       as Language,
      @Semantics.text: true
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      cast(txt.actxkt as pph_actxkt preserving type) as CostCenterActivityAltvDesc,

      // Associations
      _Language
};
