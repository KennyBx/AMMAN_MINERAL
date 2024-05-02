@AbapCatalog.sqlViewName: '/SIMPLE/MDBPRATI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Business Partner: Rating'
define view /SIMPLE/MDBPRATING
  as select from tp06 as TP06 
  left outer join tp06t as TP06T on tp06.rating = tp06t.rating 
{
  key tp06.rating       as rating,
  key tp06t.langu       as locale,
      tp06t.xrating     as description
}
