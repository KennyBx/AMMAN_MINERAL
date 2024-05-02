@AbapCatalog.sqlViewName: '/SIMPLE/MDGLACCO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - G/L account (company code)'
define view /SIMPLE/MDGLACCOUNTCOMPANYCODE
  as select from    skb1 as SKB1
    left outer join ska1 as ska1 on ska1.saknr = skb1.saknr
{
  key skb1.bukrs as companyCode,
  key skb1.saknr as glAccount,
  key ska1.ktopl as chartOfAccounts
}
