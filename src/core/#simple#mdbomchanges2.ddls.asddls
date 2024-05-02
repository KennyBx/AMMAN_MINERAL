@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMCH2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master2'
define view /SIMPLE/MDBOMCHANGES2 as select from /SIMPLE/MDBOMCHANGES {
    key BillOfMaterial              as billOfMaterial,
    key BillOfMaterialCategory      as billOfMaterialCategory,
    key BillOfMaterialVariant       as billOfMaterialVariant,
    key BillOfMaterialVariantUsage  as billOfMaterialVariantUsage,
    key EngineeringChangeDocument   as engineeringChangeDocument,
    Material as material,
    Plant as plant,
    ValidityStartDate as validityStartDate
}
