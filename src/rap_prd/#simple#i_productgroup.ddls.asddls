@AbapCatalog:{
  sqlViewName: '/SIMPLE/IPRDGRP',
  preserveKey: true
}
@Analytics: { dataCategory: #DIMENSION }
@EndUserText.label: 'Product Group Value Help'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@VDM.lifecycle.status: #DEPRECATED
@VDM.lifecycle.successor: 'I_ProductGroup_2'
@ObjectModel.representativeKey: 'MaterialGroup'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductGroup
  as select from t023

  association [0..*] to /SIMPLE/I_ProductGroupText as _Text on $projection.MaterialGroup = _Text.MaterialGroup
{
      @ObjectModel.text.association: '_Text'

      @Search: {
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8,
        ranking: #HIGH
      }
  key cast(t023.matkl as productgroup preserving type ) as MaterialGroup,
      @UI.hidden: true
      t023.begru                                        as AuthorizationGroup,


      _Text
}
