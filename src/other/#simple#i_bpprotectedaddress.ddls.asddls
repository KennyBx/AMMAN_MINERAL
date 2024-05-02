@AbapCatalog.sqlViewName: '/SIMPLE/IBPPRADD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #COMPOSITE
@EndUserText.label: 'Business Partner Protected Addresses'
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.personalData.blocking: #REQUIRED

define view /SIMPLE/I_BPProtectedAddress
  as select from P_BPProtectedAddrUsageCount
{
  key BusinessPartner,
  key AddressID,
  case
    when BPProtectedAddrUsageCount > 0
      then cast('E' as bu_protected)
    else
      cast(' ' as bu_protected)
  end as BPAddressIsProtected
}
