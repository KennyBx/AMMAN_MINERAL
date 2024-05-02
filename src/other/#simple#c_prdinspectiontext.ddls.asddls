@AbapCatalog.sqlViewName: '/SIMPLE/CPRDIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductInspectionText'
define view /SIMPLE/C_PrdInspectionText 
  as select from /SIMPLE/I_ProductTextContent
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
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

      /* Associations */
      _Product,
      @Consumption.hidden: true
      clustr,
      @Consumption.hidden: true
      clustd
}
where
  LongTextID = 'PRUE'
