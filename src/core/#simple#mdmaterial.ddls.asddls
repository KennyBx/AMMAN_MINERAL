@AbapCatalog.sqlViewName: '/SIMPLE/MDMATE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Master Data'
define view /SIMPLE/MDMATERIAL
  as select from    mara as t1
    left outer join makt as t2 on t2.matnr = t1.matnr
{
  key   t1.matnr as material,
  key   t2.spras as locale,
        t2.maktx as description,
        t1.mtart as materialType,
        t1.meins as baseUnit,
        t1.matkl as materialGroup,
        t1.attyp as materialCategory
}
