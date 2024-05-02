@AbapCatalog.sqlViewName: '/SIMPLE/MDPLTS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Delivery plant links to sales org2'
define view /SIMPLE/MDDELPLANTSALESORG2 as select from /SIMPLE/MDDELPLANTSALESORG {
    key SalesOrganization as salesOrganization,
    key DistributionChannel as distributionChannel,
    key PlantID as plantID
}
