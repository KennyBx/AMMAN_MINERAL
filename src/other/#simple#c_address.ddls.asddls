@AbapCatalog.sqlViewName: '/SIMPLE/CADDRESS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.representativeKey: 'AddressID'
@EndUserText.label: 'Address'
define view /SIMPLE/C_Address
  as select from    /SIMPLE/I_Address as _Address
    left outer join adrct             as _AddressTexts on  _AddressTexts.addrnumber = _Address.AddressID
                                                       and _AddressTexts.langu      = _Address.CorrespondenceLanguage
                                                       and _AddressTexts.nation     = _Address.Nation
  association [1..1] to /SIMPLE/I_Bank              as _Bank       on  $projection.addressID = _Bank.AddressID
  association        to parent /SIMPLE/C_BankMaster as _BankMaster on  $projection.bankCountry    = _BankMaster.bankCountry
                                                                   and $projection.bankInternalID = _BankMaster.bankInternalID
  composition [1..*] of /SIMPLE/C_FaxNumber         as _FaxNumber
  composition [1..*] of /SIMPLE/C_HomepageURL       as _HomepageURL
  composition [1..*] of /SIMPLE/C_MailAddress       as _MailAddress
  composition [1..*] of /SIMPLE/C_Phonenumber       as _Phonenumber
  composition [1..*] of /SIMPLE/C_MobiPhonenumber   as _MobiPhonenumber
{
  key _Address.AddressID             as addressID,
      _Bank.BankCountry              as bankCountry,
      _Bank.BankInternalID           as bankInternalID,
      FormOfAddress                  as formOfAddress,
      BusinessPartnerName1           as businessPartnerName1,
      BusinessPartnerName2           as businessPartnerName2,
      BusinessPartnerName3           as businessPartnerName3,
      BusinessPartnerName4           as businessPartnerName4,
      SearchTerm1                    as searchTerm1,
      SearchTerm2                    as searchTerm2,
      Building                       as building,
      Floor                          as floor,
      RoomNumber                     as roomNumber,
      CareOfName                     as careOfName,
      StreetPrefixName               as streetPrefixName,
      AdditionalStreetPrefixName     as additionalStreetPrefixName,
      _Address.StreetName            as streetName,
      HouseNumber                    as houseNumber,
      HouseNumberSupplementText      as houseNumberSupplementText,
      StreetSuffixName               as streetSuffixName,
      AdditionalStreetSuffixName     as additionalStreetSuffixName,
      District                       as district,
      CityCode                       as cityCode,
      PostalCode                     as postalCode,
      _Address.CityName              as cityName,
      Country                        as country,
      _Address.Region                as region,
      AddressTimeZone                as addressTimeZone,
      StreetAddressUndeliverableFlag as streetAddressUndeliverableFlag,
      POBox                          as poBox,
      POBoxIsWithoutNumber           as poBoxIsWithoutNumber,
      DeliveryServiceTypeCode        as deliveryServiceTypeCode,
      DeliveryServiceNumber          as deliveryServiceNumber,
      POBoxLobbyName                 as poBoxLobbyName,
      POBoxPostalCode                as poBoxPostalCode,
      POBoxDeviatingCityName         as poBoxDeviatingCityName,
      POBoxDeviatingCountry          as poBoxDeviatingCountry,
      POBoxDeviatingRegion           as poBoxDeviatingRegion,
      CompanyPostalCode              as companyPostalCode,
      POBoxAddressUndeliverableFlag  as poBoxAddressUndeliverableFlag,
      CorrespondenceLanguage         as correspondenceLanguage,
      _AddressTexts.remark           as notes,

      PrfrdCommMediumType            as prfrdCommMediumType,
      FullName                       as fullName,
      HomeCityName                   as homeCityName,
      County                         as county,
      CountyCode                     as countyCode,
      _Address.Nation                as nation,
      PhoneNumber                    as phoneNumber,
      FaxNumber                      as faxNumber,
      StreetSearch                   as streetSearch,
      CitySearch                     as citySearch,
      TaxJurisdiction                as taxJurisdiction,
      TransportZone                  as transportZone,
      RegionalStructureGrouping      as regionalStructureGrouping,
      Person                         as person,
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      /*Association*/
      _BankMaster,
      _FaxNumber,
      _HomepageURL,
      _MailAddress,
      _Phonenumber,
      _MobiPhonenumber
}
