@AbapCatalog.sqlViewName: '/SIMPLE/IBPADDR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'Business Partner Address'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BusPartAddress as select from but020 as BusinessPartnerAddress

association[1..1] to /SIMPLE/I_BusinessPartner as _BusinessPartner on $projection.BusinessPartner = _BusinessPartner.BusinessPartner

association [0..1] to /SIMPLE/I_BPProtectedAddress as _BPProtectedAddress on $projection.BusinessPartner = _BPProtectedAddress.BusinessPartner
                                                                   and $projection.AddressID = _BPProtectedAddress.AddressID  
  
{

  key BusinessPartnerAddress.partner                                   as BusinessPartner,
  key BusinessPartnerAddress.addrnumber                                as AddressID,
      BusinessPartnerAddress.address_guid                              as AddressUUID,
      BusinessPartnerAddress.addr_valid_from                           as ValidityStartDate,
      BusinessPartnerAddress.addr_valid_to                             as ValidityEndDate,
      BusinessPartnerAddress.adext                                     as AddressIDByExternalSystem, // added in 1802

      _BusinessPartner.AuthorizationGroup,
      _BusinessPartner.IsBusinessPurposeCompleted,
      _BPProtectedAddress,
      _BusinessPartner
    
}
