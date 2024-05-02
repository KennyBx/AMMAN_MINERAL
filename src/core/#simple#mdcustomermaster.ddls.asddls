@AbapCatalog.sqlViewName: '/SIMPLE/MDCUMAS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - General Data Customer Master'
define view /SIMPLE/MDCUSTOMERMASTER
  as select from kna1 as KNA1 
  left outer join knb1 as KNB1 on kna1.kunnr = knb1.kunnr
{
  key kna1.kunnr as customer,
  key knb1.bukrs as companyCode,
      kna1.sortl as searchTerm,
      kna1.land1 as country,
      kna1.pstlz as postalCode,
      kna1.mcod3 as city,
      kna1.mcod1 as name,
      kna1.begru as authorizationGroup,
      kna1.ktokd as accountGroup,
      kna1.loevm as deletionFlag,
      knb1.pernr as personnelNumber
}
