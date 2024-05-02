@AbapCatalog.sqlViewName: '/SIMPLE/MDCOTPLT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - CO-ABC Template Master Data'
define view /SIMPLE/MDCOPROCESSTEMPLATE
  as select from cotpl as COTPL 
  left outer join cotplt as COTPLT on cotpl.kokrs = cotplt.kokrs 
                                  and cotpl.class = cotplt.class
                                  and cotpl.template = cotplt.template
{
  key cotpl.kokrs       as coArea,
  key cotpl.class       as environment,
  key cotpl.template    as template,
  key cotplt.langu      as locale,
      cotplt.text       as description
}
