@AbapCatalog.sqlViewName: '/SIMPLE/MDUOMMAT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Unit of measure Material'
define view /SIMPLE/MDUOMMATERIAL
  as select distinct from /SIMPLE/MDUOMMATERIAL1 as M

  //  left outer join marc as MARC on mara.matnr = marc.matnr
    left outer join       t006a                  as T on M.UnitOfMeasure = T.msehi
{
  key M.Material      as material,
      @EndUserText.label:'Plant'
  key M.PlantID       as plantID,
  key T.spras         as locale,
   @EndUserText.label:'Unit of Measure'
  key M.UnitOfMeasure as unitOfMeasure,
      @EndUserText.label:'Base unit'
      M.BaseUnit      as baseUnit,
      @EndUserText.label:'Unit of issue'
      M.UnitOfIssue   as unitOfIssue,
      T.msehl         as description
}
where
  T.spras = $session.system_language
