@AbapCatalog.sqlViewName: '/SIMPLE/MDPROCE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Texts for Profit Center2'
define view /SIMPLE/MDPROFITCENTER2 as select from /SIMPLE/MDPROFITCENTER {
    key ProfitCenter    as profitCenter,
    key ValidTo         as validTo,
    key ControllingArea as controllingArea,
    key Locale          as locale,
    ValidFrom           as validFrom,
    GeneralName         as generalName,
    Description         as description,
    SearchTerm          as searchTerm
}
