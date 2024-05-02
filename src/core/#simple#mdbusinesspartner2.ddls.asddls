@AbapCatalog.sqlViewName: '/SIMPLE/MDBUPA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Business Partner Master Data2'
define view /SIMPLE/MDBUSINESSPARTNER2 as select from /SIMPLE/MDBUSINESSPARTNER {
    key BusinessPartner as businessPartner,
    CategoryID as categoryID,
    FirstName as firstName,
    OrganizationBPName1 as organizationBPName1,
    GroupBusinessPartnerName1 as groupBusinessPartnerName1,
    SearchTerm1 as searchTerm1,
    Customer as customer,
    Supplier as supplier
}
