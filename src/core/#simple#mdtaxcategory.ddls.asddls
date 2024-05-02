@AbapCatalog.sqlViewName: '/SIMPLE/MDTAXCAT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Tax Category'
define view /SIMPLE/MDTAXCATEGORY
  as select from    t007a as T007A
    left outer join t007s as T007S on  t007a.kalsm = t007s.kalsm
                                   and t007a.mwskz = t007s.mwskz
    join            t005  as t5    on t5.kalsm = t007a.kalsm
    join            t001  as t1    on t5.land1 = t1.land1
{
  key t007a.kalsm as procedureID,
  key t007a.mwskz as taxCode,
  key t007s.spras as locale,
      t1.bukrs    as companyCode,
      t007s.text1 as description
}
where
      t007a.xinact <> 'X'
  and t007s.spras  = $session.system_language
