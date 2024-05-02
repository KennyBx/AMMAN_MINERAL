@AbapCatalog.sqlViewName: '/SIMPLE/CPRDSTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductSalesText'
define view /SIMPLE/C_ProductSalesText
  as select from /SIMPLE/I_PrdSalesTextContent 
  association to parent /SIMPLE/C_ProductSalesDelivery as _SalesDelivery on  $projection.product                 = _SalesDelivery.product
                                                                         and $projection.productSalesOrg         = _SalesDelivery.productSalesOrg
                                                                         and $projection.productDistributionChnl = _SalesDelivery.productDistributionChnl
{

  key Product                        as product,
  key ProductSalesOrg                as productSalesOrg,
  key ProductDistributionChnl        as productDistributionChnl,
  key Language                       as language,
      //LongTextID,

//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDLONGTEXT'
      LongText                       as longText,
      //LanguageISOCode,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /*Association*/
      _SalesDelivery,
      @Consumption.hidden: true
      clustr,
      @Consumption.hidden: true
      clustd
}
