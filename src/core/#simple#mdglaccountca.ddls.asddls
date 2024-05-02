@AbapCatalog.sqlViewName: '/SIMPLE/MDGLACCA'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - GL Account'
define view /SIMPLE/MDGLACCOUNTCA
  as select from    ska1 as ska1
    left outer join skat as skat on  ska1.ktopl = skat.ktopl
                                 and ska1.saknr = skat.saknr
{
  key ska1.ktopl as chartOfAccount,
  key ska1.saknr as glAccount,
  key skat.spras as locale,
      skat.txt50 as description
}
