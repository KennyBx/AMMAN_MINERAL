@AbapCatalog.sqlViewName: '/SIMPLE/MDBASMAT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Basic Material Field'
define view /SIMPLE/MDBASICMATERIAL
  as select from twspr as TWSPR
{
  key TWSPR.wrkst   as basicMaterial
}
