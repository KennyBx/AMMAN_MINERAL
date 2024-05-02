@AbapCatalog.sqlViewName: '/SIMPLE/MDEXMAGR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - External Material Group'
define view /SIMPLE/MDEXTMATERIALGROUP
  as select from    twew
    left outer join twewt on twew.extwg = twewt.extwg
{
  key twew.extwg as externalMaterialGroup,
  key spras      as locale,
      ewbez      as description
}
