@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'PurchasingGroup'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #S
@AbapCatalog.sqlViewName: '/SIMPLE/IPURGRP'
@AbapCatalog.preserveKey:true 
@EndUserText.label: 'Purchasing Group'
@Analytics.dataCategory: #DIMENSION
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true        
@Metadata.allowExtensions:true
define view /SIMPLE/I_PurchasingGroup 

as select from t024 

{
    @ObjectModel.text.element : 'PurchasingGroupName'
    
    @Consumption.labelElement: 'PurchasingGroupName'  
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.75  
    key t024.ekgrp as PurchasingGroup,
    
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.75
    cast(t024.eknam as mm_a_purg_grp_name preserving type ) as PurchasingGroupName,
    
    t024.ektel as PurchasingGroupPhoneNumber,
    
    t024.telfx as FaxNumber,
    
    t024.tel_number as PhoneNumber,
    
    t024.tel_extens as PhoneNumberExtension,
    
    t024.smtp_addr as EmailAddress

}
              
 