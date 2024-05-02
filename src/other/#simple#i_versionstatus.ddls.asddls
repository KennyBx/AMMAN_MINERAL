@AbapCatalog.sqlViewName: '/SIMPLE/IVERSNST'
@AbapCatalog.compiler.compareFilter: true
@ClientHandling.algorithm : #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Version Status view'
@ObjectModel.dataCategory:#TEXT
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'BOMVersionStatus'
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #CUSTOMIZING}
@Search.searchable: true
define view /SIMPLE/I_VersionStatus
  as select from dd07t
{
      
      @ObjectModel.text.element: 'BOMVersionStatusDescription'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key dd07t.domvalue_l as BOMVersionStatus,
      @Semantics.language: true
      @UI.hidden
  key dd07t.ddlanguage as Language,
      @Semantics.text: true     
      dd07t.ddtext     as BOMVersionStatusDescription
}

where
  dd07t.domname = 'CS_VERSNST'
    and dd07t.ddlanguage =  $session.system_language

  

 