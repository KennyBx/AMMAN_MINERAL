@AbapCatalog.sqlViewName: '/SIMPLE/MDDEP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Department'
define view /SIMPLE/MDDEPARTMENT
  as select from    tsab
    left outer join tsabt on tsab.abtnr = tsabt.abtnr
{
  key tsab.abtnr as departmentID,
  key spras      as locale,
      vtext      as description
}
