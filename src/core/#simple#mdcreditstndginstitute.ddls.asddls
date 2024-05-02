@AbapCatalog.sqlViewName: '/SIMPLE/MDCRSTIN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4-Institute Credit Standing Infor'
define view /SIMPLE/MDCREDITSTNDGINSTITUTE
  as select from tp07 as TP07 
  left outer join tp07t as TP07T on TP07.sol_ins = TP07T.sol_ins 
{
  key TP07.sol_ins  as creditStandingInstitute,
  key TP07T.langu   as locale,
      TP07T.xsolv   as description
}
