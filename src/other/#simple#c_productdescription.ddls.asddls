@AbapCatalog.sqlViewName: '/SIMPLE/CPRDD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductDescription'
define view /SIMPLE/C_ProductDescription 
  //  as select from /SIMPLE/I_ProductDescription as Description
  as select from makt as Description
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key cast(Description.matnr as productnumber preserving type )      as product,
  key Description.spras                                              as language,
      cast(Description.maktx as productdescription preserving type ) as productDescription,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )                                  as action,
      cast( '' as abap.char( 999 ) )                                 as mdgMarkForChange,

      /* Associations */
      _Product
}
