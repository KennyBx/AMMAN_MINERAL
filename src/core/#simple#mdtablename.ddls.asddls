@AbapCatalog.sqlViewName: '/SIMPLE/MDTNAME'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Characteristic table name'
define view /SIMPLE/MDTABLENAME
  as select distinct from dd03l
    left outer join       dd02t on dd03l.tabname = dd02t.tabname
{
  key dd03l.tabname    as tableName,
  key dd02t.ddlanguage as locale,
      dd02t.ddtext     as description
}
