@AbapCatalog.sqlViewName: '/SIMPLE/IPRTGRP'
@AbapCatalog.buffering: {status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001}
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProductionResourceToolGroup'
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING}
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Group'

define view /SIMPLE/I_ProdnRsceToolGroup
  as select from tcf12

//  association [0..*] to /SIMPLE/I_PRTGroupText as _Text on $projection.ProductionResourceToolGroup = _Text.ProductionResourceToolGroup
{
      @ObjectModel.text.association: '_Text'
  key fgrua as ProductionResourceToolGroup

      // Associations
//      _Text
};
