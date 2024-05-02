@AbapCatalog.sqlViewName: '/SIMPLE/CLASS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Classification Configuration Table'
define view /SIMPLE/MDCLASSIFICATION
  as select from    klah as t1
    left outer join tcla as t2 on t1.klart = t2.klart
    left outer join swor as t3 on t1.clint = t3.clint
  //    left outer join m_clasa as t3 on t1.clint = t3.clint
{
  key     t1.clint as internalClassNumber,
  key     t3.spras as locale,
  key     t3.klpos as itemNumber,
          t1.klart as classType,
          t1.class as classification,
          t1.statu as status,
          t1.klagr as classGroup,
          t2.obtab as objectTable,
          t3.kschg as description,
          t1.wwskz as mmClassType
}
