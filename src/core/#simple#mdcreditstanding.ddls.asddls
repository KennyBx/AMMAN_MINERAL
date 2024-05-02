@AbapCatalog.sqlViewName: '/SIMPLE/MDCREDST'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Credit Standing'
define view /SIMPLE/MDCREDITSTANDING
  as select from dd07t as DD07T
{
  key dd07t.valpos     as valueKey,
  key dd07t.domvalue_l as creditStanding,
  key dd07t.ddlanguage as locale,
      dd07t.ddtext     as description
}
where domname = 'BP_SOLVNCY' 
and   as4local = 'A'
    
