@AbapCatalog.sqlViewName: '/SIMPLE/MDMRKL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - RT Material Link'
define view /SIMPLE/MDRTMATERIALLINK
  as select from mapl
    left outer join plko on mapl.plnty = plko.plnty
                      and mapl.plnnr = plko.plnnr
                      and mapl.plnal = plko.plnal
{
  key mapl.matnr as material,
  key mapl.werks as plant,
  key mapl.plnty as taskListType,
  key mapl.plnnr as taskListGroup,
  key mapl.plnal as groupCounter,
      mapl.datuv as validFrom,
      mapl.aennr as changeNumber,
      mapl.vbeln as salesDoc,
      mapl.posnr as salesDocItem,
      cast( mapl.pspnr as /simple/ps_posnr  preserving type ) as wbsElement,
      case plko.loekz
           when 'X' then 'X'
           else ( case mapl.loekz when 'X' then 'X' else ' ' end ) end as deleted
//      plko.loekz as deleted

}
