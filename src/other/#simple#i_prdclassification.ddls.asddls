@AbapCatalog.sqlViewName: '/SIMPLE/IPRDC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Classification'
define view /SIMPLE/I_PrdClassification
  as 
  select from kssk
    inner join   klah on klah.clint = kssk.clint
{
  key cast( kssk.objek as matnr ) as Product,
  key klah.class                  as Class,
  key kssk.klart                  as ClassType,
      kssk.statu                  as Status,
      kssk.stdcl                  as StandardClass

}
where kssk.klart = '001'
union 
  select distinct from  kssk
    inner join             klah on kssk.clint = klah.clint
    inner join             inob on kssk.objek =  inob.cuobj
{
  key cast( inob.objek as matnr ) as Product,
  key klah.class                  as Class,
  key kssk.klart                  as ClassType,
      kssk.statu                  as Status,
      kssk.stdcl                  as StandardClass
}
where inob.obtab = 'MARA'
  and kssk.klart = '023'
