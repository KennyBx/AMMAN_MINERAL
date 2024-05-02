@AbapCatalog.sqlViewName: '/SIMPLE/CADDRHPU'
@EndUserText.label: 'HomepageURL'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #A
@AbapCatalog.preserveKey: true

define view /SIMPLE/C_HomepageURL
  as select from /SIMPLE/I_AddressHomepageURL
  association to parent /SIMPLE/C_Address as _Address on $projection.addressID      = _Address.addressID
{
  key AddressID                      as addressID,
  key Person                         as person,
  key OrdinalNumber                  as ordinalNumber,
  key ValidityStartDate              as validityStartDate,
  key IsDefaultURLAddress            as isDefaultURLAddress,
      SearchURLAddress               as searchURLAddress,



      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 256 ) ) as mdgMarkForChange,
      /*Association*/
      _Address,
      
      URLFieldLength                 as urlFieldLength,
      WebsiteURL                     as websiteURL

}
