@AbapCatalog.sqlViewName: '/SIMPLE/ICAPTEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'CapacityInternalID'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #MASTER}
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Capacity Text'

define view /SIMPLE/I_CapacityText
  as select from kakt as kakt
    association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
      @ObjectModel.text.element: 'CapacityText'
  key kakt.kapid as CapacityInternalID,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key kakt.spras as Language,

      // Text
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
      @Semantics.text: true
      kakt.ktext as CapacityText,

      // Associations
      _Language
};
