@AbapCatalog.sqlViewName: '/SIMPLE/IPEASP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View - Ext. Assortment Priority'
@VDM.viewType: #BASIC
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #M
@ObjectModel.representativeKey: 'ProdExtAssortmentPriority'
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_PrdExAsstmtPriority
  as select from twsp

  association [0..*] to /SIMPLE/I_PrdExAsstmtPriorityT as _Text on $projection.ProdExtAssortmentPriority = _Text.ProdExtAssortmentPriority

{
      @ObjectModel.text.association: '_Text'
  key twsp.pflks as ProdExtAssortmentPriority,

      _Text
}
