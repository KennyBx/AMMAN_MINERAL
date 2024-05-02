@AbapCatalog.sqlViewName: '/SIMPLE/MDBUPA'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Business Partner Master Data'
define view /SIMPLE/MDBUSINESSPARTNER
  as select from A_BusinessPartner as t1
  //    left outer join acustomer        as t2 on t1.customer = t2.customer
  //    left outer join acustsalesarea   as t3 on t1.customer = t3.customer
  //    left outer join tvko             as t8 on t3.salesorganization = t8.vkorg
  //    left outer join asupplier        as t5 on t1.supplier = t5.supplier
  //    left outer join asupplpurch      as t6 on t1.supplier = t6.supplier
  //    left outer join t024e            as t9 on t6.purchasingorganization = t9.ekorg
{
  key  t1.BusinessPartner        as businessPartner,
       BusinessPartnerCategory   as categoryID,
       FirstName                 as firstName,
       OrganizationBPName1       as organizationBPName1,
       GroupBusinessPartnerName1 as groupBusinessPartnerName1,
       SearchTerm1               as searchTerm1,
       Customer                  as customer,
       Supplier                  as supplier
       //  key  t1.customer                as  Customer,
       //  key  t1.supplier                as  Supplier,
       //  key  t3.salesorganization       as  SalesOrganization,
       //  key  t3.distributionchannel     as  DistributionChannel,
       //  key  t3.division                as  Division,
       //  key  t6.purchasingorganization  as  PurchasingOrganization,
       //  key  t8.bukrs                   as  CustomerCompanyCode,
       //  key  t9.bukrs                   as  SupplierCompanyCode,
       //       t1.academictitle           as  AcademicTitle,
       //       t1.authorizationgroup      as  AuthorizationGroup,
       //       t1.businesspartnercategory as  BusinessPartnerCategory,
       //       t1.businesspartnerfullname as  Description,
       //       t1.businesspartnergrouping as  Grouping
}

//union select from abusinesspartner as t1
//  left outer join acustcompany     as t4 on t1.customer = t4.customer
//  left outer join asuppcompany     as t7 on t1.supplier = t7.supplier
//{
//  key  t1.businesspartner                    as  BusinessPartner,
//  key  t1.customer                           as  Customer,
//  key  t1.supplier                           as  Supplier,
//       ''                                    as  SalesOrganization,
//       ''                                    as  DistributionChannel,
//       ''                                    as  Division,
//       ''                                    as  PurchasingOrganization,
//       t4.companycode                        as  CustomerCompanyCode,
//       t7.companycode                        as  SupplierCompanyCode,
//       t1.academictitle                      as  AcademicTitle,
//       t1.authorizationgroup                 as  AuthorizationGroup,
//       t1.businesspartnercategory            as  BusinessPartnerCategory,
//       t1.businesspartnerfullname            as  Description,
//       t1.businesspartnergrouping            as  Grouping
//}
