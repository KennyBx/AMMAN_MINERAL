@AbapCatalog.sqlViewName: '/SIMPLE/IPRDCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Characteristic'
define view /SIMPLE/I_PrdCharacteristic
  as select distinct from kssk
    inner join            klah on  kssk.clint = klah.clint
                               and kssk.klart = klah.klart

    left outer join       ksml on klah.clint = ksml.clint

    left outer join       ausp on  kssk.objek = ausp.objek
                               and kssk.mafid = ausp.mafid
                               and kssk.klart = ausp.klart
                               and ksml.imerk = ausp.atinn

    left outer join       cabn on ksml.imerk = cabn.atinn

{
  key cast( kssk.objek as matnr ) as Product,
  key cabn.atnam                  as Charc,
  key ausp.atzhl                  as Counter,
  key ksml.posnr                  as CharcItem,
      ausp.atwrt                  as CharcValue,
      klah.class                  as Class,
      kssk.klart                  as ClassType,
      ksml.imerk                  as Characteristc,

      cabn.attab                  as TableName,
      cabn.atfel                  as FieldName
}
where kssk.klart <> '023'
union select distinct from kssk
  inner join               ngc_clhier_idx on kssk.clint = ngc_clhier_idx.node
  inner join               klah           on  ngc_clhier_idx.ancestor = klah.clint
                                          and ngc_clhier_idx.klart    = klah.klart
  inner join               inob           on kssk.objek = inob.cuobj
  inner join               ksml           on klah.clint = ksml.clint
  inner join               ausp           on  inob.cuobj = ausp.objek
                                          and kssk.mafid = ausp.mafid
                                          and kssk.klart = ausp.klart
                                          and ksml.imerk = ausp.atinn

  left outer join          cabn           on ksml.imerk = cabn.atinn
{
  key cast( inob.objek as matnr ) as Product,
  key cabn.atnam                  as Charc,
  key ausp.atzhl                  as Counter,
  key ksml.posnr                  as CharcItem,
      ausp.atwrt                  as CharcValue,      
      klah.class                  as Class,
      kssk.klart                  as ClassType,
      ksml.imerk                  as Characteristc,
      cabn.attab                  as TableName,
      cabn.atfel                  as FieldName
}
where inob.obtab = 'MARA'
//  as select distinct from kssk
//    inner join            ausp on  kssk.objek = ausp.objek
//                               and kssk.mafid = ausp.mafid
//                               and kssk.klart = ausp.klart
//    inner join            ksml on  kssk.clint = ksml.clint
//                               and ksml.imerk = ausp.atinn
//    inner join            cabn on  ausp.atinn = cabn.atinn
//                               and ausp.adzhl = cabn.adzhl
//    inner join            klah on ksml.clint = klah.clint
//{
//  key cast( ausp.objek as matnr ) as Product,
//  key cabn.atnam                  as Charc,
//  key ausp.atzhl                  as Counter,
//      ausp.atwrt                  as CharcValue,
//      klah.class                  as Class,
//      kssk.klart                  as ClassType
//
//}
