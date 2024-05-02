@AbapCatalog.sqlViewName: '/SIMPLE/IWORKCR'
@AbapCatalog.buffering: {status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001}
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@AccessControl.personalData.blocking: #REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'WorkCenterResponsible'
@ObjectModel.semanticKey: ['Plant', 'WorkCenterResponsible']
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING}
@Search.searchable: true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Work Center Responsible'

define view /SIMPLE/I_WCResponsible
  as select from tc24 as tc24

  association [1..1] to /SIMPLE/I_Plant as _Plant on $projection.Plant = _Plant.Plant
{
      // Key
      @ObjectModel.foreignKey.association: '_Plant'
  key tc24.werks                                        as Plant,
      @ObjectModel.text.element: 'WorkCenterResponsibleName'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key cast(tc24.veran as ap_veran preserving type)      as WorkCenterResponsible,

      // Name
      @Semantics.text: true
      cast(tc24.ktext as pph_veranname preserving type) as WorkCenterResponsibleName,

      // Associations
      _Plant
};
