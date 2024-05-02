@AbapCatalog.sqlViewName: '/SIMPLE/MDCT2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - CO-ABC Template Master Data'
define view /SIMPLE/MDCOPROCESSTEMPLATE2
  as select from /SIMPLE/MDCOPROCESSTEMPLATE
{
  key COArea      as coArea,
  key Environment as environment,
  key Template    as template,
  key Locale      as locale,
      Description as description
}
