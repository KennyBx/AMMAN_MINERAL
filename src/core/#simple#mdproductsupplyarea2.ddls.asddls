@AbapCatalog.sqlViewName: '/SIMPLE/MDPSUPA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Production Supply Area2'
define view /SIMPLE/MDPRODUCTSUPPLYAREA2 as select from /SIMPLE/MDPRODUCTSUPPLYAREA {
    key PlantID as plantID,
    key SupplyArea as supplyArea,
    key Locale as locale,
    Description as description
}
