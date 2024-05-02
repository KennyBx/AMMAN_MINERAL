@AbapCatalog.sqlViewName: '/SIMPLE/MDCUCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MDCustomerCH'
define view /SIMPLE/MDCustomerCH 
    as select from kna1 as t1
      left outer join knvv as t2 on t1.kunnr = t2.kunnr
{
    key t1.kunnr as customer,
    key t2.vtweg as distributionChannel,
    key t2.vkorg as salesOrganization,
    key t2.spart as division,
        land1    as country,
        name1    as name1,
        sortl    as searchTerm,
        ktokd    as accountGroup
}

