@AbapCatalog.sqlViewName: '/SIMPLE/MDPCG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Profit Center Group'
define view /SIMPLE/MDPCGROUP
  as select from    setheader
    left outer join sethanahier0106 on  setheader.setclass = sethanahier0106.setclass
                                    and setheader.subclass = sethanahier0106.subclass
                                    and setheader.setname  = sethanahier0106.hierbase
    left outer join setheadert      on  setheader.setclass = setheadert.setclass
                                    and setheader.subclass = setheadert.subclass
                                    and setheader.setname  = setheadert.setname
{
  key setheader.subclass as controllingArea,
  key setheader.setname as profitCenterGroup,
  key setheadert.langu as locale,
      setheadert.descript as description
}
where
      setheader.setclass       = '0106'
  and sethanahier0106.hierbase is null
