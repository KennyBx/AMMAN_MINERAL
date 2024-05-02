@AbapCatalog.sqlViewName: '/SIMPLE/MDADID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - AddressID'
define view /SIMPLE/MDADDRESSID
  as select from adrc
{
  key  adrc.addrnumber as addressNumber,
  key  adrc.date_from  as validFromDate,
  key  adrc.nation     as addressVersion,
       adrc.country    as country,
       adrc.region     as region,
       adrc.sort1      as searchTerm1,
       adrc.sort2      as searchTerm2,
       adrc.name1      as name,
       adrc.street     as street,
       adrc.mc_city1   as city
}
