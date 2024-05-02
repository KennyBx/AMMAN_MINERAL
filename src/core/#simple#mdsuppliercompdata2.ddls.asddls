@AbapCatalog.sqlViewName: '/SIMPLE/MDVDCOM2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Supplie Company data2'
define view /SIMPLE/MDSUPPLIERCOMPDATA2 as select from /SIMPLE/MDSUPPLIERCOMPDATA {
    key Supplier as supplier,
    key CompanyCode as companyCode
}
