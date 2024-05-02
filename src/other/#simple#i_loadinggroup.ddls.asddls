@ClientHandling.algorithm: #SESSION_VARIABLE //Inserted by VDM CDS Suite Plugin
@ObjectModel.representativeKey: 'LoadingGroup'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
//Commented by VDM CDS Suite Plugin:@ObjectModel.representativeKey: 'LoadingGroup'
@EndUserText.label: 'Loading Group'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API 
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/ILDGRP'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations:true
@Metadata.allowExtensions: true

define view /SIMPLE/I_LoadingGroup
as select from tlgr

association [0..*] to /SIMPLE/I_LoadingGroupText as _Text on $projection.LoadingGroup = _Text.LoadingGroup
{
    @Search.defaultSearchElement: true
    @ObjectModel.text.association: '_Text'
    key ladgr as LoadingGroup,
    _Text
};  
