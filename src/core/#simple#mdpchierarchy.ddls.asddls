@AbapCatalog.sqlViewName: '/SIMPLE/MDPCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Profit Center Hierarchy'
define view /SIMPLE/MDPCHIERARCHY
  as select from    sethanahier0106
    left outer join setheadert on  sethanahier0106.setclass = setheadert.setclass
                               and sethanahier0106.subclass = setheadert.subclass
                               and sethanahier0106.hierbase = setheadert.setname
{
  key sethanahier0106.subclass as controllingArea,
  key sethanahier0106.hierbase as profitCenterHierarchy,
  key setheadert.langu as locale,
      setheadert.descript as description
}
where
      sethanahier0106.pred   = 0
  and sethanahier0106.hlevel = 0
