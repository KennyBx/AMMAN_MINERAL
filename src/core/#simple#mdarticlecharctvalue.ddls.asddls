@AbapCatalog.sqlViewName: '/SIMPLE/MDACL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/SIMPLE/MDARTICLECHARCTVALUE'
define view /SIMPLE/MDARTICLECHARCTVALUE
  as select from    cawn  as t1
    inner join      cabn  as t2 on  t1.atinn = t2.atinn
                                and t1.adzhl = t2.adzhl

    left outer join cawnt as t3 on  t1.atinn = t3.atinn
                                and t1.atzhl = t3.atzhl
                                and t1.adzhl = t3.adzhl


{
  key    cast( t1.atinn as abap.char( 10 ) ) as internalCharacteristic,
  key    t1.atzhl                            as counter,
  key    t1.adzhl                            as counterArchivingObject,
  key    t2.atnam                            as characteristic,
  key    t3.spras                            as locale,
         @ObjectModel.virtualElement: true
         @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_HANDLEVALUE_CHARC'
         t1.atwrt                            as value,
         t2.msehi                            as unitOfMeasure,
         t3.atwtb                            as description
}
