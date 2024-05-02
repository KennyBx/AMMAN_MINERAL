@AbapCatalog.sqlViewName: '/SIMPLE/MDCOSCTG'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Group'
define view /SIMPLE/MDCOSTCENTERGROUP
//  as select from setheader as H
//  left outer join setheadert as T on H.setclass = T.setclass
//                                 and H.subclass = T.subclass
//                                 and H.setname = T.setname
as select from tka01 as co 
   left outer join setheader    as set  on co.kokrs = set.subclass
   left outer join setheadert   as sett on set.setclass = sett.setclass 
                                       and set.subclass = sett.subclass  
                                       and set.setname = sett.setname 
{
    key co.kokrs        as coArea,
    key co.khinr        as standardHierarchy,
    key set.setname     as costCenterGroup,
    key sett.langu      as locale,
        sett.descript   as description
}
where set.setclass = '0101' 
and ( set.settype = 'S' or set.settype = 'B' )
and set.rollname = 'KOSTL'
