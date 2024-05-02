@AbapCatalog.sqlViewName: '/SIMPLE/MDFUNC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Characteristics Template'
define view /SIMPLE/MDFUNCTION
  as select from tfdir
    left outer join tftit on tfdir.funcname = tftit.funcname
{
  key tftit.spras       as locale,
  key tfdir.funcname    as functionModule,
      tfdir.pname       as programName,   
      tftit.stext       as description
}
