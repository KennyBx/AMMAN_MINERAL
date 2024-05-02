@AbapCatalog.sqlViewName: '/SIMPLE/MDCOSTCE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Master Record'
define view /SIMPLE/MDCOSTCENTER
  as select distinct from csks as c
    left outer join       cskt as t on  c.kokrs = t.kokrs
                                    and c.kostl = t.kostl
                                    and c.datbi = t.datbi
{
  key c.kokrs      as coArea,
  key c.kostl      as costCenter,
  key c.datbi      as validTo,
  key t.spras      as locale,
      c.datab      as validFrom,
      c.bukrs      as companyCode,
      c.kosar      as costCenterCategory,
      c.verak      as personResponsible,
      c.verak_user as userResponsible,
      t.ltext      as description
}
