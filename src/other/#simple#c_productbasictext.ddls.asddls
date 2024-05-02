@AbapCatalog.sqlViewName: '/SIMPLE/CPRDBT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductBasicText'
define view /SIMPLE/C_ProductBasicText 
  as select from /SIMPLE/I_ProductTextContent
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
  key Language                       as language,
      //      @Consumption.hidden: true
      //      LongTextID,

//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDLONGTEXT'
      LongText                       as longText,

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
  LongTextID = 'GRUN'
