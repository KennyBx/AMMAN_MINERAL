@AbapCatalog.sqlViewName: '/SIMPLE/CFLSTUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FLocStatus'
define view /SIMPLE/C_FLOCSTATUS
  //  as select from /SIMPLE/I_IndividualObjStatus
  //{
  //  key ObjectNumber                   as objectNumber,
  //  key ObjectStatus                   as objectStatus,
  //      @ObjectModel.readOnly: true
  //      @ObjectModel.virtualElement: true
  //      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/EQUI_STATUS'
  //      cast( '' as abap.char( 4 ))    as status04,
  //      @ObjectModel.readOnly: true
  //      @ObjectModel.virtualElement: true
  //      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/EQUI_STATUS'
  //      cast( '' as abap.char( 30 ))   as status30,
  //      @ObjectModel.readOnly: true
  //      @ObjectModel.virtualElement: true
  //      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/EQUI_STATUS'
  //      cast( '' as abap.char( 1 ))    as isActive,
  //      StatusInactive                 as statusInactive,
  //      ChangeNumber                   as changeNumber,
  //      //DataAging  as  dataAging,
  //      /* SimpleMDG specific fields for integration */
  //      cast( '' as abap.char( 10 ) )  as action,
  //      cast( '' as abap.char( 999 ) ) as mdgMarkForChange
  //}

  as select from jest
    inner join   tj02t on jest.stat = tj02t.istat
    inner join   iflo  on iflo.objnr = jest.objnr
  association to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation on $projection.functionalLocation = _FunctionalLocation.functionalLocation
{
  key jest.objnr                                  as objectNumber,
  key jest.stat                                   as objectStatus,
      txt04                                       as status04,
      txt30                                       as status30,
      case when inact = 'X' then ' ' else 'X' end as isActive,
      inact                                       as statusInactive,
      chgnr                                       as changeNumber,

      cast( iflo.tplnr as /simple/tplnr preserving type )                                  as functionalLocation,
      //DataAging  as  dataAging,
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )               as action,
      cast( '' as abap.char( 999 ) )              as mdgMarkForChange,

      _FunctionalLocation
}
where
      tj02t.spras =    'E'
  and jest.objnr  like 'IF%'
