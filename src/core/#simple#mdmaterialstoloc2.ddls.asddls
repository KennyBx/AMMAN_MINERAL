@AbapCatalog.sqlViewName: '/SIMPLE/MDMARD2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Storage Location data2'
define view /SIMPLE/MDMATERIALSTOLOC2 as select from /SIMPLE/MDMATERIALSTOLOC {
    key Material as material,
    key Plant as plant,
    key StorageLocation as storageLocation
}
