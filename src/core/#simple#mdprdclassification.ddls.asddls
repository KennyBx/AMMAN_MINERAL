@AbapCatalog.sqlViewName: '/SIMPLE/MDPC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDPRDCLASSIFICATION'
define view /SIMPLE/MDPRDCLASSIFICATION 
as select from kssk as t1 
    left outer join klah    as t2 on t1.clint = t2.clint
    left outer join tcla    as t3 on t2.klart = t3.klart
    left outer join m_clasa as t4 on t2.clint = t4.clint
    
{
  key     t1.objek as materialNumber,
  key     t1.klart as classType,
  key     t2.clint as internalClassNumber,
  key     t4.spras as locale,    
          t2.class as classification,
          t1.statu as status,
          t1.stdcl as standardClass,
          t1.datuv as validfrom,
          t2.klagr as slassGroup,
          t3.obtab as objectTable,
          t4.kschg as description
}
