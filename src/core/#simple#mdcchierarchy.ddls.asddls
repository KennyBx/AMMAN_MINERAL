@AbapCatalog.sqlViewName: '/SIMPLE/MDCCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Hierarchy'
define view /SIMPLE/MDCCHIERARCHY
  as select from    sethanahier0101
    left outer join setheadert on  sethanahier0101.setclass = setheadert.setclass
                               and sethanahier0101.subclass = setheadert.subclass
                               and sethanahier0101.hierbase = setheadert.setname
{
  key sethanahier0101.subclass as controllingArea, //Controlling Area
  key sethanahier0101.hierbase as costCenterHierarchy, //Cost Center Hierarchy
  key setheadert.langu as language, //Language
      setheadert.descript  as locale //Description
}
where
      sethanahier0101.pred   = 0
  and sethanahier0101.hlevel = 0
