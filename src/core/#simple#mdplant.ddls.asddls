@AbapCatalog.sqlViewName: '/SIMPLE/MDPLNT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Plant'
define view /SIMPLE/MDPLANT
  as select from    t001w
    inner join      wrs1 on t001w.werks = wrs1.asort
    left outer join wrsz on wrs1.asort = wrsz.locnr
{
  key werks      as PlantID,
      bwkey      as ValuationArea,
      name1      as Description,
      wrsz.asort as Assortment
}
