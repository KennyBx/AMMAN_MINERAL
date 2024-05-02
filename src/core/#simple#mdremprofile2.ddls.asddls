@AbapCatalog.sqlViewName: '/SIMPLE/MDREMPP2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Repetitive Manufacturing Prof2'
define view /SIMPLE/MDREMPROFILE2 as select from /SIMPLE/MDREMPROFILE {
    key REMProfile as remProfile,
    key Locale as locale,
    Description as description
}
