@AbapCatalog.sqlViewName: '/SIMPLE/MDFLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Functional Location'
define view /SIMPLE/MDFUNCTIONALLOCATION
  as select from iflot
  //    left outer join iflos  on iflot.tplnr = iflos.tplnr //Ins by Doris - 20240111
    inner join   iflotx on iflot.tplnr = iflotx.tplnr
    inner join   iloa   on iflot.iloan = iloa.iloan
{
  key cast(iflot.tplnr as /simple/tplnr preserving type ) as functionalLocation, //Comment by Doris - 20240111
      //  key iflos.strno as functionalLocation, //Ins by Doris - 20240111
  key spras                                               as locale,
  key iflot.iloan                                         as assignmentNumber,
      iequi                                               as installationAllowed,
      iequii                                              as singleEquip,
      pltxt                                               as description,
      iflot.tplkz                                         as structureIndicator,
      fltyp                                               as category,
      cast(  tplma as char30 preserving type )            as superior,
      iwerk                                               as planningPlant,
      lgwid                                               as mainWorkCenter,
      ingrp                                               as plannerGroup,
      gsber                                               as businessArea,
      swerk                                               as maintenancePlant,
      bukrs                                               as companyCode,
      kostl                                               as costCenter
}
