@AbapCatalog.sqlViewName: '/SIMPLE/IFLOCCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Location Characteristic'
define view /SIMPLE/I_FLOCCHARACTERISTIC
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
  key cast( kssk.objek as abap.char( 90 ) ) as FunctionalLocation,
  key cabn.atnam                  as Charc,
  key ausp.atzhl                  as Counter,
  key ksml.posnr                  as CharcItem,
      ausp.atwrt                  as CharcValue,
      klah.class                  as Class,
      kssk.klart                  as ClassType,
      cast ( ksml.imerk as /simple/atinn preserving type )                  as Characteristc,

      cabn.attab                  as TableName,
      cabn.atfel                  as FieldName,

      cabn.atfor                  as CharcType,
      kssk.clint                  as clint,
      kssk.objek                  as objek,
      kssk.stdcl                  as stdcl,
      kssk.statu                  as statu
}
where
  kssk.klart = '003'
