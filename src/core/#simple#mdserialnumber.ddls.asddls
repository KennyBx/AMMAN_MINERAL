@AbapCatalog.sqlViewName: '/SIMPLE/MDSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Serial Number'
define view /SIMPLE/MDSERIALNUMBER
  as select from eqse
{
  key eqsnr  as numbr,
      matnr  as material,
      sernr  as serialNumber,
      equnr  as equipment,
      status as status,
      werk   as plant,
      lager  as storageLocation,
      charge as batch
}
