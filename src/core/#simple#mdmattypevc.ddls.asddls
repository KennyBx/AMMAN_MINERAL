@AbapCatalog.sqlViewName: '/SIMPLE/MDMTEVC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Material Type link to Caluation Class'
define view /SIMPLE/MDMATTYPEVC
  as select from    t134 as t1
    left outer join t025 as t2 on t1.kkref = t2.kkref
{
  key t1.mtart as MaterialType,
  key t2.kkref as AccountCategoryReference,
  key t2.bklas as ValuationClass
}
