@AbapCatalog.sqlViewName: '/SIMPLE/MDREMPPR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Repetitive Manufacturing Prof'
define view /SIMPLE/MDREMPROFILE
  as select from    t437s
    left outer join t437r on t437s.sfpro = t437r.sfpro
{
  key t437s.sfpro as remProfile,
  key spras       as locale,
      spbez       as description
}
