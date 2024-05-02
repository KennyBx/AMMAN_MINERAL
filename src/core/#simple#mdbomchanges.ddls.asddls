@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMCHS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master'
define view /SIMPLE/MDBOMCHANGES
  as select distinct from /SIMPLE/I_BOMChangeForChangeNo as _bomchanges
    inner join            mast                           as mast on  stlan = _bomchanges.BillOfMaterialVariantUsage
                                                                 and stlnr = _bomchanges.BillOfMaterial
                                                                 and stlal = _bomchanges.BillOfMaterialVariant
{
  key BillOfMaterial             as billOfMaterial,
  key BillOfMaterialCategory     as billOfMaterialCategory,
  key BillOfMaterialVariant      as billOfMaterialVariant,
  key BillOfMaterialVariantUsage as billOfMaterialVariantUsage,
  key EngineeringChangeDocument  as engineeringChangeDocument,
      mast.matnr                 as material,
      mast.werks                 as plant,
      ValidFromDate              as validityStartDate
}
