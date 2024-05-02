@AbapCatalog.sqlViewName: '/SIMPLE/MDSAITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Sales Document Item'
define view /SIMPLE/MDSALESDOCITEM 
  as select from vbup {
    key vbeln as salesDocument,
        posnr as item
}
