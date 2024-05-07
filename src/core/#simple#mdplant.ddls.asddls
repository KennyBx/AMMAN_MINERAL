@AbapCatalog.sqlViewName: '/SIMPLE/MDPLNT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Plant'
define view /SIMPLE/MDPLANT
  as select distinct from    t001w
    inner join      wrs1 on t001w.werks = wrs1.asort
    inner join wrsz on wrs1.asort = wrsz.locnr //SSPD-3245 - 20240506 - Danh Tran - Mod
{
  key werks      as PlantID,
  key wrsz.asort as Assortment, //SSPD-3245 - 20240506 - Danh Tran - Ins
      bwkey      as ValuationArea,
      name1      as Description 
//      wrsz.asort as Assortment //SSPD-3245 - 20240506 - Danh Tran - Del
}
