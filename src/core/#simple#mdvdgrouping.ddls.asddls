@AbapCatalog.sqlViewName: '/SIMPLE/MDVDGRP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Vendor Grouping'
define view /SIMPLE/MDVDGROUPING
  as select from    tbc001 as t1
    left outer join tb002  as t2 on t1.bu_group = t2.bu_group
{
  key    t1.bu_group as grouping,
  key    t1.ktokk    as accountGroup,
  key    spras       as locale,
         txt40       as description
}
