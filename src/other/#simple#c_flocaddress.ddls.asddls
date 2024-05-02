@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FLOCAddress'
define view /SIMPLE/C_FLOCAddress
  as select from    /SIMPLE/I_FLOCADDRESS as _Address
    inner join      iflo                                   on iflo.adrnr = _Address.AddressNumber
    left outer join adrct                 as _AddressTexts on  _AddressTexts.addrnumber = _Address.AddressNumber
                                                           and _AddressTexts.langu      = _Address.CorrespondenceLanguage
                                                           and _AddressTexts.nation     = _Address.Nation
  association        to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation on $projection.functionalLocation = _FunctionalLocation.functionalLocation

//  composition [1..*] of /SIMPLE/C_FaxNumber         as _FaxNumber
//  composition [1..*] of /SIMPLE/C_HomepageURL       as _HomepageURL
//  composition [1..*] of /SIMPLE/C_MailAddress       as _MailAddress
//  composition [1..*] of /SIMPLE/C_Phonenumber       as _Phonenumber
//  composition [1..*] of /SIMPLE/C_MobiPhonenumber   as _MobiPhonenumber
{
  key _Address.AddressNumber                  as addressNumber,
      cast( iflo.tplnr as /simple/tplnr preserving type ) as functionalLocation,
      _Address.DateFrom                       as dateFrom,
      _Address.AddressVersion                 as addressVersion,
      _Address.DateTo                         as dateTo,
      _Address.Title                          as title,
      _Address.Name1                          as name1,
      _Address.Name2                          as name2,
      _Address.Name3                          as name3,
      _Address.Name4                          as name4,
      _Address.ConvertedName                  as convertedName,
      _Address.BuildingCode                   as buildingCode,
      _Address.Room                           as room,
      _Address.Floor                          as floor,
      _Address.StreetCode                     as streetCode,
      _Address.StreetAbbreviation             as streetAbbreviation,
      _Address.HouseNumber                    as houseNumber,
      _Address.Supplement                     as supplement,
      _Address.HouseNumberRange               as houseNumberRange,
      _Address.Street2                        as street2,
      _Address.Street3                        as street3,
      _Address.Street4                        as street4,
      _Address.Street5                        as street5,
      _Address.PostalCode                     as postalCode,
      _Address.City                           as city,
      _Address.District                       as district,
      _Address.CityCode                       as cityCode,
      _Address.Country                        as country,
      _Address.Region                         as region,
      _Address.Time_Zone                      as time_Zone,
      _Address.POBox                          as pOBox,
      _Address.POBoxPostalCode                as pOBoxPostalCode,
      _Address.CompanyPostalCode              as companyPostalCode,
      _Address.Language                       as language,
      _Address.Telephone                      as telephone,
      _Address.TelephoneExtension             as telephoneExtension,
      _Address.Fax                            as fax,
      _Address.FaxExtension                   as faxExtension,
      _Address.TelephoneMethod                as telephoneMethod,
      _Address.FaxMethod                      as faxMethod,
      _Address.Teletex                        as teletex,
      _Address.Telex                          as telex,
      _Address.EMailMethod                    as eMailMethod,
      _Address.RMailMethod                    as rMailMethod,
      _Address.X400Method                     as x400Method,
      _Address.RFCMethod                      as rFCMethod,
      _Address.PrinterMethod                  as printerMethod,
      _Address.SSFMethod                      as sSFMethod,
      _Address.URIFTPMethod                   as uRIFTPMethod,
      _Address.PagerMethod                    as pagerMethod,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      cast( '' as abap.char( 10 ) )  as actionMode,
      cast( '' as abap.char( 20 ) )  as activateID,
      cast( '' as abap.char( 20 ) )  as activateItemID,

      /*Association*/
//      _BankMaster,
//      _FaxNumber,
//      _HomepageURL,
//      _MailAddress,
//      _Phonenumber,
//      _MobiPhonenumber,
        _FunctionalLocation
}
