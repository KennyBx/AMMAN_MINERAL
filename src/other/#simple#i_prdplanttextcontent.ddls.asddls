@AbapCatalog.sqlViewName: '/SIMPLE/IPRDPTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Plant Long Text'
define view /SIMPLE/I_PrdPlantTextContent
  as select from    stxl
    left outer join prd_text on prd_text.product = '????'
{
  key case LENGTH(stxl.tdname)
  when 23
  then cast (substring (stxl.tdname,1,18) as matnr)
  else
  cast (substring(stxl.tdname,1,41) as matnr)
  end                                                 as Product,
  key cast ( right( stxl.tdname , 4) as productplant) as Plant,
  key cast( stxl.tdspras as spras )                   as Language,
      stxl.tdid                                       as LongTextID,
      prd_text.longtext                               as LongText,
      clustr,
      clustd
}
where
      relid    = 'TX'
  and tdobject = 'MDTXT'
  and srtf2    = 0
  and tdid     = 'LTXT'
