@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCEQU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FLOCEquipment'
define view /SIMPLE/C_FLOCEQUIPMENT
  as select from /SIMPLE/I_FLOCEQUIPMENT
  association to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation on $projection.functionalLocation = _FunctionalLocation.functionalLocation
{
  key Equipment                      as equipment,
  key ValidTo                        as validTo,
  key UsgePerConsecNum               as usgePerConsecNum,
  key FunctionalLocation             as functionalLocation,
      NxtUsagePeriodNum              as nxtUsagePeriodNum,
      Time                           as time,
      LocAcctAssignment              as locAcctAssignment,
      Description                    as description,

      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      cast( '' as abap.char( 10 ) )  as actionMode,
      cast( '' as abap.char( 20 ) )  as activateID,
      cast( '' as abap.char( 20 ) )  as activateItemID,

      /*Association*/
      _FunctionalLocation
}
