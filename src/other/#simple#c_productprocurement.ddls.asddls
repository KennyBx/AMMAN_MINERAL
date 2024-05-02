@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductProcurement'
define view /SIMPLE/C_ProductProcurement
  as select from /SIMPLE/I_Productprocurement 
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
      PurchaseOrderQuantityUnit      as purchaseOrderQuantityUnit,
      VarblPurOrdUnitStatus          as varblPurOrdUnitStatus,
      PurchasingAcknProfile          as purchasingAcknProfile,
      @Consumption.hidden: true
      AuthorizationGroup             as authorizationGroup,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Product
}
