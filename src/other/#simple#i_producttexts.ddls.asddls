@AbapCatalog:{
  sqlViewName: '/SIMPLE/IPRDTXTS',
  compiler.compareFilter: true,
  preserveKey: true
}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Product text active entity'
define view /SIMPLE/I_Producttexts
  as select from    stxl
    left outer join prd_text on prd_text.product = '????' //this join should never satisfy the join condition. intention is to fetch an empty row with left outer join
{

  key cast( stxl.tdname as matnr )  as Product,
  key cast( stxl.tdspras as spras ) as Language,
  key stxl.tdid                     as LongTextID,
      prd_text.longtext             as LongText, //String casting is not supported. so with a dummy left outer join we bring an empty string to the longtext. this should always be empty

      cast('' as languageisocode)   as LanguageISOCode
}
where
      relid    = 'TX'
  and tdobject = 'MATERIAL'
  and srtf2    = 0
  and tdid     = 'GRUN'
  or  tdid     = 'BEST'
  or  tdid     = 'PRUE'
  or  tdid     = 'IVER'
