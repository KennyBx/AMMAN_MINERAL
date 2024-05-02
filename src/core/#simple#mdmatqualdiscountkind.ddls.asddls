@AbapCatalog.sqlViewName: '/SIMPLE/MDMAQADI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material qualifies for discount in kind'
define view /SIMPLE/MDMATQUALDISCOUNTKIND
  as select from dd07v
{
  key domvalue_l as matQualDiscKind,
  key ddlanguage as locale,
      ddtext     as description
}
