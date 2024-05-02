@AbapCatalog.sqlViewName: '/SIMPLE/MDCONGRP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Condition Group'
define view /SIMPLE/MDCONDITIONGROUP
  as select from    tvkgg
    left outer join tvkggt on tvkgg.kdkgr = tvkggt.kdkgr
{
  key tvkgg.kdkgr as conditionGroup,
  key spras       as locale,
      vtext       as description
}
