@AbapCatalog.sqlViewName: '/SIMPLE/MDCM2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - General Data Customer Master'
define view /SIMPLE/MDCUSTOMERMASTER2
  as select from /SIMPLE/MDCUSTOMERMASTER
{
  key Customer           as customer,
  key CompanyCode        as companyCode,
      SearchTerm         as searchTerm,
      Country            as country,
      PostalCode         as postalCode,
      City               as city,
      Name               as name,
      AuthorizationGroup as authorizationGroup,
      AccountGroup       as accountGroup,
      DeletionFlag       as deletionFlag,
      PersonnelNumber    as personnelNumber
}
