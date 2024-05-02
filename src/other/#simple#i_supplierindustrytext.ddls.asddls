@AbapCatalog.sqlViewName: '/SIMPLE/ISUPINT'
@EndUserText.label: 'Supplier Industry Text'
@Analytics.dataCategory: #TEXT
@AccessControl.authorizationCheck:#NOT_REQUIRED
@ObjectModel.representativeKey: 'SupplierIndustry' 
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER


define view /SIMPLE/I_SupplierIndustryText as select from t016t {
    @Semantics.language: true
    key t016t.spras as Language,
    key t016t.brsch as SupplierIndustry,
    @Semantics.text: true
    t016t.brtxt as SupplierIndustryName
}
    
 