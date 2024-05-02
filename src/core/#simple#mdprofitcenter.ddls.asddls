@AbapCatalog.sqlViewName: '/SIMPLE/MDPROCEN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Texts for Profit Center'
define view /SIMPLE/MDPROFITCENTER
  as select from    cepc
    left outer join cepct on  cepc.prctr = cepct.prctr
                          and cepc.datbi = cepct.datbi
                          and cepc.kokrs = cepct.kokrs
{
  key cepc.prctr  as profitCenter,
  key cepc.datbi  as validTo,
  key cepc.kokrs  as controllingArea,
  key cepct.spras as locale,
      datab       as validFrom,
      ktext       as generalName,
      ltext       as description,
      mctxt       as searchTerm
}
