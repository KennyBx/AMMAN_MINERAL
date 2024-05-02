@AbapCatalog.sqlViewName: '/SIMPLE/MDFNAME'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Characteristic field name'
define view /SIMPLE/MDFIELDNAME
  as select from    dd03l
    left outer join dd04t on dd03l.rollname = dd04t.rollname
{
  key dd03l.tabname    as tableName,
  key dd03l.fieldname  as fieldName,
  key dd04t.ddlanguage as locale,
      dd04t.ddtext     as description
}
