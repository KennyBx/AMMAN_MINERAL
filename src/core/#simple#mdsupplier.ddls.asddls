@AbapCatalog.sqlViewName: '/SIMPLE/MDVD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Supplier Master Data'
define view /SIMPLE/MDSUPPLIER
  as select from A_Supplier        as VD
    inner join   A_BusinessPartner as BP    on BP.Supplier = VD.Supplier
    inner join   lfm1              as VDOrg on VD.Supplier = VDOrg.lifnr
{
  key    VD.Supplier        as supplier,
         /*associations*/
         SupplierName       as supplierName,
         BP.BusinessPartner as businessPartner,
         VDOrg.ekorg        as purchasingOrganization
}
