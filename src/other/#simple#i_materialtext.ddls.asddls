@AbapCatalog:{
  sqlViewName: '/SIMPLE/IMTRLT',
  preserveKey: true
  }
@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Text'
@ObjectModel.representativeKey: 'Material'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_MaterialText

  as select from makt
//  association [1..1] to /SIMPLE/I_Material as _Material on $projection.Material = _Material.Material
{
  key makt.matnr as Material,
      @Semantics.language: true
  key makt.spras as Language,
      @Semantics.text: true
      makt.maktx as MaterialName
//      _Material
}
