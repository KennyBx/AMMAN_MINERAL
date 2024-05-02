@AbapCatalog.sqlViewName: '/SIMPLE/MDFSTGRP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Field status groups'
define view /SIMPLE/MDFIELDSTATUSGROUP
  as select from    t004f as T004F
    left outer join t004g as T004G on  t004f.bukrs = t004g.bukrs
                                   and t004f.fstag = t004g.fstag
    left outer join t001  as T001  on t004f.bukrs = t001.fstva
{
  key t004f.bukrs as fieldStatusVariant,
  key t004f.fstag as fieldStatusGroup,
  key t001.bukrs  as companyCode,
  key t004g.spras as locale,
      t004g.fsttx as description
}
