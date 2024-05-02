@AbapCatalog.sqlViewName: '/SIMPLE/MDPRCTRG'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Profit Center Group'
define view /SIMPLE/MDPROFITCENTERGROUP
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
// Update: Kent Nguyen 29/12/2021
//    key co.kokrs        as COArea,
//    key co.phinr        as HierarchyArea,
//    key set.setname     as ProfitCenterGroup,
//        sett.langu      as Locale,
//        sett.descript   as Description
    key co.kokrs        as coArea,
    key co.phinr        as hierarchyArea,
    key set.setname     as profitCenterGroup,
    key sett.langu      as locale,
        sett.descript   as description        
}
where set.setclass = '0106' 
and ( set.settype = 'S' or set.settype = 'B' )
and set.rollname = 'PRCTR'
