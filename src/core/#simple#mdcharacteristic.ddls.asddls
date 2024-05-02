@AbapCatalog.sqlViewName: '/SIMPLE/CHARACT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Characteristic Configuration Table'
define view /SIMPLE/MDCHARACTERISTIC
  as select from    ksml  as t0
    left outer join cabn  as t1 on t0.imerk = t1.atinn
    left outer join cabnt as t2 on t0.imerk = t2.atinn
    left outer join klah  as t3 on t0.clint = t3.clint
{
  key    cast( t1.atinn as abap.char( 10 ) )        as internalCharacteristic,
 // key   t1.atinn    as internalCharacteristic,
  key   t1.adzhl    as internalCounter,
  key   t1.atnam    as characteristic,
  key   t0.clint    as internalClassification,
  key   t3.class    as classification,
  key   t2.spras    as locale,
        t2.atbez    as description

}
