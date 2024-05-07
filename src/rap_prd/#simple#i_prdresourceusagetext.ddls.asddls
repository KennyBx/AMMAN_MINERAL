@AbapCatalog.sqlViewName: '/SIMPLE/IPRDRUT'
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'ProductionResourceUsage'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Usage Text'

define view /SIMPLE/I_PrdResourceUsageText
  as select from tc23t as txt

  association [0..1] to /SIMPLE/I_Language                as _Language                on $projection.Language = _Language.Language
  association [0..1] to /SIMPLE/I_PrdResourceUsage        as _ProductionResourceUsage on $projection.ProductionResourceUsage = _ProductionResourceUsage.ProductionResourceUsage

{
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key txt.spras as Language,
      @ObjectModel.foreignKey.association: '_ProductionResourceUsage'
  key txt.planv as ProductionResourceUsage,

      @Semantics.text: true
      txt.txt   as ProductionResourceUsageDesc,

      _Language,
      _ProductionResourceUsage
};
