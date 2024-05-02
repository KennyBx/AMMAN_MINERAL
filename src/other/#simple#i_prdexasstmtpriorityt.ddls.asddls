@AbapCatalog.sqlViewName: '/SIMPLE/IPEASPT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View (Text) - Ext. Asstmt Priority'
@VDM.viewType: #BASIC
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.sizeCategory : #M
@ObjectModel.usageType.serviceQuality: #A
@ClientHandling.algorithm: #SESSION_VARIABLE
define view /SIMPLE/I_PrdExAsstmtPriorityT
  as select from twspt

  association [0..1] to /SIMPLE/I_PrdExAsstmtPriority as _ProdExtAssortmentPriority on $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriority.ProdExtAssortmentPriority

  association [0..1] to /SIMPLE/I_Language              as _Language                  on $projection.Language = _Language.Language

{

      @ObjectModel.foreignKey.association: '_ProdExtAssortmentPriority'
  key pflks     as ProdExtAssortmentPriority,

      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key spras     as Language,

      @Semantics.text: true
      vtext     as ProdExtAssortmentPriorityText,
      _ProdExtAssortmentPriority,
      _Language

}
