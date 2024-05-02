@AbapCatalog.sqlViewName: '/SIMPLE/IBUPAIS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #NOT_REQUIRED
@EndUserText.label: 'Core View for BUT0IS'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
 
define view /SIMPLE/I_BPIndustry
  as select from but0is
  
    association [1..1] to /SIMPLE/I_BusinessPartner as _BusinessPartner    on _BusinessPartner.BusinessPartner  = $projection.BusinessPartner
  
{
  key ind_sector as IndustrySector,
  key istype     as IndustrySystemType,
  key partner    as BusinessPartner,
  isdef          as IsStandardIndustry,
  _BusinessPartner

  
}
