@AbapCatalog.sqlViewName: '/SIMPLE/MDSPREAC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Vendor Reconciliation Account'
define view /SIMPLE/MDSPRECONCILIATIONACC
  as select from(
                      skb1 as t1
      left outer join t001 as t2 on t1.bukrs = t2.bukrs
  )
    left outer join   skat as t3 on  t1.saknr = t3.saknr
                                 and t2.ktopl = t3.ktopl

{
           @EndUserText.label:'Reconciliation Account'
  key      t1.saknr as reconciliationAccount,
           @EndUserText.label:'Company Code'
  key      t2.bukrs as companyCode,
           @EndUserText.label:'Language'
  key      case
          when t3.spras <> 'NULL' then  t3.spras
          when t3.spras <> '' then t3.spras
          when t3.spras <> ' ' then t3.spras
          when t3.spras <> 'null' then t3.spras
          else 'E'
        end         as locale,
           @EndUserText.label:'Description'
           txt20    as description
}
where
  mitkz = 'K'
