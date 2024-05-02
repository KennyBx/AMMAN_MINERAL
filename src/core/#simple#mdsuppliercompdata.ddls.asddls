@AbapCatalog.sqlViewName: '/SIMPLE/MDVDCOMP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Supplie Company data'
define view /SIMPLE/MDSUPPLIERCOMPDATA
  as select from A_Supplier as VD
  association [0..*] to A_SupplierCompany as _SupplierCompany on $projection.supplier = _SupplierCompany.Supplier
{
  key    VD.Supplier                  as supplier,
  key    _SupplierCompany.CompanyCode as companyCode
}
