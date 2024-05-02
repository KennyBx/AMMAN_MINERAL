@AbapCatalog.sqlViewName: '/SIMPLE/MDDPTIME'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Dispatch time'
define view /SIMPLE/MDDISPATCHTIME
  as select from dd07t as DD07T
{
  key DD07T.valpos     as valueKey,
  key DD07T.domvalue_l as dispatchTime,
  key DD07T.ddlanguage as locale,
      DD07T.ddtext     as description
}
where domname = 'NA_VSZTP' 
and   as4local = 'A'
