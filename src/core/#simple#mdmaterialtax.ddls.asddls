@AbapCatalog.sqlViewName: '/SIMPLE/MDMATTAX'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Material Taxes'
define view /SIMPLE/MDMATERIALTAX
  as select from    tskm
    left outer join tskmt on  tskm.tatyp = tskmt.tatyp
                          and tskm.taxkm = tskmt.taxkm
{

  key tskm.tatyp as TaxCategory,
  key tskm.taxkm as TaxClassification,
  key spras      as Locale,
      vtext      as Description
}
