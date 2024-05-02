@EndUserText.label: 'View For Customer Company Code Dunning Fields'
//@Analytics.dataCategory: #DIMENSION
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/ICUSDUN'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.personalData.blocking: #REQUIRED
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_CustomerDunning
  as select from knb5
  association [1..1] to /SIMPLE/I_CustomerCompany as _CustomerCompany on $projection.Customer = _CustomerCompany.Customer
                                                              and $projection.CompanyCode = _CustomerCompany.CompanyCode
{
  key knb5.bukrs       as  CompanyCode,
  key knb5.kunnr       as  Customer,
  key knb5.maber       as  DunningArea,
      knb5.madat       as  LastDunnedOn,
      knb5.mahna       as  DunningProcedure,
      knb5.mahns       as  DunningLevel,
      knb5.mansp       as  DunningBlock,
      knb5.knrma       as  DunningRecipient,
      knb5.gmvdt       as  LegDunningProcedureOn,
      knb5.busab       as  DunningClerk,   
      /*associations*/ 
      _CustomerCompany


}  
 