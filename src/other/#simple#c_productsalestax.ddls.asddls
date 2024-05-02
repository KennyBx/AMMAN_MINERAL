@AbapCatalog.sqlViewName: '/SIMPLE/CPRDST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductSalesTax'
define view /SIMPLE/C_ProductSalesTax
  as select from /SIMPLE/I_ProductSalesTax 
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key  Product                        as product,
  key  Country                        as country,
  key  TaxCategory                    as taxCategory,
       TaxClassification              as taxClassification,

       /* SimpleMDG specific fields for integration */
       cast( '' as abap.char( 10 ) )  as action,
       cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

       /* Associations */
       _Product
}
