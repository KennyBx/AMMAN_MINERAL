@AbapCatalog.sqlViewName: '/SIMPLE/MDMAQAD2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material qualifies for discount in kind2'
define view /SIMPLE/MDMATQUALDISCOUNTKIND2 as select from /SIMPLE/MDMATQUALDISCOUNTKIND {
    key MatQualDiscKind as matQualDiscKind,
    key Locale as locale,
    Description as description
}
