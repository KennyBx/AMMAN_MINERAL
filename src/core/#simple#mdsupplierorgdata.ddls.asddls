@AbapCatalog.sqlViewName: '/SIMPLE/MDVDORG'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Supplie Purchasing data'
define view /SIMPLE/MDSUPPLIERORGDATA
  as select from A_Supplier as VD
  association [0..*] to A_SupplierPurchasingOrg as _SupplierPurchasingOrg on $projection.supplier = _SupplierPurchasingOrg.Supplier
{
  key    VD.Supplier                                   as supplier,
  key    _SupplierPurchasingOrg.PurchasingOrganization as purchasingOrganization
}
