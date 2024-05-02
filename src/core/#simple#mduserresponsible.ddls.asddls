@AbapCatalog.sqlViewName: '/SIMPLE/MDUSRRPS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - User Responsible'
define view /SIMPLE/MDUSERRESPONSIBLE
  as select from usr21
{
  key bname         as userID,
      responsible   as responsible,
      techdesc      as description
}
