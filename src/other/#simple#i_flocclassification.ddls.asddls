@AbapCatalog.sqlViewName: '/SIMPLE/IFLOCC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Localtion Classification'
define view /SIMPLE/I_FLOCCLASSIFICATION
  as select from kssk
    inner join   klah on klah.clint = kssk.clint
{
  key kssk.mandt                  as Client,
  key cast( kssk.objek as abap.char( 90 ) ) as FunctionalLocation,
  key klah.class                  as Class,
  key kssk.klart                  as ClassType,
      kssk.statu                  as Status,
      kssk.stdcl                  as StandardClass

}
where
  kssk.klart = '003'
union select distinct from kssk
  inner join               klah on kssk.clint = klah.clint
  inner join               inob on kssk.objek = inob.cuobj
{
  key cast( inob.objek as tplnr ) as FunctionalLocation,
  key klah.class                  as Class,
  key kssk.klart                  as ClassType,
      kssk.statu                  as Status,
      kssk.stdcl                  as StandardClass
}
where
      inob.obtab =  'IFLOT'
  and kssk.klart <> '003'
