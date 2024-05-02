@AbapCatalog.sqlViewName: '/SIMPLE/MDCCG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Group'
define view /SIMPLE/MDCCGROUP
  as select from    setheader
    left outer join sethanahier0101 on  setheader.setclass = sethanahier0101.setclass
                                    and setheader.subclass = sethanahier0101.subclass
                                    and setheader.setname  = sethanahier0101.hierbase
    left outer join setheadert      on  setheader.setclass = setheadert.setclass
                                    and setheader.subclass = setheadert.subclass
                                    and setheader.setname  = setheadert.setname
{
  key setheader.subclass as controllingArea, //Controlling Area
  key setheader.setname as costCenterGroup,
  key setheadert.langu as locale,
      setheadert.descript as description
}
where
      setheader.setclass       = '0101'
  and sethanahier0101.hierbase is null
