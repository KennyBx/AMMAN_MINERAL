@AbapCatalog.sqlViewName: '/SIMPLE/MDBCL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - BatchNumber'
define view /SIMPLE/MDBATCH
  as select from    mcha
{
  key matnr     as material,
  key werks     as plant,
  key charg     as batch
}
