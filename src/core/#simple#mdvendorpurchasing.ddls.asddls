@AbapCatalog.sqlViewName: '/SIMPLE/MDVDPC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - Vendor Purchasing'
define view /SIMPLE/MDVENDORPURCHASING
  as select from    lfm1
    left outer join lfa1 on lfa1.lifnr = lfm1.lifnr
{
  key lfm1.lifnr as vendor,
  key lfm1.ekorg as purchasingOrg,
      lfm1.zterm as paytTerms,
      lfm1.inco2 as incotermsPart2,
      lfm1.inco1 as incotermsPart1,
      lfm1.telf1 as telephone,
      lfm1.verkf as salesPerson,
      lfm1.waers as orderCurrency,
      lfa1.name1 as vendorName
}
