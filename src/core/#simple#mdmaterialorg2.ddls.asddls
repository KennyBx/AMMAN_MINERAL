@AbapCatalog.sqlViewName: '/SIMPLE/MDMVKE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Sales Org Data2'
define view /SIMPLE/MDMATERIALORG2 as select from /SIMPLE/MDMATERIALORG {
    key Material as   material,
    key SalesOrganization as   salesOrganization,
    key DistributionChannel as   distributionChannel
}
