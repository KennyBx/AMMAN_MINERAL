@AbapCatalog.sqlViewName: '/SIMPLE/MDCVAL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Characteristic Values Search Help'
define view /SIMPLE/MDCHARACTERISTICVALUE
  as select from    cawn  as t1
    inner join      cabn  as t2 on  t1.atinn = t2.atinn
                                and t1.adzhl = t2.adzhl

    left outer join cawnt as t3 on  t1.atinn = t3.atinn
                                and t1.atzhl = t3.atzhl
                                and t1.adzhl = t3.adzhl


{ 
  key    cast( t1.atinn as abap.char( 10 ) )        as internalCharacteristic,
  key    t1.atzhl          as counter,
  key    t1.adzhl          as counterArchivingObject,
  key    t2.atnam          as characteristic,
  key    atwrt             as value,
  key    t3.spras          as locale,
         atwtb             as description
}//where atwrt = 'A01'
