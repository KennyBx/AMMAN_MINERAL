@AbapCatalog.sqlViewName: '/SIMPLE/MDART'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '/SIMPLE/MDARTCICLE'
define view /SIMPLE/MDARTICLE
as select from mara
    inner join maw1 on mara.matnr = maw1.matnr
    inner join t134 on mara.mtart = t134.mtart
{
  key mara.matnr as article, 
      mara.attyp as articleCategory,
      mara.matkl as materialGroup,
      t134.kkref as accountReference,
      mara.meins as baseUnitOfMeasure,
      mara.pmata as genericArticle     
}
