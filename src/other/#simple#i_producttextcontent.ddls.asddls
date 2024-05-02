@AbapCatalog.sqlViewName: '/SIMPLE/IPRDTC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '/SIMPLE/I_ProductTextContent'
define view /SIMPLE/I_ProductTextContent
  as select from    stxl
    left outer join prd_text on prd_text.product = '????'
{
  key cast( stxl.tdname as matnr )  as Product,
  key cast( stxl.tdspras as spras ) as Language,
  key stxl.tdid                     as LongTextID,
      cast('' as languageisocode)   as LanguageISOCode,
      prd_text.longtext             as LongText,
      clustr,
      clustd
}
where
       relid    = 'TX'
  and  tdobject = 'MATERIAL'
  and  srtf2    = 0
  and(
       tdid     = 'GRUN'
    or tdid     = 'BEST'
    or tdid     = 'PRUE'
  )
//  or  tdid     = 'IVER'
