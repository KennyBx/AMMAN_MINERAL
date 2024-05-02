@AbapCatalog.sqlViewName: '/SIMPLE/MDPV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG]F4 - Production Version Master Data'
define view /SIMPLE/MDPRODUCTIONVERSION
  as select from mkal
{
  key matnr as materialNumber,
  key werks as plant,
  key verid as productionVersionId,
      text1 as text,
      adatu as validFrom,
      bdatu as validTo,
      bstmi as lotSizeFrom,
      bstma as lotSizeTo
}
