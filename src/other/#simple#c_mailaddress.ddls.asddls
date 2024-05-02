@AbapCatalog.sqlViewName: '/SIMPLE/CADDREA'
@AbapCatalog.preserveKey:true
@EndUserText.label: 'MailAddress'
@Metadata.allowExtensions:true
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'AddressID'

define view /SIMPLE/C_MailAddress
  as select from /SIMPLE/I_AddressEmailAddress
  association to parent /SIMPLE/C_Address as _Address on $projection.addressID      = _Address.addressID
{
  key  AddressID                      as addressID,
  key  Person                         as person,
  key  OrdinalNumber                  as ordinalNumber, 
       IsDefaultEmailAddress          as isDefaultEmailAddress,
       cast( EmailAddress as abap.char( 241 ) )                   as emailAddress,
       SearchEmailAddress             as searchEmailAddress,
       /* SimpleMDG specific fields for integration */
       cast( '' as abap.char( 10 ) )  as action,
       cast( '' as abap.char( 256 ) ) as mdgMarkForChange,
       /*Association*/
       _Address

}
