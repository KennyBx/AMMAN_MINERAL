@AbapCatalog.sqlViewName: '/SIMPLE/MDPUINRE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for PurchInfo Record'
define view /SIMPLE/MDPURCHINFOREC
  as select from m_meinl
{
  key infnr as infoRecord,
  key lifnr as vendor,
  key ltsnr as ssr,
  key idnlf as suppMat,
  key matnr as material,
  key matkl as materialGroup,
  key esokz as cat,
  key ekorg as pOrg,
  key werks as plant
}
