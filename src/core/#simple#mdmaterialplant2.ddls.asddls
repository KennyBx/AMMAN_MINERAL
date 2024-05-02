@AbapCatalog.sqlViewName: '/SIMPLE/MDMARC2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master table for Material & Plant data2'
define view /SIMPLE/MDMATERIALPLANT2
  as select from    marc
    left outer join makt on makt.matnr = marc.matnr
    left outer join mara on mara.matnr = marc.matnr
{
  key   marc.matnr as material,
  key   marc.werks as plant,
        makt.maktx as description,
        mara.matkl as materialGroup,
        mara.meins as baseUnit,
        marc.mmsta as plantStatus,
        marc.beskz as procurementType,
        mara.mtart as materialType,
        marc.sobsl as specialProcurementType, //Ins By Danh Tran 31.05.2022
        marc.lvorm as deletionFlag
}
where
  makt.spras = $session.system_language
