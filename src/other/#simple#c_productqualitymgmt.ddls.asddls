@AbapCatalog.sqlViewName: '/SIMPLE/CPRDQM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductQualityMgmt'
define view /SIMPLE/C_ProductQualityMgmt
  as select from /SIMPLE/I_Productqm 
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key Product                        as product,
      QltyMgmtInProcmtIsActive       as qltyMgmtInProcmtIsActive,
      @Consumption.hidden: true
      AuthorizationGroup             as authorizationGroup,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Product
}
