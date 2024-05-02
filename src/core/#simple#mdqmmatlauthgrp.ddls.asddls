@AbapCatalog.sqlViewName: '/SIMPLE/MDMAAUGP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Matl Auth Grp for Activity'
define view /SIMPLE/MDQMMATLAUTHGRP
  as select from    tq01b
    left outer join tq01c on tq01b.qmatauth = tq01c.qmatauth
{
  key tq01b.qmatauth as qmMatlAuthorizationGroup,
  key sprache        as locale,
      kzgenlos       as inspectionLot,
      kurztext       as description
}
