@AbapCatalog.sqlViewName: '/SIMPLE/MDBLSDIS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Balance Sheet Indicator'
define view /SIMPLE/MDBALANCESHEETDISPLAY
  as select from dd07v
{
  key domvalue_l as balanceSheetDisplay,
  key ddlanguage as locale,
      ddtext     as description
}
where
  domname = 'BP_BAL_FLG'
