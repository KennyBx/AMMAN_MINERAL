@AbapCatalog.sqlViewName: '/SIMPLE/MDCONDTY'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Condition type'
define view /SIMPLE/MDCONDITIONTYPE
  as select from t685 as T685 
  left outer join t685t as T685T on t685.kvewe = t685t.kvewe 
                                and t685.kappl = t685t.kappl
                                and t685.kschl = t685t.kschl
{
  key t685.kvewe as conditionTypeUsage,
  key t685.kappl as application,
  key t685.kschl as conditionType,
  key t685t.spras as locale,
      t685t.vtext as description
}
