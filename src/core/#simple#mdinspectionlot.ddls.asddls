@AbapCatalog.sqlViewName: '/SIMPLE/MDISPLOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - INSPECTION LOT'
define view /SIMPLE/MDINSPECTIONLOT
  as select from qals
{
  key prueflos as inspectionLot,
      werk     as plant,
      art      as inspectionType,
      herkunft as inspectionLotOrigin
}
