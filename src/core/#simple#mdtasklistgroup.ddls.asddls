@AbapCatalog.sqlViewName: '/SIMPLE/MDTLTYPE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Task List Group'
define view /SIMPLE/MDTASKLISTGROUP
  as select from    plko as header
    left outer join mapl as material            on  material.plnty = header.plnty
                                                and material.plnnr = header.plnnr
                                                and material.plnal = header.plnal
    left outer join eapl as equipment           on  equipment.plnty = header.plnty
                                                and equipment.plnnr = header.plnnr
                                                and equipment.plnal = header.plnal
    left outer join tapl as functionalloccation on  functionalloccation.plnty = header.plnty
                                                and functionalloccation.plnnr = header.plnnr
                                                and functionalloccation.plnal = header.plnal
{
  key header.plnty                                      as taskListType,
  key header.plnnr                                      as keyTaskListGroup,
  key header.plnal                                      as groupCounter,
      header.werks                                      as plant,
      material.matnr                                    as material,
      equipment.equnr                                   as equipment,
      cast( functionalloccation.tplnr as abap.char(40) ) as functionalLocation,
      header.strat                                      as strategy,
      header.datuv                                      as validFromDate,
      header.ktext                                      as description
}
