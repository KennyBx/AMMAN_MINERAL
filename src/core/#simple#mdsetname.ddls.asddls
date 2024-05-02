@AbapCatalog.sqlViewName: '/SIMPLE/MDSETNAM'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Set name'
define view /SIMPLE/MDSETNAME
  as select from    setheader
    left outer join setheadert on  setheader.setclass = setheadert.setclass
                               and setheader.subclass = setheadert.subclass
                               and setheader.setname  = setheadert.setname
{
  key setheader.subclass  as organizationalUnit,
  key setheader.setname   as setName,
  key setheadert.langu    as locale,
      setheadert.descript as description
}
where
  setheader.setclass = '0000'
