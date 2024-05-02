@AbapCatalog.sqlViewName: '/SIMPLE/CPRDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductSales'
define view /SIMPLE/C_ProductSales
  as select from /SIMPLE/I_ProductSales 
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
      SalesStatus                    as salesStatus,
      SalesStatusValidityDate        as salesStatusValidityDate,
      TaxClassification              as taxClassification,
      TransportationGroup            as transportationGroup,
      @Consumption.hidden: true
      AuthorizationGroup             as authorizationGroup,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Product
}
