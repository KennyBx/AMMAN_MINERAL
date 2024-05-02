@AbapCatalog.sqlViewName: '/SIMPLE/IPRDSTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Sales Long Text'
define view /SIMPLE/I_PrdSalesTextContent
  as select from    stxl
    left outer join prd_text on prd_text.product = '????'
{
  key case LENGTH(stxl.tdname)
    when 23
    then cast (substring (stxl.tdname,1,18) as productnumber)
    else
    cast (substring(stxl.tdname,1,41) as productnumber)
    end                                             as Product,
  key case length(stxl.tdname)
   when 23
   then cast (substring (stxl.tdname, 18, 21) as productsalesorganization)
   else
   cast (substring(stxl.tdname,41, 44 ) as  productsalesorganization)
   end                                              as ProductSalesOrg,
  key case length(stxl.tdname)
     when 23
     then cast (substring (stxl.tdname, 22, 23) as productdistributionchannel)
     else
     cast (substring(stxl.tdname,45,46 ) as  productdistributionchannel)
     end                                            as ProductDistributionChnl,


  key cast( stxl.tdspras as spras preserving type ) as Language,
      stxl.tdid                                     as LongTextID,
      prd_text.longtext                             as LongText,
      clustr,
      clustd
}
where
      relid    = 'TX'
  and tdobject = 'MVKE'
  and srtf2    = 0
  and tdid     = '0001'
