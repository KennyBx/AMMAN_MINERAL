@AbapCatalog.sqlViewName: '/SIMPLE/MDSADO2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Sales Document2'
define view /SIMPLE/MDSALESDOCUMENT2 as select from /SIMPLE/MDSALESDOCUMENT {
    key SalesDocument as salesDocument
}
