@AbapCatalog.sqlViewName: '/SIMPLE/MDSADOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Sales Document'
define view /SIMPLE/MDSALESDOCUMENT 
  as select from vbuk {
    key vbeln as salesDocument
}
