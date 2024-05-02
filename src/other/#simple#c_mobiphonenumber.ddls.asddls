@AbapCatalog.sqlViewName: '/SIMPLE/CADDRMPN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MobiPhonenumber'
define view /SIMPLE/C_MobiPhonenumber
  as select from /SIMPLE/I_AddressPhoneNumber
  association to parent /SIMPLE/C_Address as _Address on $projection.addressID = _Address.addressID
{
  key AddressID                      as addressID,
  key Person                         as person,
  key OrdinalNumber                  as ordinalNumber,
      DestinationLocationCountry     as destinationLocationCountry,
      IsDefaultPhoneNumber           as isDefaultPhoneNumber,
      PhoneNumber                    as phoneNumber,
      PhoneNumberExtension           as phoneNumberExtension,
      InternationalPhoneNumber       as internationalPhoneNumber,
      PhoneNumberType                as phoneNumberType,
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 256 ) ) as mdgMarkForChange,
      /*Association*/
      _Address
}
where
  PhoneNumberType = '3'
