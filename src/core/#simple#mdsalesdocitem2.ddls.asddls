@AbapCatalog.sqlViewName: '/SIMPLE/MDSAITE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Sales Document Item2'
define view /SIMPLE/MDSALESDOCITEM2 as select from /SIMPLE/MDSALESDOCITEM {
    key SalesDocument as salesDocument,
    Item as item
}
