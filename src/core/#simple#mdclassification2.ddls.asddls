@AbapCatalog.sqlViewName: '/SIMPLE/MDCLASS2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Classification Configuration Table'
define view /SIMPLE/MDCLASSIFICATION2
  as select from /SIMPLE/MDCLASSIFICATION
{
  key internalClassNumber as internalClassNumber,
  key locale              as locale,
      classType           as classType,
      classification      as classification,
      status              as status,
      classGroup          as classGroup,
      objectTable         as objectTable,
      description         as description,
      mmClassType         as mmClassType
}
