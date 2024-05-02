@AbapCatalog.sqlViewName: '/SIMPLE/MDWCCAPC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Work Center Capacity'
define view /SIMPLE/MDWCCAPACITY
  as select from    kako
    left outer join kakt on kako.kapid = kakt.kapid
{
  key kako.kapid as capacityID,
  key kakt.spras as locale,
      kako.werks as plantID,
      kako.poolk as isPooledCapacity,
      kako.name  as pooledCapacityName,
      kakt.ktext as description
}
