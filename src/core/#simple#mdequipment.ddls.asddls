@AbapCatalog.sqlViewName: '/SIMPLE/MDEQUIP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Equipment'
define view /SIMPLE/MDEQUIPMENT
  as select from    equi as e1
    left outer join eqkt as e2 on e1.equnr = e2.equnr
    left outer join equz as e3 on e1.equnr = e3.equnr
    left outer join iloa as e4 on e3.iloan = e4.iloan
    left outer join iflos as e5 on e4.tplnr = e5.tplnr //Insert by Doris Dang - 20242301 - PESI-60
{
  key e1.equnr as equipment,
  key e2.spras as locale,
  key e3.datbi as validTo,
  key e4.iloan as assignmentNumber,
      e4.swerk as maintenancePlant,
      e4.bukrs as companyCode,
//      e4.tplnr as functionalLocation, //Comment by Doris Dang - 20242301 - PESI-60
      e5.strno as functionalLocation, //Insert by Doris Dang - 20242301 - PESI-60
      e3.iwerk as planningPlant,
      e3.gewrk as mainWorkCenter,
      e3.ingrp as plannerGroup,
      e4.gsber as businessArea,
      e2.eqktx as description
}
