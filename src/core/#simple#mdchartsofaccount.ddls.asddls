@AbapCatalog.sqlViewName: '/SIMPLE/MDCHACT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Charts of Accounts'
define view /SIMPLE/MDCHARTSOFACCOUNT
  as select from t004 as T004 
  left outer join t004t as T004T on T004.ktopl = T004T.ktopl 
{
  key T004.ktopl as chartOfAccount,
  key T004T.spras as locale,
      T004T.ktplt as description
}
