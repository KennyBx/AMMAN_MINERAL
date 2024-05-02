@AbapCatalog.sqlViewName: '/SIMPLE/MDGSHMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MDSupplierMaster'
define view /SIMPLE/MDSupplierMaster
  as select from    lfa1 as t1
    left outer join lfm1 as t2 on t1.lifnr = t2.lifnr
{
  key t1.lifnr as supplier,
  key t2.ekorg as purchasingOrg,
      land1    as country,
      name1    as name,
      name2    as name2,
      name3    as name3,
      name4    as name4,
      ktokk    as accountGroup,
      werks    as plant
}
