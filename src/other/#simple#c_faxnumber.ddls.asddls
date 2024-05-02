@AbapCatalog.sqlViewName: '/SIMPLE/CADDRFN'
@AbapCatalog.preserveKey:true
@EndUserText.label: 'FaxNumber'
@Metadata.allowExtensions:true
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'AddressID'

define view /SIMPLE/C_FaxNumber
  as select from /SIMPLE/I_AddressFaxNumber as _AddressFaxNumber
  association to parent /SIMPLE/C_Address as _Address on $projection.addressID      = _Address.addressID

{
  key _Address.addressID             as addressID,
  key Person                         as person,
  key OrdinalNumber                  as ordinalNumber,
      IsDefaultFaxNumber             as isDefaultFaxNumber,
      FaxCountry                     as faxCountry,
      FaxNumber                      as faxNumber,
      FaxNumberExtension             as faxNumberExtension,
      InternationalFaxNumber         as internationalFaxNumber,
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 256 ) ) as mdgMarkForChange,
      /*Association*/
      _Address

}
