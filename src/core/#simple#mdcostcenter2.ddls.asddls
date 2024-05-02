@AbapCatalog.sqlViewName: '/SIMPLE/MDCOSTC2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Cost Center Master Record2'
define view /SIMPLE/MDCOSTCENTER2 as select from /SIMPLE/MDCOSTCENTER {
    key COArea as coArea,
    key CostCenter as costCenter,
    key ValidTo as validTo,
    key Locale as locale,
    ValidFrom as validFrom,
    CompanyCode as companyCode,
    CostCenterCategory as costCenterCategory,
    PersonResponsible as personResponsible,
    UserResponsible as userResponsible,
    Description as description
}
