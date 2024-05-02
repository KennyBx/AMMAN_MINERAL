@AbapCatalog.sqlViewName: '/SIMPLE/IPSTTT'
@ObjectModel.dataCategory: #TEXT
//@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@EndUserText.label: 'Cross-Plant Product Status Value Help Text'
@Search.searchable: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'Status'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #MASTER 
@ClientHandling.algorithm: #SESSION_VARIABLE 
@Metadata.ignorePropagatedAnnotations: true


define view /SIMPLE/I_ProductStatusText as 
    select from t141t
    {   key t141t.mmsta as Status, 
        @Semantics.language: true
        key spras as Language,        
        @Semantics.text: true  
        @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.8
        @Search.ranking: #HIGH
        cast(t141t.mtstb as crossplantstatustext preserving type ) as MaterialUsabilityProfileName
    }  
 