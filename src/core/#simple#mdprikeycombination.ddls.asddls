@AbapCatalog.sqlViewName: '/SIMPLE/MDKEY'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDPRIKeyCombination'
define view /SIMPLE/MDPRIKEYCOMBINATION //Create /SIMPLE/MDPRIKEYCOMBINATIONH and /SIMPLE/MDPRIKEYCOMBINATIONI base on /SIMPLE/MDPRIKEYCOMBINATION

  as select from    t685
    join            t682i on  t682i.kozgf = t685.kozgf
                          and t682i.kvewe = t685.kvewe
                          and t682i.kappl = t685.kappl
    join            t682z on  t682z.kozgf = t682i.kozgf
                          and t682z.kolnr = t682i.kolnr
                          and t682z.kvewe = t682i.kvewe
                          and t682z.kappl = t682i.kappl
    join            t681  on  t681.kvewe   = t682i.kvewe
                          and t681.kotabnr = t682i.kotabnr
  //left outer join /SIMPLE/PRISPECI as spec on  spec.KSCHL     = t685.KSCHL
  //                                       AND spec.KOTABNR   = t682i.kotabnr
    left outer join tmc1t on tmc1t.gstru = t681.kotab
    left outer join dd03m on  dd03m.tabname    = t681.kotab
                          and dd03m.fieldname  = t682z.zifna
                          and dd03m.ddlanguage = tmc1t.spras

  //left outer join dd03m on dd03m.tabname      = t682z.qustr and dd03m.fieldname = t682z.qufna and dd03m.ddlanguage = tmc1t.spras
{

      //key cast('' as abap.char( 1333 ) )  as pricingConditionKey,
  key t685.kschl                                     as conditionType,
  key t685.kappl                                     as application, //LD-0112 - 20231109 - Danh Tran - Ins
  key cast( t682i.kotabnr as char3 preserving type ) as conditionTableNumber,
  key tmc1t.spras                                    as locale,
  key t682z.zaehk                                    as counter,
  key t682z.zifna                                    as techField,
      dd03m.ddtext                                   as fieldDescription,
      tmc1t.gstxt                                    as tableDescription
}
where
      t685.kvewe  =  'A'
  //    and t685.kappl = 'V'  //LD-0112 - 20231109 - Danh Tran - Del
  //and t682z.fstst = ''
  and t682z.zifna <> 'KFRST'
  and t682z.zifna <> 'KBSTAT'
  //and t682z.zifna <> 'MATNR'
  and t682i.kobed =  '0000000'

//and t685.kschl = 'PR00'
//and t682i.kotabnr = '304' 
group by
  t685.kschl,
  t685.kappl,    //LD-0112 - 20231109 - Danh Tran - Ins
  tmc1t.spras,
  t682i.kotabnr,
  t682z.kolnr,
  t682z.zaehk,
  t682z.zifna,
  dd03m.ddtext,
  tmc1t.gstxt
