@AbapCatalog.sqlViewName: '/SIMPLE/MDPNAME'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Characteristics Program'
define view /SIMPLE/MDPROGRAM 
  as select distinct from tfdir
    left outer join       trdirt on tfdir.pname = trdirt.name
{
  key tfdir.pname       as programName,
  key trdirt.sprsl      as locale,
      trdirt.text       as description
}
